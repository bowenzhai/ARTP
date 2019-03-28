// Fall 2018

#pragma once

#include <glm/glm.hpp>

class Primitive {
public:
  virtual ~Primitive();
  virtual bool beHitBy(glm::vec3 orig, glm::vec3 dir, float &t, glm::vec3 &N) const;
  void transformRayToLocal(glm::vec3 &orig, glm::vec3 &dir) const;
  glm::mat4 curr_transform;
};

class Sphere : public Primitive {
public:
  virtual ~Sphere();
  virtual bool beHitBy(glm::vec3 orig, glm::vec3 dir, float &t, glm::vec3 &N) const override;
};

class Cube : public Primitive {
public:
  virtual ~Cube();
  virtual bool beHitBy(glm::vec3 orig, glm::vec3 dir, float &t, glm::vec3 &N) const override;
};

class Cylinder : public Primitive {
public:
  virtual ~Cylinder();
  virtual bool beHitBy(glm::vec3 orig, glm::vec3 dir, float &t, glm::vec3 &N) const override;
};

class Torus : public Primitive {
public:
  Torus(const float thickness): m_thickness(thickness) {}
  virtual ~Torus();
  virtual bool beHitBy(glm::vec3 orig, glm::vec3 dir, float &t, glm::vec3 &N) const override;

private:
  float m_thickness;
};

class NonhierSphere : public Primitive {
public:
  NonhierSphere(const glm::vec3& pos, double radius)
    : m_pos(pos), m_radius(radius)
  {
  }
  virtual ~NonhierSphere();
  virtual bool beHitBy(glm::vec3 orig, glm::vec3 dir, float &t, glm::vec3 &N) const override;

private:
  glm::vec3 m_pos;
  double m_radius;
};

class NonhierBox : public Primitive {
public:
  NonhierBox(const glm::vec3& pos, double size)
    : m_pos(pos), m_size(size)
  {
  }
  
  virtual ~NonhierBox();
  virtual bool beHitBy(glm::vec3 orig, glm::vec3 dir, float &t, glm::vec3 &N) const override;

private:
  glm::vec3 m_pos;
  double m_size;
};
