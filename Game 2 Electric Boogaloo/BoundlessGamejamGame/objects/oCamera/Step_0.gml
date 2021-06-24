dx	= lengthdir_x(10 * target.velocity_x, target.draw_angle);
dy	= lengthdir_y(10 * target.velocity_y, target.draw_angle);

x = lerp(x, target.x + dx, follow_speed);
y = lerp(y, target.y + dy, follow_speed);
