#include <random>
#include <iostream>
#include <glm/ext.hpp>

#include "AreaLight.hpp"

using namespace std;
using namespace glm;

list<Light *> AreaLight::getSamplePoints() {
    list <Light *> samples;
    vec3 side = glm::normalize(glm::cross(dir, up));
    for (int i = 0; i < numsamples; ++i) { 
        random_device rd; 
        mt19937_64 rng(rd());
        uniform_real_distribution<float> unif(-1 * size, 1 * size);
        float rng1 = unif(rng);
        float rng2 = unif(rng);
        vec3 newPos = position + rng1 * up + rng2 * side;
        Light *l = new Light(newPos, this->colour, this->falloff);
        samples.emplace_back(l);
        //cout << glm::to_string(l->position) << endl;
    }
    return samples;
}