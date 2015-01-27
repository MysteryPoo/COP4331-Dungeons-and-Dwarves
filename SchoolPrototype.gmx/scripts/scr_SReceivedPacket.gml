var buffer = argument[ 0 ];
var socket = argument[ 1 ];
var msgid = buffer_read( buffer , buffer_u8 );

switch( msgid ) {
    case 1:     // Ping
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
    case 2:     // Position Update
        var _x = buffer_read( buffer, buffer_s16 );
        var _y = buffer_read( buffer, buffer_s16 );
        var _direction = buffer_read( buffer, buffer_s16 );
        var _speed = buffer_read( buffer, buffer_s8 );
        buffer_seek( Buffer, buffer_seek_start, 0 );
        buffer_write( Buffer, buffer_u8, 2 );
        buffer_write( Buffer, buffer_u8, socket );
        buffer_write( Buffer, buffer_s16, _x );
        buffer_write( Buffer, buffer_s16, _y );
        buffer_write( Buffer, buffer_s16, _direction );
        buffer_write( Buffer, buffer_s8, _speed );
        for( var s = 0; s < ds_list_size( SocketList ); ++s )
            if( socket != ds_list_find_value( SocketList, s ) )
                network_send_packet( ds_list_find_value( SocketList, s ), Buffer, buffer_tell( Buffer ) );
        break;
    case 3:
        // New client
        // Send current list to new client
        buffer_seek( Buffer, buffer_seek_start, 0 );
        buffer_write( Buffer, buffer_u8, 3 );
        buffer_write( Buffer, buffer_u8, ds_list_size( SocketList ) - 1 );
        for( var s = 0; s < ds_list_size( SocketList ); ++s )
            buffer_write( Buffer, buffer_u8, ds_list_find_value( SocketList, s ) );
        network_send_packet( socket, Buffer, buffer_tell( Buffer ) );
        // Send new client to current clients
        buffer_seek( Buffer, buffer_seek_start, 0 );
        buffer_write( Buffer, buffer_u8, 3 );
        buffer_write( Buffer, buffer_u8, 1 );
        buffer_write( Buffer, buffer_u8, socket );
        for( var s = 0; s < ds_list_size( SocketList ); ++s )
            if( socket != ds_list_find_value( SocketList, s ) )
                network_send_packet( ds_list_find_value( SocketList, s ), Buffer, buffer_tell( Buffer ) );
        break;
    case 4:
        // Delete client
        buffer_seek( Buffer, buffer_seek_start, 0 );
        buffer_write( Buffer, buffer_u8, 4 );
        buffer_write( Buffer, buffer_u8, socket );
        for( var s = 0; s < ds_list_size( SocketList ); ++s )
            if( socket != ds_list_find_value( SocketList, s ) )
                network_send_packet( ds_list_find_value( SocketList, s ), Buffer, buffer_tell( Buffer ) );
        break;
    case 5:
        var _x = buffer_read( buffer, buffer_s16 );
        var _y = buffer_read( buffer, buffer_s16 );
        var _direction = buffer_read( buffer, buffer_s16 );
        buffer_seek( Buffer, buffer_seek_start, 0 );
        buffer_write( Buffer, buffer_u8, 5 );
        buffer_write( Buffer, buffer_s16, _x );
        buffer_write( Buffer, buffer_s16, _y );
        buffer_write( Buffer, buffer_s16, _direction );
        for( var s = 0; s < ds_list_size( SocketList ); ++s )
            if( socket != ds_list_find_value( SocketList, s ) )
                network_send_packet( ds_list_find_value( SocketList, s ), Buffer, buffer_tell( Buffer ) );
        break;
    case 6:
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
    default:
        for( var s = 0; s < ds_list_size( SocketList ); ++s )
            network_send_packet( ds_list_find_value( SocketList, s ), buffer, 1024 );
}

