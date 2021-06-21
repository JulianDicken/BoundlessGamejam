input = vk_space;

velocity_x	= 0; //x
velocity_y	= 0; //y

max_x	= 5;
max_y	= -8;
max_a	= 35; //max angle

grounded		= false;
time_ground		= 0;
time_air		= 0;
accelleration_g = 0.4; //accelleration gravity

charge			= 0;
time_charge		= 0;
max_charge		= 1;
speed_charge	= 1 / room_speed;

draw_xscale		= 1;
draw_yscale		= 1;
target_xscale	= 1;