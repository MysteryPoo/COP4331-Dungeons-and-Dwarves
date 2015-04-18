var buffer = argument[ 0 ];
var msgid = buffer_read( buffer , buffer_u8 );

switch( msgid ) {
    case 1:    // Ping
        var _netID = buffer_read( buffer, buffer_u8 );
        Ping = current_time - LastPing;
        NetworkID = _netID;
        break;
    case 2:     // Update Player Position
        var _updates = buffer_read( buffer, buffer_u8 );
        repeat( _updates )
        {
            var _socket = buffer_read( buffer, buffer_u8 );
            var _x = buffer_read( buffer, buffer_s16 );
            var _y = buffer_read( buffer, buffer_s16 );
            var _dir = buffer_read( buffer, buffer_s16 );
            var _speed = buffer_read( buffer, buffer_s8 );
            for( var s = 0; s < ds_list_size( SocketList ); ++s )
            {
                var _lMap = SocketList[| s ];
                if( _lMap[? "Socket" ] == _socket )
                {
                    var _pMap = _lMap[? "PositionMap" ];
                    _pMap[? "X" ] = _x;
                    _pMap[? "Y" ] = _y;
                    _pMap[? "Direction" ] = _dir;
                    _pMap[? "Speed" ] = _speed;
                    break;
                }
            }
        }
        break;
    case 3:     // Status Update
        var _updates = buffer_read( buffer, buffer_u8 );
        repeat( _updates )
        {
            var _socket = buffer_read( buffer, buffer_u8 );
            var _state = buffer_read( buffer, buffer_string );
            var _mod = buffer_read( buffer, buffer_u8 );
            for( var s = 0; s < ds_list_size( SocketList ); ++s )
            {
                var _lMap = SocketList[| s ];
                if( _lMap[? "Socket" ] == _socket )
                {
                    // Add the status to the queue
                    var _sMap = ds_map_create();
                    _sMap[? "Socket" ] = _socket;
                    _sMap[? "Status" ] = _state;
                    _sMap[? "Modifier" ] = _mod;
                    ds_queue_enqueue( StatusQueue, _sMap );
                    break;
                }
            }
        }
        break;
    case 4:     // Delete Player
        var _socket = buffer_read( buffer, buffer_u8 );
        for( var s = 0; s < ds_list_size( SocketList ); ++s )
        {
            var _lMap = SocketList[| s ];
            if( _lMap[? "Socket" ] == _socket )
            {
                ds_map_destroy( _lMap[? "PositionMap" ] );
                ds_map_destroy( _lMap[? "GestureMap" ] );
                with( _lMap[? "Instance" ] )
                    instance_destroy();
                ds_map_destroy( _lMap );
                ds_list_delete( SocketList, s );
                break;
            }
        }
        break;
    case 5:     // Update Player Attacks
        var _updates = buffer_read( buffer, buffer_u8 );
        repeat( _updates )
        {
            var _socket = buffer_read( buffer, buffer_u8 );
            var _Object = buffer_read( buffer, buffer_string );
            var _x = buffer_read( buffer, buffer_u16 );
            var _y = buffer_read( buffer, buffer_u16 );
            var _dir = buffer_read( buffer, buffer_s16 );
            var _aMap = ds_map_create();
            _aMap[? "Socket" ] = _socket;
            _aMap[? "Object" ] = _Object;
            _aMap[? "X" ] = _x;
            _aMap[? "Y" ] = _y;
            _aMap[? "Direction" ] = _dir;
            ds_queue_enqueue( AttackQueue, _aMap );
        }
        break;
    case 6:     // Update Ready status
        var _updates = buffer_read( buffer, buffer_u8 );
        repeat( _updates )
        {
            var _socket = buffer_read( buffer, buffer_u8 );
            var _ready = buffer_read( buffer, buffer_bool );
            for( var s = 0; s < ds_list_size( SocketList ); ++s )
            {
                var _lMap = SocketList[| s ];
                if( _lMap[? "Socket" ] == _socket )
                {
                    _lMap[? "Ready" ] = _ready;
                    break;
                }
            }
        }
        break;
    case 7:     // Retrieve Names
        var _updates = buffer_read( buffer, buffer_u8 );
        repeat( _updates )
        {
            var _socket = buffer_read( buffer, buffer_u8 );
            var _name = buffer_read( buffer, buffer_string );
            var _found = false;
            if( _name == Name )
                State = "Game";     // No longer spectator
            for( var s = 0; s < ds_list_size( SocketList ); ++s )
            {
                var _lMap = SocketList[| s ];
                if( _lMap[? "Socket" ] == _socket )
                {
                    _found = true;
                    _lMap[? "Name" ] = _name;
                    break;
                }
            }
            if( !_found)
            {
                var _pMap = ds_map_create();
                _pMap[? "X" ] = -100;
                _pMap[? "Y" ] = -100;
                _pMap[? "Direction" ] = 0;
                _pMap[? "Speed" ] = 0;
                var _gMap = ds_map_create();
                _gMap[? "X" ] = 0;
                _gMap[? "Y" ] = 0;
                var _lMap = ds_map_create();
                _lMap[? "Socket" ] = _socket;
                _lMap[? "Ready" ] = false;
                _lMap[? "Instance" ] = noone;
                _lMap[? "Name" ] = _name;
                _lMap[? "Map" ] = 0;
                _lMap[? "PositionMap" ] = _pMap;
                _lMap[? "GestureMap" ] = _gMap;
                ds_list_add( SocketList, _lMap );
                // Reset Ready Status
                for( var s = 0; s < ds_list_size( SocketList ); ++s )
                {
                    var _lMap = SocketList[| s ];
                    _lMap[? "Ready" ] = false;
                }
            }
        }
        break;
    case 8: // Map update
        var _updates = buffer_read( buffer, buffer_u8 );
        repeat( _updates )
        {
            var _socket = buffer_read( buffer, buffer_u8 );
            var _map = buffer_read( buffer, buffer_u8 );
            for( var s = 0; s < ds_list_size( SocketList ); ++s )
            {
                var _lMap = SocketList[| s ];
                if( _lMap[? "Socket" ] == _socket )
                {
                    _lMap[? "Map" ] = _map;
                    break;
                }
            }
        }
        break;
    case 9: // Gesture Update
        var _updates = buffer_read( buffer, buffer_u8 );
        repeat( _updates )
        {
            var _socket = buffer_read( buffer, buffer_u8 );
            var _x = buffer_read( buffer, buffer_s8 ) / 100;
            var _y = buffer_read( buffer, buffer_s8 ) / 100;
            for( var s = 0; s < ds_list_size( SocketList ); ++s )
            {
                var _lMap = SocketList[| s ];
                if( _lMap[? "Socket" ] == _socket )
                {
                    var _gMap = _lMap[? "GestureMap" ];
                    _gMap[? "X" ] = _x;
                    _gMap[? "Y" ] = _y;
                    break;
                }
            }
        }
        break;
    case 10:    // Update Server List
        var _updates = buffer_read( buffer, buffer_u8 );
        for( var s = 0; s < _updates; ++s )
        {
            var _ip = buffer_read( buffer, buffer_string );
            var _port = buffer_read( buffer, buffer_u16 );
            var _name = buffer_read( buffer, buffer_string );
            var _players = buffer_read( buffer, buffer_u8 );
            var game = obj_ServerListManager.ServerList[@ s ];
            if( instance_exists( game ) )
            {
                game.IP = _ip;
                game.Port = _port;
                game.Name = _name;
                game.Players = _players;
            }
        }
        for( var s = _updates; s < obj_ServerListManager.MaxServers; ++s )
        {
            var game = obj_ServerListManager.ServerList[@ s ];
            game.Port = 0;
        }
        break;
    case 11:    // Game Start - Retrieve Map Order
        //repeat( 4 )
        {
            var _map = buffer_read( buffer, buffer_string );
            _map = asset_get_index( _map );
            if( _map == -1 )
            {
                show_message( "Your game is out of date." );
                game_end();
            }
            //else
            //ds_list_add( MapList, _map );
        }
        //ds_list_add( MapList, rm_Client );
        if( instance_exists( obj_Time ) )
        {
            if( _map == rm_Shop )
                obj_Time.StartTime = date_inc_minute( date_current_datetime(), 1 );
            else
                obj_Time.StartTime = date_inc_minute( date_current_datetime(), 3 );
        }
        if( State != "Spectator" )
            global.Waiting = false;
        else
            global.Waiting = true;
        if( _map == rm_MainMenu )
            with( obj_Inventory )
                instance_destroy();
        if( room != _map )
            room_goto( _map );
        break;
}