///////////////////////////////////////////////////////////////////////////
/// Styles
///////////////////////////////////////////////////////////////////////////

// Control types
#define CT_STATIC           0
#define CT_BUTTON           1
#define CT_EDIT             2
#define CT_SLIDER           3
#define CT_COMBO            4
#define CT_LISTBOX          5
#define CT_TOOLBOX          6
#define CT_CHECKBOXES       7
#define CT_PROGRESS         8
#define CT_HTML             9
#define CT_STATIC_SKEW      10
#define CT_ACTIVETEXT       11
#define CT_TREE             12
#define CT_STRUCTURED_TEXT  13
#define CT_CONTEXT_MENU     14
#define CT_CONTROLS_GROUP   15
#define CT_SHORTCUTBUTTON   16
#define CT_XKEYDESC         40
#define CT_XBUTTON          41
#define CT_XLISTBOX         42
#define CT_XSLIDER          43
#define CT_XCOMBO           44
#define CT_ANIMATED_TEXTURE 45
#define CT_OBJECT           80
#define CT_OBJECT_ZOOM      81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK        98
#define CT_USER             99
#define CT_MAP              100
#define CT_MAP_MAIN         101
#define CT_LISTNBOX         102
#define CT_CHECKBOX         77

// Static styles
#define ST_POS            0x0F
#define ST_HPOS           0x03
#define ST_VPOS           0x0C
#define ST_LEFT           0x00
#define ST_RIGHT          0x01
#define ST_CENTER         0x02
#define ST_DOWN           0x04
#define ST_UP             0x08
#define ST_VCENTER        0x0C

#define ST_TYPE           0xF0
#define ST_SINGLE         0x00
#define ST_MULTI          0x10
#define ST_TITLE_BAR      0x20
#define ST_PICTURE        0x30
#define ST_FRAME          0x40
#define ST_BACKGROUND     0x50
#define ST_GROUP_BOX      0x60
#define ST_GROUP_BOX2     0x70
#define ST_HUD_BACKGROUND 0x80
#define ST_TILE_PICTURE   0x90
#define ST_WITH_RECT      0xA0
#define ST_LINE           0xB0

#define ST_SHADOW         0x100
#define ST_NO_RECT        0x200
#define ST_KEEP_ASPECT_RATIO  0x800

#define ST_TITLE          ST_TITLE_BAR + ST_CENTER

// Slider styles
#define SL_DIR            0x400
#define SL_VERT           0
#define SL_HORZ           0x400

#define SL_TEXTURES       0x10

// progress bar
#define ST_VERTICAL       0x01
#define ST_HORIZONTAL     0

// Listbox styles
#define LB_TEXTURES       0x10
#define LB_MULTI          0x20

// Tree styles
#define TR_SHOWROOT       1
#define TR_AUTOCOLLAPSE   2

// MessageBox styles
#define MB_BUTTON_OK      1
#define MB_BUTTON_CANCEL  2
#define MB_BUTTON_USER    4

// 3d object
#define CT_OBJECT 80



///////////////////////////////////////////////////////////////////////////
/// Base Classes
///////////////////////////////////////////////////////////////////////////
class RscText
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = 0;
	idc = -1;
	colorBackground[] =
	{
		0,
		0,
		0,
		0
	};
	colorText[] =
	{
		1,
		1,
		1,
		1
	};
	text = "";
	fixedWidth = 0;
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	style = 0;
	shadow = 1;
	colorShadow[] =
	{
		0,
		0,
		0,
		0.5
	};
	font = "PuristaMedium";
	SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	linespacing = 1;
	tooltipColorText[] =
	{
		1,
		1,
		1,
		1
	};
	tooltipColorBox[] =
	{
		1,
		1,
		1,
		1
	};
	tooltipColorShade[] =
	{
		0,
		0,
		0,
		0.65
	};
};

