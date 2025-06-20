// H2 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    common_scripts\utility::array_thread( getentarray( "com_wall_fan_blade_rotate", "targetname" ), ::fan_blade_rotate, "slow" );
    common_scripts\utility::array_thread( getentarray( "com_wall_fan_blade_rotate_fast", "targetname" ), ::fan_blade_rotate, "fast" );
    var_0 = [];
    var_0["trigger_multiple_dyn_metal_detector"] = ::metal_detector;
    var_0["trigger_multiple_dyn_creaky_board"] = ::creaky_board;
    var_0["trigger_multiple_dyn_photo_copier"] = ::photo_copier;
    var_0["trigger_multiple_dyn_copier_no_light"] = ::photo_copier_no_light;
    var_0["trigger_radius_motion_light"] = ::motion_light;
    var_0["trigger_radius_dyn_motion_dlight"] = ::outdoor_motion_dlight;
    var_0["trigger_multiple_dog_bark"] = ::dog_bark;
    var_0["trigger_radius_bird_startle"] = ::bird_startle;
    var_0["trigger_multiple_dyn_motion_light"] = ::motion_light;
    var_0["trigger_multiple_dyn_door"] = ::trigger_door;
    player_init();

    foreach ( var_4, var_2 in var_0 )
    {
        var_3 = getentarray( var_4, "classname" );
        common_scripts\utility::array_thread( var_3, ::triggertouchthink );
        common_scripts\utility::array_thread( var_3, var_2 );
    }

    common_scripts\utility::array_thread( getentarray( "vending_machine", "targetname" ), ::vending_machine );
    common_scripts\utility::array_thread( getentarray( "toggle", "targetname" ), ::use_toggle );
    level thread onplayerconnect();
    var_5 = getent( "civilian_jet_origin", "targetname" );

    if ( isdefined( var_5 ) )
        var_5 thread civilian_jet_flyby();
}

onplayerconnect()
{
    for (;;)
    {
        level waittill( "connecting", var_0 );
        var_0 thread movementtracker();
    }
}

player_init()
{
    if ( common_scripts\utility::issp() )
    {
        foreach ( var_1 in level.players )
        {
            var_1.touchtriggers = [];
            var_1 thread movementtracker();
        }
    }
}

ai_init()
{
    self.touchtriggers = [];
    thread movementtracker();
}

civilian_jet_flyby()
{
    level endon( "game_ended" );
    jet_init();
    level waittill( "prematch_over" );

    for (;;)
    {
        thread jet_timer();
        self waittill( "start_flyby" );
        thread jet_flyby();
        self waittill( "flyby_done" );
        jet_reset();
    }
}

jet_init()
{
    self.jet_parts = getentarray( self.target, "targetname" );
    self.jet_flyto = getent( "civilian_jet_flyto", "targetname" );
    self.engine_fxs = getentarray( "engine_fx", "targetname" );
    self.flash_fxs = getentarray( "flash_fx", "targetname" );
    self.jet_engine_fx = loadfx( "fx/fire/jet_afterburner" );
    self.jet_flash_fx_red = loadfx( "fx/misc/aircraft_light_wingtip_red" );
    self.jet_flash_fx_green = loadfx( "fx/misc/aircraft_light_wingtip_green" );
    self.jet_flash_fx_blink = loadfx( "fx/misc/aircraft_light_red_blink" );
    level.civilianjetflyby = undefined;
    var_0 = maps\_utility::_id_C32D( vectornormalize( self.origin - self.jet_flyto.origin ), 20000 );
    self.jet_flyto.origin -= var_0;
    self.origin += var_0;

    foreach ( var_2 in self.jet_parts )
    {
        var_2.origin += var_0;
        var_2.old_origin = var_2.origin;
        var_2 hide();
    }

    foreach ( var_5 in self.engine_fxs )
        var_5.origin += var_0;

    foreach ( var_8 in self.flash_fxs )
        var_8.origin += var_0;

    var_10 = self.origin;
    var_11 = self.jet_flyto.origin;
    self.jet_fly_vec = var_11 - var_10;
    var_12 = 2000;
    var_13 = abs( distance( var_10, var_11 ) );
    self.jet_flight_time = var_13 / var_12;
}

jet_reset()
{
    foreach ( var_1 in self.jet_parts )
    {
        var_1.origin = var_1.old_origin;
        var_1 hide();
    }
}

jet_timer()
{
    level endon( "game_ended" );
    var_0 = gettimeinterval();
    var_1 = max( 10, var_0 );
    var_1 = min( var_1, 100 );

    if ( getdvar( "jet_flyby_timer" ) != "" )
        level.civilianjetflyby_timer = 5 + getdvarint( "jet_flyby_timer" );
    else
        level.civilianjetflyby_timer = ( 0.25 + randomfloatrange( 0.3, 0.7 ) ) * 60 * var_1;

    wait( level.civilianjetflyby_timer );

    while ( isdefined( level.airstrikeinprogress ) || isdefined( level.ac130player ) || isdefined( level.chopper ) || isdefined( level.remotemissileinprogress ) )
        wait 0.05;

    self notify( "start_flyby" );
    level.civilianjetflyby = 1;
    self waittill( "flyby_done" );
    level.civilianjetflyby = undefined;
}

