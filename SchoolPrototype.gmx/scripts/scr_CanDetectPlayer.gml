/// scr_CanDetectPlayer(detection_radius)

var detection_radius = argument0;

// Check that the player is close enough to detect.
if (distance_to_object(obj_Dwarf) < detection_radius * global.MyInst.image_alpha)
{
    // Check that the player is in line of sight.
    if (collision_line(x, y, global.MyInst.x, global.MyInst.y, obj_Wall, false, true) == noone)
    {
        return true;
    }
}

// Couldn't detect the player.
return false;
