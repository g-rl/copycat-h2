// H2 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    if ( self.type == "dog" )
        animscripts\traverse\shared::dog_wall_and_window_hop( "window_38", 38 );
    else
        mantle_over_low_wall_38_human();
}

#using_animtree("generic_human");

mantle_over_low_wall_38_human()
{
    var_0 = [];
    var_0["traverseAnim"] = common_scripts\utility::random( [ %traverse_mantle_over_low_cover_38_var1, %traverse_mantle_over_low_cover_38_var2 ] );
    var_0["traverseHeight"] = 0;
    animscripts\traverse\shared::dotraverse( var_0 );
}
