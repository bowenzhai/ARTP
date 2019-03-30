#pragma once

#include <string>

#include <glm/glm.hpp>

enum class Transition {
	Linear
};

class Animation {
public:
  Animation(int startframe, int duration, std::string transform, glm::vec3 amount, std::string transition): 
    m_startframe(startframe), m_duration(duration), m_transform(transform), m_amount(amount)
    {
        if (transition == "linear") {
            m_transition = Transition::Linear;
        }
    }
  int m_startframe;
  int m_duration;
  std::string m_transform;
  glm::vec3 m_amount;
  Transition m_transition;

  glm::mat4 generateIntermetiate(int frame);
};
