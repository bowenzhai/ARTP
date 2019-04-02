rootnode = gr.node('root')
rootnode:rotate('y', 20)

grey = gr.phong_material({0.15, 0.18, 0.25}, {0.1, 0.1, 0.1}, 10)
blue = gr.phong_material({0.25, 0.95, 0.95}, {0.1, 0.1, 0.1}, 10)
yellow = gr.phong_material({255/255, 200/255, 110/255}, {0.1, 0.1, 0.1}, 10)
red = gr.phong_material({200/255, 50/255, 30/255}, {0.1, 0.1, 0.1}, 10)
orange = gr.phong_material({220/255, 140/255, 0/255}, {0.1, 0.1, 0.1}, 10)
green = gr.phong_material({100/255, 220/255, 0/255}, {0.1, 0.1, 0.1}, 10)
dark_green = gr.phong_material({50/255, 100/255, 0/255}, {0.1, 0.1, 0.1}, 10)
black = gr.phong_material({40/255, 40/255, 40/255}, {0.1, 0.1, 0.1}, 10)

grey_r = gr.reflective_material({0.15, 0.18, 0.25}, 0.1, 0)
blue_r = gr.reflective_material({0.25, 0.95, 0.95}, 0.5, 0)

blue_ra = gr.refractive_material({0.25, 0.95, 0.95}, 1.0, 0)
transparent = gr.refractive_material({120/255, 120/255, 140/255}, 1.3, 0)

awesome = gr.textured_material('./Assets/Textures/awesomeface.png', {0.1, 0.1, 0.1}, 10, {1, 1})
factory_iron = gr.textured_material('./Assets/Textures/factory_iron.png', {0.1, 0.1, 0.1}, 10, {1, 1})
tunnel_ciel = gr.textured_material('./Assets/Textures/tunnel_ciel.png', {0.1, 0.1, 0.1}, 10, {4, 4})
tunnel_ciel2 = gr.textured_material('./Assets/Textures/tunnel_ciel.png', {0.1, 0.1, 0.1}, 10, {1, 1})
build_iron = gr.textured_material('./Assets/Textures/build_iron.png', {0.1, 0.1, 0.1}, 10, {4, 1})
metal_bridge = gr.textured_material('./Assets/Textures/metal_bridge.png', {0.1, 0.1, 0.1}, 10, {1, 1})
dark_metal = gr.textured_material('./Assets/Textures/dark_metal.png', {0.1, 0.1, 0.1}, 10, {1, 5})
factory_window = gr.textured_material('./Assets/Textures/factory_window.png', {0.1, 0.1, 0.1}, 10, {1, 1})

-- floor
floor = gr.cube('floor')
floor:translate(-0.5, -0.5, -0.5)
floor:set_material(tunnel_ciel)
floor:scale(100, 1, 100)
rootnode:add_child(floor)

light_ground_1 = gr.cylinder('light_ground_1')
light_ground_1:set_material(yellow)
light_ground_1:scale(0.7, 50, 0.7)
light_ground_1:rotate('x', 90)
rootnode:add_child(light_ground_1)

light_ground_2 = gr.cylinder('light_ground_2')
light_ground_2:set_material(yellow)
light_ground_2:scale(0.7, 50, 0.7)
light_ground_2:rotate('x', -90)
rootnode:add_child(light_ground_2)

light_ground_3 = gr.cylinder('light_ground_3')
light_ground_3:set_material(yellow)
light_ground_3:scale(0.7, 50, 0.7)
light_ground_3:rotate('z', 90)
rootnode:add_child(light_ground_3)

light_ground_4 = gr.cylinder('light_ground_4')
light_ground_4:set_material(yellow)
light_ground_4:scale(0.7, 50, 0.7)
light_ground_4:rotate('z', -90)
rootnode:add_child(light_ground_4)

--walls
wall1 = gr.cube('wall1')
wall1:set_material(factory_iron)
wall1:translate(-0.5, -0.5, -0.5)
wall1:scale(1, 50, 100)
wall1:translate(-50, 25, 0)
rootnode:add_child(wall1)

wall2 = gr.cube('wall2')
wall2:set_material(factory_iron)
wall2:translate(-0.5, -0.5, -0.5)
wall2:scale(1, 50, 100)
wall2:translate(50, 25, 0)
rootnode:add_child(wall2)

wall3 = gr.cube('wall3')
wall3:set_material(factory_iron)
wall3:translate(-0.5, -0.5, -0.5)
wall3:scale(100, 50, 1)
wall3:translate(0, 25, -50)
rootnode:add_child(wall3)

wall4 = gr.cube('wall4')
wall4:set_material(factory_iron)
wall4:translate(-0.5, -0.5, -0.5)
wall4:scale(100, 50, 1)
wall4:translate(0, 25, 50)
rootnode:add_child(wall4)

--cieling
cieling = gr.cube('cieling')
cieling:translate(-0.5, -0.5, -0.5)
cieling:set_material(factory_window)
cieling:scale(100, 1, 100)
cieling:translate(0, 50, 0)
rootnode:add_child(cieling)

--center pillar
pillar_bottom_torus = gr.torus('pillar_bottom_torus', 0.2)
pillar_bottom_torus:set_material(factory_window)
pillar_bottom_torus:scale(10, 10, 10)
pillar_bottom_torus:translate(0, 1, 0)
rootnode:add_child(pillar_bottom_torus)

pillar_bottom_cylinder = gr.cylinder('pillar_bottom_cylinder')
pillar_bottom_cylinder:set_material(build_iron)
pillar_bottom_cylinder:scale(8, 10, 8)
rootnode:add_child(pillar_bottom_cylinder)

pillar_middle_torus = gr.torus('pillar_middle_torus', 0.2)
pillar_middle_torus:set_material(factory_window)
pillar_middle_torus:scale(10, 10, 10)
pillar_middle_torus:translate(0, 12, 0)
rootnode:add_child(pillar_middle_torus)

pillar_middle_cylinder = gr.cylinder('pillar_middle_cylinder')
pillar_middle_cylinder:set_material(build_iron)
pillar_middle_cylinder:scale(10, 2, 10)
pillar_middle_cylinder:translate(0, 14, 0)
rootnode:add_child(pillar_middle_cylinder)

pillar_middle_torus_light = gr.torus('pillar_middle_torus_light', 0.1)
pillar_middle_torus_light:set_material(yellow)
pillar_middle_torus_light:scale(10, 3, 10)
pillar_middle_torus_light:translate(0, 15, 0)
rootnode:add_child(pillar_middle_torus_light)

