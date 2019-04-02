// Winter 2019

#pragma once

#include <iosfwd>

#include <glm/glm.hpp>

enum class LightType {
	Light,
	AreaLight
};

// Represents a simple point light.
struct Light {
  Light(glm::vec3 position, glm::vec3 colour, double falloff[3]): position(position), colour(colour) {
    this->falloff[0] = falloff[0];
    this->falloff[1] = falloff[1];
    this->falloff[2] = falloff[2];
    this->lightType = LightType::Light;
    orig_pos = position;
  }
  
  glm::vec3 position;
  glm::vec3 colour;
  double falloff[3];
  LightType lightType;
  glm::vec3 orig_pos;
  glm::vec3 directLight(const glm::vec3 &p, const glm::vec3 &N);
  glm::vec3 specularLight(const glm::vec3 &view_dir, const glm::vec3 &reflect_dir, double shininess);
};

std::ostream& operator<<(std::ostream& out, const Light& l);
