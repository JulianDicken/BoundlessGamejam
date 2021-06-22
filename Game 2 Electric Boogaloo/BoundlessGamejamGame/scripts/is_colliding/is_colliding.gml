function is_colliding(_x, _y) {
	
	if (_x < 0 || _x > room_width || _y < 0 || _y > room_height) {
		return true;	
	}
	
	if (place_meeting(_x, _y, parSolid)) {
		return true;	
	}
	
	var inst = instance_place(_x, _y, parOneway);
	if (inst != noone) {
		if (velocity_sign_y == -1) { return false; }
		return bbox_bottom + 1 >= inst.bbox_top
	}
}