pillar_middle_cylinder_glass = gr.cylinder('pillar_middle_cylinder_glass')
pillar_middle_cylinder_glass:set_material(blue_ra)
pillar_middle_cylinder_glass:scale(12, 20, 12)
pillar_middle_cylinder_glass:translate(0, 16, 0)
rootnode:add_child(pillar_middle_cylinder_glass)

pillar_top_torus = gr.torus('pillar_top_torus', 0.2)
pillar_top_torus:set_material(factory_window)
pillar_top_torus:scale(10, 10, 10)
pillar_top_torus:translate(0, 40, 0)
rootnode:add_child(pillar_top_torus)

pillar_top_cylinder = gr.cylinder('pillar_top_cylinder')
pillar_top_cylinder:set_material(build_iron)
pillar_top_cylinder:scale(10, 2, 10)
pillar_top_cylinder:translate(0, 36, 0)
rootnode:add_child(pillar_top_cylinder)

pillar_top_torus_light = gr.torus('pillar_top_torus_light', 0.2)
pillar_top_torus_light:set_material(yellow)
pillar_top_torus_light:scale(10, 3, 10)
pillar_top_torus_light:translate(0, 37, 0)
rootnode:add_child(pillar_top_torus_light)

--surrounding pillars
pillar_surrounding_1 = gr.cylinder('pillar_surrounding_1')
pillar_surrounding_1:set_material(tunnel_ciel2)
pillar_surrounding_1:scale(1.2, 52, 1.2)
pillar_surrounding_1:translate(10, 0, 10)
rootnode:add_child(pillar_surrounding_1)

pillar_surrounding_2 = gr.cylinder('pillar_surrounding_2')
pillar_surrounding_2:set_material(tunnel_ciel2)
pillar_surrounding_2:scale(1.2, 52, 1.2)
pillar_surrounding_2:translate(10, 0, -10)
rootnode:add_child(pillar_surrounding_2)

pillar_surrounding_3 = gr.cylinder('pillar_surrounding_3')
pillar_surrounding_3:set_material(tunnel_ciel2)
pillar_surrounding_3:scale(1.2, 52, 1.2)
pillar_surrounding_3:translate(-10, 0, 10)
rootnode:add_child(pillar_surrounding_3)

pillar_surrounding_4 = gr.cylinder('pillar_surrounding_4')
pillar_surrounding_4:set_material(tunnel_ciel2)
pillar_surrounding_4:scale(1.2, 52, 1.2)
pillar_surrounding_4:translate(-10, 0, -10)
rootnode:add_child(pillar_surrounding_4)

--secondary pillars
pillar_secondary_1 = gr.cylinder('pillar_secondary_1')
pillar_secondary_1:set_material(metal_bridge)
pillar_secondary_1:scale(5, 25, 5)
pillar_secondary_1:translate(25, 0, 25)
rootnode:add_child(pillar_secondary_1)

pillar_secondary_torus_light_1 = gr.torus('pillar_secondary_torus_light_1', 0.1)
pillar_secondary_torus_light_1:set_material(yellow)
pillar_secondary_torus_light_1:scale(7, 7, 7)
pillar_secondary_torus_light_1:translate(25, 0, 25)
rootnode:add_child(pillar_secondary_torus_light_1)

pillar_secondary_2 = gr.cylinder('pillar_secondary_2')
pillar_secondary_2:set_material(metal_bridge)
pillar_secondary_2:scale(5, 25, 5)
pillar_secondary_2:translate(25, 0, -25)
rootnode:add_child(pillar_secondary_2)

pillar_secondary_torus_light_2 = gr.torus('pillar_secondary_torus_light_2', 0.1)
pillar_secondary_torus_light_2:set_material(yellow)
pillar_secondary_torus_light_2:scale(7, 7, 7)
pillar_secondary_torus_light_2:translate(25, 0, -25)
rootnode:add_child(pillar_secondary_torus_light_2)

pillar_secondary_3 = gr.cylinder('pillar_secondary_3')
pillar_secondary_3:set_material(metal_bridge)
pillar_secondary_3:scale(5, 25, 5)
pillar_secondary_3:translate(-25, 0, 25)
rootnode:add_child(pillar_secondary_3)

pillar_secondary_torus_light_3 = gr.torus('pillar_secondary_torus_light_3', 0.1)
pillar_secondary_torus_light_3:set_material(yellow)
pillar_secondary_torus_light_3:scale(7, 7, 7)
pillar_secondary_torus_light_3:translate(-25, 0, 25)
rootnode:add_child(pillar_secondary_torus_light_3)

pillar_secondary_4 = gr.cylinder('pillar_secondary_4')
pillar_secondary_4:set_material(metal_bridge)
pillar_secondary_4:scale(5, 25, 5)
pillar_secondary_4:translate(-25, 0, -25)
rootnode:add_child(pillar_secondary_4)

pillar_secondary_torus_light_4 = gr.torus('pillar_secondary_torus_light_4', 0.1)
pillar_secondary_torus_light_4:set_material(yellow)
pillar_secondary_torus_light_4:scale(7, 7, 7)
pillar_secondary_torus_light_4:translate(-25, 0, -25)
rootnode:add_child(pillar_secondary_torus_light_4)

--tubes
tube_1 = gr.cylinder('tube_1')
tube_1:set_material(transparent)
tube_1:scale(1, 50, 1)
tube_1:rotate('x', 90)
tube_1:translate(-25, 30, -25)
rootnode:add_child(tube_1)

tube_2 = gr.cylinder('tube_2')
tube_2:set_material(transparent)
tube_2:scale(1, 50, 1)
tube_2:rotate('x', 90)
tube_2:translate(25, 30, -25)
rootnode:add_child(tube_2)

tube_3 = gr.cylinder('tube_3')
tube_3:set_material(transparent)
tube_3:scale(1, 50, 1)
tube_3:rotate('z', 90)
tube_3:translate(25, 30, -25)
rootnode:add_child(tube_3)

tube_4 = gr.cylinder('tube_4')
tube_4:set_material(transparent)
tube_4:scale(1, 12.5, 1)
tube_4:rotate('z', 90)
tube_4:translate(25, 30, 0)
rootnode:add_child(tube_4)

tube_5 = gr.cylinder('tube_5')
tube_5:set_material(transparent)
tube_5:scale(1, 30, 1)
tube_5:translate(25, 0, 25)
rootnode:add_child(tube_5)

tube_6 = gr.cylinder('tube_6')
tube_6:set_material(transparent)
tube_6:scale(1, 30, 1)
tube_6:translate(25, 0, -25)
rootnode:add_child(tube_6)