gettimeinterval()
{
    if ( common_scripts\utility::issp() )
        return 10.0;

    if ( isdefined( game["status"] ) && game["status"] == "overtime" )
        return 1.0;
    else
        return getwatcheddvar( "timelimit" );
}

getwatcheddvar( var_0 )
{
    var_0 = "scr_" + level.gametype + "_" + var_0;
    return level.watchdvars[var_0].value;
}

jet_flyby()
{
    foreach ( var_1 in self.jet_parts )
        var_1 show();

    var_3 = [];
    var_4 = [];

    foreach ( var_6 in self.engine_fxs )
    {
        var_7 = spawn( "script_model", var_6.origin );
        var_7 setmodel( "tag_origin" );
        var_7.angles = var_6.angles;
        var_3[var_3.size] = var_7;
    }

    foreach ( var_10 in self.flash_fxs )
    {
        var_11 = spawn( "script_model", var_10.origin );
        var_11 setmodel( "tag_origin" );
        var_11.color = var_10.script_noteworthy;
        var_11.angles = var_10.angles;
        var_4[var_4.size] = var_11;
    }

    thread jet_planesound( self.jet_parts[0], level.mapcenter );
    wait 0.05;

    foreach ( var_7 in var_3 )
        playfxontag( self.jet_engine_fx, var_7, "tag_origin" );

    foreach ( var_11 in var_4 )
    {
        if ( isdefined( var_11.color ) && var_11.color == "blink" )
        {
            playfxontag( self.jet_flash_fx_blink, var_11, "tag_origin" );
            continue;
        }

        if ( isdefined( var_11.color ) && var_11.color == "red" )
        {
            playfxontag( self.jet_flash_fx_red, var_11, "tag_origin" );
            continue;
        }

        playfxontag( self.jet_flash_fx_green, var_11, "tag_origin" );
    }

    foreach ( var_1 in self.jet_parts )
        var_1 moveto( var_1.origin + self.jet_fly_vec, self.jet_flight_time );

    foreach ( var_7 in var_3 )
        var_7 moveto( var_7.origin + self.jet_fly_vec, self.jet_flight_time );

    foreach ( var_11 in var_4 )
        var_11 moveto( var_11.origin + self.jet_fly_vec, self.jet_flight_time );

    wait( self.jet_flight_time + 1 );

    foreach ( var_7 in var_3 )
        var_7 delete();

    foreach ( var_11 in var_4 )
        var_11 delete();

    self notify( "flyby_done" );
}

jet_planesound( var_0, var_1 )
{
    var_0 thread playsound_loop_on_ent( "veh_mig29_dist_loop" );

    while ( !targetisclose( var_0, var_1 ) )
        wait 0.05;

    var_0 thread playsound_loop_on_ent( "veh_mig29_close_loop" );

    while ( targetisinfront( var_0, var_1 ) )
        wait 0.05;

    wait 0.5;
    var_0 thread playsound_float( "veh_mig29_sonic_boom" );

    while ( targetisclose( var_0, var_1 ) )
        wait 0.05;

    var_0 notify( "stop soundveh_mig29_close_loop" );
    self waittill( "flyby_done" );
    var_0 notify( "stop soundveh_mig29_dist_loop" );
}

playsound_float( var_0, var_1, var_2 )
{
    var_3 = spawn( "script_origin", ( 0, 0, 1 ) );
    var_3 hide();

    if ( !isdefined( var_1 ) )
        var_1 = self.origin;

    var_3.origin = var_1;

    if ( isdefined( var_2 ) && var_2 )
        var_3 playsoundasmaster( var_0 );
    else
        var_3 playsound( var_0 );

    wait 10.0;
    var_3 delete();
}

playsound_loop_on_ent( var_0, var_1 )
{
    var_2 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_2 hide();
    var_2 endon( "death" );
    thread common_scripts\utility::delete_on_death( var_2 );

    if ( isdefined( var_1 ) )
    {
        var_2.origin = self.origin + var_1;
        var_2.angles = self.angles;
        var_2 linkto( self );
    }
    else
    {
        var_2.origin = self.origin;
        var_2.angles = self.angles;
        var_2 linkto( self );
    }

    var_2 playloopsound( var_0 );
    self waittill( "stop sound" + var_0 );
    var_2 stopsounds( var_0 );
    var_2 delete();
}

