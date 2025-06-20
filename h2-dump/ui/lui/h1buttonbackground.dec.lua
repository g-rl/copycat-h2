local f0_local0 = module
local f0_local1, f0_local2 = ...
f0_local0( f0_local1, package.seeall )
LUI.H1ButtonBackground = InheritFrom( LUI.UIElement )
LUI.H1ButtonBackground.AnimUpTime = 133
LUI.H1ButtonBackground.AnimOverTime = 133
LUI.H1ButtonBackground.AnimOverTimeContent = 67
LUI.H1ButtonBackground.EdgeW = 12
LUI.H1ButtonBackground.EdgeH = 12
LUI.H1ButtonBackground.EdgeU = 0.33
LUI.H1ButtonBackground.EdgeV = 0.33
LUI.H1ButtonBackground.ButtonHeight = 36
LUI.H1ButtonBackground.ScanlinesMovementTime = 12000
LUI.H1ButtonBackground.ScanlinesVerticalOffset = 3
LUI.H1ButtonBackground.GreenlineVerticalOffset = 5
LUI.H1ButtonBackground.FocusedOverlayGlowAlpha = 0.3
LUI.H1ButtonBackground.ScanlinesAlpha = 1
LUI.H1ButtonBackground.SubScanlineElements = 3
LUI.H1ButtonBackground.DisabledActionExtention = 2
LUI.H1ButtonBackground.ContourFinalAlpha = 0.8
LUI.H1ButtonBackground.ContourExtention = 2
LUI.H1ButtonBackground.ScanlinesButtonOverAnimation = function ( f1_arg0 )
	local f1_local0 = {
		{
			"default",
			0
		}
	}
	for f1_local1 = 1, LUI.H1ButtonBackground.SubScanlineElements, 1 do
		f1_local0[#f1_local0 + 1] = {
			"scroll_down_mid_" .. f1_local1,
			LUI.H1ButtonBackground.ScanlinesMovementTime
		}
	end
	f1_local0[#f1_local0 + 1] = {
		"scroll_down_bottom",
		LUI.H1ButtonBackground.ScanlinesMovementTime
	}
	f1_arg0:animateInLoop( f1_local0, false, false, false, true )
end

LUI.H1ButtonBackground.GreenlineButtonOverAnimation = function ( f2_arg0 )
	f2_arg0:animateInLoop( {
		{
			"default_scroll_pos",
			8000
		},
		{
			"scroll_down",
			400
		},
		{
			"default_scroll_pos",
			0
		},
		{
			"default_scroll_pos",
			33
		}
	} )
end

LUI.H1ButtonBackground.OverlayGlowButtonOverLoopAnimation = function ( f3_arg0 )
	f3_arg0:animateInLoop( {
		{
			"focused",
			3000
		},
		{
			"default_glow",
			3000
		}
	} )
end

LUI.H1ButtonBackground.InnerGlowButtonOverLoopAnimation = function ( f4_arg0 )
	f4_arg0:animateInLoop( {
		{
			"focused",
			15000
		},
		{
			"default",
			15000
		}
	} )
end

LUI.H1ButtonBackground.DisabledActionAnimation = function ( f5_arg0 )
	f5_arg0:animateInSequence( {
		{
			"action_extended",
			33
		},
		{
			"focused_disabled",
			66
		}
	} )
end

LUI.H1ButtonBackground.SelectionContourActionAnimation = function ( f6_arg0 )
	f6_arg0:animateInSequence( {
		{
			"action",
			67
		},
		{
			"action_scaled",
			133
		},
		{
			"default",
			33
		}
	} )
end

function scrollDownMidDone( f7_arg0, f7_arg1 )
	local f7_local0 = f7_arg0:getChildById( "subScanlines_" .. LUI.H1ButtonBackground.SubScanlineElements - f7_arg1 + 1 )
	if f7_local0 then
		f7_local0:setTopBottom( true, false, -LUI.H1ButtonBackground.ButtonHeight * f7_arg1, -LUI.H1ButtonBackground.ButtonHeight * (f7_arg1 - 1) )
	end
end

function scrollDownBottomDone( f8_arg0, f8_arg1 )
	for f8_local0 = 1, LUI.H1ButtonBackground.SubScanlineElements, 1 do
		local f8_local3 = f8_arg0:getChildById( "subScanlines_" .. f8_local0 )
		f8_local3:setTopBottom( true, false, LUI.H1ButtonBackground.ButtonHeight * f8_local0, LUI.H1ButtonBackground.ButtonHeight * (f8_local0 + 1) )
	end
	f8_arg0:setTopBottom( true, false, -LUI.H1ButtonBackground.ButtonHeight, 0 )
