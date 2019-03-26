#pragma once

#include <glm/glm.hpp>

#include "Material.hpp"

class ReflectiveMaterial : public Material {
public:
  ReflectiveMaterial(const glm::vec3& kd, double reflectiveness, double glossiness);
  virtual ~ReflectiveMaterial();
  glm::vec3 m_kd;

  double m_reflectiveness;
  double m_glossiness;
};