tube_7 = gr.cylinder('tube_7')
tube_7:set_material(transparent)
tube_7:scale(1, 50, 1)
tube_7:translate(-25, 0, 25)
rootnode:add_child(tube_7)

tube_8 = gr.cylinder('tube_8')
tube_8:set_material(transparent)
tube_8:scale(1, 30, 1)
tube_8:translate(-25, 0, -25)
rootnode:add_child(tube_8)

--[[dark samus begin]]
darksamus = gr.node('darksamus')
darksamus:rotate('y', -20)
darksamus:rotate('x', 10)
darksamus:translate(15, 7, 7)
rootnode:add_child(darksamus)

-- body
torso_joint = gr.joint('torso_joint', {-45, 0, 45}, {-45, 0, 45})
darksamus:add_child(torso_joint)

torso = gr.sphere('torso')
torso:scale(1.2, 1.0, 0.8)
torso:set_material(grey)
torso_joint:add_child(torso)

shoulder_joint_pre = gr.node('shoulder_joint_pre')
shoulder_joint_pre:translate(0.0, 0.5, 0.0)
torso_joint:add_child(shoulder_joint_pre)

shoulder_joint = gr.joint('shoulder_joint', {-45, 0, 45}, {-45, 0, 45})
shoulder_joint_pre:add_child(shoulder_joint)

shoulder = gr.sphere('shoulder')
shoulder:scale(1.5, 1.0, 1.0)
shoulder:set_material(grey)
shoulder_joint:add_child(shoulder)

chest_1 = gr.sphere('chest_1')
chest_1:scale(0.5, 0.2, 0.4)
chest_1:translate(-0.35, -0.3, 0.7)
chest_1:rotate('z', -30.0)
chest_1:set_material(blue)
shoulder_joint:add_child(chest_1)

chest_2 = gr.sphere('chest_2')
chest_2:scale(0.5, 0.2, 0.4)
chest_2:translate(0.35, -0.3, 0.7)
chest_2:rotate('z', 30.0)
chest_2:set_material(blue)
shoulder_joint:add_child(chest_2)

hip_joint_pre = gr.node('hip_joint_pre')
hip_joint_pre:translate(0.0, -0.5, 0.0)
torso_joint:add_child(hip_joint_pre)

hip_joint = gr.joint('hip_joint', {-45, 0, 45}, {-45, 0, 45})
hip_joint_pre:add_child(hip_joint)

hip = gr.sphere('hip')
hip:scale(0.8, 1.5, 0.8)
hip:set_material(grey)
hip_joint:add_child(hip)

-- head
neck_joint_pre = gr.node('neck_joint_pre')
neck_joint_pre:translate(0.0, 0.8, 0.5)
shoulder_joint:add_child(neck_joint_pre)

neck_joint = gr.joint('neck_joint', {-45, 0, 45}, {-45, 0, 45})
neck_joint_pre:add_child(neck_joint)

neck = gr.sphere('neck')
neck:scale(0.5, 0.1, 0.5)
neck:rotate('x', 30.0)
neck:set_material(grey)
neck_joint:add_child(neck)

head_joint_pre = gr.node('head_joint_pre')
head_joint_pre:translate(0.0, 0.6, 0.0)
neck_joint:add_child(head_joint_pre)

head_joint = gr.joint('head_joint', {-45, 0, 45}, {-45, 0, 45})
head_joint_pre:add_child(head_joint)

head = gr.sphere('head')
head:scale(0.6, 0.7, 0.6)
head:rotate('x', -20)
head:set_material(grey)
head_joint:add_child(head)

visor_1 = gr.cube('visor_1')
visor_1:translate(-0.5, -0.5, -0.5)
visor_1:scale(0.3, 0.1, 0.3)
visor_1:translate(-0.05, -0.15, 0.5)
visor_1:rotate('x', 15.0)
visor_1:rotate('z', -20.0)
visor_1:set_material(blue)
head_joint:add_child(visor_1)

visor_2 = gr.cube('visor_2')
visor_2:translate(-0.5, -0.5, -0.5)
visor_2:scale(0.3, 0.1, 0.3)
visor_2:translate(0.05, -0.15, 0.5)
visor_2:rotate('x', 15.0)
visor_2:rotate('z', 20.0)
visor_2:set_material(blue)
head_joint:add_child(visor_2)

visor_3 = gr.cube('visor_3')
visor_3:translate(-0.5, -0.5, -0.5)
visor_3:scale(0.5, 0.08, 0.3)
visor_3:translate(-0.35, -0.0, 0.5)
visor_3:rotate('y', -20)
visor_3:rotate('z', 90.0)
visor_3:set_material(blue)
head_joint:add_child(visor_3)

-- leg joints
left_leg_joint_pre = gr.node('left_leg_joint_pre')
left_leg_joint_pre:translate(0.5, -1.0, 0.0)
hip_joint:add_child(left_leg_joint_pre)

left_leg_joint = gr.joint('left_leg_joint', {-45, 0, 45}, {-45, 0, 45})
left_leg_joint_pre:add_child(left_leg_joint)

left_leg_top = gr.sphere('left_leg_top')
left_leg_top:set_material(grey)
left_leg_top:scale(0.2, 0.7, 0.8)
left_leg_top:rotate('z', -40.0)
left_leg_joint:add_child(left_leg_top)

right_leg_joint_pre = gr.node('right_leg_joint_pre')
right_leg_joint_pre:translate(-0.5, -1.0, 0.0)
hip_joint:add_child(right_leg_joint_pre)

right_leg_joint = gr.joint('right_leg_joint', {-45, 0, 45}, {-45, 0, 45})
right_leg_joint_pre:add_child(right_leg_joint)

right_leg_top = gr.sphere('right_leg_top')
right_leg_top:set_material(grey)
right_leg_top:scale(0.2, 0.7, 0.8)
right_leg_top:rotate('z', 40.0)
right_leg_joint:add_child(right_leg_top)

-- legs
left_leg_thigh = gr.sphere('left_leg_thigh')
left_leg_thigh:set_material(grey)
left_leg_thigh:scale(0.5, 1.5, 0.5)
left_leg_thigh:translate(0.1, -1.0, 0.0)
left_leg_joint:add_child(left_leg_thigh)

left_leg_thigh_side = gr.sphere('left_leg_thigh_side')
left_leg_thigh_side:set_material(blue)
left_leg_thigh_side:scale(0.1, 0.8, 0.2)
left_leg_thigh_side:translate(0.5, -1.0, 0.0)
left_leg_joint:add_child(left_leg_thigh_side)

