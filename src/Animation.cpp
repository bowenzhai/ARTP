#include "Animation.hpp"

using namespace std;

using namespace glm;

#include <iostream>
#include <glm/ext.hpp>

vec3 Animation::bezierInterpolation(vec3 start, vec3 end, float alpha, Transition kind) {
    vec2 P0(0.0f, 0.0f);
    vec2 P1, P2;
    vec2 P3(1.0f, 1.0f);
    if (kind == Transition::Ease) {
        P1 = vec2(0.25f, 0.1f);
        P2 = vec2(0.25f, 1.0f);
    } else if (kind == Transition::EaseIn) {
        P1 = vec2(0.42f, 0.0f);
        P2 = vec2(1.0f, 1.0f);
    } else if (kind == Transition::EaseOut) {
        P1 = vec2(0.0f, 0.0f);
        P2 = vec2(0.58f, 1.0f);
    } else if (kind == Transition::EaseInOut) {
        P1 = vec2(0.42f, 0.0f);
        P2 = vec2(0.58f, 1.0f);
    }

    vec2 p(0, 0);
    float t = 0.0f;
    while (p.x < alpha) {
        p = pow((1-t), 3) * P0 + 3 * t * pow((1-t), 2) *P1 + 3 * pow(t, 2) * (1-t) * P2 + pow(t, 3) * P3;
        t += 0.01;
    }
    
    return glm::lerp(start, end, p.y);
}

mat4 Animation::generateIntermetiate(int frame) {
    vec3 start(0.0f);
    if (m_transform == "scale") {
        start = vec3(1.0f);
    }
    mat4 intermediate;
    vec3 intermediate_amount;
    float alpha = (float)(frame - m_startframe) / (float)m_duration;
    float alpha_prev = (float)(frame - 1 - m_startframe) / (float)m_duration;
    if (m_transition == Transition::Linear) {
        intermediate_amount = glm::lerp(start, m_amount, alpha) - glm::lerp(start, m_amount, alpha_prev);
    } else {
        intermediate_amount = bezierInterpolation(start, m_amount, alpha, m_transition) - bezierInterpolation(start, m_amount, alpha_prev, m_transition);
    }

    if (m_transform == "translate") {
        intermediate = glm::translate(intermediate_amount);
    } else if (m_transform == "rotate") {
        if (intermediate_amount.x != 0) {
            intermediate = glm::rotate(glm::radians(intermediate_amount.x), vec3(1, 0, 0));
        } else if (intermediate_amount.y != 0) {
            intermediate = glm::rotate(glm::radians(intermediate_amount.y), vec3(0, 1, 0));
        } else if (intermediate_amount.z != 0) {
            intermediate = glm::rotate(glm::radians(intermediate_amount.z), vec3(0, 0, 1));
        }
    } else if (m_transform == "scale") {
        intermediate = glm::scale(intermediate_amount);
    }
    
    return intermediate;
}