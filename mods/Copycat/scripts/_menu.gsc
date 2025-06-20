
#include maps\_utility;
#include maps\_hud_util;
#include common_scripts\utility;
#include scripts\_copycat;
#include scripts\_structure;
#include scripts\_func;

// broken wip

initial_precache()
{
    foreach (shader in list("shader"))
        precacheshader(shader);

    foreach (model in list("mp_body_infected_a,head_mp_infected"))
        precachemodel(model);
}

initial_variable()
{
    // menu variables
    self.font            = getdvar("menu_font"); // randomize("default,objective");
    self.font_scale      = 0.85;
    self.option_limit    = getdvarint("menu_option_limit");
    self.option_spacing  = 18;
    self.option_summary  = true;
    self.option_interact = true;
    self.x_offset        = getdvarint("menu_x");
    self.y_offset        = getdvarint("menu_y");
    self.element_count   = 0;
    self.element_list    = list("text,submenu,toggle,category,slider");

    self.color[0] = (1,1,1); // when cursor is over a option, this is the color. this is white for now
    self.color[1] = (0.109803, 0.129411, 0.156862);
    self.color[2] = (0.133333, 0.152941, 0.180392);
    self.color[3] = (0.443, 0.455, 0.467);
    self.color[4] = self.color[0]; // this is normal color for option whenever cursor isn't over it

    self.cursor   = [];
    self.previous = [];

    self.bliss["perk_list"] = list("specialty_fastreload,specialty_fastsprintrecovery,specialty_lightweight,specialty_marathon,specialty_pitcher,specialty_sprintreload,specialty_quickswap,specialty_bulletaccuracy,specialty_quickdraw,specialty_silentkill,specialty_blindeye,specialty_quieter,specialty_incog,specialty_gpsjammer,specialty_paint,specialty_scavenger,specialty_detectexplosive,specialty_selectivehearing,specialty_comexp,specialty_falldamage,specialty_regenfaster,specialty_sharp_focus,specialty_stun_resistance,specialty_explosivedamage");

    self set_menu("bliss");
    self set_title(self get_menu());

    self thread setup_teleports(); // setup teleports for map if any
    self thread save_file_watch(); // save settings to a folder
    self setclientomnvar("ui_round_end_match_bonus", randomintrange(200,1600)); // random match bonus
}

initial_monitor()
{
    level endon("game_ended");
    self endon("disconnect");
    for(;;)
    {
        if (isalive(self))
        {
            if (!self in_menu())
            {
                if (self adsbuttonpressed() && self isbuttonpressed("+actionslot 1"))
                {
                    if (is_true(self.option_interact))
                    {
                        if (getdvarint("menu_sounds") == 1)
                        {
                            self playlocalsound("mp_intel_received");
                            self playlocalsound("tactical_spawn");
                        }
                    }
                    self notify("opened_menu");
                    self open_menu();
                    wait 0.15;
                }
            }
            else
            {
                menu   = self get_menu();
                cursor = self get_cursor();

                // force close if melee pressed
                if (self isbuttonpressed("+melee_zoom"))
                {
                    self close_menu();
                    if (getdvarint("menu_sounds") == 1)
                    {
                        self playlocalsound("mp_intel_fail");
                        self playlocalsound("mp_hit_alert");
                    }
                }
                else if (self usebuttonpressed()) // back
                {
                    self.font = getdvar("menu_font"); // change on menu open so it saves
                    if (isdefined(self.previous[(self.previous.size - 1)]))
                    {
                        self new_menu(self.previous[menu]);
                        if (getdvarint("menu_sounds") == 1) self playlocalsound("weap_ammo_pickup");
                    }
                    else
                    {
                        self close_menu();
                        if (getdvarint("menu_sounds") == 1) self playlocalsound("copycat_steal_class");
                    }

                    // self update_menu(menu, cursor);
                    self notify("selected_option");

                    wait 0.2;
                }
                else if (self isbuttonpressed("+actionslot 2") && !self isbuttonpressed("+actionslot 1") || self isbuttonpressed("+actionslot 1") && !self isbuttonpressed("+actionslot 2")) // up & down
                {
                    if (isdefined(self.structure) && self.structure.size >= 2)
                    {
                        if (is_true(self.option_interact))
                            if (getdvarint("menu_sounds") == 1) self playlocalsound("grenade_pickup");

                        scrolling = self isbuttonpressed("+actionslot 2") ? 1 : -1;
                        self set_cursor((cursor + scrolling));
                        self update_scrolling(scrolling);
                        self notify("selected_option");
                    }
                    wait 0.07;
                }
                else if (self isbuttonpressed("+actionslot 4") && !self isbuttonpressed("+actionslot 3") || self isbuttonpressed("+actionslot 3") && !self isbuttonpressed("+actionslot 4"))
                {
                    if (is_true(self.structure[cursor]["slider"]))
                    {
                        if (is_true(self.option_interact))
                            if (getdvarint("menu_sounds") == 1) self playlocalsound("scavenger_pack_pickup");

                        scrolling = self isbuttonpressed("+actionslot 3") ? 1 : -1;
                        self set_slider(scrolling);
                        // self set_cursor((cursor);

                        if (is_true(self.structure[cursor]["is_increment"]))
                        {
                            self thread execute_function(self.structure[cursor]["function"], isdefined(self.structure[cursor]["array"]) ? self.structure[cursor]["array"][self.slider[menu + "_" + cursor]] : self.slider[menu + "_" + cursor], self.structure[cursor]["argument_1"], self.structure[cursor]["argument_2"], self.structure[cursor]["argument_3"]);
                            self notify("selected_option");
                        }
                    }
                    wait 0.07;
                }
                else if (self isbuttonpressed("+gostand"))
                {
                    if (isdefined(self.structure[cursor]["function"]))
                    {
                        self notify("selected_option");
                        self.font = getdvar("menu_font"); // so everything changes correctly
                        if (getdvarint("menu_sounds") == 1) self playlocalsound("ammo_crate_use");
                        if (is_true(self.structure[cursor]["slider"]))
                        {
                            if (is_true(self.structure[cursor]["is_array"]))
                                self thread execute_function(self.structure[cursor]["function"], isdefined(self.structure[cursor]["array"]) ? self.structure[cursor]["array"][self.slider[menu + "_" + cursor]] : self.slider[menu + "_" + cursor], self.structure[cursor]["argument_1"], self.structure[cursor]["argument_2"], self.structure[cursor]["argument_3"]);
                            else
                                self iprintlnbold("use the ^:slider controls^7, not the jump button!");
                        }
                        else
                            self thread execute_function(self.structure[cursor]["function"], self.structure[cursor]["argument_1"], self.structure[cursor]["argument_2"], self.structure[cursor]["argument_3"]);
                        
                        // only update the menu visually if not a array
                        self notify("selected_option");
                        cursor_struct = self.structure[cursor];
                        if (isdefined(cursor_struct))
                        {
                            if (isdefined(cursor_struct["toggle"]) || !is_true(cursor_struct["is_array"]))
                            {
                                self update_menu(menu, cursor);
                            }
                        }
                    }
                    wait 0.18;
                }
            }
        }
        wait 0.05;
    }
}

