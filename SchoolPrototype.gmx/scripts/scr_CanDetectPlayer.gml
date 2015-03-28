/// scr_CanDetectPlayer(detection_radius)

var _DetectionRadius = argument0;
var _Nearest = instance_nearest( x, y, obj_Dwarf );

// Check that the player is close enough to detect.
if (distance_to_object(_Nearest) < _DetectionRadius * _Nearest.image_alpha)
{
    // Check that the player is in line of sight.
    if (collision_line(x, y, _Nearest.x, _Nearest.y, obj_Wall, false, true) == noone)
    {
        return true;
    }
}

// Couldn't detect the player.
return false;