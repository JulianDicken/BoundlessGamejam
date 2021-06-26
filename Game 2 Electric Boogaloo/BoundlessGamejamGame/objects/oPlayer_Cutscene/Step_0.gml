/// @description Action processing
if (state.event_exists( "step" ) ) {
	state.step();	
}

if (camera.y > fade_trigger_y && !fade_trigger_y_once) {
	fade_trigger_y_once = true;
	instance_create_depth(0,0,-999, oFade)
}
if (camera.y > logo_trigger_y) {
	room_goto(rm_logo)
}