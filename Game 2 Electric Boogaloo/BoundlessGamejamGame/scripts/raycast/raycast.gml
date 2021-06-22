/// @param x0
/// @param y0
/// @param x1
/// @param y1
/// @credit http://playtechs.blogspot.com/2007/03/raytracing-on-grid.html
function raycast(x0, y0, x1, y1) {
    var _dx = abs(x1 - x0);
    var _dy = abs(y1 - y0);
    
    var _x = floor(x0);
    var _y = floor(y0);
    
    var _n = 1;
    var _x_inc, _y_inc;
    var _error;
	
    static tile_layer	= "Collision";
    static _layer_id	= layer_get_id(tile_layer);
    static _tilemap_id	= layer_tilemap_get_id(_layer_id);
    
    if (_dx == 0) {
        _x_inc = 0;
        _error = infinity;
    } else if (x1 > x0) {
        _x_inc = 1;
        _n += floor(x1) - _x;
        _error = (x0 - floor(x0)) * _dy;
    } else {
        _x_inc = -1;
        _n += _x - floor(x1);
        _error = (x0 - floor(x0)) * _dy;
    }
    
    if (_dy == 0) {
        _y_inc = 0;
        _error -= infinity;
    } else if (y1 > y0) {
        _y_inc = 1;
        _n += floor(y1) - _y;
        _error -= (floor(y0) + 1 - y0) * _dx;
    } else {
        _y_inc = -1;
        _n += _y - floor(y1);
        _error -= (y0 - floor(y0)) * _dx;
    }
    
    for (; _n > 0; _n--) {
        if (tilemap_get_at_pixel(_tilemap_id, _x, _y) > 0) {
            return {
				X : _x, Y : _y,	
				tile : tilemap_get_at_pixel(_tilemap_id, _x, _y)
			};
        }
        
        if (_error > 0) {
            _y += _y_inc;
            _error -= _dx;
        } else {
            _x += _x_inc;
            _error += _dy;
        }
    }
    
    return undefined;
}