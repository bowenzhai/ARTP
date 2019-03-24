#include <iostream>
#include <glm/ext.hpp>
#include <climits>
#include <random>

#include "Ray.hpp"

using namespace std;

using namespace glm;

vec3 Ray::genBG() {
	vec3 color(0.0f);
    color.z = ((float)y / (float)512);
    int random = rand() % 100;
    if (random < 1) {
        color = vec3(1.0f, 1.0f, 1.0f);
    }
	return color;
}

const int Ray::MAX_HITS = 4;

const float Ray::BIAS = 1e-2;

Ray Ray::ggReflection(const vec3 &p, const vec3 &dir, const vec3 &N, int x, int y) {
    vec3 new_dir = glm::normalize(dir - 2 * N * (glm::dot(dir, N)));
    return Ray(p, new_dir, x, y);
}

GeometryNode *Ray::hit(SceneNode * root, float &t, vec3 &N)  {
    float t_min = INT_MAX;
    GeometryNode *hit_object = nullptr;

    for (auto child : root->children) {
        if (child->m_nodeType == NodeType::GeometryNode) {
            GeometryNode *geometryNode = static_cast<GeometryNode *>(child);
            float t_curr;
            vec3 N_curr;
            if (geometryNode->m_primitive->beHitBy(orig, dir, t_curr, N_curr) && t_curr < t_min) {
                hit_object = geometryNode;
                t_min = t_curr;
                t = t_min;
                N = N_curr;
            }
        }
    }

    return hit_object;
}    

vec3 Ray::getColor(SceneNode * root, list<Light *> lights, vec3 & ambient, int maxHits) {
    vec3 color;
    vec3 kd;
	vec3 ks;
	vec3 ke;
	vec3 N;
	vec3 p;
	float t;
    GeometryNode *hit_object = hit(root, t, N);
    if (hit_object != nullptr) {
        MaterialType type = hit_object->m_material->m_materialType;
        PhongMaterial *phongMaterial;
        ReflectiveMaterial *reflectiveMaterial;

        if (type == MaterialType::PhongMaterial) {
            phongMaterial = static_cast<PhongMaterial *>(hit_object->m_material);
            kd = phongMaterial->m_kd;
            ks = phongMaterial->m_ks;
        } else if (type == MaterialType::ReflectiveMaterial) {
            reflectiveMaterial = static_cast<ReflectiveMaterial *>(hit_object->m_material);
            kd = reflectiveMaterial->m_kd;
        }
        
        color = kd * ambient;
        p = pointAt(t);
        
        for (auto light : lights) {
            //shadow
            Ray reverse_light = Ray(p + N * BIAS, glm::normalize(light->position - p), x, y);
            vec3 N_reverse;
            float t_reverse;
            vec3 color_intermediate;
            if (reverse_light.hit(root, t_reverse, N_reverse) != nullptr) {
                // // reflective
                // if (type == MaterialType::ReflectiveMaterial && maxHits < MAX_HITS) {
                //     Ray view_reflected = ggReflection(p  + N * BIAS, dir, N, x, y);
                //     color_intermediate += reflectiveMaterial->m_reflectiveness * view_reflected.getColor(root, lights, ambient, maxHits + 1);
                // } else {
                //     continue;
                // }
                continue;
            }

            vec3 light_dir = light->position - p;
            light_dir = glm::normalize(light_dir);
            // diffuse
            color_intermediate += kd * light->directLight(p, N);

            // specular
            if (type == MaterialType::PhongMaterial) {
                Ray light_reflected = ggReflection(p, light_dir, N, x, y);
                color_intermediate += ks * light->specularLight(dir, light_reflected.dir, phongMaterial->m_shininess);
            }

            // reflective
            if (type == MaterialType::ReflectiveMaterial && maxHits < MAX_HITS) {
                Ray view_reflected = ggReflection(p  + N * BIAS, dir, N, x, y);
                color_intermediate += reflectiveMaterial->m_reflectiveness * view_reflected.getColor(root, lights, ambient, maxHits + 1);
            }

            color_intermediate /= light->falloff[0] + light->falloff[1] + light->falloff[2];
            color += color_intermediate;
        } 
    } else {
        color = genBG();
    }

    return color;
}


std::ostream& operator<<(std::ostream& out, const Ray& ray)
{
    out << "ray {";
    out << glm::to_string(ray.orig);
    out << glm::to_string(ray.dir);
    out << "}";
    return out;
}

vec3 Ray::pointAt(float t) {
    return orig + t * dir;
}