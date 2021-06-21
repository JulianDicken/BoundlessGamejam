input_pressed	= keyboard_check_pressed(input);
input_released	= keyboard_check_released(input);
input_held		= keyboard_check(input);

if (grounded) {
	time_ground++;	
	time_air = 0;
} else {
	time_air++;	
	time_ground = 0;
}

target_xscale = sign(velocity_x) != 0 ? sign(velocity_x) : target_xscale;