draw_sprite_ext(sprite_index, image_index, x, y, 
	draw_xscale, draw_yscale, image_angle, image_blend, image_alpha
);

draw_xscale = lerp(draw_xscale, target_xscale, 0.15);
draw_yscale = lerp(draw_yscale, target_yscale, 0.15);