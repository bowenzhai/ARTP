#pragma once

#include <thread>
#include <vector>

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
    SceneNode * root_orig;

    // Image to write to, set to a given width and height
    std::vector<Image *> & images;
    Image *current_image;
    int curr_frame;

    // Viewing parameters
    glm::vec3 eye;
    glm::vec3 view;
    glm::vec3 up;
    double fovy;

    // Lighting parameters
    glm::vec3 & ambient;
    std::list<Light *> lights;

    // Num workers
    int num_workers;

    // AA
    double tolarance;

    SceneNode *root_flattened;
    std::stack<glm::mat4> matrix_stack;

    RayTracer(SceneNode * root,
            std::vector<Image *> & images,
            glm::vec3 & eye,
            glm::vec3 & view,
            glm::vec3 & up,
            double fovy,
            glm::vec3 & ambient,
            std::list<Light *> & lights,
            int num_workers,
            double tolarance): root(root), images(images), eye(eye), view(view), up(up), fovy(fovy), ambient(ambient), lights(lights), num_workers(num_workers), tolarance(tolarance) {
                root_orig = root;
            }

    SceneNode *flattenScene(SceneNode * new_root, SceneNode * root);

    void transformToWorld(glm::vec3 &coords);

    void detectVariation();

    void render(int frame);
};
