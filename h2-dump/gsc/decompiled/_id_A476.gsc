// H2 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "body_slum_civ_male_ba_wht" );
    codescripts\character::attachhead( "alias_civilian_slum_heads_wht", _id_A688::main() );
    self.voice = "american";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "body_slum_civ_male_ba_wht" );
    codescripts\character::precachemodelarray( _id_A688::main() );
}
