#include "ReflectiveMaterial.hpp"

ReflectiveMaterial::ReflectiveMaterial(
	const glm::vec3& kd, double reflectiveness, double glossiness )
	: m_kd(kd), m_reflectiveness(reflectiveness), m_glossiness(glossiness)
{
	m_materialType = MaterialType::ReflectiveMaterial;
}

ReflectiveMaterial::~ReflectiveMaterial()
{}