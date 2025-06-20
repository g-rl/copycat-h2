// H2 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

init()
{
    level.destructiblespawnedentslimit = 50;
    level.destructiblespawnedents = [];
    level.currentcaralarms = 0;
    level.commonstarttime = gettime();

    if ( !isdefined( level.func ) )
        level.func = [];

    var_0 = 1;

    if ( var_0 )
        find_destructibles();

    var_1 = getentarray( "delete_on_load", "targetname" );

    foreach ( var_3 in var_1 )
        var_3 delete();

    init_destroyed_count();
    init_destructible_frame_queue();
}

_id_C84F()
{
    wait 1;
    var_0 = getentarray( "destructible", "targetname" );

    if ( var_0.size != 0 )
    {
        foreach ( var_2 in var_0 )
        {

        }
    }
}

find_destructibles()
{
    var_0 = getentarray( "destructible_vehicle", "targetname" );

    foreach ( var_2 in var_0 )
        var_2 setup_destructibles();

    var_4 = getentarray( "destructible_toy", "targetname" );

    foreach ( var_6 in var_4 )
        var_6 setup_destructibles();
}

setup_destructibles( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0;

    var_1 = undefined;
    self.modeldummyon = 0;
    add_damage_owner_recorder();
    self._id_C9DC = _id_C511::_id_B8EC( self.destructible_type );

    if ( self._id_C9DC < 0 )
        return;

    if ( !var_0 )
        precache_destructibles();

    add_destructible_fx();

    if ( isdefined( level.destructible_type[self._id_C9DC].parts ) )
    {
        self.destructible_parts = [];

        for ( var_3 = 0; var_3 < level.destructible_type[self._id_C9DC].parts.size; var_3++ )
        {
            self.destructible_parts[var_3] = spawnstruct();
            self.destructible_parts[var_3].v["currentState"] = 0;

            if ( isdefined( level.destructible_type[self._id_C9DC].parts[var_3][0].v["health"] ) )
                self.destructible_parts[var_3].v["health"] = level.destructible_type[self._id_C9DC].parts[var_3][0].v["health"];

            if ( isdefined( level.destructible_type[self._id_C9DC].parts[var_3][0].v["random_dynamic_attachment_1"] ) )
            {
                var_4 = randomint( level.destructible_type[self._id_C9DC].parts[var_3][0].v["random_dynamic_attachment_1"].size );
                var_5 = level.destructible_type[self._id_C9DC].parts[var_3][0].v["random_dynamic_attachment_tag"][var_4];
                var_6 = level.destructible_type[self._id_C9DC].parts[var_3][0].v["random_dynamic_attachment_1"][var_4];
                var_7 = level.destructible_type[self._id_C9DC].parts[var_3][0].v["random_dynamic_attachment_2"][var_4];
                var_8 = level.destructible_type[self._id_C9DC].parts[var_3][0].v["clipToRemove"][var_4];
                thread do_random_dynamic_attachment( var_5, var_6, var_7, var_8 );
            }

            if ( var_3 == 0 )
                continue;

            var_9 = level.destructible_type[self._id_C9DC].parts[var_3][0].v["modelName"];
            var_10 = level.destructible_type[self._id_C9DC].parts[var_3][0].v["tagName"];

            for ( var_11 = 1; isdefined( level.destructible_type[self._id_C9DC].parts[var_3][var_11] ); var_11++ )
            {
                var_12 = level.destructible_type[self._id_C9DC].parts[var_3][var_11].v["tagName"];
                var_13 = level.destructible_type[self._id_C9DC].parts[var_3][var_11].v["modelName"];

                if ( isdefined( var_12 ) && var_12 != var_10 )
                {
                    hideapart( var_12 );

                    if ( self.modeldummyon )
                        self.modeldummy hideapart( var_12 );
                }
            }
        }
    }

    if ( isdefined( self.target ) )
        thread destructible_handles_collision_brushes();

    if ( self.code_classname != "script_vehicle" )
        self setcandamage( 1 );

    if ( common_scripts\utility::issp() )
        thread connecttraverses();

    thread destructible_think();

    if ( isdefined( self.target ) )
        thread _id_C3DE();
}

destructible_create( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isdefined( level.destructible_type ) )
        level.destructible_type = [];

    var_6 = level.destructible_type.size;
    var_6 = level.destructible_type.size;
    level.destructible_type[var_6] = spawnstruct();
    level.destructible_type[var_6].v["type"] = var_0;
    level.destructible_type[var_6].parts = [];
    level.destructible_type[var_6].parts[0][0] = spawnstruct();
    level.destructible_type[var_6].parts[0][0].v["modelName"] = self.model;
    level.destructible_type[var_6].parts[0][0].v["tagName"] = var_1;
    level.destructible_type[var_6].parts[0][0].v["health"] = var_2;
    level.destructible_type[var_6].parts[0][0].v["validAttackers"] = var_3;
    level.destructible_type[var_6].parts[0][0].v["validDamageZone"] = var_4;
    level.destructible_type[var_6].parts[0][0].v["validDamageCause"] = var_5;
    level.destructible_type[var_6].parts[0][0].v["godModeAllowed"] = 1;
    level.destructible_type[var_6].parts[0][0].v["rotateTo"] = self.angles;
    level.destructible_type[var_6].parts[0][0].v["vehicle_exclude_anim"] = 0;
}

destructible_part( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 )
{
    var_11 = level.destructible_type.size - 1;
    var_12 = level.destructible_type[var_11].parts.size;
    var_13 = 0;
    destructible_info( var_12, var_13, var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, undefined, var_9, var_10 );
}

destructible_state( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    var_8 = level.destructible_type.size - 1;
    var_9 = level.destructible_type[var_8].parts.size - 1;
    var_10 = level.destructible_type[var_8].parts[var_9].size;

    if ( !isdefined( var_0 ) && var_9 == 0 )
        var_0 = level.destructible_type[var_8].parts[var_9][0].v["tagName"];

    destructible_info( var_9, var_10, var_0, var_1, var_2, var_3, var_4, var_5, undefined, undefined, var_6, var_7 );
}

destructible_fx( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 1;

    if ( !isdefined( var_4 ) )
        var_4 = 0;

    if ( !isdefined( var_5 ) )
        var_5 = 0;

    var_6 = level.destructible_type.size - 1;
    var_7 = level.destructible_type[var_6].parts.size - 1;
    var_8 = level.destructible_type[var_6].parts[var_7].size - 1;
    var_9 = 0;

    if ( isdefined( level.destructible_type[var_6].parts[var_7][var_8].v["fx_filename"] ) )
    {
        if ( isdefined( level.destructible_type[var_6].parts[var_7][var_8].v["fx_filename"][var_4] ) )
            var_9 = level.destructible_type[var_6].parts[var_7][var_8].v["fx_filename"][var_4].size;
    }

    if ( isdefined( var_3 ) )
        level.destructible_type[var_6].parts[var_7][var_8].v["fx_valid_damagetype"][var_4][var_9] = var_3;

    level.destructible_type[var_6].parts[var_7][var_8].v["fx_filename"][var_4][var_9] = _id_ADE9( var_1 );
    level.destructible_type[var_6].parts[var_7][var_8].v["fx_tag"][var_4][var_9] = var_0;
    level.destructible_type[var_6].parts[var_7][var_8].v["fx_useTagAngles"][var_4][var_9] = var_2;
    level.destructible_type[var_6].parts[var_7][var_8].v["fx_cost"][var_4][var_9] = var_5;
}

destructible_loopfx( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_3 ) )
        var_3 = 0;

    var_4 = level.destructible_type.size - 1;
    var_5 = level.destructible_type[var_4].parts.size - 1;
    var_6 = level.destructible_type[var_4].parts[var_5].size - 1;
    var_7 = 0;

    if ( isdefined( level.destructible_type[var_4].parts[var_5][var_6].v["loopfx_filename"] ) )
        var_7 = level.destructible_type[var_4].parts[var_5][var_6].v["loopfx_filename"].size;

    level.destructible_type[var_4].parts[var_5][var_6].v["loopfx_filename"][var_7] = _id_ADE9( var_1 );
    level.destructible_type[var_4].parts[var_5][var_6].v["loopfx_tag"][var_7] = var_0;
    level.destructible_type[var_4].parts[var_5][var_6].v["loopfx_rate"][var_7] = var_2;
    level.destructible_type[var_4].parts[var_5][var_6].v["loopfx_cost"][var_7] = var_3;
}

destructible_healthdrain( var_0, var_1, var_2, var_3 )
{
    var_4 = level.destructible_type.size - 1;
    var_5 = level.destructible_type[var_4].parts.size - 1;
    var_6 = level.destructible_type[var_4].parts[var_5].size - 1;
    level.destructible_type[var_4].parts[var_5][var_6].v["healthdrain_amount"] = var_0;
    level.destructible_type[var_4].parts[var_5][var_6].v["healthdrain_interval"] = var_1;
    level.destructible_type[var_4].parts[var_5][var_6].v["badplace_radius"] = var_2;
    level.destructible_type[var_4].parts[var_5][var_6].v["badplace_team"] = var_3;
}

destructible_sound( var_0, var_1, var_2 )
{
    var_3 = level.destructible_type.size - 1;
    var_4 = level.destructible_type[var_3].parts.size - 1;
    var_5 = level.destructible_type[var_3].parts[var_4].size - 1;

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( !isdefined( level.destructible_type[var_3].parts[var_4][var_5].v["sound"] ) )
    {
        level.destructible_type[var_3].parts[var_4][var_5].v["sound"] = [];
        level.destructible_type[var_3].parts[var_4][var_5].v["soundCause"] = [];
    }

    if ( !isdefined( level.destructible_type[var_3].parts[var_4][var_5].v["sound"][var_2] ) )
    {
        level.destructible_type[var_3].parts[var_4][var_5].v["sound"][var_2] = [];
        level.destructible_type[var_3].parts[var_4][var_5].v["soundCause"][var_2] = [];
    }

    var_6 = level.destructible_type[var_3].parts[var_4][var_5].v["sound"][var_2].size;
    level.destructible_type[var_3].parts[var_4][var_5].v["sound"][var_2][var_6] = var_0;
    level.destructible_type[var_3].parts[var_4][var_5].v["soundCause"][var_2][var_6] = var_1;
}

destructible_loopsound( var_0, var_1 )
{
    var_2 = level.destructible_type.size - 1;
    var_3 = level.destructible_type[var_2].parts.size - 1;
    var_4 = level.destructible_type[var_2].parts[var_3].size - 1;

    if ( !isdefined( level.destructible_type[var_2].parts[var_3][var_4].v["loopsound"] ) )
    {
        level.destructible_type[var_2].parts[var_3][var_4].v["loopsound"] = [];
        level.destructible_type[var_2].parts[var_3][var_4].v["loopsoundCause"] = [];
    }

    var_5 = level.destructible_type[var_2].parts[var_3][var_4].v["loopsound"].size;
    level.destructible_type[var_2].parts[var_3][var_4].v["loopsound"][var_5] = var_0;
    level.destructible_type[var_2].parts[var_3][var_4].v["loopsoundCause"][var_5] = var_1;
}

