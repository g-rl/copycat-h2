// H2 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    if ( self.type == "dog" )
        animscripts\traverse\shared::dog_wall_and_window_hop( "window_40", 40 );
    else
        low_wall_human();
}

#using_animtree("generic_human");

low_wall_human()
{
    var_0 = [];
    var_0["traverseAnim"] = %traverse_over_40_a_iw6;
    var_0["traverseToCoverAnim"] = %traverse40_2_cover;
    var_0["coverType"] = "Cover Crouch";
    var_0["traverseHeight"] = 40.0;
    var_0["interruptDeathAnim"][0] = animscripts\utility::array( %traverse40_death_start, %traverse40_death_start_2 );
    var_0["interruptDeathAnim"][1] = animscripts\utility::array( %traverse40_death_end, %traverse40_death_end_2 );
    animscripts\traverse\shared::dotraverse( var_0 );
}
