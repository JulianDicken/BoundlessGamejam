velocity_ix = abs(round(velocity_x));
velocity_iy = abs(round(velocity_y)) + 1;

repeat( velocity_iy ) {
    if (!is_colliding( x, y + sign(velocity_y)) ) {
        y += sign(velocity_y);
    } else {
		velocity_x	= 0;
		velocity_y	= 0;
		grounded	= true;
		canGrapple	= false; 
		break;
	}
}

repeat( velocity_ix ) {
    if (!is_colliding( x + sign(velocity_x), y) ) {
        x += sign(velocity_x);
    } else {
		if (grounded) {
			velocity_x = 0;	
		} else {
			velocity_x	*= -0.75;	
			draw_xscale *= -1;
		}
		break;
	}
}

var dy = bbox_top; repeat( abs(bbox_top - y) ) { dy++;
	if (is_colliding(x, dy)) { 
		grounded = false;
		velocity_y *= -0.5;
		y++; 
	} 
}