targetisinfront( var_0, var_1 )
{
    var_2 = anglestoforward( common_scripts\utility::flat_angle( var_0.angles ) );
    var_3 = vectornormalize( common_scripts\utility::flat_origin( var_1 ) - var_0.origin );
    var_4 = vectordot( var_2, var_3 );

    if ( var_4 > 0 )
        return 1;
    else
        return 0;
}

targetisclose( var_0, var_1 )
{
    var_2 = targetisinfront( var_0, var_1 );

    if ( var_2 )
        var_3 = 1;
    else
        var_3 = -1;

    var_4 = common_scripts\utility::flat_origin( var_0.origin );
    var_5 = var_4 + maps\_utility::_id_C32D( anglestoforward( common_scripts\utility::flat_angle( var_0.angles ) ), var_3 * 100000 );
    var_6 = pointonsegmentnearesttopoint( var_4, var_5, var_1 );
    var_7 = distance( var_4, var_6 );

    if ( var_7 < 3000 )
        return 1;
    else
        return 0;
}

vending_machine()
{
    level endon( "game_ended" );
    self endon( "death" );
    self setcursorhint( "HINT_ACTIVATE" );
    self.vm_normal = getent( self.target, "targetname" );
    var_0 = getent( self.vm_normal.target, "targetname" );
    var_1 = getent( var_0.target, "targetname" );
    self.vm_launch_from = getent( var_1.target, "targetname" );
    self.vm_launch_to = getent( self.vm_launch_from.target, "targetname" );

    if ( isdefined( self.vm_launch_to.target ) )
        self.vm_fx_loc = getent( self.vm_launch_to.target, "targetname" );

    self.vm_normal setcandamage( 1 );
    self.vm_normal_model = self.vm_normal.model;
    self.vm_damaged_model = self.vm_normal.script_noteworthy;
    self.vm_soda_model = var_0.model;
    self.vm_soda_start_pos = var_0.origin;
    self.vm_soda_start_angle = var_0.angles;
    self.vm_soda_stop_pos = var_1.origin;
    self.vm_soda_stop_angle = var_1.angles;
    precachemodel( self.vm_damaged_model );
    var_0 delete();
    var_1 delete();
    self.soda_array = [];
    self.soda_count = 12;
    self.soda_slot = undefined;
    self.hp = 400;
    thread vending_machine_damage_monitor( self.vm_normal );
    self playloopsound( "vending_machine_hum" );

    for (;;)
    {
        self waittill( "trigger", var_2 );
        self playsound( "vending_machine_button_press" );

        if ( !self.soda_count )
            continue;

        if ( isdefined( self.soda_slot ) )
            soda_can_eject();

        soda_can_drop( spawn_soda() );
        wait 0.05;
    }
}

vending_machine_damage_monitor( var_0 )
{
    level endon( "game_ended" );
    var_1 = "mod_grenade mod_projectile mod_explosive mod_grenade_splash mod_projectile_splash splash";
    var_2 = loadfx( "fx/explosions/tv_explosion" );

    for (;;)
    {
        var_0 waittill( "damage", var_3, var_4, var_5, var_6, var_7 );

        if ( isdefined( var_7 ) )
        {
            if ( issubstr( var_1, tolower( var_7 ) ) )
                var_3 *= 3;

            self.hp -= var_3;

            if ( self.hp > 0 )
                continue;

            thread common_scripts\utility::play_sound_in_space( "h2_explosion_vending_machine_sparks", self.origin );
            self notify( "death" );
            self.origin += ( 0, 0, 10000 );

            if ( !isdefined( self.vm_fx_loc ) )
                var_8 = self.vm_normal.origin + ( 37, -31, 52 );
            else
                var_8 = self.vm_fx_loc.origin;

            playfx( var_2, var_8 );
            self.vm_normal setmodel( self.vm_damaged_model );

            while ( self.soda_count > 0 )
            {
                if ( isdefined( self.soda_slot ) )
                    soda_can_eject();

                soda_can_drop( spawn_soda() );
                wait 0.05;
            }

            self stopsounds( "vending_machine_hum" );
            return;
        }
    }
}

spawn_soda()
{
    var_0 = spawn( "script_model", self.vm_soda_start_pos );
    var_0 setmodel( self.vm_soda_model );
    var_0.origin = self.vm_soda_start_pos;
    var_0.angles = self.vm_soda_start_angle;
    return var_0;
}

soda_can_drop( var_0 )
{
    var_0 moveto( self.vm_soda_stop_pos, 0.1 );
    var_0 playsound( "vending_machine_soda_drop" );
    wait 0.1;
    self.soda_slot = var_0;
    self.soda_count--;
}

soda_can_eject()
{
    self endon( "death" );

    if ( isdefined( self.soda_slot.ejected ) && self.soda_slot.ejected == 1 )
        return;

    var_0 = 1150.0;
    var_1 = var_0 * 0.75 * 1.15;
    var_2 = vectornormalize( self.vm_launch_to.origin - self.vm_launch_from.origin );
    var_3 = maps\_utility::_id_C32D( var_2, randomfloatrange( var_1, var_0 ) );
    var_4 = ( var_3[0] * randomfloatrange( 1, 1.15 ), var_3[1] * randomfloatrange( 1, 1.15 ), var_3[2] * randomfloatrange( 1, 1.15 ) );
    self.soda_slot physicslaunchclient( self.vm_launch_from.origin, var_4 );
    self.soda_slot.ejected = 1;
}

