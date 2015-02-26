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
            var _found = false;
            for( var s = 0; s < ds_list_size( SocketList ); ++s )
            {
                var _lMap = SocketList[| s ];
                if( _lMap[? "Socket" ] == _socket )
                {
                    _found = true;
                    var _pMap = _lMap[? "PositionMap" ];
                    _pMap[? "X" ] = _x;
                    _pMap[? "Y" ] = _y;
                    _pMap[? "Direction" ] = _dir;
                    _pMap[? "Speed" ] = _speed;
                }
            }
            if( !_found)
            {
                var _pMap = ds_map_create();
                _pMap[? "X" ] = _x;
                _pMap[? "Y" ] = _y;
                _pMap[? "Direction" ] = _dir;
                _pMap[? "Speed" ] = _speed;
                var _aMap = ds_map_create();
                _aMap[? "Object" ] = "noone";
                _aMap[? "X" ] = 0;
                _aMap[? "Y" ] = 0;
                _aMap[? "Direction" ] = 0;
                _aMap[? "Speed" ] = 0;
                var _lMap = ds_map_create();
                _lMap[? "Socket" ] = _socket;
                _lMap[? "Ready" ] = false;
                _lMap[? "Instance" ] = noone;
                _lMap[? "Name" ] = "Unnamed";
                _lMap[? "PositionMap" ] = _pMap;
                _lMap[? "AttackMap" ] = _aMap;
                ds_list_add( SocketList, _lMap );
            }
        }
        break;
    case 3:     // Status Update
        var _updates = buffer_read( buffer, buffer_u8 );
        repeat( _updates )
        {
            var _socket = buffer_read( buffer, buffer_u8 );
            var _state = buffer_read( buffer, buffer_string );
            for( var s = 0; s < ds_list_size( SocketList ); ++s )
            {
                var _lMap = SocketList[| s ];
                if( _lMap[? "Socket" ] == _socket )
                {
                    // Add the status to the queue
                    var _sMap = ds_map_create();
                    _sMap[? "Socket" ] = _socket;
                    _sMap[? "Status" ] = _state;
                    ds_queue_enqueue( StatusQueue, _sMap );
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
                ds_map_destroy( _lMap[? "AttackMap" ] );
                with( _lMap[? "Instance" ] )
                    instance_destroy();
                ds_map_destroy( _lMap );
                ds_list_delete( SocketList, s );
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
            var _ready = buffer_read( buffer, buffer_u8 );
            for( var s = 0; s < ds_list_size( SocketList ); ++s )
            {
                var _lMap = SocketList[| s ];
                if( _lMap[? "Socket" ] == _socket )
                {
                    _lMap[? "Ready" ] = _ready;
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
            for( var s = 0; s < ds_list_size( SocketList ); ++s )
            {
                var _lMap = SocketList[| s ];
                if( _lMap[? "Socket" ] == _socket )
                    _lMap[? "Name" ] = _name;
            }
        }
        break;
}