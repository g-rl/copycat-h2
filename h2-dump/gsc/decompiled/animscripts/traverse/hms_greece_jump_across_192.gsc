// H2 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    hms_greece_jump_across_192();
}

#using_animtree("generic_human");

hms_greece_jump_across_192()
{
    var_0 = [];
    var_0[0] = %hms_greece_traverse_jumpacross192_01;
    var_0[1] = %hms_greece_traverse_jumpacross192_02;
    var_1 = [];
    var_1["traverseAnim"] = var_0[randomint( var_0.size )];
    animscripts\traverse\shared::dotraverse( var_1 );
}
