// H2 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init_battlechatter()
{
    if ( isdefined( anim.chatinitialized ) && anim.chatinitialized )
        return;

    if ( getdvar( "bcs_enable" ) == "" )
        setdvar( "bcs_enable", "on" );

    if ( getdvar( "bcs_enable" ) == "off" )
    {
        anim.chatinitialized = 0;
        anim.player.chatinitialized = 0;
        return;
    }

    anim.chatinitialized = 1;
    anim.player.chatinitialized = 0;

    if ( getdvar( "bcs_filterThreat" ) == "" )
        setdvar( "bcs_filterThreat", "off" );

    if ( getdvar( "bcs_filterInform" ) == "" )
        setdvar( "bcs_filterInform", "off" );

    if ( getdvar( "bcs_filterOrder" ) == "" )
        setdvar( "bcs_filterOrder", "off" );

    if ( getdvar( "bcs_filterReaction" ) == "" )
        setdvar( "bcs_filterReaction", "off" );

    if ( getdvar( "bcs_filterResponse" ) == "" )
        setdvar( "bcs_filterResponse", "off" );

    if ( getdvar( "bcs_threatLimitTargettedBySelf" ) == "" )
        setdvar( "bcs_threatLimitTargettedBySelf", "off" );

    if ( getdvar( "bcs_threatLimitTargetingPlayer" ) == "" )
        setdvar( "bcs_threatLimitTargetingPlayer", "off" );

    if ( getdvar( "bcs_threatLimitInPlayerFOV" ) == "" )
        setdvar( "bcs_threatLimitInPlayerFOV", "on" );

    if ( getdvar( "bcs_threatLimitInLocation" ) == "" )
        setdvar( "bcs_threatLimitInLocation", "on" );

    if ( getdvar( "bcs_threatLimitSpeakerDist" ) == "" )
        setdvar( "bcs_threatLimitSpeakerDist", "512" );

    if ( getdvar( "bcs_threatLimitThreatDist" ) == "" )
        setdvar( "bcs_threatLimitThreatDist", "2048" );

    if ( getdvar( "bcs_threatPlayerRelative" ) == "" )
        setdvar( "bcs_threatPlayerRelative", "off" );

    if ( getdvar( "debug_bcprint" ) == "" )
        setdvar( "debug_bcprint", "off" );

    if ( getdvar( "debug_bcshowqueue" ) == "" )
        setdvar( "debug_bcshowqueue", "off" );

    if ( getdvar( "debug_bcprintdump" ) == "" )
        setdvar( "debug_bcprintdump", "off" );

    anim.bcprintfailprefix = "^3***** BCS FAILURE: ";
    anim.bcprintwarnprefix = "^3***** BCS WARNING: ";
    bcs_setup_teams_array();
    bcs_setup_countryids();
    anim.playernameids["american"] = "1";
    anim.playernameids["seal"] = "1";
    anim.playernameids["taskforce"] = "1";
    anim.playernameids["secretservice"] = "1";
    thread setplayerbcnameid();
    anim.usedids = [];
    anim.usedids["russian"] = [];
    anim.usedids["russian"][0] = spawnstruct();
    anim.usedids["russian"][0].count = 0;
    anim.usedids["russian"][0].npcid = "0";
    anim.usedids["russian"][1] = spawnstruct();
    anim.usedids["russian"][1].count = 0;
    anim.usedids["russian"][1].npcid = "1";
    anim.usedids["russian"][2] = spawnstruct();
    anim.usedids["russian"][2].count = 0;
    anim.usedids["russian"][2].npcid = "2";
    anim.usedids["russian"][3] = spawnstruct();
    anim.usedids["russian"][3].count = 0;
    anim.usedids["russian"][3].npcid = "3";
    anim.usedids["russian"][4] = spawnstruct();
    anim.usedids["russian"][4].count = 0;
    anim.usedids["russian"][4].npcid = "4";
    anim.usedids["portuguese"] = [];
    anim.usedids["portuguese"][0] = spawnstruct();
    anim.usedids["portuguese"][0].count = 0;
    anim.usedids["portuguese"][0].npcid = "0";
    anim.usedids["portuguese"][1] = spawnstruct();
    anim.usedids["portuguese"][1].count = 0;
    anim.usedids["portuguese"][1].npcid = "1";
    anim.usedids["portuguese"][2] = spawnstruct();
    anim.usedids["portuguese"][2].count = 0;
    anim.usedids["portuguese"][2].npcid = "2";
    anim.usedids["shadowcompany"] = [];
    anim.usedids["shadowcompany"][0] = spawnstruct();
    anim.usedids["shadowcompany"][0].count = 0;
    anim.usedids["shadowcompany"][0].npcid = "0";
    anim.usedids["shadowcompany"][1] = spawnstruct();
    anim.usedids["shadowcompany"][1].count = 0;
    anim.usedids["shadowcompany"][1].npcid = "1";
    anim.usedids["shadowcompany"][2] = spawnstruct();
    anim.usedids["shadowcompany"][2].count = 0;
    anim.usedids["shadowcompany"][2].npcid = "2";
    anim.usedids["shadowcompany"][3] = spawnstruct();
    anim.usedids["shadowcompany"][3].count = 0;
    anim.usedids["shadowcompany"][3].npcid = "3";
    anim.usedids["british"] = [];
    anim.usedids["british"][0] = spawnstruct();
    anim.usedids["british"][0].count = 0;
    anim.usedids["british"][0].npcid = "0";
    anim.usedids["british"][1] = spawnstruct();
    anim.usedids["british"][1].count = 0;
    anim.usedids["british"][1].npcid = "1";
    anim.usedids["british"][2] = spawnstruct();
    anim.usedids["british"][2].count = 0;
    anim.usedids["british"][2].npcid = "2";
    anim.usedids["american"] = [];
    anim.usedids["american"][0] = spawnstruct();
    anim.usedids["american"][0].count = 0;
    anim.usedids["american"][0].npcid = "0";
    anim.usedids["american"][1] = spawnstruct();
    anim.usedids["american"][1].count = 0;
    anim.usedids["american"][1].npcid = "1";
    anim.usedids["american"][2] = spawnstruct();
    anim.usedids["american"][2].count = 0;
    anim.usedids["american"][2].npcid = "2";
    anim.usedids["american"][3] = spawnstruct();
    anim.usedids["american"][3].count = 0;
    anim.usedids["american"][3].npcid = "3";
    anim.usedids["american"][4] = spawnstruct();
    anim.usedids["american"][4].count = 0;
    anim.usedids["american"][4].npcid = "4";
    anim.usedids["seal"] = [];
    anim.usedids["seal"][0] = spawnstruct();
    anim.usedids["seal"][0].count = 0;
    anim.usedids["seal"][0].npcid = "0";
    anim.usedids["seal"][1] = spawnstruct();
    anim.usedids["seal"][1].count = 0;
    anim.usedids["seal"][1].npcid = "1";
    anim.usedids["seal"][2] = spawnstruct();
    anim.usedids["seal"][2].count = 0;
    anim.usedids["seal"][2].npcid = "2";
    anim.usedids["seal"][3] = spawnstruct();
    anim.usedids["seal"][3].count = 0;
    anim.usedids["seal"][3].npcid = "3";
    anim.usedids["taskforce"] = [];
    anim.usedids["taskforce"][0] = spawnstruct();
    anim.usedids["taskforce"][0].count = 0;
    anim.usedids["taskforce"][0].npcid = "0";
    anim.usedids["taskforce"][1] = spawnstruct();
    anim.usedids["taskforce"][1].count = 0;
    anim.usedids["taskforce"][1].npcid = "1";
    anim.usedids["taskforce"][2] = spawnstruct();
    anim.usedids["taskforce"][2].count = 0;
    anim.usedids["taskforce"][2].npcid = "2";
    anim.usedids["secretservice"] = [];
    anim.usedids["secretservice"][0] = spawnstruct();
    anim.usedids["secretservice"][0].count = 0;
    anim.usedids["secretservice"][0].npcid = "0";
    anim.usedids["secretservice"][1] = spawnstruct();
    anim.usedids["secretservice"][1].count = 0;
    anim.usedids["secretservice"][1].npcid = "1";
    anim.usedids["secretservice"][2] = spawnstruct();
    anim.usedids["secretservice"][2].count = 0;
    anim.usedids["secretservice"][2].npcid = "2";
    anim.usedids["secretservice"][3] = spawnstruct();
    anim.usedids["secretservice"][3].count = 0;
    anim.usedids["secretservice"][3].npcid = "3";
    anim.usedids["arab"] = [];
    anim.usedids["arab"][0] = spawnstruct();
    anim.usedids["arab"][0].count = 0;
    anim.usedids["arab"][0].npcid = "0";
    anim.usedids["arab"][1] = spawnstruct();
    anim.usedids["arab"][1].count = 0;
    anim.usedids["arab"][1].npcid = "1";
    anim.usedids["arab"][2] = spawnstruct();
    anim.usedids["arab"][2].count = 0;
    anim.usedids["arab"][2].npcid = "2";
    anim.usedids["german"] = [];
    anim.usedids["german"][0] = spawnstruct();
    anim.usedids["german"][0].count = 0;
    anim.usedids["german"][0].npcid = "0";
    anim.usedids["german"][1] = spawnstruct();
    anim.usedids["german"][1].count = 0;
    anim.usedids["german"][1].npcid = "1";
    anim.usedids["german"][2] = spawnstruct();
    anim.usedids["german"][2].count = 0;
    anim.usedids["german"][2].npcid = "2";
    anim.usedids["italian"] = [];
    anim.usedids["italian"][0] = spawnstruct();
    anim.usedids["italian"][0].count = 0;
    anim.usedids["italian"][0].npcid = "0";
    anim.usedids["italian"][1] = spawnstruct();
    anim.usedids["italian"][1].count = 0;
    anim.usedids["italian"][1].npcid = "1";
    anim.usedids["italian"][2] = spawnstruct();
    anim.usedids["italian"][2].count = 0;
    anim.usedids["italian"][2].npcid = "2";
    anim.usedids["spanish"] = [];
    anim.usedids["spanish"][0] = spawnstruct();
    anim.usedids["spanish"][0].count = 0;
    anim.usedids["spanish"][0].npcid = "0";
    anim.usedids["spanish"][1] = spawnstruct();
    anim.usedids["spanish"][1].count = 0;
    anim.usedids["spanish"][1].npcid = "1";
    anim.usedids["spanish"][2] = spawnstruct();
    anim.usedids["spanish"][2].count = 0;
    anim.usedids["spanish"][2].npcid = "2";
    init_flavorbursts();

    if ( !isdefined( level.friendlyfire_warnings ) )
        level.friendlyfire_warnings = 0;

    anim.eventtypeminwait = [];
    anim.eventtypeminwait["threat"] = [];
    anim.eventtypeminwait["response"] = [];
    anim.eventtypeminwait["reaction"] = [];
    anim.eventtypeminwait["order"] = [];
    anim.eventtypeminwait["inform"] = [];
    anim.eventtypeminwait["custom"] = [];
    anim.eventtypeminwait["direction"] = [];

    if ( isdefined( level._stealth ) )
    {
        anim.eventactionminwait["threat"]["self"] = 20000;
        anim.eventactionminwait["threat"]["squad"] = 30000;
    }
    else
    {
        anim.eventactionminwait["threat"]["self"] = 12500;
        anim.eventactionminwait["threat"]["squad"] = 8000;
    }

    anim.eventactionminwait["threat"]["location_repeat"] = 5000;
    anim.eventactionminwait["response"]["self"] = 1000;
    anim.eventactionminwait["response"]["squad"] = 1000;
    anim.eventactionminwait["reaction"]["self"] = 1000;
    anim.eventactionminwait["reaction"]["squad"] = 1000;
    anim.eventactionminwait["order"]["self"] = 8000;
    anim.eventactionminwait["order"]["squad"] = 40000;
    anim.eventactionminwait["inform"]["self"] = 6000;
    anim.eventactionminwait["inform"]["squad"] = 8000;
    anim.eventactionminwait["custom"]["self"] = 0;
    anim.eventactionminwait["custom"]["squad"] = 5000;
    anim.eventtypeminwait["playername"] = 15000;
    anim.eventtypeminwait["reaction"]["casualty"] = 20000;
    anim.eventtypeminwait["reaction"]["friendlyfire"] = 5000;
    anim.eventtypeminwait["reaction"]["taunt"] = 30000;
    anim.eventtypeminwait["inform"]["reloading"] = 20000;
    anim.eventtypeminwait["inform"]["killfirm"] = 15000;
    anim.eventpriority["threat"]["infantry"] = 0.5;
    anim.eventpriority["threat"]["vehicle"] = 0.7;
    anim.eventpriority["response"]["ack"] = 0.9;
    anim.eventpriority["response"]["exposed"] = 0.8;
    anim.eventpriority["response"]["callout"] = 0.9;
    anim.eventpriority["response"]["echo"] = 0.9;
    anim.eventpriority["reaction"]["casualty"] = 0.5;
    anim.eventpriority["reaction"]["friendlyfire"] = 1.0;
    anim.eventpriority["reaction"]["taunt"] = 0.9;
    anim.eventpriority["order"]["action"] = 0.3;
    anim.eventpriority["order"]["move"] = 0.3;
    anim.eventpriority["order"]["displace"] = 0.5;
    anim.eventpriority["inform"]["attack"] = 0.9;
    anim.eventpriority["inform"]["incoming"] = 0.9;
    anim.eventpriority["inform"]["reloading"] = 0.2;
    anim.eventpriority["inform"]["suppressed"] = 0.2;
    anim.eventpriority["inform"]["killfirm"] = 0.7;
    anim.eventpriority["custom"]["generic"] = 1.0;
    anim.eventduration["threat"]["infantry"] = 1000;
    anim.eventduration["threat"]["vehicle"] = 1000;
    anim.eventduration["response"]["exposed"] = 2000;
    anim.eventduration["response"]["callout"] = 2000;
    anim.eventduration["response"]["echo"] = 2000;
    anim.eventduration["response"]["ack"] = 1750;
    anim.eventduration["reaction"]["casualty"] = 2000;
    anim.eventduration["reaction"]["friendlyfire"] = 1000;
    anim.eventduration["reaction"]["taunt"] = 2000;
    anim.eventduration["order"]["action"] = 3000;
    anim.eventduration["order"]["move"] = 3000;
    anim.eventduration["order"]["displace"] = 3000;
    anim.eventduration["inform"]["attack"] = 1000;
    anim.eventduration["inform"]["incoming"] = 1500;
    anim.eventduration["inform"]["reloading"] = 1000;
    anim.eventduration["inform"]["suppressed"] = 2000;
    anim.eventduration["inform"]["killfirm"] = 2000;
    anim.eventduration["custom"]["generic"] = 1000;
    anim.eventchance["response"]["exposed"] = 75;
    anim.eventchance["response"]["reload"] = 65;
    anim.eventchance["response"]["callout"] = 75;
    anim.eventchance["response"]["callout_negative"] = 20;
    anim.eventchance["response"]["order"] = 40;
    anim.eventchance["moveEvent"]["coverme"] = 70;
    anim.eventchance["moveEvent"]["ordertoplayer"] = 10;
    anim.fbt_desireddistmax = 620;
    anim.fbt_waitmin = 12;
    anim.fbt_waitmax = 24;
    anim.fbt_linebreakmin = 2;
    anim.fbt_linebreakmax = 5;
    anim._id_C8FC = 0;
    anim.moveorigin = spawn( "script_origin", ( 0, 0, 0 ) );

    if ( !isdefined( level._id_B67E ) )
        level._id_B67E = 1500;

    if ( !isdefined( level._id_BA7A ) )
        level._id_BA7A = 2500;

    _id_C881::bcs_location_trigs_init();
    anim.locationlastcallouttimes = [];
    anim.scripteddialoguebuffertime = 4000;
    anim.bcs_threatresettime = 3000;
    anim.squadcreatefuncs[anim.squadcreatefuncs.size] = ::init_squadbattlechatter;
    anim.squadcreatestrings[anim.squadcreatestrings.size] = "::init_squadBattleChatter";

    foreach ( var_1 in anim.teams )
    {
        anim.isteamspeaking[var_1] = 0;
        anim.isteamsaying[var_1]["threat"] = 0;
        anim.isteamsaying[var_1]["order"] = 0;
        anim.isteamsaying[var_1]["reaction"] = 0;
        anim.isteamsaying[var_1]["response"] = 0;
        anim.isteamsaying[var_1]["inform"] = 0;
        anim.isteamsaying[var_1]["custom"] = 0;
    }

    bcs_setup_chatter_toggle_array();

    if ( !isdefined( anim.flavorburstvoices ) )
    {
        anim.flavorburstvoices = [];
        anim.flavorburstvoices["american"] = 1;
        anim.flavorburstvoices["shadowcompany"] = 1;
        anim.flavorburstvoices["seal"] = 0;
        anim.flavorburstvoices["taskforce"] = 0;
        anim.flavorburstvoices["secretservice"] = 0;
        anim.flavorburstvoices["british"] = 0;
    }

    bcs_setup_flavorburst_toggle_array();
    anim.lastteamspeaktime = [];
    anim.lastnamesaid = [];
    anim.lastnamesaidtime = [];

    foreach ( var_1 in anim.teams )
    {
        anim.lastteamspeaktime[var_1] = -50000;
        anim.lastnamesaid[var_1] = "none";
        anim.lastnamesaidtime[var_1] = -100000;
    }

    anim.lastnamesaidtimeout = 10000;

    for ( var_5 = 0; var_5 < anim.squadindex.size; var_5++ )
    {
        if ( isdefined( anim.squadindex[var_5].chatinitialized ) && anim.squadindex[var_5].chatinitialized )
            continue;

        anim.squadindex[var_5] init_squadbattlechatter();
    }

    anim.threatcallouts = [];
    anim.threatcallouts["rpg"] = 100;
    anim.threatcallouts["exposed"] = 25;
    anim.threatcallouts["player_obvious"] = 40;
    anim.threatcallouts["player_yourclock"] = 30;
    anim.threatcallouts["player_contact_clock"] = 25;
    anim.threatcallouts["player_target_clock"] = 25;
    anim.threatcallouts["player_cardinal"] = 20;
    anim.threatcallouts["ai_yourclock"] = 25;
    anim.threatcallouts["ai_contact_clock"] = 20;
    anim.threatcallouts["ai_target_clock"] = 20;
    anim.threatcallouts["ai_cardinal"] = 10;
    anim.threatcallouts["player_location"] = 95;
    anim.threatcallouts["ai_location"] = 100;
    anim.threatcallouts["generic_location"] = 90;
    anim.lastteamthreatcallout = [];
    anim.lastteamthreatcallouttime = [];

    foreach ( var_1 in anim.teams )
    {
        anim.lastteamthreatcallout[var_1] = undefined;
        anim.lastteamthreatcallouttime[var_1] = undefined;
    }

    anim.teamthreatcalloutlimittimeout = 20000;
    level notify( "battlechatter initialized" );
    anim notify( "battlechatter initialized" );
}

