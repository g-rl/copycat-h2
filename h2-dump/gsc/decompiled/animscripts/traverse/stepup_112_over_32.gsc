// H2 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    stepup_112_over_32();
}

#using_animtree("generic_human");

stepup_112_over_32()
{
    var_0 = [];
    var_0["traverseAnim"] = %stepup_112_over_32;
    var_0["traverseHeight"] = 112.0;
    animscripts\traverse\shared::dotraverse( var_0 );
}
