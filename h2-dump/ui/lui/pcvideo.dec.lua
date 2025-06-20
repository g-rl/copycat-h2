local f0_local0 = module
local f0_local1, f0_local2 = ...
f0_local0( f0_local1, package.seeall )
CoD.PrintModuleLoad( _NAME )
LUI.PCVideo = {}
function GetFOV( f1_arg0 )
	return (Engine.GetProfileData( "preferedFov", f1_arg0 ) - SliderBounds.FOV.Min) / (SliderBounds.FOV.Max - SliderBounds.FOV.Min)
end

function FOVLess( f2_arg0 )
	Engine.SetProfileData( "preferedFov", math.min( SliderBounds.FOV.Max, math.max( SliderBounds.FOV.Min, Engine.GetProfileData( "preferedFov", f2_arg0 ) - SliderBounds.FOV.Step ) ), f2_arg0 )
end

function FOVMore( f3_arg0 )
	Engine.SetProfileData( "preferedFov", math.min( SliderBounds.FOV.Max, math.max( SliderBounds.FOV.Min, Engine.GetProfileData( "preferedFov", f3_arg0 ) + SliderBounds.FOV.Step ) ), f3_arg0 )
end

function OpenShaderCacheDialog( f4_arg0, f4_arg1 )
	LUI.FlowManager.RequestAddMenu( f4_arg0, "ShaderCacheChoiceDialog" )
end

