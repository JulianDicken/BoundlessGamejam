target_dist = point_distance(x, y, target_x, target_y);
target_dir  = point_direction(x, y, target_x, target_y);

x = target.x;
y = target.y;

tongue_x	= x + lengthdir_x(tongue_length, target_dir);
tongue_y	= y + lengthdir_y(tongue_length, target_dir);

if (state.event_exists( "step" ) ) {
	state.step();	
}
