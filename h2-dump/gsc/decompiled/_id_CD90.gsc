// H2 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    maps\_hud::init();
    precachestring( &"RANK_PLAYER_WAS_PROMOTED_N" );
    precachestring( &"RANK_PLAYER_WAS_PROMOTED" );
    precachestring( &"RANK_PROMOTED" );
    precachestring( &"RANK_ROMANI" );
    precachestring( &"RANK_ROMANII" );
    precachestring( &"RANK_ROMANIII" );
    precachestring( &"SCRIPT_PLUS" );
    precacheshader( "line_horizontal" );
    precacheshader( "line_vertical" );
    precacheshader( "gradient_fadein" );
    precacheshader( "white" );
    level.maxrank = int( tablelookup( "sp/rankTable.csv", 0, "maxrank", 1 ) );
    level._id_AC48 = int( tablelookup( "sp/rankTable.csv", 0, level.maxrank, 7 ) );
    var_0 = 0;

    for ( var_0 = 0; var_0 <= level.maxrank; var_0++ )
        precacheshader( tablelookup( "sp/rankTable.csv", 0, var_0, 6 ) );

    var_1 = 0;

    for ( var_2 = tablelookup( "sp/ranktable.csv", 0, var_1, 1 ); isdefined( var_2 ) && var_2 != ""; var_2 = tablelookup( "sp/ranktable.csv", 0, var_1, 1 ) )
    {
        level.ranktable[var_1][1] = tablelookup( "sp/ranktable.csv", 0, var_1, 1 );
        level.ranktable[var_1][2] = tablelookup( "sp/ranktable.csv", 0, var_1, 2 );
        level.ranktable[var_1][3] = tablelookup( "sp/ranktable.csv", 0, var_1, 3 );
        level.ranktable[var_1][7] = tablelookup( "sp/ranktable.csv", 0, var_1, 7 );
        precachestring( tablelookupistring( "sp/ranktable.csv", 0, var_1, 10 ) );
        var_1++;
    }
}

_id_BA5C()
{
    _id_AD0E();

    foreach ( var_1 in level.players )
    {
        var_1 thread _id_ABC8();
        var_1 thread _id_CDED::updatechallenges();
    }
}

_id_ABC8()
{
    if ( !isdefined( self._id_B26C ) )
    {
        self._id_B26C["rankxp"] = self getplayerdata( "experience" );
        self._id_B26C["rank"] = _id_B475( self._id_B26C["rankxp"] );
    }

    _id_BBEB();
    self._id_CFF7 = 0;
    self._id_C439 = newclienthudelem( self );
    self._id_C439.horzalign = "center";
    self._id_C439.vertalign = "middle";
    self._id_C439.alignx = "center";
    self._id_C439.aligny = "middle";
    self._id_C439.x = 0;
    self._id_C439.y = -60;
    self._id_C439.font = "hudbig";
    self._id_C439.fontscale = 0.75;
    self._id_C439.archived = 0;
    self._id_C439.color = ( 0.75, 1, 0.75 );
    self._id_C439 fontpulseinit();
}

_id_BBEB()
{
    var_0 = self getlocalplayerprofiledata( "percentCompleteSO" );
    var_1 = int( var_0 / 100 );
    var_2 = getrank();
    var_3 = var_2 + var_1 * 100;
    self setlocalplayerprofiledata( "percentCompleteSO", var_3 );
}

_id_C4F1( var_0 )
{
    var_1 = newclienthudelem( var_0 );
    var_1.x = _id_B4DA() / 2 * -1;
    var_1.y = 0;
    var_1.sort = 5;
    var_1.horzalign = "center_adjustable";
    var_1.vertalign = "bottom_adjustable";
    var_1.alignx = "left";
    var_1.aligny = "bottom";
    var_1 setshader( "gradient_fadein", _id_C8D9(), 4 );
    var_1.color = ( 1, 0.8, 0.4 );
    var_1.alpha = 0.65;
    var_1.foreground = 1;
    return var_1;
}

_id_B4DA()
{
    if ( _func_145() )
        return 726;
    else
        return 540;
}

_id_AA46()
{
    if ( !_id_C8D9() )
        self._id_BB76.alpha = 0;
    else
        self._id_BB76.alpha = 0.65;

    self._id_BB76 setshader( "gradient_fadein", _id_C8D9(), 4 );
}

