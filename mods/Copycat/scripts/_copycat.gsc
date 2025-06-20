
#include maps\_utility;
#include maps\_hud_util;
#include common_scripts\utility;
#include scripts\_func;
#include scripts\_menu;
#include scripts\_structure;
#include scripts\_util;

/#                  
    Copycat - H2
    Start: 8/13/24
#/

init() 
{
	//replacefunc(maps\_introscreen::h2_roadkill_intro, ::roadkill_intro);
    replacefunc(maps\_gameskill::should_show_cover_warning, ::ret_false);
    replacefunc(maps\_load::_id_B3AD, ::_id_B3AD);
    replacefunc(maps\_introscreen::_id_CB9B, ::ret_false);
    replacefunc(maps\_introscreen::_id_CB57, ::ret_false);
    common_scripts\utility::array_thread(getentarray("intelligence_item", "targetname"), ::delete_intel);
    
    intel = getentarray("intelligence_item", "targetname");
    foreach (i in intel)
    {
        getent(i.target, "targetname") delete();
        i delete();
    }

	setdynamicdvar("jump_enableFallDamage", 0);
	setdynamicdvar("pm_bouncing", 1);
	setdynamicdvar("safeArea_vertical", 0.89);
	setdynamicdvar("safeArea_horizontal", 0.89);
	setdynamicdvar("safearea_adjusted_vertical", 0.89);
	setdynamicdvar("safearea_adjusted_horizontal", 0.89);
	setdynamicdvar("g_gravity", 685);
	
    thread on_spawned();
}

on_spawned() 
{
	foreach(player in players()) 
    {
        /*
        if (!isdefined(player.menu_init)) // do this last so shit doesnt bug out
        {
            if (!isdefined(player.menu))
                player.menu = [];

            player overflow_fix_init(); // kinda works lol - it'll do
            player thread initial_variable(); // some other player threads are in here - _menu.gsc
            player thread initial_monitor();
            player thread create_notify();
            player.menu_init = true;
            player.first_spawn = true;
            // player freezecontrols(0);
        }  
        */

        player monitor_buttons();
		player init_classes();
		player func_manager();
	}
}

players()
{
    return level.players;
}
