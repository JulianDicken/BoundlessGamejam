#macro TO_ANGLE (180 / 3.1415)


input = vk_space;
instance_create_depth(x,y,depth, oCamera)

velocity_x = 0;
velocity_y = 0;
last_velocity_x = 0;
last_velocity_y = 0;
velocity_sign_x = 0;
velocity_sign_y = 0;
velocity_grapple = 4; 
velocity_jump = 7;
accelleration_gravity = 0.2;

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
charge_speed		= 0.03;
charge_time			= 0;
charge_full_once	= false;
charge_tap_time		= room_speed * 0.15; //x seconds
charge_tap_angle	= 60;
charge_normal_angle = 40;
charge_full_angle	= 80;

ray			= undefined;
ray_length	= 96;
target_x	= 0;
target_y	= 0;
tongue		= noone;

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
	fly_hit		: "fly_hit"
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
			
			if (charge_time < charge_tap_time) {
				target_angle = charge_tap_angle;	
			} else {
				target_angle = charge_normal_angle;
				if (charge == charge_max) {
					target_angle = charge_full_angle;
				}
			}
			
			var _xmultiplier = abs(dcos(target_angle));
			var _ymultiplier = abs(dsin(target_angle));
			
			velocity_x		= velocity_jump * _xmultiplier * xscale_sign * charge;
			velocity_y		= -velocity_jump * _ymultiplier * charge;
			
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
			switch velocity_sign_x {
				case -1:
					transformed_angle = TO_ANGLE * arctan(velocity_y);
				break;
				case 1:
					transformed_angle = TO_ANGLE * -arctan(velocity_y);
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
				
				target_x = x + (velocity_sign_x  * lengthdir_x(ray_length, abs(transformed_angle)));
				target_y = y + (-velocity_sign_y * lengthdir_y(ray_length, abs(transformed_angle)));
				
				ray = collision_line(x , y, target_x, target_y, parBoost, false, true);
				tongue = instance_create_depth(x, y, depth + 1, oTongue)
				tongue.image_angle = transformed_angle;
				if (ray == noone) {
					state.change( states.in_air );
					tongue.target_x = target_x;
					tongue.target_y = target_y;
					tongue.tongue_speed *= 2;
				} else {
					var dir = point_direction(x,y,target_x, target_y);
					velocity_x = lengthdir_x(velocity_grapple, dir);
					velocity_y = lengthdir_y(velocity_grapple, dir);
					tongue.target_x = ray.x;
					tongue.target_y = ray.y;
				}
			} else {
				state.change( states.in_air );
			}
				
		},
		step : function() {
			grapple_time++;
			if (grapple_time >= hangtime) {
				VFX_FLASH
				ray.draw_xscale = 1.8 * ray.target_xscale;
				ray.draw_yscale = 0.3;
				if (!audio_is_playing(sfx_catch_fly)) {
					audio_sound_pitch(sfx_catch_fly, random_range(0.9, 1.1))
					audio_play_sound(sfx_catch_fly, 1, false);
				}
				state.change( states.fly_hit );
			}
		}
	}
);

state.add( 
	states.fly_hit, {
		enter : function() {
			charge = 1;
			charge_time = charge_max;
			state.change( states.jumping );
		}
	}
);