if (grounded) {
	if (input_pressed) {
		charge = 0.4;	
	}
	if (input_held) {
		charge += speed_charge * time_charge * 0.1;
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
	}
} else {
	velocity_y += accelleration_g;
}
