rootnode = gr.node('root')

grey = gr.phong_material({0.15, 0.18, 0.25}, {0.1, 0.1, 0.1}, 10)
blue = gr.phong_material({0.25, 0.95, 0.95}, {0.1, 0.1, 0.1}, 10)
brown = gr.phong_material({46/255, 41/255, 32/255}, {0.1, 0.1, 0.1}, 10)
yellow = gr.phong_material({253/255, 188/255, 98/255}, {0.1, 0.1, 0.1}, 10)
transparent = gr.phong_material({120/255, 120/255, 140/255}, {0.1, 0.1, 0.1}, 10)

grey_r = gr.reflective_material({0.15, 0.18, 0.25}, 0.1, 0)
blue_r = gr.reflective_material({0.25, 0.95, 0.95}, 0.5, 0)

blue_ra = gr.refractive_material({0.25, 0.95, 0.95}, 1.3, 0)

-- floor
floor = gr.cube('floor')
floor:translate(-0.5, -0.5, -0.5)
floor:set_material(brown)
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
wall1:set_material(brown)
wall1:translate(-0.5, -0.5, -0.5)
wall1:scale(1, 50, 100)
wall1:translate(-50, 25, 0)
rootnode:add_child(wall1)

wall2 = gr.cube('wall2')
wall2:set_material(brown)
wall2:translate(-0.5, -0.5, -0.5)
wall2:scale(1, 50, 100)
wall2:translate(50, 25, 0)
rootnode:add_child(wall2)

wall3 = gr.cube('wall3')
wall3:set_material(brown)
wall3:translate(-0.5, -0.5, -0.5)
wall3:scale(100, 50, 1)
wall3:translate(0, 25, -50)
rootnode:add_child(wall3)

--cieling
cieling = gr.cube('cieling')
cieling:translate(-0.5, -0.5, -0.5)
cieling:set_material(brown)
cieling:scale(100, 1, 100)
cieling:translate(0, 50, 0)
rootnode:add_child(cieling)

--center pillar
pillar_bottom_torus = gr.torus('pillar_bottom_torus', 0.2)
pillar_bottom_torus:set_material(brown)
pillar_bottom_torus:scale(10, 10, 10)
pillar_bottom_torus:translate(0, 1, 0)
rootnode:add_child(pillar_bottom_torus)

pillar_bottom_cylinder = gr.cylinder('pillar_bottom_cylinder')
pillar_bottom_cylinder:set_material(brown)
pillar_bottom_cylinder:scale(8, 10, 8)
rootnode:add_child(pillar_bottom_cylinder)

pillar_middle_torus = gr.torus('pillar_middle_torus', 0.2)
pillar_middle_torus:set_material(brown)
pillar_middle_torus:scale(10, 10, 10)
pillar_middle_torus:translate(0, 12, 0)
rootnode:add_child(pillar_middle_torus)

pillar_middle_cylinder = gr.cylinder('pillar_middle_cylinder')
pillar_middle_cylinder:set_material(brown)
pillar_middle_cylinder:scale(10, 2, 10)
pillar_middle_cylinder:translate(0, 14, 0)
rootnode:add_child(pillar_middle_cylinder)

pillar_middle_torus_light = gr.torus('pillar_middle_torus_light', 0.1)
pillar_middle_torus_light:set_material(yellow)
pillar_middle_torus_light:scale(10, 2, 10)
pillar_middle_torus_light:translate(0, 15, 0)
rootnode:add_child(pillar_middle_torus_light)

pillar_middle_cylinder_glass = gr.cylinder('pillar_middle_cylinder_glass')
pillar_middle_cylinder_glass:set_material(blue)
pillar_middle_cylinder_glass:scale(12, 20, 12)
pillar_middle_cylinder_glass:translate(0, 16, 0)
rootnode:add_child(pillar_middle_cylinder_glass)

pillar_top_torus = gr.torus('pillar_top_torus', 0.2)
pillar_top_torus:set_material(brown)
pillar_top_torus:scale(10, 10, 10)
pillar_top_torus:translate(0, 40, 0)
rootnode:add_child(pillar_top_torus)

pillar_top_cylinder = gr.cylinder('pillar_top_cylinder')
pillar_top_cylinder:set_material(brown)
pillar_top_cylinder:scale(10, 2, 10)
pillar_top_cylinder:translate(0, 36, 0)
rootnode:add_child(pillar_top_cylinder)

pillar_top_torus_light = gr.torus('pillar_top_torus_light', 0.2)
pillar_top_torus_light:set_material(yellow)
pillar_top_torus_light:scale(10, 2, 10)
pillar_top_torus_light:translate(0, 37, 0)
rootnode:add_child(pillar_top_torus_light)

