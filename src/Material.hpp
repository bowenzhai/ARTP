// Winter 2019

#pragma once

enum class MaterialType {
	PhongMaterial,
	ReflectiveMaterial
};

class Material {
public:
  virtual ~Material();
  MaterialType m_materialType;

protected:
  Material();
};
