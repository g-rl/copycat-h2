// H2 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    if ( self.type == "dog" )
        animscripts\traverse\shared::dog_jump_down( 7, 0.7 );
    else
        human_traverse();
}

#using_animtree("generic_human");

human_traverse()
{
    var_0 = [];
    var_0["traverseAnim"] = %traverse_jumpdown_40_iw6;
    animscripts\traverse\shared::dotraverse( var_0 );
}