end

function scrollDefaultDone( f9_arg0, f9_arg1 )
	for f9_local0 = 1, LUI.H1ButtonBackground.SubScanlineElements, 1 do
		local f9_local3 = f9_arg0:getChildById( "subScanlines_" .. f9_local0 )
		f9_local3:setTopBottom( true, false, LUI.H1ButtonBackground.ButtonHeight * f9_local0, LUI.H1ButtonBackground.ButtonHeight * (f9_local0 + 1) )
	end
end

LUI.H1ButtonBackground.CreateFocusedElements = function ( f10_arg0 )
	local f10_local0 = f10_arg0:getParent()
	local f10_local1 = CoD.CreateState( 0, 0, 0, 0, CoD.AnchorTypes.All )
	f10_local1.material = RegisterMaterial( "h1_btn_reg_selected_contour" )
	f10_local1.alpha = 0
	local self = LUI.UIImage.new( f10_local1 )
	self.id = "selectionContour"
	self:setup9SliceImage( LUI.H1ButtonBackground.EdgeW, LUI.H1ButtonBackground.EdgeH, LUI.H1ButtonBackground.EdgeU, LUI.H1ButtonBackground.EdgeV )
	self:registerAnimationState( "default", f10_local1 )
	local f10_local3 = CoD.CreateState( 0, 0, 0, 0, CoD.AnchorTypes.All )
	f10_local3.material = RegisterMaterial( "h1_btn_reg_selected_contour" )
	f10_local3.alpha = LUI.H1ButtonBackground.ContourFinalAlpha
	self:registerAnimationState( "action", f10_local3 )
	local f10_local4 = CoD.CreateState( -LUI.H1ButtonBackground.ContourExtention, -LUI.H1ButtonBackground.ContourExtention, LUI.H1ButtonBackground.ContourExtention, LUI.H1ButtonBackground.ContourExtention, CoD.AnchorTypes.All )
	f10_local4.material = RegisterMaterial( "h1_btn_reg_selected_contour" )
	f10_local4.alpha = LUI.H1ButtonBackground.ContourFinalAlpha
	self:registerAnimationState( "action_scaled", f10_local4 )
	self:registerEventHandler( "button_action", LUI.H1ButtonBackground.SelectionContourActionAnimation )
	f10_local0:addElement( self )
	local f10_local5 = CoD.CreateState( 0, 0, 0, 0, CoD.AnchorTypes.All )
	f10_local5.alpha = 0
	local f10_local6 = LUI.UIElement.new( f10_local5 )
	f10_local6.id = "focusedContainer"
	f10_local6:registerAnimationState( "default", f10_local5 )
	f10_local6:registerAnimationState( "focused", {
		alpha = 1
	} )
	f10_local6:registerEventHandler( "button_over", MBh.AnimateToState( "focused", LUI.H1ButtonBackground.AnimOverTimeContent ) )
	f10_local6:registerEventHandler( "button_up", MBh.AnimateToState( "default", LUI.H1ButtonBackground.AnimUpTime ) )
	f10_local0:addElement( f10_local6 )
	local f10_local7 = LUI.UIElement.new( CoD.CreateState( 0, 0, 0, 0, CoD.AnchorTypes.All ) )
	f10_local7:setUseStencil( true )
	f10_local6:addElement( f10_local7 )
	local f10_local8 = CoD.CreateState( 0, -LUI.H1ButtonBackground.ButtonHeight, 0, 0, CoD.AnchorTypes.TopLeftRight )
	f10_local8.alpha = LUI.H1ButtonBackground.ScanlinesAlpha
	f10_local8.material = RegisterMaterial( "h1_ui_btn_focused_scanlines" )
	local f10_local9 = LUI.UIImage.new( f10_local8 )
	f10_local9.id = "scanlines"
	f10_local9:registerAnimationState( "default", f10_local8 )
	for f10_local10 = 1, LUI.H1ButtonBackground.SubScanlineElements, 1 do
		local f10_local13 = f10_local10
		local f10_local14 = LUI.H1ButtonBackground.ButtonHeight * f10_local13
		local f10_local15 = CoD.CreateState( 0, f10_local14 - LUI.H1ButtonBackground.ButtonHeight, 0, f10_local14, CoD.AnchorTypes.TopLeftRight )
		f10_local15.alpha = LUI.H1ButtonBackground.ScanlinesAlpha
		f10_local9:registerAnimationState( "scroll_down_mid_" .. f10_local13, f10_local15 )
		f10_local9:registerEventHandler( LUI.FormatAnimStateFinishStepEvent( "scroll_down_mid_" .. f10_local13 ), function ( element, event )
			scrollDownMidDone( element, f10_local13 )
		end )
		local f10_local16 = CoD.CreateState( 0, f10_local14 - LUI.H1ButtonBackground.ButtonHeight, 0, f10_local14, CoD.AnchorTypes.TopLeftRight )
		f10_local16.material = RegisterMaterial( "h1_ui_btn_focused_scanlines" )
		local f10_local17 = LUI.UIImage.new( f10_local16 )
		f10_local17.id = "subScanlines_" .. f10_local13
		f10_local17:registerAnimationState( "default", f10_local16 )
		f10_local9:addElement( f10_local17 )
	end
	local f10_local10 = LUI.H1ButtonBackground.SubScanlineElements * LUI.H1ButtonBackground.ButtonHeight
	local f10_local11 = CoD.CreateState( 0, f10_local10, 0, f10_local10 + LUI.H1ButtonBackground.ButtonHeight, CoD.AnchorTypes.TopLeftRight )
	f10_local11.alpha = LUI.H1ButtonBackground.ScanlinesAlpha
	f10_local9:registerAnimationState( "scroll_down_bottom", f10_local11 )
	f10_local9:registerEventHandler( "button_over", LUI.H1ButtonBackground.ScanlinesButtonOverAnimation )
	f10_local9:registerEventHandler( "button_up", MBh.AnimateToState( "default", 0 ) )
	f10_local9:registerEventHandler( LUI.FormatAnimStateFinishStepEvent( "scroll_down_bottom" ), scrollDownBottomDone )
	f10_local9:registerEventHandler( LUI.FormatAnimStateFinishStepEvent( "default" ), scrollDefaultDone )
	f10_local7:addElement( f10_local9 )
	local f10_local12 = CoD.CreateState( 0, 0, 0, 0, CoD.AnchorTypes.All )
	f10_local12.material = RegisterMaterial( "h1_ui_btn_focused_stroke" )
	local f10_local13 = LUI.UIImage.new( f10_local12 )
	f10_local13.id = "stroke"
	f10_local13:setup9SliceImage( LUI.H1ButtonBackground.EdgeW, LUI.H1ButtonBackground.EdgeH, LUI.H1ButtonBackground.EdgeU, LUI.H1ButtonBackground.EdgeV )
	f10_local13:registerAnimationState( "default", f10_local12 )
	f10_local6:addElement( f10_local13 )
	local f10_local14 = CoD.CreateState( 0, 0, 0, -LUI.H1ButtonBackground.GreenlineVerticalOffset, CoD.AnchorTypes.TopLeftRight )
	f10_local14.material = RegisterMaterial( "h1_btn_reg_selected_greenline" )
	local f10_local15 = LUI.UIImage.new( f10_local14 )
	f10_local15.id = "greenline"
	f10_local15:registerAnimationState( "default", f10_local14 )
	f10_local15:registerAnimationState( "default_scroll_pos", f10_local14 )
	f10_local15:registerAnimationState( "scroll_down", CoD.CreateState( 0, 0, 0, -LUI.H1ButtonBackground.GreenlineVerticalOffset, CoD.AnchorTypes.BottomLeftRight ) )
	f10_local15:registerEventHandler( "button_up", MBh.AnimateToState( "default", 0 ) )
	f10_local15:registerEventHandler( "button_over", LUI.H1ButtonBackground.GreenlineButtonOverAnimation )
	f10_local7:addElement( f10_local15 )
	local f10_local17 = CoD.CreateState( 0, 0, 0, 0, CoD.AnchorTypes.All )
	f10_local17.material = RegisterMaterial( "h1_ui_btn_focused_inner_glow" )
	f10_local17.alpha = 1
	f10_local17.scale = 0
	local f10_local18 = LUI.UIImage.new( f10_local17 )
	f10_local18.id = "innerGlow"
	f10_local18:registerAnimationState( "default", f10_local17 )
	f10_local18:registerAnimationState( "focused", {
		alpha = 0.75,
		scale = 0.55
	} )
	f10_local18:registerEventHandler( "button_up", MBh.AnimateToState( "default", 0 ) )
	f10_local18:registerEventHandler( "button_over", LUI.H1ButtonBackground.InnerGlowButtonOverLoopAnimation )
	f10_local7:addElement( f10_local18 )
	local f10_local19 = CoD.CreateState( 0, 0, 0, 0, CoD.AnchorTypes.All )
	f10_local19.material = RegisterMaterial( "h1_btn_focused_overlay_glow" )
	f10_local19.alpha = 0
	local f10_local20 = LUI.UIImage.new( f10_local19 )
	f10_local20.id = "overlayGlow"
	f10_local20:setup9SliceImage( LUI.H1ButtonBackground.EdgeW, LUI.H1ButtonBackground.EdgeH, LUI.H1ButtonBackground.EdgeU, LUI.H1ButtonBackground.EdgeV )
	f10_local20:registerAnimationState( "default", f10_local19 )
	f10_local20:registerAnimationState( "default_glow", f10_local19 )
	f10_local20:registerAnimationState( "focused", {
		alpha = LUI.H1ButtonBackground.FocusedOverlayGlowAlpha
	} )
	f10_local20:registerEventHandler( "button_up", MBh.AnimateToState( "default", 0 ) )
	f10_local20:registerEventHandler( "button_over", LUI.H1ButtonBackground.OverlayGlowButtonOverLoopAnimation )
	f10_local6:addElement( f10_local20 )
	f10_local0.hasFocusedElements = true
	return f10_local6, f10_local7
