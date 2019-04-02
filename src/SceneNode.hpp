// Fall 2018

#pragma once

#include "Material.hpp"
#include "Animation.hpp"

#include <glm/glm.hpp>

#include <list>
#include <string>
#include <iostream>

enum class NodeType {
	SceneNode,
	GeometryNode,
	JointNode
};

class SceneNode {
public:
    SceneNode(const std::string & name);

	SceneNode(const SceneNode & other);

    virtual ~SceneNode();
    
	int totalSceneNodes() const;
    
    const glm::mat4& get_transform() const;
    const glm::mat4& get_inverse() const;
    
    void set_transform(const glm::mat4& m);
    
    void add_child(SceneNode* child);
    
    void remove_child(SceneNode* child);

	//-- Transformations:
    void rotate(char axis, float angle);
    void scale(const glm::vec3& amount);
    void translate(const glm::vec3& amount);


	friend std::ostream & operator << (std::ostream & os, const SceneNode & node);

    // Transformations
    glm::mat4 trans;
    glm::mat4 invtrans;

    glm::mat4 anim_scale = glm::mat4(1.0f);
    glm::mat4 anim_rotate = glm::mat4(1.0f);
    glm::mat4 anim_translate = glm::mat4(1.0f);

    
    std::list<SceneNode*> children;

	NodeType m_nodeType;
	std::string m_name;
	unsigned int m_nodeId;

    //Animation
    std::list<Animation *>anim;
    void apply_animation(int startframe, int duration, std::string transform, glm::vec3 amount, std::string transition);

private:
	// The number of SceneNode instances.
	static unsigned int nodeInstanceCount;
};
