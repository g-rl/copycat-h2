// H2 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

addtosystem( var_0 )
{
    self endon( "death" );

    if ( !animscripts\battlechatter::bcsenabled() )
        return;

    if ( self.chatinitialized )
        return;

    if ( !isdefined( self.squad.chatinitialized ) || !self.squad.chatinitialized )
        self.squad animscripts\battlechatter::init_squadbattlechatter();

    self.enemyclass = "infantry";
    self.calledout = [];

    if ( isplayer( self ) )
    {
        self.battlechatter = 0;
        self.flavorbursts = 0;
        self.type = "human";
        return;
    }

    if ( self.type == "dog" )
    {
        self.enemyclass = undefined;
        self.battlechatter = 0;
        self.flavorbursts = 0;
        return;
    }

    if ( self.team == "neutral" )
    {
        self.enemyclass = undefined;
        self.battlechatter = 0;
        self.flavorbursts = 0;
        return;
    }

    if ( forceenglish() )
    {
        if ( self.team == "allies" )
            self.script_battlechatter = 0;
        else
            self.voice = "american";
    }

    if ( self.voice == "multilingual" )
    {
        var_1 = "russian";
        self.countryid = anim.countryids[var_1];
        self.voice = var_1;
    }
    else
        self.countryid = anim.countryids[self.voice];

    if ( isdefined( self.script_friendname ) )
    {
        var_2 = tolower( self.script_friendname );

        if ( issubstr( var_2, "price" ) )
            self.npcid = "pri";
        else if ( issubstr( var_2, "mactavish" ) || issubstr( var_2, "soap" ) )
            self.npcid = "mct";
        else if ( issubstr( var_2, "ghost" ) )
            self.npcid = "gst";
        else if ( issubstr( var_2, "dunn" ) )
            self.npcid = "cpd";
        else if ( issubstr( var_2, "foley" ) )
            self.npcid = "mcy";
        else
            setnpcid();
    }
    else
        setnpcid();

    thread ainameandrankwaiter();
    init_aibattlechatter();
    thread aithreadthreader();
}

forceenglish()
{
    if ( !getdvarint( "bcs_forceEnglish", 0 ) )
        return 0;

    switch ( level.script )
    {
        case "pmc_strike":
        case "co_strike":
        case "co_scoutsniper":
        case "co_launchfacility_a":
        case "co_crossfire":
        case "co_break":
        case "co_armada":
        case "so_ac130_co_hunted":
        case "co_hunted":
        case "sniperescape":
        case "scoutsniper":
        case "launchfacility_b":
        case "launchfacility_a":
        case "bog_b":
        case "bog_a":
        case "armada":
        case "airlift":
            return 1;
    }

    return 0;
}

aithreadthreader()
{
    self endon( "death" );
    self endon( "removed from battleChatter" );
    var_0 = 0.5;
    wait( var_0 );
    thread aigrenadedangerwaiter();
    thread aifolloworderwaiter();

    if ( self.team == "allies" )
    {
        wait( var_0 );
        thread aidisplacewaiter();
    }
    else if ( ( self.team == "axis" || self.team == "team3" ) && !isalliedcountryid( self.countryid ) )
        thread aihostileburstloop();

    if ( self.team == level.player.team )
        thread player_friendlyfire_waiter();

    wait( var_0 );
    thread aibattlechatterloop();
}

isalliedcountryid( var_0 )
{
    if ( var_0 == "UK" || var_0 == "US" || var_0 == "NS" || var_0 == "TF" || var_0 == "SS" )
        return 1;

    return 0;
}

setnpcid()
{
    var_0 = anim.usedids[self.voice];
    var_1 = var_0.size;
    var_2 = randomintrange( 0, var_1 );
    var_3 = var_2;

    for ( var_4 = 0; var_4 <= var_1; var_4++ )
    {
        if ( var_0[( var_2 + var_4 ) % var_1].count < var_0[var_3].count )
            var_3 = ( var_2 + var_4 ) % var_1;
    }

    thread npcidtracker( var_3 );
    self.npcid = var_0[var_3].npcid;
}

npcidtracker( var_0 )
{
    anim.usedids[self.voice][var_0].count++;
    self waittill( "death" );

    if ( !animscripts\battlechatter::bcsenabled() )
        return;

    anim.usedids[self.voice][var_0].count--;
}

