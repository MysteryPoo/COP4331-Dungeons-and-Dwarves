/// scr_FireAt(projectile, target_x, target_y)

var projectile = argument0;
var target_x = argument1;
var target_y = argument2;

var proj = instance_create(x, y, projectile);
proj.direction = point_direction(proj.x, proj.y, target_x, target_y);
proj.image_angle = proj.direction;
proj.Owner = id;