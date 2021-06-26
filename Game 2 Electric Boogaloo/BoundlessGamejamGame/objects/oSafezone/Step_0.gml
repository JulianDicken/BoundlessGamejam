if (place_meeting(x,y, oPlayer)) {
	if (!recently_collided) {
		recently_collided = true;
		
		save_data = {
			X: oPlayer.x,
			Y: oPlayer.y,
			T: oPlayer.time,
			S: oPlayer.state.get_current_state()
		}

	}
} else {
	recently_collided = false;	
}