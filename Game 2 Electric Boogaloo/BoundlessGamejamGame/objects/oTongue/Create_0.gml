/// @description Insert description here
// You can write your code in this editor

tongue_distance = 0;
tongue_max = 40;
tongue_speed = 15;

states = { 
	out		: "out",
	in		: "in",
	hooked	: "hooked"
}

target_x = oPlayer.x + (oPlayer.velocity_sign_x *  lengthdir_x(tongue_distance, abs(oPlayer.transformed_angle)));
target_y = oPlayer.y + (-oPlayer.velocity_sign_y * lengthdir_y(tongue_distance, abs(oPlayer.transformed_angle)));

state = new SnowState(states.out);
state.add( 
	states.out, {
		enter : function() {
			
		},
		step : function() {
			tongue_distance += tongue_speed;
			
			if (instance_place(target_x, target_y, oFly) != noone){
				state.change( states.hooked );
			} else if (tongue_distance >= tongue_max){
				state.change( states.in );
			}
		}
	} 
); 

state.add( 
	states.in, {
		enter : function() {
			
		},
		step : function() {
			tongue_distance -= tongue_speed;
			
			if (instance_place(target_x, target_y, oFly) != noone){
				state.change( states.hooked );
			} else if (tongue_distance <= 0){
				instance_destroy();
			}
		}
	} 
); 

state.add( 
	states.hooked, {
		enter : function() {
			
		},
		step : function() {
			if point_distance(target_x, target_y, oPlayer.x, oPlayer.y) <= 2{
				instance_destroy();
			}
		}
	} 
); 

