/// scr_MeleeAttack(range, weapon)

var range = argument0;
var weap = argument1;

// Create the Sword to attack.
// y offset of instance creation is subtracted since
//  positive y direction is downwards
var weapon = instance_create(x + range * dcos(direction) / 3, 
                            y - range * dsin(direction) / 3, 
                            weap);
// Configure the weapon sprite angle.
weapon.image_angle = direction;