aihostileburstloop()
{
    self endon( "death" );
    self endon( "removed from battleChatter" );

    for (;;)
    {
        if ( distance( self.origin, level.player.origin ) < 1024 )
        {
            if ( isdefined( self.squad.membercount ) && self.squad.membercount > 1 )
                addreactionevent( "taunt", "hostileburst" );
        }

        wait( randomfloatrange( 2, 5 ) );
    }
}

aibattlechatterloop()
{
    self endon( "death" );
    self endon( "removed from battleChatter" );

    for (;;)
    {
        animscripts\battlechatter::playbattlechatter();
        wait( 0.3 + randomfloat( 0.2 ) );
    }
}

ainameandrankwaiter()
{
    self endon( "death" );
    self endon( "removed from battleChatter" );

    for (;;)
    {
        self.bcname = animscripts\battlechatter::getname();
        self.bcrank = animscripts\battlechatter::getrank();
        self waittill( "set name and rank" );
    }
}

removefromsystem( var_0 )
{
    if ( !isalive( self ) && animscripts\battlechatter::bcsenabled() )
    {
        aideathfriendly();
        aideathenemy();
    }

    if ( isdefined( self ) )
    {
        self.battlechatter = 0;
        self.chatinitialized = 0;
    }

    self notify( "removed from battleChatter" );

    if ( isdefined( self ) )
    {
        self.chatqueue = undefined;
        self.nextsaytime = undefined;
        self.nextsaytimes = undefined;
        self.isspeaking = undefined;
        self.enemyclass = undefined;
        self.calledout = undefined;
        self.countryid = undefined;
        self.npcid = undefined;
    }
}

init_aibattlechatter()
{
    self.chatqueue = [];
    self.chatqueue["threat"] = spawnstruct();
    self.chatqueue["threat"].expiretime = 0;
    self.chatqueue["threat"].priority = 0.0;
    self.chatqueue["response"] = spawnstruct();
    self.chatqueue["response"].expiretime = 0;
    self.chatqueue["response"].priority = 0.0;
    self.chatqueue["reaction"] = spawnstruct();
    self.chatqueue["reaction"].expiretime = 0;
    self.chatqueue["reaction"].priority = 0.0;
    self.chatqueue["inform"] = spawnstruct();
    self.chatqueue["inform"].expiretime = 0;
    self.chatqueue["inform"].priority = 0.0;
    self.chatqueue["order"] = spawnstruct();
    self.chatqueue["order"].expiretime = 0;
    self.chatqueue["order"].priority = 0.0;
    self.chatqueue["custom"] = spawnstruct();
    self.chatqueue["custom"].expiretime = 0;
    self.chatqueue["custom"].priority = 0.0;
    self.nextsaytime = gettime() + 50;
    self.nextsaytimes["threat"] = 0;
    self.nextsaytimes["reaction"] = 0;
    self.nextsaytimes["response"] = 0;
    self.nextsaytimes["inform"] = 0;
    self.nextsaytimes["order"] = 0;
    self.nextsaytimes["custom"] = 0;
    self.isspeaking = 0;
    self.bcs_minpriority = 0.0;
    self.allowedcallouts = [];
    animscripts\battlechatter::addallowedthreatcallout( "rpg" );
    animscripts\battlechatter::addallowedthreatcallout( "exposed" );

    if ( self.voice != "shadowcompany" )
    {
        animscripts\battlechatter::addallowedthreatcallout( "ai_contact_clock" );
        animscripts\battlechatter::addallowedthreatcallout( "ai_target_clock" );
        animscripts\battlechatter::addallowedthreatcallout( "ai_cardinal" );
    }

    if ( self.team == "allies" )
    {
        animscripts\battlechatter::addallowedthreatcallout( "ai_yourclock" );
        animscripts\battlechatter::addallowedthreatcallout( "player_yourclock" );
        animscripts\battlechatter::addallowedthreatcallout( "player_contact_clock" );
        animscripts\battlechatter::addallowedthreatcallout( "player_target_clock" );
        animscripts\battlechatter::addallowedthreatcallout( "player_cardinal" );
        animscripts\battlechatter::addallowedthreatcallout( "player_obvious" );
        animscripts\battlechatter::addallowedthreatcallout( "player_object_yourclock" );
        animscripts\battlechatter::addallowedthreatcallout( "ai_object_yourclock" );
        animscripts\battlechatter::addallowedthreatcallout( "player_object_clock" );
        animscripts\battlechatter::addallowedthreatcallout( "player_location" );
        animscripts\battlechatter::addallowedthreatcallout( "ai_location" );
    }

    if ( isdefined( self.script_battlechatter ) && !self.script_battlechatter )
        self.battlechatter = 0;
    else
        self.battlechatter = level.battlechatter[self.team];

    if ( animscripts\battlechatter::voicecanburst() )
        self.flavorbursts = 1;
    else
        self.flavorbursts = 0;

    if ( level.friendlyfire_warnings )
        maps\_utility::set_friendlyfire_warnings( 1 );
    else
        maps\_utility::set_friendlyfire_warnings( 0 );

    self.chatinitialized = 1;
}

