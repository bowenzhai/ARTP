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

Ray *Ray::ggRefract(const vec3 &p, const vec3 &dir, const vec3 &N, float ior, int x, int y) {
    vec3 N_temp = N;
    float v_dot_N = glm::dot(dir, N);
    float n_i = 1.0f;
    float n_T = ior;
    if (v_dot_N < 0) {
        // outside the surface
        //v_dot_N = -v_dot_N;
    } else {
        // reverse normal direction
        //N_temp = -1 * N;
        // swap refraction indices
        std::swap(n_i, n_T);
        // update v dot N
        //v_dot_N = glm::dot(dir, N_temp);
        v_dot_N = -v_dot_N;
    }
    float index_ratio = n_i / n_T;
    float neg_test = 1 - pow(index_ratio, 2) * (1 - pow(v_dot_N, 2));
    if (neg_test < 0) {
        return nullptr;
    } else {
        vec3 new_dir = glm::normalize((-1 * index_ratio * v_dot_N - sqrt(neg_test)) * N_temp + index_ratio * dir);
        return new Ray(p, new_dir, x, y);
    }
}


Ray Ray::perturb(const vec3 &p, const vec3 &dir, const vec3 &N) {
    vec3 rotationAxis = glm::cross(dir, N);
    float cosTheta = glm::dot(dir, N);
    float s = sqrt( (1+cosTheta)*2 );
	float invs = 1 / s;

    cout << glm::to_string(dir) << endl;
    cout << glm::to_string(N) << endl;

    cout << rotationAxis.x * invs  << endl;
    cout << rotationAxis.y * invs  << endl;
    cout << rotationAxis.z * invs  << endl;
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
            cout << "";
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
    // debug a pixel
    // if (x == 10 && y == 6) {
    //     cout << "for debug" << endl;
    // }
    GeometryNode *hit_object = hit(root, t, N);
    // if (x == 10 && y == 6) {
    //     cout << glm::to_string(N) << endl;
    // }
    if (hit_object != nullptr) {
        MaterialType type = hit_object->m_material->m_materialType;
        PhongMaterial *phongMaterial;
        ReflectiveMaterial *reflectiveMaterial;
        RefractiveMaterial *refractiveMaterial;

        if (type == MaterialType::PhongMaterial) {
            phongMaterial = static_cast<PhongMaterial *>(hit_object->m_material);
            kd = phongMaterial->m_kd;
            ks = phongMaterial->m_ks;
        } else if (type == MaterialType::ReflectiveMaterial) {
            reflectiveMaterial = static_cast<ReflectiveMaterial *>(hit_object->m_material);
            kd = reflectiveMaterial->m_kd;
        } else if (type == MaterialType::RefractiveMaterial) {
            refractiveMaterial = static_cast<RefractiveMaterial *>(hit_object->m_material);
            kd = refractiveMaterial->m_kd;
        }
        
        color = kd * ambient;
        p = pointAt(t);
        
        for (auto light : lights) {
            vec3 N_reverse;
            float t_reverse;
            vec3 color_intermediate;
            float light_ratio = 1.0f;
            //shadow
            if (light->lightType == LightType::AreaLight) {
                AreaLight *areaLight = static_cast<AreaLight *>(light);
                int not_hit = areaLight->numsamples;
                list <Light *> samplePoints = areaLight->getSamplePoints();
                for (auto sample : samplePoints) {
                    //cout << glm::to_string(sample->position) << endl;

                    Ray reverse_sample = Ray(p + N * BIAS, glm::normalize(sample->position - p), x, y);
                
                    if (reverse_sample.hit(root, t_reverse, N_reverse) != nullptr && t_reverse < glm::length(sample->position - p)) {
                        --not_hit;
                    }
                }
                light_ratio = (float)not_hit / (float)areaLight->numsamples;
                if (light_ratio != 1 && light_ratio != 0) {
                    //cout << endl;
                }
            } else {
                Ray reverse_light = Ray(p + N * BIAS, glm::normalize(light->position - p), x, y);
                
                if (reverse_light.hit(root, t_reverse, N_reverse) != nullptr && t_reverse < glm::length(light->position - p)) {
                    // // reflective
                    // if (type == MaterialType::ReflectiveMaterial && maxHits < MAX_HITS) {
                    //     Ray view_reflected = ggReflection(p  + N * BIAS, dir, N, x, y);
                    //     color_intermediate += reflectiveMaterial->m_reflectiveness * view_reflected.getColor(root, lights, ambient, maxHits + 1);
                    // } else {
                    //     continue;
                    // }
                    continue;
                }
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
                Ray view_reflected = ggReflection(p + N * BIAS, dir, N, x, y);
                vec3 reflected_normally_color = reflectiveMaterial->m_reflectiveness * view_reflected.getColor(root, lights, ambient, maxHits + 1);
/*
                Ray view_reflected_perturbed = perturb(view_reflected.orig, view_reflected.dir, N);
                vec3 reflected_perturbed_color = reflectiveMaterial->m_reflectiveness * view_reflected_perturbed.getColor(root, lights, ambient, maxHits + 1);
                color_intermediate += (1.0f - reflectiveMaterial->m_glossiness) * reflected_normally_color + (reflectiveMaterial->m_glossiness) * reflected_perturbed_color;
*/
                color_intermediate += (1.0f - reflectiveMaterial->m_glossiness) * reflected_normally_color;

            }

            // refractive
            if (type == MaterialType::RefractiveMaterial && maxHits < MAX_HITS) {
                bool outside = glm::dot(dir, N) < 0;
                Ray *view_refracted;
                if (outside) {
                    view_refracted = ggRefract(p - N * BIAS, dir, N, refractiveMaterial->m_ior, x, y);
                } else {
                    view_refracted = ggRefract(p + 2 * N * BIAS, dir, N, refractiveMaterial->m_ior, x, y);
                }
                if (view_refracted != nullptr) {
                    color_intermediate = 0.1 * color_intermediate + 0.8 * view_refracted->getColor(root, lights, ambient, maxHits + 1);
                }
                delete view_refracted;
            }

            color_intermediate *= light_ratio;
            color_intermediate /= light->falloff[0] + light->falloff[1] + light->falloff[2];
            color += color_intermediate;
        } 
    } else {
        color = genBG();
    }

    // if (x == 10 && y == 6) {
    //     cout << glm::to_string(color) << endl;
    // }

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