destructible_anim( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( !isdefined( var_3 ) )
        var_3 = 0;

    if ( !isdefined( var_4 ) )
        var_4 = 0;

    var_9 = [];
    var_9["anim"] = var_0;
    var_9["animTree"] = var_1;
    var_9["animType"] = var_2;
    var_9["vehicle_exclude_anim"] = var_3;
    var_9["groupNum"] = var_4;
    var_9["mpAnim"] = var_5;
    var_9["maxStartDelay"] = var_6;
    var_9["animRateMin"] = var_7;
    var_9["animRateMax"] = var_8;
    add_array_to_destructible( "animation", var_9 );
}

destructible_spotlight( var_0 )
{
    var_1 = [];
    var_1["spotlight_tag"] = var_0;
    var_1["spotlight_fx"] = "spotlight_fx";
    var_1["spotlight_brightness"] = 0.85;
    var_1["randomly_flip"] = 1;
    var_2 = [];
    var_2["r_spotlightendradius"] = 1200;
    var_2["r_spotlightstartradius"] = 50;
    var_1["dvars"] = var_2;
    add_keypairs_to_destructible( var_1 );
}

add_key_to_destructible( var_0, var_1 )
{
    var_2 = [];
    var_2[var_0] = var_1;
    add_keypairs_to_destructible( var_2 );
}

add_keypairs_to_destructible( var_0 )
{
    var_1 = level.destructible_type.size - 1;
    var_2 = level.destructible_type[var_1].parts.size - 1;
    var_3 = level.destructible_type[var_1].parts[var_2].size - 1;

    foreach ( var_6, var_5 in var_0 )
        level.destructible_type[var_1].parts[var_2][var_3].v[var_6] = var_5;
}

add_array_to_destructible( var_0, var_1 )
{
    var_2 = level.destructible_type.size - 1;
    var_3 = level.destructible_type[var_2].parts.size - 1;
    var_4 = level.destructible_type[var_2].parts[var_3].size - 1;
    var_5 = level.destructible_type[var_2].parts[var_3][var_4].v;

    if ( !isdefined( var_5[var_0] ) )
        var_5[var_0] = [];

    var_5[var_0][var_5[var_0].size] = var_1;
    level.destructible_type[var_2].parts[var_3][var_4].v = var_5;
}

destructible_car_alarm()
{
    var_0 = level.destructible_type.size - 1;
    var_1 = level.destructible_type[var_0].parts.size - 1;
    var_2 = level.destructible_type[var_0].parts[var_1].size - 1;
    level.destructible_type[var_0].parts[var_1][var_2].v["triggerCarAlarm"] = 1;
}

destructible_lights_out( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 256;

    var_1 = level.destructible_type.size - 1;
    var_2 = level.destructible_type[var_1].parts.size - 1;
    var_3 = level.destructible_type[var_1].parts[var_2].size - 1;
    level.destructible_type[var_1].parts[var_2][var_3].v["break_nearby_lights"] = var_0;
}

random_dynamic_attachment( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) )
        var_2 = "";

    var_4 = level.destructible_type.size - 1;
    var_5 = level.destructible_type[var_4].parts.size - 1;
    var_6 = 0;

    if ( !isdefined( level.destructible_type[var_4].parts[var_5][var_6].v["random_dynamic_attachment_1"] ) )
    {
        level.destructible_type[var_4].parts[var_5][var_6].v["random_dynamic_attachment_1"] = [];
        level.destructible_type[var_4].parts[var_5][var_6].v["random_dynamic_attachment_2"] = [];
        level.destructible_type[var_4].parts[var_5][var_6].v["random_dynamic_attachment_tag"] = [];
    }

    var_7 = level.destructible_type[var_4].parts[var_5][var_6].v["random_dynamic_attachment_1"].size;
    level.destructible_type[var_4].parts[var_5][var_6].v["random_dynamic_attachment_1"][var_7] = var_1;
    level.destructible_type[var_4].parts[var_5][var_6].v["random_dynamic_attachment_2"][var_7] = var_2;
    level.destructible_type[var_4].parts[var_5][var_6].v["random_dynamic_attachment_tag"][var_7] = var_0;
    level.destructible_type[var_4].parts[var_5][var_6].v["clipToRemove"][var_7] = var_3;
}

destructible_physics( var_0, var_1 )
{
    var_2 = level.destructible_type.size - 1;
    var_3 = level.destructible_type[var_2].parts.size - 1;
    var_4 = level.destructible_type[var_2].parts[var_3].size - 1;

    if ( !isdefined( level.destructible_type[var_2].parts[var_3][var_4].v["physics"] ) )
    {
        level.destructible_type[var_2].parts[var_3][var_4].v["physics"] = [];
        level.destructible_type[var_2].parts[var_3][var_4].v["physics_tagName"] = [];
        level.destructible_type[var_2].parts[var_3][var_4].v["physics_velocity"] = [];
    }

    var_5 = level.destructible_type[var_2].parts[var_3][var_4].v["physics"].size;
    level.destructible_type[var_2].parts[var_3][var_4].v["physics"][var_5] = 1;
    level.destructible_type[var_2].parts[var_3][var_4].v["physics_tagName"][var_5] = var_0;
    level.destructible_type[var_2].parts[var_3][var_4].v["physics_velocity"][var_5] = var_1;
}

destructible_splash_damage_scaler( var_0 )
{
    var_1 = level.destructible_type.size - 1;
    var_2 = level.destructible_type[var_1].parts.size - 1;
    var_3 = level.destructible_type[var_1].parts[var_2].size - 1;
    level.destructible_type[var_1].parts[var_2][var_3].v["splash_damage_scaler"] = var_0;
}

destructible_explode( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    var_10 = level.destructible_type.size - 1;
    var_11 = level.destructible_type[var_10].parts.size - 1;
    var_12 = level.destructible_type[var_10].parts[var_11].size - 1;

    if ( common_scripts\utility::issp() )
        level.destructible_type[var_10].parts[var_11][var_12].v["explode_range"] = var_2;
    else
        level.destructible_type[var_10].parts[var_11][var_12].v["explode_range"] = var_3;

    level.destructible_type[var_10].parts[var_11][var_12].v["explode"] = 1;
    level.destructible_type[var_10].parts[var_11][var_12].v["explode_force_min"] = var_0;
    level.destructible_type[var_10].parts[var_11][var_12].v["explode_force_max"] = var_1;
    level.destructible_type[var_10].parts[var_11][var_12].v["explode_mindamage"] = var_4;
    level.destructible_type[var_10].parts[var_11][var_12].v["explode_maxdamage"] = var_5;
    level.destructible_type[var_10].parts[var_11][var_12].v["continueDamage"] = var_6;
    level.destructible_type[var_10].parts[var_11][var_12].v["originOffset"] = var_7;
    level.destructible_type[var_10].parts[var_11][var_12].v["earthQuakeScale"] = var_8;
    level.destructible_type[var_10].parts[var_11][var_12].v["earthQuakeRadius"] = var_9;
}

destructible_info( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13 )
{
    if ( isdefined( var_3 ) )
        var_3 = tolower( var_3 );

    var_14 = level.destructible_type.size - 1;
    level.destructible_type[var_14].parts[var_0][var_1] = spawnstruct();
    level.destructible_type[var_14].parts[var_0][var_1].v["modelName"] = var_3;
    level.destructible_type[var_14].parts[var_0][var_1].v["tagName"] = var_2;
    level.destructible_type[var_14].parts[var_0][var_1].v["health"] = var_4;
    level.destructible_type[var_14].parts[var_0][var_1].v["validAttackers"] = var_5;
    level.destructible_type[var_14].parts[var_0][var_1].v["validDamageZone"] = var_6;
    level.destructible_type[var_14].parts[var_0][var_1].v["validDamageCause"] = var_7;
    level.destructible_type[var_14].parts[var_0][var_1].v["alsoDamageParent"] = var_8;
    level.destructible_type[var_14].parts[var_0][var_1].v["physicsOnExplosion"] = var_9;
    level.destructible_type[var_14].parts[var_0][var_1].v["grenadeImpactDeath"] = var_10;
    level.destructible_type[var_14].parts[var_0][var_1].v["godModeAllowed"] = 0;
    level.destructible_type[var_14].parts[var_0][var_1].v["splashRotation"] = var_11;
    level.destructible_type[var_14].parts[var_0][var_1].v["receiveDamageFromParent"] = var_12;

    if ( !isdefined( var_13 ) )
        level.destructible_type[var_14].parts[var_0][var_1].v["createEntityForAnimation"] = 0;
    else
        level.destructible_type[var_14].parts[var_0][var_1].v["createEntityForAnimation"] = var_13;
}

precache_destructibles()
{
    if ( !isdefined( level.destructible_type[self._id_C9DC].parts ) )
        return;

    for ( var_0 = 0; var_0 < level.destructible_type[self._id_C9DC].parts.size; var_0++ )
    {
        for ( var_1 = 0; var_1 < level.destructible_type[self._id_C9DC].parts[var_0].size; var_1++ )
        {
            if ( level.destructible_type[self._id_C9DC].parts[var_0].size <= var_1 )
                continue;

            if ( isdefined( level.destructible_type[self._id_C9DC].parts[var_0][var_1].v["modelName"] ) )
                precachemodel( level.destructible_type[self._id_C9DC].parts[var_0][var_1].v["modelName"] );

            if ( isdefined( level.destructible_type[self._id_C9DC].parts[var_0][var_1].v["animation"] ) )
            {
                var_2 = level.destructible_type[self._id_C9DC].parts[var_0][var_1].v["animation"];

                foreach ( var_4 in var_2 )
                {
                    if ( isdefined( var_4["mpAnim"] ) )
                        common_scripts\utility::noself_func( "precacheMpAnim", var_4["mpAnim"] );
                }
            }

            if ( isdefined( level.destructible_type[self._id_C9DC].parts[var_0][var_1].v["random_dynamic_attachment_1"] ) )
            {
                foreach ( var_7 in level.destructible_type[self._id_C9DC].parts[var_0][var_1].v["random_dynamic_attachment_1"] )
                {
                    if ( isdefined( var_7 ) && var_7 != "" )
                    {
                        precachemodel( var_7 );
                        precachemodel( var_7 + "_destroy" );
                    }
                }

                foreach ( var_7 in level.destructible_type[self._id_C9DC].parts[var_0][var_1].v["random_dynamic_attachment_2"] )
                {
                    if ( isdefined( var_7 ) && var_7 != "" )
                    {
                        precachemodel( var_7 );
                        precachemodel( var_7 + "_destroy" );
                    }
                }
            }
        }
    }
}

