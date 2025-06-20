
#include maps\_utility;
#include maps\_hud_util;
#include common_scripts\utility;
#include scripts\_copycat;
#include scripts\_func;

void() {}

structure()
{
    menu = self get_menu();
    if (!isdefined(menu)) menu = "unassigned";

    increment_controls = "[{+actionslot 3}] / [{+actionslot 4}] to use slider, no jump needed to select";
    slider_controls = "[{+actionslot 3}] / [{+actionslot 4}] to use slider, [{+gostand}] to select";
    credits = "made with ^:<3^7 by @nyli2b";
    map = getdvar("mapname");

    switch(menu)
    {
    case "bliss":
        self.is_bind_menu = false;
        self add_menu("bliss");
        self add_option("test", credits, ::void);
        break;
    case "all clients":
        self.is_bind_menu = false;
        self add_menu(menu);
        players = level.players;
        foreach (player in players)
        {
            option_text = player get_name();
            self add_option(option_text, undefined, ::new_menu, "player option");
        }
        break;
    case "menu info": // remove this later maybe lmfao
        self.is_bind_menu = false;
        self add_menu(menu);
        foreach (opt in menu_info)
            self add_category(opt);
        break;
    default: // shitty bind menu solution (but works :3)
        self player_index(menu, self.select_player);
        break;
    }
}

player_index(menu, player)
{
    if (!isdefined(player) || !isplayer(player))
        menu = "unassigned";

    switch(menu)
    {
    case "player option":
        self add_menu(player get_name());
        break;
    case "unassigned":
        self add_menu(menu);
        self add_option("this menu is unassigned");
        break;
    default:
        self add_menu("error");
        self add_option("unable to load " + menu);
        break;
    }
}