freefall()
{
    level endon( "game_ended" );
    var_0 = "briefcase_bomb_mp";
    precacheitem( var_0 );

    for (;;)
    {
        self waittill( "trigger_enter", var_1 );

        if ( !var_1 hasweapon( var_0 ) )
        {
            var_1 playsound( "freefall_death" );
            var_1 giveweapon( var_0 );
            var_1 setweaponammostock( var_0, 0 );
            var_1 setweaponammoclip( var_0, 0 );
            var_1 switchtoweapon( var_0 );
        }
    }
}

metal_detector()
{
    level endon( "game_ended" );
    var_0 = getent( self.target, "targetname" );
    var_0 enablegrenadetouchdamage();
    var_1 = getent( var_0.target, "targetname" );
    var_2 = getent( var_1.target, "targetname" );
    var_3 = getent( var_2.target, "targetname" );
    var_4 = getent( var_3.target, "targetname" );
    var_5 = [];
    var_6 = min( var_1.origin[0], var_2.origin[0] );
    var_5[0] = var_6;
    var_7 = max( var_1.origin[0], var_2.origin[0] );
    var_5[1] = var_7;
    var_8 = min( var_1.origin[1], var_2.origin[1] );
    var_5[2] = var_8;
    var_9 = max( var_1.origin[1], var_2.origin[1] );
    var_5[3] = var_9;
    var_10 = min( var_1.origin[2], var_2.origin[2] );
    var_5[4] = var_10;
    var_11 = max( var_1.origin[2], var_2.origin[2] );
    var_5[5] = var_11;
    var_1 delete();
    var_2 delete();

    if ( !common_scripts\utility::issp() )
        self.alarm_interval = 7;
    else
        self.alarm_interval = 2;

    self.alarm_playing = 0;
    self.alarm_annoyance = 0;
    self.tolerance = 0;
    thread metal_detector_dmg_monitor( var_0 );
    thread metal_detector_touch_monitor();
    thread metal_detector_weapons( var_5, "weapon_claymore", "weapon_c4" );
    var_12 = [];

    if ( isdefined( var_4.target ) )
    {
        var_12 = common_scripts\utility::getstructarray( var_4.target, "targetname" );

        foreach ( var_14 in var_12 )
            var_14._id_C37D = loadfx( var_14.script_fxid );
    }
    else
    {
        var_16 = loadfx( "fx/props/metal_detector_light" );
        var_17 = spawnstruct();
        var_17.origin = ( var_3.origin[0], var_3.origin[1], var_11 );
        var_17._id_C37D = var_16;
        var_18 = spawnstruct();
        var_18.origin = ( var_4.origin[0], var_4.origin[1], var_11 );
        var_18._id_C37D = var_16;
        var_12[0] = var_17;
        var_12[1] = var_18;
    }

    if ( !isdefined( level.alarm_to_play_index ) )
        level.alarm_to_play_index = 0;

    level.alarm_to_play_index = 1 + level.alarm_to_play_index % 3;
    var_19 = "alarm_metal_detector_" + level.alarm_to_play_index;

    for (;;)
    {
        common_scripts\utility::waittill_any( "dmg_triggered", "touch_triggered", "weapon_triggered" );
        thread _id_CA8E( var_19, var_12 );
    }
}

_id_CA8E( var_0, var_1 )
{
    level endon( "game_ended" );

    if ( !self.alarm_playing )
    {
        self.alarm_playing = 1;
        thread annoyance_tracker();

        if ( !self.alarm_annoyance )
            self playsound( var_0 );

        foreach ( var_3 in var_1 )
        {
            if ( isdefined( var_3.angles ) )
            {
                var_4 = anglestoaxis( var_3.angles );
                playfx( var_3._id_C37D, var_3.origin, var_4["forward"], var_4["up"] );
                continue;
            }

            playfx( var_3._id_C37D, var_3.origin );
        }

        wait( self.alarm_interval );
        self.alarm_playing = 0;
    }
}

annoyance_tracker()
{
    level endon( "game_ended" );

    if ( !self.tolerance )
        return;

    var_0 = self.alarm_interval + 0.15;

    if ( self.tolerance )
        self.tolerance--;
    else
        self.alarm_annoyance = 1;

    var_1 = gettime();
    var_2 = 7;

    if ( common_scripts\utility::issp() )
        var_2 = 2;

    waittill_any_or_timeout( "dmg_triggered", "touch_triggered", "weapon_triggered", var_2 + 2 );
    var_3 = gettime() - var_1;

    if ( var_3 > var_2 * 1000 + 1150 )
    {
        self.alarm_annoyance = 0;
        self.tolerance = 0;
    }
}

