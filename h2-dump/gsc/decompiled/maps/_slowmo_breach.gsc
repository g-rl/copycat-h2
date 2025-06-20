// H2 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

slowmo_breach_init()
{
    level.last_player_damage = 0;
    level.slomobreachduration = 3.5;
    level.breachenemies_active = 0;
    level.breachignoreenemy_count = 0;
    level.player_one_already_breached = undefined;
    level.breachenemies_alive = 0;
    level.has_special_breach_anim = [];
    level.breach_passive_time = 0;
    slomo_sound_scale_setup();
    setdynamicdvar( "breach_debug", "0" );
    setdynamicdvar( "breach_requires_friendlies_in_position", "1" );
    setdynamicdvar( "hostage_missionfail", "0" );
    setdynamicdvar( "use_improved_breaches", 1 );
    precacheitem( "usp_scripted" );
    precacheshader( "breach_icon" );
    precacheshader( "h2_overlays_vignette" );
    precacheshader( "h2_overlays_breachdust" );
    precachemodel( "weapon_parabolic_knife" );
    precachestring( &"SCRIPT_WAYPOINT_BREACH" );
    precachestring( &"SCRIPT_PLATFORM_BREACH_ACTIVATE" );
    precachestring( &"SCRIPT_PLATFORM_BREACH_ACTIVATE_KB" );
    precachestring( &"SCRIPT_BREACH_NEED_PLAYER" );
    precachestring( &"SCRIPT_BREACH_NEED_FRIENDLY" );
    precachestring( &"SCRIPT_BREACH_TOO_MANY_ENEMIES" );
    precachestring( &"SCRIPT_BREACH_ILLEGAL_WEAPON" );
    precachestring( &"SCRIPT_BREACH_PARTNER_NOT_READY" );
    precachestring( &"SCRIPT_BREACH_YOU_NOT_READY" );
    precachestring( &"SCRIPT_MISSIONFAIL_KILLEDHOSTAGE_THROUGH_ENEMY" );
    precachestring( &"SCRIPT_MISSIONFAIL_KILLEDHOSTAGE" );
    precachestring( &"SCRIPT_MISSIONFAIL_HOSTAGEEXECUTED" );
    precachestring( &"SCRIPT_MISSIONFAIL_HOSTAGEEXECUTED_USEMULTIDOOR" );
    precachestring( &"SCRIPT_BREACH_RELOADING" );
    level._slowmo_functions = [];

    if ( !common_scripts\utility::fxexists( "breach_door" ) )
        level._effect["breach_door"] = loadfx( "vfx/explosion/breach_door" );

    if ( !common_scripts\utility::fxexists( "breach_room" ) )
        level._effect["breach_room"] = loadfx( "vfx/explosion/breach_room" );

    if ( !common_scripts\utility::fxexists( "breach_room_residual" ) )
        level._effect["breach_room_residual"] = loadfx( "vfx/explosion/breach_room_residual" );

    if ( !common_scripts\utility::fxexists( "breach_knife_execution" ) )
        level._effect["breach_knife_execution"] = loadfx( "vfx/blood/blood_hit_knife" );

    script_models();
    player_animations();
    friendly_animations();
    breach_anims();
    create_slowmo_breaches_from_entities();
    var_0 = getentarray( "trigger_multiple_breachIcon", "classname" );
    common_scripts\utility::array_thread( var_0, ::icon_trigger_setup );
    var_1 = getentarray( "breach_solid_delete", "targetname" );
    common_scripts\utility::array_call( var_1, ::connectpaths );
    common_scripts\utility::array_thread( var_1, maps\_utility::self_delete );
    var_1 = getentarray( "breach_delete", "targetname" );
    common_scripts\utility::array_thread( var_1, maps\_utility::self_delete );
    var_2 = getentarray( "breach_fx", "targetname" );
    common_scripts\utility::array_thread( var_2, ::breach_fx_setup );
    level.has_special_breach_anim["aa12"] = 1;
    level.has_special_breach_anim["aa12_reflex"] = 1;
    level.has_special_breach_anim["aa12_hb"] = 1;
    level.has_special_breach_anim["aug_reflex"] = 1;
    level.has_special_breach_anim["aug_reflex_arctic"] = 1;
    level.has_special_breach_anim["aug_scope"] = 1;
    level.has_special_breach_anim["aug_scope_arctic"] = 1;
    level.has_special_breach_anim["barrett"] = 1;
    level.has_special_breach_anim["beretta"] = 1;
    level.has_special_breach_anim["beretta393"] = 1;
    level.has_special_breach_anim["cheytac_silencer"] = 1;
    level.has_special_breach_anim["cheytac_silencer_desert"] = 1;
    level.has_special_breach_anim["fal"] = 1;
    level.has_special_breach_anim["fal_acog"] = 1;
    level.has_special_breach_anim["fal_reflex"] = 1;
    level.has_special_breach_anim["fal_shotgun"] = 1;
    level.has_special_breach_anim["fal_shotgun_attach"] = 1;
    level.has_special_breach_anim["famas"] = 1;
    level.has_special_breach_anim["famas_arctic"] = 1;
    level.has_special_breach_anim["famas_arctic_eotech"] = 1;
    level.has_special_breach_anim["famas_arctic_reflex"] = 1;
    level.has_special_breach_anim["famas_mp2"] = 1;
    level.has_special_breach_anim["famas_shotgun"] = 1;
    level.has_special_breach_anim["famas_shotgun_attach"] = 1;
    level.has_special_breach_anim["famas_woodland"] = 1;
    level.has_special_breach_anim["famas_woodland_eotech"] = 1;
    level.has_special_breach_anim["famas_woodland_acog"] = 1;
    level.has_special_breach_anim["famas_woodland_reflex"] = 1;
    level.has_special_breach_anim["famas_woodland_shotgun"] = 1;
    level.has_special_breach_anim["famas_woodland_shotgun_attach"] = 1;
    level.has_special_breach_anim["fn2000"] = 1;
    level.has_special_breach_anim["fn2000_acog"] = 1;
    level.has_special_breach_anim["fn2000_eotech"] = 1;
    level.has_special_breach_anim["fn2000_reflex"] = 1;
    level.has_special_breach_anim["fn2000_scope"] = 1;
    level.has_special_breach_anim["fn2000_shotgun"] = 1;
    level.has_special_breach_anim["fn2000_shotgun_attach"] = 1;
    level.has_special_breach_anim["fn2000_silencer"] = 1;
    level.has_special_breach_anim["fn2000_thermal"] = 1;
    level.has_special_breach_anim["glock"] = 1;
    level.has_special_breach_anim["kriss"] = 1;
    level.has_special_breach_anim["kriss_reflex"] = 1;
    level.has_special_breach_anim["kriss_eotech"] = 1;
    level.has_special_breach_anim["kriss_acog_silencer"] = 1;
    level.has_special_breach_anim["m1014"] = 1;
    level.has_special_breach_anim["m14_scoped"] = 1;
    level.has_special_breach_anim["m14_scoped_arctic"] = 1;
    level.has_special_breach_anim["m14_scoped_ghil"] = 1;
    level.has_special_breach_anim["m14_scoped_silencer"] = 1;
    level.has_special_breach_anim["m14_scoped_silencer_woodland"] = 1;
    level.has_special_breach_anim["m14_scoped_woodland"] = 1;
    level.has_special_breach_anim["m14ebr"] = 1;
    level.has_special_breach_anim["m14ebr_thermal"] = 1;
    level.has_special_breach_anim["m203"] = 1;
    level.has_special_breach_anim["m16_acog"] = 1;
    level.has_special_breach_anim["m16_basic"] = 1;
    level.has_special_breach_anim["m16_grenadier"] = 1;
    level.has_special_breach_anim["m16_reflex"] = 1;
    level.has_special_breach_anim["m16_silencer"] = 1;
    level.has_special_breach_anim["m21_baseasset"] = 1;
    level.has_special_breach_anim["m21_scoped_arctic_silenced"] = 1;
    level.has_special_breach_anim["mp5"] = 1;
    level.has_special_breach_anim["mp5_arctic"] = 1;
    level.has_special_breach_anim["mp5_arctic_reflex"] = 1;
    level.has_special_breach_anim["mp5_eotech"] = 1;
    level.has_special_breach_anim["mp5_reflex"] = 1;
    level.has_special_breach_anim["mp5_silencer"] = 1;
    level.has_special_breach_anim["mp5_silencer_reflex"] = 1;
    level.has_special_breach_anim["ranger"] = 1;
    level.has_special_breach_anim["striker"] = 1;
    level.has_special_breach_anim["striker_reflex"] = 1;
    level.has_special_breach_anim["striker_woodland"] = 1;
    level.has_special_breach_anim["striker_woodland_reflex"] = 1;
    level.has_special_breach_anim["tavor_acog"] = 1;
    level.has_special_breach_anim["tavor_digital_acog"] = 1;
    level.has_special_breach_anim["tavor_digital_eotech"] = 1;
    level.has_special_breach_anim["tavor_digital_mars"] = 1;
    level.has_special_breach_anim["tavor_digital_reflex"] = 1;
    level.has_special_breach_anim["tavor_eotech"] = 1;
    level.has_special_breach_anim["tavor_mars"] = 1;
    level.has_special_breach_anim["tavor_reflex"] = 1;
    level.has_special_breach_anim["tavor_woodland_acog"] = 1;
    level.has_special_breach_anim["tavor_woodland_eotech"] = 1;
    level.has_special_breach_anim["tavor_woodland_mars"] = 1;
    level.has_special_breach_anim["tavor_woodland_reflex"] = 1;
    level.has_special_breach_anim["tmp"] = 1;
    level.has_special_breach_anim["tmp_reflex"] = 1;
    level.has_special_breach_anim["tmp_silencer"] = 1;
    level.has_special_breach_anim["ump45"] = 1;
    level.has_special_breach_anim["ump45_acog"] = 1;
    level.has_special_breach_anim["ump45_arctic"] = 1;
    level.has_special_breach_anim["ump45_arctic_acog"] = 1;
    level.has_special_breach_anim["ump45_arctic_reflex"] = 1;
    level.has_special_breach_anim["ump45_reflex"] = 1;
    level.has_special_breach_anim["ump45_silencer"] = 1;
    level.has_special_breach_anim["ump45_eotech"] = 1;
    level.has_special_breach_anim["wa2000"] = 1;
    level.has_special_breach_anim["wa2000_thermal"] = 1;
    level.has_special_breach_anim["g36c"] = 1;
    level.has_special_breach_anim["g36c_acog"] = 1;
    level.has_special_breach_anim["g36c_reflex"] = 1;
    level.has_special_breach_anim["g36c_grenadier"] = 1;
    level.has_special_breach_anim["pecheneg"] = 1;
    level.has_special_breach_anim["pecheneg_reflex"] = 1;
    level.has_special_breach_anim["gl_g36c"] = 1;
    level.has_special_breach_anim["m240"] = 1;
    level.has_special_breach_anim["m240_reflex"] = 1;
    level.has_special_breach_anim["m240_acog"] = 1;
    level.has_special_breach_anim["m4_grenadier"] = 1;
    level.has_special_breach_anim["m4_grunt"] = 1;
    level.has_special_breach_anim["m4_grunt_acog"] = 1;
    level.has_special_breach_anim["m4_grunt_reflex"] = 1;
    level.has_special_breach_anim["m4_shotgun"] = 1;
    level.has_special_breach_anim["m4_shotgun_attach"] = 1;
    level.has_special_breach_anim["m4_silencer"] = 1;
    level.has_special_breach_anim["m4_silencer_acog"] = 1;
    level.has_special_breach_anim["alt_m4m203_acog"] = 1;
    level.has_special_breach_anim["m4m203_acog"] = 1;
    level.has_special_breach_anim["alt_m4m203_acog_payback"] = 1;
    level.has_special_breach_anim["m4m203_acog_payback"] = 1;
    level.has_special_breach_anim["m4m203_reflex"] = 1;
    level.has_special_breach_anim["m4m203_reflex_arctic"] = 1;
    level.has_special_breach_anim["m4m203_silencer"] = 1;
    level.has_special_breach_anim["m4m203_silencer_reflex"] = 1;
    level.has_special_breach_anim["m4m203_eotech"] = 1;
    level.has_special_breach_anim["scar_h"] = 1;
    level.has_special_breach_anim["scar_h_fgrip"] = 1;
    level.has_special_breach_anim["scar_h_acog"] = 1;
    level.has_special_breach_anim["scar_h_grenadier"] = 1;
    level.has_special_breach_anim["scar_h_reflex"] = 1;
    level.has_special_breach_anim["scar_h_shotgun"] = 1;
    level.has_special_breach_anim["scar_h_shotgun_attach"] = 1;
    level.has_special_breach_anim["scar_h_silencer"] = 1;
    level.has_special_breach_anim["scar_h_thermal_silencer"] = 1;
    level.has_special_breach_anim["scar_h_thermal"] = 1;
    level.has_special_breach_anim["scar_h_m203"] = 1;
    level.has_special_breach_anim["m203_m4"] = 1;
    level.has_special_breach_anim["m203_m4_acog"] = 1;
    level.has_special_breach_anim["m203_m4_eotech"] = 1;
    level.has_special_breach_anim["m203_m4_reflex"] = 1;
    level.has_special_breach_anim["m203_m4_silencer"] = 1;
    level.has_special_breach_anim["m203_m4_silencer_reflex"] = 1;
    level.has_special_breach_anim["m203_m4_reflex_arctic"] = 1;
    level.has_special_breach_anim["coltanaconda"] = 1;
    level.has_special_breach_anim["deserteagle"] = 1;
    level.has_special_breach_anim["pp2000"] = 1;
    level.has_special_breach_anim["pp2000_reflex"] = 1;
    level.has_special_breach_anim["pp2000_silencer"] = 1;
    level.has_special_breach_anim["pp2000_thermal"] = 1;
    level.has_special_breach_anim["ak47"] = 1;
    level.has_special_breach_anim["ak47_acog"] = 1;
    level.has_special_breach_anim["ak47_arctic"] = 1;
    level.has_special_breach_anim["ak47_arctic_acog"] = 1;
    level.has_special_breach_anim["ak47_arctic_eotech"] = 1;
    level.has_special_breach_anim["ak47_arctic_grenadier"] = 1;
    level.has_special_breach_anim["ak47_arctic_reflex"] = 1;
    level.has_special_breach_anim["ak47_desert"] = 1;
    level.has_special_breach_anim["ak47_desert_acog"] = 1;
    level.has_special_breach_anim["ak47_desert_eotech"] = 1;
    level.has_special_breach_anim["ak47_desert_grenadier"] = 1;
    level.has_special_breach_anim["ak47_desert_reflex"] = 1;
    level.has_special_breach_anim["ak47_digital"] = 1;
    level.has_special_breach_anim["ak47_digital_acog"] = 1;
    level.has_special_breach_anim["ak47_digital_eotech"] = 1;
    level.has_special_breach_anim["ak47_digital_grenadier"] = 1;
    level.has_special_breach_anim["ak47_digital_reflex"] = 1;
    level.has_special_breach_anim["ak47_eotech"] = 1;
    level.has_special_breach_anim["ak47_fall"] = 1;
    level.has_special_breach_anim["ak47_fall_acog"] = 1;
    level.has_special_breach_anim["ak47_fall_eotech"] = 1;
    level.has_special_breach_anim["ak47_fall_grenadier"] = 1;
    level.has_special_breach_anim["ak47_fall_reflex"] = 1;
    level.has_special_breach_anim["ak47_grenadier"] = 1;
    level.has_special_breach_anim["ak47_reflex"] = 1;
    level.has_special_breach_anim["ak47_shotgun"] = 1;
    level.has_special_breach_anim["ak47_shotgun_attach"] = 1;
    level.has_special_breach_anim["ak47_silencer"] = 1;
    level.has_special_breach_anim["ak47_thermal"] = 1;
    level.has_special_breach_anim["ak47_woodland"] = 1;
    level.has_special_breach_anim["ak47_woodland_acog"] = 1;
    level.has_special_breach_anim["ak47_woodland_eotech"] = 1;
    level.has_special_breach_anim["ak47_woodland_grenadier"] = 1;
    level.has_special_breach_anim["ak47_woodland_reflex"] = 1;
    level.has_special_breach_anim["gl_ak47"] = 1;
    level.has_special_breach_anim["gl_ak47_arctic"] = 1;
    level.has_special_breach_anim["masada"] = 1;
    level.has_special_breach_anim["masada_acog"] = 1;
    level.has_special_breach_anim["masada_dcburn_mt_black_off"] = 1;
    level.has_special_breach_anim["masada_dcburn_mt_black_on"] = 1;
    level.has_special_breach_anim["masada_digital"] = 1;
    level.has_special_breach_anim["masada_digital_acog"] = 1;
    level.has_special_breach_anim["masada_digital_eotech"] = 1;
    level.has_special_breach_anim["masada_digital_grenadier_eotech"] = 1;
    level.has_special_breach_anim["gl_masada_digital_eotech"] = 1;
    level.has_special_breach_anim["masada_digital_reflex"] = 1;
    level.has_special_breach_anim["masada_eotech"] = 1;
    level.has_special_breach_anim["masada_grenadier_acog"] = 1;
    level.has_special_breach_anim["masada_reflex"] = 1;
    level.has_special_breach_anim["masada_silencer_motion_tracker_off"] = 1;
    level.has_special_breach_anim["masada_silencer_motion_tracker_on"] = 1;
    level.has_special_breach_anim["masada_silencer_mt_black_off"] = 1;
    level.has_special_breach_anim["masada_silencer_mt_black_on"] = 1;
    level.has_special_breach_anim["masada_silencer_mt_camo_off"] = 1;
    level.has_special_breach_anim["masada_silencer_mt_camo_on"] = 1;
    level.has_special_breach_anim["masada_silencer_mt_dust_off"] = 1;
    level.has_special_breach_anim["masada_silencer_mt_dust_on"] = 1;
    level.has_special_breach_anim["uzi"] = 1;
    level.has_special_breach_anim["uzi_sd"] = 1;
    level.has_special_breach_anim["uzi_silencer"] = 1;
    level.has_special_breach_anim["uzi_akimbo"] = 1;
    level.has_special_breach_anim["p90"] = 1;
    level.has_special_breach_anim["p90_acog"] = 1;
    level.has_special_breach_anim["p90_eotech"] = 1;
    level.has_special_breach_anim["p90_reflex"] = 1;
    level.has_special_breach_anim["p90_silencer"] = 1;
    level.has_special_breach_anim["p90_arctic"] = 1;
    level.has_special_breach_anim["p90_arctic_acog"] = 1;
    level.has_special_breach_anim["p90_arctic_eotech"] = 1;
    level.has_special_breach_anim["p90_arctic_reflex"] = 1;
    level.has_special_breach_anim["rpd"] = 1;
    level.has_special_breach_anim["rpd_acog"] = 1;
    level.has_special_breach_anim["rpd_grip"] = 1;
    level.has_special_breach_anim["rpd_reflex"] = 1;
    level.has_special_breach_anim["sa80"] = 1;
    level.has_special_breach_anim["sa80_scope"] = 1;
    level.has_special_breach_anim["sa80lmg"] = 1;
    level.has_special_breach_anim["sa80lmg_reflex"] = 1;
    level.has_special_breach_anim["sa80lmg_scope"] = 1;
    level.has_special_breach_anim["at4"] = 1;
    level.has_special_breach_anim["at4_straight"] = 1;
    level.has_special_breach_anim["model1887"] = 1;
    level.has_special_breach_anim["usp"] = 1;
    level.has_special_breach_anim["usp_airport"] = 1;
    level.has_special_breach_anim["usp_silencer"] = 1;
    level.has_special_breach_anim["dragunov"] = 1;
    level.has_special_breach_anim["dragunov_arctic"] = 1;
    level.has_special_breach_anim["dragunov_desert"] = 1;
    level.has_special_breach_anim["dragunov_fall"] = 1;
    level.has_special_breach_anim["dragunov_woodland"] = 1;
    level.has_special_breach_anim["mg4"] = 1;
    level.has_special_breach_anim["mg4_acog"] = 1;
    level.has_special_breach_anim["mg4_arctic"] = 1;
    level.has_special_breach_anim["mg4_arctic_reflex"] = 1;
    level.has_special_breach_anim["mg4_arctic_thermal"] = 1;
    level.has_special_breach_anim["mg4_reflex"] = 1;
    level.has_special_breach_anim["mg4_thermal"] = 1;
    level.has_special_breach_anim["spas12"] = 1;
    level.has_special_breach_anim["spas12_arctic"] = 1;
    level.has_special_breach_anim["spas12_arctic_eotech"] = 1;
    level.has_special_breach_anim["spas12_arctic_grip"] = 1;
    level.has_special_breach_anim["spas12_arctic_heartbeat"] = 1;
    level.has_special_breach_anim["spas12_arctic_heartbeat_attach"] = 1;
    level.has_special_breach_anim["spas12_arctic_reflex"] = 1;
    level.has_special_breach_anim["spas12_eotech"] = 1;
    level.has_special_breach_anim["spas12_grip"] = 1;
    level.has_special_breach_anim["spas12_heartbeat"] = 1;
    level.has_special_breach_anim["spas12_heartbeat_attach"] = 1;
    level.has_special_breach_anim["spas12_reflex"] = 1;
    level.has_special_breach_anim["spas12_silencer"] = 1;
    level.has_special_breach_anim["paw20_eotech"] = 1;
    level.has_special_breach_anim["acr_hybrid"] = 1;
    level.has_special_breach_anim["acr_hybrid_silenced"] = 1;
    level.has_special_breach_anim["alt_acr_hybrid"] = 1;
    level.has_special_breach_anim["alt_acr_hybrid_silenced"] = 1;
    level.has_special_breach_anim["p99"] = 1;
    level.has_special_breach_anim["rsass"] = 1;
    level.has_special_breach_anim["fnfiveseven"] = 1;
    level.has_special_breach_anim["pp90m1"] = 1;
    level.has_special_breach_anim["pp90m1_acog"] = 1;
    level.has_special_breach_anim["pp90m1_eotech"] = 1;
    level.has_special_breach_anim["pp90m1_reflex"] = 1;
    level.has_special_breach_anim["pp90m1_silencer"] = 1;
    common_scripts\utility::flag_init( "breaching_on" );
    common_scripts\utility::flag_init( "no_mercy" );
    common_scripts\utility::flag_init( "breach_plant" );
    common_scripts\utility::flag_init( "breach_settle" );
    common_scripts\utility::flag_init( "breach_slowmo" );
}

