/// @description Action processing
if (state.event_exists( "step" ) ) {
	state.step();	
}

tongue_distance = clamp(tongue_distance, 0, tongue_max);

target_x = oPlayer.x + (oPlayer.velocity_sign_x *  lengthdir_x(tongue_distance, abs(oPlayer.transformed_angle)));
target_y = oPlayer.y + (-oPlayer.velocity_sign_y * lengthdir_y(tongue_distance, abs(oPlayer.transformed_angle)));