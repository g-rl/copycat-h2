// H2 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    hms_greece_jump_over_32_down_192();
}

#using_animtree("generic_human");

hms_greece_jump_over_32_down_192()
{
    var_0 = [];
    var_0["traverseAnim"] = %hms_greece_alleys_traversal_balconyledgedrop_32_192;
    var_0["traverseHeight"] = 32.0;
    animscripts\traverse\shared::dotraverse( var_0 );
}