check_missing_animation()
{
    if ( !isdefined( self.animation ) )
        return;

    if ( will_be_manhandled() && self.script_noteworthy == "manhandled" )
    {
        var_0 = getent( self.target, "targetname" );
        level.manhandled_spawners[self.export] = var_0;
    }

    var_1 = self.script_parameters;

    if ( isdefined( var_1 ) )
        level.missing_animation_parameters[var_1] = 1;

    level.missing_animations[self.animation] = 1;
}

is_breach_anim_loop_setup( var_0, var_1, var_2 )
{
    if ( !isdefined( level.scr_anim["generic"][var_0] ) )
        return 0;

    if ( !isdefined( level.scr_anim["generic"][var_0][var_1] ) )
        return 0;

    return 1;
}

is_breach_anim_single_setup( var_0, var_1 )
{
    if ( !isdefined( level.scr_anim["generic"][var_0] ) )
        return 0;

    return 1;
}

dump_missing_anims()
{
    if ( !level.missing_animations.size )
        return;

    var_0 = [];
    var_0[var_0.size] = "_survives";
    var_0[var_0.size] = "_death";
    var_0[var_0.size] = "_death2";
    var_0[var_0.size] = "_idle";
    var_0[var_0.size] = "_manhandled_guarded";
    var_0[var_0.size] = "_manhandled";
    var_0[var_0.size] = "_manhandled_guarded_idle";
    var_0[var_0.size] = "_manhandled_idle";
    var_0[var_0.size] = "_manhandled_guarded_prepare_idle";
    var_0[var_0.size] = "_manhandled_prepare_idle";
    var_0[var_0.size] = "_manhandled_guarded_prepare";
    var_0[var_0.size] = "_manhandled_prepare";
    var_1 = [];

    foreach ( var_7, var_3 in level.missing_animation_parameters )
    {
        foreach ( var_5 in var_0 )
            var_1[var_1.size] = var_5 + var_7;
    }

    var_0 = common_scripts\utility::array_combine( var_0, var_1 );

    foreach ( var_17, var_3 in level.missing_animations )
    {
        var_9 = 0;

        if ( isdefined( level.scr_stub["generic"][var_17] ) )
        {
            if ( isarray( level.scr_stub["generic"][var_17] ) )
            {
                foreach ( var_12, var_11 in level.scr_stub["generic"][var_17] )
                {
                    if ( !is_breach_anim_loop_setup( var_17, var_12, var_11 ) )
                        var_9 = 1;
                }
            }
            else if ( !is_breach_anim_single_setup( var_17, level.scr_stub["generic"][var_17] ) )
                var_9 = 1;
        }

        foreach ( var_5 in var_0 )
        {
            var_14 = var_17 + var_5;

            if ( !isdefined( level.scr_stub["generic"][var_14] ) )
                continue;

            if ( isarray( level.scr_stub["generic"][var_14] ) )
            {
                foreach ( var_12, var_11 in level.scr_stub["generic"][var_14] )
                {
                    if ( !is_breach_anim_loop_setup( var_14, var_12, var_11 ) )
                        var_9 = 1;
                }

                continue;
            }

            if ( !is_breach_anim_single_setup( var_14, level.scr_stub["generic"][var_14] ) )
                var_9 = 1;
        }

        if ( var_9 )
            level.missing_animations[var_17] = undefined;
    }

    level.missing_animation_parameters = undefined;
    level.missing_animations = undefined;
}

#using_animtree("generic_human");

breach_anims()
{
    level.breach_death_anims = [];
    maps\_anim::addnotetrack_attach( "generic", "attach knife right", "weapon_parabolic_knife", "TAG_INHAND" );
    maps\_anim::addnotetrack_detach( "generic", "detach knife right", "weapon_parabolic_knife", "TAG_INHAND", "breach_react_knife_charge" );
    level.scr_stub["generic"]["takedown_room2B_soldier1"] = "h2_room2b_takedown_soldier1";
    level.scr_stub["generic"]["takedown_room2B_soldier2"] = "h2_room2b_takedown_soldier2";
    level.scr_stub["generic"]["takedown_room1Alt_soldier"] = "takedown_room1Alt_soldier";
    level.scr_stub["generic"]["takedown_room1Alt_soldier_idle"][0] = "takedown_room1Alt_soldier_idle";
    level.scr_stub["generic"]["takedown_room2A_soldier1"] = "takedown_room2A_soldier1";
    level.scr_stub["generic"]["takedown_room2A_soldier2"] = "takedown_room2A_soldier2";
    level.scr_stub["generic"]["takedown_room1B_soldier"] = "takedown_room1B_soldier";
    level.scr_stub["generic"]["takedown_room1B_soldier_idle"][0] = "takedown_room1B_soldier_idle";
    level.scr_stub["generic"]["takedown_room1A_soldier"] = "takedown_room1A_soldier";
    level.scr_stub["generic"]["takedown_room1A_soldier_idle"][0] = "takedown_room1A_soldier_idle";
    level.scr_stub["generic"]["hostage_chair_twitch1"] = "hostage_chair_twitch1";
    level.scr_stub["generic"]["hostage_chair_twitch2"] = "hostage_chair_twitch2";
    level.scr_stub["generic"]["hostage_chair_twitch3"] = "hostage_chair_twitch3";
    level.scr_stub["generic"]["hostage_chair_twitch4"] = "hostage_chair_twitch4";
    add_slowmo_breach_custom_function( "hostage_chair_twitch1", ::_slomo_breach_c4_hostage );
    add_slowmo_breach_custom_function( "hostage_chair_twitch2", ::_slomo_breach_c4_hostage );
    add_slowmo_breach_custom_function( "hostage_chair_twitch3", ::_slomo_breach_c4_hostage );
    add_slowmo_breach_custom_function( "hostage_chair_twitch4", ::_slomo_breach_c4_hostage );
    level.scr_stub["generic"]["execution_shield_soldier"] = "execution_shield_soldier";
    level.scr_stub["generic"]["execution_shield_hostage"] = "execution_shield_hostage";
    level.scr_stub["generic"]["execution_shield_hostage_death"] = "execution_shield_hostage_death";
    level.scr_stub["generic"]["execution_shield_hostage_survives"] = "execution_shield_hostage_survives";
    level.scr_stub["generic"]["execution_shield_hostage_idle"][0] = "hostage_knees_idle";
    add_slowmo_breach_custom_function( "execution_shield_soldier", ::_slomo_breach_executioner_pistol );
    add_slowmo_breach_custom_function( "execution_shield_hostage", ::_slomo_breach_executed_guy );
    level.scr_stub["generic"]["execution_knife_soldier"] = "execution_knife_soldier";
    level.scr_stub["generic"]["execution_knife_hostage"] = "execution_knife_hostage";
    level.scr_stub["generic"]["execution_knife_hostage_death"] = "execution_knife_hostage_death";
    level.scr_stub["generic"]["execution_knife_hostage_idle"][0] = "hostage_knees_idle";
    level.scr_stub["generic"]["execution_knife_hostage_manhandled"] = "h2_room2b_takedown_hostage1";
    add_slowmo_breach_custom_function( "execution_knife_hostage", ::_slomo_breach_executed_guy );
    add_slowmo_breach_custom_function( "execution_knife_soldier", ::_slomo_breach_executioner_knife );
    level.scr_stub["generic"]["execution_knife2_soldier"] = "execution_knife2_soldier";
    level.scr_stub["generic"]["execution_knife2_hostage"] = "execution_knife2_hostage";
    level.scr_stub["generic"]["execution_knife2_hostage_death"] = "execution_knife2_hostage_death";
    level.scr_stub["generic"]["execution_knife2_hostage_idle"][0] = "hostage_stand_idle";
    add_slowmo_breach_custom_function( "execution_knife2_hostage", ::_slomo_breach_executed_guy );
    add_slowmo_breach_custom_function( "execution_knife2_soldier", ::_slomo_breach_executioner_knife );
    level.scr_stub["generic"]["execution_onknees_soldier"] = "execution_onknees_soldier";
    level.scr_stub["generic"]["execution_onknees_hostage"] = "execution_onknees_hostage";
    level.scr_stub["generic"]["execution_onknees_hostage_idle"][0] = "execution_onknees_hostage_survives";
    level.scr_stub["generic"]["execution_onknees_hostage_death"] = "execution_onknees_hostage_death";
    level.scr_stub["generic"]["execution_onknees_hostage_manhandled_guarded"] = "takedown_room1A_hostageB";
    level.scr_stub["generic"]["execution_onknees_hostage_manhandled_guarded_idle"][0] = "takedown_room1A_hostageB_idle";
    add_slowmo_breach_custom_function( "execution_onknees_soldier", ::_slomo_breach_executioner_pistol );
    add_slowmo_breach_custom_function( "execution_onknees_hostage", ::_slomo_breach_executed_guy );
    level.scr_stub["generic"]["execution_onknees2_soldier"] = "execution_onknees2_soldier";
    level.scr_stub["generic"]["execution_onknees2_hostage"] = "execution_onknees2_hostage";
    level.scr_stub["generic"]["execution_onknees2_hostage_survives"] = "execution_onknees2_hostage_survives";
    level.scr_stub["generic"]["execution_onknees2_hostage_death"] = "execution_onknees2_hostage_death";
    level.scr_stub["generic"]["execution_onknees2_hostage_manhandled_guarded"] = "h2_room2b_takedown_hostage2";
    level.scr_stub["generic"]["execution_onknees2_hostage_manhandled_guarded_prepare_idleV2"][0] = "takedown_room2A_hostageB_start_idle";
    level.scr_stub["generic"]["execution_onknees2_hostage_manhandled_guardedV2"] = "takedown_room2A_hostageB";
    level.scr_stub["generic"]["execution_onknees2_hostage_manhandled_guarded_idleV2"][0] = "takedown_room2A_hostageB_end_idle";
    add_slowmo_breach_custom_function( "execution_onknees2_soldier", ::_slomo_breach_executioner_pistol );
    add_slowmo_breach_custom_function( "execution_onknees2_hostage", ::_slomo_breach_executed_guy_pushed_to_floor );
    level.scr_stub["generic"]["execution_slamwall_soldier"] = "execution_slamwall_soldier";
    level.scr_stub["generic"]["execution_slamwall_hostage"] = "execution_slamwall_hostage";
    level.scr_stub["generic"]["execution_slamwall_hostage_idle"][0] = "hostage_stand_idle";
    level.scr_stub["generic"]["execution_slamwall_hostage_death"] = "execution_slamwall_hostage_death";
    level.scr_stub["generic"]["execution_slamwall_hostage_manhandled_prepare"] = "takedown_room2A_hostageA_flee";
    level.scr_stub["generic"]["execution_slamwall_hostage_manhandled_prepare_idle"][0] = "takedown_room2A_hostageA_hide_idle";
    level.scr_stub["generic"]["execution_slamwall_hostage_manhandled"] = "takedown_room2A_hostageA";
    level.scr_stub["generic"]["execution_slamwall_hostage_manhandled_idle"][0] = "takedown_room2A_hostageA_end_idle";
    add_slowmo_breach_custom_function( "execution_slamwall_soldier", ::_slomo_breach_executioner_pistol );
    add_slowmo_breach_custom_function( "execution_slamwall_hostage", ::_slomo_breach_executed_guy );
    level.scr_stub["generic"]["execution_fightback_guy1_03"] = "execution_fightback_guy1_03";
    level.scr_stub["generic"]["execution_fightback_guy2_03"] = "execution_fightback_guy2_03";
    level.scr_stub["generic"]["execution_fightback_guy2_03_death"] = "execution_fightback_guy2_03_death";
    level.scr_stub["generic"]["execution_fightback_guy2_03_survives"] = "execution_fightback_guy2_03_survives";
    add_slowmo_breach_custom_function( "execution_fightback_guy1_03", ::_slomo_breach_executioner_pistol );
    add_slowmo_breach_custom_function( "execution_fightback_guy2_03", ::_slomo_breach_executed_guy_pushed_to_floor );
    level.scr_stub["generic"]["patrol_bored_react"] = "patrol_bored_react_walkstop";
    level.scr_stub["generic"]["exposed_idle_react"] = "exposed_idle_reactA";
    level.scr_stub["generic"]["chess_surprise"] = "parabolic_chessgame_surprise_b";
    level.scr_stub["generic"]["breach_chair_reaction_v1"] = "breach_chair_reaction_v1";
    level.scr_stub["generic"]["patrol_bored_react_walkstop"] = "patrol_bored_react_walkstop";
    level.scr_stub["generic"]["exposed_idle_reactA"] = "exposed_idle_reactA";
    level.scr_stub["generic"]["hostage_stand_react_front"] = "hostage_stand_react_front";
    level.scr_stub["generic"]["hostage_stand_react_front_idle"][0] = "hostage_stand_idle";
    level.scr_stub["generic"]["hostage_stand_react_front_manhandled"] = "takedown_room1Alt_hostage";
    level.scr_stub["generic"]["hostage_stand_react_front_manhandled_idle"][0] = "takedown_room1Alt_hostage_idle";
    level.scr_stub["generic"]["death_explosion_stand_B_v3"] = "death_explosion_stand_B_v3";
    level.scr_stub["generic"]["breach_stackL_approach"] = "breach_stackL_approach";
    level.scr_stub["generic"]["react_stand_2_run_R45"] = "react_stand_2_run_R45";
    level.breach_death_anims["death_explosion_stand_B_v3"] = 1;
    add_slowmo_breach_custom_function( "hostage_stand_react_front", ::_slomo_breach_hostage_react );
    level.scr_stub["generic"]["hostage_stand_fall"] = "hostage_stand_fall";
    level.scr_stub["generic"]["hostage_stand_fall_idle"][0] = "hostage_knees_idle";
    level.scr_stub["generic"]["hostage_stand_fall_idle"][1] = "hostage_knees_twitch";
    level.scr_stub["generic"]["hostage_stand_fall_manhandled"] = "takedown_room1A_hostageA";
    level.scr_stub["generic"]["hostage_stand_fall_manhandled_idle"][0] = "takedown_room1A_hostageA_idle";
    level.scr_stub["generic"]["hostage_stand_fall_manhandledV2"] = "takedown_room1B_hostage";
    level.scr_stub["generic"]["hostage_stand_fall_manhandled_idleV2"][0] = "takedown_room1B_hostage_idle";
    add_slowmo_breach_custom_function( "hostage_stand_fall", ::_slomo_breach_hostage_react );
    level.scr_stub["generic"]["breach_react_knife_idle"] = "breach_react_knife_idle";
    level.scr_stub["generic"]["breach_react_knife_charge"] = "breach_react_knife_charge";
    level.scr_stub["generic"]["breach_react_knife_charge_death"] = "death_shotgun_back_v1";
    add_slowmo_breach_custom_function( "breach_react_knife_charge", ::_slomo_breach_knife_charger );
    level.scr_stub["generic"]["breach_react_blowback_v1"] = "breach_react_blowback_v1";
    level.scr_stub["generic"]["breach_react_blowback_v2"] = "breach_react_blowback_v1";
    level.scr_stub["generic"]["breach_react_blowback_v3"] = "breach_react_blowback_v1";
    level.scr_stub["generic"]["dying_crawl_back"] = "dying_crawl_back";
    add_slowmo_breach_custom_function( "breach_react_blowback_v1", ::_slomo_breach_blowback_guy );
    add_slowmo_breach_custom_function( "breach_react_blowback_v2", ::_slomo_breach_blowback_guy );
    level.scr_stub["generic"]["breach_react_desk_v1"] = "breach_react_desk_v1";
    level.scr_stub["generic"]["breach_react_desk_v2"] = "breach_react_desk_v2";
    level.scr_stub["generic"]["breach_react_desk_v3"] = "breach_react_desk_v3";
    level.scr_stub["generic"]["breach_react_desk_v4"] = "breach_react_desk_v4";
    level.scr_stub["generic"]["breach_react_desk_v5"] = "breach_react_desk_v5";
    level.scr_stub["generic"]["breach_react_desk_v6"] = "breach_react_desk_v6";
    level.scr_stub["generic"]["breach_react_desk_v7"] = "breach_react_desk_v7";
    add_slowmo_breach_custom_function( "breach_react_desk_v7", ::_slomo_breach_desk_guy );
    level.scr_stub["generic"]["breach_react_push_guy1"] = "breach_react_push_guy1";
    level.scr_stub["generic"]["breach_react_push_guy2"] = "breach_react_push_guy2";
    level.scr_stub["generic"]["breach_react_guntoss_v1_guy1"] = "breach_react_guntoss_v1_guy1";
    level.scr_stub["generic"]["breach_react_guntoss_v1_guy2"] = "breach_react_guntoss_v1_guy2";
    level.scr_stub["generic"]["breach_react_guntoss_v2_guy1"] = "breach_react_guntoss_v2_guy1";
    level.scr_stub["generic"]["breach_react_guntoss_v2_guy2"] = "breach_react_guntoss_v2_guy2";
    level.scr_stub["generic"]["breach_chair_hide_reaction_v1"] = "breach_chair_hide_reaction_v1";
    level.scr_stub["generic"]["breach_chair_hide_reaction_v1_death"] = "covercrouch_death_1";
    level.scr_stub["generic"]["breach_chair_hide_reaction_v1_death2"] = "covercrouch_death_2";
    level.scr_stub["generic"]["breach_chair_hide_reaction_v2"] = "breach_chair_hide_reaction_v2";
    level.scr_stub["generic"]["breach_chair_hide_reaction_v2_death"] = "breach_chair_hide_reaction_death_v2";
    add_slowmo_breach_custom_function( "breach_chair_hide_reaction_v1", ::_slomo_breach_chair_guy_normal );
    add_slowmo_breach_custom_function( "breach_chair_hide_reaction_v2", ::_slomo_breach_chair_guy_animated );
    level.scr_stub["generic"]["execution_fightback_guy1_02"] = "execution_fightback_guy1_02";
    level.scr_stub["generic"]["execution_fightback_guy2_02"] = "execution_fightback_guy2_02";
    level.scr_anim["generic"]["hostage_knees_loop"][0] = %hostage_knees_idle;
    level.scr_anim["generic"]["hostage_knees_loop"][1] = %hostage_knees_twitch;
}

