#pragma once

#include <list>
#include <glm/glm.hpp>

#include "Light.hpp"

class AreaLight : public Light {
public:
    AreaLight(glm::vec3 position, glm::vec3 colour, double falloff[3], glm::vec3 dir, glm::vec3 up, float size, int numsamples) :
    Light(position, colour, falloff), dir(dir), up(up), size(size), numsamples(numsamples) {
        this->lightType = LightType::AreaLight;
    }

    glm::vec3 dir;
    glm::vec3 up;
    float size;
    int numsamples;

    std::list<Light *> getSamplePoints();
};