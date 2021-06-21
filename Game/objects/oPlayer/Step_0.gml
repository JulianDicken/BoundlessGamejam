if (grounded) {
	if (input_pressed) {
		charge = 0.4;	
	}
	if (input_held) {
		charge += speed_charge * time_charge * mod_charge;
		charge = clamp(charge, 0, max_charge);
		time_charge++;
	}
	if (input_released) {
		//do jump
		velocity_y	= max_y * charge;
		velocity_x	= max_x * charge * draw_xscale;
		
		charge		= 0;
		time_charge = 0;
		grounded	= false;
		last_charge = false;
		canGrapple  = true;
	}
} else {
	if (input_pressed && canGrapple) {
		lvelocity_x = velocity_x;
		lvelocity_y = velocity_y;
		velocity_x  = 0;
		velocity_y  = 0;
		isGrappling = true;
		canGrapple  = false;
	
		tongue = instance_create_depth(x, y, 0, oTongue);
		tongue.image_angle	= draw_angle;
		tongue.image_xscale = target_xscale;
	}
	if (isGrappling) {
		time_grapple++;	
		if (time_grapple == max_grapple) {
			//do grapple action
			rx = x + lengthdir_x(length_tongue * sign(draw_xscale), draw_angle);
			ry = y + lengthdir_y(length_tongue * sign(draw_xscale), draw_angle);
			ray = tilemap_raycast(x, y, rx, ry, length_tongue);
			/*
			if (ray != noone) {
				var dx = ray.X - x; var dy = ray.Y - y;
				if (sign(dx) == 1) {
					x = ray.X - (bbox_right - x);	
				} 
				if (sign(dx) == -1) {
					x = ray.X - (bbox_left - x);	
				}
				if (sign(dy) == 1) {
					y = ray.Y - (bbox_bottom - y);	
				} 
				if (sign(dy) == -1) {
					y = ray.Y - (bbox_top - y);	
				}
			}*/
			if (ray != noone) {
				var dir = point_direction(x,y, ray.X, ray.Y);
				lvelocity_x = lengthdir_x(-max_y, dir);	
				lvelocity_y = max_y;
			}
			velocity_x	= lvelocity_x;
			velocity_y	= lvelocity_y;
			//cleanup
			instance_destroy(tongue);
			
			isGrappling		= false;
			time_grapple	= 0;
		}
	} else {
		velocity_y += accelleration_g;		
	}
}