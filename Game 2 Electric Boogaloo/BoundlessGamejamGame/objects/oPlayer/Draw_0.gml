if (state.event_exists( "draw" ) ) {
	state.draw();	
}

draw_xscale = lerp(draw_xscale, target_xscale, lerp_xscale);
draw_yscale = lerp(draw_yscale, target_yscale, lerp_yscale);
draw_angle	= lerp(draw_angle, transformed_angle, 0.25);

draw_sprite_ext(
	sprite_index, image_index, x, y,
	draw_xscale, draw_yscale, 
	draw_angle,
	c_white, 1
);

draw_line(x,y,
	x + (velocity_sign_x *  lengthdir_x(ray_length, abs(transformed_angle))),
	y + (-velocity_sign_y * lengthdir_y(ray_length, abs(transformed_angle)))
);