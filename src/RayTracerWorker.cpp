#include "RayTracerWorker.hpp"

using namespace std;

using namespace glm;

void RayTracerWorker::launch() {
    size_t h = parent->image.height();
	size_t w = parent->image.width();

    // divide img to col * col squares
    int cols = ceil(sqrt(parent->num_workers));

    // extra pixels
    int h_extra = h % cols;
    int w_extra = w % cols;
    h = h - h_extra;
    w = w - w_extra;

    // the start pixel of each square rounded down
    int h_index[cols];
    int w_index[cols];
    for (int i = 0; i < cols; ++i) {
        h_index[i] = h * ((float)i / (float)cols);
        w_index[i] = w * ((float)i / (float)cols);
    }

    // which square to render
    int row_curr = workerId / cols;
    int col_curr = workerId % cols;

    // square dimentions rounded down
    int pix_per_block_h = h / cols;
    int pix_per_block_w = w / cols;

    // start and end pixel
    int start_h = h_index[row_curr];
    int end_h = start_h + pix_per_block_h;
    int start_w = w_index[col_curr];
    int end_w = start_w + pix_per_block_w;

    // render exta pixels if last row/col
    if (row_curr == cols - 1) {
        end_h += h_extra;
    }
    if (col_curr == cols - 1) {
        end_w += w_extra;
    }

    // cout << "worker " << workerId << endl;
    // cout << start_h <<  " " << end_h << endl;
    // cout << start_w <<  " " << end_w << endl;

	for (uint y = start_h; y < end_h; ++y) {
		for (uint x = start_w; x < end_w; ++x) {
			// generate the ray
			vec3 pixel = {x, y, 0.0f};
			parent->transformToWorld(pixel);
			vec3 dir = pixel - parent->eye;
			dir = glm::normalize(dir);
			Ray ray = Ray(parent->eye, dir, x, y);
			//cout << ray << endl;

			vec3 color;
			color = ray.getColor(parent->root, parent->lights, parent->ambient, 0);

			// Red: 
			parent->image(x, y, 0) = (double)(color.x);
			// Green: 
			parent->image(x, y, 1) = (double)(color.y);
			// Blue: 
			parent->image(x, y, 2) = (double)(color.z);

			++progress;
		}
	}

    cout << "worker " << workerId << " finished" << endl;
}