function CreateOptions( f5_arg0 )
	local f5_local0 = {
		{
			text = "@LUA_MENU_MODE_FULLSCREEN",
			value = "fullscreen"
		},
		{
			text = "@LUA_MENU_MODE_WINDOWED_NO_BORDER",
			value = "windowed_no_border"
		},
		{
			text = "@LUA_MENU_MODE_WINDOWED",
			value = "windowed"
		}
	}
	local f5_local1 = {
		{
			text = "@LUA_MENU_MODE_FULLSCREEN",
			value = "fullscreen"
		},
		{
			text = "@LUA_MENU_MODE_WINDOWED",
			value = "windowed"
		}
	}
	local f5_local2 = LUI.Options.CreateDVarVideoOptionHelper
	local f5_local3 = f5_arg0
	local f5_local4 = "ui_r_displayMode"
	local f5_local5 = "@LUA_MENU_DISPLAY_MODE"
	if Engine.IsPCApp() then
		local f5_local6 = f5_local1
	end
	f5_local2( f5_local3, f5_local4, f5_local5, f5_local6 or f5_local0, {
		button_desc = "@LUA_MENU_DISPLAY_MODE_DESC"
	} )
	if not Engine.IsPCApp() then
		LUI.Options.CreateDVarVideoOptionHelper( f5_arg0, "ui_r_monitor", "@PLATFORM_UI_MONITOR", function ()
			local f6_local0 = LUI.Options.StringOptionListFromList( Engine.GetMonitorList() )
			for f6_local1 = 1, #f6_local0, 1 do
				f6_local0[f6_local1].text = Engine.MarkLocalized( f6_local0[f6_local1].text )
			end
			return f6_local0
		end, {
			button_desc = "@PLATFORM_UI_MONITOR_DESC",
			disabledFunc = function ()
				return Engine.GetDvarBool( "r_fullscreen" ) == false
			end
		} )
		LUI.Options.CreateDVarVideoOptionHelper( f5_arg0, "ui_r_refreshRate", "@MENU_SCREEN_REFRESH_RATE", function ()
			local f8_local0 = LUI.Options.StringOptionListFromList( Engine.GetRefreshRateList() )
			for f8_local1 = 1, #f8_local0, 1 do
				f8_local0[f8_local1].text = Engine.MarkLocalized( f8_local0[f8_local1].text )
			end
			return f8_local0
		end, {
			button_desc = "@PLATFORM_SCREEN_REFRESH_RATE_DESCRIPTION",
			disabledFunc = function ()
				local f9_local0
				if Engine.GetDvarBool( "r_fullscreen" ) ~= false and Engine.GetDvarBool( "r_fullscreenWindow" ) ~= true then
					f9_local0 = false
				else
					f9_local0 = true
				end
				return f9_local0
			end
		} )
	end
	f5_local2 = {
		{
			width = 800,
			height = 600,
			aspect = "4:3"
		},
		{
			width = 1024,
			height = 768,
			aspect = "4:3"
		},
		{
			width = 1280,
			height = 960,
			aspect = "4:3"
		},
		{
			width = 1440,
			height = 1080,
			aspect = "4:3"
		},
		{
			width = 1600,
			height = 1200,
			aspect = "4:3"
		},
		{
			width = 2048,
			height = 1536,
			aspect = "4:3"
		},
		{
			width = 1024,
			height = 576,
			aspect = "16:9"
		},
		{
			width = 1365,
			height = 768,
			aspect = "16:9"
		},
		{
			width = 1600,
			height = 900,
			aspect = "16:9"
		},
		{
			width = 1920,
			height = 1080,
			aspect = "16:9"
		},
		{
			width = 2560,
			height = 1440,
			aspect = "16:9"
		},
		{
			width = 3840,
			height = 2160,
			aspect = "16:9"
		},
		{
			width = 1280,
			height = 540,
			aspect = "21:9"
		},
		{
			width = 1920,
			height = 810,
			aspect = "21:9"
		},
		{
			width = 2560,
			height = 1080,
			aspect = "21:9"
		},
		{
			width = 3840,
			height = 1620,
			aspect = "21:9"
		}
	}
	f5_local3 = function ( f10_arg0, f10_arg1 )
		local f10_local0 = 1
		while f5_local2[f10_local0] do
			if f5_local2[f10_local0].width == f10_arg0 and f5_local2[f10_local0].height == f10_arg1 then
				return f10_local0
			end
			f10_local0 = f10_local0 + 1
		end
		return 0
	end
	
	f5_local4 = function ()
		local f11_local0 = nil
		local f11_local1 = Engine.GetDisplayWidth()
		local f11_local2 = Engine.GetDisplayHeight()
		if Engine.GetDvarBool( "r_fullscreen" ) == true and Engine.GetDvarBool( "r_fullscreenWindow" ) == false then
			f11_local0 = LUI.Options.StringOptionListFromList( Engine.GetModeList() )
		elseif Engine.GetDvarBool( "r_fullscreen" ) == true and Engine.GetDvarBool( "r_fullscreenWindow" ) == true then
			f11_local0 = {
				{
					text = f11_local1 .. "x" .. f11_local2,
					value = ""
				}
			}
		else
			f11_local0 = {}
			if f5_local3( f11_local1, f11_local2 ) == 0 then
				f11_local0[1] = {
					text = f11_local1 .. "x" .. f11_local2,
					value = f11_local1 .. " " .. f11_local2
				}
			end
			for f11_local6, f11_local7 in pairs( f5_local2 ) do
				f11_local0[#f11_local0 + 1] = {
					text = f11_local7.width .. "x" .. f11_local7.height .. " (" .. f11_local7.aspect .. ")",
					value = f11_local7.width .. " " .. f11_local7.height
				}
			end
		end
		for f11_local3 = 1, #f11_local0, 1 do
			f11_local0[f11_local3].text = Engine.MarkLocalized( f11_local0[f11_local3].text )
		end
		return f11_local0
	end
	
	if not Engine.IsPCApp() then
		LUI.Options.CreateDVarVideoOptionHelper( f5_arg0, "ui_r_mode", "@LUA_MENU_VIDEO_MODE", f5_local4, {
			button_desc = "@LUA_MENU_VIDEO_MODE_DESC",
			disabledFunc = function ()
				local f12_local0 = Engine.GetDvarBool( "r_fullscreen" )
				if f12_local0 then
					f12_local0 = Engine.IsPCApp()
					if not f12_local0 then
						f12_local0 = Engine.GetDvarBool( "r_fullscreenWindow" )
					end
				end
				return f12_local0
			end
		} )
	end
	if not Engine.IsPCApp() then
		LUI.Options.CreateDVarVideoOptionHelper( f5_arg0, "ui_r_letterboxAspectRatio", "@PLATFORM_FORCED_ASPECT_RATIO", {
			{
				text = "@MENU_AUTO",
				value = "auto"
			},
			{
				text = "@MENU_STANDARD_4_3",
				value = "standard"
			},
			{
				text = "@MENU_WIDE_16_10",
				value = "wide 16:10"
			},
			{
				text = "@MENU_WIDE_16_9",
				value = "wide 16:9"
			},
			{
				text = "@MENU_WIDE_21_9",
				value = "wide 21:9"
			}
		}, {
			button_desc = "@PLATFORM_FORCED_ASPECT_RATIO_DESC"
		} )
	end
	LUI.Options.AddButtonOptionVariant( f5_arg0, GenericButtonSettings.Variants.Slider, "@PLATFORM_FOV", "@PLATFORM_FOV_OPTION_SUB", GetFOV, FOVLess, FOVMore )
	if Engine.IsMultiplayer() then
		if Engine.ShaderUploadFrontendSystemIsAvailable() then
			LUI.Options.CreateOptionButton( f5_arg0, "ui_r_preloadShadersFrontendAllow", "@PLATFORM_SHADER_PRECACHE_BUTTON", "@PLATFORM_SHADER_PRECACHE_BUTTON_DESC", {
				{
					text = "@LUA_MENU_DISABLED",
					value = "false"
				},
				{
					text = "@LUA_MENU_ENABLED",
					value = "true"
				}
			}, nil, nil, function ()
				LUI.Options.RefreshVideoSetting()
				f5_arg0:RefreshButtonDisabled()
			end )
		end
		if Engine.ShaderUploadFrontendOptionsAreAvailable() then
			LUI.Options.AddButtonOptionVariant( f5_arg0, GenericButtonSettings.Variants.Common, "@PLATFORM_SHADER_POPULATE_CACHE_BUTTON", "@PLATFORM_SHADER_POPULATE_CACHE_BUTTON_DESC", nil, nil, nil, OpenShaderCacheDialog, nil, nil, function ()
				return not Engine.GetDvarBool( "r_preloadShadersFrontendAllow" )
			end )
		end
	end
	LUI.Options.InitScrollingList( f5_arg0.list, nil )