class RscStructuredText
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = 13;
	idc = -1;
	style = 0;
	colorText[] =
	{
		1,
		1,
		1,
		1
	};
	 colorBackground[] = {0,0,0,0};
	class Attributes
	{
		font = "PuristaMedium";
		color = "#ffffff";
		align = "left";
		shadow = 1;
	};
	x = 0;
	y = 0;
	h = 0.035;
	w = 0.1;
	text = "";
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	shadow = 1;
};
class RscPicture
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = 0;
	idc = -1;
	style = 48;
	colorBackground[] =
	{
		0,
		0,
		0,
		0
	};
	colorText[] =
	{
		1,
		1,
		1,
		1
	};
	font = "TahomaB";
	sizeEx = 0;
	lineSpacing = 0;
	text = "";
	fixedWidth = 0;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.2;
	h = 0.15;
	tooltipColorText[] =
	{
		1,
		1,
		1,
		1
	};
	tooltipColorBox[] =
	{
		1,
		1,
		1,
		1
	};
	tooltipColorShade[] =
	{
		0,
		0,
		0,
		0.65
	};
};
class RscEdit
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = 2;
	x = 0;
	y = 0;
	h = 0.04;
	w = 0.2;
	colorBackground[] =
	{
		0,
		0,
		0,
		1
	};
	colorText[] =
	{
		0.95,
		0.95,
		0.95,
		1
	};
	colorDisabled[] =
	{
		1,
		1,
		1,
		0.25
	};
	colorSelection[] =
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
		1
	};
	autocomplete = "";
	text = "";
	size = 0.2;
	style = "00x02";
	font = "PuristaMedium";
	shadow = 2;
	sizeEx = 0.045;
	canModify = 1;
	tooltipColorText[] =
	{
		1,
		1,
		1,
		1
	};
	tooltipColorBox[] =
	{
		1,
		1,
		1,
		1
	};
	tooltipColorShade[] =
	{
		0,
		0,
		0,
		0.65
	};
};
class RscCombo
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = 4;
	colorSelect[] =
	{
		0,
		0,
		0,
		1
	};
	colorText[] =
	{
		1,
		1,
		1,
		1
	};
	colorBackground[] =
	{
		0,
		0,
		0,
		1
	};
	colorScrollbar[] =
	{
		1,
		0,
		0,
		1
	};
	colorPicture[] =
	{
		1,
		1,
		1,
		1
	};
	colorPictureSelected[] =
	{
		1,
		1,
		1,
		1
	};
	colorPictureDisabled[] =
	{
		1,
		1,
		1,
		0.25
	};
	colorPictureRight[] =
	{
		1,
		1,
		1,
		1
	};
	colorPictureRightSelected[] =
	{
		1,
		1,
		1,
		1
	};
	colorPictureRightDisabled[] =
	{
		1,
		1,
		1,
		0.25
	};
	tooltipColorText[] =
	{
		1,
		1,
		1,
		1
	};
	tooltipColorBox[] =
	{
		1,
		1,
		1,
		1
	};
	tooltipColorShade[] =
	{
		0,
		0,
		0,
		0.65
	};
	soundSelect[] =
	{
		"\A3\ui_f\data\sound\RscCombo\soundSelect",
		0.1,
		1
	};
	soundExpand[] =
	{
		"\A3\ui_f\data\sound\RscCombo\soundExpand",
		0.1,
		1
	};
	soundCollapse[] =
	{
		"\A3\ui_f\data\sound\RscCombo\soundCollapse",
		0.1,
		1
	};
	maxHistoryDelay = 1;
	class ComboScrollBar
	{
		color[] =
		{
		1,1,1,1
		};
	};
	style = "0x10 + 0x200";
	font = "PuristaMedium";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.12;
	h = 0.035;
	colorSelectBackground[] =
	{
		1,
		1,
		1,
		0.7
	};
	arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
	arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
	wholeHeight = 0.45;
	colorActive[] =
	{
0.761,0.357,0.337,1
	};
	colorDisabled[] =
	{
		1,
		1,
		1,
		0.25
	};
	colorTextRight[] =
	{
		1,
		1,
		1,
		1
	};
	colorSelectRight[] =
	{
		0,
		0,
		0,
		1
	};
	colorSelect2Right[] =
	{
		0,
		0,
		0,
		1
	};
};
class RscListBox
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = 5;
	rowHeight = 0;
	onLBSelChanged  = "";
	colorText[] =
	{
		1,
		1,
		1,
		1
	};
	colorDisabled[] =
	{
		1,
		1,
		1,
		0.25
	};
	colorScrollbar[] =
	{
		1,
		0,
		0,
		0
	};
	colorSelect[] =
	{
		0,
		0,
		0,
		1
	};
	colorSelect2[] =
	{
		0,
		0,
		0,
		1
	};
	colorSelectBackground[] =
	{
		0.95,
		0.95,
		0.95,
		1
	};
	colorSelectBackground2[] =
	{
		1,
		1,
		1,
		0.5
	};
	colorBackground[] =
	{
		0,
		0,
		0,
		0
	};
	soundSelect[] =
	{
		"\A3\ui_f\data\sound\RscListbox\soundSelect",
		0.09,
		1
	};
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
	arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
	colorPicture[] =
	{
		1,
		1,
		1,
		1
	};
	colorPictureSelected[] =
	{
		1,
		1,
		1,
		1
	};
	colorPictureDisabled[] =
	{
		1,
		1,
		1,
		0.25
	};
	colorPictureRight[] =
	{
		1,
		1,
		1,
		1
	};
	colorPictureRightSelected[] =
	{
		1,
		1,
		1,
		1
	};
	colorPictureRightDisabled[] =
	{
		1,
		1,
		1,
		0.25
	};
	tooltipColorText[] =
	{
		1,
		1,
		1,
		1
	};
	tooltipColorBox[] =
	{
		1,
		1,
		1,
		1
	};
	tooltipColorShade[] =
	{
		0,
		0,
		0,
		0.65
	};
	class ListScrollBar
	{
		color[] =
		{
			1,
			1,
			1,
			1
		};
		autoScrollEnabled = 1;
		width = 0.021;
	};
	x = 0;
	y = 0;
	w = 0.3;
	h = 0.3;
	style = 16;
	font = "PuristaMedium";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	shadow = 0;
	colorShadow[] =
	{
		0,
		0,
		0,
		0.5
	};
	period = 1.2;
	maxHistoryDelay = 1;
	colorTextRight[] =
	{
		1,
		1,
		1,
		1
	};
	colorSelectRight[] =
	{
		0,
		0,
		0,
		1
	};
	colorSelect2Right[] =
	{
		0,
		0,
		0,
		1
	};
};

