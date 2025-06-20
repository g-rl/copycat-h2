// H2 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main( var_0 )
{
    soundscripts\_audio::deprecated_aud_register_msg_handler( ::so_msg_handler );
    thread aud_handle_map_setups( var_0 );
    soundscripts\_audio::set_stringtable_mapname( "mw3" );
}

aud_handle_map_setups( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    switch ( var_0 )
    {
        case "so_nyse_ny_manhattan":
            aud_start_nyse_fire();
            break;
    }
}

so_msg_handler( var_0, var_1 )
{
    var_2 = 1;

    switch ( var_0 )
    {
        case "so_berlin_intro_littlebird_spawn":
            var_3 = var_1;
            var_3 thread common_scripts\utility::play_loop_sound_on_entity( "so_littlebird_move" );
            break;
        case "so_ied_littlebird":
            var_3 = var_1;
            var_3 thread common_scripts\utility::play_loop_sound_on_entity( "so_littlebird_move" );
            var_3 thread aud_helicopter_deathwatch();
            break;
        case "so_ied_wave4_littlebird":
            var_4 = var_1;
            var_4 thread common_scripts\utility::play_loop_sound_on_entity( "so_littlebird_move_distant" );
            var_4 thread aud_helicopter_deathwatch();
            break;
        case "so_ied_wave3_tank":
            var_5 = var_1;
            var_5 thread aud_run_tank_system();
            break;
        case "so_nyse_littlebird_spawn":
            var_3 = var_1;
            var_3 common_scripts\utility::play_loop_sound_on_entity( "so_nymn_littlebird_move" );
            break;
        case "so_start_harbor_player_hind":
            var_6 = var_1;
            var_6 common_scripts\utility::play_loop_sound_on_entity( "so_hind_player" );
            break;
        case "so_harbor_ally_helis":
            var_7 = var_1;

            foreach ( var_3 in var_7 )
                var_3 thread common_scripts\utility::play_loop_sound_on_entity( "so_hind_allies" );

            break;
        case "so_harbor_kill_helis":
            var_7 = var_1;

            foreach ( var_3 in var_7 )
                var_3 common_scripts\utility::stop_loop_sound_on_entity( "so_hind_allies" );

            break;
        case "so_start_harbor_exit_hind":
            var_12 = var_1;
            var_12 common_scripts\utility::play_loop_sound_on_entity( "so_exit_hind_player" );
            break;
        case "so_harbor_enemy_chopper_flyover":
            var_13 = var_1;
            var_13 maps\_utility::play_sound_on_entity( "so_sub_hind_flyover" );
            break;
        case "so_sub_missile_launch":
            var_14 = var_1;
            aud_handle_so_missile( var_14 );
            break;
        default:
            var_2 = 0;
    }

    return var_2;
}

aud_start_nyse_fire()
{
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "fire_wood_med", ( -945, -2847, 262 ), "steff_01", 1000, 1.0 );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "fire_wood_med", ( -1181, -2926, 55 ), "steff_02", 1000, 1.0 );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "fire_wood_med_tight", ( -1004, -2927, 42 ), "steff_03", 1000, 1.0 );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "fire_crackle_med_tight", ( -902, -2716, 66 ), "steff_04", 1000, 1.0 );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "fire_wood_med_tight", ( -909, -2636, 36 ), "steff_05", 1000, 1.0 );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "fire_wood_med", ( -686, -2120, 91 ), "steff_car", 1000, 1.0 );
    common_scripts\utility::play_loopsound_in_space( "road_flare_lp_tight", ( -141, 271, 2 ) );
    common_scripts\utility::play_loopsound_in_space( "road_flare_lp_tight", ( -259, 579, 2 ) );
    common_scripts\utility::play_loopsound_in_space( "road_flare_lp_tight", ( -475, 980, 10 ) );
    common_scripts\utility::play_loopsound_in_space( "road_flare_lp_tight", ( -704, 311, -7 ) );
    soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point( "fire_crackle_med_tight", ( -471, 1856, -22 ), "pre_stock_01", 1000, 1.0 );
}

aud_handle_so_missile( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    wait 0.05;
    var_0 playsound( "russian_sub_missile_launch" );
    wait 1.25;
    var_0 playsound( "russian_sub_missile_launch_boom" );
}

aud_helicopter_deathwatch()
{
    level.aud.crashpos = ( 0, 0, 0 );
    self waittill( "deathspin" );
    thread aud_heli_crash_pos();
    thread common_scripts\utility::play_loop_sound_on_entity( "so_littlebird_helicopter_dying_loop" );
    common_scripts\utility::waittill_either( "death", "crash_done" );
    thread common_scripts\utility::play_sound_in_space( "so_littlebird_helicopter_crash", level.aud.crashpos );
}

aud_heli_crash_pos()
{
    self endon( "death" );

    for (;;)
    {
        if ( isdefined( self ) )
        {
            self.origin = level.aud.crashpos;
            wait 0.05;
        }
    }
}

