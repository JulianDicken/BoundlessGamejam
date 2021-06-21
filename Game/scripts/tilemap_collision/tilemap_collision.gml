function tilemap_collision() {
	static tm = layer_tilemap_get_id("Collider");
	return tm;
}