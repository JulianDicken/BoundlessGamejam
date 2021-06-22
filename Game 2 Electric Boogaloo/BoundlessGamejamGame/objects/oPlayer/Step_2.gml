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

repeat ( dx ) {
	if (!place_meeting(x + velocity_sign_x, y, parSolid)) {
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
		}
		break;
	}
}

repeat ( dy ) {
	if (!place_meeting(x, y + velocity_sign_y, parSolid)) {
		y += velocity_sign_y;
	} else {
		switch state.get_current_state() {
			case states.in_air:
				state.change( states.grounded );
			break;
		}
		velocity_x = 0;
		velocity_y = 0;
		break;
	}
}

x = round(x);
y = round(y);