end

LUI.H1ButtonBackground.ReceivedFocus = function ( f12_arg0 )
	if f12_arg0.hasFocus then
		return 
	end
	f12_arg0.hasFocus = true
	f12_arg0:animateToState( "focused", LUI.H1ButtonBackground.AnimOverTime )
	if f12_arg0.lostFocusTimer then
		LUI.UITimer.Stop( f12_arg0.lostFocusTimer )
		f12_arg0.lostFocusTimer:close()
		f12_arg0.lostFocusTimer = nil
		local f12_local0 = f12_arg0:getParent()
		if f12_local0.hasFocusedElements then
			return 
		end
	end
	local f12_local0, f12_local1 = LUI.H1ButtonBackground.CreateFocusedElements( f12_arg0 )
	f12_local0:processEvent( {
		name = "button_over",
		dispatchChildren = true
	} )
	f12_local1:processEvent( {
		name = "button_over",
		dispatchChildren = true
	} )
end

LUI.H1ButtonBackground.CreateFocusedLockedElements = function ( f13_arg0 )
	local f13_local0 = CoD.CreateState( 0, 0, 0, 0, CoD.AnchorTypes.All )
	f13_local0.alpha = 0
	local self = LUI.UIElement.new( f13_local0 )
	self:setUseStencil( true )
	self.id = "focusedLockedContainer"
	local f13_local2 = CoD.CreateState( 0, 0, 0, 0, CoD.AnchorTypes.All )
	f13_local2.alpha = 1
	self:registerAnimationState( "default", f13_local0 )
	self:registerAnimationState( "focused", f13_local2 )
	self:registerEventHandler( "button_disable", MBh.AnimateToState( "default", LUI.H1ButtonBackground.AnimUpTime ) )
	self:registerEventHandler( "button_over_disable", MBh.AnimateToState( "focused", LUI.H1ButtonBackground.AnimOverTime ) )
	f13_arg0:addElement( self )
	local f13_local3 = f13_arg0:getParent()
	f13_local3.hasFocusLockedElement = true
	return self
