rootnode = gr.node('root')

grey = gr.phong_material({0.15, 0.18, 0.25}, {0.1, 0.1, 0.1}, 10)
blue = gr.phong_material({0.25, 0.95, 0.95}, {0.1, 0.1, 0.1}, 10)

grey_r = gr.reflective_material({0.15, 0.18, 0.25}, 0.1, 0)
blue_r = gr.reflective_material({0.25, 0.95, 0.95}, 0.5, 0)

-- body
torso_joint = gr.joint('torso_joint', {-45, 0, 45}, {-45, 0, 45})
rootnode:add_child(torso_joint)

torso = gr.sphere('torso')
torso:scale(1.2, 1.0, 0.8)
torso:set_material(grey_r)
torso_joint:add_child(torso)

shoulder_joint_pre = gr.node('shoulder_joint_pre')
shoulder_joint_pre:translate(0.0, 0.5, 0.0)
torso_joint:add_child(shoulder_joint_pre)

shoulder_joint = gr.joint('shoulder_joint', {-45, 0, 45}, {-45, 0, 45})
shoulder_joint_pre:add_child(shoulder_joint)

shoulder = gr.sphere('shoulder')
shoulder:scale(1.5, 1.0, 1.0)
shoulder:set_material(grey_r)
shoulder_joint:add_child(shoulder)

chest_1 = gr.sphere('chest_1')
chest_1:scale(0.5, 0.2, 0.4)
chest_1:translate(-0.35, -0.3, 0.7)
chest_1:rotate('z', -30.0)
chest_1:set_material(blue_r)
shoulder_joint:add_child(chest_1)

chest_2 = gr.sphere('chest_2')
chest_2:scale(0.5, 0.2, 0.4)
chest_2:translate(0.35, -0.3, 0.7)
chest_2:rotate('z', 30.0)
chest_2:set_material(blue_r)
shoulder_joint:add_child(chest_2)

hip_joint_pre = gr.node('hip_joint_pre')
hip_joint_pre:translate(0.0, -0.5, 0.0)
torso_joint:add_child(hip_joint_pre)

hip_joint = gr.joint('hip_joint', {-45, 0, 45}, {-45, 0, 45})
hip_joint_pre:add_child(hip_joint)

hip = gr.sphere('hip')
hip:scale(0.8, 1.5, 0.8)
hip:set_material(grey_r)
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
neck:set_material(grey_r)
neck_joint:add_child(neck)

head_joint_pre = gr.node('head_joint_pre')
head_joint_pre:translate(0.0, 0.6, 0.0)
neck_joint:add_child(head_joint_pre)

head_joint = gr.joint('head_joint', {-45, 0, 45}, {-45, 0, 45})
head_joint_pre:add_child(head_joint)

head = gr.sphere('head')
head:scale(0.6, 0.7, 0.6)
head:rotate('x', -20)
head:set_material(grey_r)
head_joint:add_child(head)

visor_1 = gr.cube('visor_1')
visor_1:translate(-0.5, -0.5, -0.5)
visor_1:scale(0.3, 0.1, 0.3)
visor_1:translate(-0.05, -0.15, 0.5)
visor_1:rotate('x', 15.0)
visor_1:rotate('z', -20.0)
visor_1:set_material(blue_r)
head_joint:add_child(visor_1)

visor_2 = gr.cube('visor_2')
visor_2:translate(-0.5, -0.5, -0.5)
visor_2:scale(0.3, 0.1, 0.3)
visor_2:translate(0.05, -0.15, 0.5)
visor_2:rotate('x', 15.0)
visor_2:rotate('z', 20.0)
visor_2:set_material(blue_r)
head_joint:add_child(visor_2)

visor_3 = gr.cube('visor_3')
visor_3:translate(-0.5, -0.5, -0.5)
visor_3:scale(0.5, 0.08, 0.3)
visor_3:translate(-0.35, -0.0, 0.5)
visor_3:rotate('y', -20)
visor_3:rotate('z', 90.0)
visor_3:set_material(blue_r)
head_joint:add_child(visor_3)

-- leg joints
left_leg_joint_pre = gr.node('left_leg_joint_pre')
left_leg_joint_pre:translate(0.5, -1.0, 0.0)
hip_joint:add_child(left_leg_joint_pre)

left_leg_joint = gr.joint('left_leg_joint', {-45, 0, 45}, {-45, 0, 45})
left_leg_joint_pre:add_child(left_leg_joint)

left_leg_top = gr.sphere('left_leg_top')
left_leg_top:set_material(grey_r)
left_leg_top:scale(0.2, 0.7, 0.8)
left_leg_top:rotate('z', -40.0)
left_leg_joint:add_child(left_leg_top)

right_leg_joint_pre = gr.node('right_leg_joint_pre')
right_leg_joint_pre:translate(-0.5, -1.0, 0.0)
hip_joint:add_child(right_leg_joint_pre)