class RscXListBox
{
	access = 0;
	idc = CT_XLISTBOX;
	type = CT_XLISTBOX;
	style = SL_HORZ + ST_CENTER + LB_TEXTURES;
	default = 0;
	blinkingPeriod = 0;
	x = 12 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X;
	y = 17 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y;
	w = 10 * GUI_GRID_CENTER_W;
	h = 1 * GUI_GRID_CENTER_H;
	color[] = {1,1,1,1};
	colorActive[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	font = "PuristaMedium";
	shadow = 0;
	colorText[] = {1,1,1,1}; // Text color
	colorSelect[] = {1,1,1,1}; // Selected text color
	colorDisabled[] = {1,1,1,0.5}; // Disabled text color
	tooltip = ""; // Tooltip text
	tooltipColorShade[] = {0,0,0,0}; // Tooltip background color
	tooltipColorText[] = {1,1,1,0}; // Tooltip text color
	tooltipColorBox[] = {1,1,1,0}; // Tooltip frame color
	arrowEmpty = "\A3\ui_f\data\gui\cfg\slider\arrowEmpty_ca.paa"; // Arrow
	arrowFull = "\A3\ui_f\data\gui\cfg\slider\arrowFull_ca.paa"; // Arrow when clicked on
	border = "\A3\ui_f\data\gui\cfg\slider\border_ca.paa"; // Fill texture
	soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1};
};
class RscButton
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = 1;
	text = "";
	colorText[] =
	{
		1,
		1,
		1,
		1
	};
	colorDisabled[] =
	{
		1,
		1,
		1,
		0.25
	};
	colorBackground[] =
	{
		0,
		0,
		0,
		0.5
	};
	colorBackgroundDisabled[] =
	{
		0,
		0,
		0,
		0.5
	};
	colorBackgroundActive[] =
	{
		0,
		0,
		0,
		1
	};
	colorFocused[] =
	{
		0,
		0,
		0,
		1
	};
	colorShadow[] =
	{
		0,
		0,
		0,
		0
	};
	colorBorder[] =
	{
		0,
		0,
		0,
		1
	};
	soundEnter[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundEnter",
		0.09,
		1
	};
	soundPush[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundPush",
		0.09,
		1
	};
	soundClick[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundClick",
		0.09,
		1
	};
	soundEscape[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundEscape",
		0.09,
		1
	};
	style = 2;
	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.039216;
	shadow = 2;
	font = "PuristaMedium";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	offsetX = 0;
	offsetY = 0;
	offsetPressedX = 0;
	offsetPressedY = 0;
	borderSize = 0;
};
class RscShortcutButton
{
	deletable = 0;
	fade = 0;
	type = 16;
	x = 0.1;
	y = 0.1;
	class HitZone
	{
		left = 0;
		top = 0;
		right = 0;
		bottom = 0;
	};
	class ShortcutPos
	{
		left = 0;
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		w = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
		h = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class TextPos
	{
		left = 0;
		top = 0;
		right = 0;
		bottom = 0;
	};
	shortcuts[] =
	{
	};
	textureNoShortcut = "#(argb,8,8,3)color(0,0,0,0)";
	color[] =
	{
		1,
		1,
		1,
		1
	};
	colorFocused[] =
	{
		1,
		1,
		1,
		1
	};
	color2[] =
	{
		0.95,
		0.95,
		0.95,
		1
	};
	colorDisabled[] =
	{
		1,
		1,
		1,
		0.25
	};
	colorBackground[] =
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
		1
	};
	colorBackgroundFocused[] =
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
		1
	};
	colorBackground2[] =
	{
		1,
		1,
		1,
		1
	};
	soundEnter[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundEnter",
		0.09,
		1
	};
	soundPush[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundPush",
		0.09,
		1
	};
	soundClick[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundClick",
		0.09,
		1
	};
	soundEscape[] =
	{
		"\A3\ui_f\data\sound\RscButton\soundEscape",
		0.09,
		1
	};
	class Attributes
	{
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "center";
		shadow = "true";
	};
	idc = -1;
	style = 0;
	default = 0;
	shadow = 1;
	w = 0.183825;
	h = "((((safezoneW / safezoneH) min 1.2) / 1.2) / 20)";
	textSecondary = "";
	colorSecondary[] =
	{
		1,
		1,
		1,
		1
	};
	colorFocusedSecondary[] =
	{
		1,
		1,
		1,
		1
	};
	color2Secondary[] =
	{
		0.95,
		0.95,
		0.95,
		1
	};
	colorDisabledSecondary[] =
	{
		1,
		1,
		1,
		0.25
	};
	sizeExSecondary = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	fontSecondary = "PuristaMedium";
	animTextureDefault = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureNormal = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureDisabled = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureOver = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\over_ca.paa";
	animTextureFocused = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\focus_ca.paa";
	animTexturePressed = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\down_ca.paa";
	periodFocus = 1.2;
	periodOver = 0.8;
	period = 0.4;
	font = "PuristaMedium";
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	text = "";
	action = "";
	tooltip = "";
	class AttributesImage
	{
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "center";
	};
};
class RscShortcutButtonMain
{
	idc = -1;
	style = 0;
	default = 0;
	w = 0.313726;
	h = 0.104575;
	color[] =
	{
		1,
		1,
		1,
		1
	};
	colorDisabled[] =
	{
		1,
		1,
		1,
		0.25
	};
	class HitZone
	{
		left = 0;
		top = 0;
		right = 0;
		bottom = 0;
	};
	class ShortcutPos
	{
		left = 0.0145;
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)) / 2";
		w = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2) * (3/4)";
		h = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
	};
	class TextPos
	{
		left = "(((safezoneW / safezoneH) min 1.2) / 32) * 1.5";
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 20)*2 - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)) / 2";
		right = 0.005;
		bottom = 0;
	};
	animTextureNormal = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButtonMain\normal_ca.paa";
	animTextureDisabled = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButtonMain\disabled_ca.paa";
	animTextureOver = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButtonMain\over_ca.paa";
	animTextureFocused = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButtonMain\focus_ca.paa";
	animTexturePressed = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButtonMain\down_ca.paa";
	animTextureDefault = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButtonMain\normal_ca.paa";
	period = 0.5;
	font = "PuristaMedium";
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
	text = "";
	action = "";
	class Attributes
	{
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "left";
		shadow = "false";
	};
	class AttributesImage
	{
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "false";
	};
};
class RscFrame
{
	type = 0;
	idc = -1;
	style = 64;
	shadow = 2;
	colorBackground[] =
	{
		0,
		0,
		0,
		0
	};
	colorText[] =
	{
		1,
		1,
		1,
		1
	};
	font = "PuristaMedium";
	sizeEx = 0.02;
	text = "";
};
class RscSlider
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = 3;
	style = 1024;
	w = 0.3;
	color[] =
	{
		1,
		1,
		1,
		0.8
	};
	colorActive[] =
	{
		1,
		1,
		1,
		1
	};
	shadow = 0;
	h = 0.025;
};
class IGUIBack
{
	type = 0;
	idc = 124;
	style = 128;
	text = "";
	colorText[] =
	{
		0,
		0,
		0,
		0
	};
	font = "PuristaMedium";
	sizeEx = 0;
	shadow = 0;
	x = 0.1;
	y = 0.1;
	w = 0.1;
	h = 0.1;