addthreatevent( var_0, var_1, var_2 )
{
    self endon( "death" );
    self endon( "removed from battleChatter" );

    if ( !animscripts\battlechatter::cansay( "threat", var_0, var_2 ) )
        return;

    if ( animscripts\battlechatter::threatwasalreadycalledout( var_1 ) && !isplayer( var_1 ) )
        return;

    var_3 = animscripts\battlechatter::createchatevent( "threat", var_0, var_2 );

    switch ( var_0 )
    {
        case "infantry":
            var_3.threat = var_1;
            break;
    }

    if ( isdefined( var_1.squad ) )
        self.squad animscripts\battlechatter::updatecontact( var_1.squad.squadname, self );

    self.chatqueue["threat"] = undefined;
    self.chatqueue["threat"] = var_3;
}

addresponseevent( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self endon( "death" );
    self endon( "removed from battleChatter" );
    thread addresponseevent_internal( var_0, var_1, var_2, var_3, var_4, var_5 );
}

addresponseevent_internal( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    self endon( "death" );
    self endon( "removed from battleChatter" );
    self endon( "responseEvent_failsafe" );
    thread responseevent_failsafe( var_2 );
    var_6 = var_2 common_scripts\utility::waittill_any_return( "death", "done speaking", "cancel speaking" );

    if ( var_6 == "cancel speaking" )
        return;

    if ( !isalive( var_2 ) )
        return;

    if ( !animscripts\battlechatter::cansay( "response", var_0, var_3, var_1 ) )
        return;

    if ( !isplayer( var_2 ) )
    {
        if ( animscripts\battlechatter::isusingsamevoice( var_2 ) )
            return;
    }

    var_7 = animscripts\battlechatter::createchatevent( "response", var_0, var_3 );

    if ( isdefined( var_4 ) )
        var_7.reportalias = var_4;

    if ( isdefined( var_5 ) )
        var_7.location = var_5;

    var_7.respondto = var_2;
    var_7.modifier = var_1;
    self.chatqueue["response"] = undefined;
    self.chatqueue["response"] = var_7;
}

responseevent_failsafe( var_0 )
{
    self endon( "death" );
    self endon( "removed from battleChatter" );
    var_0 endon( "death" );
    var_0 endon( "done speaking" );
    var_0 endon( "cancel speaking" );
    wait 25;
    self notify( "responseEvent_failsafe" );
}

addinformevent( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    self endon( "removed from battleChatter" );

    if ( !animscripts\battlechatter::cansay( "inform", var_0, var_3, var_1 ) )
        return;

    var_4 = animscripts\battlechatter::createchatevent( "inform", var_0, var_3 );

    switch ( var_0 )
    {
        case "reloading":
            var_4.modifier = var_1;
            var_4.informto = var_2;
            break;
        default:
            var_4.modifier = var_1;
    }

    self.chatqueue["inform"] = undefined;
    self.chatqueue["inform"] = var_4;
}

addreactionevent( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    self endon( "removed from battleChatter" );

    if ( !isdefined( self.chatqueue ) )
        return;

    var_4 = animscripts\battlechatter::createchatevent( "reaction", var_0, var_3 );
    var_4.reactto = var_2;
    var_4.modifier = var_1;
    self.chatqueue["reaction"] = undefined;
    self.chatqueue["reaction"] = var_4;
}