bcs_setup_teams_array()
{
    if ( !isdefined( anim.teams ) )
    {
        anim.teams = [];
        anim.teams[anim.teams.size] = "axis";
        anim.teams[anim.teams.size] = "allies";
        anim.teams[anim.teams.size] = "team3";
        anim.teams[anim.teams.size] = "neutral";
    }
}

bcs_setup_countryids()
{
    if ( !isdefined( anim.countryids ) )
    {
        anim.countryids["british"] = "UK";
        anim.countryids["american"] = "US";
        anim.countryids["seal"] = "NS";
        anim.countryids["taskforce"] = "TF";
        anim.countryids["secretservice"] = "SS";

        if ( common_scripts\utility::_id_D5D2() == "LANGUAGE_RUSSIAN" || common_scripts\utility::_id_D5D2() == "LANGUAGE_RUSSIAN_PARTIAL" )
            anim.countryids["russian"] = "RUS";
        else
            anim.countryids["russian"] = "RU";

        anim.countryids["arab"] = "AB";
        anim.countryids["german"] = "GE";
        anim.countryids["spanish"] = "SP";
        anim.countryids["italian"] = "IT";
        anim.countryids["portuguese"] = "PG";
        anim.countryids["shadowcompany"] = "SC";
    }
}

bcs_setup_chatter_toggle_array()
{
    bcs_setup_teams_array();

    if ( !isdefined( level.battlechatter ) )
    {
        level.battlechatter = [];

        foreach ( var_1 in anim.teams )
            maps\_utility::set_battlechatter_variable( var_1, 1 );
    }
}

bcs_setup_flavorburst_toggle_array()
{
    bcs_setup_teams_array();

    if ( !isdefined( level.flavorbursts ) )
    {
        level.flavorbursts = [];

        foreach ( var_1 in anim.teams )
            level.flavorbursts[var_1] = 1;
    }
}

init_flavorbursts()
{
    anim.flavorbursts["american"] = [];
    var_0 = 41;
    var_1 = [];

    if ( level.script == "roadkill" || level.script == "trainer" )
    {
        var_1[var_1.size] = 13;
        var_1[var_1.size] = 15;
        var_1[var_1.size] = 16;
        var_1[var_1.size] = 19;
        var_1[var_1.size] = 20;
        var_1[var_1.size] = 30;
        var_1[var_1.size] = 31;
        var_1[var_1.size] = 33;
        var_1[var_1.size] = 38;
    }

    for ( var_2 = 0; var_2 < var_0; var_2++ )
    {
        if ( var_1.size )
        {
            var_3 = 0;

            foreach ( var_5 in var_1 )
            {
                if ( var_5 == var_2 )
                {
                    var_3 = 1;
                    break;
                }
            }

            if ( var_3 )
                continue;
        }

        anim.flavorbursts["american"][var_2] = maps\_utility::string( var_2 + 1 );
    }

    anim.flavorbursts["shadowcompany"] = [];
    var_0 = 9;

    for ( var_2 = 1; var_2 <= var_0; var_2++ )
        anim.flavorbursts["shadowcompany"][var_2] = maps\_utility::string( var_2 + 1 );

    anim.flavorburstsused = [];
}

shutdown_battlechatter()
{
    anim.countryids = undefined;
    anim.eventtypeminwait = undefined;
    anim.eventactionminwait = undefined;
    anim.eventtypeminwait = undefined;
    anim.eventpriority = undefined;
    anim.eventduration = undefined;
    anim.moveorigin = undefined;
    anim.scripteddialoguebuffertime = undefined;
    anim.bcs_threatresettime = undefined;
    anim.locationlastcallouttimes = undefined;
    anim.usedids = undefined;
    anim.flavorburstsused = undefined;
    anim.lastteamthreatcallout = undefined;
    anim.lastteamthreatcallouttime = undefined;
    anim.lastnamesaidtimeout = undefined;
    anim.lastnamesaid = undefined;
    anim.lastnamesaidtime = undefined;
    anim.chatinitialized = 0;
    anim.player.chatinitialized = 0;
    level.battlechatter = undefined;

    for ( var_0 = 0; var_0 < anim.squadcreatefuncs.size; var_0++ )
    {
        if ( anim.squadcreatestrings[var_0] != "::init_squadBattleChatter" )
            continue;

        if ( var_0 != anim.squadcreatefuncs.size - 1 )
        {
            anim.squadcreatefuncs[var_0] = anim.squadcreatefuncs[anim.squadcreatefuncs.size - 1];
            anim.squadcreatestrings[var_0] = anim.squadcreatestrings[anim.squadcreatestrings.size - 1];
        }

        anim.squadcreatefuncs[anim.squadcreatefuncs.size - 1] = undefined;
        anim.squadcreatestrings[anim.squadcreatestrings.size - 1] = undefined;
    }

    level notify( "battlechatter disabled" );
    anim notify( "battlechatter disabled" );
}

