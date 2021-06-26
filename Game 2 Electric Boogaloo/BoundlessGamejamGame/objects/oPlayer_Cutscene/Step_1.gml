/// @description Input and transforms
input_pressed	= false//keyboard_check_pressed(input);
input_released	= false//keyboard_check_released(input);
input_held		= false//keyboard_check(input);

xscale_sign		= sign(target_xscale);
velocity_sign_x = sign(velocity_x);
velocity_sign_y = sign(velocity_y);

if (velocity_x != 0) {
	last_velocity_x = velocity_x;
}
if (velocity_y != 0) {
	last_velocity_y = velocity_y;
}