aud_run_tank_system()
{
    aud_ground_veh_loops( "ied_tank_01", "us_tank_treads_lp_02", "us_tank_move_low_lp", "us_tank_idle_lp" );
    aud_tank_fire_watch();
}

aud_ground_veh_loops( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( self ) )
    {
        level.aud.instance_name = spawn( "script_origin", self.origin );
        var_4 = spawn( "script_origin", self.origin );
        var_5 = spawn( "script_origin", self.origin );
        var_6 = spawn( "script_origin", self.origin );
        level.aud.instance_name.fade_in = 1;
        var_7 = level.aud.instance_name;
        var_8 = level.aud.instance_name.fade_in;
        var_4 linkto( self );
        var_6 linkto( self );
        var_5 linkto( self );

        if ( isdefined( var_4 ) || isdefined( var_1 ) )
            var_4 playloopsound( var_1 );

        if ( isdefined( var_5 ) || isdefined( var_2 ) )
            var_5 playloopsound( var_2 );

        if ( isdefined( var_6 ) || isdefined( var_3 ) )
            var_6 playloopsound( var_3 );

        var_4 setvolume( 0.0 );
        var_5 setvolume( 0.0 );
        var_6 setvolume( 0.0 );
        wait 0.3;
        aud_ground_veh_speed_mapping( var_7, var_4, var_5, var_6, 1, 5, var_8 );
    }
}

aud_ground_veh_speed_mapping( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_4 = 1;
    var_5 = 5;
    thread aud_ground_veh_deathwatch( var_0, var_1, var_2, var_3 );
    thread aud_create_drive_envs();
    var_0 endon( "instance_killed" );
    var_7 = 0;

    for (;;)
    {
        if ( isdefined( self ) )
        {
            var_8 = self vehicle_getspeed();
            var_8 = min( var_8, var_5 );
            var_8 = soundscripts\_audio::aud_smooth( var_7, var_8, 0.1 );
            var_9 = soundscripts\_audio::deprecated_aud_map_range( var_8, var_4, var_5, level.aud.envs["veh_drive_vol"] );
            var_10 = soundscripts\_audio::deprecated_aud_map_range( var_8, var_4, var_5, level.aud.envs["veh_idle_vol"] );
            var_2 setvolume( var_9, 0.1 );
            var_1 setvolume( var_9, 0.1 );
            var_3 setvolume( var_10, 0.1 );
            var_7 = var_8;
            wait 0.1;
        }
    }
}

aud_create_drive_envs()
{
    level.aud.envs["veh_drive_vol"] = [ [ 0.0, 0.0 ], [ 0.05, 0.1 ], [ 0.1, 0.1 ], [ 0.2, 0.2 ], [ 0.3, 0.3 ], [ 0.4, 0.4 ], [ 0.5, 0.5 ], [ 0.6, 0.6 ], [ 0.8, 0.8 ], [ 1.0, 1.0 ] ];
    level.aud.envs["veh_idle_vol"] = [ [ 0.0, 1.0 ], [ 0.05, 0.85 ], [ 0.1, 0.6 ], [ 0.2, 0.5 ], [ 0.3, 0.4 ], [ 0.4, 0.1 ], [ 0.5, 0.0 ], [ 0.6, 0.0 ], [ 0.8, 0.0 ], [ 1.0, 0.0 ] ];
}

aud_ground_veh_deathwatch( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( self ) )
    {
        self waittill( "death" );
        var_0 notify( "instance_killed" );
        thread aud_fade_loop_out_and_delete_temp( var_1, 5 );
        thread aud_fade_loop_out_and_delete_temp( var_2, 5 );
        thread aud_fade_loop_out_and_delete_temp( var_3, 5 );
    }
}

aud_tank_fire_watch()
{
    self endon( "death" );

    if ( isdefined( self ) )
    {
        for (;;)
        {
            self waittill( "weapon_fired" );
            var_0 = randomfloatrange( 0.2, 0.4 );
            thread common_scripts\utility::play_sound_in_space( "us_tank_big_boom", self.origin );
            thread common_scripts\utility::play_sound_in_space( "us_tank_fire_dist", self.origin );
            thread common_scripts\utility::play_sound_in_space( "us_tank_fire_close", self.origin );
            thread common_scripts\utility::play_sound_in_space( "us_tank_fire_hi_ring", self.origin );
            thread common_scripts\utility::play_sound_in_space( "us_tank_fire_lfe", self.origin );
            wait 0.2;
            thread common_scripts\utility::play_sound_in_space( "us_tank_dist_verb", self.origin );
            wait( var_0 );
        }
    }
}

aud_fade_loop_out_and_delete_temp( var_0, var_1 )
{
    var_0 setvolume( 0.0, var_1 );
    wait( var_1 + 0.05 );
    var_0 stopsounds();
    wait 0.05;
    var_0 delete();
}
