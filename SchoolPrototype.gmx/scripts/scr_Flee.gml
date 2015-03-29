/// scr_Flee( flee_speed, flee_from)

var _FleeSpeed = argument0;
var _FleeFrom = argument1;
if( _FleeFrom == noone )
    exit;

if (_FleeFrom.x < x)
    hspeed = _FleeSpeed;
else if (_FleeFrom.x > x)
    hspeed = -_FleeSpeed;

if (_FleeFrom.y < y)
    vspeed = _FleeSpeed;
else if (_FleeFrom.y > y)
    vspeed = -_FleeSpeed;