right_leg_thigh = gr.sphere('right_leg_thigh')
right_leg_thigh:set_material(grey)
right_leg_thigh:scale(0.5, 1.5, 0.5)
right_leg_thigh:translate(-0.1, -1.0, 0.0)
right_leg_joint:add_child(right_leg_thigh)

right_leg_thigh_side = gr.sphere('right_leg_thigh_side')
right_leg_thigh_side:set_material(blue)
right_leg_thigh_side:scale(0.1, 0.8, 0.2)
right_leg_thigh_side:translate(-0.5, -1.0, 0.0)
right_leg_joint:add_child(right_leg_thigh_side)

left_knee_joint_pre = gr.node('left_knee_joint_pre')
left_knee_joint_pre:translate(0.1, -2.3, 0.0)
left_leg_joint:add_child(left_knee_joint_pre)

left_knee_joint = gr.joint('left_knee_joint', {-45, 0, 45}, {-45, 0, 45})
left_knee_joint_pre:add_child(left_knee_joint)

left_leg_lower = gr.sphere('left_leg_lower')
left_leg_lower:set_material(grey)
left_leg_lower:scale(0.4, 1.2, 0.4)
left_leg_lower:translate(0, -0.5, 0)
left_knee_joint:add_child(left_leg_lower)

left_leg_lower_side = gr.sphere('left_leg_lower_side')
left_leg_lower_side:set_material(blue)
left_leg_lower_side:scale(0.1, 0.6, 0.1)
left_leg_lower_side:translate(0.33, -0.5, 0.0)
left_knee_joint:add_child(left_leg_lower_side)

left_kneecap = gr.sphere('left_kneecap')
left_kneecap:set_material(grey)
left_kneecap:scale(0.3, 0.7, 0.1)
left_kneecap:rotate('x', 50.0)
left_kneecap:translate(0.0, 0.2, 0.2)
left_knee_joint:add_child(left_kneecap)

left_ankle_joint_pre = gr.node('left_ankle_joint_pre')
left_ankle_joint_pre:translate(0.08, -0.5, 0.0)
left_knee_joint:add_child(left_ankle_joint_pre)

left_ankle_joint = gr.joint('left_ankle_joint', {-45, 0, 45}, {-45, 0, 45})
left_ankle_joint_pre:add_child(left_ankle_joint)

left_foot = gr.sphere('left_foot')
left_foot:set_material(grey)
left_foot:scale(0.3, 0.7, 0.2)
left_foot:rotate('x', 100.0)
left_foot:translate(0.0, -1.1, 0.4)
left_ankle_joint:add_child(left_foot)

right_knee_joint_pre = gr.node('right_knee_joint_pre')
right_knee_joint_pre:translate(-0.1, -2.3, 0.0)
right_leg_joint:add_child(right_knee_joint_pre)

right_knee_joint = gr.joint('right_knee_joint', {-45, 0, 45}, {-45, 0, 45})
right_knee_joint_pre:add_child(right_knee_joint)

right_leg_lower = gr.sphere('right_leg_lower')
right_leg_lower:set_material(grey)
right_leg_lower:scale(0.4, 1.2, 0.4)
right_leg_lower:translate(0, -0.5, 0)
right_knee_joint:add_child(right_leg_lower)

right_leg_lower_side = gr.sphere('right_leg_lower_side')
right_leg_lower_side:set_material(blue)
right_leg_lower_side:scale(0.1, 0.6, 0.1)
right_leg_lower_side:translate(-0.33, -0.5, 0.0)
right_knee_joint:add_child(right_leg_lower_side)

right_ankle_joint_pre = gr.node('right_ankle_joint_pre')
right_ankle_joint_pre:translate(-0.08, -0.5, 0.0)
right_knee_joint:add_child(right_ankle_joint_pre)

right_kneecap = gr.sphere('right_kneecap')
right_kneecap:set_material(grey)
right_kneecap:scale(0.3, 0.7, 0.1)
right_kneecap:rotate('x', 50.0)
right_kneecap:translate(0.0, 0.2, 0.2)
right_knee_joint:add_child(right_kneecap)

right_ankle_joint = gr.joint('right_ankle_joint', {-45, 0, 45}, {-45, 0, 45})
right_ankle_joint_pre:add_child(right_ankle_joint)

right_foot = gr.sphere('right_foot')
right_foot:set_material(grey)
right_foot:scale(0.3, 0.7, 0.2)
right_foot:rotate('x', 100.0)
right_foot:translate(0.0, -1.1, 0.4)
right_ankle_joint:add_child(right_foot)

-- shoulder pad
left_arm_joint_pre = gr.node('left_arm_joint_pre')
left_arm_joint_pre:translate(1.5, 0.2, 0.0)
shoulder_joint:add_child(left_arm_joint_pre)

left_arm_joint = gr.joint('left_arm_joint', {-45, 0, 45}, {-45, 0, 45})
left_arm_joint_pre:add_child(left_arm_joint)

left_arm_pad = gr.sphere('left_arm_pad')
left_arm_pad:set_material(grey)
left_arm_pad:scale(0.8, 0.8, 0.8)
left_arm_joint:add_child(left_arm_pad)

left_arm_dot = gr.sphere('left_arm_dot')
left_arm_dot:set_material(blue)
left_arm_dot:scale(0.1, 0.1, 0.1)
left_arm_dot:translate(0.0, -0.2, 0.77)
left_arm_joint:add_child(left_arm_dot)

right_arm_joint_pre = gr.node('right_arm_joint_pre')
right_arm_joint_pre:translate(-1.5, 0.2, 0.0)
shoulder_joint:add_child(right_arm_joint_pre)

right_arm_joint = gr.joint('right_arm_joint', {-45, 0, 45}, {-45, 0, 45})
right_arm_joint_pre:add_child(right_arm_joint)

right_arm_pad = gr.sphere('right_arm_pad')
right_arm_pad:set_material(grey)
right_arm_pad:scale(0.8, 0.8, 0.8)
right_arm_joint:add_child(right_arm_pad)

right_arm_dot = gr.sphere('right_arm_dot')
right_arm_dot:set_material(blue)
right_arm_dot:scale(0.1, 0.1, 0.1)
right_arm_dot:translate(0.0, -0.2, 0.77)
right_arm_joint:add_child(right_arm_dot)

-- arms
left_arm_top = gr.sphere('left_arm_top')
left_arm_top:set_material(grey)
left_arm_top:scale(0.4, 1.0, 0.4)
left_arm_top:translate(0.2, -1.0, 0.0)
left_arm_joint:add_child(left_arm_top)

right_arm_top = gr.sphere('right_arm_top')
right_arm_top:set_material(grey)
right_arm_top:scale(0.4, 1.0, 0.4)
right_arm_top:translate(-0.2, -1.0, 0.0)
right_arm_joint:add_child(right_arm_top)