friendly_animations()
{
    level.scr_anim["generic"]["breach_friend_idle_01"][0] = %breach_flash_r1_idle;
    level.scr_anim["generic"]["breach_friend_enter_01"] = %breach_flash_r1_enter;
    level.scr_anim["generic"]["breach_friend_idle_02"][0] = %breach_flash_r2_idle;
    level.scr_anim["generic"]["breach_friend_enter_02"] = %breach_flash_r2_enter;
    level.scr_anim["ally"]["breach_inspect"] = %h2_cornerstndl_breach_ally_nod;
    level.scr_anim["ally"]["breach_normal_v1"] = %h2_breach_npc_nod;
    level.scr_anim["ally"]["breach_normal_v2"] = %h2_breach_npc_hand_signal_v1;
    level.scr_anim["ally"]["breach_normal_v3"] = %h2_breach_npc_hand_signal_v2;
    level.scr_anim["ally"]["breach_normal_v4"] = %h2_breach_npc_hand_signal_v3;
    level.scr_anim["ally"]["breach_price"] = %h2_gulag_breach_rescue_soap;
    level.scr_anim["ally"]["breach_npc_chill"] = %h2_breach_npc_idle;
    level.scr_anim["ally"]["breach_npc_twitch"] = %h2_breach_npc_twitch;
    level.scr_anim["ally"]["breach_npc_thumbs_up"] = %h2_breach_npc_thumbs_up;
    level.scr_anim["ally"]["breach_npc_lets_go"] = %h2_breach_npc_lets_go;
    level.scr_anim["ally"]["breach_npc_listen"] = %h2_breach_npc_listen;
    level._id_C558["breach_price"] = "Capt. MacTavish";
}

breach_fx_setup()
{
    var_0 = self.script_fxid;
    var_1 = self.script_slowmo_breach;
    var_2 = common_scripts\utility::createexploder( var_0 );
    var_2.v["origin"] = self.origin;
    var_2.v["angles"] = self.angles;
    var_2.v["fxid"] = var_0;
    var_2.v["delay"] = 0;
    var_2.v["exploder"] = "breach_" + var_1;
    var_2.v["soundalias"] = "nil";
}

create_slowmo_breaches_from_entities()
{
    var_0 = [];
    var_1 = getentarray( "breach_left_org", "targetname" );
    var_2 = getentarray( "breach_right_org", "targetname" );
    var_3 = getentarray( "breach_enemy_spawner", "targetname" );
    var_4 = getentarray( "breach_hostage_spawner", "targetname" );
    var_5 = getentarray( "breach_friendlyenemy_spawner", "targetname" );
    var_6 = getentarray( "breach_friendlyhostage_spawner", "targetname" );
    var_7 = getentarray( "breach_coopenemy_spawner", "targetname" );
    var_8 = getentarray( "breach_coophostage_spawner", "targetname" );
    var_9 = getentarray( "breach_solid", "targetname" );
    var_10 = getentarray( "breach_door_volume", "targetname" );
    var_11 = getentarray( "breach_safe_volume", "targetname" );
    var_12 = getentarray( "trigger_use_breach", "classname" );
    var_13 = getentarray( "trigger_multiple_breachIcon", "classname" );
    var_14 = getentarray( "trigger_use_breach", "classname" );
    var_15 = getentarray( "breach_damage_trigger", "targetname" );
    level.scr_stub = undefined;

    foreach ( var_17 in var_1 )
    {
        var_18 = var_17.script_slowmo_breach;
        var_19 = "wood";

        if ( isdefined( var_17.script_slowmo_breach_doortype ) )
        {
            switch ( var_17.script_slowmo_breach_doortype )
            {
                case "payback_wood":
                case "caves_wood":
                case "estate_wood_backwards":
                case "estate_wood":
                case "oilrig":
                case "metal":
                case "wood":
                case "none":
                    var_19 = var_17.script_slowmo_breach_doortype;
                    break;
                default:
            }
        }

        var_20 = spawnstruct();
        var_20._id_567E = var_17;
        var_20.doortype = var_19;
        var_20.animname = common_scripts\utility::ter_op( isdefined( var_17._id_B7D0 ), var_17._id_B7D0, "" );

        if ( isdefined( var_17._id_B77A ) )
            var_20._id_AB70 = strtok( var_17._id_B77A, "," );
        else
            var_20._id_AB70 = [];

        var_20.spawners = [];
        var_20.spawners["enemy"] = [];
        var_20.spawners["hostage"] = [];
        var_20.spawners["friendlyenemy"] = [];
        var_20.spawners["friendlyhostage"] = [];
        var_20.spawners["coopenemy"] = [];
        var_20.spawners["coophostage"] = [];
        var_20.lookat_triggers = [];
        var_20.path_solids = [];
        var_20.enabled = 1;
        var_20.door_volume = [];
        var_20.room_volume = [];
        var_20.safe_volume = undefined;
        var_20.friendly_anim_ent = [];
        var_0[var_18] = var_20;
    }

    foreach ( var_17 in var_2 )
    {
        var_18 = var_17.script_slowmo_breach;
        var_0[var_18].right_post = var_17;
        var_23 = spawn( "script_origin", var_17.origin );
        var_23.angles = var_17.angles;
        var_20 = spawnstruct();
        var_20.entity = var_23;
        var_20.yaw = -90;
        var_20 maps\_utility::translate_local();
        var_0[var_18].friendly_anim_ent = var_23;
    }

    foreach ( var_26 in var_3 )
        var_0 = var_26 breach_spawner_setup( var_0, "enemy" );

    foreach ( var_26 in var_4 )
        var_0 = var_26 breach_spawner_setup( var_0, "hostage" );

    foreach ( var_26 in var_5 )
        var_0 = var_26 breach_spawner_setup( var_0, "friendlyenemy" );

    foreach ( var_26 in var_6 )
        var_0 = var_26 breach_spawner_setup( var_0, "friendlyhostage" );

    foreach ( var_26 in var_7 )
        var_0 = var_26 breach_spawner_setup( var_0, "coopenemy" );

    foreach ( var_26 in var_8 )
        var_0 = var_26 breach_spawner_setup( var_0, "coophostage" );

    foreach ( var_39 in var_13 )
    {
        var_18 = var_39.script_slowmo_breach;
        var_0[var_18].lookat_triggers[var_0[var_18].lookat_triggers.size] = var_39;
        var_40 = getent( var_39.target, "targetname" );
        var_39.breach_origin = var_40.origin;
        var_41 = getent( var_40.target, "targetname" );
        var_41.breached = 0;
        var_0[var_18].room_volume = var_41;
        var_40 thread breach_icon_think( var_39, var_18, var_41 );
        var_42 = var_41.script_flag;
        common_scripts\utility::flag_init( var_42 );
    }

    foreach ( var_39 in var_14 )
    {
        var_18 = var_39.script_slowmo_breach;
        var_45 = var_0[var_18].right_post.angles;
        var_46 = angleclamp( var_45[1] - 90 );
        var_39 usetriggerrequirelookat( var_46, 50 );
        var_0[var_18].trigger = var_39;

        if ( isdefined( var_39.script_breachgroup ) )
            var_39 thread breach_group_trigger_think();
    }

    foreach ( var_49 in var_10 )
    {
        var_18 = var_49.script_slowmo_breach;
        var_0[var_18].door_volume = var_49;
    }

    foreach ( var_49 in var_11 )
    {
        var_18 = var_49.script_slowmo_breach;
        var_0[var_18].safe_volume = var_49;
    }

    foreach ( var_54 in var_9 )
    {
        var_18 = var_54.script_slowmo_breach;
        var_0[var_18].path_solids[var_0[var_18].path_solids.size] = var_54;
    }

    foreach ( var_18, var_57 in var_0 )
        level thread slowmo_breach_think( var_57, var_18 );

    foreach ( var_39 in var_15 )
    {
        var_18 = var_39.script_slowmo_breach;
        var_39 thread slowmo_breach_damage_trigger_think( var_18 );
    }

    level.breach_groups = var_0;
}

objective_breach( var_0, var_1, var_2, var_3, var_4 )
{
    objective_setpointertextoverride( var_0, &"SCRIPT_WAYPOINT_BREACH" );
    objective_position( var_0, ( 0, 0, 0 ) );
    var_5 = [];

    if ( isdefined( var_1 ) )
        var_5[var_5.size] = var_1;

    if ( isdefined( var_2 ) )
        var_5[var_5.size] = var_2;

    if ( isdefined( var_3 ) )
        var_5[var_5.size] = var_3;

    if ( isdefined( var_4 ) )
        var_5[var_5.size] = var_4;

    var_6 = 0;

    foreach ( var_8 in var_5 )
    {
        var_9 = level.breach_groups[var_8]._id_567E;

        if ( !isdefined( var_9 ) )
            return;

        var_10 = anglestoright( var_9.angles );
        var_11 = var_9.origin + var_10 * -22.5 + ( 0, 0, 56 );
        objective_additionalposition( var_0, var_6, var_11 );
        var_6++;
    }
}

assign_script_breachgroup_to_ents( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        var_3 = 0;

        foreach ( var_9, var_5 in level.breach_groups )
        {
            foreach ( var_7 in var_5.lookat_triggers )
            {
                if ( distance( var_2.origin, var_7.breach_origin ) > 80 )
                    continue;

                var_2.script_slowmo_breach = var_9;
                var_3 = 1;
                break;
            }

            if ( var_3 )
                break;
        }
    }
}

get_breach_indices_from_ents( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
        var_1[var_1.size] = var_3.script_slowmo_breach;

    return var_1;
}

slowmo_breach_damage_trigger_think( var_0 )
{
    level waittill( "breaching_number_" + var_0 );
    wait 3;
    var_1 = getaiarray();
    var_1 = maps\_utility::array_merge( var_1, level.players );

    foreach ( var_3 in var_1 )
    {
        if ( var_3 istouching( self ) )
            return;
    }

    radiusdamage( self.origin, self.radius, 500, 500 );
    self delete();
}

icon_trigger_setup()
{
    self.script_flag = "breach_door_icon_" + self.script_slowmo_breach;
    level thread maps\_trigger::trigger_looking( self );
}

breach_icon_think( var_0, var_1, var_2 )
{
    thread breach_debug_display_animnames( var_2 );
    var_3 = newhudelem();
    var_3 setshader( "breach_icon", 1, 1 );
    var_3.alpha = 0;
    var_3.color = ( 1, 1, 1 );
    var_3.x = self.origin[0];
    var_3.y = self.origin[1];
    var_3.z = self.origin[2];
    var_3 setwaypoint( 1, 1 );
    var_4 = spawn( "script_model", self.origin );
    var_4 setmodel( "mil_frame_charge" );
    var_4 hidepart( "j_frame_charge" );
    wait 0.05;
    var_5 = "breach_door_icon_" + var_1;
    common_scripts\utility::flag_wait( var_5 );

    while ( !var_2.breached )
        wait 0.05;

    var_3 destroy();
    var_4 delete();
}

breach_spawner_setup( var_0, var_1 )
{
    var_2 = self.script_slowmo_breach;
    var_3 = 0;

    if ( isdefined( self.script_slowmo_breach_spawners ) )
    {
        if ( var_1 == "enemy" || var_1 == "hostage" )
            var_3 = self.script_slowmo_breach_spawners;
    }

    if ( !isdefined( var_0[var_2].spawners[var_1][var_3] ) )
        var_0[var_2].spawners[var_1][var_3] = [];

    var_4 = var_0[var_2].spawners[var_1][var_3];
    var_4[var_4.size] = self;
    var_0[var_2].spawners[var_1][var_3] = var_4;

    if ( var_0.size )
        return var_0;
    else
        return undefined;
}

