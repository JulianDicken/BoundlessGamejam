#macro ONE_WAY 1
#macro SOLID 2
#macro BOOST 3


function is_colliding(_x, _y) {
	static tile_layer = "Collision";
    static _layer_id = layer_get_id(tile_layer);
    static _tilemap_id = layer_tilemap_get_id(_layer_id);
	
	switch tilemap_get_at_pixel(_tilemap_id, _x, _y) {
		case SOLID:
			return true;
		break;
		case ONE_WAY:
			if (velocity_sign_y == -1) { return false }
			
			return bbox_bottom >= ((y div 16) * 16);
		break;
		default:
			return false;
		break;
	}
}