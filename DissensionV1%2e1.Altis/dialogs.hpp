
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by [Vcom]Dominic, v1.063, #Remuve)
////////////////////////////////////////////////////////
class Dis_Info1
{
	idd = 3000;
	movingenable = true;
class  Controls
{
	class dis_Outline: RscFrame
	{
		idc = 1800;
		x = 0.860937 * safezoneW + safezoneX;
		y = 0.8718 * safezoneH + safezoneY;
		w = 0.120656 * safezoneW;
		h = 0.1012 * safezoneH;
	};
	class dis_resources: RscStructuredText
	{
		idc = 1100;
		x = 0.860937 * safezoneW + safezoneX;
		y = 0.874 * safezoneH + safezoneY;
		w = 0.118594 * safezoneW;
		h = 0.0968 * safezoneH;
	sizeEx = "0.02 / (getResolution select 5)";
	};
	class dis_tickets: RscStructuredText
	{
		idc = 1101;
		x = 0.824844 * safezoneW + safezoneX;
		y = 0.8916 * safezoneH + safezoneY;
		w = 0.0360937 * safezoneW;
		h = 0.066 * safezoneH;
	sizeEx = "0.02 / (getResolution select 5)";
	};
	class RscFrame_1801: RscFrame
	{
		idc = 1801;
		x = 0.823812 * safezoneW + safezoneX;
		y = 0.8894 * safezoneH + safezoneY;
		w = 0.0381563 * safezoneW;
		h = 0.0726 * safezoneH;
	};
};
};


class Dis_Agree1
{
	idd = 3027;
	movingenable = true;
class  Controls
{
	class IGUIBack_2200: IGUIBack
	{
		idc = 2200;
		x = 0.387592 * safezoneW + safezoneX;
		y = 0.445 * safezoneH + safezoneY;
		w = 0.216563 * safezoneW;
		h = 0.066 * safezoneH;
	};
	class dis_purchase: RscButton
	{
		idc = 1600;
		text = "Purchase"; //--- ToDo: Localize;
		x = 0.397906 * safezoneW + safezoneX;
		y = 0.467 * safezoneH + safezoneY;
		w = 0.0515625 * safezoneW;
		h = 0.022 * safezoneH;
		onButtonClick	= "null = [1] execVM 'Functions\dis_PurchaseDiag.sqf';";
	};
	class dis_sell: RscButton
	{
		idc = 1601;
		text = "Cancel"; //--- ToDo: Localize;
		x = 0.541249 * safezoneW + safezoneX;
		y = 0.467 * safezoneH + safezoneY;
		w = 0.0515625 * safezoneW;
		h = 0.022 * safezoneH;
		onButtonClick	= "null = [2] execVM 'Functions\dis_PurchaseDiag.sqf';";
	};
};
};





class Dis_Ipad
{
	idd = 3014;
	movingenable = true;
	name="IPad";
	onLoad="uiNamespace setVariable [""IPad"",_this select 0]";
class  Controls

{



class DGN_IpadPicture: RscPicture
{
	idc = 1200;
	text = "";
	x = 0.255 * safezoneW + safezoneX;
	y = 0.2 * safezoneH + safezoneY;
	w = 0.48625 * safezoneW;
	h = 0.676 * safezoneH;
};
class DGN_EventListBox: RscListbox
{
	idc = 1500;
	x = 0.314375 * safezoneW + safezoneX;
	y = 0.291 * safezoneH + safezoneY;
	w = 0.37125 * safezoneW;
	h = 0.11 * safezoneH;
	class ScrollBar
	{
		color[] =
		{
			1,
			1,
			1,
			0.6
		};
		colorActive[] =
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
			0.3
		};
		shadow = 0;
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};
};

/*
class DGN_DescriptionText: RscStructuredText
{
	idc = 1100;
	x = 0.324687 * safezoneW + safezoneX;
	y = 0.423 * safezoneH + safezoneY;
	w = 0.350625 * safezoneW;
	h = 0.264 * safezoneH;
};
*/

class RscStructuredText_1100: RscControlsGroup
{
  idc = 200908;
	x = 0.324687 * safezoneW + safezoneX;
	y = 0.433 * safezoneH + safezoneY;
	w = 0.350625 * safezoneW;
	h = 0.305 * safezoneH;
class VScrollbar
	{
		width = 0.021;
		autoScrollSpeed = -1;
		autoScrollDelay = 5;
		autoScrollRewind = 0;
		color[] =
		{
			1,
			1,
			1,
			0.6
		};
		colorActive[] =
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
			0.3
		};
		shadow = 0;
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};

