// H2 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("generic_human");

main()
{
    maps\_props::add_sit_load_ak_notetracks( "generic" );
    level.scr_anim["generic"]["sit_load_ak_idle"][0] = %sitting_guard_loadak_idle;
    level.scr_anim["generic"]["sit_load_ak_react"] = %sitting_guard_loadak_react1;
    maps\_anim::addnotetrack_customfunction( "generic", "detach clip left", ::_id_C4B2, "sit_load_ak_react" );
    script_models();
}

_id_C4B2( var_0 )
{
    var_0.deathanim = %exposed_death_nerve;
    var_0 endon( "death" );
    wait 2;
    var_0.deathanim = undefined;
}

#using_animtree("script_model");

script_models()
{
    level.scr_anim["chair_ak"]["sit_load_ak_react"] = %sitting_guard_loadak_idle_chair;
    level.scr_animtree["chair_ak"] = #animtree;
    level.scr_model["chair_ak"] = "com_folding_chair";
}