end

LUI.H1ButtonBackground.ReceivedFocusLocked = function ( f14_arg0 )
	if f14_arg0.hasFocus then
		return 
	else
		f14_arg0.hasFocus = true
		f14_arg0.everHadFocus = true
		f14_arg0:animateToState( "focused_disabled", LUI.H1ButtonBackground.AnimOverTime )
		if f14_arg0.lostFocusTimer then
			LUI.UITimer.Stop( f14_arg0.lostFocusTimer )
			f14_arg0.lostFocusTimer:close()
			f14_arg0.lostFocusTimer = nil
			return 
		else
			local f14_local0 = f14_arg0:getParent()
			if f14_local0.hasFocusLockedElement then
				return 
			else
				f14_local0 = LUI.H1ButtonBackground.CreateFocusedLockedElements( f14_arg0 )
				f14_local0:processEvent( {
					name = "button_over_disable",
					dispatchChildren = true
				} )
			end
		end
	end
end

LUI.H1ButtonBackground.LostFocusLocked = function ( f15_arg0 )
	if not f15_arg0.hasFocus and f15_arg0.everHadFocus then
		return 
	end
	local f15_local0 = f15_arg0:getParent()
	if f15_local0.hasFocusLockedElement then
		f15_arg0.hasFocus = false
		if not f15_arg0.lostFocusTimer then
			f15_arg0.lostFocusTimer = LUI.UITimer.new( LUI.H1ButtonBackground.AnimUpTime, "lost_focus_done", nil, true )
			f15_arg0:addElement( f15_arg0.lostFocusTimer )
		else
			LUI.UITimer.Reset( f15_arg0.lostFocusTimer )
		end
		LUI.H1ButtonBackground.AnimateToDisable( f15_arg0 )
	end
