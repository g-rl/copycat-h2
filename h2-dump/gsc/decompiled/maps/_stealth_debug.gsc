// H2 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    thread main_thread();
}

main_thread()
{

}

render_detect_ranges()
{
    var_0 = getaiarray( "allies" );

    foreach ( var_2 in var_0 )
        var_2 render_detect_ranges_for_entity();

    level.player render_detect_ranges_for_entity();
    var_4 = getaiarray( "bad_guys" );

    foreach ( var_2 in var_4 )
        var_2 render_vision_cone_for_entity();
}

render_vision_cone_for_entity()
{
    if ( !isdefined( self._stealth ) )
        return;

    var_0 = self.angles;
    var_1 = self geteye() + ( 0, 0, -70 );
    var_2 = acos( self.fovcosine );
    render_vision_cone( var_1, var_0, var_2, ( 0, 1, 0 ) );
}

render_vision_cone( var_0, var_1, var_2, var_3 )
{
    var_4 = anglestoforward( var_1 + ( 0, var_2, 0 ) );
    var_5 = anglestoforward( var_1 + ( 0, var_2 * -1, 0 ) );
}

render_detect_ranges_for_entity()
{
    if ( !isdefined( self._stealth ) )
        return;

    var_0 = maps\_stealth_visibility_friendly::friendly_get_stance();
    var_1 = level._stealth.logic.detection_level;

    foreach ( var_5, var_3 in level._stealth.logic.detect_range[var_1] )
    {
        if ( self [[ self._stealth.logic.getinshadow_func ]]() )
            var_3 *= 0.5;

        var_4 = get_debug_element_color( var_5 );
        maps\_utility::draw_circle_for_time( self.origin, var_3, var_4[0], var_4[1], var_4[2], 0.05 );

        if ( var_5 == var_0 )
        {
            maps\_utility::draw_circle_for_time( self.origin, var_3 - 2, 0.6, 0.6, 0, 0.05 );
            maps\_utility::draw_circle_for_time( self.origin, var_3 + 2, 0.6, 0.6, 0, 0.05 );
        }

        update_debug_element_data( var_5, var_3 );
    }
}

render_ranges_for_the_corpses()
{
    var_0 = getcorpsearray();

    foreach ( var_2 in var_0 )
        var_2 render_ranges_for_a_corpse();
}

render_ranges_for_a_corpse()
{
    if ( !isdefined( level._stealth ) )
        return;

    var_0 = sqrt( level._stealth.logic.corpse.found_distsqrd );
    var_1 = get_debug_element_color( "corpse_found" );
    update_debug_element_data( "corpse_found", var_0 );
    maps\_utility::draw_circle_for_time( self.origin, var_0, var_1[0], var_1[1], var_1[2], 0.05 );
    var_0 = sqrt( level._stealth.logic.corpse.found_dog_distsqrd );
    var_1 = get_debug_element_color( "corpse_dog_found" );
    update_debug_element_data( "corpse_dog_found", var_0 );
    maps\_utility::draw_circle_for_time( self.origin, var_0, var_1[0], var_1[1], var_1[2], 0.05 );
    var_0 = sqrt( level._stealth.logic.corpse.sight_distsqrd );
    var_1 = get_debug_element_color( "corpse_sight" );
    update_debug_element_data( "corpse_sight", var_0 );
    maps\_utility::draw_circle_for_time( self.origin, var_0, var_1[0], var_1[1], var_1[2], 0.05 );
    var_0 = sqrt( level._stealth.logic.corpse.detect_distsqrd );
    var_1 = get_debug_element_color( "corpse_detect" );
    update_debug_element_data( "corpse_detect", var_0 );
    maps\_utility::draw_circle_for_time( self.origin, var_0, var_1[0], var_1[1], var_1[2], 0.05 );
}

record_enemy_notification( var_0, var_1 )
{
    if ( !isdefined( level._stealth.debug.last_enemy_notification ) )
        level._stealth.debug.last_enemy_notification = spawnstruct();

    level._stealth.debug.last_enemy_notification.spotter = var_0;
    level._stealth.debug.last_enemy_notification.spotterviewpoint = var_0 geteye() + ( 0, 0, -70 );
    level._stealth.debug.last_enemy_notification.spotterangles = var_0.angles;
    level._stealth.debug.last_enemy_notification.spotterfov = acos( var_0.fovcosine );
    level._stealth.debug.last_enemy_notification.spottedstance = var_1 maps\_stealth_visibility_friendly::friendly_get_stance();
    level._stealth.debug.last_enemy_notification.spottedorigin = var_1.origin;
    level._stealth.debug.last_enemy_notification.spottedvisibledistance = var_1.maxvisibledist;
}

clear_alerted_info()
{
    level._stealth.debug.last_enemy_notification = undefined;
    level._stealth.debug.alertedinfo = undefined;
}

