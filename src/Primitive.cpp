// Winter 2019

#include <utility>
#include <iostream>
#include <glm/ext.hpp>

#include "Primitive.hpp"
#include "polyroots.hpp"

using namespace std;

using namespace glm;

Primitive::~Primitive()
{
}

bool Primitive::beHitBy(glm::vec3 orig, glm::vec3 dir, float &t, vec3 &N) {
    return false;
}

Sphere::~Sphere()
{
}

bool Sphere::beHitBy(glm::vec3 orig, glm::vec3 dir, float &t, glm::vec3 &N) {
    mat4 inverse_transform = glm::inverse(curr_transform);
    vec3 pointingAt = orig + dir;
    vec3 orig_local = (vec3)(inverse_transform * (vec4(orig, 1.0f)));
    pointingAt = (vec3)(inverse_transform * (vec4(pointingAt, 1.0f)));
    vec3 dir_local = pointingAt - orig_local;
    //vec3 dir_local = dir;
    dir_local = glm::normalize(dir_local);
    NonhierSphere nhs(vec3(0.0f), 1.0f);
    float t_local;
    vec3 N_local;
    if (nhs.beHitBy(orig_local, dir_local, t_local, N_local)) {
        vec3 p_local = orig_local + t_local * dir_local;
        vec3 p = (vec3)(curr_transform * vec4(p_local, 1.0f));
        t = glm::length(p - orig);
        N = glm::normalize((vec3)(glm::transpose(inverse_transform) * vec4(N_local, 1.0f)));
        return true;
    } else {    
        return false;
    }
}

Cube::~Cube()
{
}

bool Cube::beHitBy(glm::vec3 orig, glm::vec3 dir, float &t, glm::vec3 &N) {
    mat4 inverse_transform = glm::inverse(curr_transform);
    vec3 pointingAt = orig + dir;
    vec3 orig_local = (vec3)(inverse_transform * (vec4(orig, 1.0f)));
    pointingAt = (vec3)(inverse_transform * (vec4(pointingAt, 1.0f)));
    vec3 dir_local = pointingAt - orig_local;
    //vec3 dir_local = dir;
    dir_local = glm::normalize(dir_local);
    NonhierBox nhb(vec3(0.0f), 1.0f);
    float t_local;
    vec3 N_local;
    if (nhb.beHitBy(orig_local, dir_local, t_local, N_local)) {
        vec3 p_local = orig_local + t_local * dir_local;
        vec3 p = (vec3)(curr_transform * vec4(p_local, 1.0f));
        t = glm::length(p - orig);
        N = glm::normalize((vec3)(glm::transpose(inverse_transform) * vec4(N_local, 1.0f)));
        return true;
    } else {    
        return false;
    }
}

NonhierSphere::~NonhierSphere()
{
}

bool NonhierSphere::beHitBy(glm::vec3 orig, glm::vec3 dir, float &t, vec3 &N) {
    //cout << "hit test" << endl;
    double roots[2];
    vec3 a_minus_c = orig - m_pos;
    //cout << "orig: " << glm::to_string(orig) << " dir: " << glm::to_string(dir) << endl;

    double a = glm::dot(dir, dir);
    double b = 2.0f * glm::dot(dir, a_minus_c);
    double c = glm::dot(a_minus_c, a_minus_c) - (m_radius * m_radius);

    //cout << "a: " << a << " b: " << b << " c: " << c << endl;

    int num_roots = quadraticRoots(a, b, c, roots);
    
    if (num_roots == 0) {
        return false;
    } else if (num_roots == 2) {
        //cout << "num roots " << num_roots << endl;
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

    //cout << "hit, t = " << t << endl;
    return true;
}

NonhierBox::~NonhierBox()
{
}

bool NonhierBox::beHitBy(glm::vec3 orig, glm::vec3 dir, float &t, glm::vec3 &N) {
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
    float bias = 1.00001f;

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
