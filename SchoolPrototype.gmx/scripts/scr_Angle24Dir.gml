/// scr_Angle24Dir( Angle )
/*
    This script converts an angle in degrees into
    the corresponding 4-directional facing angle.
*/
var _Angle = argument0;

if( _Angle < 45 || _Angle > 315 )
{
    return 90;
}
else if( _Angle < 135 )
    return 180;
else if( _Angle < 225 )
{
    return -90;
}
else
    return 0;