	colorbackground[] =
	{
		"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])",
		"(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])",
		"(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])",
		"(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.8])"
	};
};
class RscCheckBox
{
	idc = -1;
	type = 77;
	style = 0;
	checked = 0;
	x = "0.375 * safezoneW + safezoneX";
	y = "0.36 * safezoneH + safezoneY";
	w = "0.025 * safezoneW";
	h = "0.04 * safezoneH";
	color[] =
	{
		1,
		1,
		1,
		0.7
	};
	colorFocused[] =
	{
		1,
		1,
		1,
		1
	};
	colorHover[] =
	{
		1,
		1,
		1,
		1
	};
	colorPressed[] =
	{
		1,
		1,
		1,
		1
	};
	colorDisabled[] =
	{
		1,
		1,
		1,
		0.2
	};
	colorBackground[] =
	{
		0,
		0,
		0,
		0
	};
	colorBackgroundFocused[] =
	{
		0,
		0,
		0,
		0
	};
	colorBackgroundHover[] =
	{
		0,
		0,
		0,
		0
	};
	colorBackgroundPressed[] =
	{
		0,
		0,
		0,
		0
	};
	colorBackgroundDisabled[] =
	{
		0,
		0,
		0,
		0
	};
	textureChecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureUnchecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	textureFocusedChecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureFocusedUnchecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	textureHoverChecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureHoverUnchecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	texturePressedChecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	texturePressedUnchecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	textureDisabledChecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureDisabledUnchecked = "A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	tooltipColorText[] =
	{
		1,
		1,
		1,
		1
	};
	tooltipColorBox[] =
	{
		1,
		1,
		1,
		1
	};
	tooltipColorShade[] =
	{
		0,
		0,
		0,
		0.65
	};
	soundEnter[] =
	{
		"",
		0.1,
		1
	};
	soundPush[] =
	{
		"",
		0.1,
		1
	};
	soundClick[] =
	{
		"",
		0.1,
		1
	};
	soundEscape[] =
	{
		"",
		0.1,
		1
	};
};
class RscTextCheckBox
{
	idc = -1;
	type = 7;
	style = 0;
	x = "0.375 * safezoneW + safezoneX";
	y = "0.36 * safezoneH + safezoneY";
	w = "0.025 * safezoneW";
	h = "0.04 * safezoneH";
	colorText[] =
	{
		1,
		0,
		0,
		1
	};
	color[] =
	{
		0,
		0,
		0,
		0
	};
	colorBackground[] =
	{
		0,
		0,
		1,
		1
	};
	colorTextSelect[] =
	{
		0,
		0.8,
		0,
		1
	};
	colorSelectedBg[] =
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
		1
	};
	colorSelect[] =
	{
		0,
		0,
		0,
		1
	};
	colorTextDisable[] =
	{
		0.4,
		0.4,
		0.4,
		1
	};
	colorDisable[] =
	{
		0.4,
		0.4,
		0.4,
		1
	};
	tooltipColorText[] =
	{
		1,
		1,
		1,
		1
	};
	tooltipColorBox[] =
	{
		1,
		1,
		1,
		1
	};
	tooltipColorShade[] =
	{
		0,
		0,
		0,
		0.65
	};
	font = "PuristaMedium";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	rows = 1;
	columns = 1;
	strings[] =
	{
		"UNCHECKED"
	};
	checked_strings[] =
	{
		"CHECKED"
	};
};
class RscButtonMenu
{
	idc = -1;
	type = 16;
	style = "0x02 + 0xC0";
	default = 0;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.039216;
	animTextureNormal = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDisabled = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureOver = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
	animTexturePressed = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDefault = "#(argb,8,8,3)color(1,1,1,1)";
	colorBackground[] =
	{
		0,
		0,
		0,
		0.8
	};
	colorBackgroundFocused[] =
	{
		1,
		1,
		1,
		1
	};
	colorBackground2[] =
	{
		0.75,
		0.75,
		0.75,
		1
	};
	color[] =
	{
		1,
		1,
		1,
		1
	};
	colorFocused[] =
	{
		0,
		0,
		0,
		1
	};
	color2[] =
	{
		0,
		0,
		0,
		1
	};
	colorText[] =
	{
		1,
		1,
		1,
		1
	};
	colorDisabled[] =
	{
		1,
		1,
		1,
		0.25
	};
	textSecondary = "";
	colorSecondary[] =
	{
		1,
		1,
		1,
		1
	};
	colorFocusedSecondary[] =
	{
		0,
		0,
		0,
		1
	};
	color2Secondary[] =
	{
		0,
		0,
		0,
		1
	};
	colorDisabledSecondary[] =
	{
		1,
		1,
		1,
		0.25
	};
	sizeExSecondary = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	fontSecondary = "PuristaLight";
	period = 1.2;
	periodFocus = 1.2;
	periodOver = 1.2;
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	tooltipColorText[] =
	{
		1,
		1,
		1,
		1
	};
	tooltipColorBox[] =
	{
		1,
		1,
		1,
		1
	};
	tooltipColorShade[] =
	{
		0,
		0,
		0,
		0.65
	};
	class TextPos
	{
		left = "0.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		right = 0.005;
		bottom = 0;
	};
	class Attributes
	{
		font = "PuristaLight";
		color = "#E5E5E5";
		align = "left";
		shadow = "false";
	};
	class ShortcutPos
	{
		left = "(6.25 * (((safezoneW / safezoneH) min 1.2) / 40)) - 0.0225 - 0.005";
		top = 0.005;
		w = 0.0225;
		h = 0.03;
	};
	soundEnter[] =
	{
		"\A3\ui_f\data\sound\RscButtonMenu\soundEnter",
		0.09,
		1
	};
	soundPush[] =
	{
		"\A3\ui_f\data\sound\RscButtonMenu\soundPush",
		0.09,
		1
	};
	soundClick[] =
	{
		"\A3\ui_f\data\sound\RscButtonMenu\soundClick",
		0.09,
		1
	};
	soundEscape[] =
	{
		"\A3\ui_f\data\sound\RscButtonMenu\soundEscape",
		0.09,
		1
	};
};
class RscButtonMenuOK
{
	idc = 1;
	shortcuts[] =
	{
		"0x00050000 + 0",
		28,
		57,
		156
	};
	default = 1;
	text = "OK";
	soundPush[] =
	{
		"\A3\ui_f\data\sound\RscButtonMenuOK\soundPush",
		0.09,
		1
	};
};
class RscButtonMenuCancel
{
	idc = 2;
	shortcuts[] =
	{
		"0x00050000 + 1"
	};
	text = "Cancel";
};
class RscObject
{
		access = 0;
		idc = -1;
		type = 81;
		style = 0x00;
		blinkingPeriod = 0;
		model = "\a3\Ui_f\objects\Compass.p3d";
		scale = 0.5;
		x = 0;
		y = 0;
		z = 1;
		w = 1;
		h = 1;

