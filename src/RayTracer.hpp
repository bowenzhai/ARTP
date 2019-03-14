#pragma once

#include <glm/glm.hpp>

#include "SceneNode.hpp"
#include "GeometryNode.hpp"
#include "JointNode.hpp"
#include "Light.hpp"
#include "Image.hpp"
#include "Ray.hpp"

class RayTracer {
public: 
    SceneNode * root;

    // Image to write to, set to a given width and height
    Image & image;

    // Viewing parameters
    glm::vec3 eye;
    glm::vec3 view;
    glm::vec3 up;
    double fovy;

    // Lighting parameters
    glm::vec3 & ambient;
    std::list<Light *> lights;

    RayTracer(SceneNode * root,
        Image & image,
        glm::vec3 & eye,
        glm::vec3 & view,
        glm::vec3 & up,
        double fovy,
        glm::vec3 & ambient,
        std::list<Light *> & lights): root(root), image(image), eye(eye), view(view), up(up), fovy(fovy), ambient(ambient), lights(lights) {}

    void transformToWorld(glm::vec3 &coords);

    void render();
};