waittill_any_or_timeout( var_0, var_1, var_2, var_3 )
{
    level endon( "game_ended" );
    self endon( var_0 );
    self endon( var_1 );
    self endon( var_2 );
    wait( var_3 );
}

metal_detector_weapons( var_0, var_1, var_2 )
{
    level endon( "game_ended" );

    for (;;)
    {
        waittill_weapon_placed();
        var_3 = getentarray( "grenade", "classname" );

        foreach ( var_5 in var_3 )
        {
            if ( isdefined( var_5.model ) && ( var_5.model == var_1 || var_5.model == var_2 ) )
            {
                if ( isinbound( var_5, var_0 ) )
                    thread weapon_notify_loop( var_5, var_0 );
            }
        }
    }
}

waittill_weapon_placed()
{
    level endon( "game_ended" );
    self endon( "dmg_triggered" );
    self waittill( "touch_triggered" );
}

weapon_notify_loop( var_0, var_1 )
{
    var_0 endon( "death" );

    while ( isinbound( var_0, var_1 ) )
    {
        self notify( "weapon_triggered" );
        wait( self.alarm_interval );
    }
}

isinbound( var_0, var_1 )
{
    var_2 = var_1[0];
    var_3 = var_1[1];
    var_4 = var_1[2];
    var_5 = var_1[3];
    var_6 = var_1[4];
    var_7 = var_1[5];
    var_8 = var_0.origin[0];
    var_9 = var_0.origin[1];
    var_10 = var_0.origin[2];

    if ( isinbound_single( var_8, var_2, var_3 ) )
    {
        if ( isinbound_single( var_9, var_4, var_5 ) )
        {
            if ( isinbound_single( var_10, var_6, var_7 ) )
                return 1;
        }
    }

    return 0;
}

isinbound_single( var_0, var_1, var_2 )
{
    if ( var_0 > var_1 && var_0 < var_2 )
        return 1;

    return 0;
}

metal_detector_dmg_monitor( var_0 )
{
    level endon( "game_ended" );

    for (;;)
    {
        var_0 waittill( "damage", var_1, var_2, var_3, var_4, var_5 );

        if ( isdefined( var_5 ) && alarm_validate_damage( var_5 ) )
            self notify( "dmg_triggered" );
    }
}

metal_detector_touch_monitor()
{
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "trigger_enter" );

        while ( anythingtouchingtrigger( self ) )
        {
            self notify( "touch_triggered" );
            wait( self.alarm_interval );
        }
    }
}

alarm_validate_damage( var_0 )
{
    var_1 = "mod_melee melee mod_grenade mod_projectile mod_explosive mod_impact";
    var_2 = strtok( var_1, " " );

    foreach ( var_4 in var_2 )
    {
        if ( tolower( var_4 ) == tolower( var_0 ) )
            return 1;
    }

    return 0;
}

creaky_board()
{
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "trigger_enter", var_0 );
        var_0 thread do_creak( self );
    }
}

do_creak( var_0 )
{
    self endon( "disconnect" );
    self endon( "death" );
    self playsound( "step_walk_plr_woodcreak_on" );

    for (;;)
    {
        self waittill( "trigger_leave", var_1 );

        if ( var_0 != var_1 )
            continue;

        self playsound( "step_walk_plr_woodcreak_off" );
        return;
    }
}

motion_light()
{
    level endon( "game_ended" );
    self.movetracker = 1;
    self.lightson = 0;
    var_0 = getentarray( self.target, "targetname" );
    precachemodel( "com_two_light_fixture_off" );
    precachemodel( "com_two_light_fixture_on" );

    foreach ( var_2 in var_0 )
    {
        var_2.lightrigs = [];
        var_3 = getent( var_2.target, "targetname" );

        if ( !isdefined( var_3.target ) )
            continue;

        var_2.lightrigs = getentarray( var_3.target, "targetname" );
    }

    for (;;)
    {
        self waittill( "trigger_enter" );

        while ( anythingtouchingtrigger( self ) )
        {
            var_5 = 0;

            foreach ( var_7 in self.touchlist )
            {
                if ( isdefined( var_7.distmoved ) && var_7.distmoved > 5.0 )
                    var_5 = 1;
            }

            if ( var_5 )
            {
                if ( !self.lightson )
                {
                    self.lightson = 1;
                    var_0[0] playsound( "switch_auto_lights_on" );

                    foreach ( var_2 in var_0 )
                    {
                        var_2 setlightintensity( 1.0 );

                        if ( isdefined( var_2.lightrigs ) )
                        {
                            foreach ( var_11 in var_2.lightrigs )
                                var_11 setmodel( "com_two_light_fixture_on" );
                        }
                    }
                }

                thread motion_light_timeout( var_0, 10.0 );
            }

            wait 0.05;
        }
    }
}

