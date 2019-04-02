#pragma once

#include <glm/glm.hpp>
#include <list>
#include <stack>

#include "SceneNode.hpp"
#include "GeometryNode.hpp"
#include "JointNode.hpp"
#include "Light.hpp"
#include "AreaLight.hpp"
#include "Material.hpp"
#include "PhongMaterial.hpp"
#include "ReflectiveMaterial.hpp"
#include "RefractiveMaterial.hpp"
#include "TexturedMaterial.hpp"

class Ray {
public:
    Ray(glm::vec3 orig, glm::vec3 dir, int x, int y): orig(orig), dir(dir), x(x), y(y) {};
    glm::vec3 genBG();
    
    static const int MAX_HITS;
    static const float BIAS;
    static Ray ggReflection(const glm::vec3 &p, const glm::vec3 &dir, const glm::vec3 &N, int x, int y);
    static Ray *ggRefract(const glm::vec3 &p, const glm::vec3 &dir, const glm::vec3 &N, float ior, int x, int y);
    GeometryNode *hit(SceneNode * root, float &t, glm::vec3 &N, float &u, float &v);
    glm::vec3 getColor(SceneNode * root, std::list<Light *> lights, glm::vec3 & ambient, int maxHits);
    friend std::ostream& operator<<(std::ostream& out, const Ray& ray);
    glm::vec3 pointAt(float t);
    static Ray perturb(const glm::vec3 &p, const glm::vec3 &dir, const glm::vec3 &N);
private:
    glm::vec3 orig;
    glm::vec3 dir;
    int x;
    int y;
};