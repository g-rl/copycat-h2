// H2 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

_id_B279()
{
    soundscripts\_audio_vehicle_manager::avm_register_callback( "about_to_stop", ::_id_C59D );
    soundscripts\_snd::snd_message( "snd_register_vehicle", "m1a1", ::_id_D5A9 );
}

_id_D4E4()
{
    if ( isdefined( self.snd_instance ) )
    {
        wait 1.0;
        _id_BE18( 1.0 );
    }

    thread snd_monitor_about_to_stop();
    var_0 = spawnstruct();
    var_0.preset_name = "m1a1";
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

_id_BE18( var_0 )
{
    if ( isdefined( self.snd_instance ) )
    {
        soundscripts\_snd::snd_message( "snd_stop_vehicle", var_0 );
        self notify( "snd_stop_vehicle" );
    }
}

_id_D5A9()
{
    soundscripts\_audio_vehicle_manager::avm_begin_preset_def( "m1a1" );
    soundscripts\_audio_vehicle_manager::avm_begin_loop_data();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "m1a1_abrams_idle_close_loop" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "m1a1_idle_vel2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "m1a1_idle_vel2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "m1a1_abrams_engine_close_loop" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "m1a1_engine_vel2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "m1a1_engine_vel2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "m1a1_abrams_engine_treads_loop" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "m1a1_treads_vel2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "m1a1_treads_vel2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "m1a1_abrams_engine_treads_loop_2" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "m1a1_treads_vel2vol" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "pitch", "m1a1_treads_vel2pch" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_end_loop_data();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data( 0.5 );
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_idle", ::_id_BE07 );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed", 1.0, 1.0 );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "about_to_stop" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_engine", ::_id_B30E );
    soundscripts\_audio_vehicle_manager::avm_add_loops( "ALL" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "speed", 1.0, 1.0 );
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
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "m1a1_idle_vel2vol", [ [ 0.0, 1.0 ], [ 8.0, 0.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "m1a1_idle_vel2pch", [ [ 0.0, 1.0 ], [ 2.5, 1.25 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "m1a1_engine_vel2vol", [ [ 0.0, 0.0 ], [ 5.0, 0.7 ], [ 8.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "m1a1_engine_vel2pch", [ [ 0.0, 0.8 ], [ 8.0, 1.0 ], [ 10.0, 1.1 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "m1a1_treads_vel2vol", [ [ 0.0, 0.0 ], [ 5.0, 0.7 ], [ 8.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "m1a1_treads_vel2pch", [ [ 0.0, 0.8 ], [ 8.0, 1.2 ] ] );
    soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

_id_C59D()
{
    var_0 = soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
    return isdefined( var_0.about_to_stop );
}

_id_BE07( var_0, var_1 )
{
    var_2 = var_0["speed"];
    var_3 = var_0["about_to_stop"];

    if ( var_2 <= 0.01 || var_3 > 0.5 )
        return 1;

    return 0;
}

_id_B30E( var_0, var_1 )
{
    var_2 = var_0["speed"];
    var_3 = var_0["about_to_stop"];

    if ( var_2 > 0.01 && var_3 < 0.5 )
        return 1;

    return 0;
}
