function tilemap_raycast(_x, _y, _rx, _ry)
{
    #macro TILE_SIZE 16
    #macro TILE_SIZE_M1 15
    _map = tilemap_collision();
	range = 6;
    _rx -= _x;
    _ry -= _y;
    var _dir = arctan2(_ry, _rx);
    _rx = cos(_dir);
    _ry = sin(_dir);
    
    var _sizeX = sqrt(1 + (_ry / _rx) * (_ry / _rx)),
        _sizeY = sqrt(1 + (_rx / _ry) * (_rx / _ry)),
        _mapX  = _x div TILE_SIZE, 
        _mapY  = _y div TILE_SIZE,
        _stepX = sign(_rx), 
        _stepY = sign(_ry);
    
    if (_rx < 0) var _lengthX = (_x - (_x &~ TILE_SIZE_M1)) / TILE_SIZE * _sizeX;
    else var _lengthX = ((_x &~ TILE_SIZE_M1) + TILE_SIZE - _x) / TILE_SIZE *_sizeX;
    
    if (_ry < 0) var _lengthY = (_y - (_y &~ TILE_SIZE_M1)) / TILE_SIZE * _sizeY;
    else var _lengthY = ((_y &~ TILE_SIZE_M1) + TILE_SIZE - _y) / TILE_SIZE *_sizeY;
    
    for (var _d = 0; _d < range; _d++)
    {
        if (_lengthX < _lengthY)
        {
            _mapX += _stepX;
            if (tilemap_get(_map, _mapX, _mapY) & tile_index_mask != 0) 
            {
                _lengthX *= TILE_SIZE;
                return { X : _x + _rx * _lengthX, Y : _y + _ry* _lengthX }
            }
            _lengthX += _sizeX;
        }
        else 
        {
            _mapY += _stepY;
            if (tilemap_get(_map, _mapX, _mapY) & tile_index_mask != 0) 
            {
                _lengthY *= TILE_SIZE;
                return { X : _x + _rx * _lengthY, Y : _y + _ry * _lengthY }
            }
            _lengthY += _sizeY;
        }   
    }
    
    return noone;
}