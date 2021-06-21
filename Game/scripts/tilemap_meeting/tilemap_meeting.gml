///@args{real}x,{real}y,{tilemap}tilemap
function tilemap_meeting(_x, _y) {
	var value = tilemap_get_at_pixel(tilemap_collision(), _x, _y);
	return value != 0 && value != 1;
}
