with (oLogo) {
	if (fade == 0 && transitioning && other.pressed) {
		global.do_load = false;
		room_goto(rm_main);	
	}	
	other.image_alpha = image_alpha;
}