init_squadbattlechatter()
{
    var_0 = self;
    var_0.numspeakers = 0;
    var_0.maxspeakers = 1;
    var_0.nextsaytime = gettime() + 50;
    var_0.nextsaytimes["threat"] = gettime() + 50;
    var_0.nextsaytimes["order"] = gettime() + 50;
    var_0.nextsaytimes["reaction"] = gettime() + 50;
    var_0.nextsaytimes["response"] = gettime() + 50;
    var_0.nextsaytimes["inform"] = gettime() + 50;
    var_0.nextsaytimes["custom"] = gettime() + 50;
    var_0.nexttypesaytimes["threat"] = [];
    var_0.nexttypesaytimes["order"] = [];
    var_0.nexttypesaytimes["reaction"] = [];
    var_0.nexttypesaytimes["response"] = [];
    var_0.nexttypesaytimes["inform"] = [];
    var_0.nexttypesaytimes["custom"] = [];
    var_0.ismembersaying["threat"] = 0;
    var_0.ismembersaying["order"] = 0;
    var_0.ismembersaying["reaction"] = 0;
    var_0.ismembersaying["response"] = 0;
    var_0.ismembersaying["inform"] = 0;
    var_0.ismembersaying["custom"] = 0;
    var_0.lastdirection = "";
    var_0.memberaddfuncs[var_0.memberaddfuncs.size] = animscripts\battlechatter_ai::addtosystem;
    var_0.memberaddstrings[var_0.memberaddstrings.size] = "::addToSystem";
    var_0.memberremovefuncs[var_0.memberremovefuncs.size] = animscripts\battlechatter_ai::removefromsystem;
    var_0.memberremovestrings[var_0.memberremovestrings.size] = "::removeFromSystem";
    var_0.squadupdatefuncs[var_0.squadupdatefuncs.size] = ::initcontact;
    var_0.squadupdatestrings[var_0.squadupdatestrings.size] = "::initContact";
    var_0.fbt_firstburst = 1;
    var_0.fbt_lastbursterid = undefined;

    for ( var_1 = 0; var_1 < anim.squadindex.size; var_1++ )
        var_0 thread initcontact( anim.squadindex[var_1].squadname );

    var_0 thread animscripts\battlechatter_ai::squadthreatwaiter();
    var_0 thread animscripts\battlechatter_ai::squadofficerwaiter();
    var_0 thread squadflavorbursttransmissions();
    var_0.chatinitialized = 1;
    var_0 notify( "squad chat initialized" );
}

shutdown_squadbattlechatter()
{
    var_0 = self;
    var_0.numspeakers = undefined;
    var_0.maxspeakers = undefined;
    var_0.nextsaytime = undefined;
    var_0.nextsaytimes = undefined;
    var_0.nexttypesaytimes = undefined;
    var_0.ismembersaying = undefined;
    var_0.fbt_firstburst = undefined;
    var_0.fbt_lastbursterid = undefined;

    for ( var_1 = 0; var_1 < var_0.memberaddfuncs.size; var_1++ )
    {
        if ( var_0.memberaddstrings[var_1] != "::addToSystem" )
            continue;

        if ( var_1 != var_0.memberaddfuncs.size - 1 )
        {
            var_0.memberaddfuncs[var_1] = var_0.memberaddfuncs[var_0.memberaddfuncs.size - 1];
            var_0.memberaddstrings[var_1] = var_0.memberaddstrings[var_0.memberaddstrings.size - 1];
        }

        var_0.memberaddfuncs[var_0.memberaddfuncs.size - 1] = undefined;
        var_0.memberaddstrings[var_0.memberaddstrings.size - 1] = undefined;
    }

    for ( var_1 = 0; var_1 < var_0.memberremovefuncs.size; var_1++ )
    {
        if ( var_0.memberremovestrings[var_1] != "::removeFromSystem" )
            continue;

        if ( var_1 != var_0.memberremovefuncs.size - 1 )
        {
            var_0.memberremovefuncs[var_1] = var_0.memberremovefuncs[var_0.memberremovefuncs.size - 1];
            var_0.memberremovestrings[var_1] = var_0.memberremovestrings[var_0.memberremovestrings.size - 1];
        }

        var_0.memberremovefuncs[var_0.memberremovefuncs.size - 1] = undefined;
        var_0.memberremovestrings[var_0.memberremovestrings.size - 1] = undefined;
    }

    for ( var_1 = 0; var_1 < var_0.squadupdatefuncs.size; var_1++ )
    {
        if ( var_0.squadupdatestrings[var_1] != "::initContact" )
            continue;

        if ( var_1 != var_0.squadupdatefuncs.size - 1 )
        {
            var_0.squadupdatefuncs[var_1] = var_0.squadupdatefuncs[var_0.squadupdatefuncs.size - 1];
            var_0.squadupdatestrings[var_1] = var_0.squadupdatestrings[var_0.squadupdatestrings.size - 1];
        }

        var_0.squadupdatefuncs[var_0.squadupdatefuncs.size - 1] = undefined;
        var_0.squadupdatestrings[var_0.squadupdatestrings.size - 1] = undefined;
    }

    for ( var_1 = 0; var_1 < anim.squadindex.size; var_1++ )
        var_0 shutdowncontact( anim.squadindex[var_1].squadname );

    var_0.chatinitialized = 0;
}

bcsenabled()
{
    return anim.chatinitialized;
}

bcsdebugwaiter()
{
    var_0 = getdvar( "bcs_enable", "on" );

    for (;;)
    {
        var_1 = getdvar( "bcs_enable", "on" );

        if ( var_1 != var_0 )
        {
            switch ( var_1 )
            {
                case "on":
                    if ( !anim.chatinitialized )
                        enablebattlechatter();

                    break;
                case "off":
                    if ( anim.chatinitialized )
                        disablebattlechatter();

                    break;
            }

            var_0 = var_1;
        }

        wait 1.0;
    }
}

enablebattlechatter()
{
    init_battlechatter();
    anim.player thread animscripts\battlechatter_ai::addtosystem();
    var_0 = getaiarray();

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
        var_0[var_1] animscripts\battlechatter_ai::addtosystem();
}

disablebattlechatter()
{
    shutdown_battlechatter();
    var_0 = getaiarray();

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        if ( isdefined( var_0[var_1].squad ) && var_0[var_1].squad.chatinitialized )
            var_0[var_1].squad shutdown_squadbattlechatter();

        var_0[var_1] animscripts\battlechatter_ai::removefromsystem();
    }
}

setplayerbcnameid( var_0, var_1 )
{
    if ( isdefined( var_0 ) && isdefined( var_1 ) )
    {
        level.player.bcnameid = var_0;
        level.player._id_AFF7 = var_1;
        return;
    }

    while ( !isdefined( level.campaign ) )
        wait 0.1;

    var_2 = level.campaign;
    var_3 = anim.playernameids[var_2];
    var_4 = anim.countryids[var_2];

    if ( isdefined( var_3 ) )
        level.player.bcnameid = var_3;

    if ( isdefined( var_4 ) )
        level.player._id_AFF7 = var_4;
}

playbattlechatter()
{
    if ( !isalive( self ) )
        return;

    if ( !bcsenabled() )
        return;

    if ( _func_1FB() )
        return;

    if ( self._animactive > 0 )
        return;

    if ( isdefined( self.isspeaking ) && self.isspeaking )
        return;

    if ( self.team == "allies" && isdefined( anim.scripteddialoguestarttime ) )
    {
        if ( anim.scripteddialoguestarttime + anim.scripteddialoguebuffertime > gettime() )
            return;
    }

    if ( friendlyfire_warning() )
        return;

    if ( !isdefined( self.battlechatter ) || !self.battlechatter )
        return;

    if ( self.team == "allies" && getdvarint( "bcs_forceEnglish", 0 ) )
        return;

    if ( anim.isteamspeaking[self.team] )
        return;

    self endon( "death" );
    var_0 = gethighestpriorityevent();

    if ( !isdefined( var_0 ) )
        return;

    switch ( var_0 )
    {
        case "custom":
            thread playcustomevent();
            break;
        case "response":
            thread playresponseevent();
            break;
        case "order":
            thread playorderevent();
            break;
        case "threat":
            thread playthreatevent();
            break;
        case "reaction":
            thread playreactionevent();
            break;
        case "inform":
            thread playinformevent();
            break;
    }
}

playthreatevent()
{
    self endon( "death" );
    self endon( "removed from battleChatter" );
    self endon( "cancel speaking" );
    self.curevent = self.chatqueue["threat"];
    var_0 = self.chatqueue["threat"].threat;

    if ( !isalive( var_0 ) )
        return;

    if ( threatwasalreadycalledout( var_0 ) && !isplayer( var_0 ) )
        return;

    anim thread lockaction( self, "threat" );
    var_1 = 0;

    switch ( self.chatqueue["threat"].eventtype )
    {
        case "infantry":
            if ( isplayer( var_0 ) || !isdefined( var_0 getturret() ) )
                var_1 = threatinfantry( var_0 );
            else
            {

            }

            break;
        case "dog":
            var_1 = threatdog( var_0 );
            break;
        case "vehicle":
            break;
    }

    self notify( "done speaking" );

    if ( !var_1 )
        return;

    if ( !isalive( var_0 ) )
        return;

    var_0.calledout[self.squad.squadname] = spawnstruct();
    var_0.calledout[self.squad.squadname].spotter = self;
    var_0.calledout[self.squad.squadname].threattype = self.chatqueue["threat"].eventtype;
    var_0.calledout[self.squad.squadname].expiretime = gettime() + anim.bcs_threatresettime;

    if ( isdefined( var_0.squad ) )
        self.squad.squadlist[var_0.squad.squadname].calledout = 1;
}

threatwasalreadycalledout( var_0 )
{
    if ( isdefined( var_0.calledout ) && isdefined( var_0.calledout[self.squad.squadname] ) )
    {
        if ( var_0.calledout[self.squad.squadname].expiretime < gettime() )
            return 1;
    }

    return 0;
}