left_elbow_joint_pre = gr.node('left_elbow_joint_pre')
left_elbow_joint_pre:translate(0.2, -2.0, 0.0)
left_arm_joint:add_child(left_elbow_joint_pre)

left_elbow_joint = gr.joint('left_elbow_joint', {-45, 0, 45}, {-45, 0, 45})
left_elbow_joint_pre:add_child(left_elbow_joint)

left_arm_lower = gr.sphere('left_arm_lower')
left_arm_lower:set_material(grey)
left_arm_lower:scale(0.3, 0.6, 0.3)
left_arm_lower:translate(0, -0.3, 0)
left_elbow_joint:add_child(left_arm_lower)

left_wrist_joint_pre = gr.node('left_wrist_joint_pre')
left_wrist_joint_pre:translate(0.1, -1.0, 0.0)
left_elbow_joint:add_child(left_wrist_joint_pre)

left_wrist_joint = gr.joint('left_wrist_joint', {-45, 0, 45}, {-45, 0, 45})
left_wrist_joint_pre:add_child(left_wrist_joint)

left_hand = gr.sphere('left_hand')
left_hand:set_material(grey)
left_hand:scale(0.1, 0.4, 0.2)
left_wrist_joint:add_child(left_hand)

left_thumb_joint_pre = gr.node('left_thumb_joint_pre')
left_thumb_joint_pre:translate(-0.1, -0.8, 0.0)
left_elbow_joint:add_child(left_thumb_joint_pre)

left_thumb_joint = gr.joint('left_thumb_joint', {-45, 0, 45}, {-45, 0, 45})
left_thumb_joint_pre:add_child(left_thumb_joint)

left_thumb = gr.sphere('left_thumb')
left_thumb:set_material(grey)
left_thumb:scale(0.07, 0.25, 0.1)
left_thumb_joint:add_child(left_thumb)

right_elbow_joint_pre = gr.node('right_elbow_joint_pre')
right_elbow_joint_pre:translate(-0.2, -2, 0.0)
right_arm_joint:add_child(right_elbow_joint_pre)

right_elbow_joint = gr.joint('right_elbow_joint', {-45, 0, 45}, {-45, 0, 45})
right_elbow_joint_pre:add_child(right_elbow_joint)

right_arm_lower = gr.cube('right_arm_lower')
right_arm_lower:translate(-0.5, -0.5, -0.5)
right_arm_lower:set_material(grey)
right_arm_lower:scale(0.7, 1.8, 0.7)
right_arm_lower:translate(0, -0.5, 0)
right_elbow_joint:add_child(right_arm_lower)

right_cannon_1 = gr.cube('right_cannon_1')
right_cannon_1:translate(-0.5, -0.5, -0.5)
right_cannon_1:set_material(blue)
right_cannon_1:scale(0.1, 1.0, 0.9)
right_cannon_1:translate(0.2, -1, 0.0)
right_elbow_joint:add_child(right_cannon_1)

right_cannon_2 = gr.cube('right_cannon_2')
right_cannon_2:translate(-0.5, -0.5, -0.5)
right_cannon_2:set_material(blue)
right_cannon_2:scale(0.1, 1.2, 0.9)
right_cannon_2:translate(-0.2, -0.9, 0.0)
right_elbow_joint:add_child(right_cannon_2)

--[[dark samus end]]


--[[samus begin]]

samus = gr.node('samus')
samus:rotate('y', 140)
samus:translate(-12, 6, 15)
rootnode:add_child(samus)

-- body
samus_torso_joint = gr.joint('samus_torso_joint', {-45, 0, 45}, {-45, 0, 45})
samus:add_child(samus_torso_joint)

samus_torso = gr.sphere('samus_torso')
samus_torso:scale(1.2, 1.0, 0.8)
samus_torso:set_material(orange)
samus_torso_joint:add_child(samus_torso)

samus_shoulder_joint_pre = gr.node('samus_shoulder_joint_pre')
samus_shoulder_joint_pre:translate(0.0, 0.5, 0.0)
samus_torso_joint:add_child(samus_shoulder_joint_pre)

samus_shoulder_joint = gr.joint('samus_shoulder_joint', {-45, 0, 45}, {-45, 0, 45})
samus_shoulder_joint_pre:add_child(samus_shoulder_joint)

samus_shoulder = gr.sphere('samus_shoulder')
samus_shoulder:scale(1.5, 1.0, 1.0)
samus_shoulder:set_material(red)
samus_shoulder_joint:add_child(samus_shoulder)

samus_chest_1 = gr.cube('samus_chest_1')
samus_chest_1:translate(-0.5, -0.5, -0.5)
samus_chest_1:scale(0.6, 0.15, 0.4)
samus_chest_1:translate(-0.4, -0.3, 0.8)
samus_chest_1:rotate('z', -20.0)
samus_chest_1:set_material(green)
samus_shoulder_joint:add_child(samus_chest_1)

samus_chest_2 = gr.cube('samus_chest_2')
samus_chest_2:translate(-0.5, -0.5, -0.5)
samus_chest_2:scale(0.6, 0.15, 0.4)
samus_chest_2:translate(0.4, -0.3, 0.8)
samus_chest_2:rotate('z', 20.0)
samus_chest_2:set_material(green)
samus_shoulder_joint:add_child(samus_chest_2)

samus_booster_1 = gr.cylinder('samus_booster_1')
samus_booster_1:scale(0.3, 1, 0.3)
samus_booster_1:translate(-0.6, -0.8, -0.7)
samus_booster_1:rotate('x', 30.0)
samus_booster_1:rotate('z', -20.0)
samus_booster_1:set_material(red)
samus_shoulder_joint:add_child(samus_booster_1)

samus_booster_2 = gr.cylinder('samus_booster_2')
samus_booster_2:scale(0.3, 1, 0.3)
samus_booster_2:translate(0.6, -0.8, -0.7)
samus_booster_2:rotate('x', 30.0)
samus_booster_2:rotate('z', 20.0)
samus_booster_2:set_material(red)
samus_shoulder_joint:add_child(samus_booster_2)

samus_hip_joint_pre = gr.node('samus_hip_joint_pre')
samus_hip_joint_pre:translate(0.0, -0.5, 0.0)
samus_torso_joint:add_child(samus_hip_joint_pre)

samus_hip_joint = gr.joint('samus_hip_joint', {-45, 0, 45}, {-45, 0, 45})
samus_hip_joint_pre:add_child(samus_hip_joint)

