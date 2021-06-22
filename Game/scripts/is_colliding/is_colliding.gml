function is_colliding(_x, _y) {
	//static layer = layer_get_id("Collision");
	var inst = instance_place(_x, _y, parCollider);
	return inst != noone;
}