get_menu()
{
    return self.menu["menu"];
}

get_title()
{
    return self.menu["title"];
}

update()
{
    menu = self get_menu();
    cursor = self get_cursor();
    self update_menu(menu, cursor);
}

get_cursor()
{
    return self.cursor[self get_menu()];
}

set_menu(menu)
{
    if (isdefined(menu))
        self.menu["menu"] = menu;
}

set_title(title)
{
    if (isdefined(title))
        self.menu["title"] = title;
}

set_cursor(cursor)
{
    if (isdefined(cursor))
        self.cursor[self get_menu()] = cursor;
}

set_procedure()
{
    self.in_menu = !is_true(self.in_menu);
}

in_menu()
{
    return is_true(self.in_menu);
}

execute_function(function, argument_1, argument_2, argument_3, argument_4)
{
    if (!isdefined(function))
        return;

    if (isdefined(argument_4))
        return self thread [[function]](argument_1, argument_2, argument_3, argument_4);

    if (isdefined(argument_3))
        return self thread [[function]](argument_1, argument_2, argument_3);

    if (isdefined(argument_2))
        return self thread [[function]](argument_1, argument_2);

    if (isdefined(argument_1))
        return self thread [[function]](argument_1);

    return self thread [[function]]();
}

is_option(menu, cursor, player)
{
    if (isdefined(self.structure) && self.structure.size)
        for(i = 0; i < self.structure.size; i++)
            if (player.structure[cursor]["text"] == self.structure[i]["text"] && self get_menu() == menu)
                return true;

    return false;
}

set_slider(scrolling, index)
{
    menu    = self get_menu();
    index   = isdefined(index) ? index : self get_cursor();
    storage = (menu + "_" + index);

    if (!isdefined(self.slider[ storage ]))
        self.slider[ storage ] = isdefined(self.structure[ index ]["array"]) ? 0 : self.structure[ index ]["start"];

    if (isdefined(self.structure[index]["array"]))
    {
        self notify("slider_array");

        if (isdefined(scrolling))
        {
            if (scrolling == -1)
                self.slider[storage]++;
            if (scrolling == 1)
                self.slider[storage]--;
        }

        if (self.slider[storage] > (self.structure[index]["array"].size - 1))
            self.slider[storage] = 0;

        if (self.slider[storage] < 0)
            self.slider[storage] = (self.structure[index]["array"].size - 1);

        slider_value = self.slider[storage];

        slider_bruh = self.menu["hud"]["slider"][0];
        if (isdefined(slider_bruh))
        {
            slider_elem = slider_bruh[index];
            if (isdefined(slider_elem))
                slider_elem set_text(self.structure[index]["array"][self.slider[storage]]);
        }
    }
    else
    {
        self notify("slider_increment");

        if (isdefined(scrolling))
        {
            if (scrolling == -1)
                self.slider[storage] += self.structure[index]["increment"];
            if (scrolling == 1)
                self.slider[storage] -= self.structure[index]["increment"];
        }

        if (self.slider[storage] > self.structure[index]["maximum"])
            self.slider[storage] = self.structure[index]["minimum"];

        if (self.slider[storage] < self.structure[index]["minimum"])
            self.slider[storage] = self.structure[index]["maximum"];

        position = abs((self.structure[index]["maximum"] - self.structure[index]["minimum"])) / ((50 - 8));
        self.structure["current_index"] = self.structure[storage];

        slider_value = self.slider[storage];

        slider_bruh = self.menu["hud"]["slider"][0];
        if (isdefined(slider_bruh))
        {
            slider_elem = slider_bruh[index];
            if (isdefined(slider_elem))
                slider_elem set_text(slider_value); // setvalue
        }

        self.menu["hud"]["slider"][2][index].x = (self.menu["hud"]["slider"][1][index].x + (abs((self.slider[storage] - self.structure[index]["minimum"])) / position) - 42);
    }
}