addorderevent( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    self endon( "removed from battleChatter" );

    if ( !animscripts\battlechatter::cansay( "order", var_0, var_3, var_1 ) )
        return;

    if ( isdefined( var_2 ) && var_2.type == "dog" )
        return;

    var_4 = animscripts\battlechatter::createchatevent( "order", var_0, var_3 );
    var_4.modifier = var_1;
    var_4.orderto = var_2;
    self.chatqueue["order"] = undefined;
    self.chatqueue["order"] = var_4;
}

squadofficerwaiter()
{
    anim endon( "battlechatter disabled" );
    anim endon( "squad deleted " + self.squadname );

    for (;;)
    {
        var_0 = undefined;

        if ( self.officers.size )
            var_1 = self.officers;
        else
            var_1 = self.members;

        var_2 = [];

        for ( var_3 = 0; var_3 < var_1.size; var_3++ )
        {
            if ( isalive( var_1[var_3] ) )
                var_2[var_2.size] = var_1[var_3];
        }

        if ( var_2.size )
        {
            var_0 = common_scripts\utility::getclosest( level.player.origin, var_2 );
            var_0 aiofficerorders();
            var_0 waittill( "death" );
        }

        wait 3.0;
    }
}

_id_ADF2( var_0 )
{
    var_1 = [];

    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
    {
        if ( !isdefined( var_0[var_2].enemyclass ) )
            continue;

        if ( !threatisviable( var_0[var_2] ) )
            continue;

        var_0[var_2]._id_BC92 = var_1.size;
        var_1[var_1.size] = var_0[var_2];
    }

    var_1 = common_scripts\utility::get_array_of_closest( level.player.origin, var_1 );
    var_3 = [];
    var_4 = [];

    foreach ( var_6 in var_1 )
    {
        var_7 = var_6 animscripts\battlechatter::getlocation();

        if ( isdefined( var_7 ) && !animscripts\battlechatter::location_called_out_recently( var_7 ) )
        {
            var_3[var_3.size] = var_6;
            continue;
        }

        var_4[var_4.size] = var_6;
    }

    var_1 = common_scripts\utility::array_combine( var_3, var_4 );
    return var_1;
}

threatisviable( var_0 )
{
    if ( !level.player animscripts\battlechatter::entinfrontarc( var_0 ) )
        return 0;

    var_1 = level._id_BA7A * level._id_BA7A;

    if ( distancesquared( level.player.origin, var_0.origin ) > var_1 )
        return 0;

    return 1;
}

squadthreatwaiter()
{
    anim endon( "battlechatter disabled" );
    anim endon( "squad deleted " + self.squadname );

    for (;;)
    {
        wait( randomfloatrange( 0.25, 0.75 ) );

        if ( self.team == "allies" )
            var_0 = _id_ADF2( getaiarray( "axis", "team3" ) );
        else if ( self.team == "team3" )
            var_0 = _id_ADF2( getaiarray( "allies", "axis" ) );
        else
        {
            var_0 = getaiarray( "allies", "team3" );
            var_0[var_0.size] = level.player;
        }

        if ( !var_0.size )
            continue;

        var_1 = [];

        foreach ( var_7, var_3 in self.members )
        {
            if ( !isalive( var_3 ) )
                continue;

            if ( !var_0.size )
            {
                var_0 = var_1;
                var_1 = [];
            }

            foreach ( var_6, var_5 in var_0 )
            {
                if ( isdefined( level.battlechattermaxcanseeperframe ) && level.battlechattermaxcanseeperframe > 0 && var_6 > 0 && var_6 % level.battlechattermaxcanseeperframe == 0 )
                {
                    waitframe();

                    if ( !isalive( var_3 ) )
                        break;
                }

                if ( !isdefined( var_5 ) )
                {
                    if ( var_6 == 0 )
                        var_0 = [];

                    continue;
                }

                if ( !isalive( var_5 ) )
                    continue;

                if ( !var_3 cansee( var_5 ) )
                {
                    if ( isplayer( var_5 ) )
                        continue;

                    if ( var_5.team == level.player.team )
                        continue;

                    if ( !maps\_utility::player_can_see_ai( var_5 ) )
                        continue;
                }

                var_3 addthreatevent( var_5.enemyclass, var_5 );
                var_1[var_1.size] = var_5;
                var_0 = common_scripts\utility::array_remove( var_0, var_5 );
                break;
            }

            wait 0.05;
        }
    }
}

