// H2 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    jump_across_112_over_32();
}

#using_animtree("generic_human");

jump_across_112_over_32()
{
    var_0 = [];
    var_0["traverseAnim"] = %jump_across_112_over_32;
    var_0["traverseHeight"] = 32.0;
    animscripts\traverse\shared::dotraverse( var_0 );
}