		xBack = 0;
		yBack = 0;
		zBack = 1;
		enableZoom = 0;
		zoomDuration = 0;
		inBack = 0;
		direction[] = {0,0,1};
		up[] = {0,1,0};
		tooltip = "";
		tooltipColorShade[] = {0,0,0,1};
		tooltipColorText[] = {1,1,1,1};
		tooltipColorBox[] = {1,1,1,1};
		onMouseMoving = "";
		onMouseHolding = "";
		onMouseDown = "";

};
class RscProgress
{
	type = 8;
	style = 0;
	colorFrame[] = {0,0,0,1};
	colorBar[] = {1,1,1,1};
	texture = "#(argb,8,8,3)color(1,1,1,1)";
	x = 0;
	y = 0;
	w = 1;
	h = 0.03;
};
class RscControlsGroup
{
	deletable = 0;
	fade = 0;
	class VScrollbar
	{
		color[] =
		{
			1,
			1,
			1,
			1
		};
		width = 0.021;
		autoScrollEnabled = 1;
	};
	class HScrollbar
	{
		color[] =
		{
			1,
			1,
			1,
			1
		};
		height = 0.028;
	};
	class Controls
	{
	};
	type = 15;
	idc = -1;
	x = 0;
	y = 0;
	w = 1;
	h = 1;
	shadow = 0;
	style = 16;

};
class RscActiveText
{
	idc = -1;
	type = CT_ACTIVETEXT;
	style = ST_PICTURE;
	x = 0.75;
	y = 0.5;
	w = 0.2;
	h = 0.035;
	font = PuristaMedium;
	sizeEx = 0.024;
	color[] = { 1, 1, 1, 1 };
	colorActive[] = { 1, 1, 1, 1 };
	colorDisabled[] = {1,1,1,1};
	soundEnter[] = { "", 0, 1 };   // no sound
	soundPush[] = { "A3\missions_f\data\sounds\click.wss", 0, 1 };
	soundClick[] = { "", 0, 1 };
	soundEscape[] = { "", 0, 1 };
	action = "hint ""Good choice!""";
	tooltip = "";
	text = "images\Tablet_Camo_Woodland.paa";
	default = true;
};

