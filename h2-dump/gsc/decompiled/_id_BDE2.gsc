// H2 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main( var_0, var_1, var_2 )
{
    maps\_vehicle::build_template( "zodiac", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_local );
    maps\_vehicle::build_deathmodel( "vehicle_zodiac" );
    maps\_vehicle::build_life( 999, 500, 1500 );
    maps\_vehicle::build_team( "allies" );
    maps\_vehicle::build_aianims( ::setanims, ::set_vehicle_anims );
    maps\_vehicle::build_unload_groups( ::unload_groups );
}

init_local()
{

}

set_vehicle_anims( var_0 )
{
    return var_0;
}

#using_animtree("generic_human");

setanims()
{
    var_0 = [];

    for ( var_1 = 0; var_1 < 6; var_1++ )
        var_0[var_1] = spawnstruct();

    var_0[0].sittag = "tag_body";
    var_0[1].sittag = "tag_body";
    var_0[2].sittag = "tag_body";
    var_0[3].sittag = "tag_body";
    var_0[4].sittag = "tag_body";
    var_0[5].sittag = "tag_body";
    var_0[0].idle = %oilrig_civ_escape_1_seal_a;
    var_0[1].idle = %oilrig_civ_escape_2_seal_a;
    var_0[2].idle = %oilrig_civ_escape_3_a;
    var_0[3].idle = %oilrig_civ_escape_4_a;
    var_0[4].idle = %oilrig_civ_escape_5_a;
    var_0[5].idle = %oilrig_civ_escape_6_a;
    var_0[0].getout = %pickup_driver_climb_out;
    var_0[1].getout = %pickup_driver_climb_out;
    var_0[2].getout = %pickup_passenger_climb_out;
    var_0[3].getout = %pickup_passenger_climb_out;
    var_0[4].getout = %pickup_passenger_climb_out;
    var_0[5].getout = %pickup_passenger_climb_out;
    var_0[0].death = %h2_af_chase_zodiacdriver_dying;
    return var_0;
}

unload_groups()
{
    var_0 = [];
    var_0["passengers"] = [];
    var_0["all"] = [];
    var_1 = "passengers";
    var_0[var_1][var_0[var_1].size] = 1;
    var_0[var_1][var_0[var_1].size] = 2;
    var_0[var_1][var_0[var_1].size] = 3;
    var_0[var_1][var_0[var_1].size] = 4;
    var_0[var_1][var_0[var_1].size] = 5;
    var_1 = "all";
    var_0[var_1][var_0[var_1].size] = 0;
    var_0[var_1][var_0[var_1].size] = 1;
    var_0[var_1][var_0[var_1].size] = 2;
    var_0[var_1][var_0[var_1].size] = 3;
    var_0[var_1][var_0[var_1].size] = 4;
    var_0[var_1][var_0[var_1].size] = 5;
    var_0["default"] = var_0["all"];
    return var_0;
}

rider_death_animate_or_ragdoll( var_0, var_1 )
{
    if ( isdefined( var_1.zodiac_rider_in_death_anim ) && var_1.zodiac_rider_in_death_anim )
        return;

    var_1 notify( "newanim" );
    var_2 = maps\_vehicle_aianim::anim_pos( var_0, var_1.vehicle_position );

    if ( isdefined( var_2.death ) )
    {
        var_0 thread maps\_vehicle_aianim::guy_deathimate_me( var_1, var_2 );
        var_1.zodiac_rider_in_death_anim = 1;
        return;
    }

    var_1 startragdoll();
}
