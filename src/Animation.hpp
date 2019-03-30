#pragma once

#include <string>

#include <glm/glm.hpp>

enum class Transition {
	Linear,
  Ease,
  EaseIn,
  EaseOut,
  EaseInOut
};

class Animation {
public:
  Animation(int startframe, int duration, std::string transform, glm::vec3 amount, std::string transition): 
    m_startframe(startframe), m_duration(duration), m_transform(transform), m_amount(amount)
    {
      if (transition == "linear") {
        m_transition = Transition::Linear;
      } else if (transition == "ease") {
        m_transition = Transition::Ease;
      } else if (transition == "ease-in") {
        m_transition = Transition::EaseIn;
      } else if (transition == "ease-out") {
        m_transition = Transition::EaseOut;
      } else if (transition == "ease-in-out") {
        m_transition = Transition::EaseInOut;
      }
    }
  int m_startframe;
  int m_duration;
  std::string m_transform;
  glm::vec3 m_amount;
  Transition m_transition;

  glm::mat4 generateIntermetiate(int frame);

  glm::vec3 bezierInterpolation(glm::vec3 start, glm::vec3 end, float t, Transition kind);
};