	class HScrollbar
	{
		height = 0.028;
		color[] =
		{
			1,
			1,
			1,
			0.6
		};
		colorActive[] =
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
			0.3
		};
		shadow = 0;
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};
	class ScrollBar
	{
		color[] =
		{
			1,
			1,
			1,
			0.6
		};
		colorActive[] =
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
			0.3
		};
		shadow = 0;
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};




  class Controls
  {
    class DGN_DescriptionText: RscStructuredText
    {
			idc = 1100;
			x = 0.0 * safezoneW + safezoneX;
			y = 0.0 * safezoneH + safezoneY;
			w = 0.350625 * safezoneW;
			h = 1.00 * safezoneH;
      colorText[] = {0,0,0,0.6};
      colorBackground[] = {0,0,0,0.6};
      colorActive[] = {0,0,0,0.6};
	class VScrollbar
		{
			width = 0.021;
			autoScrollSpeed = -1;
			autoScrollDelay = 5;
			autoScrollRewind = 0;
			color[] =
			{
				1,
				1,
				1,
				0.6
			};
			colorActive[] =
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
				0.3
			};
			shadow = 0;
			thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
			arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
			arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
			border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
		};

		class HScrollbar
		{
			height = 0.028;
			color[] =
			{
				1,
				1,
				1,
				0.6
			};
			colorActive[] =
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
				0.3
			};
			shadow = 0;
			thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
			arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
			arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
			border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
		};
		class ScrollBar
		{
			color[] =
			{
				1,
				1,
				1,
				0.6
			};
			colorActive[] =
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
				0.3
			};
			shadow = 0;
			thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
			arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
			arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
			border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
			};


    };
  };
};




class IGUIBack_2200: IGUIBack
{
	idc = 2200;
	x = 0.314375 * safezoneW + safezoneX;
	y = 0.401 * safezoneH + safezoneY;
	w = 0.37125 * safezoneW;
	h = 0.022 * safezoneH;
};
class IGUIBack_2201: IGUIBack
{
	idc = 2201;
	x = 0.675312 * safezoneW + safezoneX;
	y = 0.423 * safezoneH + safezoneY;
	w = 0.0103125 * safezoneW;
	h = 0.324 * safezoneH;
};
class IGUIBack_2202: IGUIBack
{
	idc = 2202;
	x = 0.314375 * safezoneW + safezoneX;
	y = 0.747 * safezoneH + safezoneY;
	w = 0.37125 * safezoneW;
	h = 0.022 * safezoneH;
};
class IGUIBack_2203: IGUIBack
{
	idc = 2203;
	x = 0.314375 * safezoneW + safezoneX;
	y = 0.423 * safezoneH + safezoneY;
	w = 0.0103125 * safezoneW;
	h = 0.324 * safezoneH;
};
class DIS_MM: RscButton
{
	idc = 1600;
	x = 0.29375 * safezoneW + safezoneX;
	y = 0.4934 * safezoneH + safezoneY;
	w = 0.0278438 * safezoneW;
	h = 0.055 * safezoneH;
	colorText[] = {0,0,0,0};
	colorBackground[] = {0,0,0,0};
	colorBackgroundActive[] = {0,0,0,0};
	colorBorder[] = {0,0,0,0};
	colorActive[] = {0,0,0,0};
	colorFocused[] = {0,0,0,0};
	colorDisabled[] = {0,0,0,0};
	colorBackgroundDisabled[] = {0,0,0,0};
	colorShadow[] = {0,0,0,0};
	shadow = 0;
	borderSize = 0;
	onButtonClick = "[] call dis_DMM;";


	tooltip = "Display the main menu."; //--- ToDo: Localize;
};





};
};


