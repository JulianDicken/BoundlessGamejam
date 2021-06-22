input = vk_space;

velocity_x = 0;
velocity_y = 0;
velocity_sign_x = 0;
velocity_sign_y = 0;
velocity_jump_x = 4;
velocity_jump_y = -8;
accelleration_gravity = 0.3;

collision_x = false;
collision_y	= false;

draw_xscale		= 1;
draw_yscale		= 1;
target_xscale	= 1;
target_yscale	= 1;
lerp_xscale		= 0.1;
lerp_yscale		= 0.1;
xscale_sign		= 1;

draw_angle		= 0;
target_angle	= 0;

charge				= 0;
charge_max			= 1;
charge_speed		= 0.05;
charge_time			= 0;
charge_full_once	= false;
charge_tap_time		= room_speed * 0.1; //x seconds
charge_tap_angle	= 15;
charge_normal_angle = 45;
charge_full_angle	= 75;

states = {
	idle		: "idle",
	charging	: "charging",
	jumping		: "jumping",
	in_air		: "in_air",
	grounded	: "grounded",
	grappling	: "grappling",
}

state = new SnowState(states.in_air);
state.add( 
	states.idle, {
		enter : function() {
			sprite_index	= spr_frog_idle;
			draw_angle		= 0;
		},
		step : function() {
			if (!place_meeting(x, y + 1, parSolid)) {
				state.change( states.in_air );
			}
			if (input_pressed) {
				state.change( states.charging );	
			}
		}
	} 
); 
state.add( 
	states.charging, {
		enter : function() {
			charge = 0.25;
			charge_time = 0;
			charge_full_once = true;
		},
		step : function() {
			if (input_released) {
				state.change( states.jumping );	
			}
			charge_time++;
			charge += charge_speed;
			charge = clamp(charge, 0, charge_max);
		},
		draw : function() {
			if (charge < charge_max) {
				draw_xscale = (1 + (charge * 0.3)) * xscale_sign;
				draw_yscale = 1 - (charge * 0.3);
			} else {
				if (charge_full_once) {
					charge_full_once = false;
					
					sprite_index = spr_frog_charging;
					draw_xscale = 0.7 * xscale_sign;
					draw_yscale = 1.3;
				}
			}
		}
	} 
);
state.add(
	states.jumping, {
		enter : function() {
			sprite_index	= spr_frog_jumping;
			
			velocity_x		= velocity_jump_x * xscale_sign * charge;
			velocity_y		= velocity_jump_y * charge;
			
			state.change( states.in_air );
		}
	}
);
state.add(
	states.in_air, {
		enter : function() {
			if (charge_time < charge_tap_time) {
				target_angle = charge_tap_angle;	
			} else {
				target_angle = charge_normal_angle;
				if (charge == charge_max) {
					target_angle = charge_full_angle;
				}
			}
		},
		step  : function() {
			velocity_y += accelleration_gravity
		},
		leave : function() {
			
		}
	}
);
state.add(
	states.grounded, {
		enter : function() {
			draw_xscale		= 1.4 * xscale_sign;
			draw_yscale		= 0.4;
			
			state.change( states.idle );
		}
	}
);