_id_C8D9()
{
    var_0 = int( tablelookup( "sp/rankTable.csv", 0, self._id_B26C["rank"], 3 ) );
    var_1 = int( self._id_B26C["rankxp"] - int( tablelookup( "sp/rankTable.csv", 0, self._id_B26C["rank"], 2 ) ) );
    var_2 = _id_B4DA();
    var_3 = int( var_2 * var_1 / var_0 );
    return var_3;
}

_id_AD0E()
{
    if ( !isdefined( level._id_B560 ) || !isdefined( level._id_B560.size ) )
        level._id_B560 = [];

    level.xpscale = 1;

    if ( level.console )
        level.xpscale = 1;

    _id_C9F1( "kill", 100 );
    _id_C9F1( "headshot", 100 );
    _id_C9F1( "assist", 20 );
    _id_C9F1( "suicide", 0 );
    _id_C9F1( "teamkill", 0 );
    _id_C9F1( "completion_xp", 5000 );
    level notify( "rank_score_info_defaults_set" );
}

_id_BA96()
{
    self waittill( "death", var_0, var_1, var_2 );

    if ( isdefined( var_0 ) && isdefined( var_0.classname ) && var_0.classname == "worldspawn" && isdefined( self.last_dmg_player ) )
        var_0 = self.last_dmg_player;

    _id_D166( var_0 );
}

_id_D166( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isai( var_0 ) && var_0 isbadguy() )
        return;

    if ( _id_C0F7( var_0 ) )
    {
        if ( isdefined( var_0.attacker ) )
        {
            thread _id_D166( var_0.attacker );
            return;
        }

        if ( isdefined( var_0.damageowner ) )
        {
            thread _id_D166( var_0.damageowner );
            return;
        }
    }

    if ( isplayer( var_0 ) )
    {
        if ( isdefined( level._id_AAC9 ) )
            var_0 thread [[ level._id_AAC9 ]]( self );
        else
            var_0 thread maps\_utility::givexp( "kill" );
    }

    if ( maps\_utility::is_survival() )
    {
        if ( isai( var_0 ) && !var_0 isbadguy() && isdefined( var_0.owner ) && isplayer( var_0.owner ) )
        {
            if ( isdefined( level._id_AAC9 ) )
                var_0.owner thread [[ level._id_AAC9 ]]( self );
            else
                var_0.owner thread maps\_utility::givexp( "kill" );
        }
    }

    if ( !isplayer( var_0 ) && !isai( var_0 ) )
        return;

    if ( !var_0 isbadguy() && isdefined( self._id_AE81 ) && self._id_AE81.size )
    {
        for ( var_1 = 0; var_1 < self._id_AE81.size; var_1++ )
        {
            if ( isplayer( self._id_AE81[var_1] ) && self._id_AE81[var_1] != var_0 )
            {
                if ( isdefined( self._id_CA46 ) )
                {
                    self._id_AE81[var_1] thread maps\_utility::givexp( "assist", self._id_CA46 );
                    continue;
                }

                self._id_AE81[var_1] thread maps\_utility::givexp( "assist" );
            }
        }
    }
}

_id_C0F7( var_0 )
{
    if ( !isdefined( var_0.targetname ) )
        return 0;

    if ( issubstr( var_0.targetname, "destructible" ) )
        return 1;

    if ( common_scripts\utility::string_starts_with( var_0.targetname, "sentry_" ) )
        return 1;

    return 0;
}

_id_CEE4()
{
    thread _id_BA96();
    self._id_AE81 = [];
    self._id_C749 = 0;
    maps\_utility::add_damage_function( ::_id_AFEE );
}

_id_AFEE( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( !isdefined( var_1 ) )
        return;

    if ( !isdefined( self ) )
        return;

    var_7 = gettime();
    var_8 = var_7 - self._id_C749;

    if ( var_8 <= 10000 )
    {
        self._id_AE81 = common_scripts\utility::array_remove( self._id_AE81, var_1 );
        self._id_AE81[self._id_AE81.size] = var_1;
        self._id_C749 = gettime();
        return;
    }

    self._id_AE81 = [];
    self._id_AE81[0] = var_1;
    self._id_C749 = gettime();
}