aideathfriendly()
{
    var_0 = self.attacker;
    common_scripts\utility::array_thread( self.squad.members, ::aideatheventthread );

    if ( isalive( var_0 ) && issentient( var_0 ) && isdefined( var_0.squad ) && var_0.battlechatter )
    {
        if ( isdefined( var_0.calledout[var_0.squad.squadname] ) )
            var_0.calledout[var_0.squad.squadname] = undefined;

        if ( !isdefined( var_0.enemyclass ) )
            return;

        if ( !var_0 animscripts\battlechatter::is_in_callable_location() )
            return;

        foreach ( var_2 in self.squad.members )
        {
            if ( gettime() > var_2.lastenemysighttime + 2000 )
                continue;

            var_2 addthreatevent( var_0.enemyclass, var_0 );
        }
    }
}

aideatheventthread()
{
    if ( !isalive( self ) )
        return;

    self endon( "death" );
    self endon( "removed from battleChatter" );
    wait 1.5;
    addreactionevent( "casualty", "generic", self, 0.9 );
}

aideathenemy()
{
    var_0 = self.attacker;

    if ( !isalive( var_0 ) || !issentient( var_0 ) || !isdefined( var_0.squad ) )
        return;

    if ( !isdefined( var_0.countryid ) || var_0.countryid != "NS" )
        return;

    if ( !isplayer( var_0 ) )
        var_0 thread aikilleventthread();
}

aikilleventthread()
{
    self endon( "death" );
    self endon( "removed from battleChatter" );
    wait 1.5;
    addinformevent( "killfirm", "generic" );
}

aiofficerorders()
{
    self endon( "death" );
    self endon( "removed from battleChatter" );

    if ( !isdefined( self.squad.chatinitialized ) )
        self.squad waittill( "squad chat initialized" );

    for (;;)
    {
        if ( getdvar( "bcs_enable", "on" ) == "off" )
        {
            wait 1.0;
            continue;
        }

        addsituationalorder();
        wait( randomfloatrange( 3.0, 6.0 ) );
    }
}

aigrenadedangerwaiter()
{
    self endon( "death" );
    self endon( "removed from battleChatter" );

    for (;;)
    {
        self waittill( "grenade danger", var_0 );

        if ( getdvar( "bcs_enable", "on" ) == "off" )
            continue;

        if ( !isdefined( var_0 ) || var_0.model != "projectile_m67fraggrenade" )
            continue;

        if ( distance( var_0.origin, level.player.origin ) < 512 )
            addinformevent( "incoming", "grenade" );
    }
}

aidisplacewaiter()
{
    self endon( "death" );
    self endon( "removed from battleChatter" );

    for (;;)
    {
        self waittill( "trigger" );

        if ( getdvar( "bcs_enable", "on" ) == "off" )
            continue;

        if ( gettime() < self.a.paintime + 4000 )
            continue;

        addresponseevent( "ack", "yes", level.player, 1.0 );
    }
}

evaluatemoveevent( var_0 )
{
    self endon( "death" );
    self endon( "removed from battleChatter" );

    if ( !animscripts\battlechatter::bcsenabled() )
        return;

    if ( !isdefined( self.node ) )
        return;

    var_1 = distance( self.origin, self.node.origin );

    if ( var_1 < 512 )
        return;

    if ( !animscripts\battlechatter::isnodecoverorconceal() )
        return;

    if ( !nationalityokformoveorder() )
        return;

    var_2 = animscripts\battlechatter::getresponder( 24, 1024, "response" );

    if ( self.team != "axis" && self.team != "team3" )
    {
        if ( !isdefined( var_2 ) )
            var_2 = level.player;
        else if ( randomint( 100 ) < anim.eventchance["moveEvent"]["ordertoplayer"] )
            var_2 = level.player;
    }

    if ( self.combattime > 0.0 )
    {
        if ( randomint( 100 ) < anim.eventchance["moveEvent"]["coverme"] )
            addorderevent( "action", "coverme", var_2 );
        else
            addorderevent( "move", "combat", var_2 );
    }
    else if ( nationalityokformoveordernoncombat() )
        addorderevent( "move", "noncombat", var_2 );
}

