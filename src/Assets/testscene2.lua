rootnode = gr.node('root')

brown = gr.phong_material({146/255, 141/255, 132/255}, {0.1, 0.1, 0.1}, 10)

pillar_bottom_cylinder = gr.cylinder('pillar_bottom_cylinder')
pillar_bottom_cylinder:set_material(brown)
pillar_bottom_cylinder:scale(5, 5, 5)
rootnode:add_child(pillar_bottom_cylinder)

pillar_middle_torus = gr.torus('pillar_middle_torus', 0.3)
pillar_middle_torus:set_material(brown)
pillar_middle_torus:scale(5, 5, 5)
pillar_middle_torus:translate(0, 8, 0)
rootnode:add_child(pillar_middle_torus)

white_light = gr.light({0, 0, 20}, {0.9, 0.9, 0.9}, {1, 0, 0})

gr.render(rootnode, './Generated/testscene2.png', 20, 20,
{0, 6, 15}, {0, 0, -1}, {0, 1, 0}, 50,
	  {0.3, 0.3, 0.3}, {white_light})