_id_BE91( var_0, var_1 )
{
    if ( !isdefined( level.xp_enable ) || !level.xp_enable )
        return;

    if ( !isdefined( var_1 ) )
    {
        if ( isdefined( level._id_B560[var_0] ) )
            var_1 = getscoreinfovalue( var_0 );
        else
            var_1 = getscoreinfovalue( "kill" );
    }

    if ( level.xpscale > 1 )
        var_1 = int( var_1 * level.xpscale );
    else if ( self getplayerdata( "rankedMatchData", "hasDoubleXPItem" ) )
        var_1 = int( var_1 * 2 );

    if ( var_0 == "assist" )
    {
        if ( var_1 > getscoreinfovalue( "kill" ) )
            var_1 = getscoreinfovalue( "kill" );
    }

    thread _id_C182( var_1 );
    self._id_B26C["rankxp"] += var_1;

    if ( updaterank() )
    {
        thread updaterankannouncehud();
        _id_BBEB();
    }

    if ( self._id_B26C["rankxp"] <= level._id_AC48 )
        self setplayerdata( "experience", self._id_B26C["rankxp"] );

    if ( self._id_B26C["rankxp"] > level._id_AC48 )
        self setplayerdata( "experience", level._id_AC48 );

    waittillframeend;
    self notify( "xp_updated", var_0 );
}

_id_C182( var_0 )
{
    self notify( "update_xp" );
    self endon( "update_xp" );
    self._id_CFF7 += var_0;
    self._id_C439.label = &"SCRIPT_PLUS";
    self._id_C439 setvalue( self._id_CFF7 );
    self._id_C439.alpha = 0.75;
    self._id_C439 thread fontpulse( self );
    self._id_C439.x = 0;
    self._id_C439.y = -60;
    wait 1;
    self._id_C439 fadeovertime( 0.2 );
    self._id_C439.alpha = 0;
    self._id_C439 moveovertime( 0.2 );
    self._id_C439.x = -240;
    self._id_C439.y = 160;
    wait 0.5;
    self._id_C439.x = 0;
    self._id_C439.y = -60;
    self._id_CFF7 = 0;
}

fontpulseinit()
{
    self.basefontscale = self.fontscale;
    self.maxfontscale = self.fontscale * 2;
    self.inframes = 3;
    self.outframes = 5;
}

fontpulse( var_0 )
{
    self notify( "fontPulse" );
    self endon( "fontPulse" );
    var_1 = self.maxfontscale - self.basefontscale;

    while ( self.fontscale < self.maxfontscale )
    {
        self.fontscale = min( self.maxfontscale, self.fontscale + var_1 / self.inframes );
        wait 0.05;
    }

    while ( self.fontscale > self.basefontscale )
    {
        self.fontscale = max( self.basefontscale, self.fontscale - var_1 / self.outframes );
        wait 0.05;
    }
}

updaterank()
{
    var_0 = getrank();

    if ( var_0 == self._id_B26C["rank"] )
        return 0;

    var_1 = self._id_B26C["rank"];
    var_2 = self._id_B26C["rank"];

    for ( self._id_B26C["rank"] = var_0; var_2 <= var_0; var_2++ )
        self._id_B93C = 1;

    return 1;
}

updaterankannouncehud()
{
    self endon( "disconnect" );
    self notify( "update_rank" );
    self endon( "update_rank" );
    self notify( "reset_outcome" );
    var_0 = getrankinfofull( self._id_B26C["rank"] );
    var_1 = spawnstruct();
    var_1.titletext = &"RANK_PROMOTED";
    var_1.iconname = _id_B2F0( self._id_B26C["rank"] );
    var_1.sound = "sp_level_up";
    var_1.duration = 4.0;
    var_2 = level.ranktable[self._id_B26C["rank"]][1];
    var_3 = int( var_2[var_2.size - 1] );
    var_1.notifytext = var_0;

    if ( common_scripts\utility::flag_exist( "special_op_final_xp_given" ) && common_scripts\utility::flag( "special_op_final_xp_given" ) )
        level._id_AEB9 = int( max( 0, var_1.duration - 2 ) );

    thread notifymessage( var_1 );

    if ( var_3 > 1 )
        return;
}

notifymessage( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_1 = 4;

    while ( self._id_C6F5 && var_1 > 0 )
    {
        var_1 -= 0.5;
        wait 0.5;
    }

    thread shownotifymessage( var_0 );
}

stringtofloat( var_0 )
{
    var_1 = strtok( var_0, "." );
    var_2 = int( var_1[0] );

    if ( isdefined( var_1[1] ) )
    {
        var_3 = 1;

        for ( var_4 = 0; var_4 < var_1[1].size; var_4++ )
            var_3 *= 0.1;

        var_2 += int( var_1[1] ) * var_3;
    }

    return var_2;
}