add_destructible_fx()
{
    if ( !isdefined( level.destructible_type[self._id_C9DC].parts ) )
        return;

    for ( var_0 = 0; var_0 < level.destructible_type[self._id_C9DC].parts.size; var_0++ )
    {
        for ( var_1 = 0; var_1 < level.destructible_type[self._id_C9DC].parts[var_0].size; var_1++ )
        {
            if ( level.destructible_type[self._id_C9DC].parts[var_0].size <= var_1 )
                continue;

            var_2 = level.destructible_type[self._id_C9DC].parts[var_0][var_1];

            if ( isdefined( var_2.v["fx_filename"] ) )
            {
                for ( var_3 = 0; var_3 < var_2.v["fx_filename"].size; var_3++ )
                {
                    var_4 = var_2.v["fx_filename"][var_3];

                    if ( isdefined( var_4 ) )
                    {
                        if ( isdefined( var_2.v["fx"] ) && isdefined( var_2.v["fx"][var_3] ) && var_2.v["fx"][var_3].size == var_4.size )
                            continue;

                        foreach ( var_7, var_6 in var_4 )
                            level.destructible_type[self._id_C9DC].parts[var_0][var_1].v["fx"][var_3][var_7] = common_scripts\utility::_id_D3CE( var_6 );
                    }
                }
            }

            var_8 = level.destructible_type[self._id_C9DC].parts[var_0][var_1].v["loopfx_filename"];

            if ( isdefined( var_8 ) )
            {
                if ( isdefined( var_2.v["loopfx"] ) && var_2.v["loopfx"].size == var_8.size )
                    continue;

                foreach ( var_7, var_10 in var_8 )
                    level.destructible_type[self._id_C9DC].parts[var_0][var_1].v["loopfx"][var_7] = common_scripts\utility::_id_D3CE( var_10 );
            }
        }
    }
}

candamagedestructible( var_0 )
{
    foreach ( var_2 in self.destructibles )
    {
        if ( var_2 == var_0 )
            return 1;
    }

    return 0;
}

destructible_think()
{
    var_0 = 0;
    var_1 = self.model;
    var_2 = undefined;
    var_3 = self.origin;
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;
    destructible_update_part( var_0, var_1, var_2, var_3, var_4, var_5, var_6 );
    self endon( "stop_taking_damage" );

    for (;;)
    {
        var_0 = undefined;
        var_5 = undefined;
        var_4 = undefined;
        var_3 = undefined;
        var_7 = undefined;
        var_1 = undefined;
        var_2 = undefined;
        var_8 = undefined;
        var_9 = undefined;
        self waittill( "damage", var_0, var_5, var_4, var_3, var_7, var_1, var_2, var_8, var_9 );

        if ( !isdefined( var_0 ) )
            continue;

        if ( isdefined( var_5 ) && isdefined( var_5.type ) && var_5.type == "soft_landing" && !var_5 candamagedestructible( self ) )
            continue;

        if ( common_scripts\utility::issp() )
            var_0 *= 0.5;
        else
            var_0 *= 1.0;

        if ( var_0 <= 0 )
            continue;

        if ( isdefined( var_5 ) && isplayer( var_5 ) )
            self.damageowner = var_5;

        var_7 = getdamagetype( var_7 );

        if ( is_shotgun_damage( var_5, var_7 ) )
        {
            if ( common_scripts\utility::issp() )
                var_0 *= 8.0;
            else
                var_0 *= 4.0;
        }

        if ( !isdefined( var_1 ) || var_1 == "" )
            var_1 = self.model;

        if ( isdefined( var_2 ) && var_2 == "" )
        {
            if ( isdefined( var_8 ) && var_8 != "" && var_8 != "tag_body" && var_8 != "body_animate_jnt" )
                var_2 = var_8;
            else
                var_2 = undefined;

            var_10 = level.destructible_type[self._id_C9DC].parts[0][0].v["tagName"];

            if ( isdefined( var_10 ) && isdefined( var_8 ) && var_10 == var_8 )
                var_2 = undefined;
        }

        if ( var_7 == "splash" )
        {
            if ( isdefined( level.destructible_type[self._id_C9DC].parts[0][0].v["splash_damage_scaler"] ) )
                var_0 *= level.destructible_type[self._id_C9DC].parts[0][0].v["splash_damage_scaler"];
            else if ( common_scripts\utility::issp() )
                var_0 *= 9.0;
            else
                var_0 *= 13.0;

            destructible_splash_damage( int( var_0 ), var_3, var_4, var_5, var_7 );
            continue;
        }

        thread destructible_update_part( int( var_0 ), var_1, var_2, var_3, var_4, var_5, var_7 );
    }
}

is_shotgun_damage( var_0, var_1 )
{
    if ( var_1 != "bullet" )
        return 0;

    if ( !isdefined( var_0 ) )
        return 0;

    var_2 = undefined;

    if ( isplayer( var_0 ) )
        var_2 = var_0 getcurrentweapon();

    if ( !isdefined( var_2 ) )
        return 0;

    var_3 = weaponclass( var_2 );

    if ( isdefined( var_3 ) && var_3 == "spread" )
        return 1;

    return 0;
}

getpartandstateindex( var_0, var_1 )
{
    var_2 = spawnstruct();
    var_2.v = [];
    var_3 = -1;
    var_4 = -1;

    if ( tolower( var_0 ) == tolower( self.model ) && !isdefined( var_1 ) )
    {
        var_0 = self.model;
        var_1 = undefined;
        var_3 = 0;
        var_4 = 0;
    }

    for ( var_5 = 0; var_5 < level.destructible_type[self._id_C9DC].parts.size; var_5++ )
    {
        var_4 = self.destructible_parts[var_5].v["currentState"];

        if ( level.destructible_type[self._id_C9DC].parts[var_5].size <= var_4 )
            continue;

        if ( !isdefined( var_1 ) )
            continue;

        if ( isdefined( level.destructible_type[self._id_C9DC].parts[var_5][var_4].v["tagName"] ) )
        {
            var_6 = level.destructible_type[self._id_C9DC].parts[var_5][var_4].v["tagName"];

            if ( var_6 == var_1 )
            {
                var_3 = var_5;
                break;
            }
        }
    }

    var_2.v["stateIndex"] = var_4;
    var_2.v["partIndex"] = var_3;
    return var_2;
}

