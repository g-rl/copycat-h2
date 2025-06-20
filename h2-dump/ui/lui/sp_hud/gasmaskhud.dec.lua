local f0_local0 = module
local f0_local1, f0_local2 = ...
f0_local0( f0_local1, package.seeall )
CoD.PrintModuleLoad( _NAME )
f0_local0 = function ( f1_arg0, f1_arg1 )
	local f1_local0 = f1_arg0:getFirstDescendentById( "gasmaskVisorId" )
	local f1_local1 = f1_arg0:getFirstDescendentById( "gasmaskDistortId" )
	if f1_arg1.value then
		f1_local0:animateToState( "cracks", 0 )
		f1_local1:animateToState( "cracks", 0 )
	else
		f1_local0:animateToState( "clean", 0 )
		f1_local1:animateToState( "clean", 0 )
	end
end

LUI.MenuBuilder.registerType( "gasmaskHudDef", function ()
	local self = LUI.UIElement.new( Engine.IsConsoleGame() and {
		leftAnchor = false,
		rightAnchor = false,
		topAnchor = false,
		bottomAnchor = false,
		left = -360 * Engine.GetAspectRatio(),
		right = 360 * Engine.GetAspectRatio(),
		top = -360,
		bottom = 360
	} or {
		leftAnchor = true,
		rightAnchor = true,
		topAnchor = true,
		bottomAnchor = true,
		left = 0,
		right = 0,
		top = 0,
		bottom = 0
	} )
	self:registerAnimationState( "off", {
		alpha = 0
	} )
	self:registerAnimationState( "on", {
		alpha = 1
	} )
	self.id = "gasmaskRootId"
	local f2_local1 = LUI.UIImage.new( {
		leftAnchor = true,
		rightAnchor = true,
		topAnchor = true,
		bottomAnchor = true,
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
		material = RegisterMaterial( "h1_gasmask_overlay" )
	} )
	f2_local1.id = "gasmaskVisorId"
	self:addElement( f2_local1 )
	local f2_local2 = LUI.UIImage.new( {
		leftAnchor = true,
		rightAnchor = true,
		topAnchor = true,
		bottomAnchor = true,
		left = 0,
		right = 0,
		top = 0,
		bottom = 0
	} )
	f2_local2.id = "gasmaskDistortId"
	self:addElement( f2_local2 )
	local f2_local3 = LUI.UIImage.new( {
		leftAnchor = true,
		rightAnchor = true,
		topAnchor = true,
		bottomAnchor = true,
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
		material = RegisterMaterial( "h1_gasmask_blur" )
	} )
	f2_local3.id = "gasmaskBlurId"
	self:addElement( f2_local3 )
	local f2_local4 = function ( f3_arg0 )
		f3_arg0:registerAnimationState( "current", {
			material = RegisterMaterial( CoD.IsUsingAspectRatio( 1.33 ) and "h1_gasmask_distort_4x3" or "h1_gasmask_distort" )
		} )
		f3_arg0:animateToState( "current" )
	end
	
	f2_local2:registerEventHandler( "toggle_pause_off", f2_local4 )
	f2_local4( f2_local2 )
	return self
end )
LockTable( _M )