threatinfantry( var_0, var_1 )
{
    self endon( "cancel speaking" );
    var_2 = createchatphrase();
    var_2.master = 1;
    var_2.threatent = var_0;
    var_3 = getthreatinfantrycallouttype( var_0 );

    if ( !isdefined( var_3 ) || isdefined( var_3 ) && !isdefined( var_3.type ) )
        return 0;

    switch ( var_3.type )
    {
        case "rpg":
            var_2 threatinfantryrpg( var_0 );
            break;
        case "exposed":
            var_4 = doexposedcalloutresponse( var_3.responder );

            if ( var_4 && cansayname( var_3.responder ) )
            {
                var_2 addnamealias( var_3.responder.bcname );
                var_2.looktarget = var_3.responder;
            }

            var_2 threatinfantryexposed( var_0 );

            if ( var_4 )
            {
                if ( randomint( 100 ) < anim.eventchance["response"]["callout_negative"] )
                    var_3.responder animscripts\battlechatter_ai::addresponseevent( "callout", "neg", self, 0.9 );
                else
                    var_3.responder animscripts\battlechatter_ai::addresponseevent( "exposed", "acquired", self, 0.9 );
            }

            break;
        case "player_obvious":
            var_2 addplayernamealias();
            var_2 addthreatobviousalias();
            break;
        case "player_yourclock":
            var_2 addplayernamealias();
            var_2 addthreatcalloutalias( "yourclock", var_3.playerclockdirection );
            break;
        case "player_contact_clock":
            var_2 addplayernamealias();
            var_2 addthreatcalloutalias( "contactclock", var_3.playerclockdirection );
            break;
        case "player_target_clock":
            var_2 addplayernamealias();
            var_2 addthreatcalloutalias( "targetclock", var_3.playerclockdirection );
            break;
        case "player_cardinal":
            var_2 addplayernamealias();
            var_5 = getdirectioncompass( level.player.origin, var_0.origin );
            var_6 = normalizecompassdirection( var_5 );

            if ( var_6 == "impossible" )
                return 0;

            var_2 addthreatcalloutalias( "cardinal", var_6 );
            break;
        case "ai_yourclock":
            var_7 = getrelativeangles( var_3.responder );

            if ( cansayname( var_3.responder ) )
            {
                var_2 addnamealias( var_3.responder.bcname );
                var_2.looktarget = var_3.responder;
            }

            var_2 addthreatcalloutalias( "yourclock", var_3.responderclockdirection );
            var_2 addcalloutresponseevent( self, var_3, var_0 );
            break;
        case "ai_contact_clock":
            var_8 = self;

            if ( self.team == "allies" )
                var_8 = level.player;
            else if ( isdefined( var_3.responder ) && randomint( 100 ) < anim.eventchance["response"]["callout"] )
                var_8 = var_3.responder;

            var_7 = getrelativeangles( var_8 );
            var_9 = getdirectionfacingclock( var_7, var_8.origin, var_0.origin );

            if ( isdefined( var_3.responder ) && cansayname( var_3.responder ) )
            {
                var_2 addnamealias( var_3.responder.bcname );
                var_2.looktarget = var_3.responder;
            }

            var_2 addthreatcalloutalias( "contactclock", var_9 );
            var_2 addcalloutresponseevent( self, var_3, var_0 );
            break;
        case "ai_target_clock":
            var_8 = self;

            if ( self.team == "allies" )
                var_8 = level.player;
            else if ( isdefined( var_3.responder ) && randomint( 100 ) < anim.eventchance["response"]["callout"] )
                var_8 = var_3.responder;

            var_7 = getrelativeangles( var_8 );
            var_9 = getdirectionfacingclock( var_7, var_8.origin, var_0.origin );

            if ( isdefined( var_3.responder ) && cansayname( var_3.responder ) )
            {
                var_2 addnamealias( var_3.responder.bcname );
                var_2.looktarget = var_3.responder;
            }

            var_2 addthreatcalloutalias( "targetclock", var_9 );
            var_2 addcalloutresponseevent( self, var_3, var_0 );
            break;
        case "ai_cardinal":
            var_8 = self;

            if ( self.team == "allies" )
                var_8 = level.player;

            var_5 = getdirectioncompass( var_8.origin, var_0.origin );
            var_6 = normalizecompassdirection( var_5 );

            if ( var_6 == "impossible" )
                return 0;

            var_2 addthreatcalloutalias( "cardinal", var_6 );
            break;
        case "generic_location":
            var_10 = var_2 threatinfantry_docalloutlocation( var_3, level.player, var_0 );

            if ( !var_10 )
                return 0;

            break;
        case "player_location":
            var_2 addplayernamealias();
            var_10 = var_2 threatinfantry_docalloutlocation( var_3, level.player, var_0 );

            if ( !var_10 )
                return 0;

            break;
        case "ai_location":
            if ( cansayname( var_3.responder ) )
            {
                var_2 addnamealias( var_3.responder.bcname );
                var_2.looktarget = var_3.responder;
            }

            var_10 = var_2 threatinfantry_docalloutlocation( var_3, self, var_0 );

            if ( !var_10 )
                return 0;

            var_11 = var_2.soundaliases.size - 1;
            var_12 = var_2.soundaliases[var_11];

            if ( iscallouttypereport( var_12 ) )
                var_3.responder animscripts\battlechatter_ai::addresponseevent( "callout", "echo", self, 0.9, var_12 );
            else if ( iscallouttypeqa( var_12, self ) )
                var_3.responder animscripts\battlechatter_ai::addresponseevent( "callout", "QA", self, 0.9, var_12, var_3.location );
            else if ( randomint( 100 ) < anim.eventchance["response"]["callout_negative"] )
                var_3.responder animscripts\battlechatter_ai::addresponseevent( "callout", "neg", self, 0.9 );
            else
                var_3.responder animscripts\battlechatter_ai::addresponseevent( "exposed", "acquired", self, 0.9 );

            break;
    }

    setlastcallouttype( var_3.type );
    playphrase( var_2 );
    return 1;
}

doexposedcalloutresponse( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( var_0.countryid != "US" && var_0.countryid != "NS" && var_0.countryid != "TF" )
        return 0;

    if ( randomint( 100 ) > anim.eventchance["response"]["exposed"] )
        return 0;

    return 1;
}

threatinfantry_docalloutlocation( var_0, var_1, var_2 )
{
    var_3 = addthreatcalloutlocationalias( var_0.location );
    return var_3;
}

addcalloutresponseevent( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1.responder ) )
        return;

    if ( randomint( 100 ) > anim.eventchance["response"]["callout"] )
        return;

    var_3 = "affirm";

    if ( !var_1.responder cansee( var_2 ) && randomint( 100 ) < anim.eventchance["response"]["callout_negative"] )
        var_3 = "neg";

    var_1.responder animscripts\battlechatter_ai::addresponseevent( "callout", var_3, var_0, 0.9 );
}

getthreatinfantrycallouttype( var_0 )
{
    var_1 = var_0 getlocation();
    var_2 = getdirectionfacingclock( self.angles, self.origin, var_0.origin );
    var_3 = getresponder( 64, 1024, "response" );
    var_4 = undefined;

    if ( isdefined( var_3 ) )
        var_4 = getdirectionfacingclock( var_3.angles, var_3.origin, var_0.origin );

    var_5 = 0;

    if ( self.team == level.player.team )
        var_5 = maps\_utility::player_can_see_ai( var_0 );

    var_6 = level.player pointinfov( var_0.origin );
    var_7 = level.player entinfrontarc( var_0 );
    var_8 = getdirectionfacingclock( level.player.angles, level.player.origin, var_0.origin );
    self.possiblethreatcallouts = [];

    if ( !isplayer( var_0 ) && var_0 animscripts\utility::usingrocketlauncher() )
        addpossiblethreatcallout( "rpg" );

    if ( var_0 isexposed() )
        addpossiblethreatcallout( "exposed" );

    if ( var_7 && cansayplayername() )
    {
        if ( var_8 == "11" || var_8 == "12" || var_8 == "1" )
        {
            if ( var_5 )
                addpossiblethreatcallout( "player_obvious" );
        }
        else
        {
            addpossiblethreatcallout( "player_yourclock" );
            addpossiblethreatcallout( "player_contact_clock" );
            addpossiblethreatcallout( "player_target_clock" );
            addpossiblethreatcallout( "player_cardinal" );
        }
    }

    if ( isdefined( var_3 ) && cansayname( var_3 ) )
        addpossiblethreatcallout( "ai_yourclock" );

    if ( enemy_team_name() || var_2 != "12" )
    {
        addpossiblethreatcallout( "ai_contact_clock" );
        addpossiblethreatcallout( "ai_target_clock" );
    }

    addpossiblethreatcallout( "ai_cardinal" );

    if ( isdefined( var_1 ) )
    {
        var_9 = var_1 getcannedresponse( self );

        if ( isdefined( var_9 ) )
        {
            if ( isdefined( var_3 ) )
                addpossiblethreatcallout( "ai_location" );
            else
            {
                if ( cansayplayername() )
                    addpossiblethreatcallout( "player_location" );

                addpossiblethreatcallout( "generic_location" );
            }
        }
        else
        {
            if ( isdefined( var_3 ) )
                addpossiblethreatcallout( "ai_location" );

            if ( cansayplayername() )
                addpossiblethreatcallout( "player_location" );

            addpossiblethreatcallout( "generic_location" );
        }
    }

    if ( !self.possiblethreatcallouts.size )
        return undefined;

    var_11 = getweightedchanceroll( self.possiblethreatcallouts, anim.threatcallouts );
    var_12 = spawnstruct();
    var_12.type = var_11;
    var_12.responder = var_3;
    var_12.responderclockdirection = var_4;
    var_12.playerclockdirection = var_8;

    if ( isdefined( var_1 ) )
        var_12.location = var_1;

    return var_12;
}

getcannedresponse( var_0 )
{
    var_1 = undefined;
    var_2 = self.locationaliases;

    foreach ( var_4 in var_2 )
    {
        if ( iscallouttypeqa( var_4, var_0 ) && !isdefined( self.qafinished ) )
        {
            var_1 = var_4;
            break;
        }

        if ( iscallouttypereport( var_4 ) )
            var_1 = var_4;
    }

    return var_1;
}

iscallouttypereport( var_0 )
{
    return issubstr( var_0, "_report" );
}

iscallouttypeqa( var_0, var_1 )
{
    if ( issubstr( var_0, "_qa" ) && soundexists( var_0 ) )
        return 1;

    var_2 = var_1 getqacalloutalias( var_0, 0 );

    if ( soundexists( var_2 ) )
        return 1;

    return 0;
}

getqacalloutalias( var_0, var_1 )
{
    var_2 = self.countryid + "_" + self.npcid + "_co_";
    var_2 += var_0;
    var_2 += ( "_qa" + var_1 );
    return var_2;
}

addallowedthreatcallout( var_0 )
{
    self.allowedcallouts[self.allowedcallouts.size] = var_0;
}

addpossiblethreatcallout( var_0 )
{
    var_1 = 0;

    foreach ( var_3 in self.allowedcallouts )
    {
        if ( var_3 == var_0 )
        {
            if ( !callouttypewillrepeat( var_0 ) )
                var_1 = 1;

            break;
        }
    }

    if ( !var_1 )
        return;

    self.possiblethreatcallouts[self.possiblethreatcallouts.size] = var_0;
}

callouttypewillrepeat( var_0 )
{
    if ( !isdefined( anim.lastteamthreatcallout[self.team] ) )
        return 0;

    if ( !isdefined( anim.lastteamthreatcallouttime[self.team] ) )
        return 0;

    var_1 = anim.lastteamthreatcallout[self.team];
    var_2 = anim.lastteamthreatcallouttime[self.team];
    var_3 = anim.teamthreatcalloutlimittimeout;

    if ( var_0 == var_1 && gettime() - var_2 < var_3 )
        return 1;

    return 0;
}

setlastcallouttype( var_0 )
{
    anim.lastteamthreatcallout[self.team] = var_0;
    anim.lastteamthreatcallouttime[self.team] = gettime();
}

getweightedchanceroll( var_0, var_1 )
{
    var_2 = undefined;
    var_3 = -1;

    foreach ( var_5 in var_0 )
    {
        if ( var_1[var_5] <= 0 )
            continue;

        var_6 = randomint( var_1[var_5] );

        if ( isdefined( var_2 ) && var_1[var_2] >= 100 )
        {
            if ( var_1[var_5] < 100 )
                continue;
        }
        else
        {
            if ( var_1[var_5] >= 100 )
            {
                var_2 = var_5;
                var_3 = var_6;
                continue;
            }

            if ( var_6 > var_3 )
            {
                var_2 = var_5;
                var_3 = var_6;
            }
        }
    }

    return var_2;
}

threatdog( var_0, var_1 )
{
    self endon( "cancel speaking" );
    var_2 = createchatphrase();
    var_2.master = 1;
    var_2.threatent = var_0;
    var_2 addthreatalias( "dog", "generic" );
    playphrase( var_2 );
    return 1;
}

threatinfantryexposed( var_0 )
{
    var_1 = [];
    var_1 = common_scripts\utility::array_add( var_1, "open" );
    var_1 = common_scripts\utility::array_add( var_1, "breaking" );

    if ( self.owner.team == "allies" && self.owner.countryid != "RU" && self.owner.countryid != "RUS" )
    {
        var_1 = common_scripts\utility::array_add( var_1, "oscarmike" );
        var_1 = common_scripts\utility::array_add( var_1, "movement" );
    }

    var_2 = var_1[randomint( var_1.size )];
    addthreatexposedalias( var_2 );
}

threatinfantryrpg( var_0 )
{
    addthreatalias( "rpg" );
}

playreactionevent()
{
    self endon( "death" );
    self endon( "removed from battleChatter" );
    self.curevent = self.chatqueue["reaction"];
    var_0 = self.chatqueue["reaction"].reactto;
    var_1 = self.chatqueue["reaction"].modifier;
    anim thread lockaction( self, "reaction" );

    switch ( self.chatqueue["reaction"].eventtype )
    {
        case "casualty":
            reactioncasualty( var_0, var_1 );
            break;
        case "taunt":
            reactiontaunt( var_0, var_1 );
            break;
        case "friendlyfire":
            reactionfriendlyfire( var_0, var_1 );
            break;
    }

    self notify( "done speaking" );
}