/* #Hyvexa
$[
	1.063,
	["Vehicles",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1500,"DIS_VehicleList",[1,"",["0.314375 * safezoneW + safezoneX","0.269 * safezoneH + safezoneY","0.232031 * safezoneW","0.462 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1200,"Dis_Picture",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.577344 * safezoneW + safezoneX","0.269 * safezoneH + safezoneY","0.103125 * safezoneW","0.154 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"DIS_Purchase",[1,"Purchase",["0.597969 * safezoneW + safezoneX","0.434 * safezoneH + safezoneY","0.061875 * safezoneW","0.044 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"DIS_Close",[1,"X",["0.690781 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.0154688 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"Dis_Text1",[1,"Vehicles",["0.309219 * safezoneW + safezoneX","0.236 * safezoneH + safezoneY","0.0515625 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1800,"Dis_Frame1",[1,"",["0.309219 * safezoneW + safezoneX","0.258 * safezoneH + safezoneY","0.242344 * safezoneW","0.484 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1801,"Dis_Frame2",[1,"",["0.572187 * safezoneW + safezoneX","0.258 * safezoneH + safezoneY","0.113437 * safezoneW","0.176 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1201,"Dis_Pictures1",[1,"#(argb,8,8,3)color(1,1,1,1)",["0.29375 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.4125 * safezoneW","0.55 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"Dis_Text2",[1,"Cost:",["0.572187 * safezoneW + safezoneX","0.555 * safezoneH + safezoneY","0.113437 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"DIS_PCASHText",[1,"Current Cash:",["0.572187 * safezoneW + safezoneX","0.511 * safezoneH + safezoneY","0.113437 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1802,"Dis_Frame",[1,"",["0.572187 * safezoneW + safezoneX","0.511 * safezoneH + safezoneY","0.12375 * safezoneW","0.066 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Dominic, v1.063, #Fuxofo)
////////////////////////////////////////////////////////
class Dis_VehiclePurchase
{
	idd = 3016;
	movingenable = true;
	name="VehiclePurchase";
	onLoad="uiNamespace setVariable [""VehiclePurchase"",_this select 0]";
class  Controls

{
class Dis_Pictures1: RscPicture
{
	idc = 1201;
	text = "";
	x = 0.29375 * safezoneW + safezoneX;
	y = 0.225 * safezoneH + safezoneY;
	w = 0.4125 * safezoneW;
	h = 0.55 * safezoneH;
};
class Dis_Picture: RscPicture
{
	idc = 1200;
	text = "";
	x = 0.577344 * safezoneW + safezoneX;
	y = 0.269 * safezoneH + safezoneY;
	w = 0.103125 * safezoneW;
	h = 0.154 * safezoneH;
};
class DIS_VehicleList: RscListbox
{
	idc = 1500;
	x = 0.314375 * safezoneW + safezoneX;
	y = 0.269 * safezoneH + safezoneY;
	w = 0.232031 * safezoneW;
	h = 0.462 * safezoneH;
};
class DIS_Purchase: RscButton
{
	idc = 1600;
	animTextureNormal = "Pictures\Background.paa";
	animTextureDisabled = "Pictures\Background.paa";
	animTextureOver = "Pictures\Background.paa";
	animTextureFocused = "Pictures\Background.paa";
	animTexturePressed = "Pictures\Background.paa";
	animTextureDefault = "Pictures\Background.paa";
	textureNoShortcut = "Pictures\Background.paa";
	text = "Purchase"; //--- ToDo: Localize;
	onButtonClick	= "[] call dis_VehiclePurchase2";
	x = 0.597969 * safezoneW + safezoneX;
	y = 0.434 * safezoneH + safezoneY;
	w = 0.061875 * safezoneW;
	h = 0.044 * safezoneH;
	colorText[] = {1,1,1,1};
 colorDisabled[] = {0.8,0.8,0.8,1};
 colorBackground[] = {0.8,0.8,0.8,1};
 colorBackgroundDisabled[] = {0.8,0.8,0.8,1};
 colorBackgroundActive[] = {0.8,0.8,0.8,1};
};
class DIS_Close: RscButton
{
	idc = 1601;
	animTextureNormal = "Pictures\Background.paa";
	animTextureDisabled = "Pictures\Background.paa";
	animTextureOver = "Pictures\Background.paa";
	animTextureFocused = "Pictures\Background.paa";
	animTexturePressed = "Pictures\Background.paa";
	animTextureDefault = "Pictures\Background.paa";
	textureNoShortcut = "Pictures\Background.paa";
	text = "X"; //--- ToDo: Localize;
	onButtonClick	= "closedialog 3016";
	x = 0.690781 * safezoneW + safezoneX;
	y = 0.225 * safezoneH + safezoneY;
	w = 0.0154688 * safezoneW;
	h = 0.033 * safezoneH;
	colorText[] = {1,1,1,1};
	colorDisabled[] = {0.8,0.8,0.8,1};
	colorBackground[] = {0.8,0.8,0.8,1};
	colorBackgroundDisabled[] = {0.8,0.8,0.8,1};
	colorBackgroundActive[] = {0.8,0.8,0.8,1};
};
class Dis_Text1: RscText
{
	idc = 1000;
	text = "Vehicles"; //--- ToDo: Localize;
	colorBackground[] = {0,0,0,1};
	x = 0.309219 * safezoneW + safezoneX;
	y = 0.236 * safezoneH + safezoneY;
	w = 0.0515625 * safezoneW;
	h = 0.022 * safezoneH;
};
class Dis_Text2: RscText
{
	idc = 1001;
	text = "Cost:"; //--- ToDo: Localize;
	colorBackground[] = {0,0,0,1};
	x = 0.572187 * safezoneW + safezoneX;
	y = 0.555 * safezoneH + safezoneY;
	w = 0.113437 * safezoneW;
	h = 0.022 * safezoneH;
};
class DIS_PCASHText: RscText
{
	idc = 1002;
	text = "Current Cash:"; //--- ToDo: Localize;
	colorBackground[] = {0,0,0,1};
	x = 0.572187 * safezoneW + safezoneX;
	y = 0.511 * safezoneH + safezoneY;
	w = 0.113437 * safezoneW;
	h = 0.022 * safezoneH;
};
class Dis_Frame1: RscFrame
{
	idc = 1800;
	x = 0.309219 * safezoneW + safezoneX;
	y = 0.258 * safezoneH + safezoneY;
	w = 0.242344 * safezoneW;
	h = 0.484 * safezoneH;
};
class Dis_Frame2: RscFrame
{
	idc = 1801;
	x = 0.572187 * safezoneW + safezoneX;
	y = 0.258 * safezoneH + safezoneY;
	w = 0.113437 * safezoneW;
	h = 0.176 * safezoneH;
};
class Dis_Frame: RscFrame
{
	idc = 1802;
	x = 0.572187 * safezoneW + safezoneX;
	y = 0.511 * safezoneH + safezoneY;
	w = 0.12375 * safezoneW;
	h = 0.066 * safezoneH;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
};
};


/* #Tokeda
$[
	1.063,
	["Dis_Recruit",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[2206,"",[1,"",["0.29375 * safezoneW + safezoneX","0.214 * safezoneH + safezoneY","0.4125 * safezoneW","0.561 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1500,"DIS_UnitLB",[1,"",["0.304062 * safezoneW + safezoneX","0.247 * safezoneH + safezoneY","0.12375 * safezoneW","0.506 * safezoneH"],[-1,-1,-1,-1],[0,0,0,1],[-1,-1,-1,-1],"","-1"],[]],
	[1100,"DIS_Infobox",[1,"",["0.448438 * safezoneW + safezoneX","0.247 * safezoneH + safezoneY","0.237187 * safezoneW","0.154 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"DIS_Units",[1,"Units",["0.324687 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.0721875 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2200,"",[1,"",["0.436063 * safezoneW + safezoneX","0.423 * safezoneH + safezoneY","0.00515625 * safezoneW","0.352 * safezoneH"],[0,0,0,1],[0,0,0,1],[0,0,0,1],"","-1"],[]],
	[2201,"",[1,"",["0.438125 * safezoneW + safezoneX","0.423 * safezoneH + safezoneY","0.268125 * safezoneW","0.011 * safezoneH"],[0,0,0,1],[0,0,0,1],[0,0,0,1],"","-1"],[]],
	[2202,"",[1,"",["0.29375 * safezoneW + safezoneX","0.214 * safezoneH + safezoneY","0.4125 * safezoneW","0.011 * safezoneH"],[0,0,0,1],[0,0,0,1],[0,0,0,1],"","-1"],[]],
	[2203,"",[1,"",["0.701094 * safezoneW + safezoneX","0.214 * safezoneH + safezoneY","0.00515625 * safezoneW","0.22 * safezoneH"],[0,0,0,1],[0,0,0,1],[0,0,0,1],"","-1"],[]],
	[2204,"",[1,"",["0.29375 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.00515625 * safezoneW","0.55 * safezoneH"],[0,0,0,1],[0,0,0,1],[0,0,0,1],"","-1"],[]],
	[2205,"",[1,"",["0.295812 * safezoneW + safezoneX","0.764 * safezoneH + safezoneY","0.144375 * safezoneW","0.011 * safezoneH"],[0,0,0,1],[0,0,0,1],[0,0,0,1],"","-1"],[]],
	[2800,"DIS_CheckBox",[1,"",["0.528875 * safezoneW + safezoneX","0.555 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"DIS_JoinGroupText",[1,"Join My Group",["0.543313 * safezoneW + safezoneX","0.555 * safezoneH + safezoneY","0.061875 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1600,"Dis_RecruitButton",[1,"Recruit",["0.530937 * safezoneW + safezoneX","0.599 * safezoneH + safezoneY","0.0721875 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1601,"Dis_Exit",[1,"X",["0.298906 * safezoneW + safezoneX","0.225 * safezoneH + safezoneY","0.0154688 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Genesis, v1.063, #Tokeda)
////////////////////////////////////////////////////////
class Dis_RecruitUnits
{
	idd = 3017;
	movingenable = true;
	name="RecruitUnits";
	onLoad="uiNamespace setVariable [""RecruitUnits"",_this select 0]";
	
class  Controls
{
class IGUIBack_2206: IGUIBack
{
	idc = 2206;
	x = 0.29375 * safezoneW + safezoneX;
	y = 0.214 * safezoneH + safezoneY;
	w = 0.4125 * safezoneW;
	h = 0.561 * safezoneH;
};
class DIS_UnitLB: RscListbox
{
	idc = 1500;
	x = 0.304062 * safezoneW + safezoneX;
	y = 0.247 * safezoneH + safezoneY;
	w = 0.12375 * safezoneW;
	h = 0.506 * safezoneH;
	colorBackground[] = {0,0,0,1};
	style = ST_LEFT;
	sizeEx = "0.02 / (getResolution select 5)";	
};
class DIS_Infobox: RscStructuredText
{
	idc = 1100;
	style = ST_LEFT;
	x = 0.448438 * safezoneW + safezoneX;
	y = 0.247 * safezoneH + safezoneY;
	w = 0.237187 * safezoneW;
	h = 0.154 * safezoneH;
	class VScrollbar
		{
			width = 0.021;
			autoScrollSpeed = -1;
			autoScrollDelay = 5;
			autoScrollRewind = 0;
			color[] =
			{
				1,
				1,
				1,
				0.6
			};
			colorActive[] =
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
				0.3
			};
			shadow = 0;
			thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
			arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
			arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
			border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
		sizeEx = "0.02 / (getResolution select 5)";
		};

		class HScrollbar
		{
			height = 0.028;
			color[] =
			{
				1,
				1,
				1,
				0.6
			};
			colorActive[] =
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
				0.3
			};
			shadow = 0;
			thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
			arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
			arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
			border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
		sizeEx = "0.02 / (getResolution select 5)";
		};
		class ScrollBar
		{
			color[] =
			{
				1,
				1,
				1,
				0.6
			};
			colorActive[] =
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
				0.3
			};
			shadow = 0;
			thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
			arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
			arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
			border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
		sizeEx = "0.02 / (getResolution select 5)";
			};	
};
class DIS_Units: RscText
{
	idc = 1000;
	text = "Units"; //--- ToDo: Localize;
	x = 0.324687 * safezoneW + safezoneX;
	y = 0.225 * safezoneH + safezoneY;
	w = 0.0721875 * safezoneW;
	h = 0.022 * safezoneH;
sizeEx = "0.02 / (getResolution select 5)";	
style = ST_LEFT;
};
class IGUIBack_2200: IGUIBack
{
	idc = 2200;
	x = 0.436063 * safezoneW + safezoneX;
	y = 0.423 * safezoneH + safezoneY;
	w = 0.00515625 * safezoneW;
	h = 0.352 * safezoneH;
	colorText[] = {0,0,0,1};
	colorBackground[] = {0,0,0,1};
	colorActive[] = {0,0,0,1};
};
class IGUIBack_2201: IGUIBack
{
	idc = 2201;
	x = 0.438125 * safezoneW + safezoneX;
	y = 0.423 * safezoneH + safezoneY;
	w = 0.268125 * safezoneW;
	h = 0.011 * safezoneH;
	colorText[] = {0,0,0,1};
	colorBackground[] = {0,0,0,1};
	colorActive[] = {0,0,0,1};

};
class IGUIBack_2202: IGUIBack
{
	idc = 2202;
	x = 0.29375 * safezoneW + safezoneX;
	y = 0.214 * safezoneH + safezoneY;
	w = 0.4125 * safezoneW;
	h = 0.011 * safezoneH;
	colorText[] = {0,0,0,1};
	colorBackground[] = {0,0,0,1};
	colorActive[] = {0,0,0,1};

};
class IGUIBack_2203: IGUIBack
{
	idc = 2203;
	x = 0.701094 * safezoneW + safezoneX;
	y = 0.214 * safezoneH + safezoneY;
	w = 0.00515625 * safezoneW;
	h = 0.22 * safezoneH;
	colorText[] = {0,0,0,1};
	colorBackground[] = {0,0,0,1};
	colorActive[] = {0,0,0,1};

};
class IGUIBack_2204: IGUIBack
{
	idc = 2204;
	x = 0.29375 * safezoneW + safezoneX;
	y = 0.225 * safezoneH + safezoneY;
	w = 0.00515625 * safezoneW;
	h = 0.55 * safezoneH;
	colorText[] = {0,0,0,1};
	colorBackground[] = {0,0,0,1};
	colorActive[] = {0,0,0,1};

};
class IGUIBack_2205: IGUIBack
{
	idc = 2205;
	x = 0.295812 * safezoneW + safezoneX;
	y = 0.764 * safezoneH + safezoneY;
	w = 0.144375 * safezoneW;
	h = 0.011 * safezoneH;
	colorText[] = {0,0,0,1};
	colorBackground[] = {0,0,0,1};
	colorActive[] = {0,0,0,1};

};
class DIS_CheckBox: RscCheckbox
{
	idc = 2800;
	x = 0.52865 * safezoneW + safezoneX;
	y = 0.555 * safezoneH + safezoneY;
	w = 0.0155 * safezoneW;
	h = 0.022 * safezoneH;
	strings[] =
	{
		"NO"
	};
	checked_strings[] =
	{
		"YES"
	};
	sizeEx = "0.015 / (getResolution select 5)";	
};
class DIS_JoinGroupText: RscText
{
	idc = 1001;
	text = "Join My Group"; //--- ToDo: Localize;
	x = 0.543313 * safezoneW + safezoneX;
	y = 0.555 * safezoneH + safezoneY;
	w = 0.061875 * safezoneW;
	h = 0.022 * safezoneH;
	sizeEx = "0.015 / (getResolution select 5)";	
};
class Dis_RecruitButton: RscButton
{
	idc = 1600;
	text = "Recruit"; //--- ToDo: Localize;
	x = 0.530937 * safezoneW + safezoneX;
	y = 0.599 * safezoneH + safezoneY;
	w = 0.0721875 * safezoneW;
	h = 0.022 * safezoneH;
	onButtonClick	= "[] call Dis_fnc_recruitSel";
};
class Dis_Exit: RscButton
{
	idc = 1601;
	text = "X"; //--- ToDo: Localize;
	x = 0.298906;
	y = 0.225;
	w = 0.0154688;
	h = 0.022;
	onButtonClick	= "closedialog 3017";
};
};
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
