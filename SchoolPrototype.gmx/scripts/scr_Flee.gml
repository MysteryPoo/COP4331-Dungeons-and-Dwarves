/// scr_Flee(flee_speed)

var flee_speed = argument0;

if (global.MyInst.x < x)
    hspeed = FleeSpeed;
else if (global.MyInst.x > x)
    hspeed = -FleeSpeed;

if (global.MyInst.y < y)
    vspeed = FleeSpeed;
else if (global.MyInst.y > y)
    vspeed = -FleeSpeed;
