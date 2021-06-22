/// @description Input and transforms
input_pressed	= keyboard_check_pressed(input);
input_released	= keyboard_check_released(input);
input_held		= keyboard_check(input);

xscale_sign = sign(target_xscale);
velocity_sign_x = sign(velocity_x);
velocity_sign_y = sign(velocity_y);
