var buffer = argument[ 0 ];
var msgid = buffer_read( buffer , buffer_u8 );

switch( msgid ) {
    case 1:    // Get network ID
        var _netID = buffer_read( buffer, buffer_u8 );
        netID = _netID;
        break;
        /*
    case 1:     // Ping
        var time = buffer_read( buffer , buffer_u32 );
        var Ping = current_time - time;
        break;*/
    case 2:     // Update Position
        var _netID = buffer_read( buffer, buffer_u8 );
        var _x = buffer_read( buffer, buffer_s16 );
        var _y = buffer_read( buffer, buffer_s16 );
        var _direction = buffer_read( buffer, buffer_s16 );
        var _speed = buffer_read( buffer, buffer_s8 );
        with( obj_Player )
            if( netID == _netID )
            {
                x = _x;
                y = _y;
                direction = _direction;
                speed = _speed;
            }
        break;
    case 3:     // Create New Player
        var _netID = buffer_read( buffer, buffer_u8 );
        var _x = buffer_read( buffer, buffer_s16 );
        var _y = buffer_read( buffer, buffer_s16 );
        inst = instance_create( _x, _y, obj_Player );
        inst.netID = _netID;
    case 4:     // Delete Player
        var _netID = buffer_read( buffer, buffer_u8 );
        with( obj_Player )
            if( netID == _netID )
                instance_destroy();
        break;
}