reactioncasualty( var_0, var_1 )
{
    self endon( "death" );
    self endon( "removed from battleChatter" );
    var_2 = createchatphrase();
    var_2 addreactionalias( "casualty", "generic" );
    playphrase( var_2 );
}

reactiontaunt( var_0, var_1 )
{
    self endon( "death" );
    self endon( "removed from battleChatter" );
    var_2 = createchatphrase();

    if ( isdefined( var_1 ) && var_1 == "hostileburst" )
        var_2 addhostileburstalias();
    else
        var_2 addtauntalias( "taunt", "generic" );

    playphrase( var_2 );
}

reactionfriendlyfire( var_0, var_1 )
{
    self endon( "death" );
    self endon( "removed from battleChatter" );
    var_2 = createchatphrase();
    var_2 addcheckfirealias();
    playphrase( var_2 );
}

playresponseevent()
{
    self endon( "death" );
    self endon( "removed from battleChatter" );
    self.curevent = self.chatqueue["response"];
    var_0 = self.chatqueue["response"].modifier;
    var_1 = self.chatqueue["response"].respondto;

    if ( !isalive( var_1 ) )
        return;

    if ( self.chatqueue["response"].modifier == "follow" && self.a.state != "move" )
        return;

    anim thread lockaction( self, "response" );

    switch ( self.chatqueue["response"].eventtype )
    {
        case "exposed":
            responsethreatexposed( var_1, var_0 );
            break;
        case "callout":
            responsethreatcallout( var_1, var_0 );
            break;
        case "ack":
            responsegeneric( var_1, var_0 );
            break;
    }

    self notify( "done speaking" );
}

responsethreatexposed( var_0, var_1 )
{
    self endon( "death" );
    self endon( "removed from battleChatter" );

    if ( !isalive( var_0 ) )
        return;

    var_2 = createchatphrase();
    var_2 addthreatexposedalias( var_1 );
    var_2.looktarget = var_0;
    var_2.master = 1;
    playphrase( var_2 );
}

responsethreatcallout( var_0, var_1 )
{
    self endon( "death" );
    self endon( "removed from battleChatter" );

    if ( !isalive( var_0 ) )
        return;

    var_2 = createchatphrase();
    var_3 = 0;

    if ( var_1 == "echo" )
        var_3 = var_2 addthreatcalloutecho( self.curevent.reportalias, var_0 );
    else if ( var_1 == "QA" )
        var_3 = var_2 addthreatcalloutqa_nextline( var_0, self.curevent.reportalias, self.curevent.location );
    else
        var_3 = var_2 addthreatcalloutresponsealias( var_1 );

    if ( !var_3 )
        return;

    var_2.looktarget = var_0;
    var_2.master = 1;
    playphrase( var_2 );
}

responsegeneric( var_0, var_1 )
{
    self endon( "death" );
    self endon( "removed from battleChatter" );

    if ( !isalive( var_0 ) )
        return;

    var_2 = self.chatqueue["response"].eventtype;
    var_3 = createchatphrase();
    var_3 addresponsealias( var_2, var_1 );
    var_3.looktarget = var_0;
    var_3.master = 1;
    playphrase( var_3 );
}

playorderevent()
{
    self endon( "death" );
    self endon( "removed from battleChatter" );
    self.curevent = self.chatqueue["order"];
    var_0 = self.chatqueue["order"].modifier;
    var_1 = self.chatqueue["order"].orderto;
    anim thread lockaction( self, "order" );

    switch ( self.chatqueue["order"].eventtype )
    {
        case "action":
            orderaction( var_0, var_1 );
            break;
        case "move":
            ordermove( var_0, var_1 );
            break;
        case "displace":
            orderdisplace( var_0 );
            break;
    }

    self notify( "done speaking" );
}

orderaction( var_0, var_1 )
{
    self endon( "death" );
    self endon( "removed from battleChatter" );
    var_2 = createchatphrase();
    tryorderto( var_2, var_1 );
    var_2 addorderalias( "action", var_0 );
    playphrase( var_2 );
}

ordermove( var_0, var_1 )
{
    self endon( "death" );
    self endon( "removed from battleChatter" );
    var_2 = createchatphrase();
    tryorderto( var_2, var_1 );
    var_2 addorderalias( "move", var_0 );
    playphrase( var_2 );
}

orderdisplace( var_0 )
{
    self endon( "death" );
    self endon( "removed from battleChatter" );
    var_1 = createchatphrase();
    var_1 addorderalias( "displace", var_0 );
    playphrase( var_1, 1 );
}

tryorderto( var_0, var_1 )
{
    if ( randomint( 100 ) > anim.eventchance["response"]["order"] )
    {
        if ( !isdefined( var_1 ) || isdefined( var_1 ) && !isplayer( var_1 ) )
            return;
    }

    if ( isdefined( var_1 ) && isplayer( var_1 ) && isdefined( level.player.bcnameid ) )
    {
        var_0 addplayernamealias();
        var_0.looktarget = level.player;
    }
    else if ( isdefined( var_1 ) && cansayname( var_1 ) )
    {
        var_0 addnamealias( var_1.bcname );
        var_0.looktarget = var_1;
        var_1 animscripts\battlechatter_ai::addresponseevent( "ack", "yes", self, 0.9 );
    }
    else
        level notify( "follow order", self );
}

playinformevent()
{
    self endon( "death" );
    self endon( "removed from battleChatter" );
    self.curevent = self.chatqueue["inform"];
    var_0 = self.chatqueue["inform"].modifier;
    anim thread lockaction( self, "inform" );

    switch ( self.chatqueue["inform"].eventtype )
    {
        case "incoming":
            informincoming( var_0 );
            break;
        case "attack":
            informattacking( var_0 );
            break;
        case "reloading":
            informreloading( var_0 );
            break;
        case "suppressed":
            informsuppressed( var_0 );
            break;
        case "killfirm":
            informkillfirm( var_0 );
            break;
    }

    self notify( "done speaking" );
}

informreloading( var_0 )
{
    self endon( "death" );
    self endon( "removed from battleChatter" );
    var_1 = createchatphrase();
    var_1 addinformalias( "reloading", var_0 );
    playphrase( var_1 );
}

informsuppressed( var_0 )
{
    self endon( "death" );
    self endon( "removed from battleChatter" );
    var_1 = createchatphrase();
    var_1 addinformalias( "suppressed", var_0 );
    playphrase( var_1 );
}

informincoming( var_0 )
{
    self endon( "death" );
    self endon( "removed from battleChatter" );
    var_1 = createchatphrase();

    if ( var_0 == "grenade" )
        var_1.master = 1;

    var_1 addinformalias( "incoming", var_0 );
    playphrase( var_1 );
}

informattacking( var_0 )
{
    self endon( "death" );
    self endon( "removed from battleChatter" );
    var_1 = createchatphrase();
    var_1 addinformalias( "attack", var_0 );
    playphrase( var_1 );
}

informkillfirm( var_0 )
{
    self endon( "death" );
    self endon( "removed from battleChatter" );
    var_1 = createchatphrase();
    var_1 addinformalias( "killfirm", var_0 );
    playphrase( var_1 );
}

playcustomevent()
{
    self endon( "death" );
    self endon( "removed from battleChatter" );
    self.curevent = self.chatqueue["custom"];
    anim thread lockaction( self, self.curevent.type, 1 );
    playphrase( self.customchatphrase );
    self notify( "done speaking" );
    self.customchatevent = undefined;
    self.customchatphrase = undefined;
}

playphrase( var_0, var_1 )
{
    anim endon( "battlechatter disabled" );
    self endon( "death" );

    if ( isdefined( var_1 ) )
        return;

    if ( isdefined( level._stealth ) && voice_is_british_based() )
    {
        for ( var_2 = 0; var_2 < var_0.soundaliases.size; var_2++ )
            var_0.soundaliases[var_2] += "_s";
    }

    if ( battlechatter_canprint() || battlechatter_canprintdump() )
    {
        var_3 = [];

        foreach ( var_5 in var_0.soundaliases )
            var_3[var_3.size] = var_5;

        if ( battlechatter_canprint() )
            battlechatter_print( var_3 );

        if ( battlechatter_canprintdump() )
        {
            var_7 = self.curevent.eventaction + "_" + self.curevent.eventtype;

            if ( isdefined( self.curevent.modifier ) )
                var_7 += ( "_" + self.curevent.modifier );

            thread battlechatter_printdump( var_3, var_7 );
        }
    }

    for ( var_2 = 0; var_2 < var_0.soundaliases.size; var_2++ )
    {
        if ( !self.battlechatter )
        {
            if ( !is_friendlyfire_event( self.curevent ) )
                continue;
            else if ( !can_say_friendlyfire( 0 ) )
                continue;
        }

        if ( self._animactive > 0 )
            continue;

        if ( isfiltered( self.curevent.eventaction ) )
        {
            wait 0.85;
            continue;
        }

        if ( !soundexists( var_0.soundaliases[var_2] ) )
            continue;

        var_8 = gettime();

        if ( var_0.master && self.team == "allies" )
        {
            thread maps\_anim::anim_facialfiller( var_0.soundaliases[var_2], var_0.looktarget );
            self playsoundatviewheight( var_0.soundaliases[var_2], var_0.soundaliases[var_2], 1 );
            self waittill( var_0.soundaliases[var_2] );
        }
        else
        {
            thread maps\_anim::anim_facialfiller( var_0.soundaliases[var_2], var_0.looktarget );
            self playsoundatviewheight( var_0.soundaliases[var_2], var_0.soundaliases[var_2], 1 );
            self waittill( var_0.soundaliases[var_2] );
        }

        if ( gettime() < var_8 + 250 )
        {

        }
    }

    self notify( "playPhrase_done" );
    dotypelimit( self.curevent.eventaction, self.curevent.eventtype );
}

is_friendlyfire_event( var_0 )
{
    if ( !isdefined( var_0.eventaction ) || !isdefined( var_0.eventtype ) )
        return 0;

    if ( var_0.eventaction == "reaction" && var_0.eventtype == "friendlyfire" )
        return 1;

    return 0;
}

isspeakingfailsafe( var_0 )
{
    self endon( "death" );
    wait 25;
    clearisspeaking( var_0 );
}

clearisspeaking( var_0 )
{
    self.isspeaking = 0;
    self.chatqueue[var_0].expiretime = 0;
    self.chatqueue[var_0].priority = 0.0;
    self.nextsaytimes[var_0] = gettime() + anim.eventactionminwait[var_0]["self"];
}

lockaction( var_0, var_1, var_2 )
{
    anim endon( "battlechatter disabled" );
    var_3 = var_0.squad;
    var_4 = var_0.team;
    var_0.isspeaking = 1;
    var_0 thread isspeakingfailsafe( var_1 );
    var_3.ismembersaying[var_1] = 1;
    var_3.numspeakers++;
    anim.isteamspeaking[var_4] = 1;
    anim.isteamsaying[var_4][var_1] = 1;
    var_5 = var_0 common_scripts\utility::waittill_any_return( "death", "done speaking", "cancel speaking" );
    var_3.ismembersaying[var_1] = 0;
    var_3.numspeakers--;
    anim.isteamspeaking[var_4] = 0;
    anim.isteamsaying[var_4][var_1] = 0;

    if ( var_5 == "cancel speaking" )
        return;

    anim.lastteamspeaktime[var_4] = gettime();

    if ( isalive( var_0 ) )
        var_0 clearisspeaking( var_1 );

    var_3.nextsaytimes[var_1] = gettime() + anim.eventactionminwait[var_1]["squad"];
}

updatecontact( var_0, var_1 )
{
    if ( gettime() - self.squadlist[var_0].lastcontact > 10000 )
    {
        var_2 = 0;

        for ( var_3 = 0; var_3 < self.members.size; var_3++ )
        {
            if ( self.members[var_3] != var_1 && isalive( self.members[var_3].enemy ) && isdefined( self.members[var_3].enemy.squad ) && self.members[var_3].enemy.squad.squadname == var_0 )
                var_2 = 1;
        }

        if ( !var_2 )
        {
            self.squadlist[var_0].firstcontact = gettime();
            self.squadlist[var_0].calledout = 0;
        }
    }

    self.squadlist[var_0].lastcontact = gettime();
}