actionnotifymessage( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_1 = var_0.slot;

    if ( tablelookup( "sp/splashTable.csv", 0, var_0.name, 0 ) != "" )
    {
        if ( isdefined( var_0.optionalnumber ) )
            self showhudsplash( var_0.name, var_0.slot, var_0.optionalnumber );
        else
            self showhudsplash( var_0.name, var_0.slot );

        self.doingsplash[var_1] = var_0;
        var_2 = stringtofloat( tablelookup( "sp/splashTable.csv", 0, var_0.name, 4 ) );

        if ( isdefined( var_0.sound ) )
            self playlocalsound( var_0.sound );

        self notify( "actionNotifyMessage" + var_1 );
        self endon( "actionNotifyMessage" + var_1 );
        wait( var_2 - 0.05 );
        self.doingsplash[var_1] = undefined;
    }

    if ( self.splashqueue[var_1].size )
        thread dispatchnotify( var_1 );
}

_id_C726( var_0, var_1 )
{
    var_2 = [];

    for ( var_3 = 0; var_3 < self.splashqueue[var_1].size; var_3++ )
    {
        if ( self.splashqueue[var_1][var_3].type != "killstreak" )
            var_2[var_2.size] = self.splashqueue[var_1][var_3];
    }

    self.splashqueue[var_1] = var_2;
}

actionnotify( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );
    var_1 = var_0.slot;

    if ( !isdefined( var_0.type ) )
        var_0.type = "";

    if ( !isdefined( self.doingsplash[var_1] ) )
    {
        thread actionnotifymessage( var_0 );
        return;
    }
    else if ( var_0.type == "killstreak" && self.doingsplash[var_1].type != "challenge" && self.doingsplash[var_1].type != "rank" )
    {
        self.notifytext.alpha = 0;
        self.notifytext2.alpha = 0;
        self.notifyicon.alpha = 0;
        thread actionnotifymessage( var_0 );
        return;
    }
    else if ( var_0.type == "challenge" && self.doingsplash[var_1].type != "killstreak" && self.doingsplash[var_1].type != "challenge" && self.doingsplash[var_1].type != "rank" )
    {
        self.notifytext.alpha = 0;
        self.notifytext2.alpha = 0;
        self.notifyicon.alpha = 0;
        thread actionnotifymessage( var_0 );
        return;
    }

    if ( var_0.type == "challenge" || var_0.type == "killstreak" )
    {
        if ( var_0.type == "killstreak" )
            _id_C726( "killstreak", var_1 );

        for ( var_2 = self.splashqueue[var_1].size; var_2 > 0; var_2-- )
            self.splashqueue[var_1][var_2] = self.splashqueue[var_1][var_2 - 1];

        self.splashqueue[var_1][0] = var_0;
    }
    else
        self.splashqueue[var_1][self.splashqueue[var_1].size] = var_0;
}