samus_hip = gr.sphere('samus_hip')
samus_hip:scale(0.8, 1.5, 0.8)
samus_hip:set_material(orange)
samus_hip_joint:add_child(samus_hip)

-- samus_head
samus_neck_joint_pre = gr.node('samus_neck_joint_pre')
samus_neck_joint_pre:translate(0.0, 0.8, 0.5)
samus_shoulder_joint:add_child(samus_neck_joint_pre)

samus_neck_joint = gr.joint('samus_neck_joint', {-45, 0, 45}, {-45, 0, 45})
samus_neck_joint_pre:add_child(samus_neck_joint)

samus_neck = gr.sphere('samus_neck')
samus_neck:scale(0.5, 0.1, 0.5)
samus_neck:rotate('x', 30.0)
samus_neck:set_material(red)
samus_neck_joint:add_child(samus_neck)

samus_head_joint_pre = gr.node('samus_head_joint_pre')
samus_head_joint_pre:translate(0.0, 0.6, 0.0)
samus_neck_joint:add_child(samus_head_joint_pre)

samus_head_joint = gr.joint('samus_head_joint', {-45, 0, 45}, {-45, 0, 45})
samus_head_joint_pre:add_child(samus_head_joint)

samus_head = gr.sphere('samus_head')
samus_head:scale(0.6, 0.7, 0.6)
samus_head:rotate('x', -20)
samus_head:set_material(red)
samus_head_joint:add_child(samus_head)

samus_visor_1 = gr.cube('samus_visor_1')
samus_visor_1:translate(-0.5, -0.5, -0.5)
samus_visor_1:scale(0.7, 0.3, 0.46)
samus_visor_1:translate(0, -0.15, 0.4)
samus_visor_1:rotate('x', 12)
samus_visor_1:set_material(green)
samus_head_joint:add_child(samus_visor_1)

samus_visor_3 = gr.cube('samus_visor_3')
samus_visor_3:translate(-0.5, -0.5, -0.5)
samus_visor_3:scale(0.2, 0.3, 0.3)
samus_visor_3:translate(-0.25, -0.0, 0.5)
samus_visor_3:rotate('y', -20)
samus_visor_3:rotate('z', 90.0)
samus_visor_3:set_material(green)
samus_head_joint:add_child(samus_visor_3)

-- leg joints
samus_left_leg_joint_pre = gr.node('samus_left_leg_joint_pre')
samus_left_leg_joint_pre:translate(0.5, -1.0, 0.0)
samus_hip_joint:add_child(samus_left_leg_joint_pre)

samus_left_leg_joint = gr.joint('samus_left_leg_joint', {-45, 0, 45}, {-45, 0, 45})
samus_left_leg_joint_pre:add_child(samus_left_leg_joint)

samus_left_leg_top = gr.sphere('samus_left_leg_top')
samus_left_leg_top:set_material(black)
samus_left_leg_top:scale(0.2, 0.6, 0.5)
samus_left_leg_top:rotate('z', -40.0)
samus_left_leg_joint:add_child(samus_left_leg_top)

samus_right_leg_joint_pre = gr.node('samus_right_leg_joint_pre')
samus_right_leg_joint_pre:translate(-0.5, -1.0, 0.0)
samus_hip_joint:add_child(samus_right_leg_joint_pre)

samus_right_leg_joint = gr.joint('samus_right_leg_joint', {-45, 0, 45}, {-45, 0, 45})
samus_right_leg_joint_pre:add_child(samus_right_leg_joint)

samus_right_leg_top = gr.sphere('samus_right_leg_top')
samus_right_leg_top:set_material(black)
samus_right_leg_top:scale(0.2, 0.6, 0.5)
samus_right_leg_top:rotate('z', 40.0)
samus_right_leg_joint:add_child(samus_right_leg_top)

-- legs
samus_left_leg_thigh = gr.sphere('samus_left_leg_thigh')
samus_left_leg_thigh:set_material(orange)
samus_left_leg_thigh:scale(0.5, 1.5, 0.5)
samus_left_leg_thigh:translate(0.1, -1.0, 0.0)
samus_left_leg_joint:add_child(samus_left_leg_thigh)

samus_left_leg_thigh_side = gr.sphere('samus_left_leg_thigh_side')
samus_left_leg_thigh_side:set_material(green)
samus_left_leg_thigh_side:scale(0.1, 0.8, 0.2)
samus_left_leg_thigh_side:translate(0.5, -1.0, 0.0)
samus_left_leg_joint:add_child(samus_left_leg_thigh_side)

samus_right_leg_thigh = gr.sphere('samus_right_leg_thigh')
samus_right_leg_thigh:set_material(orange)
samus_right_leg_thigh:scale(0.5, 1.5, 0.5)
samus_right_leg_thigh:translate(-0.1, -1.0, 0.0)
samus_right_leg_joint:add_child(samus_right_leg_thigh)

samus_right_leg_thigh_side = gr.sphere('samus_right_leg_thigh_side')
samus_right_leg_thigh_side:set_material(green)
samus_right_leg_thigh_side:scale(0.1, 0.8, 0.2)
samus_right_leg_thigh_side:translate(-0.5, -1.0, 0.0)
samus_right_leg_joint:add_child(samus_right_leg_thigh_side)

samus_left_knee_joint_pre = gr.node('samus_left_knee_joint_pre')
samus_left_knee_joint_pre:translate(0.1, -2.3, 0.0)
samus_left_leg_joint:add_child(samus_left_knee_joint_pre)

samus_left_knee_joint = gr.joint('samus_left_knee_joint', {-45, 0, 45}, {-45, 0, 45})
samus_left_knee_joint_pre:add_child(samus_left_knee_joint)

samus_left_leg_lower = gr.sphere('samus_left_leg_lower')
samus_left_leg_lower:set_material(orange)
samus_left_leg_lower:scale(0.4, 1.2, 0.4)
samus_left_leg_lower:translate(0, -0.5, 0)
samus_left_knee_joint:add_child(samus_left_leg_lower)

samus_left_leg_lower_side = gr.sphere('samus_left_leg_lower_side')
samus_left_leg_lower_side:set_material(green)
samus_left_leg_lower_side:scale(0.1, 0.6, 0.1)
samus_left_leg_lower_side:translate(0.33, -0.5, 0.0)
samus_left_knee_joint:add_child(samus_left_leg_lower_side)

samus_left_kneecap = gr.sphere('samus_left_kneecap')
samus_left_kneecap:set_material(orange)
samus_left_kneecap:scale(0.3, 0.7, 0.1)
samus_left_kneecap:rotate('x', 50.0)
samus_left_kneecap:translate(0.0, 0.2, 0.2)
samus_left_knee_joint:add_child(samus_left_kneecap)