destructible_update_part( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    if ( !isdefined( self.destructible_parts ) )
        return;

    if ( self.destructible_parts.size == 0 )
        return;

    var_8 = getpartandstateindex( var_1, var_2 );
    var_9 = var_8.v["stateIndex"];
    var_10 = var_8.v["partIndex"];

    if ( var_10 < 0 )
        return;

    var_11 = var_9;
    var_12 = 0;
    var_13 = 0;

    for (;;)
    {
        var_9 = self.destructible_parts[var_10].v["currentState"];

        if ( !isdefined( level.destructible_type[self._id_C9DC].parts[var_10][var_9] ) )
            break;

        if ( isdefined( level.destructible_type[self._id_C9DC].parts[var_10][0].v["alsoDamageParent"] ) )
        {
            if ( getdamagetype( var_6 ) != "splash" )
            {
                var_14 = level.destructible_type[self._id_C9DC].parts[var_10][0].v["alsoDamageParent"];
                var_15 = int( var_0 * var_14 );
                thread notifydamageafterframe( var_15, var_5, var_4, var_3, var_6, "", "" );
            }
        }

        if ( getdamagetype( var_6 ) != "splash" )
        {
            foreach ( var_17 in level.destructible_type[self._id_C9DC].parts )
            {
                if ( !isdefined( var_17[0].v["receiveDamageFromParent"] ) )
                    continue;

                if ( !isdefined( var_17[0].v["tagName"] ) )
                    continue;

                var_14 = var_17[0].v["receiveDamageFromParent"];
                var_18 = int( var_0 * var_14 );
                var_19 = var_17[0].v["tagName"];
                thread notifydamageafterframe( var_18, var_5, var_4, var_3, var_6, "", var_19 );
            }
        }

        if ( !isdefined( level.destructible_type[self._id_C9DC].parts[var_10][var_9].v["health"] ) )
            break;

        if ( !isdefined( self.destructible_parts[var_10].v["health"] ) )
            break;

        if ( var_12 )
            self.destructible_parts[var_10].v["health"] = level.destructible_type[self._id_C9DC].parts[var_10][var_9].v["health"];

        var_12 = 0;

        if ( isdefined( level.destructible_type[self._id_C9DC].parts[var_10][var_9].v["grenadeImpactDeath"] ) && var_6 == "impact" )
            var_0 = 100000000;

        var_21 = self.destructible_parts[var_10].v["health"];
        var_22 = isattackervalid( var_10, var_9, var_5 );

        if ( var_22 )
        {
            var_23 = isvaliddamagecause( var_10, var_9, var_6 );

            if ( var_23 )
            {
                if ( isdefined( var_5 ) )
                {
                    if ( isplayer( var_5 ) )
                        self.player_damage += var_0;
                    else if ( var_5 != self )
                        self.non_player_damage += var_0;
                }

                if ( isdefined( var_6 ) )
                {
                    if ( var_6 == "melee" || var_6 == "impact" )
                        var_0 = 100000;
                }

                self.destructible_parts[var_10].v["health"] -= var_0;
            }
        }

        if ( self.destructible_parts[var_10].v["health"] > 0 )
            return;

        if ( isdefined( var_7 ) )
        {
            var_7.v["fxcost"] = get_part_fx_cost_for_action_state( var_10, self.destructible_parts[var_10].v["currentState"] );
            add_destructible_to_frame_queue( self, var_7, var_0 );
            self.waiting_for_queue = 1;
            self waittill( "queue_processed", var_24 );
            self.waiting_for_queue = undefined;

            if ( !var_24 )
            {
                self.destructible_parts[var_10].v["health"] = var_21;
                return;
            }
        }

        var_0 = int( abs( self.destructible_parts[var_10].v["health"] ) );

        if ( var_0 < 0 )
            return;

        self.destructible_parts[var_10].v["currentState"]++;
        var_9 = self.destructible_parts[var_10].v["currentState"];
        var_25 = var_9 - 1;
        var_26 = undefined;

        if ( isdefined( level.destructible_type[self._id_C9DC].parts[var_10][var_25] ) )
            var_26 = level.destructible_type[self._id_C9DC].parts[var_10][var_25].v;

        var_27 = undefined;

        if ( isdefined( level.destructible_type[self._id_C9DC].parts[var_10][var_9] ) )
            var_27 = level.destructible_type[self._id_C9DC].parts[var_10][var_9].v;

        if ( !isdefined( level.destructible_type[self._id_C9DC].parts[var_10][var_25] ) )
            return;

        if ( isdefined( level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["explode"] ) )
            self.exploding = 1;

        if ( isdefined( self.loopingsoundstopnotifies ) && isdefined( self.loopingsoundstopnotifies[common_scripts\utility::tostring( var_10 )] ) )
        {
            for ( var_28 = 0; var_28 < self.loopingsoundstopnotifies[common_scripts\utility::tostring( var_10 )].size; var_28++ )
            {
                self notify( self.loopingsoundstopnotifies[common_scripts\utility::tostring( var_10 )][var_28] );

                if ( common_scripts\utility::issp() && self.modeldummyon )
                    self.modeldummy notify( self.loopingsoundstopnotifies[common_scripts\utility::tostring( var_10 )][var_28] );
            }

            self.loopingsoundstopnotifies[common_scripts\utility::tostring( var_10 )] = undefined;
        }

        if ( isdefined( var_26["break_nearby_lights"] ) )
            destructible_get_my_breakable_light( var_26["break_nearby_lights"] );

        if ( isdefined( level.destructible_type[self._id_C9DC].parts[var_10][var_9] ) )
        {
            if ( var_10 == 0 )
            {
                var_29 = var_27["modelName"];

                if ( isdefined( var_29 ) && var_29 != self.model )
                {
                    self setmodel( var_29 );

                    if ( common_scripts\utility::issp() && self.modeldummyon )
                        self.modeldummy setmodel( var_29 );

                    destructible_splash_rotatation( var_27 );
                }
            }
            else
            {
                hideapart( var_2 );

                if ( common_scripts\utility::issp() && self.modeldummyon )
                    self.modeldummy hideapart( var_2 );

                var_2 = var_27["tagName"];

                if ( isdefined( var_2 ) )
                {
                    showapart( var_2 );

                    if ( common_scripts\utility::issp() && self.modeldummyon )
                        self.modeldummy showapart( var_2 );
                }
            }
        }

        var_30 = get_dummy();

        if ( isdefined( self.exploding ) && ( level.script != "boneyard" || var_30.model != "vehicle_mack_truck_short_green_destroy_animated" ) )
            clear_anims( var_30 );

        var_31 = destructible_animation_think( var_26, var_30, var_6, var_10 );
        var_31 = destructible_fx_think( var_26, var_30, var_6, var_10, var_31 );
        var_31 = destructible_sound_think( var_26, var_30, var_6, var_31 );

        if ( isdefined( level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["createEntityForAnimation"] ) && level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["createEntityForAnimation"] && !isdefined( self.exploded ) )
        {
            var_32 = _id_CF3C( var_10, var_25, self._id_C9DC );

            if ( isdefined( level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["partAnim"] ) )
            {
                var_33 = level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["partAnim"];
                var_34 = level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["partAnimTree"];
                var_32 useanimtree( var_34 );
                var_35 = level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["partAnimType"];

                if ( !isdefined( self.animsapplied ) )
                    self.animsapplied = [];

                self.animsapplied[self.animsapplied.size] = var_33;

                if ( isdefined( self.exploding ) && isdefined( self.animsapplied ) )
                {
                    for ( var_28 = 0; var_28 < self.animsapplied.size; var_28++ )
                        var_32 clearanim( self.animsapplied[var_28], 0 );
                }

                if ( var_35 == "setanim" )
                    var_32 setanim( var_33, 1.0, 1.0, 1.0 );
                else if ( var_35 == "setanimknob" )
                    var_32 setanimknob( var_33, 1.0, 1.0, 1.0 );
                else
                {

                }
            }
        }

        if ( isdefined( level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["loopfx"] ) )
        {
            var_36 = level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["loopfx_filename"].size;

            if ( var_36 > 0 )
                self notify( "FX_State_Change" + var_10 );

            for ( var_37 = 0; var_37 < var_36; var_37++ )
            {
                var_38 = level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["loopfx"][var_37];
                var_39 = level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["loopfx_tag"][var_37];
                var_40 = level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["loopfx_rate"][var_37];
                thread loopfx_ontag( var_38, var_39, var_40, var_10 );
            }
        }

        if ( isdefined( level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["loopsound"] ) )
        {
            for ( var_28 = 0; var_28 < level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["loopsound"].size; var_28++ )
            {
                var_41 = isvalidsoundcause( "loopsoundCause", var_26, var_28, var_6 );

                if ( var_41 )
                {
                    var_42 = level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["loopsound"][var_28];
                    var_43 = level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["tagName"];
                    thread play_loop_sound_on_destructible( var_42, var_43 );

                    if ( !isdefined( self.loopingsoundstopnotifies ) )
                        self.loopingsoundstopnotifies = [];

                    if ( !isdefined( self.loopingsoundstopnotifies[common_scripts\utility::tostring( var_10 )] ) )
                        self.loopingsoundstopnotifies[common_scripts\utility::tostring( var_10 )] = [];

                    var_44 = self.loopingsoundstopnotifies[common_scripts\utility::tostring( var_10 )].size;
                    self.loopingsoundstopnotifies[common_scripts\utility::tostring( var_10 )][var_44] = "stop sound" + var_42;
                }
            }
        }

        if ( isdefined( level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["triggerCarAlarm"] ) )
            thread do_car_alarm();

        if ( isdefined( level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["break_nearby_lights"] ) )
            thread break_nearest_light();

        if ( isdefined( level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["healthdrain_amount"] ) )
        {
            self notify( "Health_Drain_State_Change" + var_10 );
            var_45 = level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["healthdrain_amount"];
            var_46 = level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["healthdrain_interval"];
            var_47 = level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["modelName"];
            var_48 = level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["tagName"];
            var_49 = level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["badplace_radius"];
            var_50 = level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["badplace_team"];

            if ( var_45 > 0 )
                thread health_drain( var_45, var_46, var_10, var_47, var_48, var_49, var_50 );
        }

        if ( isdefined( level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["explode"] ) )
        {
            var_13 = 1;
            var_51 = level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["explode_force_min"];
            var_52 = level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["explode_force_max"];
            var_53 = level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["explode_range"];
            var_54 = level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["explode_mindamage"];
            var_55 = level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["explode_maxdamage"];
            var_56 = level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["continueDamage"];
            var_57 = level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["originOffset"];
            var_58 = level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["earthQuakeScale"];
            var_59 = level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["earthQuakeRadius"];

            if ( isdefined( var_5 ) && var_5 != self )
            {
                self.attacker = var_5;

                if ( self.code_classname == "script_vehicle" )
                    self.damage_type = var_6;
            }

            thread explode( var_10, var_51, var_52, var_53, var_54, var_55, var_56, var_57, var_58, var_59, var_5 );
        }

        var_60 = undefined;

        if ( isdefined( level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["physics"] ) )
        {
            if ( isdefined( level.destructible_type[self._id_C9DC].parts[var_10][0].v["physicsOnExplosion"] ) )
                level.destructible_type[self._id_C9DC].parts[var_10][0].v["physicsOnExplosion"] = undefined;

            for ( var_28 = 0; var_28 < level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["physics"].size; var_28++ )
            {
                var_60 = undefined;
                var_61 = level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["physics_tagName"][var_28];
                var_62 = level.destructible_type[self._id_C9DC].parts[var_10][var_25].v["physics_velocity"][var_28];
                var_63 = undefined;

                if ( isdefined( var_62 ) )
                {
                    var_64 = undefined;

                    if ( isdefined( var_61 ) )
                        var_64 = self gettagangles( var_61 );
                    else if ( isdefined( var_2 ) )
                        var_64 = self gettagangles( var_2 );

                    var_60 = undefined;

                    if ( isdefined( var_61 ) )
                        var_60 = self gettagorigin( var_61 );
                    else if ( isdefined( var_2 ) )
                        var_60 = self gettagorigin( var_2 );

                    var_65 = var_62[0] - 5 + randomfloat( 10 );
                    var_66 = var_62[1] - 5 + randomfloat( 10 );
                    var_67 = var_62[2] - 5 + randomfloat( 10 );
                    var_68 = anglestoforward( var_64 ) * var_65 * randomfloatrange( 80, 110 );
                    var_69 = anglestoright( var_64 ) * var_66 * randomfloatrange( 80, 110 );
                    var_70 = anglestoup( var_64 ) * var_67 * randomfloatrange( 80, 110 );
                    var_63 = var_68 + var_69 + var_70;
                }
                else
                {
                    var_63 = var_3;
                    var_71 = ( 0, 0, 0 );

                    if ( isdefined( var_5 ) )
                    {
                        var_71 = var_5.origin;
                        var_63 = vectornormalize( var_3 - var_71 );
                        var_63 = maps\_utility::_id_C32D( var_63, 200 );
                    }
                }

                if ( isdefined( var_61 ) )
                {
                    var_72 = undefined;

                    for ( var_73 = 0; var_73 < level.destructible_type[self._id_C9DC].parts.size; var_73++ )
                    {
                        if ( !isdefined( level.destructible_type[self._id_C9DC].parts[var_73][0].v["tagName"] ) )
                            continue;

                        if ( level.destructible_type[self._id_C9DC].parts[var_73][0].v["tagName"] != var_61 )
                            continue;

                        var_72 = var_73;
                        break;
                    }

                    if ( isdefined( var_60 ) )
                        thread physics_launch( var_72, 0, var_60, var_63 );
                    else
                        thread physics_launch( var_72, 0, var_3, var_63 );

                    continue;
                }

                if ( isdefined( var_60 ) )
                    thread physics_launch( var_10, var_25, var_60, var_63 );
                else
                    thread physics_launch( var_10, var_25, var_3, var_63 );

                return;
            }
        }

        var_12 = 1;
    }
}

destructible_splash_rotatation( var_0 )
{
    var_1 = var_0["splashRotation"];
    var_2 = var_0["rotateTo"];

    if ( !isdefined( var_2 ) )
        return;

    if ( !isdefined( var_1 ) )
        return;

    if ( !var_1 )
        return;

    self.angles = ( self.angles[0], var_2[1], self.angles[2] );
}

damage_not( var_0 )
{
    var_1 = strtok( var_0, " " );
    var_2 = strtok( "splash melee bullet splash impact unknown", " " );
    var_3 = "";

    foreach ( var_6, var_5 in var_1 )
        var_2 = common_scripts\utility::array_remove( var_2, var_5 );

    foreach ( var_8 in var_2 )
        var_3 += ( var_8 + " " );

    return var_3;
}

destructible_splash_damage( var_0, var_1, var_2, var_3, var_4 )
{
    if ( var_0 <= 0 )
        return;

    if ( isdefined( self.exploded ) )
        return;

    if ( !isdefined( level.destructible_type[self._id_C9DC].parts ) )
        return;

    var_5 = getallactiveparts( var_2 );

    if ( var_5.size <= 0 )
        return;

    var_5 = setdistanceonparts( var_5, var_1 );
    var_6 = getlowestpartdistance( var_5 );

    foreach ( var_8 in var_5 )
    {
        var_9 = var_8.v["distance"] * 1.4;
        var_10 = var_0 - ( var_9 - var_6 );

        if ( var_10 <= 0 )
            continue;

        if ( isdefined( self.exploded ) )
            continue;

        thread destructible_update_part( var_10, var_8.v["modelName"], var_8.v["tagName"], var_1, var_2, var_3, var_4, var_8 );
    }
}

