#include "ReflectiveMaterial.hpp"

ReflectiveMaterial::ReflectiveMaterial(
	const glm::vec3& kd, double reflectiveness )
	: m_kd(kd)
	, m_reflectiveness(reflectiveness)
{
	m_materialType = MaterialType::ReflectiveMaterial;
}

ReflectiveMaterial::~ReflectiveMaterial()
{}