class RscVideo

{
	idc = -1;
	type = 0;
	style = 48;
	deletable = 0;
	access = 0;
	fade = 0;
	fixedWidth = 0;
	loops = 1;
	lineSpacing = 0;
	autoplay = 1;
	text = "";
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	font = "TahomaB";
	shadow = 0;
	sizeEx = 0;
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	tooltipColorText[] = {1,1,1,1};
	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.039216;


};

class RscActivePicture

{
	idc = -1;
	type = 11;
	style = 48;
	deletable = 0;
	access = 0;
	default = 0;
	shadow = 2;
	fade = 0;
	color[] = {1,1,1,1};
	colorActive[] = {1,1,1,0.25};
	colorDisabled[] = {1,1,1,1};
	url = "";
	text = "";
	font = "RobotoCondensed";
	action = "hint ""Good choice!""";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	soundEnter[] = { "", 0, 1 };   // no sound
	soundPush[] = { "A3\missions_f\data\sounds\click.wss", 0, 1 };
	soundClick[] = { "", 0, 1 };
	soundEscape[] = { "", 0, 1 };
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	tooltipColorText[] = {1,1,1,1};

};
class RscTreeScrollBar
{

	idc = -1;
	color[] = {1,1,1,0.25};
	colorActive[] = {1,1,1,0.25};
	colorDisabled[] = {1,1,1,0.3};
	thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
	arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
	arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
	border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	shadow = 0;
	scrollSpeed = 0.06;
	width = 0;
	height = 0;
	autoScrollEnabled = 0;
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
};
class RscTree
{
	idc = -1;
    type = 12;
	style = 0;
	font = "RobotoCondensed";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	expandedTexture = "A3\ui_f\data\gui\rsccommon\rsctree\expandedTexture_ca.paa";
	hiddenTexture = "A3\ui_f\data\gui\rsccommon\rsctree\hiddenTexture_ca.paa";
	x = 0;
	y = 0;
	w = 0.1;
	h = 0.2;
	rowHeight = 0.0439091;
	colorText[] = {1,1,1,1.0};
	colorSelect[] = {1,1,1,0.7};
	colorSelectText[] = {0,0,0,1};
	colorBackground[] = {0,0,0,0};
	colorSelectBackground[] = {0,0,0,0.5};
	colorBorder[] = {0,0,0,0};
	colorPicture[] = {1,1,1,1};
	colorPictureSelected[] = {1,1,1,1};
	colorPictureDisabled[] = {1,1,1,1};
	colorPictureRight[] = {1,1,1,1};
	colorPictureRightDisabled[] = {1,1,1,0.25};
	colorPictureRightSelected[] = {0,0,0,1};
	colorDisabled[] = {1,1,1,0.25};
	borderSize = 0;
	expandOnDoubleclick = 1;
	maxHistoryDelay = 1;
	colorArrow[] = {0,0,0,0};
	colorMarked[] = {1,0.5,0,0.5};
	colorMarkedText[] = {1,1,1,1};
	colorMarkedSelected[] = {1,0.5,0,1};
	onTreeSelChanged = "";
	onTreeLButtonDown = "";
	onTreeDblClick = "";
	onTreeExpanded = "";
	onTreeCollapsed = "";
	onTreeMouseMove = "";
	onTreeMouseHold = "";
	onTreeMouseExit = "";
	class ScrollBar: RscTreeScrollBar{};
};


class RscMapControl
{
  access = 0;
  idc = -1;
  type = CT_MAP_MAIN;
  style = ST_PICTURE;

  x = 0.10;
  y = 0.10;
  w = 0.80;
  h = 0.60;

