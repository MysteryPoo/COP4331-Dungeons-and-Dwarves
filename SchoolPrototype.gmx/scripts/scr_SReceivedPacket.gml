var buffer = argument[ 0 ];
var socket = argument[ 1 ];
var msgid = buffer_read( buffer , buffer_u8 );

switch( msgid ) {
    case 1:     // Ping
        buffer_seek( Buffer , buffer_seek_start , 0 );
        buffer_write( Buffer , buffer_u8 , 1 );
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
        break;
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
        var _Object = buffer_read( buffer, buffer_string );
        var _x = buffer_read( buffer, buffer_s16 );
        var _y = buffer_read( buffer, buffer_s16 );
        var _dir = buffer_read( buffer, buffer_s16 );
        var _speed = buffer_read( buffer, buffer_u8 );
        for( var s = 0; s < ds_list_size( SocketList ); ++s )
        {
            var _lMap = SocketList[| s ];
            if( _lMap[? "Socket" ] == socket )
            {
                var _aMap = _lMap[? "AttackMap" ];
                _aMap[? "Object" ] = _Object;
                _aMap[? "X" ] = _x;
                _aMap[? "Y" ] = _y;
                _aMap[? "Direction" ] = _dir;
                _aMap[? "Speed" ] = _speed;
            }
        }
        break;
    case 6: // Client is "ready"
        var _ready = buffer_read( buffer, buffer_u8 );
        for( var s = 0; s < ds_list_size( SocketList ); ++s )
        {
            var _lMap = SocketList[| s ];
            if( _lMap[? "Socket" ] == socket )
            {
                _lMap[? "Ready" ] = _ready;
            }
        }
        break;
}