end

LUI.H1ButtonBackground.ClearFocusedContainers = function ( f16_arg0 )
	local f16_local0 = f16_arg0:getParent()
	if f16_local0 ~= nil then
		local f16_local1 = f16_local0:getChildById( "selectionContour" )
		if f16_local1 then
			f16_local1:close()
		end
		local f16_local2 = f16_local0:getChildById( "focusedContainer" )
		if f16_local2 then
			f16_local2:close()
		end
		f16_local0.hasFocusLockedElement = false
		f16_local0.hasFocusedElements = false
	end
	f16_arg0:closeChildren()
	collectgarbage( "collect" )
end

LUI.H1ButtonBackground.LostFocusDone = function ( f17_arg0 )
	if f17_arg0.lostFocusTimer then
		LUI.UITimer.Stop( f17_arg0.lostFocusTimer )
		f17_arg0.lostFocusTimer:close()
		f17_arg0.lostFocusTimer = nil
	end
	LUI.H1ButtonBackground.ClearFocusedContainers( f17_arg0 )
end

LUI.H1ButtonBackground.LostFocus = function ( f18_arg0 )
	if not f18_arg0.hasFocus then
		return 
	end
	f18_arg0.hasFocus = false
	if not f18_arg0.lostFocusTimer then
		f18_arg0.lostFocusTimer = LUI.UITimer.new( LUI.H1ButtonBackground.AnimUpTime, "lost_focus_done", nil, true )
		f18_arg0:addElement( f18_arg0.lostFocusTimer )
	else
		LUI.UITimer.Reset( f18_arg0.lostFocusTimer )
	end
	LUI.H1ButtonBackground.AnimateToEnable( f18_arg0 )
end

LUI.H1ButtonBackground.AnimateToEnable = function ( f19_arg0 )
	if f19_arg0.hasFocus then
		LUI.H1ButtonBackground.ClearFocusedContainers( f19_arg0 )
		f19_arg0:animateToState( "focused", LUI.H1ButtonBackground.AnimOverTime )
		local f19_local0, f19_local1 = LUI.H1ButtonBackground.CreateFocusedElements( f19_arg0 )
		f19_local0:processEvent( {
			name = "button_over",
			dispatchChildren = true
		} )
		f19_local1:processEvent( {
			name = "button_over",
			dispatchChildren = true
		} )
	else
		f19_arg0:animateToState( "default", LUI.H1ButtonBackground.AnimUpTime )
		f19_arg0.material = RegisterMaterial( "h1_ui_btn_unfocused" )
	end
end

LUI.H1ButtonBackground.AnimateToDisable = function ( f20_arg0 )
	if f20_arg0.hasFocus then
		LUI.H1ButtonBackground.ClearFocusedContainers( f20_arg0 )
		f20_arg0:animateToState( "focused_disabled", LUI.H1ButtonBackground.AnimOverTime )
		local f20_local0 = LUI.H1ButtonBackground.CreateFocusedLockedElements( f20_arg0 )
		f20_local0:processEvent( {
			name = "button_over_disable",
			dispatchChildren = true
		} )
	else
		f20_arg0:animateToState( "default_disabled", LUI.H1ButtonBackground.AnimUpTime )
		f20_arg0.material = RegisterMaterial( "h1_btn_locked_unfocused" )
	end
end

LUI.H1ButtonBackground.ClearRarityElements = function ( f21_arg0 )
	if f21_arg0.glow and f21_arg0.leftStrip and f21_arg0.topRightCorner then
		f21_arg0:removeElement( f21_arg0.glow )
		f21_arg0:removeElement( f21_arg0.leftStrip )
		f21_arg0:removeElement( f21_arg0.topRightCorner )
	end
end