samus_left_ankle_joint_pre = gr.node('samus_left_ankle_joint_pre')
samus_left_ankle_joint_pre:translate(0.08, -0.5, 0.0)
samus_left_knee_joint:add_child(samus_left_ankle_joint_pre)

samus_left_ankle_joint = gr.joint('samus_left_ankle_joint', {-45, 0, 45}, {-45, 0, 45})
samus_left_ankle_joint_pre:add_child(samus_left_ankle_joint)

samus_left_foot = gr.sphere('samus_left_foot')
samus_left_foot:set_material(orange)
samus_left_foot:scale(0.3, 0.7, 0.2)
samus_left_foot:rotate('x', 100.0)
samus_left_foot:translate(0.0, -1.1, 0.4)
samus_left_ankle_joint:add_child(samus_left_foot)

samus_right_knee_joint_pre = gr.node('samus_right_knee_joint_pre')
samus_right_knee_joint_pre:translate(-0.1, -2.3, 0.0)
samus_right_leg_joint:add_child(samus_right_knee_joint_pre)

samus_right_knee_joint = gr.joint('samus_right_knee_joint', {-45, 0, 45}, {-45, 0, 45})
samus_right_knee_joint_pre:add_child(samus_right_knee_joint)

samus_right_leg_lower = gr.sphere('samus_right_leg_lower')
samus_right_leg_lower:set_material(orange)
samus_right_leg_lower:scale(0.4, 1.2, 0.4)
samus_right_leg_lower:translate(0, -0.5, 0)
samus_right_knee_joint:add_child(samus_right_leg_lower)

samus_right_leg_lower_side = gr.sphere('samus_right_leg_lower_side')
samus_right_leg_lower_side:set_material(green)
samus_right_leg_lower_side:scale(0.1, 0.6, 0.1)
samus_right_leg_lower_side:translate(-0.33, -0.5, 0.0)
samus_right_knee_joint:add_child(samus_right_leg_lower_side)

samus_right_ankle_joint_pre = gr.node('samus_right_ankle_joint_pre')
samus_right_ankle_joint_pre:translate(-0.08, -0.5, 0.0)
samus_right_knee_joint:add_child(samus_right_ankle_joint_pre)

samus_right_kneecap = gr.sphere('samus_right_kneecap')
samus_right_kneecap:set_material(orange)
samus_right_kneecap:scale(0.3, 0.7, 0.1)
samus_right_kneecap:rotate('x', 50.0)
samus_right_kneecap:translate(0.0, 0.2, 0.2)
samus_right_knee_joint:add_child(samus_right_kneecap)

samus_right_ankle_joint = gr.joint('samus_right_ankle_joint', {-45, 0, 45}, {-45, 0, 45})
samus_right_ankle_joint_pre:add_child(samus_right_ankle_joint)

samus_right_foot = gr.sphere('samus_right_foot')
samus_right_foot:set_material(orange)
samus_right_foot:scale(0.3, 0.7, 0.2)
samus_right_foot:rotate('x', 100.0)
samus_right_foot:translate(0.0, -1.1, 0.4)
samus_right_ankle_joint:add_child(samus_right_foot)

-- samus_shoulder pad
samus_left_arm_joint_pre = gr.node('samus_left_arm_joint_pre')
samus_left_arm_joint_pre:translate(1.5, 0.2, 0.0)
samus_shoulder_joint:add_child(samus_left_arm_joint_pre)

samus_left_arm_joint = gr.joint('samus_left_arm_joint', {-45, 0, 45}, {-45, 0, 45})
samus_left_arm_joint_pre:add_child(samus_left_arm_joint)

samus_left_arm_pad = gr.sphere('samus_left_arm_pad')
samus_left_arm_pad:set_material(orange)
samus_left_arm_pad:scale(0.8, 0.8, 0.8)
samus_left_arm_joint:add_child(samus_left_arm_pad)

samus_left_arm_spike1 = gr.sphere('samus_left_arm_spike1')
samus_left_arm_spike1:set_material(orange)
samus_left_arm_spike1:scale(0.2, 0.6, 0.5)
samus_left_arm_spike1:rotate('z', -50.0)
samus_left_arm_spike1:translate(0.35, 0.3, 0)
samus_left_arm_joint:add_child(samus_left_arm_spike1)

samus_left_arm_spike2 = gr.sphere('samus_left_arm_spike2')
samus_left_arm_spike2:set_material(orange)
samus_left_arm_spike2:scale(0.2, 0.6, 0.5)
samus_left_arm_spike2:rotate('z', 10.0)
samus_left_arm_spike2:translate(-0.1, 0.5, 0)
samus_left_arm_joint:add_child(samus_left_arm_spike2)

samus_right_arm_joint_pre = gr.node('samus_right_arm_joint_pre')
samus_right_arm_joint_pre:translate(-1.5, 0.2, 0.0)
samus_shoulder_joint:add_child(samus_right_arm_joint_pre)

samus_right_arm_joint = gr.joint('samus_right_arm_joint', {-45, 0, 45}, {-45, 0, 45})
samus_right_arm_joint_pre:add_child(samus_right_arm_joint)

samus_right_arm_pad = gr.sphere('samus_right_arm_pad')
samus_right_arm_pad:set_material(orange)
samus_right_arm_pad:scale(0.8, 0.8, 0.8)
samus_right_arm_joint:add_child(samus_right_arm_pad)

samus_right_arm_spike1 = gr.sphere('samus_right_arm_spike1')
samus_right_arm_spike1:set_material(orange)
samus_right_arm_spike1:scale(0.2, 0.6, 0.5)
samus_right_arm_spike1:rotate('z', 50.0)
samus_right_arm_spike1:translate(-0.35, 0.3, 0)
samus_right_arm_joint:add_child(samus_right_arm_spike1)

samus_right_arm_spike2 = gr.sphere('samus_right_arm_spike2')
samus_right_arm_spike2:set_material(orange)
samus_right_arm_spike2:scale(0.2, 0.6, 0.5)
samus_right_arm_spike2:rotate('z', -10.0)
samus_right_arm_spike2:translate(0.1, 0.5, 0)
samus_right_arm_joint:add_child(samus_right_arm_spike2)

-- arms
samus_left_arm_top = gr.sphere('samus_left_arm_top')
samus_left_arm_top:set_material(orange)
samus_left_arm_top:scale(0.4, 1.0, 0.4)
samus_left_arm_top:translate(0.2, -1.0, 0.0)
samus_left_arm_joint:add_child(samus_left_arm_top)

