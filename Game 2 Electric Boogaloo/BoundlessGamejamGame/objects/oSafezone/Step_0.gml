if (place_meeting(x,y, oPlayer)) {
	if (!recently_collided) {
		recently_collided = true;
		
		save_data = {
			X: oPlayer.x,
			Y: oPlayer.y,
			T: oPlayer.time.elapsed(),
			S: oPlayer.state.get_current_state()
		}	
		
		var raw_data = snap_to_json(save_data);
		var encrypted_data = base64_encode(raw_data);
		var file = file_text_open_write("save_data.txt");
		file_text_write_string(file, encrypted_data);
		file_text_close(file);
	}
} else {
	recently_collided = false;	
}