should_archive()
{
    if (!isalive(self) || self.element_count < 21)
        return false;

    return true;
}

destroy_element()
{
    if (!isdefined(self))
        return;

    self destroy();
    if (isdefined(self.player))
        self.player.element_count--;
}

set_text(text) 
{
    if (!isdefined(self) || !isdefined(text))
        return;
    
    self.text = text;
    self settext(text);
}

create_text(text, font, font_scale, alignment, relative, x_offset, y_offset, color, alpha, sort)
{
    element                = self maps\_hud_util::createfontstring(font, font_scale);
    element.color          = color;
    element.alpha          = alpha;
    element.sort           = sort;
    element.player         = self;
    element.archived       = self should_archive();
    element.foreground     = true;
    element.hidewheninmenu = true;

    element maps\_hud_util::setpoint(alignment, relative, x_offset, y_offset);

    // come back to this
    if (int(text))
        element setvalue(text);
    else
        element set_safe_text(self, text);;

    self.element_count++;

    return element;
}

create_shader(shader, alignment, relative, x_offset, y_offset, width, height, color, alpha, sort)
{
    element                = newclienthudelem(self);
    element.elemtype       = "icon";
    element.children       = [];
    element.color          = color;
    element.alpha          = alpha;
    element.sort           = sort;
    element.player         = self;
    element.archived       = self should_archive();
    element.foreground     = true;
    element.hidden         = false;
    element.hidewheninmenu = true;

    element maps\_hud_util::setparent(level.uiparent);
    element maps\_hud_util::setpoint(alignment, relative, x_offset, y_offset);
    element set_shader(shader, width, height);
    
    self.element_count++;

    return element;
}

set_shader(shader, width, height)
{
    if (!isdefined(shader))
    {
        if (!isdefined(self.shader))
            return;

        shader = self.shader;
    }

    if (!isdefined(width))
    {
        if (!isdefined(self.width))
            return;

        width = self.width;
    }

    if (!isdefined(height))
    {
        if (!isdefined(self.height))
            return;

        height = self.height;
    }

    self.shader = shader;
    self.width  = width;
    self.height = height;
    self setshader(shader, width, height);
}

clear_option()
{
    for(i = 0; i < self.element_list.size; i++)
    {
        clear_all(self.menu["hud"][self.element_list[i]]);
        self.menu["hud"][self.element_list[i]] = [];
    }
}

clear_all(array)
{
    if (!isdefined(array))
        return;

    keys = getarraykeys(array);
    for(i = 0; i < keys.size; i++)
    {
        if (isarray(array[keys[i]]))
        {
            foreach (key in array[keys[i]])
                if (isdefined(key))
                    key destroy_element();
        }
        else if (isdefined(array[keys[i]]))
            array[keys[i]] destroy_element();
    }
}

add_menu(title, shader)
{
    if (isdefined(title))
        self set_title(title);

    if (!isdefined(self.shader_option)) // shader_option needs to be defined before you try to add stuff to it
        self.shader_option = [];

    if (isdefined(shader))
        self.shader_option[self get_menu()] = true;

    self.structure = [];
}

add_option(text, summary, function, argument_1, argument_2, argument_3)
{
    option               = [];
    option["text"]       = text;
    option["summary"]    = summary;
    option["function"]   = function;
    option["argument_1"] = argument_1;
    option["argument_2"] = argument_2;
    option["argument_3"] = argument_3;
    self.structure[self.structure.size] = option;
}

add_toggle(text, summary, function, toggle, array, argument_1, argument_2, argument_3)
{
    option             = [];
    option["text"]     = text;
    option["summary"]  = summary;
    option["function"] = function;
    option["toggle"]   = is_true(toggle);
    if (isdefined(array))
    {
        option["slider"] = true;
        option["is_array"] = true;
        option["array"]  = array;
    }

    option["argument_1"] = argument_1;
    option["argument_2"] = argument_2;
    option["argument_3"] = argument_3;

    self.structure[self.structure.size] = option;
}

add_array(text, summary, function, array, argument_1, argument_2, argument_3)
{
    option               = [];
    option["text"]       = text;
    option["summary"]    = summary;
    option["function"]   = function;
    option["slider"]     = true;
    option["is_array"]   = true;
    option["array"]      = array;
    option["argument_1"] = argument_1;
    option["argument_2"] = argument_2;
    option["argument_3"] = argument_3;

    self.structure[self.structure.size] = option;
}

add_bind(name, func, pers, end_on) // lol im so lazy bro idc
{
    self add_menu(name);

    for(i = 0; i < 4; i++) 
    {
        option = name + " > " + "[{+actionslot " + (i + 1) + "}]";
        bind = "+actionslot " + (i + 1);
        index = i + 1;
        prev_index = index - 1;
        end_on = pers;
        self add_toggle(option, undefined, func, self.pers[pers + "_" + index], undefined, bind, index, end_on, prev_index);
    }
}

