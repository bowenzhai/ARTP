// Winter 2019

#include <utility>
#include <iostream>
#include <glm/ext.hpp>
#include <list>

#include "Primitive.hpp"
#include "polyroots.hpp"

using namespace std;

using namespace glm;

Primitive::~Primitive()
{
}

bool Primitive::beHitBy(glm::vec3 orig, glm::vec3 dir, float &t, vec3 &N) const{
    return false;
}

void Primitive::transformRayToLocal(glm::vec3 &orig, glm::vec3 &dir) const{
    mat4 inverse_transform = glm::inverse(curr_transform);
    vec3 pointingAt = orig + dir;
    orig = (vec3)(inverse_transform * (vec4(orig, 1.0f)));
    pointingAt = (vec3)(inverse_transform * (vec4(pointingAt, 1.0f)));
    vec3 dir_local = pointingAt - orig;
    dir = glm::normalize(dir_local);
}

Sphere::~Sphere()
{
}

bool Sphere::beHitBy(glm::vec3 orig, glm::vec3 dir, float &t, glm::vec3 &N) const{
    vec3 orig_local = orig;
    vec3 dir_local = dir;
    transformRayToLocal(orig_local, dir_local);
    NonhierSphere nhs(vec3(0.0f), 1.0f);
    float t_local;
    vec3 N_local;
    if (nhs.beHitBy(orig_local, dir_local, t_local, N_local)) {
        vec3 p_local = orig_local + t_local * dir_local;
        vec3 p = (vec3)(curr_transform * vec4(p_local, 1.0f));
        t = glm::length(p - orig);
        N = glm::normalize((vec3)(glm::transpose(glm::inverse(curr_transform)) * vec4(N_local, 1.0f)));
        return true;
    } else {    
        return false;
    }
}

Cube::~Cube()
{
}

bool Cube::beHitBy(glm::vec3 orig, glm::vec3 dir, float &t, glm::vec3 &N) const{
    vec3 orig_local = orig;
    vec3 dir_local = dir;
    transformRayToLocal(orig_local, dir_local);
    NonhierBox nhb(vec3(0.0f), 1.0f);
    float t_local;
    vec3 N_local;
    if (nhb.beHitBy(orig_local, dir_local, t_local, N_local)) {
        vec3 p_local = orig_local + t_local * dir_local;
        vec3 p = (vec3)(curr_transform * vec4(p_local, 1.0f));
        t = glm::length(p - orig);
        N = glm::normalize((vec3)(glm::transpose(glm::inverse(curr_transform)) * vec4(N_local, 1.0f)));
        return true;
    } else {    
        return false;
    }
}

Cylinder::~Cylinder()
{
}

bool Cylinder::beHitBy(glm::vec3 orig, glm::vec3 dir, float &t, glm::vec3 &N) const {
    vec3 orig_local = orig;
    vec3 dir_local = dir;
    transformRayToLocal(orig_local, dir_local);
    // calculate intersection with a "unit" cylinder with radius 1, length 1 and aligned with the y axis
    bool intersect_unit_cylinder = true;
    float t_local;
    vec3 p_local;
    vec3 N_local;
    {
        vec3 m_pos = vec3(0, 0, 0);
        float m_length = 1.0f;

        double roots[2];

        double a = pow(dir_local.x, 2) + pow(dir_local.z, 2);
        double b = 2 * orig_local.x * dir_local.x + 2 * orig_local.z * dir_local.z;
        double c = pow(orig_local.x, 2) + pow(orig_local.z, 2) - 1;

        int num_roots = quadraticRoots(a, b, c, roots);
        
        if (num_roots == 0) {
            intersect_unit_cylinder = false;
        } else if (num_roots == 2) {
            double t0 = roots[0];
            double t1 = roots[1];

            // test for each t, whether it passes the test
            float y_1 = orig_local.y + t0 * dir_local.y;
            float y_2 = orig_local.y + t1 * dir_local.y;

            if ((y_1 <= (m_pos.y + m_length) && y_1 >= m_pos.y) &&
                (y_2 <= (m_pos.y + m_length) && y_2 >= m_pos.y)) {
                if (t0 > t1) std::swap(t0, t1); 
        
                if (t0 < 0) { 
                    t0 = t1;
                }

                t_local = t0;
            } else if (y_1 <= (m_pos.y + m_length) && y_1 >= m_pos.y) {
                t_local = t0;
            } else if (y_2 <= (m_pos.y + m_length) && y_2 >= m_pos.y) {
                t_local = t1;
            } else {
                intersect_unit_cylinder = false;
            }

            if (t_local < 0) {
                intersect_unit_cylinder = false;
            }

            p_local = orig_local + t_local * dir_local;
            vec3 rel = m_pos + vec3(0, p_local.y, 0);
            N_local = glm::normalize(p_local - rel);
        }
    }
    if (intersect_unit_cylinder) {
        vec3 p = (vec3)(curr_transform * vec4(p_local, 1.0f));
        t = glm::length(p - orig);
        N = glm::normalize((vec3)(glm::transpose(glm::inverse(curr_transform)) * vec4(N_local, 1.0f)));
        return true;
    } else {    
        return false;
    }
}

