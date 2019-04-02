#include <iostream>
#include <glm/ext.hpp>
#include <lodepng/lodepng.h>

#include "TexturedMaterial.hpp"

using namespace std;
using namespace glm;

TexturedMaterial::TexturedMaterial(
	const std::string src, const glm::vec3& ks, double shininess, const glm::vec2 &tile)
	: m_src(src)
	, m_ks(ks)
	, m_shininess(shininess)
    , m_tile(tile)
{
	m_materialType = MaterialType::TexturedMaterial;
    loadData();
    getTexturePixel(0, 0);
}

TexturedMaterial::~TexturedMaterial()
{}

void TexturedMaterial::loadData() {
    lodepng::decode(m_data, w, h, m_src, LCT_RGB);
}

vec3 TexturedMaterial::getTexturePixel(int x, int y) {
    vec3 pixel;
    pixel.x = (float)((uint)m_data[3 * (w * y + x) + 0]) / 255.0f;
    pixel.y = (float)((uint)m_data[3 * (w * y + x) + 1]) / 255.0f;
    pixel.z = (float)((uint)m_data[3 * (w * y + x) + 2]) / 255.0f;
    //cout << glm::to_string(pixel) << endl;
    return pixel;
}

vec3 TexturedMaterial::getMaterialColor(float u, float v) {
    vec3 color;
    float d_i = (w - 1) * u;
    float d_j = (h - 1) * v;
    int i = d_i;
    int j = d_j;
    float u_p = d_i - i;
    float v_p = d_j - j;
    color = getTexturePixel(i, j) * (1 - u_p) * (1 - v_p) + 
            getTexturePixel(i, j+1) * (1 - u_p) * v_p + 
            getTexturePixel(i+1, j) * u_p * (1 - v_p) + 
            getTexturePixel(i+1, j+1) * u_p * v_p;
    //cout << glm::to_string(color) << endl;
    return color;
}