getallactiveparts( var_0 )
{
    var_1 = [];

    if ( !isdefined( level.destructible_type[self._id_C9DC].parts ) )
        return var_1;

    for ( var_2 = 0; var_2 < level.destructible_type[self._id_C9DC].parts.size; var_2++ )
    {
        var_3 = var_2;
        var_4 = self.destructible_parts[var_3].v["currentState"];

        for ( var_5 = 0; var_5 < level.destructible_type[self._id_C9DC].parts[var_3].size; var_5++ )
        {
            var_6 = level.destructible_type[self._id_C9DC].parts[var_3][var_5].v["splashRotation"];

            if ( isdefined( var_6 ) && var_6 )
            {
                var_7 = vectortoangles( var_0 );
                var_8 = var_7[1] - 90;
                level.destructible_type[self._id_C9DC].parts[var_3][var_5].v["rotateTo"] = ( 0, var_8, 0 );
            }
        }

        if ( !isdefined( level.destructible_type[self._id_C9DC].parts[var_3][var_4] ) )
            continue;

        var_9 = level.destructible_type[self._id_C9DC].parts[var_3][var_4].v["tagName"];

        if ( !isdefined( var_9 ) )
            var_9 = "";

        if ( var_9 == "" )
            continue;

        var_10 = level.destructible_type[self._id_C9DC].parts[var_3][var_4].v["modelName"];

        if ( !isdefined( var_10 ) )
            var_10 = "";

        var_11 = var_1.size;
        var_1[var_11] = spawnstruct();
        var_1[var_11].v["modelName"] = var_10;
        var_1[var_11].v["tagName"] = var_9;
    }

    return var_1;
}

setdistanceonparts( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
    {
        var_3 = 0;

        if ( maps\_utility::hastag( self.model, var_0[var_2].v["tagName"] ) )
            var_3 = distance( var_1, self gettagorigin( var_0[var_2].v["tagName"] ) );
        else
        {

        }

        var_0[var_2].v["distance"] = var_3;
    }

    return var_0;
}

getlowestpartdistance( var_0 )
{
    var_1 = undefined;

    foreach ( var_3 in var_0 )
    {
        var_4 = var_3.v["distance"];

        if ( !isdefined( var_1 ) )
            var_1 = var_4;

        if ( var_4 < var_1 )
            var_1 = var_4;
    }

    return var_1;
}

isvalidsoundcause( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( var_4 ) )
        var_5 = var_1[var_0][var_4][var_2];
    else
        var_5 = var_1[var_0][var_2];

    if ( !isdefined( var_5 ) )
        return 1;

    if ( var_5 == var_3 )
        return 1;

    return 0;
}

isattackervalid( var_0, var_1, var_2 )
{
    if ( isdefined( self.forceexploding ) )
        return 1;

    if ( isdefined( level.destructible_type[self._id_C9DC].parts[var_0][var_1].v["explode"] ) )
    {
        if ( isdefined( self.dontallowexplode ) )
            return 0;
    }

    if ( !isdefined( var_2 ) )
        return 1;

    if ( var_2 == self )
        return 1;

    var_3 = level.destructible_type[self._id_C9DC].parts[var_0][var_1].v["validAttackers"];

    if ( !isdefined( var_3 ) )
        return 1;

    if ( var_3 == "no_player" )
    {
        if ( !isplayer( var_2 ) )
            return 1;

        if ( !isdefined( var_2.damageisfromplayer ) )
            return 1;

        if ( var_2.damageisfromplayer == 0 )
            return 1;
    }
    else if ( var_3 == "player_only" )
    {
        if ( isplayer( var_2 ) )
            return 1;

        if ( isdefined( var_2.damageisfromplayer ) && var_2.damageisfromplayer )
            return 1;
    }
    else if ( var_3 == "no_ai" && isdefined( level.isaifunc ) )
    {
        if ( ![[ level.isaifunc ]]( var_2 ) )
            return 1;
    }
    else if ( var_3 == "ai_only" && isdefined( level.isaifunc ) )
    {
        if ( [[ level.isaifunc ]]( var_2 ) )
            return 1;
    }
    else
    {

    }

    return 0;
}

isvaliddamagecause( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        return 1;

    var_3 = level.destructible_type[self._id_C9DC].parts[var_0][var_1].v["godModeAllowed"];

    if ( var_3 && ( isdefined( self.godmode ) && self.godmode || isdefined( self.script_bulletshield ) && self.script_bulletshield && var_2 == "bullet" ) )
        return 0;

    var_4 = level.destructible_type[self._id_C9DC].parts[var_0][var_1].v["validDamageCause"];

    if ( !isdefined( var_4 ) )
        return 1;

    if ( var_4 == "splash" && var_2 != "splash" )
        return 0;

    if ( var_4 == "no_melee" && var_2 == "melee" || var_2 == "impact" )
        return 0;

    return 1;
}

getdamagetype( var_0 )
{
    if ( !isdefined( var_0 ) )
        return "unknown";

    var_0 = tolower( var_0 );

    switch ( var_0 )
    {
        case "mod_crush":
        case "mod_melee":
        case "melee":
            return "melee";
        case "bullet":
        case "mod_rifle_bullet":
        case "mod_pistol_bullet":
            return "bullet";
        case "mod_explosive":
        case "mod_projectile_splash":
        case "mod_projectile":
        case "splash":
        case "mod_grenade_splash":
        case "mod_grenade":
            return "splash";
        case "mod_impact":
            return "impact";
        case "unknown":
            return "unknown";
        default:
            return "unknown";
    }
}

damage_mirror( var_0, var_1, var_2 )
{
    self notify( "stop_damage_mirror" );
    self endon( "stop_damage_mirror" );
    var_0 endon( "stop_taking_damage" );
    self setcandamage( 1 );

    for (;;)
    {
        self waittill( "damage", var_3, var_4, var_5, var_6, var_7 );
        var_0 notify( "damage", var_3, var_4, var_5, var_6, var_7, var_1, var_2 );
        var_3 = undefined;
        var_4 = undefined;
        var_5 = undefined;
        var_6 = undefined;
        var_7 = undefined;
    }
}

add_damage_owner_recorder()
{
    self.player_damage = 0;
    self.non_player_damage = 0;
    self.car_damage_owner_recorder = 1;
}

loopfx_ontag_singleshot( var_0, var_1, var_2 )
{
    var_3 = get_dummy();

    if ( isdefined( var_3 ) && maps\_utility::hastag( var_3.model, var_1 ) )
    {
        playfxontag( var_0, var_3, var_1 );
        common_scripts\utility::waittill_any_ents( self, "FX_State_Change" + var_2, self, "delete_destructible", level, "putout_fires" );

        if ( isdefined( var_3 ) )
        {
            if ( maps\_utility::hastag( var_3.model, var_1 ) )
                stopfxontag( var_0, var_3, var_1 );
            else
            {

            }
        }
    }
    else
    {
        if ( isdefined( var_3 ) )
            return;

        return;
    }
}

loopfx_ontag( var_0, var_1, var_2, var_3 )
{
    if ( var_2 == 0 )
    {
        thread loopfx_ontag_singleshot( var_0, var_1, var_3 );
        return;
    }

    self endon( "FX_State_Change" + var_3 );
    self endon( "delete_destructible" );
    level endon( "putout_fires" );

    while ( isdefined( self ) )
    {
        var_4 = get_dummy();

        if ( maps\_utility::hastag( var_4.model, var_1 ) )
            playfxontag( var_0, var_4, var_1 );
        else
        {

        }

        wait( var_2 );
    }
}

health_drain( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    self endon( "Health_Drain_State_Change" + var_2 );
    level endon( "putout_fires" );
    self endon( "destroyed" );

    if ( isdefined( var_5 ) && isdefined( level.destructible_badplace_radius_multiplier ) )
        var_5 *= level.destructible_badplace_radius_multiplier;

    if ( isdefined( var_0 ) && isdefined( level.destructible_health_drain_amount_multiplier ) )
        var_0 *= level.destructible_health_drain_amount_multiplier;

    wait( var_1 );
    self.healthdrain = 1;
    var_7 = undefined;

    if ( isdefined( level.disable_destructible_bad_places ) && level.disable_destructible_bad_places )
        var_5 = undefined;

    if ( isdefined( var_5 ) && isdefined( var_6 ) && common_scripts\utility::issp() )
    {
        var_7 = "" + gettime();

        if ( !isdefined( self.disablebadplace ) )
        {
            if ( isdefined( self.script_radius ) )
                var_5 = self.script_radius;

            if ( var_6 == "both" )
                call [[ level.badplace_cylinder_func ]]( var_7, 0, self.origin, var_5, 128, "allies", "bad_guys" );
            else
                call [[ level.badplace_cylinder_func ]]( var_7, 0, self.origin, var_5, 128, var_6 );

            thread badplace_remove( var_7 );
        }
    }

    while ( isdefined( self ) && self.destructible_parts[var_2].v["health"] > 0 )
    {
        self notify( "damage", var_0, self, ( 0, 0, 0 ), ( 0, 0, 0 ), "MOD_UNKNOWN", var_3, var_4 );
        wait( var_1 );
    }

    self notify( "remove_badplace" );
}

badplace_remove( var_0 )
{
    common_scripts\utility::waittill_any( "destroyed", "remove_badplace" );
    call [[ level.badplace_delete_func ]]( var_0 );
}

physics_launch( var_0, var_1, var_2, var_3 )
{
    var_4 = level.destructible_type[self._id_C9DC].parts[var_0][var_1].v["modelName"];
    var_5 = level.destructible_type[self._id_C9DC].parts[var_0][var_1].v["tagName"];
    hideapart( var_5 );

    if ( level.destructiblespawnedents.size >= level.destructiblespawnedentslimit )
        physics_object_remove( level.destructiblespawnedents[0] );

    var_6 = spawn( "script_model", self gettagorigin( var_5 ) );
    var_6.angles = self gettagangles( var_5 );
    var_6 setmodel( var_4 );
    level.destructiblespawnedents[level.destructiblespawnedents.size] = var_6;
    var_6 physicslaunchclient( var_2, var_3 );
}

physics_object_remove( var_0 )
{
    var_1 = [];

    for ( var_2 = 0; var_2 < level.destructiblespawnedents.size; var_2++ )
    {
        if ( level.destructiblespawnedents[var_2] == var_0 )
            continue;

        var_1[var_1.size] = level.destructiblespawnedents[var_2];
    }

    level.destructiblespawnedents = var_1;

    if ( isdefined( var_0 ) )
        var_0 delete();
}

