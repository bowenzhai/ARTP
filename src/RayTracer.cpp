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

	// animation
	list<Animation *> anim = node->anim;
	for (Animation * a : anim) {
		if (curr_frame > a->m_startframe && curr_frame <= (a->m_startframe + a->m_duration)) {
			mat4 intermediate = a->generateIntermetiate(curr_frame);
			if (a->m_transform == "scale") {
				node->anim_scale = intermediate * node->anim_scale;
			} else if (a->m_transform == "rotate") {
				node->anim_rotate = intermediate * node->anim_rotate;
			} else if (a->m_transform == "translate") {
				node->anim_translate = intermediate * node->anim_translate;
			}
		}
	}

	new_matrix = new_matrix * node->anim_translate * node->anim_rotate;

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
	float n_x = current_image->width();
	float n_y = current_image->height();
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

void RayTracer::detectVariation() {
	std::cout << "postprocess..." << std::endl;

	list<pair<int, int>> outliers;
	int w = current_image->width();
	int h = current_image->height();
	for (int y = 0; y < h; ++y) {
		for (int x = 0; x < w; ++x) {
			float red_delta = 0.0f;
			float green_delta = 0.0f;
			float blue_delta = 0.0f;
		
			// Red: 
			float current_red = current_image->operator()(x, y, 0);
			// Green: 
			float current_green = current_image->operator()(x, y, 1);
			// Blue: 
			float current_blue = current_image->operator()(x, y, 2);
			if (y - 1 >= 0) {
				red_delta += (current_image->operator()(x, y-1, 0) - current_red);
				green_delta += (current_image->operator()(x, y-1, 1) - current_green);
				blue_delta += (current_image->operator()(x, y-1, 2) - current_blue);
			}
			if (y + 1 < h) {
				red_delta += (current_image->operator()(x, y+1, 0) - current_red);
				green_delta += (current_image->operator()(x, y+1, 1) - current_green);
				blue_delta += (current_image->operator()(x, y+1, 2) - current_blue);
			}
			if (x - 1 >= 0) {
				red_delta += (current_image->operator()(x-1, y, 0) - current_red);
				green_delta += (current_image->operator()(x-1, y, 1) - current_green);
				blue_delta += (current_image->operator()(x-1, y, 2) - current_blue);
			}
			if (x + 1 < w) {
				red_delta += (current_image->operator()(x+1, y, 0) - current_red);
				green_delta += (current_image->operator()(x+1, y, 1) - current_green);
				blue_delta += (current_image->operator()(x+1, y, 2) - current_blue);
			}

			if (red_delta > tolarance || green_delta > tolarance || blue_delta > tolarance) {
				outliers.emplace_back(pair<int, int>(x, y));
			}
		}
	}

	for (auto p : outliers) {
		int x = p.first;
		int y = p.second;
		// // Red: 
		// current_image->operator()(x, y, 0) = 1;
		// // Green: 
		// current_image->operator()(x, y, 1) = 0;
		// // Blue: 
		// current_image->operator()(x, y, 2) = 0;

		// generate the ray
		vec3 new_color(0.0f);
		list<pair<float, float>> surroundings;
		surroundings.emplace_back(pair<float, float>(x-0.5f, y-0.5f));
		surroundings.emplace_back(pair<float, float>(x+0.5f, y-0.5f));
		surroundings.emplace_back(pair<float, float>(x-0.5f, y+0.5f));
		surroundings.emplace_back(pair<float, float>(x+0.5f, y+0.5f));

		for (auto s : surroundings) {
			float x_new = s.first;
			float y_new = s.second;

			vec3 pixel = {x_new, y_new, 0.0f};
			transformToWorld(pixel);
			vec3 dir = pixel - eye;
			dir = glm::normalize(dir);
			Ray ray = Ray(eye, dir, x_new, y_new);
			
			new_color += ray.getColor(root, lights, ambient, 0);
		}

		new_color /= 4;

		// Red: 
		current_image->operator()(x, y, 0) = (double)(new_color.x);
		// Green: 
		current_image->operator()(x, y, 1) = (double)(new_color.y);
		// Blue: 
		current_image->operator()(x, y, 2) = (double)(new_color.z);
	}
}

void RayTracer::render(int frame) {
  current_image = images[frame];
  curr_frame = frame;

  std::cout << "Calling RayTracer::render(\n" <<
		  "\t" << *root <<
          "\t" << "Image(width:" << current_image->width() << ", height:" << current_image->height() << ")\n"
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
	matrix_stack.empty();
	matrix_stack.push(glm::mat4(1.0f));
	// shallow copy root node
	root_flattened = new SceneNode(root_orig->m_name);
	root_flattened->m_nodeType = root_orig->m_nodeType;
	root_flattened->m_name = root_orig->m_name;
	root_flattened->trans = root_orig->trans;
	root_flattened->invtrans = root_orig->invtrans;

	root = flattenScene(root_flattened, root_orig);

	RayTracerWorker *workers[num_workers];
	thread threads[num_workers];
	for (int i = 0; i < num_workers; ++i) {
		workers[i] = new RayTracerWorker(i, this);
		threads[i] = thread(&RayTracerWorker::launch, workers[i]);
	}
	
	for (int i = 0; i < num_workers; ++i) {
		threads[i].join();
	}

	if (tolarance < 1) {
		detectVariation();
	}
}
