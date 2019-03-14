#include <iostream>
#include <glm/ext.hpp>
#include <climits>
#include <random>

#include "Ray.hpp"

using namespace std;

using namespace glm;

vec3 Ray::genBG() {
	vec3 color(0.0f);
    color.z = ((float)y / 256.0f);
    int random = rand() % 100;
    if (random < 2) {
        color = vec3(1.0f, 1.0f, 1.0f);
    }
	return color;
}

const int Ray::MAX_HITS = 2;

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

GeometryNode *Ray::hit_hier(SceneNode * root, float &t, glm::vec3 &N) {
    float t_min = INT_MAX;
    GeometryNode *hit_object = nullptr;

    mat4 new_matrix(matrix_stack.top());
	new_matrix = new_matrix * root->trans;

	if (root->m_nodeType == NodeType::JointNode) {
		JointNode *jointNode = static_cast<JointNode *>(root);
		mat4 id(1.0f);
		float degree = jointNode->m_joint_x.init;
		new_matrix = glm::rotate(new_matrix, radians(degree), vec3(1, 0, 0));
	}

	matrix_stack.push(new_matrix);

	if (root->m_nodeType == NodeType::GeometryNode) {
		GeometryNode *geometryNode = static_cast<GeometryNode *>(root);
        geometryNode->m_primitive->curr_transform = new_matrix;
        float t_curr;
        vec3 N_curr;
        if (geometryNode->m_primitive->beHitBy(orig, dir, t_curr, N_curr) && t_curr < t_min) {
            hit_object = geometryNode;
            t_min = t_curr;
            t = t_min;
            N = N_curr;
        }
	}

	for (auto child : root->children) {
        float t_curr;
        vec3 N_curr;
        GeometryNode *hit_object_curr = hit_hier(child, t_curr, N_curr);
		if (hit_object_curr != nullptr && t_curr < t_min) {
            hit_object = hit_object_curr;
            t_min = t_curr;
            t = t_min;
            N = N_curr;
        }
	}

	matrix_stack.pop();

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

    GeometryNode *hit_object = hit_hier(root, t, N);
    if (hit_object != nullptr) {
        PhongMaterial *phongMaterial = static_cast<PhongMaterial *>(hit_object->m_material);
        kd = phongMaterial->m_kd;
        ks = phongMaterial->m_ks;
        color = kd * ambient;
        p = pointAt(t);
        
        for (auto light : lights) {
            // shadow
            Ray reverse_light = Ray(p + N * BIAS, glm::normalize(light->position - p), x, y);
            vec3 N_reverse;
            float t_reverse;
            if (reverse_light.hit_hier(root, t_reverse, N_reverse) != nullptr) {
                continue;
            }

            vec3 color_intermediate;
            vec3 light_dir = light->position - p;
            light_dir = glm::normalize(light_dir);
            Ray reflected = ggReflection(p, light_dir, N, x, y);
            if (kd.length() != 0) {
                color_intermediate += kd * light->directLight(p, N);
            }
            if (ks.length() != 0 && maxHits < MAX_HITS) {
                //color_intermediate += ks * reflected.getColor(root, lights, ambient, maxHits + 1);
                color_intermediate += ks * light->specularLight(dir, reflected.dir, phongMaterial->m_shininess);
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