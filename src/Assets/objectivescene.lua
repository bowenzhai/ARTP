grey = gr.phong_material({0.5, 0.5, 0.5}, {0.5, 0.7, 0.5}, 25)
green = gr.phong_material({0.7, 1.0, 0.7}, {0.5, 0.7, 0.5}, 25)
orange = gr.phong_material({1.0, 0.6, 0.1}, {0.5, 0.7, 0.5}, 25)
pink = gr.phong_material({0.9, 0.4, 0.6}, {0.5, 0.7, 0.5}, 25)

grey_r = gr.reflective_material({0.7, 1.0, 0.7}, 0.3, 0)
green_r = gr.reflective_material({0.5, 0.5, 0.5}, 0.3, 0)
orange_r = gr.reflective_material({1.0, 0.6, 0.1}, 0.3, 0)
orange_r_g = gr.reflective_material({1.0, 0.6, 0.1}, 0.3, 0.5)
pink_r = gr.reflective_material({0.9, 0.4, 0.6}, 0.3, 0)

grey_ra = gr.refractive_material({0.7, 1.0, 0.7}, 1.3, 0)
green_ra = gr.refractive_material({0.5, 0.5, 0.5}, 1.3, 0)
orange_ra = gr.refractive_material({1.0, 0.6, 0.1}, 1.3, 0)
pink_ra = gr.refractive_material({0.9, 0.4, 0.6}, 1.3, 0)

rootnode = gr.node('root')

-- floor
floor = gr.cube('floor')
floor:translate(-0.5, -0.5, -0.5)
floor:set_material(grey)
floor:scale(20, 1, 20)
rootnode:add_child(floor)

--walls

wall1 = gr.cube('wall1')
wall1:set_material(green)
wall1:translate(-0.5, -0.5, -0.5)
wall1:scale(1, 10, 10)
wall1:translate(-5, 5, 0)
rootnode:add_child(wall1)

wall2 = gr.cube('wall2')
wall2:set_material(orange)
wall2:translate(-0.5, -0.5, -0.5)
wall2:scale(1, 10, 10)
wall2:translate(5, 5, 0)
rootnode:add_child(wall2)

wall3 = gr.cube('wall3')
wall3:set_material(pink)
wall3:translate(-0.5, -0.5, -0.5)
wall3:scale(10, 10, 1)
wall3:translate(0, 5, -5)
rootnode:add_child(wall3)

s2 = gr.sphere('s2')
s2:set_material(orange_ra)
s2:scale(2, 2, 2)
s2:translate(0, 5, 10)
rootnode:add_child(s2)

white_light = gr.light({3, 5, 15}, {0.8, 0.8, 0.8}, {1, 0, 0})
magenta_light = gr.light({400.0, 100.0, 150.0}, {0.7, 0.0, 0.7}, {1, 0, 0})
white_area_light = gr.area_light({0, 10, 0}, {0.9, 0.9, 0.9}, {1, 0, 0},  {0, -1, 0}, {0, 0, -1}, 2, 100)


gr.render(rootnode, './Generated/objectivescene/', 512, 512, --216,
{0, 5, 20}, {0, 0, -1}, {0, 1, 0}, 50,
	  {0.3, 0.3, 0.3}, {white_light}, 1, 1)