// H2 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

detroit_music_preset_constructor()
{
    var_0 = 0.1;
    var_1 = 0.05;
    soundscripts\_audio_vehicle_manager::avm_begin_preset_def( "detroit_music" );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "env_low_intensity", [ [ 0.0, 1.0 ], [ 0.25, 0.5 ], [ 1.0, 0.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "env_high_intensity", [ [ 0.0, 0.0 ], [ 0.25, 0.75 ], [ 1.0, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_begin_loop_data( 5.0, var_0, var_1 );
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "mus_dtrt_refugee_camp" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "ams_intensity" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "env_low_intensity" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "mus_dtrt_school" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "ams_intensity" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "env_low_intensity" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "mus_dtrt_low_tension1" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "ams_intensity" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "env_low_intensity" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "mus_dtrt_low_tension2" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "ams_intensity" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "env_low_intensity" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "mus_dtrt_low_tension3" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "ams_intensity" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "env_low_intensity" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "mus_dtrt_generic_combat" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "ams_intensity" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "env_high_intensity" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_end_loop_data();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data();
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_refugee_camp", ::to_refugee_camp );
    soundscripts\_audio_vehicle_manager::avm_add_loops( [ "mus_dtrt_refugee_camp", "mus_dtrt_generic_combat" ] );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_school1", ::to_school1 );
    soundscripts\_audio_vehicle_manager::avm_add_loops( [ "mus_dtrt_low_tension1", "mus_dtrt_generic_combat" ] );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_school2", ::to_school2 );
    soundscripts\_audio_vehicle_manager::avm_add_loops( [ "mus_dtrt_low_tension2", "mus_dtrt_generic_combat" ] );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_school3", ::to_school3 );
    soundscripts\_audio_vehicle_manager::avm_add_loops( [ "mus_dtrt_low_tension3", "mus_dtrt_generic_combat" ] );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_end_behavior_data();
    soundscripts\_audio_vehicle_manager::avm_begin_state_data( 0.25, 50 );
    soundscripts\_audio_vehicle_manager::avm_begin_state_group( "main_group", "refugee_camp", "to_refugee_camp" );
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "refugee_camp" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "school1", "to_school1" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "school2", "to_school2" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "school3", "to_school3" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "school1" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "school2", "to_school2" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "school3", "to_school3" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "refugee_camp", "to_refugee_camp" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "school2" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "school1", "to_school1" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "school3", "to_school3" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "refugee_camp", "to_refugee_camp" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "school3" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "school1", "to_school1" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "school2", "to_school2" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "refugee_camp", "to_refugee_camp" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_end_state_group();
    soundscripts\_audio_vehicle_manager::avm_end_state_data();
    soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

to_refugee_camp( var_0, var_1 )
{
    return soundscripts\_audio_music::ams_get_state() == "refugee_camp";
}

to_school1( var_0, var_1 )
{
    return soundscripts\_audio_music::ams_get_state() == "school1";
}

to_school2( var_0, var_1 )
{
    return soundscripts\_audio_music::ams_get_state() == "school2";
}

to_school3( var_0, var_1 )
{
    return soundscripts\_audio_music::ams_get_state() == "school3";
}

virus1_preset_constructor()
{
    var_0 = 0.65;
    var_1 = 0.75;
    var_2 = 0.0;
    var_3 = 1.0;
    var_4 = 0.5;
    var_5 = 0.6;
    var_6 = 0.7;
    var_7 = 0.8;
    var_8 = 0;
    var_9 = 1.0;
    var_10 = 0.3;
    var_11 = 1.0;
    var_12 = 0;
    var_13 = 1.0;
    var_14 = 0.2;
    var_15 = 1.0;
    var_16 = 0;
    var_17 = 1.0;
    var_18 = 0.1;
    var_19 = 1.0;
    var_20 = 0.0;
    var_21 = 1.0;
    var_22 = 0.0;
    var_23 = 1.0;
    var_24 = 0.15;
    var_25 = 1.0;
    soundscripts\_audio_vehicle_manager::avm_begin_preset_def( "virus1", ::vrs1_instance_init );
    soundscripts\_audio_vehicle_manager::avm_begin_loop_data( 5.0, 0.1, 0.05 );
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "virus1_mix1" );
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "virus1_mix2" );
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "virus1_tilbell" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "ams_intensity" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "virus1_tilbell_i2vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "virus1_bigshufl" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "ams_intensity" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "virus1_bigshufl_i2vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "virus1_tribelgruv" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "ams_intensity" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "virus1_tribelgruv_i2vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "virus1_bsgprc1" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "ams_intensity" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "virus1_bsgprc1_i2vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "virus1_bsgprc2" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "ams_intensity" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "virus1_bsgprc2_i2vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "virus1_badbrain" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "ams_intensity" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "virus1_badbrain_i2vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_end_loop_data();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data();
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_mix1", ::vrs1_condition_to_mix1 );
    soundscripts\_audio_vehicle_manager::avm_add_loops( [ "virus1_mix1" ] );
    soundscripts\_audio_vehicle_manager::avm_add_init_state_callback( ::vrs1_enter_mix1 );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_mix2", ::vrs1_condition_to_mix2 );
    soundscripts\_audio_vehicle_manager::avm_add_loops( [ "virus1_mix2" ] );
    soundscripts\_audio_vehicle_manager::avm_add_init_state_callback( ::vrs1_enter_mix2 );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_adaptive", ::vrs1_condition_to_adaptive );
    soundscripts\_audio_vehicle_manager::avm_add_loops( [ "virus1_tilbell", "virus1_bigshufl", "virus1_badbrain", "virus1_tribelgruv", "virus1_bsgprc1", "virus1_bsgprc2" ] );
    soundscripts\_audio_vehicle_manager::avm_add_init_state_callback( ::vrs1_enter_adaptive );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_end_behavior_data();
    soundscripts\_audio_vehicle_manager::avm_begin_state_data( 0.25, 50 );
    soundscripts\_audio_vehicle_manager::avm_begin_state_group( "main_group", "mix1", "to_mix1" );
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "mix1" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "mix2", "to_mix2" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "adaptive", "to_adaptive" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "mix2" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "mix1", "to_mix1" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "adaptive", "to_adaptive" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "adaptive" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "mix1", "to_mix1" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "mix2", "to_mix2" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_end_state_group();
    soundscripts\_audio_vehicle_manager::avm_end_state_data();
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "virus1_bsgprc2_i2vol", [ [ var_0, var_2 ], [ var_1, var_3 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "virus1_bsgprc1_i2vol", [ [ var_4, var_8 ], [ var_5, var_9 ], [ var_6, var_9 ], [ var_7, var_8 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "virus1_bigshufl_i2vol", [ [ var_10, var_12 ], [ var_11, var_13 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "virus1_tribelgruv_i2vol", [ [ var_14, var_16 ], [ var_15, var_17 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "virus1_tilbell_i2vol", [ [ 0, 0 ], [ var_18, var_20 ], [ var_19, var_21 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "virus1_badbrain_i2vol", [ [ var_22, var_24 ], [ var_23, var_25 ] ] );
    soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

vrs1_instance_init( var_0 )
{

}

vrs1_condition_to_mix1( var_0, var_1 )
{
    return soundscripts\_audio_music::ams_get_state() == "mix1";
}

vrs1_condition_to_mix2( var_0, var_1 )
{
    return soundscripts\_audio_music::ams_get_state() == "mix2";
}

vrs1_condition_to_adaptive( var_0, var_1 )
{
    return soundscripts\_audio_music::ams_get_state() == "adaptive";
}

vrs1_enter_mix1( var_0 )
{
    soundscripts\_audio_vehicle_manager::avm_set_instance_master_volume( 1.0, 3.0 );
}

vrs1_enter_mix2( var_0 )
{
    soundscripts\_audio_vehicle_manager::avm_set_instance_master_volume( 1.0, 3.0 );
}

vrs1_enter_adaptive( var_0 )
{
    soundscripts\_audio_vehicle_manager::avm_set_instance_master_volume( 1.0, 3.0 );
}

bsgods_preset_constructor()
{
    soundscripts\_audio_vehicle_manager::avm_begin_preset_def( "bsgods_preset", ::bsgods_preset_instance_init_callback );
    soundscripts\_audio_vehicle_manager::avm_begin_loop_data( 3.0, 0.08, 0.08 );
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "mus_sfa_street_breakdown", 3.1 );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "ams_proxy_vehicle_speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "intro_loop_speed_to_vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "bsgods_prc_lyr1" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "ams_proxy_vehicle_speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "bsgods_prc_lyr1_speed_to_vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "bsgods_prc_lyr2" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "ams_proxy_vehicle_speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "bsgods_prc_lyr2_speed_to_vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "bsgods_prc_lyr3" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "ams_proxy_vehicle_speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "bsgods_prc_lyr3_speed_to_vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "bsgods_lps_lyr1" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "ams_proxy_vehicle_speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "bsgods_lps_lyr1_speed_to_vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "bsgods_lps_lyr2" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "ams_proxy_vehicle_speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "bsgods_lps_lyr2_speed_to_vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "bsgods_lps_lyr3" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "ams_proxy_vehicle_speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "bsgods_lps_lyr3_speed_to_vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "bsgods_lps_lyr4" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "ams_proxy_vehicle_speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "bsgods_lps_lyr4_speed_to_vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "bsgods_lps_lyr5" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "ams_proxy_vehicle_speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "bsgods_lps_lyr5_speed_to_vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "bsgods_atm_lyr2" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "ams_proxy_vehicle_speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "bsgods_atm_lyr1_speed_to_vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_begin_loop_def( "bsgods_ris_lyr1" );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "ams_proxy_vehicle_speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "bsgods_ris_lyr1_speed_to_vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_loop_def();
    soundscripts\_audio_vehicle_manager::avm_end_loop_data();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "bsgods_prc_hit1", "bsgods_prc_hit_duck_envelope", 0.25, 0 );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "ams_proxy_vehicle_speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "bsgods_prc_hit_speed_to_vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def( "bsgods_prc_hit2", "bsgods_prc_hit_duck_envelope", 0.25, 0 );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "ams_proxy_vehicle_speed" );
    soundscripts\_audio_vehicle_manager::avm_add_param_map_env( "volume", "bsgods_prc_hit_speed_to_vol" );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
    soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_intro", ::bsgods_condition_to_state_intro, [ "ams_proxy_vehicle_speed" ] );
    soundscripts\_audio_vehicle_manager::avm_add_loops( [ "mus_sfa_street_breakdown" ] );
    soundscripts\_audio_vehicle_manager::avm_add_oneshots( "bsgods_prc_hit1" );
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_begin_behavior_def( "to_state_driving", ::bsgods_condition_to_state_driving );
    soundscripts\_audio_vehicle_manager::avm_add_loops( [ "bsgods_prc_lyr1", "bsgods_prc_lyr2", "bsgods_prc_lyr3", "bsgods_lps_lyr1", "bsgods_lps_lyr2", "bsgods_lps_lyr3", "bsgods_lps_lyr4", "bsgods_lps_lyr5", "bsgods_atm_lyr2", "bsgods_ris_lyr1" ] );
    soundscripts\_audio_vehicle_manager::avm_add_oneshots( "bsgods_prc_hit1" );
    soundscripts\_audio_vehicle_manager::avm_add_init_state_callback( ::bsgods_enter_state_driving );
    soundscripts\_audio_vehicle_manager::avm_add_in_state_callback( ::bsgods_in_state_driving );
    soundscripts\_audio_vehicle_manager::avm_begin_param_map( "ams_proxy_vehicle_speed", 0.025, 0.025 );
    soundscripts\_audio_vehicle_manager::avm_end_param_map();
    soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
    soundscripts\_audio_vehicle_manager::avm_end_behavior_data();
    soundscripts\_audio_vehicle_manager::avm_begin_state_data( 0.25, 50 );
    soundscripts\_audio_vehicle_manager::avm_begin_state_group( "main_group", "state_driving", "to_state_driving" );
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_intro" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_driving", "to_state_driving" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_begin_state_def( "state_driving" );
    soundscripts\_audio_vehicle_manager::avm_add_state_transition( "state_intro", "to_state_intro" );
    soundscripts\_audio_vehicle_manager::avm_end_state_def();
    soundscripts\_audio_vehicle_manager::avm_end_state_group();
    soundscripts\_audio_vehicle_manager::avm_end_state_data();
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "intro_loop_speed_to_vol", [ [ 0.0, 1.0 ], [ 60.0, 1.0 ] ] );
    var_0 = [ 0.0, 0.166, 0.333, 0.5, 0.666, 0.833, 1.0 ];
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "bsgods_prc_lyr1_speed_to_vol", [ [ 0 + 60 * var_0[0], 1.0 ], [ 0 + 60 * var_0[2], 1.0 ], [ 0 + 60 * var_0[3], 0.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "bsgods_prc_lyr2_speed_to_vol", [ [ 0 + 60 * var_0[1], 0.0 ], [ 0 + 60 * var_0[2], 1.0 ], [ 0 + 60 * var_0[4], 1.0 ], [ 0 + 60 * var_0[5], 0.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "bsgods_prc_lyr3_speed_to_vol", [ [ 0 + 60 * var_0[3], 0.0 ], [ 0 + 60 * var_0[4], 1.0 ], [ 0 + 60 * var_0[6], 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "bsgods_prc_hit_speed_to_vol", [ [ 0.0, 0.5 ], [ 60.0, 0.5 ] ] );
    var_0 = [ 0.0, 0.166, 0.333, 0.5, 0.666, 0.833, 1.0 ];
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "bsgods_lps_lyr1_speed_to_vol", [ [ 0 + 60 * var_0[0], 1.0 ], [ 0 + 60 * var_0[1], 1.0 ], [ 0 + 60 * var_0[2], 1.0 ], [ 0 + 60 * var_0[2] + 0.1, 0.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "bsgods_lps_lyr2_speed_to_vol", [ [ 0 + 60 * var_0[2] - 0.1, 0.0 ], [ 0 + 60 * var_0[2], 1.0 ], [ 0 + 60 * var_0[3], 1.0 ], [ 0 + 60 * var_0[3] + 0.1, 0.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "bsgods_lps_lyr3_speed_to_vol", [ [ 0 + 60 * var_0[3] - 0.1, 0.0 ], [ 0 + 60 * var_0[3], 1.0 ], [ 0 + 60 * var_0[4], 1.0 ], [ 0 + 60 * var_0[4] + 0.1, 0.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "bsgods_lps_lyr4_speed_to_vol", [ [ 0 + 60 * var_0[4] - 0.1, 0.0 ], [ 0 + 60 * var_0[4], 1.0 ], [ 0 + 60 * var_0[5], 1.0 ], [ 0 + 60 * var_0[5] + 0.1, 0.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "bsgods_lps_lyr5_speed_to_vol", [ [ 0 + 60 * var_0[5] - 0.1, 0.0 ], [ 0 + 60 * var_0[5], 1.0 ], [ 0 + 60 * var_0[6], 1.0 ] ] );
    var_0 = [ 0.0, 0.166, 0.333, 0.5, 0.666, 0.833, 1.0 ];
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "bsgods_atm_lyr1_speed_to_vol", [ [ 0 + 60 * var_0[3], 0.0 ], [ 0 + 60 * var_0[4], 0.4 ], [ 0 + 60 * var_0[5], 0.7 ], [ 0 + 60 * var_0[6], 0.7 ] ] );
    var_0 = [ 0.8, 0.9, 1.0 ];
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "bsgods_ris_lyr1_speed_to_vol", [ [ 0 + 60 * var_0[0], 0.0 ], [ 0 + 60 * var_0[1], 1.0 ], [ 0 + 60 * var_0[2], 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_add_envelope( "bsgods_prc_hit_duck_envelope", [ [ 0.0, 1.0 ], [ 0.05, 0.5 ], [ 0.3, 0.75 ], [ 1.12, 1.0 ] ] );
    soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

bsgods_preset_instance_init_callback( var_0 )
{

}

bsgods_condition_to_state_intro( var_0, var_1 )
{
    return soundscripts\_audio_music::ams_get_state() == "intro";
}

bsgods_condition_to_state_driving( var_0, var_1 )
{
    return soundscripts\_audio_music::ams_get_state() == "driving";
}

bsgods_enter_state_driving( var_0 )
{
    if ( !isdefined( var_0.st_driving ) )
        var_0.st_driving = spawnstruct();

    var_0.st_driving.ris_is_muted = 1;
    var_0.st_driving.ris_mute_time = 0;
    var_0.st_driving.ris_off_time = 0;
    var_0.st_driving.ris_max_off_time = 36;
    var_0.st_driving.ris_max_on_time = 18;
    var_0.st_driving.atm_is_muted = 1;
    var_0.st_driving.atm_mute_time = 0;
    var_0.st_driving.atm_off_time = 0;
    var_0.st_driving.atm_max_off_time = 18;
    var_0.st_driving.atm_max_on_time = 9;
    soundscripts\_audio_vehicle_manager::avm_set_loop_mute_state( "bsgods_ris_lyr1", var_0.st_driving.ris_is_muted, 0.05 );
    var_0.st_driving.ris_mute_time = soundscripts\_snd::snd_get_secs();
    soundscripts\_audio_vehicle_manager::avm_set_loop_mute_state( "bsgods_atm_lyr2", var_0.st_driving.atm_is_muted, 0.05 );
    var_0.st_driving.atm_mute_time = soundscripts\_snd::snd_get_secs();
}

bsgods_in_state_driving( var_0, var_1 )
{
    var_2 = var_0["ams_proxy_vehicle_speed"];

    if ( var_2 > 45.0 )
    {
        var_3 = 4.0;
        var_4 = soundscripts\_snd::snd_get_secs() - var_1.st_driving.ris_mute_time;

        if ( var_1.st_driving.ris_is_muted && var_4 > var_1.st_driving.ris_max_off_time )
        {
            soundscripts\_audio_vehicle_manager::avm_set_loop_mute_state( "bsgods_ris_lyr1", 0, var_3 );
            var_1.st_driving.ris_is_muted = 0;
            var_1.st_driving.ris_mute_time = soundscripts\_snd::snd_get_secs();
        }
        else if ( !var_1.st_driving.ris_is_muted && var_4 > var_1.st_driving.ris_max_on_time )
        {
            soundscripts\_audio_vehicle_manager::avm_set_loop_mute_state( "bsgods_ris_lyr1", 1, var_3 );
            var_1.st_driving.ris_is_muted = 1;
            var_1.st_driving.ris_mute_time = soundscripts\_snd::snd_get_secs();
        }
    }
    else if ( !var_1.st_driving.ris_is_muted )
    {
        var_1.st_driving.ris_is_muted = 1;
        soundscripts\_audio_vehicle_manager::avm_set_loop_mute_state( "bsgods_ris_lyr1", var_1.st_driving.ris_is_muted, 1.0 );
        var_1.st_driving.ris_mute_time = soundscripts\_snd::snd_get_secs();
    }

    if ( var_2 > 30.0 )
    {
        var_3 = 2.0;
        var_4 = soundscripts\_snd::snd_get_secs() - var_1.st_driving.atm_mute_time;

        if ( var_1.st_driving.atm_is_muted && var_4 > var_1.st_driving.atm_max_off_time )
        {
            soundscripts\_audio_vehicle_manager::avm_set_loop_mute_state( "bsgods_atm_lyr2", 0, var_3 );
            var_1.st_driving.atm_is_muted = 0;
            var_1.st_driving.atm_mute_time = soundscripts\_snd::snd_get_secs();
            return;
        }

        if ( !var_1.st_driving.atm_is_muted && var_4 > var_1.st_driving.atm_max_on_time )
        {
            soundscripts\_audio_vehicle_manager::avm_set_loop_mute_state( "bsgods_atm_lyr2", 1, var_3 );
            var_1.st_driving.atm_is_muted = 1;
            var_1.st_driving.atm_mute_time = soundscripts\_snd::snd_get_secs();
            return;
        }

        return;
    }
    else if ( !var_1.st_driving.atm_is_muted )
    {
        var_1.st_driving.atm_is_muted = 1;
        soundscripts\_audio_vehicle_manager::avm_set_loop_mute_state( "bsgods_atm_lyr2", var_1.st_driving.atm_is_muted, 1.0 );
        var_1.st_driving.atm_mute_time = soundscripts\_snd::snd_get_secs();
    }
}

audio_presets_music_moods( var_0, var_1 )
{
    soundscripts\_audio::aud_print_warning( "CALLING MUSIC_MOODS PRESET USING OLD METHOD!" );
}

audio_presets_music_cue_groups( var_0, var_1 )
{
    soundscripts\_audio::aud_print_warning( "CALLING MUSIC_CUE_GROUPS PRESET USING OLD METHOD!" );
}

audio_presets_music_cues( var_0, var_1 )
{
    soundscripts\_audio::aud_print_warning( "CALLING MUSIC_CUES PRESET USING OLD METHOD!" );
}
