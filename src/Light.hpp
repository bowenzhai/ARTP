// Winter 2019

#pragma once

#include <iosfwd>

#include <glm/glm.hpp>

// Represents a simple point light.
struct Light {
  Light();
  
  glm::vec3 colour;
  glm::vec3 position;
  double falloff[3];
  glm::vec3 directLight(const glm::vec3 &p, const glm::vec3 &N);
  glm::vec3 specularLight(const glm::vec3 &view_dir, const glm::vec3 &reflect_dir, double shininess);
};

std::ostream& operator<<(std::ostream& out, const Light& l);
