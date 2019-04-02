mat1 = gr.phong_material({0.7, 1.0, 0.7}, {0.5, 0.7, 0.5}, 25)
mat2 = gr.phong_material({0.5, 0.5, 0.5}, {0.5, 0.7, 0.5}, 25)
mat3 = gr.phong_material({1.0, 0.6, 0.1}, {0.5, 0.7, 0.5}, 25)
mat4 = gr.phong_material({0.9, 0.4, 0.6}, {0.5, 0.7, 0.5}, 25)

mat1_r = gr.reflective_material({0.7, 1.0, 0.7}, 0.3, 0)
mat2_r = gr.reflective_material({0.5, 0.5, 0.5}, 0.3, 0)
mat3_r = gr.reflective_material({1.0, 0.6, 0.1}, 0.3, 0)
mat4_r = gr.reflective_material({0.9, 0.4, 0.6}, 0.3, 0)

mat1_ra = gr.refractive_material({0.7, 1.0, 0.7}, 1.3, 0)
mat2_ra = gr.refractive_material({0.5, 0.5, 0.5}, 1.3, 0)
mat3_ra = gr.refractive_material({1.0, 0.6, 0.1}, 1.3, 0)
mat3_ra_g = gr.refractive_material({1.0, 0.6, 0.1}, 1.3, 0.3)
mat4_ra = gr.refractive_material({0.9, 0.4, 0.6}, 1.3, 0)

scene_root = gr.node('root')

b1 = gr.nh_box('b1', {-10, -22, -12}, 20)
scene_root:add_child(b1)
b1:set_material(mat2_r)

s1 = gr.sphere('s1')
--scene_root:add_child(s1)
s1:set_material(mat1_r)
s1:scale(2, 1, 1)
s1:rotate('z', 45.0)

n1 = gr.node('n1')
n1:translate(1.5, -0.5, 1)
scene_root:add_child(n1)

s2 = gr.sphere('s2')
n1:add_child(s2)
s2:set_material(mat2_r)
s2:scale(2, 1, 1)
s2:rotate('z', 45.0)

n2 = gr.node('n2')
n2:translate(-5, -1, 0)
n1:add_child(n2)

b2 = gr.cube('b2')
n2:add_child(b2)
b2:set_material(mat3_r)
b2:scale(2, 1, 2)

s3 = gr.nh_sphere('s3', {2.5, -1, 3}, 1)
scene_root:add_child(s3)
s3:set_material(mat3_r)

c1 = gr.cylinder('c1')
scene_root:add_child(c1)
c1:set_material(mat1_r)
c1:scale(1, 3, 1)
c1:translate(-1, -2, 0)
--c1:rotate('z', 45.0)

t1 = gr.torus('t1', 0.5)
scene_root:add_child(t1)
t1:set_material(mat4_r)
t1:translate(0, -1.6, 3)

s4 = gr.sphere('s4')
s4:scale(2, 2, 2)
s4:translate(0, 0, 5)
scene_root:add_child(s4)
s4:set_material(mat3_ra_g)

white_light = gr.light({-3, 3, 7}, {0.9, 0.9, 0.9}, {1, 0, 0})
magenta_light = gr.light({400.0, 100.0, 150.0}, {0.7, 0.0, 0.7}, {1, 0, 0})
white_area_light = gr.area_light({0, 10, 0}, {0.9, 0.9, 0.9}, {1, 0, 0},  {0, -1, 0}, {0, 0, -1}, 2, 100)


gr.render(scene_root, './Generated/simple-hier/', 512, 512, --216,
{0, 0, 15}, {0, 0, -1}, {0, 1, 0}, 50,
	  {0.3, 0.3, 0.3}, {white_light}, 1, 1)