cansay( var_0, var_1, var_2, var_3 )
{
    self endon( "death" );
    self endon( "removed from battleChatter" );

    if ( isplayer( self ) )
        return 0;

    if ( distance( level.player.origin, self.origin ) > level._id_B67E )
        return 0;

    if ( !isdefined( self.battlechatter ) || !self.battlechatter )
        return 0;

    if ( isdefined( var_2 ) && var_2 >= 1 )
        return 1;

    if ( gettime() + anim.eventactionminwait[var_0]["self"] < self.nextsaytimes[var_0] )
        return 0;

    if ( gettime() + anim.eventactionminwait[var_0]["squad"] < self.squad.nextsaytimes[var_0] )
        return 0;

    if ( isdefined( var_1 ) && typelimited( var_0, var_1 ) )
        return 0;

    if ( isdefined( var_1 ) && anim.eventpriority[var_0][var_1] < self.bcs_minpriority )
        return 0;

    if ( voice_is_british_based() )
        return _id_B765( var_0, var_1, var_3 );

    return 1;
}

_id_B765( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = "";

    if ( !isdefined( var_1 ) )
        return 0;

    switch ( var_0 )
    {
        case "order":
            if ( var_1 == "action" && var_2 == "coverme" )
                return 1;

            break;
        case "threat":
            if ( var_1 == "infantry" || var_1 == "dog" || var_1 == "rpg" )
                return 1;

            break;
        case "inform":
            if ( var_1 == "attack" && var_2 == "grenade" )
                return 1;
            else if ( var_1 == "incoming" && var_2 == "grenade" )
                return 1;
            else if ( var_1 == "reloading" && var_2 == "generic" )
                return 1;

            break;
        case "reaction":
            if ( var_1 == "casualty" && var_2 == "generic" )
                return 1;

            break;
        default:
            return 0;
    }

    return 0;
}

gethighestpriorityevent()
{
    var_0 = undefined;
    var_1 = -999999999;

    if ( isvalidevent( "custom" ) )
    {
        var_0 = "custom";
        var_1 = self.chatqueue["custom"].priority;
    }

    if ( isvalidevent( "response" ) )
    {
        if ( self.chatqueue["response"].priority > var_1 )
        {
            var_0 = "response";
            var_1 = self.chatqueue["response"].priority;
        }
    }

    if ( isvalidevent( "order" ) )
    {
        if ( self.chatqueue["order"].priority > var_1 )
        {
            var_0 = "order";
            var_1 = self.chatqueue["order"].priority;
        }
    }

    if ( isvalidevent( "threat" ) )
    {
        if ( self.chatqueue["threat"].priority > var_1 )
        {
            var_0 = "threat";
            var_1 = self.chatqueue["threat"].priority;
        }
    }

    if ( isvalidevent( "inform" ) )
    {
        if ( self.chatqueue["inform"].priority > var_1 )
        {
            var_0 = "inform";
            var_1 = self.chatqueue["inform"].priority;
        }
    }

    if ( isvalidevent( "reaction" ) )
    {
        if ( self.chatqueue["reaction"].priority > var_1 )
        {
            var_0 = "reaction";
            var_1 = self.chatqueue["reaction"].priority;
        }
    }

    return var_0;
}

gettargettingai( var_0 )
{
    var_1 = self.squad;
    var_2 = [];

    for ( var_3 = 0; var_3 < var_1.members.size; var_3++ )
    {
        if ( isdefined( var_1.members[var_3].enemy ) && var_1.members[var_3].enemy == var_0 )
            var_2[var_2.size] = var_1.members[var_3];
    }

    if ( !isdefined( var_2[0] ) )
        return undefined;

    var_4 = undefined;

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        if ( var_2[var_3] cansay( "response" ) )
            return var_4;
    }

    return common_scripts\utility::getclosest( self.origin, var_2 );
}

getqueueevents()
{
    var_0 = [];
    var_1 = [];
    var_0[0] = "custom";
    var_0[1] = "response";
    var_0[2] = "order";
    var_0[3] = "threat";
    var_0[4] = "inform";

    for ( var_2 = var_0.size - 1; var_2 >= 0; var_2-- )
    {
        for ( var_3 = 1; var_3 <= var_2; var_3++ )
        {
            if ( self.chatqueue[var_0[var_3 - 1]].priority < self.chatqueue[var_0[var_3]].priority )
            {
                var_4 = var_0[var_3 - 1];
                var_0[var_3 - 1] = var_0[var_3];
                var_0[var_3] = var_4;
            }
        }
    }

    var_5 = 0;

    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
    {
        var_6 = geteventstate( var_0[var_2] );

        if ( var_6 == " valid" && !var_5 )
        {
            var_5 = 1;
            var_1[var_2] = "g " + var_0[var_2] + var_6 + " " + self.chatqueue[var_0[var_2]].priority;
            continue;
        }

        if ( var_6 == " valid" )
        {
            var_1[var_2] = "y " + var_0[var_2] + var_6 + " " + self.chatqueue[var_0[var_2]].priority;
            continue;
        }

        if ( self.chatqueue[var_0[var_2]].expiretime == 0 )
        {
            var_1[var_2] = "b " + var_0[var_2] + var_6 + " " + self.chatqueue[var_0[var_2]].priority;
            continue;
        }

        var_1[var_2] = "r " + var_0[var_2] + var_6 + " " + self.chatqueue[var_0[var_2]].priority;
    }

    return var_1;
}

geteventstate( var_0 )
{
    var_1 = "";

    if ( self.squad.ismembersaying[var_0] )
        var_1 += " playing";

    if ( gettime() > self.chatqueue[var_0].expiretime )
        var_1 += " expired";

    if ( gettime() < self.squad.nextsaytimes[var_0] )
        var_1 += " cantspeak";

    if ( var_1 == "" )
        var_1 = " valid";

    return var_1;
}

isfiltered( var_0 )
{
    if ( getdvar( "bcs_filter" + var_0, "off" ) == "on" || getdvar( "bcs_filter" + var_0, "off" ) == "1" )
        return 1;

    return 0;
}

isvalidevent( var_0 )
{
    if ( !self.squad.ismembersaying[var_0] && !anim.isteamsaying[self.team][var_0] && gettime() < self.chatqueue[var_0].expiretime && gettime() > self.squad.nextsaytimes[var_0] )
    {
        if ( !typelimited( var_0, self.chatqueue[var_0].eventtype ) )
            return 1;
    }

    return 0;
}

typelimited( var_0, var_1 )
{
    if ( !isdefined( anim.eventtypeminwait[var_0][var_1] ) )
        return 0;

    if ( !isdefined( self.squad.nexttypesaytimes[var_0][var_1] ) )
        return 0;

    if ( gettime() > self.squad.nexttypesaytimes[var_0][var_1] )
        return 0;

    return 1;
}

dotypelimit( var_0, var_1 )
{
    if ( !isdefined( anim.eventtypeminwait[var_0][var_1] ) )
        return;

    self.squad.nexttypesaytimes[var_0][var_1] = gettime() + anim.eventtypeminwait[var_0][var_1];
}

bcissniper()
{
    if ( isplayer( self ) )
        return 0;

    if ( isexposed() )
        return 0;

    return animscripts\utility::issniperrifle( self.weapon );
}

isexposed()
{
    if ( distance( self.origin, level.player.origin ) > 1500 )
        return 0;

    if ( isdefined( getlocation() ) )
        return 0;

    var_0 = bcgetclaimednode();

    if ( !isdefined( var_0 ) )
        return 1;

    if ( !isnodecoverorconceal() )
        return 0;

    return 1;
}

isnodecoverorconceal()
{
    var_0 = self.node;

    if ( !isdefined( var_0 ) )
        return 0;

    if ( issubstr( var_0.type, "Cover" ) || issubstr( var_0.type, "Conceal" ) )
        return 1;

    return 0;
}

squadhasofficer( var_0 )
{
    if ( var_0.officercount > 0 )
        return 1;
    else
        return 0;
}

isofficer()
{
    var_0 = getrank();

    if ( !isdefined( var_0 ) )
        return 0;

    if ( var_0 == "sergeant" || var_0 == "lieutenant" || var_0 == "captain" || var_0 == "sergeant" )
        return 1;

    return 0;
}

bcgetclaimednode()
{
    if ( isplayer( self ) )
        return self.node;
    else
        return animscripts\utility::getclaimednode();
}

enemy_team_name()
{
    if ( self isbadguy() )
        return 1;
    else
        return 0;
}

getname()
{
    if ( enemy_team_name() )
        var_0 = self.ainame;
    else if ( self.team == "allies" )
        var_0 = self.name;
    else
        var_0 = undefined;

    if ( !isdefined( var_0 ) || voice_is_british_based() )
        return undefined;

    var_1 = strtok( var_0, " " );

    if ( var_1.size < 2 )
        return var_0;

    return var_1[1];
}

getrank()
{
    return self.airank;
}

getclosestfriendlyspeaker( var_0 )
{
    var_1 = getspeakers( var_0, self.team );
    var_2 = common_scripts\utility::getclosest( self.origin, var_1 );
    return var_2;
}

getspeakers( var_0, var_1 )
{
    var_2 = [];
    var_3 = getaiarray( var_1 );

    for ( var_4 = 0; var_4 < var_3.size; var_4++ )
    {
        if ( var_3[var_4] == self )
            continue;

        if ( !var_3[var_4] cansay( var_0 ) )
            continue;

        var_2[var_2.size] = var_3[var_4];
    }

    return var_2;
}

getresponder( var_0, var_1, var_2 )
{
    var_3 = undefined;

    if ( !isdefined( var_2 ) )
        var_2 = "response";

    var_4 = common_scripts\utility::array_randomize( self.squad.members );

    for ( var_5 = 0; var_5 < var_4.size; var_5++ )
    {
        if ( var_4[var_5] == self )
            continue;

        if ( !isalive( var_4[var_5] ) )
            continue;

        if ( distance( self.origin, var_4[var_5].origin ) > var_0 && distance( self.origin, var_4[var_5].origin ) < var_1 && !isusingsamevoice( var_4[var_5] ) && var_4[var_5] cansay( var_2 ) )
        {
            var_3 = var_4[var_5];

            if ( cansayname( var_3 ) )
                break;
        }
    }

    return var_3;
}

getlocation()
{
    var_0 = get_all_my_locations();
    var_0 = common_scripts\utility::array_randomize( var_0 );

    if ( var_0.size )
    {
        foreach ( var_2 in var_0 )
        {
            if ( !location_called_out_ever( var_2 ) )
                return var_2;
        }

        foreach ( var_2 in var_0 )
        {
            if ( !location_called_out_recently( var_2 ) )
                return var_2;
        }
    }

    return undefined;
}

get_all_my_locations()
{
    var_0 = anim.bcs_locations;
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( self istouching( var_3 ) && isdefined( var_3.locationaliases ) )
            var_1[var_1.size] = var_3;
    }

    return var_1;
}

is_in_callable_location()
{
    var_0 = get_all_my_locations();

    foreach ( var_2 in var_0 )
    {
        if ( !location_called_out_recently( var_2 ) )
            return 1;
    }

    return 0;
}

location_called_out_ever( var_0 )
{
    var_1 = location_get_last_callout_time( var_0 );

    if ( !isdefined( var_1 ) )
        return 0;

    return 1;
}

location_called_out_recently( var_0 )
{
    var_1 = location_get_last_callout_time( var_0 );

    if ( !isdefined( var_1 ) )
        return 0;

    var_2 = var_1 + anim.eventactionminwait["threat"]["location_repeat"];

    if ( gettime() < var_2 )
        return 1;

    return 0;
}

location_add_last_callout_time( var_0 )
{
    anim.locationlastcallouttimes[var_0.classname] = gettime();
}

location_get_last_callout_time( var_0 )
{
    if ( isdefined( anim.locationlastcallouttimes[var_0.classname] ) )
        return anim.locationlastcallouttimes[var_0.classname];

    return undefined;
}

