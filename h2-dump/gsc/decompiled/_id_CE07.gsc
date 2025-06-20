// H2 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

_id_C183()
{
    soundscripts\_audio_vehicle_manager::avm_register_callback( "about_to_stop", ::_id_AD12 );
    soundscripts\_snd::snd_message( "snd_register_vehicle", "technical", ::_id_B998 );
}

_id_CB29()
{
    if ( isdefined( self.snd_instance ) )
    {
        wait 1.0;
        _id_D1E9( 1.0 );
    }

    thread snd_monitor_about_to_stop();
    var_0 = spawnstruct();
    var_0.preset_name = "technical";
    soundscripts\_snd::snd_message( "snd_start_vehicle", var_0 );
}

snd_monitor_about_to_stop()
{
    self endon( "death" );
    self endon( "snd_stop_vehicle" );
    self waittill( "about_to_stop", var_0 );

    if ( var_0 > 1.0 )
    {
        wait( var_0 - 1.0 );

        if ( !isdefined( self ) )
            return;
    }

    self.about_to_stop = 1;
}

_id_D1E9( var_0 )
{
    if ( isdefined( self.snd_instance ) )
    {
        soundscripts\_snd::snd_message( "snd_stop_vehicle", var_0 );
        self notify( "snd_stop_vehicle" );
    }
}

_id_B998()
{
    soundscripts\_audio_vehicle_manager::avm_begin_preset_def( "technical" );
    soundscripts\_audio_vehicle_manager::avm_begin_loop_data();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "h1r_technical_idle" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed", 0.3, 0.1 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "technical_idle_vel2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "technical_idle_vel2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "h1r_technical_engine" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed", 0.1, 0.65 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "technical_engine_vel2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "technical_engine_vel2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "h1r_technical_treads" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed", 0.1, 0.65 );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "technical_treads_vel2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "technical_treads_vel2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_end_loop_data();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data( 0.5 );
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_idle", ::_id_AC55 );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "about_to_stop" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_engine", ::_id_BA73 );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "about_to_stop" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_end_behavior_data();
    soundscripts\_audio_vehicle_manager::avm_begin_state_data();
    soundscripts\_audio_vehicle_manager::avm_begin_state_group( "main_oneshots", "state_idle", "to_state_idle", 50, 0.1 );
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_idle" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_engine", "to_state_engine" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_engine", 1.0 );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_idle", "to_state_idle" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_end_state_group();
    soundscripts\_audio_vehicle_manager::avm_end_state_data();
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "technical_idle_vel2vol", [ [ 0.0, 1.0 ], [ 10.0, 0.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "technical_idle_vel2pch", [ [ 0.0, 1.0 ], [ 10.0, 1.25 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "technical_engine_vel2vol", [ [ 0.0, 0.0 ], [ 4.0, 0.1 ], [ 10.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "technical_engine_vel2pch", [ [ 0.0, 0.8 ], [ 4.0, 1.0 ], [ 16.0, 1.1 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "technical_treads_vel2vol", [ [ 0.0, 0.0 ], [ 4.0, 0.4 ], [ 8.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "technical_treads_vel2pch", [ [ 0.0, 0.8 ], [ 8.0, 1.0 ], [ 16.0, 1.1 ] ] );
    soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

_id_AD12()
{
    var_0 = soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
    return isdefined( var_0.about_to_stop );
}

_id_AC55( var_0, var_1 )
{
    var_2 = var_0["speed"];
    var_3 = var_0["about_to_stop"];

    if ( var_2 <= 0.1 || var_3 > 0.5 )
        return 1;

    return 0;
}

_id_BA73( var_0, var_1 )
{
    var_2 = var_0["speed"];
    var_3 = var_0["about_to_stop"];

    if ( var_2 > 0.1 && var_3 <= 0.5 )
        return 1;

    return 0;
}
