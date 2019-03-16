-- A simple scene with five spheres

mat1 = gr.material({0.7, 1.0, 0.7}, {0.5, 0.7, 0.5}, 25)
mat2 = gr.material({0.5, 0.5, 0.5}, {0.5, 0.7, 0.5}, 25)
mat3 = gr.material({1.0, 0.6, 0.1}, {0.5, 0.7, 0.5}, 25)

scene_root = gr.node('root')

s1 = gr.nh_sphere('s1', {0, 0, 0}, 1)
--s1 = gr.sphere('s1')
scene_root:add_child(s1)
s1:set_material(mat1)
-- s1:scale(2, 1, 1)
-- s1:translate(0.1, 0.05, 0)
-- s1:rotate('z', 45.0)

n1 = gr.node('n1')
n1:translate(0.1, -0.1, 0.0)
scene_root:add_child(n1)

s2 = gr.sphere('s2')
n1:add_child(s2)
s2:set_material(mat2)

s3 = gr.nh_sphere('s3', {0, -0.5, 0}, 1)
scene_root:add_child(s3)
s3:set_material(mat3)

white_light = gr.light({-100.0, 150.0, 400.0}, {0.9, 0.9, 0.9}, {1, 0, 0})
magenta_light = gr.light({400.0, 100.0, 150.0}, {0.7, 0.0, 0.7}, {1, 0, 0})

gr.render(scene_root, './Generated/simple-hier.png', 512, 512, --216,
{0, 0, 10}, {0, 0, -1}, {0, 1, 0}, 50,
	  {0.3, 0.3, 0.3}, {white_light})