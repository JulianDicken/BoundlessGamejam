///@args{real}x,{real}y,{tilemap}tilemap
function tilemap_meeting(_x, _y) {
	return tilemap_get_at_pixel(tilemap_collision(), _x, _y) != 0;
}