Torus::~Torus()
{
}

bool Torus::beHitBy(glm::vec3 orig, glm::vec3 dir, float &t, glm::vec3 &N) const {
    vec3 orig_local = orig;
    vec3 dir_local = dir;
    transformRayToLocal(orig_local, dir_local);
    // calculate intersection with a "unit" torus with radius 1, thickness radius 0.5 and positioned at the origin
    bool intersect_unit_torus = true;
    float t_local;
    vec3 p_local;
    vec3 N_local;
    {
        vec3 m_pos = vec3(0, 0, 0);
        float m_radius = 1.0f;
        float m_thickness_local = m_thickness * m_radius; // the radius of the outer circle
        
        double coefficients[5];
        double roots[4];

        //https://marcin-chwedczuk.github.io/ray-tracing-torus
        float d_squared = glm::dot(dir_local, dir_local);
        float o_squared = glm::dot(orig_local, orig_local);
        float o_dot_d = glm::dot(orig_local, dir_local);
        float r_squared = pow(m_thickness_local, 2);
        float R_squared = pow(m_radius, 2);

        coefficients[4] = pow(d_squared, 2);
        coefficients[3] = 4 * d_squared * o_dot_d;
        coefficients[2] = 2 * d_squared * (o_squared - (r_squared + R_squared)) + 
                            4 * pow(o_dot_d, 2) + 4 * R_squared * pow(dir_local.y, 2);
        coefficients[1] = 4 * (o_squared - (r_squared + R_squared)) * o_dot_d + 8 * R_squared * orig_local.y * dir_local.y;
        coefficients[0] = pow((o_squared - (r_squared + R_squared)), 2) - 4 * R_squared * (r_squared - pow(orig_local.y, 2));

        double coefficients_normal[4];
        coefficients_normal[0] = coefficients[3] / coefficients[4];
        coefficients_normal[1] = coefficients[2] / coefficients[4];
        coefficients_normal[2] = coefficients[1] / coefficients[4];
        coefficients_normal[3] = coefficients[0] / coefficients[4];

        int num_roots = quarticRoots(coefficients_normal[0], coefficients_normal[1], coefficients_normal[2], coefficients_normal[3], roots);

        if (num_roots <= 1) {
            intersect_unit_torus = false;
        } else {
            list<double> roots_sort;
            for (int i = 0; i < 4; ++i) {
                if (roots[i] > 0.01f) {
                    roots_sort.emplace_back(roots[i]);
                }
            }
            roots_sort.sort();
            if (roots_sort.size() == 0 ) {
                intersect_unit_torus = false;
            }
            float t_local = roots_sort.front();
            p_local = orig_local + t_local * dir_local;

            // closest point on the circle
            // https://www.geometrictools.com/Documentation/DistanceToCircle3.pdf
            vec3 up = vec3(0, 1, 0);
            vec3 delta = p_local - m_pos;
            vec3 k = m_pos + m_radius * glm::normalize(delta - glm::dot(up, delta) * up);

            N_local = glm::normalize(p_local - k);
        }
    }
    if (intersect_unit_torus) {
        vec3 p = (vec3)(curr_transform * vec4(p_local, 1.0f));
        t = glm::length(p - orig);
        N = glm::normalize((vec3)(glm::transpose(glm::inverse(curr_transform)) * vec4(N_local, 1.0f)));
        return true;
    } else {    
        return false;
    }
}

