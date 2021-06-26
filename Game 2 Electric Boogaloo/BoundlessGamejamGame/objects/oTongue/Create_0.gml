target_x = 0;
target_y = 0;
target_dist = 0;
target_dir	= 0;
target_sign_dx = sign(target_x - x);
target_sign_dy = sign(target_y - y);

tongue_length = 0;
tongue_speed  = 16;
tongue_max_length = 96;
tongue_x = x;
tongue_y = y;
target = noone;

states = {
	in		: "in",
	out		: "out",
	hooked	: "hooked",
}

state = new SnowState(states.out);

state.add( 
	states.out, {
		step : function() {
			if (place_meeting(tongue_x, tongue_y, parBoost)) {
				state.change( states.hooked );
				return;	
			}
			if (tongue_length >= tongue_max_length) {
				state.change( states.in );	
				return;
			}
			tongue_length += tongue_speed;
			tongue_length = clamp(tongue_length,0,tongue_max_length);
		}
	}
);

state.add( 
	states.in, {
		step : function() {
			if (tongue_length <= tongue_speed) {
				instance_destroy();
			}
			tongue_length -= tongue_speed;
		}
	}
);

state.add( 
	states.hooked, {
		step : function() {
			if (sign(target_x - x) != target_sign_dx) {
				state.change( states.in );
				return;
			}
			if (sign(target_y - y) != target_sign_dy) {
				state.change( states.in );	
				return;
			}
			if (target_dist >= tongue_max_length) {
				instance_destroy();
			}
			
			target_sign_dx = sign(target_x - x);
			target_sign_dy = sign(target_y - y);
		}
	}
);