slowmo_breach_think( var_0, var_1 )
{
    var_2 = var_0._id_567E;
    var_3 = var_0.right_post;
    var_4 = var_0.spawners["enemy"];
    var_5 = var_0.spawners["hostage"];
    var_6 = var_0.trigger;
    var_7 = var_0.path_solids;
    var_8 = var_0.door_volume;
    var_9 = var_0.room_volume;
    var_10 = [];
    var_11 = [];
    var_12 = [];
    var_13 = [];

    if ( isdefined( var_0.spawners["friendlyenemy"][0] ) )
    {
        var_10 = var_0.spawners["friendlyenemy"][0];
        var_0.spawners["friendlyenemy"] = var_10;
    }

    if ( isdefined( var_0.spawners["friendlyhostage"][0] ) )
    {
        var_11 = var_0.spawners["friendlyhostage"][0];
        var_0.spawners["friendlyhostage"] = var_11;
    }

    if ( isdefined( var_0.spawners["coopenemy"][0] ) )
    {
        var_12 = var_0.spawners["coopenemy"][0];
        var_0.spawners["coopenemy"] = var_12;
    }

    if ( isdefined( var_0.spawners["coophostage"][0] ) )
    {
        var_13 = var_0.spawners["coophostage"][0];
        var_0.spawners["coophostage"] = var_13;
    }

    var_14 = spawnstruct();
    var_14.entity = var_2;
    var_14.forward = 5;
    var_14.right = 6;
    var_14.yaw = -90;
    var_14 maps\_utility::translate_local();
    var_14 = spawnstruct();
    var_14.entity = var_3;
    var_14.right = -2;
    var_14.yaw = 90;
    var_14 maps\_utility::translate_local();
    var_15 = [];

    foreach ( var_18, var_17 in var_4 )
        var_15[var_18] = var_18;

    foreach ( var_18, var_17 in var_5 )
        var_15[var_18] = var_18;

    if ( var_15.size )
    {
        var_20 = common_scripts\utility::random( var_15 );

        if ( isdefined( var_4[var_20] ) )
            var_4 = var_4[var_20];
        else
            var_4 = [];

        if ( isdefined( var_5[var_20] ) )
            var_5 = var_5[var_20];
        else
            var_5 = [];
    }

    var_0.spawners["enemy"] = var_4;
    var_0.spawners["hostage"] = var_5;
    common_scripts\utility::array_thread( var_4, maps\_utility::add_spawn_function, ::breach_enemy_spawner_think );
    common_scripts\utility::array_thread( var_5, maps\_utility::add_spawn_function, ::breach_hostage_spawner_think );
    common_scripts\utility::array_thread( var_10, maps\_utility::add_spawn_function, ::breach_enemy_spawner_think );
    common_scripts\utility::array_thread( var_11, maps\_utility::add_spawn_function, ::breach_hostage_spawner_think );
    common_scripts\utility::array_thread( var_12, maps\_utility::add_spawn_function, ::breach_enemy_spawner_think );
    common_scripts\utility::array_thread( var_13, maps\_utility::add_spawn_function, ::breach_hostage_spawner_think );
    var_6 thread common_scripts\utility::_id_AE1E( level.player, &"SCRIPT_PLATFORM_BREACH_ACTIVATE", &"SCRIPT_PLATFORM_BREACH_ACTIVATE_KB", "trigger" );

    if ( !isdefined( level.breach_use_triggers ) )
        level.breach_use_triggers = [];

    level.breach_use_triggers = common_scripts\utility::array_add( level.breach_use_triggers, var_6 );
    var_21 = "breach_door_charge";
    var_22 = undefined;

    switch ( var_0.doortype )
    {
        case "metal":
            var_22 = "breach_door_model_metal";
            break;
        case "estate_wood":
            var_22 = "breach_door_model_estate";
            break;
        case "estate_wood_backwards":
            var_22 = "breach_door_model_estate";
            break;
        case "caves_wood":
            var_22 = "breach_door_model_caves";
            break;
        case "payback_wood":
            var_22 = "breach_door_model_payback";
            var_21 = "breach_door_charge_payback";
            break;
        case "oilrig":
            var_22 = "breach_door_model_oilrig";
            break;
        case "wood":
        case "none":
            var_22 = "breach_door_model";
            break;
        default:
            break;
    }

    var_23 = maps\_utility::spawn_anim_model( var_22 );

    if ( var_0.doortype == "none" || var_0.doortype == "estate_wood_backwards" )
        var_23 hide();

    level.breach_doors = [];
    level.breach_doors[var_1] = var_23;
    var_24 = maps\_utility::spawn_anim_model( var_21 );
    var_24 common_scripts\utility::hide_notsolid();
    var_2.scene_models = [];
    var_2 add_scene_model( "active_breacher_rig" );
    var_25 = var_2.scene_models["active_breacher_rig"];
    var_25 hide();
    var_26 = undefined;

    if ( maps\_utility::is_coop() )
    {
        var_2 add_coop_scene_models();
        var_26 = var_2.scene_models["passive_breacher_rig"];
        var_26 hide();
    }

    var_2.door = var_23;
    var_2.charge = var_24;
    var_2.post = var_3;
    var_2.breach_index = var_1;
    var_2 maps\_anim::anim_first_frame_solo( var_23, "breach" );
    var_2 maps\_anim::anim_first_frame_solo( var_24, "breach" );
    var_2 maps\_anim::anim_first_frame_solo( var_25, "breach_player_anim" );

    if ( maps\_utility::is_coop() )
        var_2 maps\_anim::anim_first_frame_solo( var_26, "breach_player_anim" );

    var_2 wait_for_breach_or_deletion( var_0 );

    foreach ( var_28 in var_2.scene_models )
        var_28 delete();

    if ( isdefined( var_6 ) )
        var_6 delete();

    if ( isdefined( var_23 ) )
        var_23 delete();

    if ( isdefined( var_24 ) )
        var_24 delete();

    if ( isdefined( var_2 ) )
        var_2 delete();

    if ( isdefined( var_3 ) )
        var_3 delete();
}

breach_should_be_skipped( var_0 )
{
    if ( !isdefined( level.skip_breach ) )
        return 0;

    if ( !isdefined( level.skip_breach[var_0] ) )
        return 0;

    return 1;
}

coop_player_touching_valid_door_volume( var_0, var_1 )
{
    var_2 = [];
    var_2[0] = var_0;

    if ( isdefined( var_0.script_breachgroup ) )
        var_2 = get_door_volumes_from_breachgroup( var_0.script_breachgroup );

    foreach ( var_4 in var_2 )
    {
        if ( var_1 istouching( var_4 ) )
            return 1;
    }

    return 0;
}

get_door_volumes_from_breachgroup( var_0 )
{
    var_1 = [];
    var_2 = getentarray( "breach_door_volume", "targetname" );

    foreach ( var_4 in var_2 )
    {
        if ( isdefined( var_4.script_breachgroup ) && var_4.script_breachgroup == var_0 )
            var_1[var_1.size] = var_4;
    }

    return var_1;
}

breach_participants_ready_to_proceed( var_0, var_1, var_2 )
{
    if ( maps\_utility::is_coop() )
    {
        var_3 = maps\_utility::get_other_player( var_0 );

        if ( var_3 maps\_utility::ent_flag_exist( "laststand_downed" ) && var_3 maps\_utility::ent_flag( "laststand_downed" ) )
            return 0;

        if ( coop_player_touching_valid_door_volume( var_2, var_3 ) )
            return 1;
        else
            return 0;
    }

    if ( var_1.size == 0 )
        return 1;

    if ( !room_has_multiple_doors( var_2 ) )
        return 1;

    if ( !breach_friendlies_ready_at_other_door( var_2, 1 ) )
    {
        if ( getdvar( "breach_requires_friendlies_in_position" ) == "1" )
        {
            if ( !breachfriendlies_can_teleport( var_1, var_2 ) )
                return 0;
        }
    }

    return 1;
}

wait_for_breach_or_deletion( var_0 )
{
    var_1 = var_0.trigger;

    if ( !isdefined( var_1 ) )
        return;

    var_2 = var_0.door_volume;
    var_1 endon( "death" );

    for (;;)
    {
        var_1 waittill( "trigger", var_3, var_4 );

        if ( gettime() == level.breach_passive_time )
            var_4 = level.breach_passive_player;

        var_5 = isdefined( var_4 );

        if ( !var_0.enabled )
            return;

        if ( isalive( var_3 ) && !var_5 )
        {
            if ( breach_failed_to_start() )
            {
                setsaveddvar( "r_progressIconRatio", 0 );
                continue;
            }
        }

        if ( isdefined( level._id_BD96 ) && level._id_BD96 )
            setsaveddvar( "compass", "0" );

        if ( isdefined( var_0.safe_volume ) && !maps\_utility::is_specialop() )
        {
            if ( isplayer( var_3 ) && isalive( var_3 ) )
            {
                var_6 = var_0.safe_volume maps\_utility::get_ai_touching_volume( "axis" );

                foreach ( var_8 in var_6 )
                {
                    if ( isdefined( var_8.ignore_safe_volume ) && var_8.ignore_safe_volume )
                        var_6 = common_scripts\utility::array_remove( var_6, var_8 );
                }

                if ( var_6.size )
                {
                    thread breach_too_many_enemies_hint();
                    setsaveddvar( "r_progressIconRatio", 0 );
                    continue;
                }
            }
        }

        var_10 = get_available_breachfriendlies( var_2 );

        if ( isplayer( var_3 ) && isalive( var_3 ) )
        {
            if ( breach_should_be_skipped( var_1.script_slowmo_breach ) )
                break;

            if ( breach_participants_ready_to_proceed( var_3, var_10, var_2 ) )
            {
                if ( player_breach( var_0, var_3 ) )
                    break;
            }
            else
                thread breach_friendly_hint();

            continue;
        }

        if ( var_10.size )
        {
            friendlies_breach( var_0, var_10 );
            break;
        }
        else
        {
            breachless_door_opens( var_0 );
            break;
        }
    }
}

breachfriendlies_can_teleport( var_0, var_1 )
{
    var_2 = 0;
    var_3 = get_player_volume( var_1 );

    foreach ( var_5 in var_0 )
    {
        if ( isdefined( var_3 ) )
        {
            if ( var_5 goalpos_within_volume( var_3 ) )
                continue;
        }

        if ( !var_5 friendly_can_teleport() )
            continue;

        var_2++;
    }

    if ( var_2 >= 2 )
        return 1;

    return 0;
}

friendly_can_teleport()
{
    if ( maps\_utility::player_can_see_ai( self ) )
        return 0;

    if ( distance( level.player.origin, self.origin ) < 96 )
        return 0;

    return 1;
}

breach_friendly_hint()
{
    if ( maps\_utility::is_coop() )
        thread breach_hint_create( &"SCRIPT_BREACH_NEED_PLAYER" );
    else
        thread breach_hint_create( &"SCRIPT_BREACH_NEED_FRIENDLY" );
}

breach_too_many_enemies_hint()
{
    thread breach_hint_create( &"SCRIPT_BREACH_TOO_MANY_ENEMIES" );
}

breach_reloading_hint()
{
    thread breach_hint_create( &"SCRIPT_BREACH_RELOADING" );
}

breach_bad_weapon_hint()
{
    thread breach_hint_create( &"SCRIPT_BREACH_ILLEGAL_WEAPON" );
}

breach_not_ready_hint()
{
    if ( maps\_utility::is_coop() )
    {
        thread breach_hint_create( &"SCRIPT_BREACH_PARTNER_NOT_READY" );
        return;
    }

    thread breach_hint_create( &"SCRIPT_BREACH_YOU_NOT_READY" );
}

breach_hint_create( var_0 )
{
    level notify( "breach_hint_cleanup" );
    level endon( "breach_hint_cleanup" );
    var_1 = 20;

    if ( _func_145() )
        var_1 = -23;

    thread maps\_utility::hint( var_0, 2, var_1 );
    thread breach_hint_cleanup();
}

breach_hint_cleanup()
{
    level notify( "breach_hint_cleanup" );
    level endon( "breach_hint_cleanup" );

    foreach ( var_1 in level.breach_use_triggers )
    {
        if ( isdefined( var_1 ) )
            var_1 sethintstring( "" );
    }

    level common_scripts\utility::waittill_notify_or_timeout( "breaching", 2 );
    maps\_utility::hint_fade();

    foreach ( var_1 in level.breach_use_triggers )
    {
        if ( isdefined( var_1 ) )
        {
            var_1 thread common_scripts\utility::_id_AE1E( level.player, &"SCRIPT_PLATFORM_BREACH_ACTIVATE", &"SCRIPT_PLATFORM_BREACH_ACTIVATE_KB", "trigger" );
            var_1 setcursorhint( "HINT_ACTIVATE" );
        }
    }
}

room_has_multiple_doors( var_0 )
{
    if ( isdefined( var_0.script_breachgroup ) )
        return 1;

    return 0;
}

breach_friendlies_take_grenades()
{
    if ( !isdefined( level.breachfriendlies ) )
        return;

    level.breachfriendlies_grenades_empty = 1;

    foreach ( var_1 in level.breachfriendlies )
    {
        var_1.grenadeammo_prebreach = var_1.grenadeammo;
        var_1.grenadeammo = 0;
    }
}

breach_friendlies_restore_grenades()
{
    if ( !isdefined( level.breachfriendlies ) )
        return;

    if ( !isdefined( level.breachfriendlies_grenades_empty ) )
        return;

    foreach ( var_1 in level.breachfriendlies )
    {
        var_1.grenadeammo = var_1.grenadeammo_prebreach;
        var_1.grenadeammo_prebreach = undefined;
    }

    level.breachfriendlies_grenades_empty = undefined;
}

breach_friendlies_ready_at_other_door( var_0, var_1 )
{
    var_2 = var_0.script_breachgroup;
    var_3 = get_door_volumes_from_breachgroup( var_0.script_breachgroup );
    var_3 = common_scripts\utility::array_remove( var_3, var_0 );
    var_4 = var_3[0];

    foreach ( var_6 in level.breachfriendlies )
    {
        if ( isdefined( var_1 ) && var_1 )
        {
            if ( var_6 goalpos_within_volume( var_4 ) )
            {
                if ( var_6 friendly_can_teleport() )
                    return 1;
            }
        }

        if ( var_6 istouching( var_4 ) )
            return 1;
    }

    return 0;
}

add_coop_scene_models()
{
    add_scene_model( "passive_breacher_rig" );
    add_scene_model( "active_breacher_3rd_person" );
    add_scene_model( "passive_breacher_3rd_person" );
}

add_scene_model( var_0 )
{
    self.scene_models[var_0] = maps\_utility::spawn_anim_model( var_0 );
    self.scene_models[var_0] hide();
}

set_room_to_breached( var_0, var_1 )
{
    var_1.breached = 1;
    var_2 = get_breach_notify( var_0.script_breachgroup );

    if ( isdefined( var_0.script_breachgroup ) )
        level notify( var_2 );

    var_1 notify( "breached" );
    var_0 common_scripts\utility::trigger_off();
}

breachless_door_opens( var_0 )
{
    var_1 = var_0.trigger;
    var_2 = var_0.room_volume;
    var_3 = var_0.path_solids;
    var_4 = self.door;
    var_5 = self.charge;
    set_room_to_breached( var_1, var_2 );
    common_scripts\utility::array_call( var_3, ::connectpaths );
    common_scripts\utility::array_thread( var_3, maps\_utility::self_delete );
    var_6 = spawnstruct();
    var_6.entity = var_4;
    var_6.forward = 4;
    var_6.right = 10;
    var_6.yaw = -170;
    var_6 maps\_utility::translate_local();
    var_5 delete();

    if ( !maps\_utility::is_coop() )
        return;

    while ( !var_2.breached )
        wait 0.05;

    var_7 = undefined;
    var_8 = undefined;

    if ( var_0.spawners["coopenemy"].size )
    {
        var_7 = var_0.spawners["coopenemy"];
        var_8 = var_0.spawners["coophostage"];
    }
    else
    {
        var_7 = var_0.spawners["enemy"];
        var_8 = var_0.spawners["hostage"];
    }

    if ( var_7.size )
        common_scripts\utility::array_call( var_7, ::stalingradspawn );

    if ( var_8.size )
        common_scripts\utility::array_call( var_8, ::stalingradspawn );
}

friendlies_breach( var_0, var_1 )
{
    var_2 = var_0.trigger;
    var_3 = var_0.door_volume;
    var_4 = var_0.room_volume;
    var_5 = var_0.spawners["enemy"];
    var_6 = var_0.spawners["hostage"];
    var_7 = var_0.spawners["friendlyenemy"];
    var_8 = var_0.spawners["friendlyhostage"];
    var_9 = var_0.path_solids;
    var_10 = self.charge;
    var_11 = self.scene_models["active_breacher_rig"];
    set_room_to_breached( var_2, var_4 );
    var_12 = var_0.friendly_anim_ent;
    var_13 = get_player_volume( var_3 );
    var_14 = getdvar( "breach_requires_friendlies_in_position" ) == "1";

    if ( !var_14 )
    {
        if ( isdefined( var_13 ) && breach_friendlies_ready_at_other_door( var_13 ) )
        {
            foreach ( var_16 in var_1 )
            {
                if ( !var_16 istouching( var_3 ) )
                    var_1 = common_scripts\utility::array_remove( var_1, var_16 );
            }

            var_14 = 1;
        }
    }

    if ( var_14 )
        var_18 = common_scripts\utility::getclosest( var_12.origin, var_1 );
    else
        var_18 = get_teleport_optimized_breachfriendly( var_12.origin, var_3, var_1, var_13 );

    var_1 = common_scripts\utility::array_remove( var_1, var_18 );

    if ( var_7.size )
        level.breachenemies = maps\_utility::array_spawn( var_7, 1 );

    if ( var_8.size )
        common_scripts\utility::array_call( var_8, ::stalingradspawn );

    common_scripts\utility::array_call( var_9, ::connectpaths );
    common_scripts\utility::array_thread( var_9, maps\_utility::self_delete );
    var_19 = "breach_player_anim";
    var_20 = 0;

    if ( getdvarint( "use_improved_breaches", 0 ) )
    {
        var_21 = getanimlength( var_11 maps\_utility::getanim( var_19 ) );
        var_22 = getnotetracktimes( var_11 maps\_utility::getanim( var_19 ), "explode" )[0];
        var_23 = var_21 * var_22;
        var_19 = level._id_C061;
        var_11.animname = "h2_active_breacher_rig";
        var_24 = getanimlength( var_11 maps\_utility::getanim( var_19 ) );
        var_22 = getnotetracktimes( var_11 maps\_utility::getanim( var_19 ), "explode" )[0];
        var_25 = var_24 * var_22;
        var_20 = var_25 - var_23;
    }

    var_18 thread friendly_breach( 1, var_12, var_4, var_20 );
    var_4.breaching_friendly1 = var_18;

    if ( var_1.size )
    {
        if ( var_14 )
            var_26 = common_scripts\utility::getclosest( var_12.origin, var_1 );
        else
            var_26 = get_teleport_optimized_breachfriendly( var_12.origin, var_3, var_1, var_13 );

        if ( isdefined( var_26 ) )
        {
            var_26 thread friendly_breach( 2, var_12, var_4, var_20 );
            var_4.breaching_friendly2 = var_26;
        }
        else
        {

        }
    }

    level notify( "slowmo_breach_friendlies_assigned" );
    wait 1;
    breach_friendlies_take_grenades();
    maps\_anim::anim_single_solo( var_11, var_19 );
}

