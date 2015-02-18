var buffer = argument[ 0 ];
var socket = argument[ 1 ];
var msgid = buffer_read( buffer , buffer_u8 );

switch( msgid ) {
    case 1:     // Client wants to know their ID
        /*
        var time = buffer_read( buffer , buffer_u32 );
        buffer_seek( Buffer , buffer_seek_start , 0 );
        buffer_write( Buffer , buffer_u8 , 1 );
        buffer_write( Buffer , buffer_u32 , time );
        network_send_packet( socket , Buffer , buffer_tell( Buffer ) );
        */
        buffer_seek( Buffer, buffer_seek_start, 0 );
        buffer_write( Buffer, buffer_u8, 1 );
        buffer_write( Buffer, buffer_u8, socket );
        network_send_packet( socket, Buffer, buffer_tell( Buffer ) );
        break;
    case 2:     // Received a Position Update from client
        var _x = buffer_read( buffer, buffer_s16 );
        var _y = buffer_read( buffer, buffer_s16 );
        var _dir = buffer_read( buffer, buffer_s16 );
        var _speed = buffer_read( buffer, buffer_s8 );
        for( var s = 0; s < ds_list_size( SocketList ); ++s )
        {
            var _lMap = SocketList[| s ];
            if( _lMap[? "Socket" ] == socket )
            {
                var _pMap = _lMap[? "PositionMap" ];
                _pMap[? "X" ]           = _x;
                _pMap[? "Y" ]           = _y;
                _pMap[? "Direction" ]   = _dir;
                _pMap[? "Speed" ]       = _speed;
            }
        }
        break;
    case 3: // New client connected
        // Send current list to new client
        buffer_seek( Buffer, buffer_seek_start, 0 );
        buffer_write( Buffer, buffer_u8, 3 );
        buffer_write( Buffer, buffer_u8, ds_list_size( SocketList ) - 1 );
        for( var s = 0; s < ds_list_size( SocketList ); ++s )
        {
            var _lMap = SocketList[| s ];
            if( _lMap[? "Socket" ] != socket )
            {
                var _pMap = _lMap[? "PositionMap" ];
                buffer_write( Buffer, buffer_u8, _lMap[? "Socket" ] );
                buffer_write( Buffer, buffer_s16, _pMap[? "X" ] );
                buffer_write( Buffer, buffer_s16, _pMap[? "Y" ] );
                buffer_write( Buffer, buffer_s16, _pMap[? "Direction" ] );
                buffer_write( Buffer, buffer_s8, _pMap[? "Speed" ] );
            }
        }
        network_send_packet( socket, Buffer, buffer_tell( Buffer ) );
        // Send new client to current clients
        buffer_seek( Buffer, buffer_seek_start, 0 );
        buffer_write( Buffer, buffer_u8, 3 );
        buffer_write( Buffer, buffer_u8, 1 );
        for( var s = 0; s < ds_list_size( SocketList ); ++s )
        {
            var _lMap = SocketList[| s ];
            if( _lMap[? "Socket" ] == socket )
            {
                var _pMap = _lMap[? "PositionMap" ];
                buffer_write( Buffer, buffer_u8, socket );
                buffer_write( Buffer, buffer_s16, _pMap[? "X" ] );
                buffer_write( Buffer, buffer_s16, _pMap[? "Y" ] );
                buffer_write( Buffer, buffer_s16, _pMap[? "Direction" ] );
                buffer_write( Buffer, buffer_s8, _pMap[? "Speed" ] );
                for( var s = 0; s < ds_list_size( SocketList ); ++s )
                {
                    _lMap = SocketList[| s ];
                    if( _lMap[? "Socket" ] != socket )
                        network_send_packet( _lMap[? "Socket" ], Buffer, buffer_tell( Buffer ) );
                }
                break;
            }
        }
        break;
    case 4: // Client disconnected
        buffer_seek( Buffer, buffer_seek_start, 0 );
        buffer_write( Buffer, buffer_u8, 4 );
        buffer_write( Buffer, buffer_u8, socket );
        for( var s = 0; s < ds_list_size( SocketList ); ++s )
        {
            _lMap = SocketList[| s ];
            if( _lMap[? "Socket" ] != socket )
                network_send_packet( _lMap[? "Socket" ], Buffer, buffer_tell( Buffer ) );
        }
        break;
    case 5: // Client made an attack
        if( ds_exists( AttackArray[ socket ], ds_type_map ) )
            ds_map_destroy( AttackArray[ socket ] );
        var _aMap = ds_map_create();
        AttackArray[ socket ] = _aMap;
        _aMap[? "Object" ] = buffer_read( buffer, buffer_string );
        _aMap[? "X" ] = buffer_read( buffer, buffer_s16 );
        _aMap[? "Y" ] = buffer_read( buffer, buffer_s16 );
        _aMap[? "Direction" ] = buffer_read( buffer, buffer_s16 );
        /* Send the packet
        buffer_seek( Buffer, buffer_seek_start, 0 );
        buffer_write( Buffer, buffer_u8, 5 );
        buffer_write( Buffer, buffer_s16, _x );
        buffer_write( Buffer, buffer_s16, _y );
        buffer_write( Buffer, buffer_s16, _direction );
        for( var s = 0; s < ds_list_size( SocketList ); ++s )
            if( socket != ds_list_find_value( SocketList, s ) )
                network_send_packet( ds_list_find_value( SocketList, s ), Buffer, buffer_tell( Buffer ) );*/
        break;
    case 6: // Received a ranged attack from client -- DEPRECATE
        var _x = buffer_read( buffer, buffer_s16 );
        var _y = buffer_read( buffer, buffer_s16 );
        var _direction = buffer_read( buffer, buffer_s16 );
        var _speed = buffer_read( buffer, buffer_u8 );
        buffer_seek( Buffer, buffer_seek_start, 0 );
        buffer_write( Buffer, buffer_u8, 6 );
        buffer_write( Buffer, buffer_s16, _x );
        buffer_write( Buffer, buffer_s16, _y );
        buffer_write( Buffer, buffer_s16, _direction );
        buffer_write( Buffer, buffer_u8, _speed );
        for( var s = 0; s < ds_list_size( SocketList ); ++s )
            if( socket != ds_list_find_value( SocketList, s ) )
                network_send_packet( ds_list_find_value( SocketList, s ), Buffer, buffer_tell( Buffer ) );
        break;
}