nationalityokformoveorder()
{
    if ( self.countryid == "SS" )
        return 0;

    return 1;
}

nationalityokformoveordernoncombat()
{
    if ( self.countryid == "US" )
        return 1;

    return 0;
}

aifolloworderwaiter()
{
    self endon( "death" );
    self endon( "removed from battleChatter" );

    for (;;)
    {
        level waittill( "follow order", var_0 );

        if ( !animscripts\battlechatter::bcsenabled() )
            return;

        if ( var_0.team != self.team )
            continue;

        if ( distance( self.origin, var_0.origin ) < 600 )
            addresponseevent( "ack", "yes", var_0, 0.9 );
    }
}

player_friendlyfire_waiter()
{
    self endon( "death" );
    self endon( "removed from battleChatter" );
    thread player_friendlyfire_waiter_damage();

    for (;;)
    {
        self waittill( "bulletwhizby", var_0, var_1 );

        if ( !animscripts\battlechatter::bcsenabled() )
            continue;

        if ( !isplayer( var_0 ) )
            continue;

        if ( friendlyfire_whizby_distances_valid( var_0, var_1 ) )
        {
            player_friendlyfire_addreactionevent();
            wait 3;
        }
    }
}

player_friendlyfire_addreactionevent()
{
    addreactionevent( "friendlyfire", undefined, level.player, 1.0 );
}

player_friendlyfire_waiter_damage()
{
    self endon( "death" );
    self endon( "removed from battleChatter" );

    for (;;)
    {
        self waittill( "damage", var_0, var_1, var_2, var_3, var_4 );

        if ( isdefined( var_1 ) && isplayer( var_1 ) )
        {
            if ( damage_is_valid_for_friendlyfire_warning( var_4 ) )
                player_friendlyfire_addreactionevent();
        }
    }
}

damage_is_valid_for_friendlyfire_warning( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    switch ( var_0 )
    {
        case "MOD_IMPACT":
        case "MOD_MELEE":
        case "MOD_CRUSH":
        case "MOD_GRENADE_SPLASH":
        case "MOD_GRENADE":
            return 0;
    }

    return 1;
}

friendlyfire_whizby_distances_valid( var_0, var_1 )
{
    var_2 = 65536;
    var_3 = 42;

    if ( distancesquared( var_0.origin, self.origin ) < var_2 )
        return 0;

    if ( var_1 > var_3 )
        return 0;

    return 1;
}

evaluatereloadevent()
{
    self endon( "death" );
    self endon( "removed from battleChatter" );

    if ( !animscripts\battlechatter::bcsenabled() )
        return;

    addinformevent( "reloading", "generic" );
}

evaluatemeleeevent()
{
    self endon( "death" );
    self endon( "removed from battleChatter" );

    if ( !animscripts\battlechatter::bcsenabled() )
        return 0;

    if ( !isdefined( self.enemy ) )
        return 0;

    return 0;
}

evaluatefiringevent()
{
    self endon( "death" );
    self endon( "removed from battleChatter" );

    if ( !animscripts\battlechatter::bcsenabled() )
        return;

    if ( !isdefined( self.enemy ) )
        return;
}

evaluatesuppressionevent()
{
    self endon( "death" );
    self endon( "removed from battleChatter" );

    if ( !animscripts\battlechatter::bcsenabled() )
        return;

    if ( !self.suppressed )
        return;

    addinformevent( "suppressed", "generic" );
}

evaluateattackevent( var_0 )
{
    self endon( "death" );
    self endon( "removed from battleChatter" );

    if ( !animscripts\battlechatter::bcsenabled() )
        return;

    addinformevent( "attack", "grenade" );
}

addsituationalorder()
{
    self endon( "death" );
    self endon( "removed from battleChatter" );

    if ( self.squad.squadstates["combat"].isactive )
        addsituationalcombatorder();
}

