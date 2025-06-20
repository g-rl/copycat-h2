// H2 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

friendly_bubbles()
{
    self endon( "death" );
    self notify( "stop_friendly_bubbles" );
    self endon( "stop_friendly_bubbles" );
    thread friendly_bubbles_cleanup();
    var_0 = "TAG_EYE";
    self.scuba_org = common_scripts\utility::spawn_tag_origin();
    self.scuba_org linkto( self, "tag_eye", ( 5, 0, -6 ), ( -90, 0, 0 ) );

    for (;;)
    {
        wait( 3.5 + randomfloat( 3 ) );
        playfxontag( common_scripts\utility::getfx( "scuba_bubbles_friendly" ), self.scuba_org, "tag_origin" );
    }
}

friendly_bubbles_stop()
{
    self notify( "stop_friendly_bubbles" );
    self.scuba_org delete();
}

friendly_bubbles_cleanup_on_death()
{
    common_scripts\utility::waittill_either( "death", "stop_friendly_bubbles" );
    self.scuba_org delete();
}

friendly_bubbles_cleanup()
{
    self endon( "death" );
    self waittillmatch( "single anim", "surfacing" );
    self notify( "stop_friendly_bubbles" );
}

underwater_hud_enable( var_0 )
{
    wait 0.05;

    if ( var_0 == 1 )
    {
        setsaveddvar( "hud_showStance", "0" );
        setsaveddvar( "compass", "0" );
        setsaveddvar( "ammoCounterHide", "1" );
        setsaveddvar( "g_friendlyNameDist", 0 );
        setsaveddvar( "actionSlotsHide", 1 );
    }
    else
    {
        setsaveddvar( "hud_drawhud", "1" );
        setsaveddvar( "hud_showStance", "1" );
        setsaveddvar( "compass", "1" );
        setsaveddvar( "ammoCounterHide", "0" );
        setsaveddvar( "g_friendlyNameDist", 15000 );
        setsaveddvar( "actionSlotsHide", 0 );
    }
}

player_underwater_start( var_0 )
{
    if ( isdefined( var_0 ) && var_0 == 1 )
    {
        self.scuba_assisted = 1;
        player_scuba();
        player_scuba_mask();
    }
    else
    {
        self.scuba_assisted = 0;
        player_underwater_breath();
    }
}

player_underwater_end()
{
    if ( isdefined( self.scuba_assisted ) && self.scuba_assisted == 1 )
    {
        stop_player_scuba();
        player_scuba_mask_disable();
    }
    else
        stop_player_underwater_breath();
}

player_scuba()
{
    if ( !_func_145() )
        thread player_scuba_breathe_sound();
    else if ( self == level.player )
        thread player_scuba_breathe_sound();

    thread player_scuba_bubbles();
}

player_scuba_breathe_sound()
{
    self endon( "death" );
    self notify( "start_scuba_breathe" );
    self endon( "start_scuba_breathe" );
    self endon( "stop_scuba_breathe" );

    for (;;)
    {
        wait 0.05;
        self notify( "scuba_breathe_sound_starting" );
        self playlocalsound( "scuba_breathe_player", "scuba_breathe_sound_done" );
        self waittill( "scuba_breathe_sound_done" );
    }
}

stop_player_scuba()
{
    self notify( "stop_scuba_breathe" );
    self stoplocalsound( "scuba_breathe_player" );
}

player_scuba_bubbles()
{
    if ( getdvarint( "demo_mode" ) )
        return;

    self endon( "death" );
    self endon( "stop_scuba_breathe" );
    waittillframeend;
    self.playerfxorg = spawn( "script_model", self.origin + ( 0, 0, 0 ) );
    self.playerfxorg setmodel( "tag_origin" );
    self.playerfxorg.angles = self.angles;
    self.playerfxorg.origin = self geteye() - ( 0, 0, 10 );
    self.playerfxorg linktoplayerview( self, "tag_origin", ( 5, 0, -55 ), ( 0, 0, 0 ), 1 );
    thread scuba_fx_cleanup( self.playerfxorg );

    for (;;)
    {
        self waittill( "scuba_breathe_sound_starting" );
        wait 2.1;
        thread player_bubbles_fx( self.playerfxorg );

        if ( common_scripts\utility::cointoss() )
            self waittill( "scuba_breathe_sound_starting" );
    }
}

