#define scr_FireAt
/// scr_FireAt(projectile, target_x, target_y)

var projectile = argument0;
var target_x = argument1;
var target_y = argument2;

var proj = instance_create(x + 32 * dcos( direction ), y - 32 * dsin( direction ), projectile);
proj.direction = point_direction(proj.x, proj.y, target_x, target_y);
proj.image_angle = proj.direction;
proj.Owner = id;

return proj;

#define scr_Fire
/// scr_Fire( Target )
var _Target = argument0;

// Estimate the number of game updates (steps) it will take for the arrow to get to the player.
var num_frames_til_impact = distance_to_point(_Target.x, _Target.y) / ProjectileSpeed;

// Find position the player will be at at the estimated point the arrow will contact them.
var target_next_x = _Target.x + num_frames_til_impact * _Target.hspeed;
var target_next_y = _Target.y + num_frames_til_impact * _Target.vspeed;

// If the shot is invalid, just shoot at where the player is.
if (collision_line(x, y, target_next_x, target_next_y, obj_Wall, false, false) != noone)
{
    target_next_x = _Target.x;
    target_next_y = _Target.y;
}

// Fire the projectile.
var _ball = scr_FireAt(Projectile, target_next_x, target_next_y);