_id_CF3C( var_0, var_1, var_2 )
{
    var_3 = level.destructible_type[self._id_C9DC].parts[var_0][var_1].v["modelName"];
    var_4 = level.destructible_type[self._id_C9DC].parts[var_0][var_1].v["tagName"];
    hideapart( var_4 );
    var_5 = spawn( "script_model", self gettagorigin( var_4 ) );
    var_5.angles = self gettagangles( var_4 );
    var_5 setmodel( var_3 );
    var_5 linkto( self );

    if ( !isdefined( self._id_B786 ) )
        self._id_B786 = [];

    self._id_B786[self._id_B786.size] = var_5;
    return var_5;
}

explode( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 )
{
    if ( isdefined( var_3 ) && isdefined( level.destructible_explosion_radius_multiplier ) )
        var_3 *= level.destructible_explosion_radius_multiplier;

    if ( !isdefined( var_7 ) )
        var_7 = 80;

    if ( !isdefined( var_6 ) || isdefined( var_6 ) && !var_6 )
    {
        if ( isdefined( self.exploded ) )
            return;

        self.exploded = 1;
    }

    self notify( "exploded", var_10 );
    level notify( "destructible_exploded" );

    if ( self.code_classname == "script_vehicle" )
        self notify( "death", var_10, self.damage_type );

    if ( common_scripts\utility::issp() )
        thread disconnecttraverses();

    wait 0.05;
    var_11 = self.destructible_parts[var_0].v["currentState"];
    var_12 = undefined;

    if ( isdefined( level.destructible_type[self._id_C9DC].parts[var_0][var_11] ) )
        var_12 = level.destructible_type[self._id_C9DC].parts[var_0][var_11].v["tagName"];

    if ( isdefined( var_12 ) )
        var_13 = self gettagorigin( var_12 );
    else
        var_13 = self.origin;

    self notify( "damage", var_5, self, ( 0, 0, 0 ), var_13, "MOD_EXPLOSIVE", "", "" );
    self notify( "stop_car_alarm" );
    waittillframeend;

    if ( isdefined( self._id_B786 ) )
    {
        foreach ( var_15 in self._id_B786 )
            var_15 delete();
    }

    if ( isdefined( level.destructible_type[self._id_C9DC].parts ) )
    {
        for ( var_17 = level.destructible_type[self._id_C9DC].parts.size - 1; var_17 >= 0; var_17-- )
        {
            if ( var_17 == var_0 )
                continue;

            var_18 = self.destructible_parts[var_17].v["currentState"];

            if ( var_18 >= level.destructible_type[self._id_C9DC].parts[var_17].size )
                var_18 = level.destructible_type[self._id_C9DC].parts[var_17].size - 1;

            var_19 = level.destructible_type[self._id_C9DC].parts[var_17][var_18].v["modelName"];
            var_12 = level.destructible_type[self._id_C9DC].parts[var_17][var_18].v["tagName"];

            if ( !isdefined( var_19 ) )
                continue;

            if ( !isdefined( var_12 ) )
                continue;

            if ( isdefined( level.destructible_type[self._id_C9DC].parts[var_17][0].v["physicsOnExplosion"] ) )
            {
                if ( level.destructible_type[self._id_C9DC].parts[var_17][0].v["physicsOnExplosion"] > 0 )
                {
                    var_20 = level.destructible_type[self._id_C9DC].parts[var_17][0].v["physicsOnExplosion"];
                    var_21 = self gettagorigin( var_12 );
                    var_22 = vectornormalize( var_21 - var_13 );
                    var_22 = maps\_utility::_id_C32D( var_22, randomfloatrange( var_1, var_2 ) * var_20 );
                    thread physics_launch( var_17, var_18, var_21, var_22 );
                    continue;
                }
            }
        }
    }

    var_23 = !isdefined( var_6 ) || isdefined( var_6 ) && !var_6;

    if ( var_23 )
        self notify( "stop_taking_damage" );

    wait 0.05;
    var_24 = var_13 + ( 0, 0, var_7 );
    var_25 = getsubstr( level.destructible_type[self._id_C9DC].v["type"], 0, 7 ) == "vehicle";

    if ( var_25 )
    {
        anim.lastcarexplosiontime = gettime();
        anim.lastcarexplosiondamagelocation = var_24;
        anim.lastcarexplosionlocation = var_13;
        anim.lastcarexplosionrange = var_3;
    }

    level thread set_disable_friendlyfire_value_delayed( 1 );

    if ( common_scripts\utility::issp() )
    {
        if ( !isdefined( self._id_C56B ) || self._id_C56B )
        {
            if ( level.gameskill == 0 && !player_touching_post_clip() )
                self radiusdamage( var_24, var_3, var_5, var_4, self, "MOD_RIFLE_BULLET" );
            else
                self radiusdamage( var_24, var_3, var_5, var_4, self );

            if ( isdefined( self.damageowner ) && var_25 )
            {
                self.damageowner notify( "destroyed_car" );
                level notify( "player_destroyed_car", self.damageowner, var_24 );
            }
        }
    }
    else if ( !isdefined( self.damageowner ) )
        self radiusdamage( var_24, var_3, var_5, var_4, self );
    else
    {
        self radiusdamage( var_24, var_3, var_5, var_4, self.damageowner );

        if ( var_25 )
        {
            self.damageowner notify( "destroyed_car" );
            level notify( "player_destroyed_car", self.damageowner, var_24 );
        }
    }

    if ( isdefined( var_8 ) && isdefined( var_9 ) )
        earthquake( var_8, 2.0, var_24, var_9 );

    level thread set_disable_friendlyfire_value_delayed( 0, 0.05 );
    var_26 = 0.01;
    var_27 = var_3 * var_26;
    var_3 *= 0.99;
    physicsexplosionsphere( var_24, var_3, 0, var_27 );

    if ( var_23 )
    {
        self setcandamage( 0 );
        thread cleanupvars();
    }

    self notify( "destroyed" );
}

cleanupvars()
{
    wait 0.05;

    if ( !isdefined( self ) )
        return;

    if ( isdefined( self.waiting_for_queue ) )
        self waittill( "queue_processed" );

    if ( !isdefined( self ) )
        return;

    self.animsapplied = undefined;
    self.attacker = undefined;
    self.car_damage_owner_recorder = undefined;
    self.caralarm = undefined;
    self.damageowner = undefined;
    self.destructible_parts = undefined;
    self.destructible_type = undefined;
    self._id_C9DC = undefined;
    self.healthdrain = undefined;
    self.non_player_damage = undefined;
    self.player_damage = undefined;
}

set_disable_friendlyfire_value_delayed( var_0, var_1 )
{
    level notify( "set_disable_friendlyfire_value_delayed" );
    level endon( "set_disable_friendlyfire_value_delayed" );

    if ( isdefined( var_1 ) )
        wait( var_1 );

    level.friendlyfiredisabledfordestructible = var_0;
}

connecttraverses()
{
    var_0 = get_traverse_disconnect_brush();

    if ( !isdefined( var_0 ) )
        return;

    var_0 call [[ level.connectpathsfunction ]]();
    var_0.origin -= ( 0, 0, 10000 );
}

disconnecttraverses()
{
    var_0 = get_traverse_disconnect_brush();

    if ( !isdefined( var_0 ) )
        return;

    var_0.origin += ( 0, 0, 10000 );
    var_0 call [[ level.disconnectpathsfunction ]]();
    var_0.origin -= ( 0, 0, 10000 );
}

get_traverse_disconnect_brush()
{
    if ( !isdefined( self.target ) )
        return undefined;

    var_0 = getentarray( self.target, "targetname" );

    foreach ( var_2 in var_0 )
    {
        if ( isspawner( var_2 ) )
            continue;

        if ( isdefined( var_2.script_destruct_collision ) )
            continue;

        if ( var_2.code_classname == "light" )
            continue;

        if ( !var_2.spawnflags & 1 )
            continue;

        return var_2;
    }
}

hideapart( var_0 )
{
    self hidepart( var_0 );
}

showapart( var_0 )
{
    self showpart( var_0 );
}

disable_explosion()
{
    self.dontallowexplode = 1;
}

_id_B7AD( var_0 )
{
    self._id_C56B = var_0;
}

force_explosion()
{
    self.dontallowexplode = undefined;
    self.forceexploding = 1;
    self notify( "damage", 100000000, self, self.origin, self.origin, "MOD_EXPLOSIVE", "", "" );
}

get_dummy()
{
    if ( !common_scripts\utility::issp() )
        return self;

    if ( self.modeldummyon )
        var_0 = self.modeldummy;
    else
        var_0 = self;

    return var_0;
}

play_loop_sound_on_destructible( var_0, var_1 )
{
    var_2 = get_dummy();
    var_3 = spawn( "script_origin", ( 0, 0, 0 ) );

    if ( isdefined( var_1 ) )
        var_3.origin = var_2 gettagorigin( var_1 );
    else
        var_3.origin = var_2.origin;

    var_3 playloopsound( var_0 );
    var_2 thread force_stop_sound( var_0 );
    var_2 waittill( "stop sound" + var_0 );

    if ( !isdefined( var_3 ) )
        return;

    var_3 stopsounds( var_0 );
    var_3 delete();
}

force_stop_sound( var_0 )
{
    self endon( "stop sound" + var_0 );
    level waittill( "putout_fires" );
    self notify( "stop sound" + var_0 );
}

