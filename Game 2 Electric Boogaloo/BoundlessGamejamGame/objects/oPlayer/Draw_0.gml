if (state.event_exists( "draw" ) ) {
	state.draw();	
}

draw_xscale = lerp(draw_xscale, target_xscale, lerp_xscale);
draw_yscale = lerp(draw_yscale, target_yscale, lerp_yscale);

draw_sprite_ext(
	sprite_index, image_index, x, y,
	draw_xscale, draw_yscale, 
	image_angle,
	c_white, 1
);
draw_bbox();

var tx = x + lengthdir_x(32, image_angle);
var ty = y + lengthdir_y(32, image_angle);
draw_line(x,y,tx,ty)