motion_light_timeout( var_0, var_1 )
{
    self notify( "motion_light_timeout" );
    self endon( "motion_light_timeout" );
    wait( var_1 );

    foreach ( var_3 in var_0 )
    {
        var_3 setlightintensity( 0 );

        if ( isdefined( var_3.lightrigs ) )
        {
            foreach ( var_5 in var_3.lightrigs )
                var_5 setmodel( "com_two_light_fixture_off" );
        }
    }

    var_0[0] playsound( "switch_auto_lights_off" );
    self.lightson = 0;
}

outdoor_motion_dlight()
{
    if ( !isdefined( level.outdoor_motion_light ) )
        level.outdoor_motion_light = loadfx( "fx/misc/outdoor_motion_light" );

    level endon( "game_ended" );
    self.movetracker = 1;
    self.lightson = 0;
    var_0 = getent( self.target, "targetname" );
    var_1 = getentarray( var_0.target, "targetname" );
    precachemodel( "com_two_light_fixture_off" );
    precachemodel( "com_two_light_fixture_on" );

    for (;;)
    {
        self waittill( "trigger_enter" );

        while ( anythingtouchingtrigger( self ) )
        {
            var_2 = 0;

            foreach ( var_4 in self.touchlist )
            {
                if ( isdefined( var_4.distmoved ) && var_4.distmoved > 5.0 )
                    var_2 = 1;
            }

            if ( var_2 )
            {
                if ( !self.lightson )
                {
                    self.lightson = 1;
                    var_0 playsound( "switch_auto_lights_on" );
                    var_0 setmodel( "com_two_light_fixture_on" );

                    foreach ( var_7 in var_1 )
                    {
                        var_7.lightent = spawn( "script_model", var_7.origin );
                        var_7.lightent setmodel( "tag_origin" );
                        playfxontag( level.outdoor_motion_light, var_7.lightent, "tag_origin" );
                    }
                }

                thread outdoor_motion_dlight_timeout( var_0, var_1, 10.0 );
            }

            wait 0.05;
        }
    }
}

outdoor_motion_dlight_timeout( var_0, var_1, var_2 )
{
    self notify( "motion_light_timeout" );
    self endon( "motion_light_timeout" );
    wait( var_2 );

    foreach ( var_4 in var_1 )
        var_4.lightent delete();

    var_0 playsound( "switch_auto_lights_off" );
    var_0 setmodel( "com_two_light_fixture_off" );
    self.lightson = 0;
}

dog_bark()
{
    level endon( "game_ended" );
    self.movetracker = 1;
    var_0 = getent( self.target, "targetname" );

    for (;;)
    {
        self waittill( "trigger_enter", var_1 );

        while ( anythingtouchingtrigger( self ) )
        {
            var_2 = 0;

            foreach ( var_4 in self.touchlist )
            {
                if ( isdefined( var_4.distmoved ) && var_4.distmoved > var_2 )
                    var_2 = var_4.distmoved;
            }

            if ( var_2 > 6.0 )
            {
                var_0 playsound( "dyn_anml_dog_bark" );
                wait( randomfloatrange( 16 / var_2, 16 / var_2 + randomfloat( 1.0 ) ) );
                continue;
            }

            wait 0.05;
        }
    }
}

trigger_door()
{
    var_0 = getent( self.target, "targetname" );
    self.doorent = var_0;
    self.doorangle = getvectorrightangle( vectornormalize( self getorigin() - var_0 getorigin() ) );
    var_0.baseyaw = var_0.angles[1];
    var_1 = 1.0;

    for (;;)
    {
        self waittill( "trigger_enter", var_2 );
        var_0 thread dooropen( var_1, getdoorside( var_2 ) );

        if ( anythingtouchingtrigger( self ) )
            self waittill( "trigger_empty" );

        wait 3.0;

        if ( anythingtouchingtrigger( self ) )
            self waittill( "trigger_empty" );

        var_0 thread doorclose( var_1 );
    }
}

dooropen( var_0, var_1 )
{
    if ( var_1 )
        self rotateto( ( 0, self.baseyaw + 90, 1 ), var_0, 0.1, 0.75 );
    else
        self rotateto( ( 0, self.baseyaw - 90, 1 ), var_0, 0.1, 0.75 );

    self playsound( "door_generic_house_open" );
    wait( var_0 + 0.05 );
}

doorclose( var_0 )
{
    self rotateto( ( 0, self.baseyaw, 1 ), var_0 );
    self playsound( "door_generic_house_close" );
    wait( var_0 + 0.05 );
}

getdoorside( var_0 )
{
    return vectordot( self.doorangle, vectornormalize( var_0.origin - self.doorent getorigin() ) ) > 0;
}

getvectorrightangle( var_0 )
{
    return ( var_0[1], 0 - var_0[0], var_0[2] );
}

