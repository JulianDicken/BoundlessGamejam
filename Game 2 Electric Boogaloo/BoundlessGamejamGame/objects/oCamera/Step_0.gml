dir = point_direction(x,y,mouse_x, mouse_y);
d	= min(view_dist, point_distance(x,y,mouse_x,mouse_y));
dx	= lengthdir_x(d, dir);
dy	= lengthdir_y(d, dir);

x = lerp(x, target.x + dx, follow_speed);
y = lerp(y, target.y + dy, follow_speed);
