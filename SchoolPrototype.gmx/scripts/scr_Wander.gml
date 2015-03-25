/// scr_Wander(wander_speed)

var wander_speed = argument0;

var vertical_weight = 0;
var horizontal_weight = 0;

// Determine if we should move up (negative weight) or down (positive weight)
if (!place_free(x, y - 30))
    vertical_weight = 2;
else if (!place_free(x, y + 30))
    vertical_weight = -2;
    
// Determine if we should move left (negative weight) or right (positive weight)
if (!place_free(x - 20, y))
    horizontal_weight = 2;
else if (!place_free(bbox_right + 20, y))
    horizontal_weight = -2;

// If we need to move right
if (horizontal_weight > 0)
    direction = 0;
// If we need to move left
else if (horizontal_weight < 0)
    direction = 180;
// No preference, decide randomly
else
{
    if (irandom(1))
        direction = 0;
    else
        direction = 180;
}

// Pick a random offset to our current direction between 0 and 90 degrees
var offset = irandom(90);

// If we need to move down
if (vertical_weight > 0)
{
    // Move down and to the right (range 270-360)
    if (direction == 0)
        direction = 360 - offset;
    // Move down and to the left (range 180-270)
    else
        direction += offset;
}
// If we need to move up
else if (vertical_weight < 0)
{
    // Move up and to the right (range 0-90)
    if (direction == 0)
        direction += offset;
    // Move up and to the left (range 90-180)
    else
        direction -= offset;
}
// No preference for up or down, decide randomly
else
{
    if (irandom(1))
        direction += offset;
    else
        direction -= offset;
}       

speed = irandom(wander_speed);