end

function RefreshFunc( f15_arg0 )
	return function ( f16_arg0, f16_arg1 )
		LUI.PCOptions.TransferSettingsToUI()
		f15_arg0.list:processEvent( {
			name = "content_refresh",
			dispatchChildren = true
		} )
	end
	
end

LUI.PCVideo.new = function ( f17_arg0, f17_arg1 )
	LUI.PCOptions.TransferSettingsToUI()
	Engine.ExecNow( "profile_menuDvarsSetup" )
	local f17_local0 = Engine.IsMultiplayer() and 0 or LUI.MenuTemplate.spMenuOffset
	local f17_local1 = LUI.MenuTemplate.new( f17_arg0, {
		menu_title = Engine.ToUpperCase( Engine.Localize( "@LUA_MENU_GRAPHIC_OPTIONS" ) ),
		menu_top_indent = f17_local0 + LUI.H1MenuTab.tabChangeHoldingElementHeight + H1MenuDims.spacing,
		menu_list_divider_top_offset = -(LUI.H1MenuTab.tabChangeHoldingElementHeight + H1MenuDims.spacing),
		menu_width = GenericMenuDims.OptionMenuWidth,
		genericListAction = function ( f18_arg0, f18_arg1 )
			LUI.Options.CloseSelectionMenu( f18_arg1.menu )
		end,
		skipAnim = LUI.PCGraphicOptions.FindTypeIndex( LUI.PreviousMenuName ) ~= 0
	} )
	f17_local1:addElement( LUI.H1MenuTab.new( {
		title = function ( f19_arg0 )
			return LUI.PCGraphicOptions.Categories[f19_arg0].title
		end,
		tabCount = #LUI.PCGraphicOptions.Categories,
		underTabTextFunc = function ( f20_arg0 )
			return LUI.PCGraphicOptions.Categories[f20_arg0].title
		end,
		top = f17_local0 + LUI.MenuTemplate.ListTop,
		width = GenericMenuDims.OptionMenuWidth,
		clickTabBtnAction = LUI.PCGraphicOptions.LoadMenu,
		activeIndex = LUI.PCGraphicOptions.FindTypeIndex( "pc_video" ),
		skipChangeTab = true,
		exclusiveController = f17_local1.exclusiveController
	} ) )
	if Engine.GetProfileData( "preferedFov", f17_local1.exclusiveController ) > SliderBounds.FOV.Max then
		Engine.SetProfileData( "preferedFov", SliderBounds.FOV.Min, f17_local1.exclusiveController )
	end
	f17_local1:registerEventHandler( "onVideoChange", RefreshFunc( f17_local1 ) )
	CreateOptions( f17_local1 )
	LUI.PCControlOptions.AddOptimalVideoButton( f17_local1 )
	LUI.Options.AddOptionTextInfo( f17_local1 )
	f17_local1:AddBackButtonWithSelector()
	return f17_local1
end

LUI.MenuBuilder.registerType( "pc_video", LUI.PCVideo.new )
LockTable( _M )