shownotifymessage( var_0 )
{
    self endon( "disconnect" );
    self._id_C6F5 = 1;
    waitrequirevisibility( 0 );

    if ( isdefined( var_0.duration ) )
        var_1 = var_0.duration;
    else
        var_1 = 4.0;

    thread resetoncancel();

    if ( isdefined( var_0.sound ) )
        self playlocalsound( var_0.sound );

    if ( isdefined( var_0.glowcolor ) )
        var_2 = var_0.glowcolor;
    else
        var_2 = ( 0.3, 0.6, 0.3 );

    var_3 = self.notifytitle;

    if ( isdefined( var_0.titletext ) )
    {
        if ( isdefined( var_0.titlelabel ) )
            self.notifytitle.label = var_0.titlelabel;
        else
            self.notifytitle.label = &"";

        if ( isdefined( var_0.titlelabel ) && !isdefined( var_0.titleisstring ) )
            self.notifytitle setvalue( var_0.titletext );
        else
            self.notifytitle settext( var_0.titletext );

        self.notifytitle setpulsefx( 100, int( var_1 * 1000 ), 1000 );
        self.notifytitle.glowcolor = var_2;
        self.notifytitle.alpha = 1;
    }

    if ( isdefined( var_0.notifytext ) )
    {
        if ( isdefined( var_0.textlabel ) )
            self.notifytext.label = var_0.textlabel;
        else
            self.notifytext.label = &"";

        if ( isdefined( var_0.textlabel ) && !isdefined( var_0.textisstring ) )
            self.notifytext setvalue( var_0.notifytext );
        else
            self.notifytext settext( var_0.notifytext );

        self.notifytext setpulsefx( 100, int( var_1 * 1000 ), 1000 );
        self.notifytext.glowcolor = var_2;
        self.notifytext.alpha = 1;
        var_3 = self.notifytext;
    }

    if ( isdefined( var_0.notifytext2 ) )
    {
        self.notifytext2 maps\_hud_util::setparent( var_3 );

        if ( isdefined( var_0.text2label ) )
            self.notifytext2.label = var_0.text2label;
        else
            self.notifytext2.label = &"";

        self.notifytext2 settext( var_0.notifytext2 );
        self.notifytext2 setpulsefx( 100, int( var_1 * 1000 ), 1000 );
        self.notifytext2.glowcolor = var_2;
        self.notifytext2.alpha = 1;
        var_3 = self.notifytext2;
    }

    if ( isdefined( var_0.iconname ) )
    {
        self.notifyicon maps\_hud_util::setparent( var_3 );
        self.notifyicon setshader( var_0.iconname, 60, 60 );
        self.notifyicon.alpha = 0;
        self.notifyicon fadeovertime( 1.0 );
        self.notifyicon.alpha = 1;
        waitrequirevisibility( var_1 );
        self.notifyicon fadeovertime( 0.75 );
        self.notifyicon.alpha = 0;
    }
    else
        waitrequirevisibility( var_1 );

    self notify( "notifyMessageDone" );
    self._id_C6F5 = 0;
}

resetoncancel()
{
    self notify( "resetOnCancel" );
    self endon( "resetOnCancel" );
    self endon( "notifyMessageDone" );
    self endon( "disconnect" );
    level waittill( "cancel_notify" );
    self.notifytitle.alpha = 0;
    self.notifytext.alpha = 0;
    self.notifyicon.alpha = 0;
    self._id_C6F5 = 0;
}

waitrequirevisibility( var_0 )
{
    var_1 = 0.05;

    while ( !canreadtext() )
        wait( var_1 );

    while ( var_0 > 0 )
    {
        wait( var_1 );

        if ( canreadtext() )
            var_0 -= var_1;
    }
}

canreadtext()
{
    if ( isflashbanged() )
        return 0;

    return 1;
}

isflashbanged()
{
    return isdefined( self.flashendtime ) && gettime() < self.flashendtime;
}

dispatchnotify( var_0 )
{
    var_1 = self.splashqueue[var_0][0];

    for ( var_2 = 1; var_2 < self.splashqueue[var_0].size; var_2++ )
        self.splashqueue[var_0][var_2 - 1] = self.splashqueue[var_0][var_2];

    self.splashqueue[var_0][var_2 - 1] = undefined;

    if ( isdefined( var_1.name ) )
        actionnotify( var_1 );
    else
        shownotifymessage( var_1 );
}

_id_C9F1( var_0, var_1 )
{
    level._id_B560[var_0]["value"] = var_1;
}

getscoreinfovalue( var_0 )
{
    return level._id_B560[var_0]["value"];
}

getrankinfominxp( var_0 )
{
    return int( level.ranktable[var_0][2] );
}

getrankinfoxpamt( var_0 )
{
    return int( level.ranktable[var_0][3] );
}

getrankinfomaxxp( var_0 )
{
    return int( level.ranktable[var_0][7] );
}

getrankinfofull( var_0 )
{
    return tablelookupistring( "sp/ranktable.csv", 0, var_0, 5 );
}

_id_B2F0( var_0 )
{
    return tablelookup( "sp/rankTable.csv", 0, var_0, 6 );
}

getrank()
{
    return 3;
}

_id_B475( var_0 )
{
    var_1 = 0;
    var_2 = level.ranktable[var_1][1];

    while ( isdefined( var_2 ) && var_2 != "" )
    {
        if ( var_0 < getrankinfominxp( var_1 ) + getrankinfoxpamt( var_1 ) )
            return var_1;

        var_1++;

        if ( isdefined( level.ranktable[var_1] ) )
        {
            var_2 = level.ranktable[var_1][1];
            continue;
        }

        var_2 = undefined;
    }

    var_1--;
    return var_1;
}

getrankxp()
{
    return self getplayerdata( "experience" );
}