addsituationalcombatorder()
{
    self endon( "death" );
    self endon( "removed from battleChatter" );
    var_0 = self.squad;
    var_0 animscripts\squadmanager::updatestates();

    if ( var_0.squadstates["suppressed"].isactive )
    {
        if ( var_0.squadstates["cover"].isactive )
        {
            var_1 = animscripts\battlechatter::getresponder( 96, 512, "response" );
            addorderevent( "action", "grenade", var_1 );
        }
        else
            addorderevent( "displace", "generic" );
    }
    else if ( var_0.squadstates["combat"].isactive )
    {
        if ( self.countryid != "SS" )
        {
            var_1 = animscripts\battlechatter::getresponder( 24, 1024, "response" );
            addorderevent( "action", "suppress", var_1 );
        }
    }
}

custom_battlechatter_init_valid_phrases()
{
    var_0 = [];
    var_0[var_0.size] = "order_move_combat";
    var_0[var_0.size] = "order_move_noncombat";
    var_0[var_0.size] = "order_action_coverme";
    var_0[var_0.size] = "inform_reloading";
    level.custombcs_validphrases = var_0;
}

custom_battlechatter_validate_phrase( var_0 )
{
    var_1 = 0;

    foreach ( var_3 in level.custombcs_validphrases )
    {
        if ( var_3 == var_0 )
        {
            var_1 = 1;
            break;
        }
    }

    return var_1;
}

custom_battlechatter_internal( var_0 )
{
    if ( !isdefined( level.custombcs_validphrases ) )
        custom_battlechatter_init_valid_phrases();

    var_0 = tolower( var_0 );
    var_1 = anim.bcprintfailprefix + "custom battlechatter phrase '" + var_0 + "' isn't valid.  look at _utility::custom_battlechatter_init_valid_phrases(), or the util script documentation for custom_battlechatter(), for a list of valid phrases.";
    var_2 = anim.bcprintfailprefix + "AI at origin " + self.origin + "wasn't able to play custom battlechatter because his nationality is '" + self.countryid + "'.";

    if ( !custom_battlechatter_validate_phrase( var_0 ) )
        return 0;

    var_3 = animscripts\battlechatter::getresponder( 24, 512, "response" );
    begincustomevent();

    switch ( var_0 )
    {
        case "order_move_combat":
            if ( !nationalityokformoveorder() )
                return 0;

            animscripts\battlechatter::tryorderto( self.customchatphrase, var_3 );
            addmovecombataliasex();
            break;
        case "order_move_noncombat":
            if ( !nationalityokformoveordernoncombat() )
                return 0;

            addmovenoncombataliasex();
            break;
        case "order_action_coverme":
            animscripts\battlechatter::tryorderto( self.customchatphrase, var_3 );
            addactioncovermealiasex();
            break;
        case "inform_reloading":
            addinformreloadingaliasex();
            break;
        default:
            return 0;
    }

    endcustomevent( 2000 );
    return 1;
}

begincustomevent()
{
    if ( !animscripts\battlechatter::bcsenabled() )
        return;

    self.customchatphrase = animscripts\battlechatter::createchatphrase();
}

addactioncovermealiasex()
{
    self.customchatphrase animscripts\battlechatter::addorderalias( "action", "coverme" );
}

addmovecombataliasex()
{
    self.customchatphrase animscripts\battlechatter::addorderalias( "move", "combat" );
}

addmovenoncombataliasex()
{
    self.customchatphrase animscripts\battlechatter::addorderalias( "move", "noncombat" );
}

addinformreloadingaliasex()
{
    self.customchatphrase animscripts\battlechatter::addinformalias( "reloading", "generic" );
}

addnamealiasex( var_0 )
{
    if ( !animscripts\battlechatter::bcsenabled() )
        return;

    self.customchatphrase animscripts\battlechatter::addnamealias( var_0 );
}

endcustomevent( var_0, var_1 )
{
    if ( !animscripts\battlechatter::bcsenabled() )
        return;

    var_2 = animscripts\battlechatter::createchatevent( "custom", "generic", 1.0 );

    if ( isdefined( var_0 ) )
        var_2.expiretime = gettime() + var_0;

    if ( isdefined( var_1 ) )
        var_2.type = var_1;
    else
        var_2.type = "custom";

    self.chatqueue["custom"] = undefined;
    self.chatqueue["custom"] = var_2;
}
