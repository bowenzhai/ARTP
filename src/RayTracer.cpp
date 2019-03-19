// Winter 2019

#include <glm/ext.hpp>

#include "RayTracer.hpp"
#include "RayTracerWorker.hpp"

using namespace std;

using namespace glm;

SceneNode *RayTracer::flattenScene(SceneNode * new_root, SceneNode * node) {
	mat4 new_matrix(matrix_stack.top());
	//new_matrix = node->trans * new_matrix;
	new_matrix = new_matrix * node->trans;	
	if (node->m_nodeType == NodeType::JointNode) {
		JointNode *jointNode = static_cast<JointNode *>(node);
		mat4 id(1.0f);
		float degree = jointNode->m_joint_x.init;
		new_matrix = glm::rotate(new_matrix, radians(degree), vec3(1, 0, 0));
	}

    //cout << glm::to_string(new_matrix) << endl;
	matrix_stack.push(new_matrix);

	if (node->m_nodeType == NodeType::GeometryNode) {
		GeometryNode *geometryNode = static_cast<GeometryNode *>(node);
        geometryNode->m_primitive->curr_transform = new_matrix;
		new_root->add_child(geometryNode);
	}

	for (auto child : node->children) {
        flattenScene(new_root, child);
	}

	matrix_stack.pop();

	// done flattening, replace root
	if (node->m_name == "root") {
		return new_root;
	}
}

void RayTracer::transformToWorld(glm::vec3 &coords) {
	float n_x = image.width();
	float n_y = image.height();
	float d = 1.0f;

	vec4 coords_4 = vec4(coords, 1.0f);

	mat4 translate_1 = glm::translate(mat4(1.0f), vec3(-n_x / 2.0f, -n_y / 2.0f, d));
	
	// preserve aspect ratio and correct sign
	float h = 2 * d * tan(glm::radians(fovy) / 2.0f);
	mat4 scale = glm::scale(mat4(1.0f), vec3(-h / n_y, -h / n_y, 1.0f));

	// to superimpose WCS to VCS
	vec3 w = glm::normalize(view);
	vec3 u = glm::cross(up, w);
	u = glm::normalize(u);
	vec3 v = glm::cross(w, u);
	v = glm::normalize(v);
	mat4 rotate = {u.x, v.x, w.x, 0.0f,
					u.y, v.y, w.y, 0.0f,
					u.z, v.z, w.z, 0.0f,
					0.0f, 0.0f, 0.0f, 1.0f};

	// apply camera-to-world
	mat4 translate_2 = glm::translate(mat4(1.0f), vec3(eye.x, eye.y, eye.z));
	coords_4 = translate_2 * rotate * scale * translate_1 * coords_4;
	coords = (vec3)coords_4;
}

void RayTracer::render() {

  // Fill in raytracing code here...  

  std::cout << "Calling RayTracer::render(\n" <<
		  "\t" << *root <<
          "\t" << "Image(width:" << image.width() << ", height:" << image.height() << ")\n"
          "\t" << "eye:  " << glm::to_string(eye) << std::endl <<
		  "\t" << "view: " << glm::to_string(view) << std::endl <<
		  "\t" << "up:   " << glm::to_string(up) << std::endl <<
		  "\t" << "fovy: " << fovy << std::endl <<
          "\t" << "ambient: " << glm::to_string(ambient) << std::endl <<
		  "\t" << "lights{" << std::endl;

	for(const Light * light : lights) {
		std::cout << "\t\t" <<  *light << std::endl;
	}
	std::cout << "\t}" << std::endl;
	std::cout << "\t" << "num_workers:" << num_workers << std::endl;
	std::cout <<")" << std::endl;

	// flatten scene
	matrix_stack.push(glm::mat4(1.0f));
	// shallow copy root node
	root_flattened = new SceneNode(root->m_name);
	root_flattened->m_nodeType = root->m_nodeType;
	root_flattened->m_name = root->m_name;
	root_flattened->trans = root->trans;
	root_flattened->invtrans = root->invtrans;

	root = flattenScene(root_flattened, root);

	RayTracerWorker *workers[num_workers];
	thread threads[num_workers];
	for (int i = 0; i < num_workers; ++i) {
		workers[i] = new RayTracerWorker(i, this);
		threads[i] = thread(&RayTracerWorker::launch, workers[i]);
	}
	
	for (int i = 0; i < num_workers; ++i) {
		threads[i].join();
	}
}