scuba_fx_cleanup( var_0 )
{
    self waittill( "stop_scuba_breathe" );
    killfxontag( common_scripts\utility::getfx( "scuba_bubbles" ), var_0, "TAG_ORIGIN" );
    var_0 unlinkfromplayerview( self );
    var_0 delete();
}

player_bubbles_fx( var_0 )
{
    self endon( "stop_scuba_breathe" );
    playfxontag( common_scripts\utility::getfx( "scuba_bubbles" ), var_0, "TAG_ORIGIN" );
}

player_scuba_mask( var_0, var_1 )
{
    if ( getdvarint( "sg_scuba_mask_off" ) == 1 )
        return;

    if ( getdvarint( "demo_mode" ) )
        return;

    var_2 = "halo_overlay_scuba";

    if ( isdefined( var_1 ) )
        var_2 = var_1;

    self.hud_scubamask = maps\_hud_util::create_client_overlay( var_2, 1, self );
    self.hud_scubamask.foreground = 0;
    self.hud_scubamask.sort = -99;
    self.scubamask_distortion = spawn( "script_model", level.player.origin );
    self.scubamask_distortion setmodel( "tag_origin" );
    self.scubamask_distortion.origin = self.origin;
    self.scubamask_distortion linktoplayerview( self, "tag_origin", ( 10, 0, 0 ), ( 0, 180, 0 ), 1 );
    playfxontag( common_scripts\utility::getfx( "scuba_mask_distortion" ), self.scubamask_distortion, "tag_origin" );
    self.hud_scubamask_model = spawn( "script_model", level.player geteye() );
    self.hud_scubamask_model setmodel( "shpg_udt_headgear_player_a" );
    self.hud_scubamask_model linktoplayerview( self, "tag_origin", ( -0.3, 0, -1.2 ), ( 0, 90, -4 ), 1 );

    if ( getdvarint( "demo_mode" ) )
    {
        self.hud_scubamask_model delete();
        stopfxontag( common_scripts\utility::getfx( "scuba_mask_distortion" ), self.scubamask_distortion, "tag_origin" );
    }
}

player_scuba_mask_disable( var_0 )
{
    if ( getdvarint( "sg_scuba_mask_off" ) == 1 )
        return;

    if ( getdvarint( "demo_mode" ) )
        return;

    if ( isdefined( self.hud_scubamask ) )
    {
        self.hud_scubamask maps\_hud_util::destroyelem();
        self.scubamask_distortion unlinkfromplayerview( self );
        self.scubamask_distortion delete();
        self.hud_scubamask_model unlinkfromplayerview( self );
        self.hud_scubamask_model delete();
    }
}

player_underwater_breath()
{
    set_default_breath_values();
    self.is_drowning = 0;
    thread handle_player_breath();
}

stop_player_underwater_breath()
{
    self notify( "stop_freeswim_breathe" );
    self.is_drowning = 0;
}

set_default_breath_values()
{
    if ( !isdefined( level.player_breath_amount_use_rate ) )
        level.player_breath_amount_use_rate = 6.66667;

    if ( !isdefined( level.player_breath_amount_fill_rate ) )
        level.player_breath_amount_fill_rate = 50.0;
}

override_breath_values( var_0, var_1 )
{
    level.player_breath_amount_use_rate = 100 / var_0;
    level.player_breath_amount_fill_rate = 100 / var_1;
}

handle_player_breath()
{
    self endon( "death" );
    self notify( "handle_player_breath" );
    self endon( "handle_player_breath" );

    if ( !isdefined( self.player_breath_amount ) )
        self.player_breath_amount = 100;

    var_0 = gettime();
    var_1 = var_0;
    self.player_breath_fulltime = 0;

    if ( !isdefined( self.no_breath_hud ) || !self.no_breath_hud )
        thread player_breath_hud();

    for (;;)
    {
        var_0 = gettime();
        var_2 = ( var_0 - var_1 ) / 1000.0;

        if ( isdefined( self.underwater ) && self.underwater )
            self.player_breath_amount = max( self.player_breath_amount - level.player_breath_amount_use_rate * var_2, 0 );
        else
            self.player_breath_amount = min( self.player_breath_amount + level.player_breath_amount_fill_rate * var_2, 100 );

        if ( self.player_breath_amount <= 0 )
            thread player_drowning_damage_thread();
        else
            self notify( "stop_drowning" );

        var_1 = var_0;

        if ( self.player_breath_amount == 100 )
            self.player_breath_fulltime += 0.05;
        else
            self.player_breath_fulltime = 0;

        if ( self.player_breath_fulltime >= 1.0 )
            break;

        wait 0.05;
    }
}