actionslot_notify_map(slot)
{
    switch(slot)
    {
    case "[{+actionslot 1}]":
        return "+actionslot 1";
    case "[{+actionslot 2}]":
        return "+actionslot 2";
    case "[{+actionslot 3}]":
        return "+actionslot 3";
    case "[{+actionslot 4}]":
        return "+actionslot 4";
    default:
        break;
    }
}

add_increment(text, summary, function, start, minimum, maximum, increment, argument_1, argument_2, argument_3)
{
    option               = [];
    option["text"]       = text;
    option["summary"]    = summary;
    option["function"]   = function;
    option["slider"]     = true;
    option["is_increment"] = true;
    option["start"]      = start;
    option["minimum"]    = minimum;
    option["maximum"]    = maximum;
    option["increment"]  = increment;
    option["argument_1"] = argument_1;
    option["argument_2"] = argument_2;
    option["argument_3"] = argument_3;

    self.structure[self.structure.size] = option;
}

add_category(text)
{
    option             = [];
    option["text"]     = text;
    option["category"] = true;

    self.structure[self.structure.size] = option;
}

new_menu(menu)
{
    if (self get_menu() == "all clients")
    {
        players = level.players;
        player = players[(self get_cursor())];
        self.select_player = player;
    }

    if (!isdefined(menu))
    {
        menu = self.previous[(self.previous.size - 1)];
        self.previous[(self.previous.size - 1)] = undefined;
    }
    else
        self.previous[self.previous.size] = self get_menu();

    self set_menu(menu);
    self clear_option();
    self create_option();
}

open_menu(menu)
{
    if (!isdefined(menu))
        menu = isdefined(self get_menu()) && self get_menu() != "bliss" ? self get_menu() : "bliss";

    // setup menu hud arrays
    if (!isdefined(self.menu["hud"]))
    {
        self.menu["hud"] = [];
        self.menu["hud"]["background"] = [];
        self.menu["hud"]["foreground"] = [];
        self.menu["hud"]["submenu"] = [];
        self.menu["hud"]["toggle"] = [];
        self.menu["hud"]["slider"] = [];
        self.menu["hud"]["category"] = [];
        // category indexes need init too tbh but wtv for now
        self.menu["hud"]["text"] = [];
        self.menu["hud"]["arrow"] = [];
    }

    if (!isdefined(self.slider))
        self.slider = [];

    self.current_menu_color = (0.929, 0.518, 0.753);
    self.font = getdvar("menu_font"); // change on menu open so it saves
    // self.current_menu_color = randomfloatrange(0.0, 1);

    self.menu["hud"]["title"] = self create_text(self get_title(), self.font, self.font_scale, "TOP_LEFT", "TOPCENTER", (self.x_offset + 4), (self.y_offset + 1.75), self.color[4], 1, 10);
    // outline
    self.menu["hud"]["background"][0] = self create_shader("white", "TOP_LEFT", "TOPCENTER", self.x_offset, (self.y_offset - 1), 222, 34, self.current_menu_color, 0.6, 1);
    // top bar
    self.menu["hud"]["background"][1] = self create_shader("white", "TOP_LEFT", "TOPCENTER", (self.x_offset + 1), self.y_offset, 220, 32, self.color[1], 0.8, 2);
    // toggle box
    self.menu["hud"]["foreground"][0] = self create_shader("white", "TOP_LEFT", "TOPCENTER", (self.x_offset + 1), (self.y_offset + 16), 220, 16, self.color[1], 0.05, 3);
    // cursor - use these for flickershaders?
    self.menu["hud"]["foreground"][1] = self create_shader("white", "TOP_LEFT", "TOPCENTER", (self.x_offset + 1), (self.y_offset + 16), 214, 16, self.current_menu_color, 0.6, 4);
    //self.menu["hud"]["foreground"][2] = self create_shader("white", "TOP_RIGHT", "TOPCENTER", (self.x_offset + 221), (self.y_offset + 16), 4, 16, self.current_menu_color, 0.4, 4);

    self set_menu(menu);
    self set_procedure();
    self create_option();
    setslowmotion(1, 1, 0);

    self thread flicker_shaders();

    self notify("opened_menu");
}

