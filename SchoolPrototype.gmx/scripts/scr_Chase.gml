/// scr_Chase( chase_speed, target )

var chase_speed = argument0;
var _Target = argument1;

mp_potential_step( _Target.x, _Target.y, chase_speed, false);