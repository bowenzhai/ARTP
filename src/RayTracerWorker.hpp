#pragma once

#include "RayTracer.hpp"

class RayTracerWorker {
public:
    int workerId;
    RayTracer *parent;
    int progress = 0;
    void launch();

    RayTracerWorker(int workerId, RayTracer *parent): workerId(workerId), parent(parent) {}
};
