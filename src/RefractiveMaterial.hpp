#pragma once

#include <glm/glm.hpp>

#include "Material.hpp"

class RefractiveMaterial : public Material {
public:
  RefractiveMaterial(const glm::vec3& kd, double ior, double glossiness);
  virtual ~RefractiveMaterial();
  glm::vec3 m_kd;

  double m_ior;
  double m_glossiness;
};
