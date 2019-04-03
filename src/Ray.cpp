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
        //color = vec3(1.0f, 1.0f, 1.0f);
    }
	return color;
}

const int Ray::MAX_HITS = 3;

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

vec3 Ray::perturb(const vec3 &N, float factor) {
    random_device rd; 
    mt19937_64 rng(rd());
    uniform_real_distribution<float> unif(0.0f, 1.0f);
    float x1 = unif(rng);
    float x2 = unif(rng);
    vec4 n4(N, 1.0f);
    float alpha = pow(acos(1 - x1), 0.5);
    float beta = 2 * M_PI * x2;
    n4 = glm::rotate(n4, radians(alpha) * (factor * 10.f), vec3(0, 1, 0));
    n4 = glm::rotate(n4, radians(beta) * (factor * 10.0f), vec3(0, 0, 1));
    return glm::normalize(vec3(n4));
}

GeometryNode *Ray::hit(SceneNode * root, float &t, vec3 &N, float &u, float &v)  {
    float t_min = INT_MAX;
    GeometryNode *hit_object = nullptr;

    for (auto child : root->children) {
        if (child->m_nodeType == NodeType::GeometryNode) {
            GeometryNode *geometryNode = static_cast<GeometryNode *>(child);
            float t_curr;
            vec3 N_curr;
            if (geometryNode->m_primitive->beHitBy(orig, dir, t_curr, N_curr, u, v) && t_curr < t_min) {
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
    vec3 color(0.0f);
    vec3 kd;
	vec3 ks;
	vec3 ke;
	vec3 N;
	vec3 p;
	float t;
    float u;
    float v;
    // debug a pixel
    // if (x == 10 && y == 6) {
    //     cout << "for debug" << endl;
    // }
    GeometryNode *hit_object = hit(root, t, N, u, v);
    // if (x == 10 && y == 6) {
    //     cout << glm::to_string(N) << endl;
    // }
    if (hit_object != nullptr) {
        MaterialType type = hit_object->m_material->m_materialType;
        PhongMaterial *phongMaterial;
        ReflectiveMaterial *reflectiveMaterial;
        RefractiveMaterial *refractiveMaterial;
        TexturedMaterial *texturedMaterial;

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
        } else if (type == MaterialType::TexturedMaterial) {
            texturedMaterial = static_cast<TexturedMaterial *>(hit_object->m_material);
            // cursed
            //u = u * 3 - (int)u;
            //v = v * 3 - (int)v;
            float u_tile = fmod(u * texturedMaterial->m_tile.x, 1);
            float v_tile = fmod(v * texturedMaterial->m_tile.y, 1);
            kd = texturedMaterial->getMaterialColor(u_tile, v_tile);
        }
        
        color = kd * ambient;
        p = pointAt(t);
        
        for (auto light : lights) {
            vec3 N_reverse;
            float t_reverse;
            float u_reverse;
            float v_reverse;
            vec3 color_intermediate;
            float light_ratio = 1.0f;
            //shadow
            if (light->lightType == LightType::AreaLight) {
                AreaLight *areaLight = static_cast<AreaLight *>(light);
                int not_hit = areaLight->numsamples;
                list <Light *> samplePoints = areaLight->getSamplePoints();
                for (auto sample : samplePoints) {
                    Ray reverse_sample = Ray(p + N * BIAS, glm::normalize(sample->position - p), x, y);
                
                    if (reverse_sample.hit(root, t_reverse, N_reverse, u_reverse, v_reverse) != nullptr && t_reverse < glm::length(sample->position - p)) {
                        --not_hit;
                    }
                }
                light_ratio = (float)not_hit / (float)areaLight->numsamples;
            } else {
                bool outside = glm::dot(dir, N) < 0;
                Ray reverse_light = Ray(p + N * BIAS, glm::normalize(light->position - p), x, y);
                GeometryNode *reverse_hit = reverse_light.hit(root, t_reverse, N_reverse, u_reverse, v_reverse);
                if (reverse_hit != nullptr && t_reverse < glm::length(light->position - p)) {
                    if (type == MaterialType::RefractiveMaterial && reverse_hit == hit_object) {

                    } else {
                        continue;
                    }
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
                if (reflectiveMaterial->m_glossiness != 0) {
                    vec3 N_perturbed = perturb(N, reflectiveMaterial->m_glossiness);
                    Ray view_reflected_perturbed = ggReflection(p + N_perturbed * BIAS, dir, N_perturbed, x, y);
                    vec3 reflected_perturbed_color = reflectiveMaterial->m_reflectiveness * view_reflected_perturbed.getColor(root, lights, ambient, maxHits + 1);
                    color_intermediate += reflected_perturbed_color;
                } else {
                    Ray view_reflected = ggReflection(p + N * BIAS, dir, N, x, y);
                    vec3 reflected_normally_color = reflectiveMaterial->m_reflectiveness * view_reflected.getColor(root, lights, ambient, maxHits + 1);
                    color_intermediate += reflected_normally_color;
                }
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
                    if (refractiveMaterial->m_glossiness != 0) {
                        vec3 dir_perturbed = perturb(view_refracted->dir, refractiveMaterial->m_glossiness);
                        view_refracted->dir = dir_perturbed;
                    }
                    vec3 refracted_color = view_refracted->getColor(root, lights, ambient, maxHits + 1);
                    color_intermediate = 0.1 * color_intermediate + 0.3 * refracted_color;
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