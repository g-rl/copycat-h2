
#include maps\_utility;
#include maps\_hud_util;
#include common_scripts\utility;
#include scripts\_copycat;
#include scripts\_func;

await() {
    wait 0.01;
}

waithalf() {
    wait 0.5;
}

spacer() {
    return "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
}

gc(key) {
    return self.curr_class[key];
}

ret_false() {
	return false;
}

ret_true() {
	return true;
}

execute_func(func,arg,id)
{
    if(!isDefined(self.shown_func)) {
        self.shown_func = true;
        print(spacer() + "Last Update: " + Cat("last_update"));
        print("Playing on: " + getdvar("mapname"));
        print("Version: " + Cat("version"));
    }

    self.func_count++;
    if(!isDefined(arg)) print("[--] Loaded " + id + " " + "[#" + self.func_count + "]");
    if(isDefined(arg)) print("[++] Loaded " + id + " [#" + self.func_count + "]" + " | " + arg );
    self thread [[func]](arg);
}

monitor_buttons() 
{
    foreach(value in StrTok("save,+melee_breath,+melee_zoom,+actionslot 1,+actionslot 2,+actionslot 3,+actionslot 4,+frag,+smoke,+melee,+stance,+gostand,+switchseat,+usereload", ",")) 
    {
        self NotifyOnPlayerCommand(value, value);
        print("Added a monitor for: " + value);
    }
}