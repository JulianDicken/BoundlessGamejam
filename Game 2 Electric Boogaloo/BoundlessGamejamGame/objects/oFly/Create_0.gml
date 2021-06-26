draw_xscale = 1;
draw_yscale = 1;
target_xscale = image_yscale;
target_yscale = 1;

states = {
	spawning : "spawning",
	alive : "alive",
	dead : "dead"
}

state = new SnowState( states.alive );

state.add(
	states.spawning, {
		enter : function() {
			sprite_index = spr_fly_respawn;	
		},
		step : function() {
			if (floor(image_index) == image_number - 1) {
				state.change( states.alive );
			}
		}
	}
);

state.add( 
	states.alive, {
		enter : function() {
			sprite_index = spr_fly;	
		}
	}
);

state.add( 
	states.dead, {
		enter : function() {
			sprite_index = spr_fly_dead;	
		},
		step : function() {
			if (floor(image_index) == image_number - 1) {
				state.change( states.spawning );
			}
		}
	}
);

