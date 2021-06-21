input = vk_space;

velocity_x	= 0; //x
velocity_y	= 0; //y

max_x	= 4;
max_y	= -6;
max_a	= 45; //max angle

grounded		= false;
time_ground		= 0;
time_air		= 0;
accelleration_g = 0.35; //accelleration gravity

charge			= 0;
mod_charge		= 0.09;
time_charge		= 0;
last_charge		= 0;
max_charge		= 1;
speed_charge	= 1 / room_speed;

canGrapple		= false;
isGrappling		= false;
time_grapple	= 0;
max_grapple		= room_speed * 0.15;
tongue			= noone;
length_tongue	= 96;
lvelocity_x		= 0;
lvelocity_y		= 0;

draw_xscale		= 1;
draw_yscale		= 1;
target_xscale	= 1;

draw_angle		= 0;
target_angle	= 0;