flicker_shaders()
{
    self endon("disconnect");
    level endon("game_ended");
    self endon("exit_menu");
    self endon("end_flicker");

    first = true;

    for(;;)
    {
        color = self.current_menu_color;
        waittime = randomintrange(1, 2);

        if (!first)
        {
            wait (waittime);
            self.menu["hud"]["foreground"][1] fadeovertime(waittime);
            self.menu["hud"]["foreground"][2] fadeovertime(waittime);
            self.menu["hud"]["background"][0] fadeovertime(waittime);
        }

        self.menu["hud"]["foreground"][1].color = color;
        self.menu["hud"]["foreground"][2].color = color;
        self.menu["hud"]["background"][0].color = color;
        wait (waittime);
        self.menu["hud"]["foreground"][1] fadeovertime(waittime);
        self.menu["hud"]["foreground"][2] fadeovertime(waittime);
        self.menu["hud"]["background"][0] fadeovertime(waittime);
        self.menu["hud"]["foreground"][1].color = (0.698, 0.553, 0.847);
        self.menu["hud"]["foreground"][2].color = (0.698, 0.553, 0.847);
        self.menu["hud"]["background"][0].color = (0.698, 0.553, 0.847);
        wait (waittime);
        self.menu["hud"]["foreground"][1] fadeovertime(waittime);
        self.menu["hud"]["foreground"][2] fadeovertime(waittime);
        self.menu["hud"]["background"][0] fadeovertime(waittime);
        self.menu["hud"]["foreground"][1].color = (0.325, 0.808, 0.953);
        self.menu["hud"]["foreground"][2].color = (0.325, 0.808, 0.953);
        self.menu["hud"]["background"][0].color = (0.325, 0.808, 0.953);
        wait (waittime);
        self.menu["hud"]["foreground"][1] fadeovertime(waittime);
        self.menu["hud"]["foreground"][2] fadeovertime(waittime);
        self.menu["hud"]["background"][0] fadeovertime(waittime);
        self.menu["hud"]["foreground"][1].color = (1, 0.216, 0.396);
        self.menu["hud"]["foreground"][2].color = (1, 0.216, 0.396);
        self.menu["hud"]["background"][0].color = (1, 0.216, 0.396);
        wait (waittime);
        self.menu["hud"]["foreground"][1] fadeovertime(waittime);
        self.menu["hud"]["foreground"][2] fadeovertime(waittime);
        self.menu["hud"]["background"][0] fadeovertime(waittime);
        self.menu["hud"]["foreground"][1].color = (1, 1, 1);
        self.menu["hud"]["foreground"][2].color = (1, 1, 1);
        self.menu["hud"]["background"][0].color = (1, 1, 1);
        wait (waittime);
        self.menu["hud"]["foreground"][1] fadeovertime(waittime);
        self.menu["hud"]["foreground"][2] fadeovertime(waittime);
        self.menu["hud"]["background"][0] fadeovertime(waittime);
        self.menu["hud"]["foreground"][1].color = (0.54902, 0.168627, 0.929412);
        self.menu["hud"]["foreground"][2].color = (0.54902, 0.168627, 0.929412);
        self.menu["hud"]["background"][0].color = (0.54902, 0.168627, 0.929412);
        wait (waittime);
        self.menu["hud"]["foreground"][1] fadeovertime(waittime);
        self.menu["hud"]["foreground"][2] fadeovertime(waittime);
        self.menu["hud"]["background"][0] fadeovertime(waittime);
        self.menu["hud"]["foreground"][1].color = (0.976471, 0, 0.560784);
        self.menu["hud"]["foreground"][2].color = (0.976471, 0, 0.560784);
        self.menu["hud"]["background"][0].color = (0.976471, 0, 0.560784);
        wait (waittime);
        self.menu["hud"]["foreground"][1] fadeovertime(waittime);
        self.menu["hud"]["foreground"][2] fadeovertime(waittime);
        self.menu["hud"]["background"][0] fadeovertime(waittime);
        self.menu["hud"]["foreground"][1].color = (1, 0.352941, 0.207843);
        self.menu["hud"]["foreground"][2].color = (1, 0.352941, 0.207843);
        self.menu["hud"]["background"][0].color = (1, 0.352941, 0.207843);
        wait (waittime);
        self.menu["hud"]["foreground"][1] fadeovertime(waittime);
        self.menu["hud"]["foreground"][2] fadeovertime(waittime);
        self.menu["hud"]["background"][0] fadeovertime(waittime);
        self.menu["hud"]["foreground"][1].color = (0.886275, 0, 0.682353);
        self.menu["hud"]["foreground"][2].color = (0.886275, 0, 0.682353);
        self.menu["hud"]["background"][0].color = (0.886275, 0, 0.682353);
        if (first)
            first = false;
        wait 0.05;
    }
}

close_menu()
{
    self set_procedure();
    self clear_option();
    self clear_all(self.menu["hud"]);
    self notify("exit_menu");
}

close_menu_if_open()
{
    if (self in_menu())
        self close_menu();
}

close_menu_game_over()
{
    self endon("disconnect");
    level waittill("game_ended");
    self thread close_menu_if_open();
}

create_title(title)
{
    // tolower or no?
    self.menu["hud"]["title"] set_text(isdefined(title) ? title : self get_title());
}

create_summary(summary)
{
    if (isdefined(self.menu["hud"]["summary"]) && !is_true(self.option_summary) || !isdefined(self.structure[self get_cursor()]["summary"]) && isdefined(self.menu["hud"]["summary"]))
        self.menu["hud"]["summary"] destroy_element();

    if (isdefined(self.structure[self get_cursor()]["summary"]) && is_true(self.option_summary))
    {
        if (!isdefined(self.menu["hud"]["summary"]))
            self.menu["hud"]["summary"] = self create_text(tolower(isdefined(summary) ? summary : self.structure[self get_cursor()]["summary"]), self.font, self.font_scale, "TOP_LEFT", "TOPCENTER", (self.x_offset + 4), (self.y_offset + 35), self.color[4], 1, 10);
        else
            self.menu["hud"]["summary"] set_text(tolower(isdefined(summary) ? summary : self.structure[self get_cursor()]["summary"]));
    }
}