player_breath_hud()
{
    self endon( "death" );
    self notify( "player_breath_hud" );
    self endon( "player_breath_hud" );
    var_0 = 0.5;
    var_1 = 100;

    if ( !isdefined( level.player_breath_elem ) )
    {
        level.player_breath_elem = level.player maps\_hud_util::createclientprogressbar( level.player, 60, "white", "black", 100, 10 );
        level.player_breath_elem maps\_hud_util::setpoint( "RIGHT", undefined, -65, var_1 + 12 );
        level.player_breath_elem maps\_hud_util::updatebar( 1 );
        level.player_breath_elem.alpha = var_0;
        level.player_breath_elem.bar.alpha = var_0;
        level.player_breath_elem.bar.color = ( 0, 0, 1 );
        level.player_breath_elem.text = level.player maps\_hud_util::createclientfontstring( "default", 1.2 );
        level.player_breath_elem.text maps\_hud_util::setpoint( "RIGHT", undefined, -60, var_1 );
        level.player_breath_elem.text settext( "O2" );
        level.player_breath_elem.text.alpha = var_0;
    }

    wait 0.05;

    while ( self.player_breath_amount <= 100 )
    {
        var_2 = self.player_breath_amount / 100;
        level.player_breath_elem maps\_hud_util::updatebar( var_2 );

        if ( self.player_breath_fulltime >= 1.0 )
            break;

        level.player_breath_elem.alpha = var_0;
        level.player_breath_elem.bar.alpha = var_0;
        level.player_breath_elem.text.alpha = var_0;
        wait 0.05;
    }

    if ( isdefined( level.player_breath_elem ) )
    {
        var_3 = gettime();
        var_4 = 500.0;

        while ( gettime() - var_3 < var_4 && isdefined( level.player_breath_elem ) )
        {
            var_5 = 1.0 - float( gettime() - var_3 ) / var_4;
            level.player_breath_elem.alpha = var_0 * var_5;
            level.player_breath_elem.bar.alpha = var_0 * var_5;
            level.player_breath_elem.text.alpha = var_0 * var_5;
            wait 0.05;
        }

        level.player_breath_elem.text maps\_hud_util::destroyelem();
        level.player_breath_elem maps\_hud_util::destroyelem();
        level.player_breath_hud = undefined;
    }
}

player_drowning_damage_thread()
{
    self endon( "death" );
    self endon( "stop_freeswim_breathe" );
    self endon( "stop_drowning" );

    if ( self.is_drowning )
        return;

    self.is_drowning = 1;
    var_0 = common_scripts\utility::spawn_tag_origin();
    var_0 linktoplayerview( level.player, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ), 1 );
    soundscripts\_snd::snd_message( "player_drowning_start" );

    if ( self == level.player && isdefined( self.drowning_warning ) )
    {
        thread maps\_utility_code::hintprint( self.drowning_warning, undefined, undefined, undefined, undefined, 20, undefined, undefined );
        self.drowning_warning = undefined;
    }

    thread end_drowning_damage( var_0 );

    for (;;)
    {
        if ( isdefined( self.drowning_damage ) )
            self dodamage( self.drowning_damage, self.origin );
        else
            self dodamage( 25, self.origin );

        playfxontag( common_scripts\utility::getfx( "water_vm_gasping_breath" ), var_0, "tag_origin" );
        wait 0.5;
    }
}

end_drowning_damage( var_0 )
{
    self endon( "death" );
    self endon( "stop_freeswim_breathe" );
    self waittill( "stop_drowning" );
    var_0 delete();
    self.is_drowning = 0;
}

parse_underwater_triggers()
{
    level.underwater_triggers = getentarray( "trigger_underwater", "targetname" );
}
