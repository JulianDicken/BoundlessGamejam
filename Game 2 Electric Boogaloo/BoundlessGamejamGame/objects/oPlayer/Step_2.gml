/// @description Collissions

var dx;
switch velocity_sign_x {
	case -1:
		dx = abs(floor(velocity_x));
	break;
	case 1: 
		dx = abs(ceil(velocity_x));
	break;
	default : 
		dx = 0;
	break;
}
var dy;
switch velocity_sign_y {
	case -1:
		dy = abs(floor(velocity_y));
	break;
	case 1: 
		dy = abs(ceil(velocity_y));
	break;
	default : 
		dy = 0;
	break;
}

repeat ( dy ) {
	if (!is_colliding(x, y + velocity_sign_y)) {
		y += velocity_sign_y;
	} else {
		switch state.get_current_state() {
			case states.in_air:
				state.change( states.grounded );
			break;
		}
		while (is_colliding(x , y)) {
			y += -velocity_sign_y;	
		}
		if (is_colliding(x, y + 1)) {
			velocity_x = 0;	
		}
		velocity_y = 0;
		break;
	}
}
repeat ( dx ) {
	if (!is_colliding(x + velocity_sign_x, y)) {
		x += velocity_sign_x;	
	} else {
		switch state.get_current_state() {
			case states.in_air:
				velocity_x		*= -1;
				target_xscale	*= -1;
				draw_xscale		*= -1;
			break;
			default : 
				velocity_x = 0;
			break;
			while (is_colliding(x, y)) {
				x += -velocity_sign_x;	
			}
		}
		break;
	}
}
x = round(x);
y = round(y);