use_toggle()
{
    if ( self.classname != "trigger_use_touch" )
        return;

    var_0 = getentarray( self.target, "targetname" );
    self.lightson = 1;

    foreach ( var_2 in var_0 )
        var_2 setlightintensity( 1.5 * self.lightson );

    for (;;)
    {
        self waittill( "trigger" );
        self.lightson = !self.lightson;

        if ( self.lightson )
        {
            foreach ( var_2 in var_0 )
                var_2 setlightintensity( 1.5 );

            self playsound( "switch_auto_lights_on" );
            continue;
        }

        foreach ( var_2 in var_0 )
            var_2 setlightintensity( 0 );

        self playsound( "switch_auto_lights_off" );
    }
}

bird_startle()
{

}

photo_copier_init( var_0 )
{
    self.copier = get_photo_copier( var_0 );

    if ( !isdefined( self.copier.target ) )
    {
        self.copier = undefined;
        return;
    }

    _id_BBFD();
    self.copier.animname = "photocopier";
    self.copier maps\_anim::setanimtree();
    var_1 = getent( self.copier.target, "targetname" );
    var_2 = getent( var_1.target, "targetname" );
    var_2.intensity = var_2 getlightintensity();
    var_2 setlightintensity( 0 );
    var_0.copy_bar = var_1;
    var_0.start_pos = var_1.origin;
    var_0.light = var_2;
    var_3 = self.copier.angles + ( 0, 90, 0 );
    var_4 = anglestoforward( var_3 );
    var_0.end_pos = var_0.start_pos + maps\_utility::_id_C32D( var_4, 30 );
}

get_photo_copier( var_0 )
{
    if ( !isdefined( var_0.target ) )
    {
        var_1 = getentarray( "destructible_toy", "targetname" );
        var_2 = var_1[0];

        foreach ( var_4 in var_1 )
        {
            if ( isdefined( var_4.destructible_type ) && var_4.destructible_type == "toy_copier" )
            {
                if ( distance( var_0.origin, var_2.origin ) > distance( var_0.origin, var_4.origin ) )
                    var_2 = var_4;
            }
        }
    }
    else
    {
        var_2 = getent( var_0.target, "targetname" );
        var_2 setcandamage( 1 );
    }

    return var_2;
}

waittill_copier_copies()
{
    self.copier endon( "FX_State_Change0" );
    self.copier endon( "death" );
    self waittill( "trigger_enter" );
}

photo_copier()
{
    level endon( "game_ended" );
    photo_copier_init( self );

    if ( !isdefined( self.copier ) )
        return;

    self.copier endon( "FX_State_Change0" );
    thread photo_copier_stop();

    for (;;)
    {
        waittill_copier_copies();
        self.copier thread maps\_anim::anim_single_solo( self.copier, "photocopier_copying" );
        self playsound( "mach_copier_run" );

        if ( isdefined( self.copy_bar ) )
        {
            reset_copier( self );
            thread photo_copier_copy_bar_goes();
            thread photo_copier_light_on();
        }

        wait 6;
    }
}

photo_copier_no_light()
{
    level endon( "game_ended" );
    self.copier = get_photo_copier( self );
    self.copier endon( "FX_State_Change0" );

    for (;;)
    {
        waittill_copier_copies();
        self playsound( "mach_copier_run" );
        wait 3;
    }
}

reset_copier( var_0 )
{
    var_0.copy_bar moveto( var_0.start_pos, 0.2 );
    var_0.light setlightintensity( 0 );
}

photo_copier_copy_bar_goes()
{
    self.copier notify( "bar_goes" );
    self.copier endon( "bar_goes" );
    self.copier endon( "FX_State_Change0" );
    self.copier endon( "death" );
    var_0 = self.copy_bar;
    wait 2.0;
    var_0 moveto( self.end_pos, 1.6 );
    wait 1.8;
    var_0 moveto( self.start_pos, 1.6 );
    wait 1.6;
    var_1 = self.light;
    var_2 = 0.2;
    var_3 = var_2 / 0.05;

    for ( var_4 = 0; var_4 < var_3; var_4++ )
    {
        var_5 = var_4 * 0.05;
        var_5 /= var_2;
        var_5 = 1 - var_5 * var_1.intensity;

        if ( var_5 > 0 )
            var_1 setlightintensity( var_5 );

        wait 0.05;
    }

    var_1 setlightintensity( 0 );
}

photo_copier_light_on()
{
    self.copier notify( "light_on" );
    self.copier endon( "light_on" );
    self.copier endon( "FX_State_Change0" );
    self.copier endon( "death" );
    var_0 = self.light;
    var_1 = 0.2;
    var_2 = var_1 / 0.05;

    for ( var_3 = 0; var_3 < var_2; var_3++ )
    {
        var_4 = var_3 * 750;
        var_4 /= var_1;
        var_0 setlightintensity( var_4 * var_0.intensity );
        wait 0.05;
    }

    photo_light_flicker( var_0 );
}