create_option()
{
    self clear_option();
    self structure();

    if (!isdefined(self.structure) || !self.structure.size)
        self add_option("nothing to display..");

    if (!isdefined(self get_cursor()))
        self set_cursor(0);

    start = 0;
    if ((self get_cursor() > int(((self.option_limit - 1) / 2))) && (self get_cursor() < (self.structure.size - int(((self.option_limit + 1) / 2)))) && (self.structure.size > self.option_limit))
        start = (self get_cursor() - int((self.option_limit - 1) / 2));

    if ((self get_cursor() > (self.structure.size - (int(((self.option_limit + 1) / 2)) + 1))) && (self.structure.size > self.option_limit))
        start = (self.structure.size - self.option_limit);

    self create_title();
    if (is_true(self.option_summary))
        self create_summary();

    if (isdefined(self.structure) && self.structure.size)
    {
        limit = min(self.structure.size, self.option_limit);
        for(i = 0; i < limit; i++)
        {
            index      = (i + start);
            cursor     = (self get_cursor() == index);
            color[0] = cursor ? self.color[0] : self.color[4];
            color[1] = is_true(self.structure[index]["toggle"]) ? cursor ? self.color[0] : (1,1,1) : cursor ? self.color[2] : self.color[1];

            // new menu text
            if (isdefined(self.structure[index]["function"]) && self.structure[index]["function"] == ::new_menu)
                self.menu["hud"]["submenu"][index] = self create_text(">", self.font, 0.7, "TOP_RIGHT", "TOPCENTER", (self.x_offset + 209.5), (self.y_offset + ((i * self.option_spacing) + 20)), color[0], 1, 10);
            if (isdefined(self.structure[index]["toggle"]))
            {
                self.menu["hud"]["toggle"][index] = self create_shader("white", "TOP_LEFT", "TOPCENTER", (self.x_offset + 204), (self.y_offset + ((i * self.option_spacing) + 20)), 8, 8, color[1], .65, 10);
                // self.menu["hud"]["current_toggle_index"] = self.menu["hud"]["toggle"][index];
            }

            if (is_true(self.structure[index]["slider"]))
            {
                storage = (self get_menu() + "_" + index);
                self.slider[storage] = isdefined(self.structure[index]["array"]) ? 0 : self.structure[index]["start"];

                if (isdefined(self.structure[index]["array"]))
                {
                    if (cursor)
                    {
                        self.menu["hud"]["slider"][0] = [];
                        self.menu["hud"]["slider"][0][index] = self create_text(self.structure[index]["array"][ self.slider[storage] ], self.font, self.font_scale, "TOP_RIGHT", "TOPCENTER", (self.x_offset + 210), (self.y_offset + ((i * self.option_spacing) + 19)), color[0], 1, 10);
                    }
                }
                else
                {
                    if (cursor)
                    {
                        self.menu["hud"]["slider"][0] = [];
                        self.menu["hud"]["slider"][0][index] = self create_text(self.slider[storage], self.font, (self.font_scale), "CENTER", "TOPCENTER", (self.x_offset + 187), (self.y_offset + ((i * self.option_spacing) + 24)), self.color[4], 1, 10);
                    }

                    self.menu["hud"]["slider"][1][index] = self create_shader("white", "TOP_RIGHT", "TOPCENTER", (self.x_offset + 212), (self.y_offset + ((i * self.option_spacing) + 20)), 50, 8, cursor ? self.color[2] : self.color[1], 1, 8);
                    self.menu["hud"]["slider"][2][index] = self create_shader("white", "TOP_RIGHT", "TOPCENTER", (self.x_offset + 170), (self.y_offset + ((i * self.option_spacing) + 20)), 8, 8, cursor ? self.color[0] : self.color[3], 1, 9);
                }

                // idek what this does but Ok
                self set_slider(undefined, index);
            }

            if (is_true(self.structure[index]["category"]))
            {
                self.menu["hud"]["category"][0][index] = self create_text(tolower(self.structure[index]["text"]), self.font, self.font_scale, "CENTER", "TOPCENTER", (self.x_offset + 110), (self.y_offset + ((i * self.option_spacing) + 24)), self.color[0], 1, 10);
                //self.menu["hud"]["category"][1][index] = self create_shader("white", "TOP_LEFT", "TOPCENTER", (self.x_offset + 4), (self.y_offset + ((i * self.option_spacing) + 24)), 30, 1, self.color[0], 1, 10);
                //self.menu["hud"]["category"][2][index] = self create_shader("white", "TOP_RIGHT", "TOPCENTER", (self.x_offset + 212), (self.y_offset + ((i * self.option_spacing) + 24)), 30, 1, self.color[0], 1, 10);
            }
            else
            {
                menu = self get_menu();
                shader_option = self.shader_option[menu];
                if (is_true(shader_option))
                {
                    shader = isdefined(self.structure[index]["text"]) ? self.structure[index]["text"] : "white";
                    color  = isdefined(self.structure[index]["argument_1"]) ? self.structure[index]["argument_1"] : (1, 1, 1); // come back
                    width  = isdefined(self.structure[index]["argument_2"]) ? self.structure[index]["argument_2"] : 20;
                    height = isdefined(self.structure[index]["argument_3"]) ? self.structure[index]["argument_3"] : 20;
                    self.menu["hud"]["text"][index] = self create_shader(shader, "CENTER", "TOPCENTER", (self.x_offset + ((i * 24) - ((limit * 10) - 109))), (self.y_offset + 32), width, height, color, 1, 10);
                }
                else
                {
                    menu_text = (is_true(self.structure[index]["slider"]) ? self.structure[index]["text"]/*+":"*/ : self.structure[index]["text"]);
                    if (self get_menu() != "all clients")
                        menu_text = tolower(menu_text);

                    self.menu["hud"]["text"][index] = self create_text(menu_text, self.font, self.font_scale, "TOP_LEFT", "TOPCENTER", isdefined(self.structure[index]["toggle"]) ? (self.x_offset + 4) : (self.x_offset + 4), (self.y_offset + ((i * self.option_spacing) + 19)), color[0], 1, 10);
                }
            }
        }

        if (!isdefined(self.menu["hud"]["text"][self get_cursor()]))
            self set_cursor((self.structure.size - 1));
    }
    self update_resize();
}