NonhierSphere::~NonhierSphere()
{
}

bool NonhierSphere::beHitBy(glm::vec3 orig, glm::vec3 dir, float &t, vec3 &N) const{
    double roots[2];
    vec3 a_minus_c = orig - m_pos;

    double a = glm::dot(dir, dir);
    double b = 2.0f * glm::dot(dir, a_minus_c);
    double c = glm::dot(a_minus_c, a_minus_c) - (m_radius * m_radius);

    int num_roots = quadraticRoots(a, b, c, roots);
    
    if (num_roots == 0) {
        return false;
    } else if (num_roots == 2) {
        double t0 = roots[0];
        double t1 = roots[1];

        if (t0 > t1) std::swap(t0, t1); 
 
        if (t0 < 0) { 
            t0 = t1;
            if (t0 < 0) return false;
        }

        t = t0;
        N = glm::normalize((orig + t * dir) - m_pos);
    }

    return true;
}

NonhierBox::~NonhierBox()
{
}

bool NonhierBox::beHitBy(glm::vec3 orig, glm::vec3 dir, float &t, glm::vec3 &N) const{
    vec3 bounds[2];
    bounds[0] = m_pos;
    bounds[1] = vec3(m_pos.x + m_size, m_pos.y + m_size, m_pos.z + m_size);

    vec3 inv_dir = 1.0f / dir;
    i8vec3 sign = vec3((inv_dir.x < 0), (inv_dir.y < 0), (inv_dir.z < 0));

    float t_min = (bounds[sign.x].x - orig.x) * inv_dir.x;
    float t_max = (bounds[1 - sign.x].x - orig.x) * inv_dir.x;

    float ty_min = (bounds[sign.y].y - orig.y) * inv_dir.y;
    float ty_max = (bounds[1 - sign.y].y - orig.y) * inv_dir.y;

    if ((t_min > ty_max) || (ty_min > t_max)) {
        return false;
    }

    if (ty_min > t_min) {
        t_min = ty_min;
    }

    if (ty_max < t_max) {
        t_max = ty_max;
    }

    float tz_min = (bounds[sign.z].z - orig.z) * inv_dir.z;
    float tz_max = (bounds[1 - sign.z].z - orig.z) * inv_dir.z;
    
    if ((t_min > tz_max) || (tz_min > t_max)) {
        return false;
    }

    if (tz_min > t_min) {
        t_min = tz_min;
    }

    if (tz_max < t_max) {
        t_max = tz_max;
    }

    if (t_min < 0) {
        t_min = t_max;
        if (t_min < 0) return false;
    }

    t = t_min;

    // normal calculation
    float bias = 1.0001f;

    vec3 min = bounds[0];
    vec3 max = bounds[1];

    vec3 center = vec3((min.x + max.x) / 2, (min.y + max.y) / 2, (min.z + max.z) / 2);
    vec3 hit = orig + t * dir;
    vec3 p = hit - center;
    vec3 divisor = vec3(abs(min.x - max.x) / 2, abs(min.y - max.y) / 2, abs(min.z - max.z) / 2);
    N = vec3((int)(p.x / divisor.x * bias), (int)(p.y / divisor.y * bias), (int)(p.z / divisor.z * bias));
    N = glm::normalize(N);

    return true;
}