getrelativeangles( var_0 )
{
    var_1 = var_0.angles;

    if ( !isplayer( var_0 ) )
    {
        var_2 = var_0 bcgetclaimednode();

        if ( isdefined( var_2 ) )
            var_1 = var_2.angles;
    }

    return var_1;
}

sideisleftright( var_0 )
{
    if ( var_0 == "left" || var_0 == "right" )
        return 1;

    return 0;
}

getdirectionfacingflank( var_0, var_1, var_2 )
{
    var_3 = vectortoangles( var_2 );
    var_4 = vectortoangles( var_1 - var_0 );
    var_5 = var_3[1] - var_4[1];
    var_5 += 360;
    var_5 = int( var_5 ) % 360;

    if ( var_5 > 315 || var_5 < 45 )
        var_6 = "front";
    else if ( var_5 < 135 )
        var_6 = "right";
    else if ( var_5 < 225 )
        var_6 = "rear";
    else
        var_6 = "left";

    return var_6;
}

normalizecompassdirection( var_0 )
{
    var_1 = undefined;

    switch ( var_0 )
    {
        case "north":
            var_1 = "n";
            break;
        case "northwest":
            var_1 = "nw";
            break;
        case "west":
            var_1 = "w";
            break;
        case "southwest":
            var_1 = "sw";
            break;
        case "south":
            var_1 = "s";
            break;
        case "southeast":
            var_1 = "se";
            break;
        case "east":
            var_1 = "e";
            break;
        case "northeast":
            var_1 = "ne";
            break;
        case "impossible":
            var_1 = "impossible";
            break;
        default:
            return;
    }

    return var_1;
}

getdirectioncompass( var_0, var_1 )
{
    var_2 = vectortoangles( var_1 - var_0 );
    var_3 = var_2[1];
    var_4 = getnorthyaw();
    var_3 -= var_4;

    if ( var_3 < 0 )
        var_3 += 360;
    else if ( var_3 > 360 )
        var_3 -= 360;

    if ( var_3 < 22.5 || var_3 > 337.5 )
        var_5 = "north";
    else if ( var_3 < 67.5 )
        var_5 = "northwest";
    else if ( var_3 < 112.5 )
        var_5 = "west";
    else if ( var_3 < 157.5 )
        var_5 = "southwest";
    else if ( var_3 < 202.5 )
        var_5 = "south";
    else if ( var_3 < 247.5 )
        var_5 = "southeast";
    else if ( var_3 < 292.5 )
        var_5 = "east";
    else if ( var_3 < 337.5 )
        var_5 = "northeast";
    else
        var_5 = "impossible";

    return var_5;
}

getfrontarcclockdirection( var_0 )
{
    var_1 = "undefined";

    if ( var_0 == "10" || var_0 == "11" )
        var_1 = "10";
    else if ( var_0 == "12" )
        var_1 = var_0;
    else if ( var_0 == "1" || var_0 == "2" )
        var_1 = "2";

    return var_1;
}

getdirectionfacingclock( var_0, var_1, var_2 )
{
    var_3 = anglestoforward( var_0 );
    var_4 = vectornormalize( var_3 );
    var_5 = vectortoangles( var_4 );
    var_6 = vectortoangles( var_2 - var_1 );
    var_7 = var_5[1] - var_6[1];
    var_7 += 360;
    var_7 = int( var_7 ) % 360;

    if ( var_7 > 345 || var_7 < 15 )
        var_8 = "12";
    else if ( var_7 < 45 )
        var_8 = "1";
    else if ( var_7 < 75 )
        var_8 = "2";
    else if ( var_7 < 105 )
        var_8 = "3";
    else if ( var_7 < 135 )
        var_8 = "4";
    else if ( var_7 < 165 )
        var_8 = "5";
    else if ( var_7 < 195 )
        var_8 = "6";
    else if ( var_7 < 225 )
        var_8 = "7";
    else if ( var_7 < 255 )
        var_8 = "8";
    else if ( var_7 < 285 )
        var_8 = "9";
    else if ( var_7 < 315 )
        var_8 = "10";
    else
        var_8 = "11";

    return var_8;
}

getvectorrightangle( var_0 )
{
    return ( var_0[1], 0 - var_0[0], var_0[2] );
}

getvectorarrayaverage( var_0 )
{
    var_1 = ( 0, 0, 0 );

    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
        var_1 += var_0[var_2];

    return ( var_1[0] / var_0.size, var_1[1] / var_0.size, var_1[2] / var_0.size );
}

addnamealias( var_0 )
{
    self.soundaliases[self.soundaliases.size] = self.owner.countryid + "_" + self.owner.npcid + "_name_" + var_0;
    anim.lastnamesaid[self.owner.team] = var_0;
    anim.lastnamesaidtime[self.owner.team] = gettime();
}

addplayernamealias()
{
    if ( !self.owner cansayplayername() )
        return;

    anim.lastplayernamecalltime = gettime();
    var_0 = self.owner.countryid + "_" + self.owner.npcid + "_name_player_" + level.player._id_AFF7 + "_" + level.player.bcnameid;
    self.soundaliases[self.soundaliases.size] = var_0;
    self.looktarget = level.player;
}

addrankalias( var_0 )
{
    self.soundaliases[self.soundaliases.size] = self.owner.countryid + "_" + self.owner.npcid + "_rank_" + var_0;
}

cansayname( var_0 )
{
    if ( enemy_team_name() )
        return 0;

    if ( !isdefined( var_0.bcname ) )
        return 0;

    if ( !isdefined( var_0.countryid ) )
        return 0;

    if ( self.countryid != var_0.countryid )
        return 0;

    if ( namesaidrecently( var_0 ) )
        return 0;

    var_1 = self.countryid + "_" + self.npcid + "_name_" + var_0.bcname;

    if ( soundexists( var_1 ) )
        return 1;

    return 0;
}

namesaidrecently( var_0 )
{
    if ( anim.lastnamesaid[self.team] == var_0.bcname && gettime() - anim.lastnamesaidtime[self.team] < anim.lastnamesaidtimeout )
        return 1;

    return 0;
}

cansayplayername()
{
    if ( enemy_team_name() )
        return 0;

    if ( !isdefined( level.player.bcnameid ) || !isdefined( level.player._id_AFF7 ) )
        return 0;

    if ( player_name_called_recently() )
        return 0;

    var_0 = self.countryid + "_" + self.npcid + "_name_player_" + level.player._id_AFF7 + "_" + level.player.bcnameid;

    if ( soundexists( var_0 ) )
        return 1;

    return 0;
}

player_name_called_recently()
{
    if ( !isdefined( anim.lastplayernamecalltime ) )
        return 0;

    if ( gettime() - anim.lastplayernamecalltime >= anim.eventtypeminwait["playername"] )
        return 0;

    return 1;
}

isusingsamevoice( var_0 )
{
    if ( isstring( self.npcid ) && isstring( var_0.npcid ) && self.npcid == var_0.npcid )
        return 1;
    else if ( !isstring( self.npcid ) && !isstring( var_0.npcid ) && self.npcid == var_0.npcid )
        return 1;
    else
        return 0;
}

addthreatalias( var_0, var_1 )
{
    var_2 = self.owner.countryid + "_" + self.owner.npcid + "_threat_" + var_0;

    if ( isdefined( var_1 ) )
        var_2 += ( "_" + var_1 );

    self.soundaliases = common_scripts\utility::array_add( self.soundaliases, var_2 );
    return 1;
}

addthreatexposedalias( var_0 )
{
    var_1 = self.owner.countryid + "_" + self.owner.npcid + "_exposed_" + var_0;
    self.soundaliases[self.soundaliases.size] = var_1;
    return 1;
}

addthreatobviousalias()
{
    var_0 = self.owner.countryid + "_" + self.owner.npcid + "_order_action_suppress";
    self.soundaliases[self.soundaliases.size] = var_0;
    return 1;
}

addthreatcalloutecho( var_0, var_1 )
{
    var_2 = createechoalias( var_0, var_1 );

    if ( !soundexists( var_2 ) )
        return 0;

    self.soundaliases[self.soundaliases.size] = var_2;
    return 1;
}

addthreatcalloutresponsealias( var_0 )
{
    var_1 = self.owner.countryid + "_" + self.owner.npcid + "_resp_ack_co_gnrc_" + var_0;

    if ( !soundexists( var_1 ) )
        return 0;

    self.soundaliases[self.soundaliases.size] = var_1;
    return 1;
}

addthreatcalloutqa_nextline( var_0, var_1, var_2 )
{
    var_3 = undefined;

    foreach ( var_5 in var_2.locationaliases )
    {
        if ( issubstr( var_1, var_5 ) )
        {
            var_3 = var_5;
            break;
        }
    }

    var_7 = self.owner.countryid + "_" + self.owner.npcid + "_co_";
    var_8 = getsubstr( var_1, var_1.size - 1, var_1.size );
    var_9 = int( var_8 ) + 1;
    var_10 = var_7 + var_3 + "_qa" + var_9;

    if ( !soundexists( var_10 ) )
    {
        if ( randomint( 100 ) < anim.eventchance["response"]["callout_negative"] )
            var_0 animscripts\battlechatter_ai::addresponseevent( "callout", "neg", self.owner, 0.9 );
        else
            var_0 animscripts\battlechatter_ai::addresponseevent( "exposed", "acquired", self.owner, 0.9 );

        var_2.qafinished = 1;
        return 0;
    }

    var_0 animscripts\battlechatter_ai::addresponseevent( "callout", "QA", self.owner, 0.9, var_10, var_2 );
    self.soundaliases[self.soundaliases.size] = var_10;
    return 1;
}

createechoalias( var_0, var_1 )
{
    var_2 = "_report";
    var_3 = "_echo";
    var_4 = self.owner.countryid + "_" + self.owner.npcid + "_";
    var_5 = var_0.size - var_2.size;
    var_6 = self.owner.countryid + "_" + var_1.npcid + "_";
    var_7 = var_6.size;
    var_8 = getsubstr( var_0, var_7, var_5 );
    var_9 = var_4 + var_8 + var_3;
    return var_9;
}

addthreatcalloutalias( var_0, var_1 )
{
    var_2 = self.owner.countryid + "_" + self.owner.npcid + "_callout_" + var_0 + "_" + var_1;
    self.soundaliases[self.soundaliases.size] = var_2;
    return 1;
}

addthreatcalloutlandmarkalias( var_0, var_1, var_2 )
{
    var_3 = var_0.script_landmark;

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    var_4 = self.owner.countryid + "_" + self.owner.npcid + "_callout_obj_" + var_3;

    if ( var_2 )
        var_4 += "_y";

    var_4 += ( "_" + var_1 );

    if ( !soundexists( var_4 ) )
        return 0;

    self.soundaliases[self.soundaliases.size] = var_4;
    return 1;
}

addthreatcalloutlocationalias( var_0 )
{
    var_1 = undefined;
    var_2 = var_0.locationaliases;
    var_3 = var_2[0];

    if ( var_2.size > 1 )
    {
        var_4 = undefined;
        var_4 = var_0 getcannedresponse( self.owner );

        if ( isdefined( var_4 ) )
            var_3 = var_4;
        else
            var_3 = common_scripts\utility::random( var_2 );
    }

    var_5 = undefined;

    if ( !isdefined( var_0.qafinished ) && iscallouttypeqa( var_3, self.owner ) )
        var_5 = self.owner getqacalloutalias( var_3, 0 );
    else
    {
        var_6 = self.owner.countryid + "_" + self.owner.npcid + "_";

        if ( !issubstr( var_3, "callout" ) )
            var_6 += "co_";

        var_5 = var_6 + var_3;
    }

    if ( soundexists( var_5 ) )
        var_1 = var_5;

    if ( !isdefined( var_1 ) )
        return 0;

    location_add_last_callout_time( var_0 );
    self.soundaliases[self.soundaliases.size] = var_1;
    return 1;
}

addinformalias( var_0, var_1 )
{
    var_2 = self.owner.countryid + "_" + self.owner.npcid + "_inform_" + var_0 + "_" + var_1;
    self.soundaliases[self.soundaliases.size] = var_2;
}

