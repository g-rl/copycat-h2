// H2 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    if ( self.type == "dog" )
        animscripts\traverse\shared::dog_jump_up( 52.0, 5 );
    else
        low_wall_human();
}

#using_animtree("generic_human");

low_wall_human()
{
    var_0 = [];
    var_0["traverseAnim"] = %traverse_stepup_52_fast;
    var_0["traverseHeight"] = 52.0;
    animscripts\traverse\shared::dotraverse( var_0 );
}
