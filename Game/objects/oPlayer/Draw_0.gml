draw_sprite_ext(sprite_index, image_index, x, y, draw_xscale, draw_yscale, draw_angle, image_blend, image_alpha)
if (debug_mode) {
	draw_line_color(x, y, 
		x + lengthdir_x(velocity_x * 10, image_angle),
		y + lengthdir_y(velocity_y * 10, image_angle),
		c_red, c_red
	);
	draw_line_color(x, y, 
		x + velocity_ix * 10 * sign(velocity_x),
		y,
		c_green, c_green
	);
	draw_line_color(x, y, 
		x,
		y + velocity_iy * 10 * sign(velocity_y),
		c_blue, c_blue
	);
	draw_set_color(tilemap_meeting(x,y) ? c_red : c_white);
	draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true)
	draw_circle(x,y,1,false);
	draw_set_color(c_red);
	draw_text(8,8, string(charge))
	draw_set_color(c_white);
}
if (time_ground == 1) {
	draw_xscale = 1.5 * target_xscale;
	draw_yscale = 0.5;
	draw_angle		= 0;
	target_angle	= 0;
	sprite_index = spr_frog_idle;        
}
if (time_air == 1) {
	draw_xscale = 0.5 * target_xscale;
	draw_yscale = 1.5;
	sprite_index = spr_frog_jumping;
}
if (time_charge) {
	if (charge < max_charge) {
		draw_xscale = (1 + charge * 0.2) * sign(target_xscale);
		draw_yscale =  1 - charge * 0.3;		
	}
	if (charge == max_charge && !last_charge) {
		last_charge = true;
		draw_xscale = 0.75 * target_xscale;
		draw_yscale = 1.25;
		sprite_index = spr_frog_charged;
	}
}
if (!grounded) {
	if (sign(target_xscale) == -1) {
		target_angle = max_a;
		if (sign(velocity_y) == -1)    { target_angle = -max_a; }
	} else {
		target_angle = -max_a;
		if (sign(velocity_y) == -1)    { target_angle = max_a; }
	}
}

if (!isGrappling) {
	draw_angle	= lerp(draw_angle,  target_angle, 0.15);
	draw_xscale = lerp(draw_xscale, target_xscale, 0.15);	
	draw_yscale = lerp(draw_yscale, 1, 0.15);	
}