get_player_volume( var_0 )
{
    var_1 = undefined;
    var_2 = get_grouped_doorvolumes( var_0 );

    foreach ( var_4 in var_2 )
    {
        if ( level.player istouching( var_4 ) )
        {
            var_1 = var_4;
            break;
        }
    }

    return var_1;
}

get_teleport_optimized_breachfriendly( var_0, var_1, var_2, var_3 )
{
    var_4 = [];

    foreach ( var_6 in var_2 )
    {
        if ( isdefined( var_3 ) )
        {
            if ( var_6 goalpos_within_volume( var_3 ) )
                continue;
        }

        if ( !var_6 friendly_can_teleport() )
            continue;

        var_4[var_4.size] = var_6;
    }

    if ( !var_4.size )
        return undefined;

    var_4 = common_scripts\utility::get_array_of_closest( var_0, var_4 );
    var_8 = var_4[0];

    foreach ( var_6 in var_4 )
    {
        if ( var_6 goalpos_within_volume( var_1 ) )
        {
            var_8 = var_6;
            break;
        }
    }

    return var_8;
}

goalpos_within_volume( var_0 )
{
    if ( isdefined( self.goalpos ) )
    {
        if ( origin_within_volume( self.goalpos + ( 0, 0, 40 ), var_0 ) )
            return 1;
    }

    return 0;
}

origin_within_volume( var_0, var_1 )
{
    var_2 = spawn( "script_origin", var_0 );
    var_3 = 0;

    if ( var_2 istouching( var_1 ) )
        var_3 = 1;

    var_2 delete();
    return var_3;
}

get_grouped_doorvolumes( var_0 )
{
    var_1 = [];
    var_1[0] = var_0;

    if ( isdefined( var_0.script_breachgroup ) )
    {
        foreach ( var_3 in level.breach_groups )
        {
            if ( !isdefined( var_3.door_volume ) )
                continue;

            if ( var_3.door_volume == var_0 )
                continue;

            if ( !isdefined( var_3.door_volume.script_breachgroup ) )
                continue;

            if ( isdefined( var_3.door_volume.script_breachgroup ) && var_3.door_volume.script_breachgroup == var_0.script_breachgroup )
                var_1[var_1.size] = var_3.door_volume;
        }
    }

    return var_1;
}

sort_breachers( var_0, var_1 )
{
    var_2 = var_1["active"];
    var_3 = anglestoright( self.angles );
    var_4 = vectornormalize( var_2.origin - var_0.trigger.origin );
    var_5 = vectordot( var_3, var_4 );

    if ( var_5 < 0 )
    {
        var_1["active"] = var_1["passive"];
        var_1["passive"] = var_2;
    }

    return var_1;
}

player_breach( var_0, var_1 )
{
    var_2 = [];
    var_2["active"] = var_1;
    var_3 = self.scene_models["active_breacher_rig"];
    var_4 = getdvarint( "use_improved_breaches", 0 );
    var_5 = undefined;
    var_6 = level._id_D03D;
    var_7 = "breach_player_anim";

    if ( var_4 )
    {
        var_3 delete();
        var_0._id_567E add_scene_model( "h2_active_breacher_rig" );
        var_3 = self.scene_models["h2_active_breacher_rig"];
        self.scene_models["active_breacher_rig"] = undefined;
        var_8 = getstartorigin( self.origin, self.angles, level.scr_anim["ally"][level._id_C07B[0]] );
        var_9 = getstartangles( self.origin, self.angles, level.scr_anim["ally"][level._id_C07B[0]] );
        var_10 = getaiarray( "allies" );
        var_11 = getdvar( "force_breach_anim", "" );
        var_12 = common_scripts\utility::ter_op( var_11 == "", var_0.animname, var_11 );

        if ( isdefined( level._id_A94B[var_12] ) )
            var_12 = "";

        foreach ( var_14 in var_10 )
        {
            if ( isdefined( var_14._id_BAEC ) && var_14._id_BAEC )
                continue;

            if ( !isdefined( level._id_C558[var_12] ) )
            {
                if ( distance2d( var_8, var_14.origin ) < 10 && vectordot( anglestoforward( var_9 ), anglestoforward( var_14.angles ) ) > 0.95 )
                {
                    var_5 = var_14;
                    var_6 = level._id_C07B;
                    break;
                }
            }
            else if ( isdefined( var_14.script_friendname ) && level._id_C558[var_12] == var_14.script_friendname )
            {
                var_5 = var_14;
                break;
            }
        }

        if ( !isdefined( level.scr_anim["h2_active_breacher_rig"][var_12] ) || !isdefined( var_5 ) && isdefined( level._id_C56F[var_12] ) )
            var_7 = common_scripts\utility::random( var_6 );
        else
            var_7 = var_12;

        maps\_anim::anim_first_frame_solo( var_3, var_7 );
        level._id_C061 = var_7;
    }

    var_16 = 0;
    var_17 = undefined;

    if ( maps\_utility::is_coop() )
    {
        var_2["passive"] = maps\_utility::get_other_player( var_2["active"] );
        var_17 = self.scene_models["passive_breacher_rig"];
        var_18 = breach_near_player( var_2["passive"] );

        if ( var_18 == var_0 )
        {
            var_16 = 1;
            var_18.room_volume.has_passive_breacher = 1;
            var_2 = sort_breachers( var_0, var_2 );
        }
        else
        {
            level.breach_passive_player = var_2["passive"];
            level.breach_passive_time = gettime();
            var_18.trigger notify( "trigger", var_2["passive"], "passive" );
        }
    }

    var_19 = common_scripts\utility::ter_op( var_4, int( getanimlength( level.scr_anim[var_3.animname][var_7] ) * 1000 ), 0 );
    var_2["active"] forceviewmodelanimation( var_19 );

    if ( var_16 )
        var_2["passive"] disableweapons();

    foreach ( var_1 in var_2 )
    {
        if ( !isdefined( level.slowmo_breach_disable_stancemod ) )
        {
            var_1 enableinvulnerability();
            var_1 disableweaponswitch();
            var_1 disableoffhandweapons();
            var_1 allowcrouch( 0 );
            var_1 allowprone( 0 );
            var_1 _meth_830F( 0 );
            var_1 allowjump( 0 );
        }

        var_1 common_scripts\utility::_disableusability();

        if ( !isdefined( var_1.prebreachcurrentweapon ) )
            var_1.prebreachcurrentweapon = var_1 getcurrentweapon();
    }

    level notify( "breaching" );
    level notify( "breaching_number_" + self.script_slowmo_breach );
    setsaveddvar( "objectiveHide", 1 );
    var_22 = var_0.room_volume;
    set_room_to_breached( var_0.trigger, var_22 );
    var_23 = undefined;
    var_24 = isdefined( level.has_special_breach_anim[var_2["active"].prebreachcurrentweapon] );

    if ( var_4 )
    {
        var_25 = getanimlength( level.scr_anim["h2_active_breacher_rig"][var_7] );
        var_26 = getnotetracktimes( level.scr_anim["h2_active_breacher_rig"][var_7], "place" );
        var_27 = getnotetracktimes( level.scr_anim["h2_active_breacher_rig"][var_7], "explode" );
        level.slowmo_breach_start_delay = var_27[0] * var_25;
        _id_CFAB();

        if ( !isdefined( level._id_C536 ) )
            level._id_C536 = 0;

        var_23 = var_26[0] * var_25 - 0.16 + level._id_C536;
    }
    else if ( var_24 )
    {
        level.slowmo_breach_start_delay = 2.25;
        set_door_charge_anim_special();
        var_23 = 0.5;
    }
    else
    {
        level.slowmo_breach_start_delay = 2.15;
        set_door_charge_anim_normal();
        var_23 = 0.2;
    }

    var_2["active"] thread play_detpack_plant_sound( var_23 );

    if ( maps\_utility::is_coop() )
    {
        if ( !isdefined( level.player_one_already_breached ) )
        {
            level.breachenemies_alive = 0;
            level.breachenemies_active = 0;
            level.player_one_already_breached = 1;
        }
    }
    else
    {
        level.breachenemies_alive = 0;
        level.breachenemies_active = 0;
    }

    var_28 = var_0.spawners["enemy"];
    common_scripts\utility::array_call( var_28, ::stalingradspawn );
    var_29 = var_0.spawners["hostage"];
    common_scripts\utility::array_call( var_29, ::stalingradspawn );
    var_2["active"] playerlinktoblend( var_3, "tag_player", 0.2, 0.1, 0.1 );

    if ( !var_4 && isdefined( var_2["active"].dont_unlink_after_breach ) )
        thread maps\_utility::open_up_fov( 0.2, var_3, "tag_player", 45, 45, 90, 45 );
    else
        thread _id_C269( var_3 );

    if ( var_16 )
    {
        var_2["passive"] playerlinktoblend( var_17, "tag_player", 0.2, 0.1, 0.1 );

        if ( !var_4 && isdefined( var_2["passive"].dont_unlink_after_breach ) )
            thread maps\_utility::open_up_fov( 0.2, var_17, "tag_player", 45, 45, 90, 45 );
    }

    var_2["active"] thread take_prebreach_weapons( var_4 );

    if ( !var_24 )
        wait 0.05;

    var_30 = self.charge;

    if ( var_4 )
    {
        var_30 delete();
        level.scr_model["breach_door_charge"] = level._id_C136[var_7];
        var_30 = maps\_utility::spawn_anim_model( "breach_door_charge" );
        self.charge = var_30;
        self._id_AB70 = [];

        foreach ( var_32 in var_0._id_AB70 )
        {
            var_33 = maps\_utility::spawn_anim_model( "breach_door_charge" );
            self._id_AB70[self._id_AB70.size] = var_33;
            thread maps\_anim::anim_single_solo( var_33, var_32 );
            var_33 show();
        }
    }

    var_35 = common_scripts\utility::ter_op( var_4, var_7, "breach" );
    thread maps\_anim::anim_single_solo( var_30, var_35 );

    if ( var_35 == "breach_price" || var_35 == "breach_price2" || var_35 == "breach_inspect" )
        var_30 show();
    else
    {
        var_30 hide();
        var_30 common_scripts\utility::delaycall( 0.2, ::show );
    }

    var_2["active"] thread restore_prebreach_weapons();
    var_36 = 0;

    if ( var_16 )
    {
        thread maps\_anim::anim_single_solo( var_17, "breach_player_anim" );
        var_2["passive"].animname = "passive_breacher_3rd_person";
        var_2["passive"] thread maps\_anim::anim_single_solo( var_2["passive"], "breach_player_anim" );
        var_2["passive"] thread enable_passive_weapons();
        var_2["passive"] thread restore_prebreach_weapons();
        var_2["active"].animname = "active_breacher_3rd_person";
        var_2["active"] thread maps\_anim::anim_single_solo( var_2["active"], "breach_player_anim" );
    }

    var_37 = "";

    if ( var_4 )
    {
        maps\_utility::delaythread( 0.2, ::_id_CADA, var_3 );

        if ( isdefined( var_5 ) && isdefined( level.scr_anim["ally"][var_7] ) )
        {
            var_5 notify( "start_breach" );
            var_37 = var_5.animname;
            var_5.animname = "ally";
            thread maps\_anim::anim_single_solo( var_5, var_7 );
        }
    }

    maps\_anim::anim_single_solo( var_3, var_7 );

    if ( isdefined( var_5 ) )
        var_5.animname = var_37;

    level notify( "sp_slowmo_breachanim_done" );
    thread flag_set_when_room_cleared( var_22 );
    var_38 = var_0.path_solids;
    common_scripts\utility::array_call( var_38, ::connectpaths );
    common_scripts\utility::array_thread( var_38, maps\_utility::self_delete );

    foreach ( var_1 in var_2 )
    {
        if ( isdefined( var_1.dont_unlink_after_breach ) )
        {
            var_36 = 1;
            special_gulag_adjustment( var_3 );
        }
        else
            var_1 unlink();

        var_1 show();
        var_3 hide();
    }

    if ( var_36 )
        level waittill( "breach_concludes" );

    var_2["active"] _meth_80F9();

    foreach ( var_1 in var_2 )
    {
        if ( !isdefined( level.slowmo_breach_disable_stancemod ) )
        {
            var_1 disableinvulnerability();
            var_1 enableweaponswitch();
            var_1 enableoffhandweapons();
            var_1 allowcrouch( 1 );
            var_1 allowprone( 1 );
            var_1 _meth_830F( 1 );
            var_1 allowjump( 1 );
        }

        var_1 common_scripts\utility::_enableusability();
    }

    return 1;
}

_id_BC08( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    wait( var_0 );
    level.player lerpviewangleclamp( var_1, var_2, var_3, var_4, var_5, var_6, var_7 );
    level.player setviewangleresistance( 50, 50, 20, 20 );
    wait( var_1 );
}

_id_C269( var_0 )
{
    if ( isdefined( level._id_C061 ) )
    {
        var_1 = 90;
        var_2 = 90;
        var_3 = 90;
        var_4 = 45;
        var_5 = level._id_C061;
        thread maps\_utility::open_up_fov( 0.2, var_0, "tag_player", 0, 0, 0, 0 );

        switch ( var_5 )
        {
            case "breach_inspect":
                thread _id_BC08( 1.35, 0.85, 0.25, 0.25, 10, 0, 5, 5 );
                thread _id_BC08( 2.2, 1.0, 0.25, 0.25, 15, 0, 20, 20 );
                thread _id_BC08( 3.2, 0.85, 0.25, 0.25, var_1, var_2, var_3, var_4 );
                break;
            case "breach_price":
                thread _id_BC08( 1.15, 1.0, 0.25, 0.25, 10, 0, 5, 5 );
                thread _id_BC08( 2.5, 1.0, 0.25, 0.25, 15, 0, 20, 20 );
                thread _id_BC08( 4.5, 1.5, 0.25, 0.25, 45, 45, var_3, var_4 );
                break;
            default:
                common_scripts\utility::flag_wait( "breach_plant" );
                _id_BC08( 0.35, 0.4, 0.15, 0.15, 10, 0, 5, 5 );
                common_scripts\utility::flag_clear( "breach_plant" );
                common_scripts\utility::flag_wait( "breach_settle" );
                _id_BC08( 0.0, 0.4, 0.15, 0.15, 15, 0, 20, 20 );
                common_scripts\utility::flag_clear( "breach_settle" );
                common_scripts\utility::flag_wait( "breach_slowmo" );
                _id_BC08( 0.35, 0.4, 0.15, 0.15, var_1, var_2, var_3, var_4 );
                common_scripts\utility::flag_clear( "breach_slowmo" );
                break;
        }
    }
    else
    {

    }
}

play_detpack_plant_sound( var_0 )
{
    self endon( "death" );
    wait( var_0 );
    level notify( "plant_go" );
    common_scripts\utility::flag_set( "breach_plant" );
}

flag_set_when_room_cleared( var_0 )
{
    var_1 = var_0.script_flag;
    level endon( var_1 );
    var_2 = var_0 maps\_utility::get_ai_touching_volume( "bad_guys" );
    maps\_utility::waittill_dead( var_2 );
    level notify( "breach_room_has_been_cleared" );
    level.breachenemies = undefined;
    common_scripts\utility::flag_set( var_1 );
}

take_prebreach_weapons( var_0 )
{
    self giveweapon( "usp_scripted" );
    self switchtoweaponimmediate( "usp_scripted" );

    if ( isdefined( level.has_special_breach_anim[self.prebreachcurrentweapon] ) || var_0 )
        self switchtoweaponimmediate( self.prebreachcurrentweapon );
}

restore_prebreach_weapons()
{
    wait 0.5;
    self takeweapon( "usp_scripted" );

    if ( isdefined( self.prebreachcurrentweapon ) )
    {
        var_0 = self.prebreachcurrentweapon;
        self switchtoweapon( var_0 );

        if ( should_topoff_breach_weapon( var_0 ) )
        {
            var_1 = weaponclipsize( var_0 );

            if ( self getweaponammoclip( var_0 ) < var_1 )
                self setweaponammoclip( var_0, var_1 );
        }

        self.prebreachcurrentweapon = undefined;
    }
}

_id_CADA( var_0 )
{
    setsaveddvar( "cg_drawGun", 0 );
    var_0 show();
}

_id_C81E( var_0 )
{
    setsaveddvar( "cg_drawGun", 1 );
    common_scripts\utility::flag_set( "breach_settle" );
    var_0 hide();
}

enable_passive_weapons()
{
    wait 2.2;
    self enableweapons();
}

should_topoff_breach_weapon( var_0 )
{
    if ( level.gameskill > 1 )
        return 0;

    if ( isdefined( level.breach_no_auto_reload ) )
        return !level.breach_no_auto_reload;

    if ( !isdefined( self.prebreachcurrentweapon ) )
        return 0;

    if ( var_0 != self.prebreachcurrentweapon )
        return 0;

    return 1;
}

friendly_breach( var_0, var_1, var_2, var_3 )
{
    var_4 = var_2.script_flag;

    if ( var_0 == 2 )
    {
        var_5 = "breach_friend_idle_02";
        var_6 = "breach_friend_enter_02";
    }
    else
    {
        var_5 = "breach_friend_idle_01";
        var_6 = "breach_friend_enter_01";
    }

    self.breaching = 1;
    var_7 = 1;

    if ( !isdefined( self.magic_bullet_shield ) )
    {
        var_7 = 0;
        thread maps\_utility::magic_bullet_shield();
    }

    wait 0.5;
    self forceteleport( var_1.origin, var_1.angles );
    maps\_utility::anim_stopanimscripted();
    var_1 thread maps\_anim::anim_generic_loop( self, var_5, "stop_idle" );
    self setgoalpos( self.origin );
    wait( 3 + var_3 );
    thread friendlies_shoot_while_breaching( var_0 );
    var_1 notify( "stop_idle" );
    var_1 maps\_anim::anim_generic( self, var_6 );
    self setgoalpos( self.origin );
    level notify( "friendlies_finished_breach" );

    if ( isdefined( self.friendly_breach_finished_flag ) )
        common_scripts\utility::flag_set( self.friendly_breach_finished_flag );

    common_scripts\utility::flag_wait( var_4 );

    if ( !var_7 )
        maps\_utility::stop_magic_bullet_shield();

    self.breaching = undefined;
}