photo_copier_stop()
{
    self.copier waittill( "FX_State_Change0" );
    self.copier endon( "death" );
    reset_copier( self );
}

photo_light_flicker( var_0 )
{
    var_0 setlightintensity( 3000 );
    wait 0.05;
    var_0 setlightintensity( 0 );
    wait 0.1;
    var_0 setlightintensity( 3000 );
    wait 0.05;
    var_0 setlightintensity( 0 );
    wait 0.1;
    var_0 setlightintensity( 3000 );
}

fan_blade_rotate( var_0 )
{
    var_1 = 0;
    var_2 = 20000;
    var_3 = 1.0;

    if ( isdefined( self.speed ) )
        var_3 = self.speed;

    if ( var_0 == "slow" )
        var_1 = randomfloatrange( 100 * var_3, 360 * var_3 );
    else if ( var_0 == "fast" )
        var_1 = randomfloatrange( 720 * var_3, 1000 * var_3 );
    else
    {

    }

    wait( randomfloatrange( 0, 1 ) );
    var_4 = self.angles;
    var_5 = maps\_utility::_id_C32D( anglestoright( self.angles ), 100 );
    var_5 = vectornormalize( var_5 );

    for (;;)
    {
        var_6 = abs( vectordot( var_5, ( 1, 0, 0 ) ) );
        var_7 = abs( vectordot( var_5, ( 0, 1, 0 ) ) );
        var_8 = abs( vectordot( var_5, ( 0, 0, 1 ) ) );

        if ( var_6 > 0.9 )
            self rotatevelocity( ( var_1, 0, 0 ), var_2 );
        else if ( var_7 > 0.9 )
            self rotatevelocity( ( var_1, 0, 0 ), var_2 );
        else if ( var_8 > 0.9 )
            self rotatevelocity( ( 0, var_1, 0 ), var_2 );
        else
            self rotatevelocity( ( 0, var_1, 0 ), var_2 );

        wait( var_2 );
    }
}

triggertouchthink( var_0, var_1 )
{
    level endon( "game_ended" );
    self.entnum = self getentitynumber();

    for (;;)
    {
        self waittill( "trigger", var_2 );

        if ( !isplayer( var_2 ) && !isdefined( var_2.finished_spawning ) )
            continue;

        if ( !isalive( var_2 ) )
            continue;

        if ( !isdefined( var_2.touchtriggers[self.entnum] ) )
            var_2 thread playertouchtriggerthink( self, var_0, var_1 );
    }
}

playertouchtriggerthink( var_0, var_1, var_2 )
{
    if ( !isplayer( self ) )
        self endon( "death" );

    if ( !common_scripts\utility::issp() )
        var_3 = self.guid;
    else
        var_3 = "player" + gettime();

    var_0.touchlist[var_3] = self;

    if ( isdefined( var_0.movetracker ) )
        self.movetrackers++;

    var_0 notify( "trigger_enter", self );
    self notify( "trigger_enter", var_0 );

    if ( isdefined( var_1 ) )
        self thread [[ var_1 ]]( var_0 );

    self.touchtriggers[var_0.entnum] = var_0;

    while ( isalive( self ) && self istouching( var_0 ) && ( common_scripts\utility::issp() || !level.gameended ) )
        wait 0.05;

    if ( isdefined( self ) )
    {
        self.touchtriggers[var_0.entnum] = undefined;

        if ( isdefined( var_0.movetracker ) )
            self.movetrackers--;

        self notify( "trigger_leave", var_0 );

        if ( isdefined( var_2 ) )
            self thread [[ var_2 ]]( var_0 );
    }

    if ( !common_scripts\utility::issp() && level.gameended )
        return;

    var_0.touchlist[var_3] = undefined;
    var_0 notify( "trigger_leave", self );

    if ( !anythingtouchingtrigger( var_0 ) )
        var_0 notify( "trigger_empty" );
}

movementtracker()
{
    self endon( "disconnect" );

    if ( !isplayer( self ) )
        self endon( "death" );

    self.movetrackers = 0;
    self.distmoved = 0;

    for (;;)
    {
        self waittill( "trigger_enter" );
        var_0 = self.origin;

        while ( self.movetrackers )
        {
            self.distmoved = distance( var_0, self.origin );
            var_0 = self.origin;
            wait 0.05;
        }

        self.distmoved = 0;
    }
}

anythingtouchingtrigger( var_0 )
{
    return var_0.touchlist.size;
}

playertouchingtrigger( var_0, var_1 )
{
    return isdefined( var_0.touchtriggers[var_1.entnum] );
}

#using_animtree("script_model");

_id_BBFD()
{
    level.scr_animtree["photocopier"] = #animtree;
    level.scr_anim["photocopier"]["photocopier_copying"] = %h2_com_photocopier_animated;
}
