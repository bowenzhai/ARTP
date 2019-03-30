#include "Animation.hpp"

using namespace std;

using namespace glm;

#include <glm/ext.hpp>

mat4 Animation::generateIntermetiate(int frame) {
    vec3 start(0.0f);
    mat4 intermediate;
    vec3 intermediate_amount;
    if (m_transition == Transition::Linear) {
        float alpha = (float)(frame - m_startframe) / (float)m_duration;
        intermediate_amount = glm::lerp(start, m_amount, alpha);
    }

    if (m_transform == "translate") {
        intermediate = glm::translate(intermediate_amount);
    }
    
    return intermediate;
}