right_leg_joint = gr.joint('right_leg_joint', {-45, 0, 45}, {-45, 0, 45})
right_leg_joint_pre:add_child(right_leg_joint)

right_leg_top = gr.sphere('right_leg_top')
right_leg_top:set_material(grey_r)
right_leg_top:scale(0.2, 0.7, 0.8)
right_leg_top:rotate('z', 40.0)
right_leg_joint:add_child(right_leg_top)

-- legs
left_leg_thigh = gr.sphere('left_leg_thigh')
left_leg_thigh:set_material(grey_r)
left_leg_thigh:scale(0.5, 1.5, 0.5)
left_leg_thigh:translate(0.1, -1.0, 0.0)
left_leg_joint:add_child(left_leg_thigh)

left_leg_thigh_side = gr.sphere('left_leg_thigh_side')
left_leg_thigh_side:set_material(blue_r)
left_leg_thigh_side:scale(0.1, 0.8, 0.2)
left_leg_thigh_side:translate(0.5, -1.0, 0.0)
left_leg_joint:add_child(left_leg_thigh_side)

right_leg_thigh = gr.sphere('right_leg_thigh')
right_leg_thigh:set_material(grey_r)
right_leg_thigh:scale(0.5, 1.5, 0.5)
right_leg_thigh:translate(-0.1, -1.0, 0.0)
right_leg_joint:add_child(right_leg_thigh)

right_leg_thigh_side = gr.sphere('right_leg_thigh_side')
right_leg_thigh_side:set_material(blue_r)
right_leg_thigh_side:scale(0.1, 0.8, 0.2)
right_leg_thigh_side:translate(-0.5, -1.0, 0.0)
right_leg_joint:add_child(right_leg_thigh_side)

left_knee_joint_pre = gr.node('left_knee_joint_pre')
left_knee_joint_pre:translate(0.1, -2.3, 0.0)
left_leg_joint:add_child(left_knee_joint_pre)

left_knee_joint = gr.joint('left_knee_joint', {-45, 0, 45}, {-45, 0, 45})
left_knee_joint_pre:add_child(left_knee_joint)

left_leg_lower = gr.sphere('left_leg_lower')
left_leg_lower:set_material(grey_r)
left_leg_lower:scale(0.4, 1.2, 0.4)
left_leg_lower:translate(0, -0.5, 0)
left_knee_joint:add_child(left_leg_lower)

left_leg_lower_side = gr.sphere('left_leg_lower_side')
left_leg_lower_side:set_material(blue_r)
left_leg_lower_side:scale(0.1, 0.6, 0.1)
left_leg_lower_side:translate(0.33, -0.5, 0.0)
left_knee_joint:add_child(left_leg_lower_side)

left_kneecap = gr.sphere('left_kneecap')
left_kneecap:set_material(grey_r)
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
left_foot:set_material(grey_r)
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
right_leg_lower:set_material(grey_r)
right_leg_lower:scale(0.4, 1.2, 0.4)
right_leg_lower:translate(0, -0.5, 0)
right_knee_joint:add_child(right_leg_lower)

right_leg_lower_side = gr.sphere('right_leg_lower_side')
right_leg_lower_side:set_material(blue_r)
right_leg_lower_side:scale(0.1, 0.6, 0.1)
right_leg_lower_side:translate(-0.33, -0.5, 0.0)
right_knee_joint:add_child(right_leg_lower_side)

right_ankle_joint_pre = gr.node('right_ankle_joint_pre')
right_ankle_joint_pre:translate(-0.08, -0.5, 0.0)
right_knee_joint:add_child(right_ankle_joint_pre)

right_kneecap = gr.sphere('right_kneecap')
right_kneecap:set_material(grey_r)
right_kneecap:scale(0.3, 0.7, 0.1)
right_kneecap:rotate('x', 50.0)
right_kneecap:translate(0.0, 0.2, 0.2)
right_knee_joint:add_child(right_kneecap)

right_ankle_joint = gr.joint('right_ankle_joint', {-45, 0, 45}, {-45, 0, 45})
right_ankle_joint_pre:add_child(right_ankle_joint)

right_foot = gr.sphere('right_foot')
right_foot:set_material(grey_r)
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
left_arm_pad:set_material(grey_r)
left_arm_pad:scale(0.8, 0.8, 0.8)
left_arm_joint:add_child(left_arm_pad)

left_arm_dot = gr.sphere('left_arm_dot')
left_arm_dot:set_material(blue_r)
left_arm_dot:scale(0.1, 0.1, 0.1)
left_arm_dot:translate(0.0, -0.2, 0.77)
left_arm_joint:add_child(left_arm_dot)

right_arm_joint_pre = gr.node('right_arm_joint_pre')
right_arm_joint_pre:translate(-1.5, 0.2, 0.0)
shoulder_joint:add_child(right_arm_joint_pre)

right_arm_joint = gr.joint('right_arm_joint', {-45, 0, 45}, {-45, 0, 45})
right_arm_joint_pre:add_child(right_arm_joint)