friendlies_shoot_while_breaching( var_0 )
{
    if ( var_0 == 1 )
        wait 1;
    else
        wait 2;

    level endon( "friendlies_finished_breach" );
    level endon( "breach_room_has_been_cleared" );

    while ( !isdefined( level.breachenemies ) )
        wait 0.05;

    while ( isdefined( level.breachenemies ) && level.breachenemies.size )
    {
        wait 0.05;

        if ( !isdefined( level.breachenemies ) )
            break;

        level.breachenemies = maps\_utility::remove_dead_from_array( level.breachenemies );

        foreach ( var_2 in level.breachenemies )
        {
            if ( !isalive( var_2 ) || !isdefined( var_2 ) )
                continue;

            var_3 = var_2 gettagorigin( "tag_eye" );
            var_4 = self getmuzzlepos();
            var_5 = self getshootatpos() - var_4;

            if ( self canshoot( var_3, var_5 ) )
            {
                magicbullet( self.weapon, self getmuzzlepos(), var_3 );
                bullettracer( self getmuzzlepos(), var_3, 1 );
                wait 0.5;
            }
        }
    }
}

get_available_breachfriendlies( var_0 )
{
    var_1 = [];

    if ( !isdefined( level.breachfriendlies ) )
        return var_1;

    var_1 = maps\_utility::array_removedead( level.breachfriendlies );
    var_2 = getdvar( "breach_requires_friendlies_in_position" ) == "1";

    foreach ( var_4 in var_1 )
    {
        if ( isdefined( var_4.breaching ) && var_4.breaching == 1 )
        {
            var_1 = common_scripts\utility::array_remove( var_1, var_4 );
            continue;
        }

        if ( var_2 && !var_4 istouching( var_0 ) )
        {
            var_1 = common_scripts\utility::array_remove( var_1, var_4 );
            continue;
        }
    }

    return var_1;
}

get_breach_notify( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "none";

    return "A door in breach group " + var_0 + " has been activated.";
}

breach_group_trigger_think()
{
    var_0 = self.script_breachgroup;
    var_1 = get_breach_notify( var_0 );
    level waittill( var_1 );
    waittillframeend;
    self notify( "trigger" );
}

slowmo_player_cleanup()
{
    if ( isdefined( level.playerspeed ) )
        self setmovespeedscale( level.playerspeed );
    else
        self setmovespeedscale( 1 );
}

slowmo_begins( var_0 )
{
    if ( isdefined( level.breaching ) && level.breaching == 1 )
        return;

    level.breaching = 1;
    common_scripts\utility::flag_set( "breaching_on" );
    level notify( "slowmo_go" );
    level endon( "slowmo_go" );
    var_1 = 0.5;
    var_2 = 0.75;
    var_3 = 0.2;

    if ( isdefined( level.slomobreachplayerspeed ) )
        var_3 = level.slomobreachplayerspeed;

    var_4 = level.player;
    var_5 = undefined;

    if ( maps\_utility::is_coop() )
        var_5 = maps\_utility::get_other_player( var_4 );

    var_4 thread maps\_utility::play_sound_on_entity( "slomo_whoosh_in" );
    var_4 thread player_heartbeat();
    thread _id_B49D();
    thread _id_A808();
    common_scripts\utility::flag_set( "breach_slowmo" );
    var_6 = var_1 * 2;
    var_7 = var_2 / 2;
    thread slomo_breach_vision_change( var_6, var_7 );
    thread slomo_difficulty_dvars();
    common_scripts\utility::flag_clear( "can_save" );
    maps\_utility::slowmo_start();
    var_4 thread set_breaching_variable();

    if ( isdefined( var_5 ) )
        var_5 thread set_breaching_variable();

    var_4 allowmelee( 0 );

    if ( isdefined( var_5 ) )
        var_5 allowmelee( 0 );

    maps\_utility::slowmo_setspeed_slow( 0.25 );
    maps\_utility::slowmo_setlerptime_in( var_1 );
    maps\_utility::slowmo_lerp_in();
    var_4 setmovespeedscale( var_3 );

    if ( isdefined( var_5 ) )
        var_5 setmovespeedscale( var_3 );

    var_8 = gettime();
    var_9 = var_8 + level.slomobreachduration * 1000;

    if ( !maps\_utility::is_coop() )
        var_4 thread catch_weapon_switch();

    var_4 thread catch_mission_failed();

    if ( isdefined( var_5 ) )
        var_5 thread catch_mission_failed();

    var_10 = 500;
    var_11 = 1000;

    for (;;)
    {
        if ( isdefined( level.forced_slowmo_breach_slowdown ) )
        {
            if ( !level.forced_slowmo_breach_slowdown )
            {
                if ( isdefined( level.forced_slowmo_breach_lerpout ) )
                    var_2 = level.forced_slowmo_breach_lerpout;

                break;
            }

            wait 0.05;
            continue;
        }

        if ( gettime() >= var_9 )
            break;

        if ( level.breachenemies_active <= 0 && level.breachignoreenemy_count == 0 )
        {
            var_2 = 1.15;
            break;
        }

        if ( !maps\_utility::is_coop() )
        {
            if ( var_4.lastreloadstarttime >= var_8 + var_10 )
                break;

            if ( var_4.switchedweapons && gettime() - var_8 > var_11 )
                break;
        }

        if ( maps\_utility::is_specialop() && common_scripts\utility::flag( "special_op_terminated" ) )
            break;

        if ( var_4.breach_missionfailed || maps\_utility::is_coop() && var_5.breach_missionfailed )
        {
            var_2 = 0.5;
            break;
        }

        wait 0.05;
    }

    level notify( "slowmo_breach_ending", var_2 );
    level notify( "stop_player_heartbeat" );
    var_4 thread maps\_utility::play_sound_on_entity( "slomo_whoosh_out" );
    maps\_utility::slowmo_setlerptime_out( var_2 );
    maps\_utility::slowmo_lerp_out();

    if ( !isdefined( level._id_C58A ) || !level._id_C58A )
    {
        var_4 allowmelee( 1 );

        if ( isdefined( var_5 ) )
            var_5 allowmelee( 1 );
    }

    var_4 maps\_utility::delaythread( var_2, ::clear_breaching_variable );

    if ( isdefined( var_5 ) )
        var_5 maps\_utility::delaythread( var_2, ::clear_breaching_variable );

    maps\_utility::slowmo_end();
    common_scripts\utility::flag_set( "can_save" );
    level.player_one_already_breached = undefined;
    var_4 slowmo_player_cleanup();

    if ( isdefined( var_5 ) )
        var_5 slowmo_player_cleanup();

    level notify( "slomo_breach_over" );
    level.breaching = 0;
    common_scripts\utility::flag_clear( "breaching_on" );
    setsaveddvar( "objectiveHide", 0 );

    foreach ( var_13 in getaispeciesarray( "all", "all" ) )
    {
        if ( isdefined( var_13._id_A87F.remove_shields_when_breach_end ) && var_13._id_A87F.remove_shields_when_breach_end )
            _id_B190::_id_D55F( var_13 );
    }
}

_id_B49D()
{
    var_0 = 0.1;
    var_1 = 0.25;
    var_2 = maps\_hud_util::create_client_overlay( "h2_overlays_vignette", 0 );
    var_2.sort = 20;
    var_2.foreground = 0;
    var_2 fadeovertime( var_0 );
    var_2.alpha = 1;
    wait( var_0 );
    level waittill( "slowmo_breach_ending" );
    var_2 fadeovertime( var_1 );
    var_2.alpha = 0;
    wait( var_1 );
    var_2 destroy();
}

_id_A808()
{
    var_0 = 0.1;
    var_1 = 0.5;
    var_2 = 0.25;
    var_3 = maps\_hud_util::create_client_overlay( "h2_overlays_breachdust", 0 );
    var_3.sort = 19;
    var_3.foreground = 0;
    var_3 fadeovertime( var_0 );
    var_3.alpha = 0.9;
    wait( var_0 );
    var_3 fadeovertime( var_1 );
    var_3.alpha = 0.8;
    wait( var_1 );
    level waittill( "slowmo_breach_ending" );
    var_3 fadeovertime( var_2 );
    var_3.alpha = 0;
    wait( var_2 );
    var_3 destroy();
}

set_breaching_variable()
{
    self endon( "clear_breaching_variable" );
    self.isbreaching = 1;
    self.breaching_shots_fired = 0;
    self.achieve_slowmo_breach_kills = undefined;
    var_0 = self getcurrentweaponclipammo();
    self notifyonplayercommand( "player_shot_fired", "+attack" );
    self notifyonplayercommand( "player_shot_fired", "+attack_akimbo_accessible" );

    while ( isdefined( self.isbreaching ) )
    {
        self waittill( "player_shot_fired" );
        self.breaching_shots_fired = var_0 - self getcurrentweaponclipammo();
        wait 0.05;

        while ( self isfiring() )
        {
            self.breaching_shots_fired = var_0 - self getcurrentweaponclipammo();
            wait 0.05;
        }
    }
}

clear_breaching_variable()
{
    self.isbreaching = undefined;
    thread maps\_utility::notify_delay( "clear_breaching_variable", 0.25 );
}

slomo_difficulty_dvars()
{
    var_0 = getdvar( "bg_viewKickScale" );
    var_1 = getdvar( "bg_viewKickMax" );
    setsaveddvar( "bg_viewKickScale", 0.3 );
    setsaveddvar( "bg_viewKickMax", "15" );
    setsaveddvar( "bullet_penetration_damage", 0 );
    level waittill( "slowmo_breach_ending" );
    setsaveddvar( "bg_viewKickScale", var_0 );
    setsaveddvar( "bg_viewKickMax", var_1 );
    wait 2;
    setsaveddvar( "bullet_penetration_damage", 1 );
}

slomo_breach_vision_change( var_0, var_1 )
{
    if ( !isdefined( level.slomobasevision ) || level.vision_cheat_enabled )
        return;

    visionsetnaked( "slomo_breach", var_0 );
    level waittill( "slowmo_breach_ending", var_2 );

    if ( isdefined( var_2 ) )
        var_1 = var_2;

    wait 1;

    if ( !level.vision_cheat_enabled )
        visionsetnaked( level.slomobasevision, var_1 );
}

player_heartbeat()
{
    level endon( "stop_player_heartbeat" );

    for (;;)
    {
        self playlocalsound( "breathing_heartbeat" );
        wait 0.5;
    }
}

catch_weapon_switch()
{
    level endon( "slowmo_breach_ending" );
    self.switchedweapons = 0;
    common_scripts\utility::waittill_any( "weapon_switch_started", "night_vision_on", "night_vision_off" );
    self.switchedweapons = 1;
}

catch_mission_failed()
{
    level endon( "slowmo_breach_ending" );
    self.breach_missionfailed = 0;
    level waittill( "mission failed" );
    self.breach_missionfailed = 1;
}

breach_enemy_spawner_think()
{
    var_0 = self.spawner;
    self endon( "death" );
    maps\_utility::add_damage_function( ::record_last_player_damage );
    thread breach_enemy_ignored_by_friendlies();
    thread breach_enemy_ragdoll_on_death();
    level thread breach_enemy_track_status( self );

    if ( isdefined( self.script_parameters ) && common_scripts\utility::string_starts_with( self.script_parameters, "reference" ) )
        var_0 = getent( self.script_parameters, "targetname" );

    self.reference = var_0;
    var_0 maps\_anim::anim_generic_first_frame( self, self.animation );

    if ( isdefined( level._slowmo_functions[self.animation] ) )
    {
        var_1 = level._slowmo_functions[self.animation];
        self thread [[ var_1 ]]();
    }

    self.grenadeammo = 0;
    self.allowdeath = 1;
    self.health = 10;
    self.baseaccuracy = 5000;
    self._id_A87F.remove_shields_when_breach_end = 1;

    if ( isdefined( self.animation ) )
        self.cheat._id_BDF2 = 1;

    if ( isdefined( self.script_threatbias ) )
        self.threatbias = self.script_threatbias;

    if ( isdefined( level.breach_death_anims[self.animation] ) )
        self.skipdeathanim = 1;

    wait( level.slowmo_breach_start_delay );
    maps\_utility::script_delay();
    self notify( "starting_breach_reaction" );
    var_0 maps\_anim::anim_generic( self, self.animation );
    self notify( "finished_breach_start_anim" );
}

record_last_player_damage( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( !isalive( var_1 ) )
        return;

    if ( !isplayer( var_1 ) )
        return;

    if ( !self isbadguy() )
        return;

    level.last_player_damage = gettime();
}

breach_enemy_ignored_by_friendlies()
{
    self endon( "death" );

    if ( !common_scripts\utility::flag( "no_mercy" ) )
        self.ignoreme = 1;

    level common_scripts\utility::waittill_either( "slomo_breach_over", "friendlies_finished_breach" );

    if ( isdefined( self ) )
        self.ignoreme = 0;
}

breach_enemy_ragdoll_on_death()
{
    self endon( "breach_enemy_cancel_ragdoll_death" );
    self.ragdoll_immediate = 1;
    var_0 = common_scripts\utility::waittill_any_return( "death", "finished_breach_start_anim" );

    if ( var_0 == "finished_breach_start_anim" )
        self.ragdoll_immediate = undefined;
}

breach_enemy_cancel_ragdoll()
{
    self notify( "breach_enemy_cancel_ragdoll_death" );
    self.ragdoll_immediate = undefined;
}

breach_enemy_track_status( var_0 )
{
    level.breachenemies_active++;
    var_1 = spawnstruct();
    var_1.enemy = var_0;
    var_1 thread breach_enemy_waitfor_death( var_0 );
    var_1 thread breach_enemy_waitfor_death_counter( var_0 );
    var_1 thread breach_enemy_catch_exceptions( var_0 );
    var_1 thread breach_enemy_waitfor_breach_ending();
    var_1 waittill( "breach_status_change", var_2 );
    level.breachenemies_active--;
    var_1 = undefined;
}

breach_enemy_waitfor_death( var_0 )
{
    self endon( "breach_status_change" );
    var_0 waittill( "death" );
    self notify( "breach_status_change", "death" );
}

breach_enemy_waitfor_death_counter( var_0 )
{
    level.breachenemies_alive++;
    var_0 waittill( "death" );
    level.breachenemies_alive--;

    if ( level.breachenemies_alive <= 0 )
        breach_friendlies_restore_grenades();

    level notify( "breach_all_enemies_dead" );
}

breach_enemy_catch_exceptions( var_0 )
{
    self endon( "breach_status_change" );

    while ( isalive( var_0 ) )
        wait 0.05;

    self notify( "breach_status_change", "exception" );
}

breach_enemy_waitfor_breach_ending()
{
    self endon( "breach_status_change" );
    level waittill( "slowmo_breach_ending" );
    self notify( "breach_status_change", "breach_ending" );
}

breach_hostage_spawner_think()
{
    self endon( "death" );
    self.breachfinished = 0;
    var_0 = self.spawner;
    self.reference = var_0;
    self endon( "cancel_breach_behavior" );
    thread hostage_mission_fail();
    maps\_anim::anim_generic_first_frame( self, self.animation );
    self.health = 10;
    self.no_friendly_fire_penalty = 1;
    self.ignorerandombulletdamage = 1;
    wait( level.slowmo_breach_start_delay );

    if ( isdefined( level._slowmo_functions[self.animation] ) )
    {
        var_1 = level._slowmo_functions[self.animation];
        self thread [[ var_1 ]]();
    }

    self.allowdeath = 1;
    var_0 maps\_anim::anim_generic( self, self.animation );
    self notify( "finished_breach_start_anim" );

    if ( isdefined( self.skipendingidle ) )
        return;

    if ( anim_exists( self.animation + "_idle" ) )
        thread maps\_anim::anim_generic_loop( self, self.animation + "_idle", "stop_idle" );
    else
    {
        var_2 = "hostage_knees_loop";
        thread maps\_anim::anim_generic_loop( self, var_2, "stop_idle" );
    }

    self.breachfinished = 1;
}

hostage_health_regen()
{
    var_0 = self.health;
    self endon( "death" );
    self endon( "saved" );

    while ( isdefined( self ) )
    {
        self waittill( "damage", var_1, var_2 );

        if ( isdefined( var_2 ) )
        {
            if ( isplayer( var_2 ) )
            {
                self kill( self.origin, level.player );
                break;
            }
            else if ( isdefined( var_2.team ) && var_2.team == "allies" )
                self.health = var_0;
        }
    }
}

get_room_volume_from_slomo_breach_number( var_0 )
{
    return level.breach_groups[var_0].room_volume;
}

hostage_mission_fail()
{
    if ( maps\_utility::is_specialop() )
        level endon( "special_op_terminated" );

    level endon( "mission failed" );
    var_0 = self.health;
    var_1 = 0;
    thread hostage_health_regen();
    var_2 = get_room_volume_from_slomo_breach_number( self.script_slowmo_breach );

    if ( getdvar( "hostage_missionfail" ) == "0" )
        return;

    while ( isdefined( self ) )
    {
        self waittill( "death", var_3 );

        if ( isdefined( var_3 ) )
        {
            if ( isplayer( var_3 ) )
            {
                level notify( "player_shot_a_hostage" );
                waittillframeend;

                if ( level.last_player_damage == gettime() )
                    maps\_player_death::set_deadquote( &"SCRIPT_MISSIONFAIL_KILLEDHOSTAGE" );
                else
                    maps\_player_death::set_deadquote( &"SCRIPT_MISSIONFAIL_KILLEDHOSTAGE" );

                var_1 = 1;
            }
            else if ( isdefined( var_3.team ) && var_3.team == "allies" && !isplayer( var_3 ) )
            {
                maps\_player_death::set_deadquote( &"SCRIPT_MISSIONFAIL_HOSTAGEEXECUTED" );
                var_1 = 1;
            }
            else
            {
                if ( coop_breached_from_same_door_in_a_muliti_door_room( var_2 ) )
                    maps\_player_death::set_deadquote( &"SCRIPT_MISSIONFAIL_HOSTAGEEXECUTED_USEMULTIDOOR" );
                else
                    maps\_player_death::set_deadquote( &"SCRIPT_MISSIONFAIL_HOSTAGEEXECUTED" );

                var_1 = 1;
            }
        }

        if ( var_1 == 1 )
        {
            thread maps\_utility::missionfailedwrapper();
            level notify( "mission failed" );
        }
    }
}

