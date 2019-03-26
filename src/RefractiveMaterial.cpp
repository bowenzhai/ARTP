#include "RefractiveMaterial.hpp"

RefractiveMaterial::RefractiveMaterial(
	const glm::vec3& kd, double ior, double glossiness )
	: m_kd(kd), m_ior(ior), m_glossiness(glossiness)
{
	m_materialType = MaterialType::RefractiveMaterial;
}

RefractiveMaterial::~RefractiveMaterial()
{}