render_alerted_info()
{
    if ( !isdefined( level._stealth.debug.last_enemy_notification ) )
        return;

    var_0 = level._stealth.debug.last_enemy_notification;
    var_1 = ( 0.9, 0, 0.2 );
    var_2 = "Spotter";

    if ( isdefined( level._stealth.debug.alertedinfo ) )
        var_2 = var_2 + " ai_event: " + level._stealth.debug.alertedinfo.eventtype;

    if ( isdefined( var_0.spottedstance ) )
    {

    }

    render_vision_cone( var_0.spotterviewpoint, var_0.spotterangles, var_0.spotterfov, ( 0, 1, 0 ) );

    if ( isdefined( var_0.spotter ) )
    {

    }

    if ( isdefined( level._stealth.debug.alertedinfo ) && isdefined( level._stealth.logic.ai_event[level._stealth.debug.alertedinfo.eventtype] ) )
        maps\_utility::draw_circle_for_time( var_0.spottedorigin, level._stealth.logic.ai_event[level._stealth.debug.alertedinfo.eventtype]["hidden"], var_1[0], var_1[1], var_1[2], 0.05 );
    else
        maps\_utility::draw_circle_for_time( var_0.spottedorigin, var_0.spottedvisibledistance, var_1[0], var_1[1], var_1[2], 0.05 );
}

record_stealth_event( var_0, var_1 )
{
    if ( !isdefined( level._stealth.debug.alertedinfo ) )
        level._stealth.debug.alertedinfo = spawnstruct();

    level._stealth.debug.alertedinfo.alertedentity = var_0;
    level._stealth.debug.alertedinfo.eventtype = var_1;
}

add_debug_element( var_0, var_1, var_2 )
{
    if ( !isdefined( level._stealth.debug ) )
    {
        level._stealth.debug = spawnstruct();
        level._stealth.debug.debug_elements = [];
    }

    var_3 = spawnstruct();
    var_3.text = var_1;
    var_3.color = var_2;
    var_3.data = -1;
    level._stealth.debug.debug_elements[var_0] = var_3;
}

update_debug_element_data( var_0, var_1 )
{
    if ( !isdefined( level._stealth.debug ) )
        return;

    level._stealth.debug.debug_elements[var_0].data = var_1;
}

get_debug_element_color( var_0 )
{
    if ( !isdefined( level._stealth.debug ) )
        return ( 0, 0, 0 );

    return level._stealth.debug.debug_elements[var_0].color;
}

disable_stealth_debug_hud()
{
    if ( !isdefined( level._stealth.debug.hud ) )
        return;

    foreach ( var_1 in level._stealth.debug.hud )
        var_1 destroy();

    level._stealth.debug.hud = undefined;
}

initialize_stealth_debug_hud()
{
    if ( isdefined( level._stealth.debug.hud ) )
        return;

    level._stealth.debug.hud = [];

    for ( var_0 = 0; var_0 < level._stealth.debug.debug_elements.size; var_0++ )
    {
        level._stealth.debug.hud[var_0] = newhudelem();
        level._stealth.debug.hud[var_0].x = 0;
        level._stealth.debug.hud[var_0].y = 20 + var_0 * 12;
        level._stealth.debug.hud[var_0].alignx = "left";
        level._stealth.debug.hud[var_0].aligny = "top";
    }
}

update_stealth_debug_hud()
{
    initialize_stealth_debug_hud();

    if ( !isdefined( level._stealth.debug.debug_elements ) )
        return;

    var_0 = 0;

    foreach ( var_2 in level._stealth.debug.debug_elements )
    {
        level._stealth.debug.hud[var_0] settext( var_2.text + var_2.data );
        level._stealth.debug.hud[var_0].color = var_2.color;
        var_0++;
    }
}

last_known_position_monitor()
{
    self notify( "last_known_position_monitor" );
    self endon( "last_known_position_monitor" );
    self endon( "death" );
    var_0 = 0.1;
    var_1 = ( 0.9, 0, 0.2 );
    var_2 = 24.0;

    for (;;)
    {
        if ( isdefined( self._stealth ) && isdefined( self.enemy ) )
        {
            self._stealth.logic.last_known_enemy_pos = self lastknownpos( self.enemy );
            self._stealth.logic.last_known_enemy_reason = self _meth_844E( self.enemy );
        }

        if ( isdefined( self._stealth ) && isdefined( self._stealth.logic.last_known_enemy_pos ) )
        {
            maps\_utility::draw_circle_for_time( self._stealth.logic.last_known_enemy_pos, var_2, var_1[0], var_1[1], var_1[2], var_0 );

            if ( isdefined( self._stealth.logic.last_known_enemy_reason ) )
            {

            }
        }

        wait( var_0 );
    }
}

stealth_enemy_debug_monitor()
{
    self notify( "stealth_enemy_debug_monitor" );
    self endon( "stealth_enemy_debug_monitor" );
    self endon( "death" );

    for (;;)
    {
        if ( isdefined( self.alertlevel ) )
            var_0 = "Alert level: " + self.alertlevel;

        if ( isdefined( self._stealth.logic.threat_level ) )
            var_0 = "Threat level: " + self._stealth.logic.threat_level;

        wait 0.05;
    }
}

stealth_enemy_minimal_debug_monitor()
{
    self notify( "stealth_enemy_minimal_debug_monitor" );
    self endon( "stealth_enemy_minimal_debug_monitor" );
    self endon( "death" );

    for (;;)
    {
        var_0 = ".";

        if ( isdefined( self.alertlevel ) )
        {
            if ( self.alertlevel == "noncombat" )
            {

            }
            else if ( self.alertlevel == "alert" )
            {

            }
            else if ( self.alertlevel == "combat" )
            {

            }
        }

        wait 0.05;
    }
}