coop_breached_from_same_door_in_a_muliti_door_room( var_0 )
{
    if ( !maps\_utility::is_specialop() )
        return 0;

    if ( !maps\_utility::is_coop() )
        return 0;

    if ( isdefined( var_0.has_passive_breacher ) )
        return 1;
    else
        return 0;
}

#using_animtree("script_model");

script_models()
{
    level.scr_anim["breach_door_model"]["breach"] = %breach_player_door_v2;
    level.scr_animtree["breach_door_model"] = #animtree;
    level.scr_model["breach_door_model"] = "com_door_01_handleright";
    level.scr_anim["breach_door_hinge"]["breach"] = %breach_player_door_hinge_v1;
    level.scr_animtree["breach_door_hinge"] = #animtree;
    level.scr_model["breach_door_hinge"] = "com_door_piece_hinge";
    level.scr_anim["breach_door_model_metal"]["breach"] = %breach_player_door_v2;
    level.scr_animtree["breach_door_model_metal"] = #animtree;
    level.scr_model["breach_door_model_metal"] = "breach_door_metal_right";
    level.scr_anim["breach_door_hinge_metal"]["breach"] = %breach_player_door_metal;
    level.scr_animtree["breach_door_hinge_metal"] = #animtree;
    level.scr_model["breach_door_hinge_metal"] = "breach_door_metal_right_dst";

    if ( level.script == "oilrig" )
    {
        level.scr_anim["breach_door_model_oilrig"]["breach"] = %breach_player_door_v2;
        level.scr_animtree["breach_door_model_oilrig"] = #animtree;
        level.scr_model["breach_door_model_oilrig"] = "h2_oilr_door_breaching_undamaged";
        level.scr_anim["breach_door_hinge_oilrig"]["breach"] = %h2_oilr_door_breaching_open_anim;
        level.scr_animtree["breach_door_hinge_oilrig"] = #animtree;
        level.scr_model["breach_door_hinge_oilrig"] = "h2_oilr_door_breaching_damaged";
    }

    level.scr_anim["breach_door_charge"]["breach"] = %breach_player_frame_charge_v3;
    level.scr_animtree["breach_door_charge"] = #animtree;
    level.scr_model["breach_door_charge"] = "mil_frame_charge";

    if ( isdefined( level._id_CA75 ) )
        precachemodel( level._id_CA75 );
    else
        level._id_CA75 = "mil_frame_charge";

    level.scr_animtree["desk"] = #animtree;
    level.scr_anim["desk"]["breach_react_desk_v7_desk"] = %breach_react_desk_v7_desk;
    level.scr_animtree["chair"] = #animtree;
    level.scr_anim["chair"]["breach_chair_hide_reaction_v2_chair"] = %breach_chair_hide_reaction_v2_chair;
    level.scr_anim["chair"]["breach_chair_hide_reaction_death_v2_chair"] = %breach_chair_hide_reaction_death_v2_chair;
}

set_door_charge_anim_normal()
{
    level.scr_anim["breach_door_charge"]["breach"] = %breach_player_frame_charge_v3;
}

set_door_charge_anim_special()
{
    level.scr_anim["breach_door_charge"]["breach"] = %breach_player_frame_charge;
}

_id_CFAB()
{
    level.scr_anim["breach_door_charge"]["breach_normal"] = %h2_breach_normal_charge;
    level.scr_anim["breach_door_charge"]["breach_normal_v1"] = %h2_breach_normal_charge_v1;
    level.scr_anim["breach_door_charge"]["breach_normal_v2"] = %h2_breach_normal_charge_v2;
    level.scr_anim["breach_door_charge"]["breach_normal_v3"] = %h2_breach_normal_charge_v3;
    level.scr_anim["breach_door_charge"]["breach_normal_v4"] = %h2_breach_normal_charge_v4;
    level.scr_anim["breach_door_charge"]["breach_inspect"] = %h2_breach_normal_charge_inspect;
    level.scr_anim["breach_door_charge"]["breach_price"] = %h2_gulag_breach_rescue_charge;
    level.scr_anim["breach_door_charge"]["breach_price2"] = %h2_gulag_breach_rescue_charge_soap;
    level.scr_anim["breach_door_charge"]["breach_npc_chill"] = %h2_breach_normal_charge_v1;
    level.scr_anim["breach_door_charge"]["breach_npc_twitch"] = %h2_breach_normal_charge_v2;
    level.scr_anim["breach_door_charge"]["breach_npc_thumbs_up"] = %h2_breach_normal_charge_v3;
    level.scr_anim["breach_door_charge"]["breach_npc_lets_go"] = %h2_breach_normal_charge_v4;
    level.scr_anim["breach_door_charge"]["breach_npc_listen"] = %h2_breach_normal_charge_v1;
    level.scr_anim["breach_door_charge"]["player_inspect_v1"] = %h2_breach_normal_charge_inspect_v1;
    maps\_anim::addonstart_animsound( "breach_door_charge", "breach_normal", "scn_detpack_breach_normal" );
    maps\_anim::addonstart_animsound( "breach_door_charge", "breach_normal_v1", "scn_detpack_breach_normal_v1" );
    maps\_anim::addonstart_animsound( "breach_door_charge", "breach_normal_v2", "scn_detpack_breach_normal_v2" );
    maps\_anim::addonstart_animsound( "breach_door_charge", "breach_normal_v3", "scn_detpack_breach_normal_v3" );
    maps\_anim::addonstart_animsound( "breach_door_charge", "breach_normal_v4", "scn_detpack_breach_normal_v4" );
    maps\_anim::addonstart_animsound( "breach_door_charge", "breach_inspect", "scn_detpack_breach_inspect" );
    maps\_anim::addonstart_animsound( "breach_door_charge", "player_inspect_v1", "scn_detpack_breach_inspect_v1" );
    maps\_anim::addonstart_animsound( "breach_door_charge", "breach_npc_chill", "scn_detpack_breach_npc_chill" );
    maps\_anim::addonstart_animsound( "breach_door_charge", "breach_npc_twitch", "scn_detpack_breach_npc_twitch" );
    maps\_anim::addonstart_animsound( "breach_door_charge", "breach_npc_thumbs_up", "scn_detpack_breach_npc_thumbs_up" );
    maps\_anim::addonstart_animsound( "breach_door_charge", "breach_npc_lets_go", "scn_detpack_breach_npc_lets_go" );
    maps\_anim::addonstart_animsound( "breach_door_charge", "breach_npc_listen", "scn_detpack_breach_npc_listen" );
    level._id_C136 = [];
    level._id_C136["breach_normal"] = "mil_frame_charge";
    level._id_C136["breach_normal_v1"] = "mil_frame_charge";
    level._id_C136["breach_normal_v2"] = "mil_frame_charge";
    level._id_C136["breach_normal_v3"] = "mil_frame_charge";
    level._id_C136["breach_normal_v4"] = "mil_frame_charge";
    level._id_C136["breach_inspect"] = "mil_frame_charge";
    level._id_C136["breach_price"] = "mil_frame_charge";
    level._id_C136["breach_price2"] = "mil_frame_charge";
    level._id_C136["breach_npc_chill"] = "mil_frame_charge";
    level._id_C136["breach_npc_twitch"] = "mil_frame_charge";
    level._id_C136["breach_npc_thumbs_up"] = "mil_frame_charge";
    level._id_C136["breach_npc_lets_go"] = "mil_frame_charge";
    level._id_C136["breach_npc_listen"] = "mil_frame_charge";
    level._id_C136["player_inspect_v1"] = "mil_frame_charge";
}

#using_animtree("multiplayer");

player_animations()
{
    if ( !isdefined( level.slowmo_viewhands ) )
        level.slowmo_viewhands = "viewhands_player_udt";

    level.scr_animtree["active_breacher_rig"] = #animtree;
    level.scr_model["active_breacher_rig"] = level.slowmo_viewhands;
    level.scr_anim["active_breacher_rig"]["breach_player_anim"] = %breach_coop_player_1;

    if ( maps\_utility::is_coop() )
    {
        level.scr_anim["active_breacher_rig"]["breach_player_anim"] = %breach_coop_player_1;
        level.scr_animtree["active_breacher_3rd_person"] = #animtree;
        level.scr_model["active_breacher_3rd_person"] = level.slowmo_viewhands;
        level.scr_anim["active_breacher_3rd_person"]["breach_player_anim"] = %breach_coop_player_1_3rdperson;
        level.scr_anim["active_breacher_3rd_person"]["root"] = %code;
        level.scr_animtree["passive_breacher_rig"] = #animtree;
        level.scr_model["passive_breacher_rig"] = level.slowmo_viewhands;
        level.scr_anim["passive_breacher_rig"]["breach_player_anim"] = %breach_coop_player_2;
        level.scr_animtree["passive_breacher_3rd_person"] = #animtree;
        level.scr_model["passive_breacher_3rd_person"] = level.slowmo_viewhands;
        level.scr_anim["passive_breacher_3rd_person"]["breach_player_anim"] = %breach_coop_player_2_3rdperson;
        level.scr_anim["passive_breacher_3rd_person"]["root"] = %code;
    }

    if ( !isdefined( level._id_B8AB ) )
        level._id_B8AB = "viewbody_udt";

    level.scr_animtree["h2_active_breacher_rig"] = #animtree;
    level.scr_model["h2_active_breacher_rig"] = level._id_B8AB;
    level.scr_anim["h2_active_breacher_rig"]["breach_normal"] = %h2_breach_normal;
    level.scr_anim["h2_active_breacher_rig"]["breach_normal_v1"] = %h2_breach_normal_v1;
    level.scr_anim["h2_active_breacher_rig"]["breach_normal_v2"] = %h2_breach_normal_v2;
    level.scr_anim["h2_active_breacher_rig"]["breach_normal_v3"] = %h2_breach_normal_v3;
    level.scr_anim["h2_active_breacher_rig"]["breach_normal_v4"] = %h2_breach_normal_v4;
    level.scr_anim["h2_active_breacher_rig"]["breach_inspect"] = %h2_breach_player_inspect;
    level.scr_anim["h2_active_breacher_rig"]["breach_price"] = %h2_gulag_breach_rescue_player;
    level.scr_anim["h2_active_breacher_rig"]["breach_npc_chill"] = %h2_breach_normal_v1;
    level.scr_anim["h2_active_breacher_rig"]["breach_npc_twitch"] = %h2_breach_normal_v2;
    level.scr_anim["h2_active_breacher_rig"]["breach_npc_thumbs_up"] = %h2_breach_normal_v3;
    level.scr_anim["h2_active_breacher_rig"]["breach_npc_lets_go"] = %h2_breach_normal_v4;
    level.scr_anim["h2_active_breacher_rig"]["breach_npc_listen"] = %h2_breach_normal_v1;
    level.scr_anim["h2_active_breacher_rig"]["player_inspect_v1"] = %h2_breach_player_inspect_v1;
    level._id_D03D = [ "breach_normal", "breach_normal_v1", "breach_normal_v2", "breach_normal_v3", "breach_normal_v4", "player_inspect_v1", "breach_npc_chill", "breach_npc_twitch", "breach_npc_thumbs_up", "breach_npc_lets_go", "breach_npc_listen" ];
    level._id_C07B = [ "breach_normal_v1", "breach_normal_v2", "breach_normal_v3", "breach_normal_v4", "breach_npc_chill", "breach_npc_twitch", "breach_npc_thumbs_up", "breach_npc_lets_go", "breach_npc_listen" ];
    level._id_C56F = [];
    level._id_A94B = [];
    _id_CFAB();

    foreach ( var_2, var_1 in level.scr_anim["h2_active_breacher_rig"] )
    {
        if ( level._id_C136[var_2] != level._id_CA75 )
        {
            level._id_A94B[var_2] = 1;
            level._id_D03D = common_scripts\utility::array_remove( level._id_D03D, var_2 );
            level._id_C07B = common_scripts\utility::array_remove( level._id_C07B, var_2 );
            continue;
        }

        if ( maps\_utility::is_in_array( level._id_C07B, var_2 ) && !maps\_utility::is_in_array( level._id_D03D, var_2 ) )
            level._id_C56F[var_2] = 1;
    }

    level._slowmo_breach_funcs = [];
    add_breach_func( ::breach_explosion );
    maps\_anim::addnotetrack_customfunction( "active_breacher_rig", "explode", ::breach_functions );
    maps\_anim::addnotetrack_customfunction( "active_breacher_rig", "slowmo", ::slowmo_begins );
    maps\_anim::addnotetrack_customfunction( "h2_active_breacher_rig", "explode", ::breach_functions );
    maps\_anim::addnotetrack_customfunction( "h2_active_breacher_rig", "slowmo", ::slowmo_begins );
    maps\_anim::addnotetrack_customfunction( "h2_active_breacher_rig", "hide_WB", ::_id_C81E );
}

add_breach_func( var_0 )
{
    level._slowmo_breach_funcs[level._slowmo_breach_funcs.size] = var_0;
}

breach_functions( var_0 )
{
    foreach ( var_2 in level._slowmo_breach_funcs )
        thread [[ var_2 ]]( var_0 );
}

breach_explosion( var_0 )
{
    var_1 = level.breach_groups[self.breach_index];
    var_2 = undefined;
    var_3 = undefined;

    switch ( var_1.doortype )
    {
        case "wood":
            var_2 = "detpack_explo_wood";
            var_3 = "breach_door_hinge";
            break;
        case "estate_wood":
            var_2 = "detpack_explo_wood";
            var_3 = "breach_door_hinge_estate";
            break;
        case "estate_wood_backwards":
            var_2 = "detpack_explo_wood";
            var_3 = undefined;
            break;
        case "caves_wood":
            var_2 = "detpack_explo_wood";
            var_3 = "breach_door_hinge_caves";
            break;
        case "payback_wood":
            var_2 = "pybk_breach_blast";
            var_3 = "breach_door_hinge_payback";
            break;
        case "metal":
            var_2 = "detpack_explo_metal";
            var_3 = "breach_door_hinge_metal";
            break;
        case "none":
            var_2 = "detpack_explo_concrete";
            break;
        case "oilrig":
            var_2 = "detpack_explo_metal";
            var_3 = undefined;
            break;
        default:
            break;
    }

    if ( isdefined( level.friendly_breach ) )
    {
        if ( level.friendly_breach )
            var_2 = "detpack_explo_friendlies";
    }

    if ( isdefined( var_2 ) )
        thread common_scripts\utility::play_sound_in_space( var_2, self.charge.origin );

    common_scripts\_exploder::exploder( "breach_" + self.breach_index );
    thread breach_rumble( self.charge.origin );
    level notify( "breach_explosion" );

    if ( isdefined( level.friendly_breach ) )
        level.friendly_breach = !level.friendly_breach;

    if ( isdefined( var_3 ) )
    {
        var_4 = maps\_utility::spawn_anim_model( var_3 );
        self.post thread maps\_anim::anim_single_solo( var_4, "breach" );
    }

    wait 0.05;
    self.charge delete();

    if ( isdefined( self._id_AB70 ) )
    {
        foreach ( var_6 in self._id_AB70 )
            var_6 delete();
    }

    if ( isdefined( self.door ) )
        self.door delete();
}

breach_rumble( var_0 )
{
    var_1 = spawn( "script_origin", var_0 );
    var_1.origin = var_0;
    var_1 playrumblelooponentity( "grenade_rumble" );
    wait 4;
    var_1 delete();
}

_slomo_breach_executioner_knife()
{
    self endon( "death" );
    self.dodamagetoall = 1;
    thread knife_guy_cleanup();
}

_slomo_breach_executioner_pistol()
{
    self endon( "death" );
    self.dodamagetoall = 1;
    thread _slomo_breach_pistol_guy();
}

_slomo_breach_pistol_guy()
{
    animscripts\notetracks::notetrackpistolpickup();
}

_slomo_breach_blowback_guy()
{
    self endon( "death" );

    if ( !common_scripts\utility::flag( "no_mercy" ) )
        self.ignoreme = 1;

    self.forcelongdeath = 1;
    maps\_utility::waittill_notetrack_or_damage( "bodyfall large" );
    self waittill( "finished_breach_start_anim" );
    self dodamage( self.health - 1, self.origin );
}

_slomo_breach_executed_guy()
{
    if ( self.animation == "execution_knife_hostage" || self.animation == "execution_knife2_hostage" )
        thread _slomo_breach_knife_hostage_death();

    if ( will_be_manhandled() )
        thread get_manhandled();

    self.skipendingidle = 1;
    self endon( "death" );
    maps\_utility::set_generic_deathanim( self.animation + "_death" );
    self waittill( "finished_breach_start_anim" );

    if ( isdefined( self.manhandled ) )
        return;

    if ( anim_exists( self.animation + "_survives" ) )
        self.reference maps\_anim::anim_generic( self, self.animation + "_survives" );

    thread maps\_anim::anim_generic_loop( self, self.animation + "_idle", "stop_idle" );
    self.breachfinished = 1;
}

_slomo_breach_hostage_react()
{
    if ( will_be_manhandled() )
        thread get_manhandled();

    self.skipendingidle = 1;
    self waittill( "finished_breach_start_anim" );

    if ( isdefined( self.manhandled ) )
        return;

    if ( anim_exists( self.animation + "_idle" ) )
        thread maps\_anim::anim_generic_loop( self, self.animation + "_idle", "stop_idle" );

    self.breachfinished = 1;
}

