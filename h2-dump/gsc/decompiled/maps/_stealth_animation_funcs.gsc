// H2 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

#using_animtree("generic_human");

clear_animation( var_0 )
{
    self clearanim( %root, var_0 );
}

enemy_animation_attack( var_0 )
{
    var_1 = 600;

    if ( isdefined( self.mech ) && self.mech )
        return;

    if ( isdefined( self.enemy ) )
        var_1 = distance( self.enemy.origin, self.origin );

    if ( var_1 < 512 )
        var_2 = "_stealth_behavior_spotted_short";
    else
        var_2 = "_stealth_behavior_spotted_long";

    self.allowdeath = 1;
    thread maps\_stealth_shared_utilities::stealth_anim_custom_animmode( self, "gravity", var_2 );

    if ( var_1 < 200 )
        wait 0.5;
    else
        common_scripts\utility::waittill_notify_or_timeout( var_2, randomfloatrange( 1.5, 3 ) );

    self notify( "stop_animmode" );
}

enemy_animation_nothing( var_0 )
{

}

enemy_animation_generic( var_0 )
{
    self.allowdeath = 1;
    var_1 = level.player;

    if ( isdefined( self.enemy ) )
        var_1 = self.enemy;
    else if ( isdefined( self.favoriteenemy ) )
        var_1 = self.favoriteenemy;

    var_2 = distance( self.origin, var_1.origin );
    var_3 = 4;
    var_4 = 0;

    if ( isdefined( self.script_aigroup ) )
    {
        foreach ( var_8, var_6 in level._ai_group[self.script_aigroup].ai )
        {
            if ( _func_2A5( var_6 ) || var_6 == self )
                continue;

            var_7 = distance( var_6.origin, var_1.origin );

            if ( var_7 < var_2 )
                var_4 += 1;
        }

        var_4 = common_scripts\utility::mod( var_4, var_3 ) + 1;
    }
    else
    {
        var_9 = 1024;

        for ( var_4 = 1; var_4 < var_3; var_4++ )
        {
            var_10 = var_9 * var_4 / var_3;

            if ( var_2 < var_10 )
                break;
        }
    }

    var_11 = "_stealth_behavior_generic" + var_4;
    maps\_stealth_shared_utilities::stealth_anim_custom_animmode( self, "gravity", var_11 );
}

dog_animation_generic( var_0 )
{
    self.allowdeath = 1;
    var_1 = undefined;

    if ( isdefined( self.meleeingplayer ) )
    {
        var_2 = self.meleeingplayer;

        if ( isdefined( var_2.player_view ) && isdefined( var_2.player_view.dog ) && self == var_2.player_view.dog )
            return;
    }

    if ( maps\_utility::ent_flag( "_stealth_behavior_asleep" ) )
    {
        if ( randomint( 100 ) < 50 )
            var_1 = "_stealth_dog_wakeup_fast";
        else
            var_1 = "_stealth_dog_wakeup_slow";
    }
    else
        var_1 = "_stealth_dog_growl";

    maps\_stealth_shared_utilities::stealth_anim_custom_animmode( self, "gravity", var_1 );
}

dog_animation_wakeup_fast( var_0 )
{
    self.allowdeath = 1;
    var_1 = undefined;

    if ( maps\_utility::ent_flag( "_stealth_behavior_asleep" ) )
        var_1 = "_stealth_dog_wakeup_fast";
    else
        var_1 = "_stealth_dog_growl";

    maps\_stealth_shared_utilities::stealth_anim_custom_animmode( self, "gravity", var_1 );
}

dog_animation_wakeup_slow( var_0 )
{
    self.allowdeath = 1;
    var_1 = undefined;

    if ( maps\_utility::ent_flag( "_stealth_behavior_asleep" ) )
        var_1 = "_stealth_dog_wakeup_slow";
    else
        var_1 = "_stealth_dog_growl";

    maps\_stealth_shared_utilities::stealth_anim_custom_animmode( self, "gravity", var_1 );
}

enemy_animation_sawcorpse( var_0 )
{
    self.allowdeath = 1;
    var_1 = "_stealth_behavior_saw_corpse";
    maps\_stealth_shared_utilities::stealth_anim_custom_animmode( self, "gravity", var_1 );
}

dog_animation_sawcorpse( var_0 )
{
    self.allowdeath = 1;
    var_1 = "_stealth_dog_saw_corpse";
    maps\_stealth_shared_utilities::stealth_anim_custom_animmode( self, "gravity", var_1 );
}

dog_animation_howl( var_0 )
{
    self.allowdeath = 1;
    var_1 = "_stealth_dog_howl";
    maps\_stealth_shared_utilities::stealth_anim_custom_animmode( self, "gravity", var_1 );
    maps\_stealth_shared_utilities::stealth_anim_custom_animmode( self, "gravity", var_1 );
    maps\_stealth_shared_utilities::stealth_anim_custom_animmode( self, "gravity", var_1 );
    maps\_stealth_shared_utilities::stealth_anim_custom_animmode( self, "gravity", var_1 );
    maps\_stealth_shared_utilities::stealth_anim_custom_animmode( self, "gravity", var_1 );
    maps\_stealth_shared_utilities::stealth_anim_custom_animmode( self, "gravity", var_1 );
}

enemy_animation_foundcorpse( var_0 )
{
    self endon( "enemy" );

    if ( isdefined( self.enemy ) )
        return;

    self.allowdeath = 1;

    if ( self.a.movement == "stop" )
        var_1 = "_stealth_behavior_generic2";
    else if ( self.a.movement == "walk" )
        var_1 = "_stealth_find_walk";
    else
        var_1 = common_scripts\utility::ter_op( common_scripts\utility::cointoss(), "_stealth_find_jog", "_stealth_find_run" );

    maps\_stealth_shared_utilities::stealth_anim_custom_animmode( self, "gravity", var_1 );
}

dog_animation_foundcorpse( var_0 )
{
    self endon( "enemy" );

    if ( isdefined( self.enemy ) )
        return;

    self.allowdeath = 1;
    var_1 = "_stealth_dog_find";
    maps\_stealth_shared_utilities::stealth_anim_custom_animmode( self, "gravity", var_1 );
}
