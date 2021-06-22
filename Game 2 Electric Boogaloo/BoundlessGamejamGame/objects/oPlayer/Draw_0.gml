if (state.event_exists( "draw" ) ) {
	state.draw();	
}

draw_xscale = lerp(draw_xscale, target_xscale, lerp_xscale);
draw_yscale = lerp(draw_yscale, target_yscale, lerp_yscale);

draw_sprite_ext(
	sprite_index, image_index, x, y,
	draw_xscale, draw_yscale, 
	draw_angle,
	c_white, 1
);
draw_set_color(c_red);
draw_line(x,y,target_x,target_y);
draw_set_color(c_white);