notifydamageafterframe( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( isdefined( level.notifydamageafterframe ) )
        return;

    level.notifydamageafterframe = 1;
    waittillframeend;

    if ( isdefined( self.exploded ) )
    {
        level.notifydamageafterframe = undefined;
        return;
    }

    if ( common_scripts\utility::issp() )
        var_0 /= 0.5;
    else
        var_0 /= 1.0;

    self notify( "damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6 );
    level.notifydamageafterframe = undefined;
}

play_sound( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
    {
        var_2 = spawn( "script_origin", self gettagorigin( var_1 ) );
        var_2 hide();
        var_2 linkto( self, var_1, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
    else
    {
        var_2 = spawn( "script_origin", ( 0, 0, 0 ) );
        var_2 hide();
        var_2.origin = self.origin;
        var_2.angles = self.angles;
        var_2 linkto( self );
    }

    var_2 playsound( var_0, "sounddone" );
    var_2 waittill( "sounddone" );
    wait 0.1;
    var_2 delete();
}

do_car_alarm()
{
    if ( isdefined( self.caralarm ) )
        return;

    self.caralarm = 1;

    if ( !should_do_car_alarm() )
        return;

    var_0 = [ "car_alarm_01", "car_alarm_02", "car_alarm_03", "car_alarm_04" ];
    var_1 = common_scripts\utility::random( var_0 );
    self.car_alarm_org = spawn( "script_model", self.origin );
    self.car_alarm_org hide();
    self.car_alarm_org playloopsound( var_1 );
    level.currentcaralarms++;
    thread car_alarm_timeout();
    self waittill( "stop_car_alarm" );
    level.lastcaralarmtime = gettime();
    level.currentcaralarms--;
    self.car_alarm_org stopsounds( var_1 );
    self.car_alarm_org delete();
}

car_alarm_timeout()
{
    self endon( "stop_car_alarm" );
    wait 25;

    if ( !isdefined( self ) )
        return;

    thread play_sound( "car_alarm_off" );
    self notify( "stop_car_alarm" );
}

should_do_car_alarm()
{
    if ( level.currentcaralarms >= 2 )
        return 0;

    var_0 = undefined;

    if ( !isdefined( level.lastcaralarmtime ) )
    {
        if ( common_scripts\utility::cointoss() )
            return 1;

        var_0 = gettime() - level.commonstarttime;
    }
    else
        var_0 = gettime() - level.lastcaralarmtime;

    if ( level.currentcaralarms == 0 && var_0 >= 120 )
        return 1;

    if ( randomint( 100 ) <= 33 )
        return 1;

    return 0;
}

do_random_dynamic_attachment( var_0, var_1, var_2, var_3 )
{
    var_4 = [];

    if ( common_scripts\utility::issp() )
    {
        self attach( var_1, var_0, 0 );

        if ( isdefined( var_2 ) && var_2 != "" )
            self attach( var_2, var_0, 0 );
    }
    else
    {
        var_4[0] = spawn( "script_model", self gettagorigin( var_0 ) );
        var_4[0].angles = self gettagangles( var_0 );
        var_4[0] setmodel( var_1 );
        var_4[0] linkto( self, var_0 );

        if ( isdefined( var_2 ) && var_2 != "" )
        {
            var_4[1] = spawn( "script_model", self gettagorigin( var_0 ) );
            var_4[1].angles = self gettagangles( var_0 );
            var_4[1] setmodel( var_2 );
            var_4[1] linkto( self, var_0 );
        }
    }

    if ( isdefined( var_3 ) )
    {
        var_5 = self gettagorigin( var_0 );
        var_6 = get_closest_with_targetname( var_5, var_3 );

        if ( isdefined( var_6 ) )
            var_6 delete();
    }

    self waittill( "exploded" );

    if ( common_scripts\utility::issp() )
    {
        self detach( var_1, var_0 );
        self attach( var_1 + "_destroy", var_0, 0 );

        if ( isdefined( var_2 ) && var_2 != "" )
        {
            self detach( var_2, var_0 );
            self attach( var_2 + "_destroy", var_0, 0 );
        }
    }
    else
    {
        var_4[0] setmodel( var_1 + "_destroy" );

        if ( isdefined( var_2 ) && var_2 != "" )
            var_4[1] setmodel( var_2 + "_destroy" );
    }
}

get_closest_with_targetname( var_0, var_1 )
{
    var_2 = undefined;
    var_3 = undefined;
    var_4 = getentarray( var_1, "targetname" );

    foreach ( var_6 in var_4 )
    {
        var_7 = distancesquared( var_0, var_6.origin );

        if ( !isdefined( var_2 ) || var_7 < var_2 )
        {
            var_2 = var_7;
            var_3 = var_6;
        }
    }

    return var_3;
}

player_touching_post_clip()
{
    var_0 = [];

    if ( !isdefined( self.target ) )
        return 0;

    var_1 = getentarray( self.target, "targetname" );

    foreach ( var_3 in var_1 )
    {
        if ( isdefined( var_3.script_destruct_collision ) && var_3.script_destruct_collision == "post" )
            var_0[var_0.size] = var_3;
    }

    if ( var_0.size == 0 )
        return 0;

    foreach ( var_6 in var_0 )
    {
        var_7 = get_player_touching( var_6 );

        if ( isdefined( var_7 ) )
            return 1;
    }

    return 0;
}

get_player_touching( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( !isalive( var_2 ) )
            continue;

        if ( var_0 istouching( var_2 ) )
            return var_2;
    }

    return undefined;
}

is_so()
{
    return getdvar( "specialops" ) == "1";
}

destructible_handles_collision_brushes()
{
    var_0 = getentarray( self.target, "targetname" );
    var_1 = [];
    var_1["pre"] = ::collision_brush_pre_explosion;
    var_1["post"] = ::collision_brush_post_explosion;

    foreach ( var_3 in var_0 )
    {
        if ( !isdefined( var_3.script_destruct_collision ) )
            continue;

        self thread [[ var_1[var_3.script_destruct_collision] ]]( var_3 );
    }
}

collision_brush_pre_explosion( var_0 )
{
    waittillframeend;

    if ( common_scripts\utility::issp() )
        var_0 call [[ level.disconnectpathsfunction ]]();

    self waittill( "exploded" );

    if ( common_scripts\utility::issp() )
    {
        var_0 notsolid();
        var_0 call [[ level.connectpathsfunction ]]();
    }

    var_0 delete();
}

collision_brush_post_explosion( var_0 )
{
    var_0 notsolid();

    if ( common_scripts\utility::issp() )
        var_0 call [[ level.connectpathsfunction ]]();

    self waittill( "exploded" );
    waittillframeend;

    if ( common_scripts\utility::issp() )
    {
        if ( is_so() )
        {
            var_1 = get_player_touching( var_0 );

            if ( isdefined( var_1 ) )
                self thread [[ level.func_destructible_crush_player ]]( var_1 );
        }
        else
        {

        }
    }

    var_0 solid();

    if ( common_scripts\utility::issp() )
        var_0 call [[ level.disconnectpathsfunction ]]();
}

debug_player_in_post_clip( var_0 )
{

}

_id_C3DE()
{
    var_0 = getentarray( "trigger_multiple_fire_react", "classname" );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2.targetname ) && self.target != var_2.targetname )
            var_0 = common_scripts\utility::array_remove( var_0, var_2 );
    }

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2.script_noteworthy ) )
        {
            switch ( var_2.script_noteworthy )
            {
                case "pre":
                    thread _id_BCDF( var_2 );
                    break;
                case "post":
                    thread _id_D0FC( var_2 );
                    break;
                case "fire_react_gaspump":
                    thread fire_react_gaspump( var_2 );
                    break;
                default:
                    break;
            }
        }
    }
}

_id_BCDF( var_0 )
{
    waittillframeend;

    if ( !isdefined( var_0 ) )
        return;

    self waittill( "exploded" );
    var_0 common_scripts\utility::trigger_off();
}

_id_D0FC( var_0 )
{
    waittillframeend;

    if ( !isdefined( var_0 ) )
        return;

    var_0 common_scripts\utility::trigger_off();
    self waittill( "exploded" );
    var_0 common_scripts\utility::trigger_on();
}

fire_react_gaspump( var_0 )
{
    self endon( "destroyed" );
    waittillframeend;
    var_0 common_scripts\utility::trigger_off();
    var_1 = 3;
    self waittill( "damage" );

    while ( isdefined( self.destructible_parts ) )
    {
        if ( self.destructible_parts[0].v["currentState"] >= var_1 )
        {
            var_0 common_scripts\utility::trigger_on();
            break;
        }

        waitframe();
    }

    self waittill( "exploded" );
    var_0 common_scripts\utility::trigger_off();
}

destructible_get_my_breakable_light( var_0 )
{
    var_1 = getentarray( "light_destructible", "targetname" );

    if ( common_scripts\utility::issp() )
    {
        var_2 = getentarray( "light_destructible", "script_noteworthy" );
        var_1 = common_scripts\utility::array_combine( var_1, var_2 );
    }

    if ( !var_1.size )
        return;

    var_3 = var_0 * var_0;
    var_4 = undefined;

    foreach ( var_6 in var_1 )
    {
        var_7 = distancesquared( self.origin, var_6.origin );

        if ( var_7 < var_3 )
        {
            var_4 = var_6;
            var_3 = var_7;
        }
    }

    if ( !isdefined( var_4 ) )
        return;

    self.breakable_light = var_4;
}

break_nearest_light( var_0 )
{
    if ( !isdefined( self.breakable_light ) )
        return;

    self.breakable_light setlightintensity( 0 );
}

debug_radiusdamage_circle( var_0, var_1, var_2, var_3 )
{
    var_4 = 16;
    var_5 = 360 / var_4;
    var_6 = [];

    for ( var_7 = 0; var_7 < var_4; var_7++ )
    {
        var_8 = var_5 * var_7;
        var_9 = cos( var_8 ) * var_1;
        var_10 = sin( var_8 ) * var_1;
        var_11 = var_0[0] + var_9;
        var_12 = var_0[1] + var_10;
        var_13 = var_0[2];
        var_6[var_6.size] = ( var_11, var_12, var_13 );
    }

    thread debug_circle_drawlines( var_6, 5.0, ( 1, 0, 0 ), var_0 );
    var_6 = [];

    for ( var_7 = 0; var_7 < var_4; var_7++ )
    {
        var_8 = var_5 * var_7;
        var_9 = cos( var_8 ) * var_1;
        var_10 = sin( var_8 ) * var_1;
        var_11 = var_0[0];
        var_12 = var_0[1] + var_9;
        var_13 = var_0[2] + var_10;
        var_6[var_6.size] = ( var_11, var_12, var_13 );
    }

    thread debug_circle_drawlines( var_6, 5.0, ( 1, 0, 0 ), var_0 );
    var_6 = [];

    for ( var_7 = 0; var_7 < var_4; var_7++ )
    {
        var_8 = var_5 * var_7;
        var_9 = cos( var_8 ) * var_1;
        var_10 = sin( var_8 ) * var_1;
        var_11 = var_0[0] + var_10;
        var_12 = var_0[1];
        var_13 = var_0[2] + var_9;
        var_6[var_6.size] = ( var_11, var_12, var_13 );
    }

    thread debug_circle_drawlines( var_6, 5.0, ( 1, 0, 0 ), var_0 );
}

debug_circle_drawlines( var_0, var_1, var_2, var_3 )
{
    for ( var_4 = 0; var_4 < var_0.size; var_4++ )
    {
        var_5 = var_0[var_4];

        if ( var_4 + 1 >= var_0.size )
            var_6 = var_0[0];
        else
            var_6 = var_0[var_4 + 1];

        thread debug_line( var_5, var_6, var_1, var_2 );
        thread debug_line( var_3, var_5, var_1, var_2 );
    }
}

debug_line( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_3 ) )
        var_3 = ( 1, 1, 1 );

    for ( var_4 = 0; var_4 < var_2 * 20; var_4++ )
        wait 0.05;
}

spotlight_tag_origin_cleanup( var_0 )
{
    var_0 endon( "death" );
    level waittill( "new_destructible_spotlight" );
    var_0 delete();
}

spotlight_fizzles_out( var_0, var_1, var_2, var_3, var_4 )
{
    level endon( "new_destructible_spotlight" );
    thread spotlight_tag_origin_cleanup( var_4 );
    var_5 = var_0["spotlight_brightness"];
    common_scripts\utility::noself_func( "setsaveddvar", "r_spotlightbrightness", var_5 );
    wait( randomfloatrange( 2, 5 ) );
    var_6 = randomintrange( 5, 11 );

    for ( var_7 = 0; var_7 < var_6; var_7++ )
    {
        common_scripts\utility::noself_func( "setsaveddvar", "r_spotlightbrightness", var_5 * 0.65 );
        wait 0.05;
        common_scripts\utility::noself_func( "setsaveddvar", "r_spotlightbrightness", var_5 );
        wait 0.05;
    }

    destructible_fx_think( var_0, var_1, var_2, var_3 );
    level.destructible_spotlight delete();
    var_4 delete();
}