  colorBackground[] = {1.00, 1.00, 1.00, 1.00};
  colorText[] = {0.00, 0.00, 0.00, 1.00};
  colorSea[] = {0.56, 0.80, 0.98, 0.50};
  colorForest[] = {0.60, 0.80, 0.20, 0.50};
  colorRocks[] = {0.50, 0.50, 0.50, 0.50};
  colorGrid[] = {0.1,0.1,0.1,0.6};
  colorGridMap[] = {0.1,0.1,0.1,0.6};
  colorCountlines[] = {0.65, 0.45, 0.27, 0.50};
  colorMainCountlines[] = {0.65, 0.45, 0.27, 1.00};
  colorCountlinesWater[] = {0.00, 0.53, 1.00, 0.50};
  colorMainCountlinesWater[] = {0.00, 0.53, 1.00, 0};
  colorForestBorder[] = {0.40, 0.80, 0.00, 0};
  colorRocksBorder[] = {0.50, 0.50, 0.50, 1.00};
  colorPowerLines[] = {0.00, 0.00, 0.00, 1.00};
  colorNames[] = {0.00, 0.00, 0.00, 1.00};
  colorInactive[] = {1.00, 1.00, 1.00, 0.50};
  colorLevels[] = {0.00, 0.00, 0.00, 1.00};
  colorOutside[] = {0,0,0,1};
  colorRailWay[] = {0.8,0.2,0,1};
  colorRoads[] = {0.7,0.7,0.7,1};
  colorRoadsFill[] = {1,1,1,1};
  colorTracks[] = {0.84,0.76,0.65,0.15};
  colorTracksFill[] = {0.84,0.76,0.65,1};
  colorTrails[] = {0.84,0.76,0.65,0.15};
  colorTrailsFill[] = {0.84,0.76,0.65,0.65};
  colorMainRoads[] = {0.9,0.5,0.3,1};
  colorMainRoadsFill[] = {1,0.6,0.4,1};

  font = "TahomaB";
  sizeEx = 0.040000;

  fontLabel = "TahomaB";
  sizeExLabel = 0.02;
  fontGrid = "TahomaB";
  sizeExGrid = 0.02;
  fontUnits = "TahomaB";
  sizeExUnits = 0.02;
  fontNames = "TahomaB";
  sizeExNames = 0.02;
  fontInfo = "TahomaB";
  sizeExInfo = 0.02;
  fontLevel = "TahomaB";
  sizeExLevel = 0.02;
maxSatelliteAlpha = 0.8;
moveOnEdges = 1;
  stickX[] = {0.20, {"Gamma", 1.00, 1.50} };
  stickY[] = {0.20, {"Gamma", 1.00, 1.50} };
  ptsPerSquareSea = 6;
  ptsPerSquareTxt = 8;
  ptsPerSquareCLn = 8;
  ptsPerSquareExp = 8;
  ptsPerSquareCost = 8;
  ptsPerSquareFor = "4.0f";
  ptsPerSquareForEdge = "10.0f";
  ptsPerSquareRoad = 2;
  ptsPerSquareObj = 10;
  text = "#(argb,8,8,3)color(1,1,1,1)";
  alphaFadeEndScale = 2;
  alphaFadeStartScale = 2;
  showCountourInterval=2;
  textureComboBoxColor = "#(argb,8,8,3)color(1,1,1,1)";
  	scaleMin = 0.05;
	scaleMax = 1.5;
	scaleDefault = 0.16;
  onMouseButtonClick = "";
  onMouseButtonDblClick = "";
	class LineMarker {
		lineDistanceMin = 3e-005;
		lineLengthMin = 5;
		lineWidthThick = 0.014;
		lineWidthThin = 0.008;
		textureComboBoxColor = "#(argb,8,8,3)color(1,1,1,1)";
	};
	class Legend {
		x = "SafeZoneX + 					(			((safezoneW / safezoneH) min 1.2) / 40)";
		y = "SafeZoneY + safezoneH - 4.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		w = "10 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
		h = "3.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		font = "PuristaMedium";
		sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		colorBackground[] = {1, 1, 1, 0.5};
		color[] = {0, 0, 0, 1};
	};

	class Task {
		icon = "\A3\ui_f\data\map\mapcontrol\taskIcon_CA.paa";
		iconCreated = "\A3\ui_f\data\map\mapcontrol\taskIconCreated_CA.paa";
		iconCanceled = "\A3\ui_f\data\map\mapcontrol\taskIconCanceled_CA.paa";
		iconDone = "\A3\ui_f\data\map\mapcontrol\taskIconDone_CA.paa";
		iconFailed = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_CA.paa";
		color[] = {"(profilenamespace getvariable ['IGUI_TEXT_RGB_R',0])", "(profilenamespace getvariable ['IGUI_TEXT_RGB_G',1])", "(profilenamespace getvariable ['IGUI_TEXT_RGB_B',1])", "(profilenamespace getvariable ['IGUI_TEXT_RGB_A',0.8])"};
		colorCreated[] = {1, 1, 1, 1};
		colorCanceled[] = {0.7, 0.7, 0.7, 1};
		colorDone[] = {0.7, 1, 0.3, 1};
		colorFailed[] = {1, 0.3, 0.2, 1};
		size = 27;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};