_slomo_breach_c4_hostage()
{
    var_0 = spawn( "script_model", self.reference.origin );
    var_0 setmodel( "com_restaurantchair_2" );
    var_0.angles = self.reference.angles + ( 0, 90, 0 );
    var_0.origin = self.reference.origin;
    self.animname = "generic";

    switch ( self.animation )
    {
        case "hostage_chair_twitch2":
        case "hostage_chair_twitch1":
            maps\_utility::set_deathanim( "h2_hostage_chair_breachdeath_02" );
            break;
        case "hostage_chair_twitch4":
        case "hostage_chair_twitch3":
            maps\_utility::set_deathanim( "h2_hostage_chair_breachdeath" );
            break;
    }
}

_slomo_breach_knife_hostage_death()
{
    var_0 = maps\_utility::get_closest_ai( self.origin, "bad_guys" );
    self waittill( "finished_breach_start_anim" );

    if ( isdefined( var_0 ) && isalive( var_0 ) )
    {
        playfxontag( common_scripts\utility::getfx( "breach_knife_execution" ), self, "J_neck" );
        thread maps\_utility::play_sound_on_entity( "melee_knife_hit_body" );
        self kill();
    }
}

_slomo_breach_executed_guy_pushed_to_floor()
{
    self.skipendingidle = 1;
    self endon( "death" );

    if ( will_be_manhandled() )
        thread get_manhandled();

    self waittillmatch( "single anim", "bodyfall large" );
    maps\_utility::set_generic_deathanim( self.animation + "_death" );
    self waittill( "finished_breach_start_anim" );
    self exitprone( 0.2 );
    maps\_anim::anim_generic( self, self.animation + "_survives" );

    if ( isdefined( self.manhandled ) )
        return;

    thread maps\_anim::anim_generic_loop( self, "hostage_knees_loop", "stop_idle" );
    self.breachfinished = 1;
}

_slomo_breach_fightback_guy()
{
    self.skipendingidle = 1;
    self endon( "death" );
    self waittill( "finished_breach_start_anim" );
    maps\_utility::set_generic_deathanim( self.animation + "_death" );
    maps\_anim::anim_generic( self, self.animation + "_survives" );
    thread maps\_anim::anim_generic_loop( self, "hostage_knees_loop", "stop_idle" );
    self.breachfinished = 1;
}

_slomo_breach_knife_charger()
{
    self endon( "death" );
    breach_enemy_cancel_ragdoll();
    maps\_utility::set_generic_deathanim( self.animation + "_death" );
    self waittillmatch( "single anim", "stab" );
    wait 0.1;
    thread knife_guy_stabs_player();
    self waittill( "finished_breach_start_anim" );
}

knife_guy_stabs_player()
{
    var_0 = maps\_utility::get_closest_player( self.origin );
    var_1 = distance( var_0.origin, self.origin );

    if ( var_1 <= 50 )
    {
        var_0 playrumblelooponentity( "grenade_rumble" );
        var_0 thread maps\_utility::play_sound_on_entity( "melee_knife_hit_body" );
        var_0 enablehealthshield( 0 );
        var_0 enabledeathshield( 0 );
        waittillframeend;
        var_0 dodamage( var_0.health + 50000, self gettagorigin( "tag_weapon_right" ), self );
        var_0.breach_missionfailed = 1;
    }
}

knife_guy_cleanup()
{
    wait 0.5;
    common_scripts\utility::waittill_either( "damage", "finished_breach_start_anim" );

    if ( isdefined( self ) )
        self detach( "weapon_parabolic_knife", "TAG_INHAND" );
}

_slomo_breach_chair_guy_normal()
{
    self endon( "death" );
    breach_enemy_cancel_ragdoll();
    var_0 = randomintrange( 1, 3 );

    if ( common_scripts\utility::cointoss() )
        maps\_utility::set_generic_deathanim( self.animation + "_death" );
    else
        maps\_utility::set_generic_deathanim( self.animation + "_death2" );
}

_slomo_breach_chair_guy_animated()
{
    self endon( "death" );
    breach_enemy_cancel_ragdoll();
    maps\_utility::set_generic_deathanim( self.animation + "_death" );
    thread chair_animate();
    self waittill( "finished_breach_start_anim" );
    thread _slomo_breach_chair_guy_normal();
}

chair_animate()
{
    var_0 = spawn( "script_model", self.reference.origin );
    var_0 setmodel( "furniture_chair_metal01" );
    var_0.animname = "chair";
    var_0 maps\_utility::assign_animtree();
    var_0.reference = spawn( "script_origin", self.reference.origin );
    var_0.reference.angles = self.reference.angles;
    self waittill( "starting_breach_reaction" );
    var_0.reference thread maps\_anim::anim_single_solo( var_0, "breach_chair_hide_reaction_v2_chair" );
    self endon( "finished_breach_start_anim" );

    if ( isalive( self ) )
    {
        self waittill( "death" );
        var_0.reference thread maps\_anim::anim_single_solo( var_0, "breach_chair_hide_reaction_death_v2_chair" );
    }
}

_slomo_breach_desk_guy()
{
    self endon( "death" );
    thread desk_animate();
    self waittill( "finished_breach_start_anim" );
}

desk_animate()
{
    var_0 = spawn( "script_model", self.reference.origin );
    var_0 setmodel( "furniture_long_desk_animate" );
    var_0.animname = "desk";
    var_0 maps\_utility::assign_animtree();
    var_0.reference = spawn( "script_origin", self.reference.origin );
    var_0.reference.angles = self.reference.angles;
    self waittill( "starting_breach_reaction" );
    var_0.reference thread maps\_anim::anim_single_solo( var_0, "breach_react_desk_v7_desk" );
}

breach_near_player( var_0 )
{
    foreach ( var_2 in level.breach_groups )
    {
        if ( var_0 istouching( var_2.door_volume ) )
            return var_2;
    }
}

get_breach_groups()
{
    var_0 = getarraykeys( level.breach_groups );
    return var_0;
}

make_empty_breach( var_0 )
{
    level.breach_groups[var_0].enabled = 0;
}

delete_breach( var_0 )
{
    level.breach_groups[var_0].trigger delete();
    var_1 = level.breach_groups[var_0].path_solids;
    common_scripts\utility::array_call( var_1, ::connectpaths );
    common_scripts\utility::array_thread( var_1, maps\_utility::self_delete );

    foreach ( var_3 in level.breach_groups[var_0].lookat_triggers )
        var_3 delete();
}

breach_debug_display_animnames( var_0 )
{
    if ( !isdefined( self ) )
        return;

    var_1 = self.origin;
    wait 0.05;

    if ( getdvar( "breach_debug" ) == "0" )
        return;

    var_2 = [];
    var_3 = getentarray( "breach_enemy_spawner", "targetname" );
    var_4 = getentarray( "breach_hostage_spawner", "targetname" );
    var_2 = maps\_utility::array_merge( var_3, var_4 );

    foreach ( var_6 in var_2 )
    {
        if ( !var_6 istouching( var_0 ) )
            var_2 = common_scripts\utility::array_remove( var_2, var_6 );
    }

    while ( !var_0.breached )
    {
        var_8 = var_1;

        foreach ( var_6 in var_2 )
        {
            if ( isdefined( var_6.animation ) )
            {
                thread maps\_utility::debug_message( var_6.animation, var_8, 1 );
                var_8 -= ( 0, 0, 10 );
            }
        }

        wait 1;
    }
}

will_be_manhandled()
{
    if ( maps\_utility::is_coop() )
        return 0;

    if ( isdefined( level.hostagemanhandle ) && level.hostagemanhandle == 0 )
        return 0;

    if ( isdefined( self.script_noteworthy ) )
        return self.script_noteworthy == "manhandled" || self.script_noteworthy == "manhandled_guarded";

    return 0;
}

manhandler_hold()
{
    if ( level.breachenemies_alive > 0 )
        return 1;

    if ( !self.startmanhandling )
        return 1;

    return 0;
}

get_manhandled()
{
    self endon( "death" );
    self.manhandled = 1;
    self.readytobemanhandled = 0;
    self.startmanhandling = 0;
    var_0 = undefined;

    if ( self.script_noteworthy == "manhandled" )
        var_0 = getent( self.target, "targetname" );

    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;
    var_7 = undefined;
    var_8 = "";

    if ( isdefined( self.script_parameters ) )
        var_8 = self.script_parameters;

    switch ( self.script_noteworthy )
    {
        case "manhandled":
            var_4 = self.animation + "_manhandled";
            break;
        case "manhandled_guarded":
            var_4 = self.animation + "_manhandled_guarded";
            break;
    }

    var_7 = var_4 + "_idle" + var_8;
    var_2 = var_4 + "_prepare" + var_8;
    var_3 = var_4 + "_prepare_idle" + var_8;
    var_5 = var_4 + "_part2A" + var_8;
    var_6 = var_4 + "_part2B" + var_8;
    var_4 += var_8;
    assert_if_anim_not_defined( var_4 );
    assert_if_anim_not_defined( var_7 );

    if ( self.script_noteworthy == "manhandled" )
    {
        var_1 = var_0 maps\_utility::spawn_ai( 1 );
        var_1 hide();
        self.reference maps\_anim::anim_generic_first_frame( var_1, var_1.animation );
        var_1 pushplayer( 1 );
        level.manhandler = var_1;
        var_1.readytomanhandle = 0;
        var_1 thread manhandler_think();
    }

    wait 0.5;

    if ( self.script_noteworthy == "manhandled" )
    {
        var_1 show();
        var_9 = level.scr_anim["generic"]["friendly_manhandle_h2"];

        if ( isdefined( var_9 ) )
            var_1 thread maps\_anim::anim_loop_solo( var_1, "friendly_manhandle_h2", undefined, undefined, "generic" );
    }

    wait 0.5;
    self waittill( "finished_breach_start_anim" );

    if ( anim_exists( var_2 ) )
        self.reference maps\_anim::anim_generic( self, var_2 );

    if ( anim_exists( var_3 ) )
        self.reference thread maps\_anim::anim_generic_loop( self, var_3, "stop_idle" );
    else
        var_3 = undefined;

    self.readytobemanhandled = 1;

    if ( isdefined( var_3 ) )
    {
        while ( manhandler_hold() )
            wait 0.05;
    }

    self.reference notify( "stop_idle" );
    self notify( "stop_idle" );

    if ( self.script_noteworthy == "manhandled" )
    {
        var_1 notify( "stop_loop" );
        self.reference thread maps\_anim::anim_generic( var_1, var_1.animation );
    }

    self.reference maps\_anim::anim_generic( self, var_4 );

    if ( anim_exists( var_5 ) )
    {
        var_10 = getent( "animation_breach_2A", "targetname" );
        var_10 thread maps\_anim::anim_generic( var_1, var_1.animation + "_part2A" );
        var_10 maps\_anim::anim_generic( self, var_5 );
    }
    else if ( anim_exists( var_6 ) )
    {
        var_10 = getent( "animation_breach_2B", "targetname" );
        var_10 thread maps\_anim::anim_generic( var_1, var_1.animation + "_part2B" );
        var_10 maps\_anim::anim_generic( self, var_6 );
    }

    if ( isdefined( var_1 ) && isdefined( level.scr_anim["generic"][var_1.animation + "_idle"] ) )
        self.reference thread maps\_anim::anim_generic_loop( var_1, var_1.animation + "_idle", "stop_idle" );

    if ( isdefined( level.scr_anim["generic"][var_7] ) )
        self.reference thread maps\_anim::anim_generic_loop( self, var_7, "stop_idle" );
}

_id_CA04( var_0 )
{
    var_1 = level.player getplayerangles();
    var_1 = ( 0, var_1[1], 0 );
    var_2 = anglestoforward( var_1 );
    var_3 = anglestoup( var_1 );
    var_4 = 0.1;
    var_5 = common_scripts\utility::spawn_tag_origin();
    var_5.origin = level.player.origin;
    var_5.angles = var_1;
    level.player playerlinktodelta( var_5, "tag_origin", 1, 45, 45, 90, 45, 1 );
    var_5 moveto( var_5.origin + var_3 * var_0, var_4 );
    wait( var_4 );
    level.player unlink();
}

special_gulag_adjustment( var_0 )
{
    if ( level.script == "gulag" )
    {
        var_1 = var_0.angles;
        var_2 = ( -4254.38, 1667.38, 133.681 );
        var_3 = common_scripts\utility::spawn_tag_origin();
        var_3.origin = level.player.origin;
        var_3.angles = var_1;
        level.player playerlinktodelta( var_3, "tag_origin", 1, 45, 45, 90, 45, 1 );
        var_4 = 0.45;
        var_3 moveto( var_2, var_4, var_4 * 0.4, var_4 * 0.4 );
        wait( var_4 );
        level.player setmovespeedscale( 0.5 );
        thread player_slows_down();
        level.price_breach_ent thread price_breach_ent_rotatesto_player();
    }
}

player_slows_down()
{
    wait 0.25;
    var_0 = level maps\_utility::create_blend( ::player_loses_speedscale, 0.5, 0 );
    var_0.time = 1.5;
}

price_breach_ent_movesto_player()
{
    self endon( "stop_following_player" );
    wait 1.5;

    for (;;)
    {
        self moveto( level.player.origin, 2, 0, 0 );
        wait 0.05;
    }
}

price_breach_ent_rotatesto_player()
{
    self endon( "stop_following_player" );
    var_0 = spawn( "script_origin", ( 0, 0, 0 ) );

    for (;;)
    {
        var_1 = level.player.origin;
        var_1 = maps\_utility::set_z( var_1, 0 );
        var_2 = self.origin;
        var_2 = maps\_utility::set_z( var_2, 0 );
        var_3 = vectortoangles( var_1 - var_2 );
        var_4 = anglestoforward( var_3 );
        var_5 = anglestoforward( self.angles );
        var_6 = anglestoright( self.angles );
        var_7 = vectordot( var_4, var_6 );
        var_0.angles = self.angles;
        var_8 = abs( acos( var_7 ) );
        var_9 = 2;

        if ( var_9 > var_8 )
            var_9 = var_8;

        if ( var_7 < 0 )
            var_0 addyaw( var_9 );
        else
            var_0 addyaw( var_9 * -1 );

        self rotateto( var_0.angles, 0.15 );
        wait 0.15;
    }
}

player_loses_speedscale( var_0, var_1, var_2 )
{
    level.player setmovespeedscale( var_1 * ( 1 - var_0 ) + var_2 * var_0 );
}

manhandler_think()
{
    level endon( "mission failed" );

    if ( getdvar( "hostage_missionfail" ) == "1" )
        level endon( "player_shot_a_hostage" );

    thread maps\_utility::magic_bullet_shield();
    maps\_utility::setflashbangimmunity( 1 );

    if ( !common_scripts\utility::flag( "no_mercy" ) )
        self.ignoreme = 1;

    self.grenadeawareness = 0;
    wait 1;
    var_0 = [];
    var_1 = getaispeciesarray( "neutral", "civilian" );

    foreach ( var_3 in var_1 )
    {
        if ( !isdefined( var_3.readytobemanhandled ) )
            continue;

        if ( isdefined( var_3.script_slowmo_breach ) && var_3.script_slowmo_breach == self.script_slowmo_breach )
        {
            if ( isdefined( var_3.script_noteworthy ) && issubstr( var_3.script_noteworthy, "manhandled" ) )
                var_0 = common_scripts\utility::array_add( var_0, var_3 );
        }
    }

    var_5 = var_0.size;
    var_6 = var_0;

    while ( var_5 > 0 )
    {
        wait 0.05;

        foreach ( var_3 in var_6 )
        {
            if ( !isdefined( var_3 ) || var_3.readytobemanhandled == 1 )
            {
                var_6 = common_scripts\utility::array_remove( var_6, var_3 );
                var_5--;
            }
        }
    }

    if ( isdefined( self.manhandler_additional_wait_func ) )
        [[ self.manhandler_additional_wait_func ]]();

    foreach ( var_3 in var_0 )
    {
        if ( isdefined( var_3 ) )
            var_3.startmanhandling = 1;
    }
}

assert_if_anim_not_defined( var_0 )
{

}

anim_exists( var_0 )
{
    if ( isdefined( level.scr_anim["generic"][var_0] ) )
        return 1;
    else
        return 0;
}

add_slowmo_breach_custom_function( var_0, var_1 )
{
    level._slowmo_functions[var_0] = var_1;
}

add_slowmo_breacher()
{
    if ( !isdefined( self ) )
        return;

    if ( !isdefined( level.breachfriendlies ) )
    {
        level.breachfriendlies = [];
        level.breachfriendlies[0] = self;
    }
    else if ( maps\_utility::is_in_array( level.breachfriendlies, self ) )
        return;
    else
        level.breachfriendlies = common_scripts\utility::array_add( level.breachfriendlies, self );
}

remove_slowmo_breacher()
{
    if ( !isdefined( self ) )
        return;

    if ( !isdefined( level.breachfriendlies ) )
        return;

    if ( maps\_utility::is_in_array( level.breachfriendlies, self ) )
        level.breachfriendlies = common_scripts\utility::array_remove( level.breachfriendlies, self );
}

breach_failed_to_start()
{
    var_0 = [];
    var_0[var_0.size] = ::ismeleeing;
    var_0[var_0.size] = ::isswitchingweapon;
    var_0[var_0.size] = ::isthrowinggrenade;

    foreach ( var_2 in level.players )
    {
        if ( var_2 isreloading() )
        {
            thread breach_reloading_hint();
            return 1;
        }

        if ( var_2 using_illegal_breach_weapon() )
        {
            thread breach_bad_weapon_hint();
            return 1;
        }

        foreach ( var_4 in var_0 )
        {
            if ( var_2 call [[ var_4 ]]() )
            {
                thread breach_not_ready_hint();
                return 1;
            }
        }
    }

    return 0;
}

using_illegal_breach_weapon()
{
    var_0 = [];
    var_0["riotshield"] = 1;
    var_0["claymore"] = 1;
    var_0["c4"] = 1;
    var_0["none"] = 1;
    var_1 = self getcurrentweapon();
    return isdefined( var_0[var_1] );
}

slomo_sound_scale_setup()
{

}