LUI.H1ButtonBackground.new = function ( f22_arg0 )
	local self = LUI.UIElement.new( CoD.CreateState( 0, 0, 0, 0, CoD.AnchorTypes.All ) )
	self.id = "buttonContainer"
	self:setClass( LUI.H1ButtonBackground )
	local f22_local1 = CoD.CreateState( 0, 0, 0, 0, CoD.AnchorTypes.All )
	f22_local1.material = RegisterMaterial( "h1_ui_btn_unfocused" )
	local f22_local2 = LUI.UIImage.new( f22_local1 )
	f22_local2.id = "fill"
	f22_local2.UITimer = nil
	f22_local2.hasFocus = false
	f22_local2.everHadFocus = false
	f22_local2:setup9SliceImage( LUI.H1ButtonBackground.EdgeW, LUI.H1ButtonBackground.EdgeH, LUI.H1ButtonBackground.EdgeU, LUI.H1ButtonBackground.EdgeV )
	f22_local2:registerAnimationState( "default", f22_local1 )
	f22_local2:registerAnimationState( "focused", {
		material = RegisterMaterial( "h1_ui_btn_focused_fill" )
	} )
	f22_local2:registerAnimationState( "default_disabled", {
		material = RegisterMaterial( "h1_btn_locked_unfocused" )
	} )
	local f22_local3 = CoD.CreateState( 0, 0, 0, 0, CoD.AnchorTypes.All )
	f22_local3.material = RegisterMaterial( "h1_btn_locked_overlay" )
	f22_local2:registerAnimationState( "focused_disabled", f22_local3 )
	f22_local2:registerAnimationState( "action_extended", CoD.CreateState( -LUI.H1ButtonBackground.DisabledActionExtention, -LUI.H1ButtonBackground.DisabledActionExtention, LUI.H1ButtonBackground.DisabledActionExtention, LUI.H1ButtonBackground.DisabledActionExtention, CoD.AnchorTypes.All ) )
	f22_local2:registerEventHandler( "button_up", LUI.H1ButtonBackground.LostFocus )
	f22_local2:registerEventHandler( "button_over", LUI.H1ButtonBackground.ReceivedFocus )
	f22_local2:registerEventHandler( "button_disable", LUI.H1ButtonBackground.LostFocusLocked )
	f22_local2:registerEventHandler( "button_over_disable", LUI.H1ButtonBackground.ReceivedFocusLocked )
	f22_local2:registerEventHandler( "button_action_disable", LUI.H1ButtonBackground.DisabledActionAnimation )
	f22_local2:registerEventHandler( "lost_focus_done", LUI.H1ButtonBackground.LostFocusDone )
	f22_local2:registerEventHandler( "enable", LUI.H1ButtonBackground.AnimateToEnable )
	f22_local2:registerEventHandler( "disable", LUI.H1ButtonBackground.AnimateToDisable )
	self:addElement( f22_local2 )
	if f22_arg0 ~= nil and f22_arg0.strip ~= nil and f22_arg0.glow ~= nil and f22_arg0.corner ~= nil and f22_arg0.rarity > 0 then
		local f22_local4 = CoD.CreateState( 0, 0, nil, 0, CoD.AnchorTypes.TopBottomLeft )
		f22_local4.width = 8
		f22_local4.material = f22_arg0.strip
		
		local leftStrip = LUI.UIImage.new( f22_local4 )
		self:addElement( leftStrip )
		self.leftStrip = leftStrip
		
		local f22_local6 = CoD.CreateState( 0, 0, 0, 0, CoD.AnchorTypes.All )
		f22_local6.material = f22_arg0.glow
		
		local glow = LUI.UIImage.new( f22_local6 )
		self:addElement( glow )
		self.glow = glow
		
		local f22_local8 = CoD.CreateState( nil, 2, -2, nil, CoD.AnchorTypes.TopRight )
		f22_local8.width = 16
		f22_local8.height = 16
		f22_local8.material = f22_arg0.corner
		f22_local8.alpha = 0
		local f22_local9 = LUI.UIImage.new( f22_local8 )
		f22_local9:registerAnimationState( "focused", {
			alpha = 1
		} )
		f22_local9:registerEventHandler( "button_up", MBh.AnimateToState( "default" ) )
		f22_local9:registerEventHandler( "button_over", MBh.AnimateToState( "focused" ) )
		f22_local9:registerEventHandler( "button_disable", MBh.AnimateToState( "default" ) )
		f22_local9:registerEventHandler( "button_over_disable", MBh.AnimateToState( "focused" ) )
		self:addElement( f22_local9 )
		self.topRightCorner = f22_local9
	end
	return self
end

LockTable( _M )