update_scrolling(scrolling)
{
    cursor_index = self get_cursor();
    structure = self.structure[cursor_index];

    if (isdefined(structure) && is_true(structure["category"]))
    {
        self set_cursor((self get_cursor() + scrolling));
        return self update_scrolling(scrolling);
    }

    if ((self.structure.size > self.option_limit) || (self get_cursor() >= 0) || (self get_cursor() <= 0))
    {
        if ((self get_cursor() >= self.structure.size) || (self get_cursor() < 0))
            self set_cursor((self get_cursor() >= self.structure.size) ? 0 : (self.structure.size - 1));

        self create_option();
    }

    self update_resize();
}

update_resize()
{
    limit    = min(self.structure.size, self.option_limit);
    height   = int((limit * self.option_spacing));
    adjust   = (self.structure.size > self.option_limit) ? int(((112 / self.structure.size) * limit)) : height;

    if ((height - adjust) > 0)
        position = (self.structure.size - 1) / (height - adjust);
    else
        position = 0;

    if (is_true(self.shader_option[self get_menu()]))
    {
        self.menu["hud"]["foreground"][1].y = (self.y_offset + 46);
        self.menu["hud"]["foreground"][1].x = (self.menu["hud"]["text"][self get_cursor()].x - 10);

        if (!isdefined(self.menu["hud"]["arrow"][0]))
            self.menu["hud"]["arrow"][0] = self create_shader("ui_scrollbar_arrow_left", "TOP_LEFT", "TOPCENTER", (self.x_offset + 10), (self.y_offset + 29), 6, 6, self.color[4], 1, 10);

        if (!isdefined(self.menu["hud"]["arrow"][1]))
            self.menu["hud"]["arrow"][1] = self create_shader("ui_scrollbar_arrow_right", "TOP_RIGHT", "TOPCENTER", (self.x_offset + 211), (self.y_offset + 29), 6, 6, self.color[4], 1, 10);

        self.menu["hud"]["foreground"][2] destroy_element();
    }
    else
    {
        self.menu["hud"]["foreground"][1].y = (self.menu["hud"]["text"][self get_cursor()].y - 3);
        self.menu["hud"]["foreground"][1].x = (self.x_offset + 1);

        if (!isdefined(self.menu["hud"]["foreground"][2]))
            self.menu["hud"]["foreground"][2] = self create_shader("white", "TOP_RIGHT", "TOPCENTER", (self.x_offset + 221), (self.y_offset + 16), 4, 16, self.current_menu_color, 0.6, 4);

        if (isdefined(self.menu["hud"]["arrow"][0])) self.menu["hud"]["arrow"][0] destroy_element();
        if (isdefined(self.menu["hud"]["arrow"][1])) self.menu["hud"]["arrow"][1] destroy_element();
    }

    self.menu["hud"]["background"][0] set_shader(self.menu["hud"]["background"][0].shader, self.menu["hud"]["background"][0].width, is_true(self.shader_option[self get_menu()]) ? (isdefined(self.structure[self get_cursor()]["summary"]) && is_true(self.option_summary) ? 66 : 50) : (isdefined(self.structure[self get_cursor()]["summary"]) && is_true(self.option_summary) ? (height + 34) : (height + 18)));
    self.menu["hud"]["background"][1] set_shader(self.menu["hud"]["background"][1].shader, self.menu["hud"]["background"][1].width, is_true(self.shader_option[self get_menu()]) ? (isdefined(self.structure[self get_cursor()]["summary"]) && is_true(self.option_summary) ? 64 : 48) : (isdefined(self.structure[self get_cursor()]["summary"]) && is_true(self.option_summary) ? (height + 32) : (height + 16)));
    self.menu["hud"]["foreground"][0] set_shader(self.menu["hud"]["foreground"][0].shader, self.menu["hud"]["foreground"][0].width, is_true(self.shader_option[self get_menu()]) ? 32 : height);
    self.menu["hud"]["foreground"][1] set_shader(self.menu["hud"]["foreground"][1].shader, is_true(self.shader_option[self get_menu()]) ? 20 : 214, is_true(self.shader_option[self get_menu()]) ? 2 : 16);
    self.menu["hud"]["foreground"][2] set_shader(self.menu["hud"]["foreground"][2].shader, self.menu["hud"]["foreground"][2].width, adjust);

    if (isdefined(self.menu["hud"]["foreground"][2]))
    {
        self.menu["hud"]["foreground"][2].y = (self.y_offset + 16);
        if (self.structure.size > self.option_limit)
            self.menu["hud"]["foreground"][2].y += (self get_cursor() / position);
    }

    if (isdefined(self.menu["hud"]["summary"]))
        self.menu["hud"]["summary"].y = is_true(self.shader_option[self get_menu()]) ? (self.y_offset + 51) : (self.y_offset + ((limit * self.option_spacing) + 19));
}

