// Winter 2019

#include <iostream>

#include <glm/ext.hpp>

#include "Light.hpp"

using namespace glm;

Light::Light()
  : colour(0.0, 0.0, 0.0),
    position(0.0, 0.0, 0.0)
{
  falloff[0] = 1.0;
  falloff[1] = 0.0;
  falloff[2] = 0.0;
}

vec3 Light::directLight(const vec3 &p, const vec3 &N) {
  vec3 lightDir = glm::normalize(position - p);
  float diff = max(glm::dot(N, lightDir), 0.0f);
  return diff * colour;
}

vec3 Light::specularLight(const vec3 &view_dir, const glm::vec3 &reflect_dir, double shininess) {
  float spec = pow(max(glm::dot(view_dir, reflect_dir), 0.0f), shininess);
  return spec * colour;
}

std::ostream& operator<<(std::ostream& out, const Light& l)
{
  out << "L[" << glm::to_string(l.colour) 
  	  << ", " << glm::to_string(l.position) << ", ";
  for (int i = 0; i < 3; i++) {
    if (i > 0) out << ", ";
    out << l.falloff[i];
  }
  out << "]";
  return out;
}
