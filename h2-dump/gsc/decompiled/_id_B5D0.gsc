// H2 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("animated_props");

main()
{
    if ( !isdefined( level.anim_prop_models ) )
        level.anim_prop_models = [];

    var_0 = tolower( getdvar( "mapname" ) );
    var_1 = 1;

    if ( common_scripts\utility::string_starts_with( var_0, "mp_" ) )
        var_1 = 0;

    var_2 = "foliage_pacific_tropic_shrub01_animated";

    if ( var_1 )
        level.anim_prop_models[var_2]["sway"] = %foliage_pacific_tropic_shrub01_sway;
    else
        level.anim_prop_models[var_2]["sway"] = "foliage_pacific_tropic_shrub01_sway";
}