	class Waypoint {
		icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
		color[] = {0, 0, 0, 1};
		size = 27;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};

	class WaypointCompleted {
		icon = "\A3\ui_f\data\map\mapcontrol\waypointCompleted_ca.paa";
		color[] = {0, 0, 0, 1};
		size = 27;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};

	class CustomMark {
		icon = "\A3\ui_f\data\map\mapcontrol\custommark_ca.paa";
		size = 24;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
		color[] = {0, 0, 0, 1};
	};

	class Command {
		icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
		size = 18;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};

	class Bush {
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		color[] = {0.45, 0.64, 0.33, 0.4};
		size = 14/2;
		importance = 0.2 * 14 * 0.05 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};

	class Rock {
		icon = "\A3\ui_f\data\map\mapcontrol\rock_ca.paa";
		color[] = {0.1, 0.1, 0.1, 0.8};
		size = 12;
		importance = 0.5 * 12 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};

	class SmallTree {
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		color[] = {0.45, 0.64, 0.33, 0.4};
		size = 12;
		importance = 0.6 * 12 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};

	class Tree {
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		color[] = {0.45, 0.64, 0.33, 0.4};
		size = 12;
		importance = 0.9 * 16 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
	};

	class busstop {
		icon = "\A3\ui_f\data\map\mapcontrol\busstop_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};

	class fuelstation {
		icon = "\A3\ui_f\data\map\mapcontrol\fuelstation_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};

	class hospital {
		icon = "\A3\ui_f\data\map\mapcontrol\hospital_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};

	class church {
		icon = "\A3\ui_f\data\map\mapcontrol\church_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};

	class lighthouse {
		icon = "\A3\ui_f\data\map\mapcontrol\lighthouse_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};

	class power {
		icon = "\A3\ui_f\data\map\mapcontrol\power_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};

	class powersolar {
		icon = "\A3\ui_f\data\map\mapcontrol\powersolar_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};

	class powerwave {
		icon = "\A3\ui_f\data\map\mapcontrol\powerwave_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};

	class powerwind {
		icon = "\A3\ui_f\data\map\mapcontrol\powerwind_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};

	class quay {
		icon = "\A3\ui_f\data\map\mapcontrol\quay_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};

	class shipwreck {
		icon = "\A3\ui_f\data\map\mapcontrol\shipwreck_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};

	class transmitter {
		icon = "\A3\ui_f\data\map\mapcontrol\transmitter_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};

	class watertower {
		icon = "\A3\ui_f\data\map\mapcontrol\watertower_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};

	class Cross {
		icon = "\A3\ui_f\data\map\mapcontrol\Cross_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {0, 0, 0, 1};
	};

	class Chapel {
		icon = "\A3\ui_f\data\map\mapcontrol\Chapel_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {0, 0, 0, 1};
	};

	class Bunker {
		icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		size = 14;
		importance = 1.5 * 14 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
		color[] = {0, 0, 0, 1};
	};

	class Fortress {
		icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		size = 16;
		importance = 2 * 16 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
		color[] = {0, 0, 0, 1};
	};

	class Fountain {
		icon = "\A3\ui_f\data\map\mapcontrol\fountain_ca.paa";
		size = 11;
		importance = 1 * 12 * 0.05;
		coefMin = 0.25;
		coefMax = 4;
		color[] = {0, 0, 0, 1};
	};

	class Ruin {
		icon = "\A3\ui_f\data\map\mapcontrol\ruin_ca.paa";
		size = 16;
		importance = 1.2 * 16 * 0.05;
		coefMin = 1;
		coefMax = 4;
		color[] = {0, 0, 0, 1};
	};

	class Stack {
		icon = "\A3\ui_f\data\map\mapcontrol\stack_ca.paa";
		size = 20;
		importance = 2 * 16 * 0.05;
		coefMin = 0.9;
		coefMax = 4;
		color[] = {0, 0, 0, 1};
	};

	class Tourism {
		icon = "\A3\ui_f\data\map\mapcontrol\tourism_ca.paa";
		size = 16;
		importance = 1 * 16 * 0.05;
		coefMin = 0.7;
		coefMax = 4;
		color[] = {0, 0, 0, 1};
	};

	class ViewTower {
		icon = "\A3\ui_f\data\map\mapcontrol\viewtower_ca.paa";
		size = 16;
		importance = 2.5 * 16 * 0.05;
		coefMin = 0.5;
		coefMax = 4;
		color[] = {0, 0, 0, 1};
	};

	class ActiveMarker {
		size = 24;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
		color[] = {0, 0, 0, 1};
	};
};
class RscVertSbar {
    idc = -1;
    type = CT_SLIDER;
    style = SL_VERT;
 	width = 0.021;
	color[] = {1,1,1,0.25};
	colorActive[] = {1,1,1,0.25};
	colorDisabled[] = {1,1,1,0.3};
        thumb = "#(argb,8,8,3)color(0,0,0,1)";
        arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
        arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
        border = "#(argb,8,8,3)color(1,1,1,1)";
	shadow = 0;
	scrollSpeed = 0.06;
};