right_arm_pad = gr.sphere('right_arm_pad')
right_arm_pad:set_material(grey_r)
right_arm_pad:scale(0.8, 0.8, 0.8)
right_arm_joint:add_child(right_arm_pad)

right_arm_dot = gr.sphere('right_arm_dot')
right_arm_dot:set_material(blue_r)
right_arm_dot:scale(0.1, 0.1, 0.1)
right_arm_dot:translate(0.0, -0.2, 0.77)
right_arm_joint:add_child(right_arm_dot)

-- arms
left_arm_top = gr.sphere('left_arm_top')
left_arm_top:set_material(grey_r)
left_arm_top:scale(0.4, 1.0, 0.4)
left_arm_top:translate(0.2, -1.0, 0.0)
left_arm_joint:add_child(left_arm_top)

right_arm_top = gr.sphere('right_arm_top')
right_arm_top:set_material(grey_r)
right_arm_top:scale(0.4, 1.0, 0.4)
right_arm_top:translate(-0.2, -1.0, 0.0)
right_arm_joint:add_child(right_arm_top)

left_elbow_joint_pre = gr.node('left_elbow_joint_pre')
left_elbow_joint_pre:translate(0.2, -2.0, 0.0)
left_arm_joint:add_child(left_elbow_joint_pre)

left_elbow_joint = gr.joint('left_elbow_joint', {-45, 0, 45}, {-45, 0, 45})
left_elbow_joint_pre:add_child(left_elbow_joint)

left_arm_lower = gr.sphere('left_arm_lower')
left_arm_lower:set_material(grey_r)
left_arm_lower:scale(0.3, 0.6, 0.3)
left_arm_lower:translate(0, -0.3, 0)
left_elbow_joint:add_child(left_arm_lower)

left_wrist_joint_pre = gr.node('left_wrist_joint_pre')
left_wrist_joint_pre:translate(0.1, -1.0, 0.0)
left_elbow_joint:add_child(left_wrist_joint_pre)

left_wrist_joint = gr.joint('left_wrist_joint', {-45, 0, 45}, {-45, 0, 45})
left_wrist_joint_pre:add_child(left_wrist_joint)

left_hand = gr.sphere('left_hand')
left_hand:set_material(grey_r)
left_hand:scale(0.1, 0.4, 0.2)
left_wrist_joint:add_child(left_hand)

left_thumb_joint_pre = gr.node('left_thumb_joint_pre')
left_thumb_joint_pre:translate(-0.1, -0.8, 0.0)
left_elbow_joint:add_child(left_thumb_joint_pre)

left_thumb_joint = gr.joint('left_thumb_joint', {-45, 0, 45}, {-45, 0, 45})
left_thumb_joint_pre:add_child(left_thumb_joint)

left_thumb = gr.sphere('left_thumb')
left_thumb:set_material(grey_r)
left_thumb:scale(0.07, 0.25, 0.1)
left_thumb_joint:add_child(left_thumb)

right_elbow_joint_pre = gr.node('right_elbow_joint_pre')
right_elbow_joint_pre:translate(-0.2, -2, 0.0)
right_arm_joint:add_child(right_elbow_joint_pre)

right_elbow_joint = gr.joint('right_elbow_joint', {-45, 0, 45}, {-45, 0, 45})
right_elbow_joint_pre:add_child(right_elbow_joint)

right_arm_lower = gr.cube('right_arm_lower')
right_arm_lower:translate(-0.5, -0.5, -0.5)
right_arm_lower:set_material(grey_r)
right_arm_lower:scale(0.7, 1.8, 0.7)
right_arm_lower:translate(0, -0.5, 0)
right_elbow_joint:add_child(right_arm_lower)

right_cannon_1 = gr.cube('right_cannon_1')
right_cannon_1:translate(-0.5, -0.5, -0.5)
right_cannon_1:set_material(blue_r)
right_cannon_1:scale(0.1, 1.0, 0.9)
right_cannon_1:translate(0.2, -1, 0.0)
right_elbow_joint:add_child(right_cannon_1)

right_cannon_2 = gr.cube('right_cannon_2')
right_cannon_2:translate(-0.5, -0.5, -0.5)
right_cannon_2:set_material(blue_r)
right_cannon_2:scale(0.1, 1.2, 0.9)
right_cannon_2:translate(-0.2, -0.9, 0.0)
right_elbow_joint:add_child(right_cannon_2)

white_light = gr.light({-20, 0, 40.0}, {0.9, 0.9, 0.9}, {1, 0, 0})
magenta_light = gr.light({400.0, 100.0, 150.0}, {0.7, 0.0, 0.7}, {1, 0, 0})

gr.render(rootnode, './Generated/darksamus.png', 512, 512,
--50, 50,
{0, 0, 2}, {0, 0, -1}, {0, 1, 0}, 50,
	  {0.3, 0.3, 0.3}, {white_light})