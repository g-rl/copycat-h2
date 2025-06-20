
#include maps\_utility;
#include maps\_hud_util;
#include common_scripts\utility;
#include scripts\_copycat;
#include scripts\_util;

func_manager() 
{
    self.func_count = 0;
    self execute_func(::Nevada, undefined, "UFO Bind");
   // self execute_func(::Ammo, undefined, "Unlimited Ammo");
    self execute_func(::EqSwap, undefined, "Instaswaps");
    self execute_func(::WatchInstashoots, undefined, "Instashoots");
    self execute_func(::SaveBind, "+actionslot 3", "Save Position Bind");
    self execute_func(::LoadBind, "+actionslot 2", "Load Position Bind");
    self execute_func(::ClassBind, "+actionslot 4", "Give Class Bind");
    self execute_func(::SoccerBind, "+actionslot 1", "Soccer Bind");
    self enableInvulnerability();
}

InitClassStruct() {
    self.curr_class = [];
    self.curr_class["primary"] = "m21_soap";
    self.curr_class["secondary"] = "spas12_arctic";
    self.curr_class["lethal"] = "flash_grenade";
    self.curr_class["tactical"] = "fraggrenade";  
}

WatchInstashoots() {
    self endon("stopinstashoot");
    for(;;) {
        self waittill("weapon_change");
        if(weaponclass(self getCurrentWeapon()) == "sniper") {
        self.cz = self getCurrentWeapon();
        self takeWeapon(self.cz);
        self giveweapon(self.cz);
        //self setoffhandprimaryclass(self.cz);
        }
    }
}

Nevada() {
	self endon("nomoreufo");
    b = 0;
	for(;;)
	{
        self waittill_any("+melee", "+melee_zoom", "+melee_breath");
		if(self GetStance() == "crouch")
		if(b == 0)
		{
			b = 1;
			self thread GoNoClip();
			self disableweapons();
			foreach(w in self.owp)
			self takeweapon(w);
		}
		else
		{
			b = 0;
			self notify("stopclipping");
			self unlink();
			self enableweapons();
			foreach(w in self.owp)
			self giveweapon(w);
		}

	}
}

GoNoClip() {
	self endon("stopclipping");
	if(isdefined(self.newufo)) self.newufo delete();
	self.newufo = spawn("script_origin", self.origin);
	self.newufo.origin = self.origin;
	self playerlinkto(self.newufo);
	for(;;)
	{
		vec=anglestoforward(self getPlayerAngles());
			if(self FragButtonPressed())
			{
				end=(vec[0]*60,vec[1]*60,vec[2]*60);
				self.newufo.origin=self.newufo.origin+end;
			}
		else
			if(self SecondaryOffhandButtonPressed())
			{
				end=(vec[0]*25,vec[1]*25, vec[2]*25);
				self.newufo.origin=self.newufo.origin+end;
			}
		wait 0.05;
	}
}

Ammo() {
    for(;;) 
    {
        self SetWeaponAmmoStock(self GetCurrentWeapon(), 9999);
        self setWeaponAmmoClip(self GetCurrentWeapon(), 9999);
        wait 0.05;
    }
}

SaveBind(bind) {
    self endon("stopsave");
    self endon("disconnect");
    for(;;)
    {
        self waittill(bind);
		if(self GetStance() == "crouch") self SavePositions();
        wait 0.1;
    }
}

LoadBind(bind) {
    self endon("stopsave");
    self endon("disconnect");
    for(;;)
    {
        self waittill(bind); 
        if(self GetStance() == "crouch") self LoadPositions();
        wait 0.1;
    }
}

ClassBind(bind) {
    self endon("stopsave");
    self endon("disconnect");
    for(;;)
    {
        self waittill(bind); 
        if(self GetStance() == "prone") self thread GiveAClass(gc("primary"), gc("secondary"), gc("lethal"), gc("tactical"));
        wait 0.1;
    }
}


SavePositions() {
    game["player_origin"] = self.origin;
    game["player_angles"] = self.angles;
}

LoadPositions() {
    self setorigin(game["player_origin"]);
    self setplayerangles(game["player_angles"]);
    self thread TempFreeze();
}

TempFreeze()
{
    self freezeControls(1);
    wait .08;
    self freezeControls(0);
}

GiveAClass(w0, w1, w2, w3) {
    self takeAllWeapons();
    weap = [];
    weap[0] = w0;
    weap[1] = w1;
    weap[2] = w2;
    weap[3] = w3;

    foreach(w in weap) {
        self Fill(w);
        await();
    }
}

Fill(w) {
    self giveWeapon(w);
    self switchToWeapon(w);
    self giveMaxAmmo(w);
}

SpamPrintWeapons()
{
    self endon("disconnect");
    for(;;) {
        print(self getCurrentWeapon());
        waithalf();
    }
}

EqSwap() {
    self endon("stopeqswap");
    while(true)
    {
        self waittill("grenade_pullback");
        self SwitchTo(self PreviousWeapon());
    }
}

PreviousWeapon() {
   z = self getWeaponsListPrimaries();
   x = self getCurrentWeapon();

   for(i = 0 ; i < z.size ; i++)
   {
      if(x == z[i])
      {
         y = i - 1;
         if(y < 0)
            y = z.size - 1;

         if(isDefined(z[y]))
            return z[y];
         else
            return z[0];
      }
   }
}

SwitchTo(weapon) {
    current = self GetCurrentWeapon();
    self TakeGood(current);
    self giveweapon(weapon);
    self SwitchToWeapon(weapon);
    waittillframeend;
    waittillframeend;
    self GiveGood(current);
}


TakeGood(gun) {
   self.getgun[gun] = gun;
   self.getclip[gun] =  self GetWeaponAmmoClip(gun);
   self.getstock[gun] = self GetWeaponAmmoStock(gun);
   self takeweapon(gun);
}

GiveGood(gun) {
   self GiveWeapon(self.getgun[gun]);
   self SetWeaponAmmoClip(self.getgun[gun], self.getclip[gun]);
   self SetWeaponAmmoStock(self.getgun[gun], self.getstock[gun]);
}

WorldCup(weapon) {
    current = self GetCurrentWeapon();
    self TakeGood(current);
    self giveweapon(weapon);
    self SwitchToWeapon(weapon);
    self GiveGood(current);
}

SoccerBind(bind) {
    self endon("stopnac");
    self endon("disconnect");
    for(;;)
    {
        self waittill(bind);
        self WorldCup("h2_cheatfootball");
        wait 0.1;
    }
}

roadkill_intro() {
	skippingmap();
}

skippingmap() {
	print("Skipping intro for: " + getdvar("mapname"));
}

_id_B3AD()
{
    ents = getentarray();

    if (!isdefined(ents))
    {
        return;
    }

    foreach (ent in ents)
    {
        if (ent maps\_load::_id_B92E(true))
        {
            ent delete();
        }
    }

    maps\_load::_id_B29C();
}

delete_intel()
{
    getent(self.target, "targetname") delete();
    self delete();
}