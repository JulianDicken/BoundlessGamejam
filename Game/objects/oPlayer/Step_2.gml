velocity_ix = abs(round(velocity_x));
velocity_iy = abs(round(velocity_y)) + 1;

repeat( velocity_iy ) {
    if (!tilemap_meeting( x, y + sign(velocity_y)) ) {
        y += sign(velocity_y);
    } else {
		velocity_x	= 0;
		velocity_y	= 0;
		grounded	= true;
		break;
	}
}

repeat( velocity_ix ) {
    if (!tilemap_meeting( x + sign(velocity_x), y) ) {
        x += sign(velocity_x);
    } else {
		if (grounded) {
			velocity_x = 0;	
		} else {
			velocity_x *= -0.75;	
		}
		break;
	}
}

if (tilemap_meeting(x, bbox_top)) {
	while( tilemap_meeting(x, bbox_top + 1) ) { y++; }
	velocity_x *= 0.5;
	velocity_y = 0;
	grounded = false;
}