addresponsealias( var_0, var_1 )
{
    var_2 = self.owner.countryid + "_" + self.owner.npcid + "_response_" + var_0 + "_" + var_1;
    self.soundaliases[self.soundaliases.size] = var_2;
    return 1;
}

addreactionalias( var_0, var_1 )
{
    var_2 = self.owner.countryid + "_" + self.owner.npcid + "_reaction_" + var_0 + "_" + var_1;
    self.soundaliases[self.soundaliases.size] = var_2;
    return 1;
}

addcheckfirealias()
{
    var_0 = self.owner.countryid + "_" + self.owner.npcid + "_check_fire";
    self.soundaliases[self.soundaliases.size] = var_0;
    return 1;
}

addtauntalias( var_0, var_1 )
{
    var_2 = self.owner.countryid + "_" + self.owner.npcid + "_taunt";
    self.soundaliases[self.soundaliases.size] = var_2;
    return 1;
}

addhostileburstalias()
{
    var_0 = self.owner.countryid + "_" + self.owner.npcid + "_hostile_burst";
    self.soundaliases[self.soundaliases.size] = var_0;
    return 1;
}

addorderalias( var_0, var_1 )
{
    var_2 = self.owner.countryid + "_" + self.owner.npcid + "_order_" + var_0 + "_" + var_1;
    self.soundaliases[self.soundaliases.size] = var_2;
    return 1;
}

initcontact( var_0 )
{
    if ( !isdefined( self.squadlist[var_0].calledout ) )
        self.squadlist[var_0].calledout = 0;

    if ( !isdefined( self.squadlist[var_0].firstcontact ) )
        self.squadlist[var_0].firstcontact = 2000000000;

    if ( !isdefined( self.squadlist[var_0].lastcontact ) )
        self.squadlist[var_0].lastcontact = 0;
}

shutdowncontact( var_0 )
{
    self.squadlist[var_0].calledout = undefined;
    self.squadlist[var_0].firstcontact = undefined;
    self.squadlist[var_0].lastcontact = undefined;
}

createchatevent( var_0, var_1, var_2 )
{
    var_3 = spawnstruct();
    var_3.owner = self;
    var_3.eventtype = var_1;
    var_3.eventaction = var_0;

    if ( isdefined( var_2 ) )
        var_3.priority = var_2;
    else
        var_3.priority = anim.eventpriority[var_0][var_1];

    var_3.expiretime = gettime() + anim.eventduration[var_0][var_1];
    return var_3;
}

createchatphrase()
{
    var_0 = spawnstruct();
    var_0.owner = self;
    var_0.soundaliases = [];
    var_0.master = 0;
    return var_0;
}

pointinfov( var_0 )
{
    var_1 = anglestoforward( self.angles );
    var_2 = vectornormalize( var_0 - self.origin );
    var_3 = vectordot( var_1, var_2 );
    return var_3 > 0.766;
}

entinfrontarc( var_0 )
{
    var_1 = getdirectionfacingclock( self.angles, self.origin, var_0.origin );

    if ( var_1 == "9" || var_1 == "10" || var_1 == "11" || var_1 == "12" || var_1 == "1" || var_1 == "2" || var_1 == "3" )
        return 1;

    return 0;
}

squadflavorbursttransmissions()
{
    anim endon( "battlechatter disabled" );
    self endon( "squad_deleting" );

    if ( self.team != "allies" )
    {
        if ( level.script != "af_caves" )
            return;
    }

    while ( self.membercount <= 0 )
        wait 0.5;

    var_0 = 0;

    while ( isdefined( self ) )
    {
        if ( !squadcanburst( self ) )
        {
            var_0 = 1;
            wait 1;
            continue;
        }
        else if ( self.fbt_firstburst )
        {
            if ( !var_0 )
                wait( randomfloat( anim.fbt_waitmin ) );

            if ( var_0 )
                var_0 = 0;

            self.fbt_firstburst = 0;
        }
        else
        {
            if ( !var_0 )
                wait( randomfloatrange( anim.fbt_waitmin, anim.fbt_waitmax ) );

            if ( var_0 )
                var_0 = 0;
        }

        var_1 = getburster( self );

        if ( !isdefined( var_1 ) )
            continue;

        var_2 = var_1.voice;
        var_3 = getflavorburstid( self, var_2 );
        var_4 = getflavorburstaliases( var_2, var_3 );

        foreach ( var_8, var_6 in var_4 )
        {
            if ( !var_1 candoflavorburst() || distance( level.player.origin, var_1.origin ) > anim.fbt_desireddistmax )
            {
                for ( var_7 = 0; var_7 < self.members.size; var_7++ )
                {
                    var_1 = getburster( self );

                    if ( !isdefined( var_1 ) )
                        continue;

                    if ( var_1.voice == var_2 )
                        break;
                }

                if ( !isdefined( var_1 ) || var_1.voice != var_2 )
                    break;
            }

            thread playflavorburstline( var_1, var_6 );
            self waittill( "burst_line_done" );

            if ( var_8 != var_4.size - 1 )
                wait( randomfloatrange( anim.fbt_linebreakmin, anim.fbt_linebreakmax ) );
        }
    }
}

squadcanburst( var_0 )
{
    var_1 = 0;

    foreach ( var_3 in var_0.members )
    {
        if ( var_3 candoflavorburst() )
        {
            var_1 = 1;
            break;
        }
    }

    return var_1;
}

candoflavorburst()
{
    var_0 = 0;

    if ( !isplayer( self ) && isalive( self ) && self.classname != "actor_enemy_dog" && voicecanburst() && self.flavorbursts )
        var_0 = 1;

    return var_0;
}

voicecanburst()
{
    if ( isdefined( level.battlechatter[self.voice] ) && level.battlechatter[self.voice] )
        return 1;

    return 0;
}

getburster( var_0 )
{
    var_1 = undefined;
    var_2 = common_scripts\utility::get_array_of_farthest( level.player.origin, var_0.members );

    foreach ( var_4 in var_2 )
    {
        if ( var_4 candoflavorburst() )
        {
            var_1 = var_4;

            if ( !isdefined( var_0.fbt_lastbursterid ) )
                break;

            if ( isdefined( var_0.fbt_lastbursterid ) && var_0.fbt_lastbursterid == var_1.unique_id )
                continue;
        }
    }

    if ( isdefined( var_1 ) )
        var_0.fbt_lastbursterid = var_1.unique_id;

    return var_1;
}

getflavorburstid( var_0, var_1 )
{
    var_2 = common_scripts\utility::array_randomize( anim.flavorbursts[var_1] );

    if ( anim.flavorburstsused.size >= var_2.size )
        anim.flavorburstsused = [];

    var_3 = undefined;

    foreach ( var_5 in var_2 )
    {
        var_3 = var_5;

        if ( !flavorburstwouldrepeat( var_3 ) )
            break;
    }

    anim.flavorburstsused[anim.flavorburstsused.size] = var_3;
    return var_3;
}

flavorburstwouldrepeat( var_0 )
{
    if ( !anim.flavorburstsused.size )
        return 0;

    var_1 = 0;

    foreach ( var_3 in anim.flavorburstsused )
    {
        if ( var_3 == var_0 )
        {
            var_1 = 1;
            break;
        }
    }

    return var_1;
}

getflavorburstaliases( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 1;

    var_3 = var_2;
    var_4 = [];

    for (;;)
    {
        var_5 = "FB_" + anim.countryids[var_0] + "_" + var_1 + "_" + var_3;
        var_3++;

        if ( soundexists( var_5 ) )
        {
            var_4[var_4.size] = var_5;
            continue;
        }

        break;
    }

    return var_4;
}

playflavorburstline( var_0, var_1 )
{
    anim endon( "battlechatter disabled" );
    var_2 = spawn( "script_origin", var_0.origin );
    var_2 linkto( var_0 );
    var_2 playsound( var_1, var_1, 1 );
    var_2 waittill( var_1 );
    var_2 delete();

    if ( isdefined( self ) )
        self notify( "burst_line_done" );
}

flavorburstlinedebug( var_0, var_1 )
{
    self endon( "burst_line_done" );

    for (;;)
        wait 0.05;
}

battlechatter_canprint()
{
    return 0;
}

battlechatter_canprintdump()
{
    return 0;
}

battlechatter_print( var_0 )
{
    if ( var_0.size <= 0 )
        return;

    if ( !battlechatter_canprint() )
        return;

    var_1 = "^5 ";

    if ( enemy_team_name() )
        var_1 = "^6 ";

    foreach ( var_3 in var_0 )
    {

    }
}

battlechatter_printdump( var_0, var_1 )
{

}

getaliastypefromsoundalias( var_0 )
{
    var_1 = self.countryid + "_" + self.npcid + "_";
    var_2 = getsubstr( var_0, var_1.size, var_0.size );
    return var_2;
}

battlechatter_printdumpline( var_0, var_1, var_2 )
{
    if ( common_scripts\utility::flag( var_2 ) )
        common_scripts\utility::flag_wait( var_2 );

    common_scripts\utility::flag_set( var_2 );
    common_scripts\utility::flag_clear( var_2 );
}

bcdrawobjects()
{
    for ( var_0 = 0; var_0 < anim.bcs_locations.size; var_0++ )
    {
        var_1 = anim.bcs_locations[var_0].locationaliases;

        if ( !isdefined( var_1 ) )
            continue;

        var_2 = "";

        foreach ( var_4 in var_1 )
            var_2 += var_4;

        thread drawbcobject( "Location: " + var_2, anim.bcs_locations[var_0] getorigin(), ( 0, 0, 8 ), ( 1, 1, 1 ) );
    }
}

drawbcobject( var_0, var_1, var_2, var_3 )
{
    for (;;)
    {
        if ( distance( level.player.origin, var_1 ) > 2048 )
        {
            wait 0.1;
            continue;
        }

        wait 0.05;
    }
}

drawbcdirections( var_0, var_1, var_2 )
{
    var_3 = var_0 getorigin();

    for (;;)
    {
        if ( distance( level.player.origin, var_3 ) > 2048 )
        {
            wait 0.1;
            continue;
        }

        var_4 = getdirectioncompass( level.player.origin, var_3 );
        var_4 = normalizecompassdirection( var_4 );
        var_5 = getdirectionfacingclock( level.player.angles, level.player.origin, var_3 );
        var_6 = var_4 + ", " + var_5 + ":00";
        wait 0.05;
    }
}

resetnextsaytimes( var_0, var_1 )
{
    var_2 = getaiarray( var_0 );

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        var_4 = var_2[var_3];

        if ( !isalive( var_4 ) )
            continue;

        if ( !isdefined( var_4.battlechatter ) )
            continue;

        var_4.nextsaytimes[var_1] = gettime() + 350;
        var_4.squad.nextsaytimes[var_1] = gettime() + 350;
    }
}

voice_is_british_based()
{
    self endon( "death" );

    if ( self.voice == "british" || self.voice == "spanish" || self.voice == "italian" || self.voice == "german" )
        return 1;
    else
        return 0;
}

friendlyfire_warning()
{
    if ( !can_say_friendlyfire() )
        return 0;

    dotypelimit( "reaction", "friendlyfire" );
    thread playreactionevent();
    return 1;
}

can_say_friendlyfire( var_0 )
{
    if ( isdefined( self.friendlyfire_warnings_disable ) )
        return 0;

    if ( !isdefined( self.chatqueue ) )
        return 0;

    if ( !isdefined( self.chatqueue["reaction"] ) || !isdefined( self.chatqueue["reaction"].eventtype ) )
        return 0;

    if ( self.chatqueue["reaction"].eventtype != "friendlyfire" )
        return 0;

    if ( gettime() > self.chatqueue["reaction"].expiretime )
        return 0;

    if ( !isdefined( var_0 ) )
        var_0 = 1;

    if ( var_0 )
    {
        if ( isdefined( self.squad.nexttypesaytimes["reaction"]["friendlyfire"] ) )
        {
            if ( gettime() < self.squad.nexttypesaytimes["reaction"]["friendlyfire"] )
                return 0;
        }
    }

    return 1;
}
