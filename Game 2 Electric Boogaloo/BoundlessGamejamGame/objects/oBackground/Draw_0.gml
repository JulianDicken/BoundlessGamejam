var _offset_1 = 0.7;
var _offset_2 = 0.5;
var _offset_3 = 0.3;

var _camx = camera_get_view_x(view_camera[0]);
var _camy = camera_get_view_y(view_camera[0])

draw_sprite_tiled(spr_background_3, 0, -1000 +  _camx * _offset_1, -1000 + _camy * _offset_1);
draw_sprite_tiled(spr_background_1, 0, -1000 +  _camx * _offset_2, -1000 + _camy * _offset_2);
draw_sprite_tiled(spr_background_2, 0, -1000 +  _camx * _offset_3, -1000 + _camy * _offset_3);