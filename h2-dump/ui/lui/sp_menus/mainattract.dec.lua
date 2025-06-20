local f0_local0 = module
local f0_local1, f0_local2 = ...
f0_local0( f0_local1, package.seeall )
CoD.PrintModuleLoad( _NAME )
f0_local0 = function ( f1_arg0, f1_arg1 )
	LUI.FlowManager.RequestAddMenu( f1_arg0, "main_lockout", false, f1_arg1.controller, true )
end

f0_local1 = function ( f2_arg0, f2_arg1 )
	if Engine.IsVideoFinished() then
		f0_local0( f2_arg0, f2_arg1 )
	end
end

LUI.MenuBuilder.registerType( "main_attract", function ()
	local self = LUI.UIElement.new( {
		leftAnchor = true,
		rightAnchor = false,
		topAnchor = true,
		bottomAnchor = false,
		top = 0,
		bottom = 720,
		left = 0,
		right = 1280,
		alpha = 1
	} )
	PersistentBackground.ChangeBackground( nil, CoD.Background.Attract, false )
	local f3_local1 = LUI.UIBindButton.new()
	f3_local1.id = "AttractBindButton"
	f3_local1.handlePrimary = true
	f3_local1:registerAnyKeyEventHandler( f0_local0 )
	self:addElement( f3_local1 )
	local f3_local2 = LUI.UITimer.new( 300, "cinematic_update", nil, false )
	f3_local2.id = "cinematic_update_timer"
	self:addElement( f3_local2 )
	self:registerEventHandler( "cinematic_update", f0_local1 )
	if Engine.IsPC() then
		self:setHandleMouseButton( true )
		self:registerEventHandler( "leftmousedown", f0_local0 )
		self:registerEventHandler( "rightmousedown", f0_local0 )
	end
	return self
end )
LockTable( _M )