--surrounding pillars
pillar_surrounding_1 = gr.cylinder('pillar_surrounding_1')
pillar_surrounding_1:set_material(brown)
pillar_surrounding_1:scale(1.2, 52, 1.2)
pillar_surrounding_1:translate(10, 0, 10)
rootnode:add_child(pillar_surrounding_1)

pillar_surrounding_2 = gr.cylinder('pillar_surrounding_2')
pillar_surrounding_2:set_material(brown)
pillar_surrounding_2:scale(1.2, 52, 1.2)
pillar_surrounding_2:translate(10, 0, -10)
rootnode:add_child(pillar_surrounding_2)

pillar_surrounding_3 = gr.cylinder('pillar_surrounding_3')
pillar_surrounding_3:set_material(brown)
pillar_surrounding_3:scale(1.2, 52, 1.2)
pillar_surrounding_3:translate(-10, 0, 10)
rootnode:add_child(pillar_surrounding_3)

pillar_surrounding_4 = gr.cylinder('pillar_surrounding_4')
pillar_surrounding_4:set_material(brown)
pillar_surrounding_4:scale(1.2, 52, 1.2)
pillar_surrounding_4:translate(-10, 0, -10)
rootnode:add_child(pillar_surrounding_4)

--secondary pillars
pillar_secondary_1 = gr.cylinder('pillar_secondary_1')
pillar_secondary_1:set_material(brown)
pillar_secondary_1:scale(5, 25, 5)
pillar_secondary_1:translate(25, 0, 25)
rootnode:add_child(pillar_secondary_1)

pillar_secondary_torus_light_1 = gr.torus('pillar_secondary_torus_light_1', 0.1)
pillar_secondary_torus_light_1:set_material(yellow)
pillar_secondary_torus_light_1:scale(7, 7, 7)
pillar_secondary_torus_light_1:translate(25, 0, 25)
rootnode:add_child(pillar_secondary_torus_light_1)

pillar_secondary_2 = gr.cylinder('pillar_secondary_2')
pillar_secondary_2:set_material(brown)
pillar_secondary_2:scale(5, 25, 5)
pillar_secondary_2:translate(25, 0, -25)
rootnode:add_child(pillar_secondary_2)

pillar_secondary_torus_light_2 = gr.torus('pillar_secondary_torus_light_2', 0.1)
pillar_secondary_torus_light_2:set_material(yellow)
pillar_secondary_torus_light_2:scale(7, 7, 7)
pillar_secondary_torus_light_2:translate(25, 0, -25)
rootnode:add_child(pillar_secondary_torus_light_2)

pillar_secondary_3 = gr.cylinder('pillar_secondary_3')
pillar_secondary_3:set_material(brown)
pillar_secondary_3:scale(5, 25, 5)
pillar_secondary_3:translate(-25, 0, 25)
rootnode:add_child(pillar_secondary_3)

pillar_secondary_torus_light_3 = gr.torus('pillar_secondary_torus_light_3', 0.1)
pillar_secondary_torus_light_3:set_material(yellow)
pillar_secondary_torus_light_3:scale(7, 7, 7)
pillar_secondary_torus_light_3:translate(-25, 0, 25)
rootnode:add_child(pillar_secondary_torus_light_3)

pillar_secondary_4 = gr.cylinder('pillar_secondary_4')
pillar_secondary_4:set_material(brown)
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
tube_4:scale(1, 25, 1)
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
-- body
darksamus = gr.node('darksamus')
darksamus:rotate('y', 45)
darksamus:translate(-17, 6, 20)
rootnode:add_child(darksamus)

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

darksamus:animate(0, 24, 'translate', {0, 10, 0}, 'ease')
--darksamus:animate(6, 5, 'translate', {-5, 0, 0}, 'linear')
--left_arm_joint:animate(0, 4, 'rotate', {-45, 0, 0}, 'linear')
--pillar_bottom_torus:animate(0, 4, 'scale', {1, 2, 1}, 'linear')

white_light = gr.light({2, 12, 30}, {0.9, 0.9, 0.9}, {1, 0, 0})

gr.render(rootnode, './Generated/testscene/',
330, 135,
--660, 270,
--2100, 900,
{0, 15, 50}, {0, 0, -1}, {0, 1, 0}, 
--{0, 120, 0}, {0, -1, 0}, {0, 0, -1}, 

50, {0.3, 0.3, 0.3}, {white_light}, 25)