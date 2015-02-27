image_speed = 0;

if (position_meeting(mouse_x, mouse_y, self))
{
    if(left_pressed)
        image_index = 2;
    else
        image_index = 1;
}
else
{
    image_index = 0;   
    
    left_pressed = false;
}