samus_right_arm_top = gr.sphere('samus_right_arm_top')
samus_right_arm_top:set_material(orange)
samus_right_arm_top:scale(0.4, 1.0, 0.4)
samus_right_arm_top:translate(-0.2, -1.0, 0.0)
samus_right_arm_joint:add_child(samus_right_arm_top)

samus_left_elbow_joint_pre = gr.node('samus_left_elbow_joint_pre')
samus_left_elbow_joint_pre:translate(0.2, -2.0, 0.0)
samus_left_arm_joint:add_child(samus_left_elbow_joint_pre)

samus_left_elbow_joint = gr.joint('samus_left_elbow_joint', {-45, 0, 45}, {-45, 0, 45})
samus_left_elbow_joint_pre:add_child(samus_left_elbow_joint)

samus_left_arm_lower = gr.sphere('samus_left_arm_lower')
samus_left_arm_lower:set_material(orange)
samus_left_arm_lower:scale(0.3, 0.6, 0.3)
samus_left_arm_lower:translate(0, -0.3, 0)
samus_left_elbow_joint:add_child(samus_left_arm_lower)

samus_left_wrist_joint_pre = gr.node('samus_left_wrist_joint_pre')
samus_left_wrist_joint_pre:translate(0.1, -1.0, 0.0)
samus_left_elbow_joint:add_child(samus_left_wrist_joint_pre)

samus_left_wrist_joint = gr.joint('samus_left_wrist_joint', {-45, 0, 45}, {-45, 0, 45})
samus_left_wrist_joint_pre:add_child(samus_left_wrist_joint)

samus_left_hand = gr.sphere('samus_left_hand')
samus_left_hand:set_material(orange)
samus_left_hand:scale(0.1, 0.4, 0.2)
samus_left_wrist_joint:add_child(samus_left_hand)

samus_left_thumb_joint_pre = gr.node('samus_left_thumb_joint_pre')
samus_left_thumb_joint_pre:translate(-0.1, -0.8, 0.0)
samus_left_elbow_joint:add_child(samus_left_thumb_joint_pre)

samus_left_thumb_joint = gr.joint('samus_left_thumb_joint', {-45, 0, 45}, {-45, 0, 45})
samus_left_thumb_joint_pre:add_child(samus_left_thumb_joint)

samus_left_thumb = gr.sphere('samus_left_thumb')
samus_left_thumb:set_material(orange)
samus_left_thumb:scale(0.07, 0.25, 0.1)
samus_left_thumb_joint:add_child(samus_left_thumb)

samus_right_elbow_joint_pre = gr.node('samus_right_elbow_joint_pre')
samus_right_elbow_joint_pre:translate(-0.2, -2, 0.0)
samus_right_arm_joint:add_child(samus_right_elbow_joint_pre)

samus_right_elbow_joint = gr.joint('samus_right_elbow_joint', {-45, 0, 45}, {-45, 0, 45})
samus_right_elbow_joint_pre:add_child(samus_right_elbow_joint)

samus_right_arm_lower = gr.cylinder('samus_right_arm_lower')
samus_right_arm_lower:set_material(dark_green)
samus_right_arm_lower:scale(0.45, 1.8, 0.45)
samus_right_arm_lower:translate(0, -1.5, 0)
samus_right_elbow_joint:add_child(samus_right_arm_lower)

samus_right_cannon_1 = gr.sphere('samus_right_cannon_1')
samus_right_cannon_1:set_material(yellow)
samus_right_cannon_1:scale(0.45, 0.2, 0.45)
samus_right_cannon_1:translate(0.0, -1.5, 0.0)
samus_right_elbow_joint:add_child(samus_right_cannon_1)

--[[samus end]]

left_arm_joint:rotate('x', -34)
left_arm_joint:rotate('y', 20)
left_elbow_joint:rotate('x', -75)
left_elbow_joint:rotate('y', -91)
right_arm_joint:rotate('x', -9)
right_arm_joint:rotate('y', -19)
right_elbow_joint:rotate('y', 37)
right_elbow_joint:rotate('x', -37)
hip_joint:rotate('x', -24)
left_leg_joint:rotate('y', 18)
left_knee_joint:rotate('x', 57)
right_leg_joint:rotate('x', -21)
right_knee_joint:rotate('x', 49)
head_joint:rotate('y', -10)

samus_left_arm_joint:rotate('x', -43)
samus_left_arm_joint:rotate('y', -25)
samus_left_elbow_joint:rotate('x', -43)
samus_left_elbow_joint:rotate('y', -39)
samus_right_arm_joint:rotate('x', -38)
samus_right_arm_joint:rotate('y', 48)
samus_right_elbow_joint:rotate('x', -37)
samus_left_leg_joint:rotate('x', 16)
samus_right_leg_joint:rotate('x', -20)
samus_right_knee_joint:rotate('x', 23)
samus_left_ankle_joint:rotate('x', -18)
samus_right_ankle_joint:rotate('x', -12)

rootnode:rotate('y', 50)
rootnode:translate(0, -5, 0)
darksamus:rotate('x', 10)
head_joint:rotate('y', -20)
darksamus:translate(0, 0, 10)

-- rootnode:animate(5, 14, 'rotate', {0, 60, 0}, 'ease-in')
-- darksamus:animate(3, 3, 'rotate', {10, 0, 0}, 'linear')
-- head_joint:animate(3, 3, 'rotate', {0, -20, 0}, 'linear')
-- darksamus:animate(6, 14, 'translate', {0, 0, 10}, 'ease-in')

white_light = gr.light({2, 12, 30}, {0.9, 0.9, 0.9}, {1, 0, 0})
white_area_light = gr.area_light({2, 12, 30}, {0.9, 0.9, 0.9}, {1, 0, 0}, {0, 0, -1}, {0, 1, 0}, 10, 100)

blue_light_1 = gr.light({0, 25, 12.5}, {0.25, 0.95, 0.95}, {1, 0, 0})
blue_light_2 = gr.light({0, 25, -12.5}, {0.25, 0.95, 0.95}, {1, 0, 0})
blue_light_3 = gr.light({12.5, 25, 0}, {0.25, 0.95, 0.95}, {1, 0, 0})
blue_light_4 = gr.light({-12.5, 25, 0}, {0.25, 0.95, 0.95}, {1, 0, 0})

gr.render(rootnode, './Generated/scene2_last/',
330, 135,
--660, 270,
--2100, 900,
{10, 2, 27}, {0, 0, -1}, {0, 1, 0}, 
--{0, 120, 0}, {0, -1, 0}, {0, 0, -1}, 

50, {0.3, 0.3, 0.3}, {blue_light_1, blue_light_3}, 1, 
--0.1
1
)