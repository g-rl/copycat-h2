// H2 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    self setmodel( "body_work_civ_male_b" );
    codescripts\character::attachhead( "alias_civilian_worker_heads", _id_A689::main() );
    self.voice = "american";
    self setclothtype( "vestlight" );
}

precache()
{
    precachemodel( "body_work_civ_male_b" );
    codescripts\character::precachemodelarray( _id_A689::main() );
}
