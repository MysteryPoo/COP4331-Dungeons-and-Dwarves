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
        for( var s = 0; s < ds_list_size( PlayerList ); ++s )
        {
            var _lMap = PlayerList[| s ];
            if( _lMap[? "Socket" ] == socket )
            {
                var _pMap = _lMap[? "PositionMap" ];
                if( Map == "rm_Client" )
                {
                    if( point_distance( _pMap[? "X" ], _pMap[? "Y" ], _x, _y ) < 32 )
                    {
                        _pMap[? "X" ]           = _x;
                        _pMap[? "Y" ]           = _y;
                        _pMap[? "Direction" ]   = _dir;
                        _pMap[? "Speed" ]       = _speed;
                    }
                }
                else
                {
                    _pMap[? "X" ]           = _x;
                    _pMap[? "Y" ]           = _y;
                    _pMap[? "Direction" ]   = _dir;
                    _pMap[? "Speed" ]       = _speed;
                }
                break;
            }
        }
        break;
    case 3: // Name Request  -- DEPRECATED
        buffer_seek( Buffer, buffer_seek_start, 0 );
        buffer_write( Buffer, buffer_u8, 7 );
        buffer_write( Buffer, buffer_u8, ds_list_size( PlayerList ) );
        for( var s = 0; s < ds_list_size( PlayerList ); ++s )
        {
            var _lMap = PlayerList[| s ];
            buffer_write( Buffer, buffer_u8, _lMap[? "Socket" ] );
            buffer_write( Buffer, buffer_string, _lMap[? "Name" ] );
        }
        network_send_packet( socket, Buffer, buffer_tell( Buffer ) );
        break;
    case 4: // Set Name -> Client requesting a player slot
        var _name = buffer_read( buffer, buffer_string );
        if( ds_list_size( PlayerList ) < 8 )
        {
            var _lMap = ds_map_create();
            _lMap[? "Socket" ]  = socket;
            _lMap[? "Instance" ] = noone;
            _lMap[? "Name" ]    = _name;
            _lMap[? "Ready" ] = false;
            var _pMap = ds_map_create();
            _pMap[? "X" ]       = 100;
            _pMap[? "Y" ]       = 100;
            _pMap[? "Direction" ] = 0;
            _pMap[? "Speed" ] = 0;
            _lMap[? "PositionMap" ] = _pMap;
            var _gMap = ds_map_create();
            _gMap[? "X" ] = 0;
            _gMap[? "Y" ] = 0;
            _lMap[? "GestureMap" ] = _gMap;
            ds_list_add( PlayerList, _lMap );
            StartTimer = 30 * 60;   // Reset countdown until game start
            // Update player count on Lobby Server
            buffer_seek( Buffer, buffer_seek_start, 0 );
            buffer_write( Buffer, buffer_u8, 2 );
            buffer_write( Buffer, buffer_u8, ds_list_size( PlayerList ) );
            network_send_packet( LobbyServer, Buffer, buffer_tell( Buffer ) );
            // Reset Ready status
            for( var s = 0; s < ds_list_size( PlayerList ); ++s )
            {
                var _lMap = PlayerList[| s ];
                _lMap[? "Ready" ] = false;
            }
        }
        if( ds_list_size( PlayerList ) > 1 && State != "Running" )
            State = "Gathering";
        /*for( var s = 0; s < ds_list_size( PlayerList ); ++s )
        {
            var _lMap = PlayerList[| s ];
            if( _lMap[? "Socket" ] == socket )
            {
                _lMap[? "Name" ] = _name;
                break;
            }
        }*/
        buffer_seek( Buffer, buffer_seek_start, 0 );
        buffer_write( Buffer, buffer_u8, 7 );
        buffer_write( Buffer, buffer_u8, 1 );
        buffer_write( Buffer, buffer_u8, socket );
        buffer_write( Buffer, buffer_string, _name );
        for( var s = 0; s < ds_list_size( SocketList ); ++s )
        {
            network_send_packet( SocketList[| s ], Buffer, buffer_tell( Buffer ) );
        }
        break;
    case 5: // Client made an attack
        var _Object = buffer_read( buffer, buffer_string );
        var _x = buffer_read( buffer, buffer_u16 );
        var _y = buffer_read( buffer, buffer_u16 );
        var _dir = buffer_read( buffer, buffer_s16 );
        var _aMap = ds_map_create();
        _aMap[? "Socket" ] = socket;
        _aMap[? "Object" ] = _Object;
        _aMap[? "X" ] = _x;
        _aMap[? "Y" ] = _y;
        _aMap[? "Direction" ] = _dir;
        ds_queue_enqueue( AttackQueue, _aMap );
        break;
    case 6: // Client is "ready"
        var _ready = buffer_read( buffer, buffer_bool );
        for( var s = 0; s < ds_list_size( PlayerList ); ++s )
        {
            var _lMap = PlayerList[| s ];
            if( _lMap[? "Socket" ] == socket )
            {
                _lMap[? "Ready" ] = _ready;
                // Notify Clients
                buffer_seek( Buffer, buffer_seek_start, 0 );
                buffer_write( Buffer, buffer_u8, 6 );
                buffer_write( Buffer, buffer_u8, 1 );
                buffer_write( Buffer, buffer_u8, _lMap[? "Socket" ] );
                buffer_write( Buffer, buffer_bool, _lMap[? "Ready" ] );
                for( var s = 0; s < ds_list_size( SocketList ); ++s )
                {
                    network_send_packet( SocketList[| s ] , Buffer, buffer_tell( Buffer ) );
                }
                break;
            }
        }
        break;
    case 7: // Update map
        var _map = buffer_read( buffer, buffer_u8 );
        for( var s = 0; s < ds_list_size( PlayerList ); ++s )
        {
            var _lMap = PlayerList[| s ];
            if( _lMap[? "Socket" ] == socket )
            {
                _lMap[? "Map" ] = _map;
                break;
            }
        }
        buffer_seek( Buffer, buffer_seek_start, 0 );
        buffer_write( Buffer, buffer_u8, 8 );
        buffer_write( Buffer, buffer_u8, 1 );
        buffer_write( Buffer, buffer_u8, socket );
        buffer_write( Buffer, buffer_u8, _map );
        for( var s = 0; s < ds_list_size( SocketList ); ++s )
        {
            network_send_packet( SocketList[| s ], Buffer, buffer_tell( Buffer ) );
        }
        break;
    case 8: // Gesture Update
        var _x = buffer_read( buffer, buffer_s8 ) / 100;
        var _y = buffer_read( buffer, buffer_s8 ) / 100;
        for( var s = 0; s < ds_list_size( PlayerList ); ++s )
        {
            var _lMap = PlayerList[| s ];
            if( _lMap[? "Socket" ] == socket )
            {
                var _gMap = _lMap[? "GestureMap" ];
                _gMap[? "X" ] = _x;
                _gMap[? "Y" ] = _y;
                break;
            }
        }
        break;
}
