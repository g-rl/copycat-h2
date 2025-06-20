local f0_local0 = module
local f0_local1, f0_local2 = ...
f0_local0( f0_local1, package.seeall )
CoD.PrintModuleLoad( "Registering " .. _NAME )
LUI.ButtonDescText = {}
LUI.ButtonDescText.Font = CoD.TextSettings.Font21
LUI.ButtonDescText.new = function ( f1_arg0, f1_arg1 )
	if not f1_arg1 then
		f1_arg1 = {}
	end
	local self = f1_arg1.font
	if not self then
		self = LUI.ButtonDescText.Font
	end
	f1_arg1.font = self
	self = f1_arg1.red
	if not self then
		self = GenericMenuColors.text_highlight.r
	end
	f1_arg1.red = self
	self = f1_arg1.green
	if not self then
		self = GenericMenuColors.text_highlight.g
	end
	f1_arg1.green = self
	self = f1_arg1.blue
	if not self then
		self = GenericMenuColors.text_highlight.b
	end
	f1_arg1.blue = self
	f1_arg1.margin = f1_arg1.margin or 0
	self = LUI.UIElement.new()
	self.id = "generic_button_desc_text_id"
	self:registerAnimationState( "default", {
		leftAnchor = true,
		rightAnchor = true,
		topAnchor = true,
		bottomAnchor = false,
		left = 0,
		right = 0,
		top = 0,
		bottom = f1_arg1.font.Height
	} )
	self:animateToState( "default" )
	local f1_local1 = LUI.UIText.new()
	f1_local1.id = "desc_text"
	f1_local1:registerAnimationState( "default", {
		alignment = LUI.AdjustAlignmentForLanguage( LUI.Alignment.Left ),
		font = f1_arg1.font.Font,
		topAnchor = true,
		bottomAnchor = true,
		leftAnchor = true,
		rightAnchor = true,
		top = 0,
		bottom = 0,
		left = f1_arg1.margin,
		right = -f1_arg1.margin,
		red = f1_arg1.red,
		green = f1_arg1.green,
		blue = f1_arg1.blue,
		alpha = 1
	} )
	f1_local1:animateToState( "default" )
	f1_local1:registerEventHandler( "set_button_info_text", function ( element, event )
		if event.text then
			element:setText( event.text )
		end
	end )
	self:addElement( f1_local1 )
	return self
end

LUI.ButtonDescText.build = function ( f3_arg0, f3_arg1, f3_arg2 )
	return LUI.ButtonDescText.new( f3_arg0, f3_arg1 )
end

LUI.MenuBuilder.registerType( "button_desc_text", LUI.ButtonDescText.build )
LockTable( _M )
