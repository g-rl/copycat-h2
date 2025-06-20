// H2 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main( var_0, var_1, var_2 )
{
    maps\_vehicle::build_template( "slamraam", var_0, var_1, var_2 );
    maps\_vehicle::build_localinit( ::init_local );
    maps\_vehicle::build_deathmodel( "vehicle_slamraam", "vehicle_slamraam_base" );
    precachemodel( "projectile_slamraam_missile" );
    maps\_vehicle::build_deathfx( "fx/explosions/vehicle_explosion_slamraam", undefined, "exp_slamraam_destroyed" );
    maps\_vehicle::build_life( 50 );
    maps\_vehicle::build_team( "allies" );
}

init_local()
{
    self.missilemodel = "projectile_slamraam_missile";
    self.missiletags = [];
    self.missiletags[0] = "tag_missle1";
    self.missiletags[1] = "tag_missle2";
    self.missiletags[2] = "tag_missle3";
    self.missiletags[3] = "tag_missle4";
    self.missiletags[4] = "tag_missle5";
    self.missiletags[5] = "tag_missle6";
    self.missiletags[6] = "tag_missle7";
    self.missiletags[7] = "tag_missle8";
}
