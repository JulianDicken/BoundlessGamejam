#macro TO_ANGLE (180 / 3.1415)

input = vk_space;

velocity_x = 0;
velocity_y = 0;
last_velocity_x = 0;
last_velocity_y = 0;
velocity_sign_x = 0;
velocity_sign_y = 0;
velocity_jump_x = 4;
velocity_jump_y = -8;
accelleration_gravity = 0.3;

draw_xscale		= 1;
draw_yscale		= 1;
target_xscale	= 1;
target_yscale	= 1;
lerp_xscale		= 0.1;
lerp_yscale		= 0.1;
xscale_sign		= 1;

draw_angle		= 0;
transformed_angle = 0;
target_angle	= 0;

charge				= 0;
charge_max			= 1;
charge_speed		= 0.05;
charge_time			= 0;
charge_full_once	= false;
charge_tap_time		= room_speed * 0.15; //x seconds
charge_tap_angle	= 15;
charge_normal_angle = 45;
charge_full_angle	= 60;

ray			= undefined;
ray_length	= 96;
target_x	= 0;
target_y	= 0;

can_grapple		= false;
grapple_time	= 0;
hangtime		= room_speed * 0.25;

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
		},
		step : function() {
			if (!is_colliding(x, y + 1)) {
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
			
			audio_sound_pitch(sfx_charge, 0.7)
			if (!audio_is_playing(sfx_charge)) {
				audio_play_sound(sfx_charge, 1, true);
			}
		},
		step : function() {
			if (input_released) {
				state.change( states.jumping );	
			}
			charge_time++;
			charge += charge_speed;
			charge = clamp(charge, 0, charge_max);
			
			audio_sound_pitch(sfx_charge, 0.8 + (charge * 0.5))
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
		},
		leave : function() {
			if (audio_is_playing(sfx_charge)) {
				audio_stop_sound(sfx_charge)	
			}
		}
	} 
);
state.add(
	states.jumping, {
		enter : function() {
			sprite_index	= spr_frog_jumping;
			can_grapple		= true;
			
			velocity_x		= velocity_jump_x * xscale_sign * charge;
			velocity_y		= velocity_jump_y * charge;
			
			if (!audio_is_playing(sfx_jump)) {
				audio_sound_pitch(sfx_jump, 0.7 + (charge * 0.5))
				audio_play_sound(sfx_jump, 1, false);
			}
			
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
		step : function() {
			velocity_y += accelleration_gravity;
			if (input_pressed) {
				state.change( states.grappling );	
			}
		},
		draw : function() {
			switch velocity_sign_y {
				case -1:
					switch velocity_sign_x {
						case -1:
							transformed_angle = -target_angle;
						break;
						case 1:
							transformed_angle = target_angle;
						break;
					}
				break;
				case  1:
					switch velocity_sign_x {
						case -1:
							transformed_angle = TO_ANGLE * arctan(velocity_y);
						break;
						case 1:
							transformed_angle = TO_ANGLE * -arctan(velocity_y);
						break;
					}
				break;
			}
		}
	}
);
state.add(
	states.grounded, {
		enter : function() { 
			draw_xscale		= 1.4 * xscale_sign;
			draw_yscale		= 0.4;
			transformed_angle = 0;
			draw_angle = 0;
			
			if (!audio_is_playing(sfx_land)) {
				audio_sound_pitch(sfx_land, random_range(0.8, 1))
				audio_play_sound(sfx_land, 1, false);
			}
			state.change( states.idle );
		}
	}
);
state.add(
	states.grappling, {
		enter : function() {
			if (can_grapple) {	
				can_grapple		= false;
				grapple_time	= 0;
				
				target_x	= x + lengthdir_x(ray_length * velocity_sign_x, target_angle);
				target_y	= y + lengthdir_y(ray_length * -velocity_sign_y,target_angle);
				
				//TODO Flies
				ray = collision_line(x , y, target_x, target_y, parBoost, false, true);
				
				tongue = instance_create_depth(x, y, depth + 1, oTongue)
				tongue.image_angle	= transformed_angle;
				tongue.image_xscale = xscale_sign;
				tongue.max_length	= ray_length;
				tongue.target		= id;
				
				if (ray != noone) {
					velocity_x = 0;
					velocity_y = 0;
				} else {
					state.change( states.in_air, false );	
				}
				
				if (!audio_is_playing(sfx_tongue)) {
					audio_sound_pitch(sfx_tongue, random_range(0.8, 1.2))
					audio_play_sound(sfx_tongue, 1, false);
				}
			} else {
				state.change( states.in_air, false );	
			}
		},
		step : function() {
			grapple_time++;
			if (grapple_time >= hangtime) {
				state.change( states.in_air );	
			}
		},
		leave : function() {
			VFX_FLASH
			if (!audio_is_playing(sfx_catch_fly)) {
				audio_sound_pitch(sfx_catch_fly, random_range(0.9, 1.1))
				audio_play_sound(sfx_catch_fly, 1, false);
			}
			ray.draw_xscale = 1.8 * target_yscale;
			ray.draw_yscale = 0.3;
			
			velocity_x = velocity_jump_x * xscale_sign;
			velocity_y = velocity_jump_y;
		}
	}
);