destructible_spotlight_think( var_0, var_1, var_2, var_3 )
{
    if ( !common_scripts\utility::issp() )
        return;

    if ( !isdefined( self.breakable_light ) )
        return;

    var_1 common_scripts\utility::self_func( "startignoringspotLight" );

    foreach ( var_6, var_5 in var_0["dvars"] )
        common_scripts\utility::noself_func( "setsaveddvar", var_6, var_5 );

    if ( !isdefined( level.destructible_spotlight ) )
    {
        level.destructible_spotlight = common_scripts\utility::spawn_tag_origin();
        var_7 = common_scripts\utility::getfx( var_0["spotlight_fx"] );
        playfxontag( var_7, level.destructible_spotlight, "tag_origin" );
    }

    level notify( "new_destructible_spotlight" );
    level.destructible_spotlight unlink();
    var_8 = common_scripts\utility::spawn_tag_origin();
    var_8 linkto( self, var_0["spotlight_tag"], ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.destructible_spotlight.origin = self.breakable_light.origin;
    level.destructible_spotlight.angles = self.breakable_light.angles;
    level.destructible_spotlight thread spotlight_fizzles_out( var_0, var_1, var_2, var_3, var_8 );
    wait 0.05;

    if ( isdefined( var_8 ) )
        level.destructible_spotlight linkto( var_8 );
}

is_valid_damagetype( var_0, var_1, var_2, var_3 )
{
    var_4 = undefined;

    if ( isdefined( var_1["fx_valid_damagetype"] ) )
        var_4 = var_1["fx_valid_damagetype"][var_3][var_2];

    if ( !isdefined( var_4 ) )
        return 1;

    return issubstr( var_4, var_0 );
}

destructible_sound_think( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( self.exploded ) )
        return undefined;

    if ( !isdefined( var_0["sound"] ) )
        return undefined;

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    for ( var_4 = 0; var_4 < var_0["sound"][var_3].size; var_4++ )
    {
        var_5 = isvalidsoundcause( "soundCause", var_0, var_4, var_2, var_3 );

        if ( !var_5 )
            continue;

        var_6 = var_0["sound"][var_3][var_4];
        var_7 = var_0["tagName"];
        var_1 thread play_sound( var_6, var_7 );
    }

    return var_3;
}

destructible_fx_think( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_0["fx"] ) )
        return undefined;

    if ( !isdefined( var_4 ) )
        var_4 = randomint( var_0["fx_filename"].size );

    if ( !isdefined( var_0["fx"][var_4] ) )
        var_4 = randomint( var_0["fx_filename"].size );

    var_5 = var_0["fx_filename"][var_4].size;

    for ( var_6 = 0; var_6 < var_5; var_6++ )
    {
        if ( !is_valid_damagetype( var_2, var_0, var_6, var_4 ) )
            continue;

        var_7 = var_0["fx"][var_4][var_6];

        if ( isdefined( var_0["fx_tag"][var_4][var_6] ) )
        {
            var_8 = var_0["fx_tag"][var_4][var_6];
            self notify( "FX_State_Change" + var_3 );

            if ( var_0["fx_useTagAngles"][var_4][var_6] )
                playfxontag( var_7, var_1, var_8 );
            else
            {
                var_9 = var_1 gettagorigin( var_8 );
                var_10 = var_9 + ( 0, 0, 100 ) - var_9;
                playfx( var_7, var_9, var_10 );
            }

            continue;
        }

        var_9 = var_1.origin;
        var_10 = var_9 + ( 0, 0, 100 ) - var_9;
        playfx( var_7, var_9, var_10 );
    }

    return var_4;
}

destructible_animation_think( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( self.exploded ) )
        return undefined;

    if ( !isdefined( var_0["animation"] ) )
        return undefined;

    if ( isdefined( var_0["randomly_flip"] ) && !isdefined( self.script_noflip ) )
    {
        if ( common_scripts\utility::cointoss() )
            self.angles += ( 0, 180, 0 );
    }

    if ( isdefined( var_0["spotlight_tag"] ) )
    {
        thread destructible_spotlight_think( var_0, var_1, var_2, var_3 );
        wait 0.05;
    }

    var_4 = common_scripts\utility::random( var_0["animation"] );
    var_5 = var_4["anim"];
    var_6 = var_4["animTree"];
    var_7 = var_4["groupNum"];
    var_8 = var_4["mpAnim"];
    var_9 = var_4["maxStartDelay"];
    var_10 = var_4["animRateMin"];
    var_11 = var_4["animRateMax"];

    if ( !isdefined( var_10 ) )
        var_10 = 1.0;

    if ( !isdefined( var_11 ) )
        var_11 = 1.0;

    if ( var_10 == var_11 )
        var_12 = var_10;
    else
        var_12 = randomfloatrange( var_10, var_11 );

    var_13 = var_4["vehicle_exclude_anim"];

    if ( self.code_classname == "script_vehicle" && var_13 )
        return undefined;

    var_1 common_scripts\utility::self_func( "useanimtree", var_6 );
    var_14 = var_4["animType"];

    if ( !isdefined( self.animsapplied ) )
        self.animsapplied = [];

    self.animsapplied[self.animsapplied.size] = var_5;

    if ( isdefined( self.exploding ) )
        clear_anims( var_1 );

    if ( isdefined( var_9 ) && var_9 > 0 )
        wait( randomfloat( var_9 ) );

    if ( !common_scripts\utility::issp() )
    {
        if ( isdefined( var_8 ) )
            common_scripts\utility::self_func( "scriptModelPlayAnim", var_8 );

        return var_7;
    }

    if ( var_14 == "setanim" )
    {
        var_1 common_scripts\utility::self_func( "setanim", var_5, 1.0, 1.0, var_12 );
        return var_7;
    }

    if ( var_14 == "setanimknob" )
    {
        var_1 common_scripts\utility::self_func( "setanimknob", var_5, 1.0, 0, var_12 );
        return var_7;
    }

    return undefined;
}

clear_anims( var_0 )
{
    if ( isdefined( self.animsapplied ) )
    {
        foreach ( var_2 in self.animsapplied )
        {
            if ( common_scripts\utility::issp() )
            {
                var_0 common_scripts\utility::self_func( "clearanim", var_2, 0 );
                continue;
            }

            var_0 common_scripts\utility::self_func( "scriptModelClearAnim" );
        }
    }
}

init_destroyed_count()
{
    level.destroyedcount = 0;
    level.destroyedcounttimeout = 0.5;

    if ( common_scripts\utility::issp() )
        level.maxdestructions = 20;
    else
        level.maxdestructions = 2;
}

add_to_destroyed_count()
{
    level.destroyedcount++;
    wait( level.destroyedcounttimeout );
    level.destroyedcount--;
}

get_destroyed_count()
{
    return level.destroyedcount;
}

get_max_destroyed_count()
{
    return level.maxdestructions;
}

init_destructible_frame_queue()
{
    level.destructibleframequeue = [];
}

add_destructible_to_frame_queue( var_0, var_1, var_2 )
{
    var_3 = self getentitynumber();

    if ( !isdefined( level.destructibleframequeue[var_3] ) )
    {
        level.destructibleframequeue[var_3] = spawnstruct();
        level.destructibleframequeue[var_3].entnum = var_3;
        level.destructibleframequeue[var_3].destructible = var_0;
        level.destructibleframequeue[var_3].totaldamage = 0;
        level.destructibleframequeue[var_3].neardistance = 9999999;
        level.destructibleframequeue[var_3].fxcost = 0;
    }

    level.destructibleframequeue[var_3].fxcost += var_1.v["fxcost"];
    level.destructibleframequeue[var_3].totaldamage += var_2;

    if ( var_1.v["distance"] < level.destructibleframequeue[var_3].neardistance )
        level.destructibleframequeue[var_3].neardistance = var_1.v["distance"];

    thread handle_destructible_frame_queue();
}

handle_destructible_frame_queue()
{
    level notify( "handle_destructible_frame_queue" );
    level endon( "handle_destructible_frame_queue" );
    wait 0.05;
    var_0 = level.destructibleframequeue;
    level.destructibleframequeue = [];
    var_1 = sort_destructible_frame_queue( var_0 );

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        if ( get_destroyed_count() < get_max_destroyed_count() )
        {
            if ( var_1[var_2].fxcost )
                thread add_to_destroyed_count();

            var_1[var_2].destructible notify( "queue_processed", 1 );
            continue;
        }

        var_1[var_2].destructible notify( "queue_processed", 0 );
    }
}

sort_destructible_frame_queue( var_0 )
{
    var_1 = [];

    foreach ( var_3 in var_0 )
        var_1[var_1.size] = var_3;

    for ( var_5 = 1; var_5 < var_1.size; var_5++ )
    {
        var_6 = var_1[var_5];

        for ( var_7 = var_5 - 1; var_7 >= 0 && get_better_destructible( var_6, var_1[var_7] ) == var_6; var_7-- )
            var_1[var_7 + 1] = var_1[var_7];

        var_1[var_7 + 1] = var_6;
    }

    return var_1;
}

get_better_destructible( var_0, var_1 )
{
    if ( var_0.totaldamage > var_1.totaldamage )
        return var_0;
    else
        return var_1;
}

get_part_fx_cost_for_action_state( var_0, var_1 )
{
    var_2 = 0;

    if ( !isdefined( level.destructible_type[self._id_C9DC].parts[var_0][var_1] ) )
        return var_2;

    var_3 = level.destructible_type[self._id_C9DC].parts[var_0][var_1].v;

    if ( isdefined( var_3["fx"] ) )
    {
        foreach ( var_5 in var_3["fx_cost"] )
        {
            foreach ( var_7 in var_5 )
                var_2 += var_7;
        }
    }

    return var_2;
}

_id_ADE9( var_0 )
{
    if ( !isdefined( level._id_D4AA ) )
        return var_0;

    var_1 = level.destructible_type.size - 1;
    var_2 = level.destructible_type[var_1].v["type"];

    if ( isdefined( level._id_D4AA[var_2] ) )
    {
        if ( isdefined( level._id_D4AA[var_2][var_0] ) )
            return level._id_D4AA[var_2][var_0];
    }

    return var_0;
}

_id_BDEC( var_0, var_1, var_2 )
{
    if ( !isdefined( level._id_D4AA ) )
        level._id_D4AA = [];

    if ( !isdefined( level._id_D4AA[var_0] ) )
        level._id_D4AA[var_0] = [];

    level._id_D4AA[var_0][var_1] = var_2;
}