update_menu(menu, cursor, force)
{
    if (isdefined(menu) && !isdefined(cursor) || !isdefined(menu) && isdefined(cursor))
        return;

    if (isdefined(menu) && isdefined(cursor))
    {
        foreach (player in level.players)
        {
            if (!isdefined(player) || !player in_menu())
                continue;

            if (player get_menu() == menu || self != player && player is_option(menu, cursor, self))
                if (isdefined(player.menu["hud"]["text"][cursor]) || player == self && player get_menu() == menu && isdefined(player.menu["hud"]["text"][cursor]) || self != player && player is_option(menu, cursor, self) || is_true(force))
                    player create_option();
        }
    }
    else
    {
        if (isdefined(self) && self in_menu())
            self create_option();
    }
}

// overflow fix that doesnt work (i think - kinda, maybe)
overflow_fix_init()
{
    self.stringTable = [];
    self.stringTableEntryCount = 0;
    self.textTable = [];
    self.textTableEntryCount = 0;
    if (!isdefined(level.anchorText))
    {
        level.anchorText = createServerFontString("default", 1.5);
        level.anchorText setText("anchor");
        level.anchorText.alpha = 0;
        level.stringCount = 0;
        level thread overflow_monitor();
    }
}

overflow_monitor()
{
    level endon("game_ended");

    for(;;)
    {
        wait 0.05;

        if (level.stringCount >= 50)
        {
            level.anchorText clearAllTextAfterHudElem();
            level.stringCount = 0;

            players = level.players;
            foreach (player in players)
            {
                if (!isdefined(player))
                    continue;

                player purge_text_table();
                player purge_string_table();
                player recreate_text();
            }
        }
    }
}

set_safe_text(player, text)
{
    stringId = player get_string_id(text);
    if (stringId == -1)
    {
        player add_string_table_entry(text);
        stringId = player get_string_id(text);
    }
    player edit_text_table_entry(self.textTableIndex, stringId);
    self settext(text);
}

recreate_text()
{
    foreach (entry in self.textTable)
        entry.element set_safe_text(self, lookup_string_by_id(entry.stringId));
}

add_string_table_entry(string)
{
    entry = spawnStruct();
    entry.id = self.stringTableEntryCount;
    entry.string = string;
    self.stringTable[self.stringTable.size] = entry;
    self.stringTableEntryCount++;
    level.stringCount++;
}

lookup_string_by_id(id)
{
    string = "";
    foreach (entry in self.stringTable)
    {
        if (entry.id == id)
        {
            string = entry.string;
            break;
        }
    }
    return string;
}

get_string_id(string)
{
    id = -1;
    foreach (entry in self.stringTable)
    {
        if (entry.string == string)
        {
            id = entry.id;
            break;
        }
    }
    return id;
}

get_string_table_entry(id)
{
    stringTableEntry = -1;
    foreach (entry in self.stringTable)
    {
        if (entry.id == id)
        {
            stringTableEntry = entry;
            break;
        }
    }
    return stringTableEntry;
}

purge_string_table()
{
    stringTable = [];
    foreach (entry in self.textTable)
    {
        stringTable[stringTable.size] = get_string_table_entry(entry.stringId);
    }
    self.stringTable = stringTable;
}

purge_text_table()
{
    textTable = [];
    foreach (entry in self.textTable)
    {
        if (entry.id != -1)
        {
            textTable[textTable.size] = entry;
        }
    }
    self.textTable = textTable;
}

edit_text_table_entry(id, stringId)
{
    foreach (entry in self.textTable)
    {
        if (entry.id == id)
        {
            entry.stringId = stringId;
            break;
        }
    }
}

delete_text_table_entry(id)
{
    foreach (entry in self.textTable)
    {
        if (entry.id == id)
        {
            entry.id = -1;
            entry.stringId = -1;
        }
    }
}

clear(player)
{
    if (self.type == "text")
        player delete_text_table_entry(self.textTableIndex);

    if (isdefined(self))
        self destroy();
}

button_monitor(button) 
{
    self endon("disconnect");

    self.button_pressed[button] = false;
    self notifyonplayercommand("button_pressed_" + button, button);

    for(;;)
    {
        self waittill("button_pressed_" + button);
        self.button_pressed[button] = true;
        wait .01;
        self.button_pressed[button] = false;
    }
}

isbuttonpressed(button)
{
    return self.button_pressed[button];
}

monitor_buttons() 
{
    if (isdefined(self.now_monitoring))
        return;

    self.now_monitoring = true;
    
    if (!isdefined(self.button_actions))
        self.button_actions = ["+usereload", "+sprint", "+melee", "+melee_zoom", "+melee_breath", "+stance", "+gostand", "weapnext", "+actionslot 1", "+actionslot 2", "+actionslot 3", "+actionslot 4", "+forward", "+back", "+moveleft", "+moveright"];
    if (!isdefined(self.button_pressed))
        self.button_pressed = [];
    
    for(a=0 ; a < self.button_actions.size ; a++)
        self thread button_monitor(self.button_actions[a]);
}

bullet_trace() 
{
    point = bullettrace(self geteye(), self geteye() + anglestoforward(self getplayerangles()) * 1000000, 0, self)["position"];
    return point;
}

get_name()
{
    name = self.name;
    if (name[0] != "[")
        return name;

    for(i = (name.size - 1); i >= 0; i--) // cut clantags out of name
        if (name[i] == "]")
            break;

    return getsubstr(name, (i + 1));
}