#pragma once

#include <vector>
#include <string>
#include <glm/glm.hpp>

#include "Material.hpp"

class TexturedMaterial : public Material {
public:
  TexturedMaterial(const std::string src, const glm::vec3& ks, double shininess, const glm::vec2 & tile);
  virtual ~TexturedMaterial();
  std::string m_src;
  glm::vec3 m_ks;
  std::vector<unsigned char> m_data;
  uint w;
  uint h;

  double m_shininess;
  glm::vec2 m_tile;

  void loadData();
  glm::vec3 getTexturePixel(int x, int y);
  glm::vec3 getMaterialColor(float u, float v);
};
