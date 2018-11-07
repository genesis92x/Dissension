////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by [Vcom]Dominic, v1.063, #Lycygu)
////////////////////////////////////////////////////////
#define CT_STATIC         0
#define ST_LEFT           0x00
#define ST_CENTER         0x02
class KOZHUD
{
  idd = 1002;
  movingEnable=0;
  duration=1e+011;
  name = "KOZHUD_name";
  onLoad = "uiNamespace setVariable ['KOZHUD', _this select 0];";
	onUnLoad = "uiNamespace setVariable ['KOZHUD', nil]";
  controlsBackground[] = {};
  objects[] = {};
class controls
{
class KOZ_IndScore: IGUIBack
{
	idc = 2200;
  type = CT_STATIC;
	x = 0.463895 * safezoneW + safezoneX;
	y = 0.0270386 * safezoneH + safezoneY;
	w = 0.0670526 * safezoneW;
	h = 0.0329973 * safezoneH;
	colorBackground[] = {0,0.76,0.12,0.5};
	colorActive[] = {0,0.76,0.12,0.5};
};
class KOZ_BluScore: IGUIBack
{
	idc = 2201;
  type = CT_STATIC;
	x = 0.386526 * safezoneW + safezoneX;
	y = 0.0270386 * safezoneH + safezoneY;
	w = 0.0670526 * safezoneW;
	h = 0.0329973 * safezoneH;
	colorBackground[] = {0,0.18,0.61,0.5};
	colorActive[] = {0,0.18,0.61,0.5};
};
class IGUIBack_2202: IGUIBack
{
	idc = 2202;
  type = CT_STATIC;
	x = 0.541263 * safezoneW + safezoneX;
	y = 0.0270386 * safezoneH + safezoneY;
	w = 0.0670526 * safezoneW;
	h = 0.0329973 * safezoneH;
	colorBackground[] = {0.76,0.09,0,0.5};
	colorActive[] = {0.76,0.09,0,0.5};
};
class K0Z_IndActualScore: RscText
{
	idc = 1000;
  type = CT_STATIC;
	text = "5000"; //--- ToDo: Localize;
  style = ST_CENTER;
	x = 0.463895 * safezoneW + safezoneX;
	y = 0.0270386 * safezoneH + safezoneY;
	w = 0.0670526 * safezoneW;
	h = 0.0329973 * safezoneH;
	sizeEx = "0.02 / (getResolution select 5)";	
};
class K0Z_BluActualScore: RscText
{
	idc = 1001;
	text = "5000"; //--- ToDo: Localize;
  style = ST_CENTER;
  type = CT_STATIC;
	x = 0.386526 * safezoneW + safezoneX;
	y = 0.0270386 * safezoneH + safezoneY;
	w = 0.0670526 * safezoneW;
	h = 0.0329973 * safezoneH;
	sizeEx = "0.02 / (getResolution select 5)";	
};
class K0Z_RedActualScore: RscText
{
	idc = 1002;
	text = "5000"; //--- ToDo: Localize;
  style = ST_CENTER;
  type = CT_STATIC;
	x = 0.541263 * safezoneW + safezoneX;
	y = 0.0270386 * safezoneH + safezoneY;
	w = 0.0670526 * safezoneW;
	h = 0.0329973 * safezoneH;
	sizeEx = "0.02 / (getResolution select 5)";	
};
class KOZ_Certs: IGUIBack
{
	idc = 2203;
  type = CT_STATIC;
	x = 0.922947 * safezoneW + safezoneX;
	y = 0.950963 * safezoneH + safezoneY;
	w = 0.0670526 * safezoneW;
	h = 0.0329973 * safezoneH;
	colorBackground[] = {0,0,0,0.5};
	colorActive[] = {0,0,0,0.5};
};
class KOZ_ActualCerts: RscText
{
	idc = 1003;
	text = "Certs: 500"; //--- ToDo: Localize;
  style = ST_CENTER;
  type = CT_STATIC;
	x = 0.922947 * safezoneW + safezoneX;
	y = 0.950963 * safezoneH + safezoneY;
	w = 0.0670526 * safezoneW;
	h = 0.0329973 * safezoneH;
	sizeEx = "0.02 / (getResolution select 5)";	
};

};
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
/* #Lycygu
$[
	1.063,
	["DisplayHUD",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[2200,"KOZ_IndScore",[1,"",["0.463895 * safezoneW + safezoneX","0.0270386 * safezoneH + safezoneY","0.0670526 * safezoneW","0.0329973 * safezoneH"],[-1,-1,-1,-1],[0,0.76,0.12,0.5],[0,0.76,0.12,0.5],"","-1"],[]],
	[2201,"KOZ_BluScore",[1,"",["0.386526 * safezoneW + safezoneX","0.0270386 * safezoneH + safezoneY","0.0670526 * safezoneW","0.0329973 * safezoneH"],[-1,-1,-1,-1],[0,0.18,0.61,0.5],[0,0.18,0.61,0.5],"","-1"],[]],
	[2202,"",[1,"",["0.541263 * safezoneW + safezoneX","0.0270386 * safezoneH + safezoneY","0.0670526 * safezoneW","0.0329973 * safezoneH"],[-1,-1,-1,-1],[0.76,0.09,0,0.5],[0.76,0.09,0,0.5],"","-1"],[]],
	[1000,"K0Z_IndActualScore",[1,"5000",["0.463895 * safezoneW + safezoneX","0.0270386 * safezoneH + safezoneY","0.0670526 * safezoneW","0.0329973 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"K0Z_BluActualScore",[1,"5000",["0.386526 * safezoneW + safezoneX","0.0270386 * safezoneH + safezoneY","0.0670526 * safezoneW","0.0329973 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"K0Z_RedActualScore",[1,"5000",["0.541263 * safezoneW + safezoneX","0.0270386 * safezoneH + safezoneY","0.0670526 * safezoneW","0.0329973 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[2203,"KOZ_Certs",[1,"",["0.922947 * safezoneW + safezoneX","0.950963 * safezoneH + safezoneY","0.0670526 * safezoneW","0.0329973 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.5],[0,0,0,0.5],"","-1"],[]],
	[1003,"KOZ_ActualCerts",[1,"500",["0.922947 * safezoneW + safezoneX","0.950963 * safezoneH + safezoneY","0.0670526 * safezoneW","0.0329973 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by [Vcom]Dominic, v1.063, #Sidoku)
////////////////////////////////////////////////////////
class KOZHUD_2
{
  idd = 1003;
  movingEnable=0;
  duration=1e+011;
  name = "KOZHUD_2_name";
  onLoad = "uiNamespace setVariable ['KOZHUD_2', _this select 0];";
	onUnLoad = "uiNamespace setVariable ['KOZHUD_2', nil]";
  controlsBackground[] = {};
  objects[] = {};
class controls
{
class KOZ_BlackBackGround: IGUIBack
{
	idc = 2201;
	x = 0.438105 * safezoneW + safezoneX;
	y = 0.489001 * safezoneH + safezoneY;
	w = 0.092842 * safezoneW;
	h = 0.0879928 * safezoneH;
	colorBackground[] = {0,0,0,0.5};
	colorActive[] = {0,0,0,0.5};
};
class KOZ_YellowBackGround: IGUIBack
{
	idc = 2200;
	x = 0.448421 * safezoneW + safezoneX;
	y = 0.510999 * safezoneH + safezoneY;
	w = 0.0722105 * safezoneW;
	h = 0.0439964 * safezoneH;
	colorBackground[] = {0.98,0.93,0,0.6};
	colorActive[] = {0.98,0.93,0,0.6};
};
class KOZ_CostText: RscText
{
	idc = 1000;
	text = "Certs Remaining:"; //--- ToDo: Localize;
	x = 0.438105 * safezoneW + safezoneX;
	y = 0.489001 * safezoneH + safezoneY;
	w = 0.092842 * safezoneW;
	h = 0.0219982 * safezoneH;
  style = ST_CENTER;
  type = CT_STATIC;
};
class KOZ_ActualCost: RscText
{
	idc = 1001;
	text = "0"; //--- ToDo: Localize;
	x = 0.448421 * safezoneW + safezoneX;
	y = 0.510999 * safezoneH + safezoneY;
	w = 0.0722105 * safezoneW;
	h = 0.0439964 * safezoneH;
  style = ST_CENTER;
  type = CT_STATIC;
};
class KOZ_Message: RscStructuredText
{
	idc = 1100;
	text = "Leaving this screen will purchase equipped gear!"; //--- ToDo: Localize;
	x = 0.427789 * safezoneW + safezoneX;
	y = 0.576994 * safezoneH + safezoneY;
	w = 0.123474 * safezoneW;
	h = 0.0759946 * safezoneH;
	colorText[] = {0.73,0.01,0,1};
	colorBackground[] = {0.49,0.49,0.49,1};
	colorActive[] = {0.49,0.49,0.49,1};
};
};
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
/* #Sidoku
$[
	1.063,
	["CertsScreen",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[2201,"KOZ_BlackBackGround",[1,"",["0.438105 * safezoneW + safezoneX","0.489001 * safezoneH + safezoneY","0.092842 * safezoneW","0.0879928 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.5],[0,0,0,0.5],"","-1"],[]],
	[2200,"KOZ_YellowBackGround",[1,"",["0.448421 * safezoneW + safezoneX","0.510999 * safezoneH + safezoneY","0.0722105 * safezoneW","0.0439964 * safezoneH"],[-1,-1,-1,-1],[0.98,0.93,0,0.6],[0.98,0.93,0,0.6],"","-1"],[]],
	[1000,"KOZ_CostText",[1,"Certs Remaining:",["0.438105 * safezoneW + safezoneX","0.489001 * safezoneH + safezoneY","0.092842 * safezoneW","0.0219982 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"KOZ_ActualCost",[1,"0",["0.448421 * safezoneW + safezoneX","0.510999 * safezoneH + safezoneY","0.0722105 * safezoneW","0.0439964 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1100,"KOZ_Message",[1,"Leaving this screen will purchase equipped gear!",["0.427789 * safezoneW + safezoneX","0.576994 * safezoneH + safezoneY","0.113474 * safezoneW","0.0659946 * safezoneH"],[0.73,0.01,0,1],[0.49,0.49,0.49,1],[0.49,0.49,0.49,1],"","-1"],[]]
]
*/
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by [Vcom]Dominic, v1.063, #Wugure)
////////////////////////////////////////////////////////

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by [Vcom]Dominic, v1.063, #Biwyci)
////////////////////////////////////////////////////////
class KOZHUD_3
{
  idd = 1004;
  movingEnable=0;
  duration=1e+011;
  name = "KOZHUD_3_name";
  onLoad = "uiNamespace setVariable ['KOZHUD_3', _this select 0];";
	onUnLoad = "uiNamespace setVariable ['KOZHUD_3', nil]";
  controlsBackground[] = {};
  objects[] = {};
class controls
{
class BG_ScreenMessageBox: RscStructuredText
{
	idc = 1100;
	x = 0.29375 * safezoneW + safezoneX;
	y = 0.401 * safezoneH + safezoneY;
	w = 0.4125 * safezoneW;
	h = 0.088 * safezoneH;
};
};
};
class KOZHUD_4
{
  idd = 1005;
  movingEnable=0;
  duration=1e+011;
  name = "KOZHUD_4_name";
  onLoad = "uiNamespace setVariable ['KOZHUD_4', _this select 0];";
	onUnLoad = "uiNamespace setVariable ['KOZHUD_4', nil]";
  controlsBackground[] = {};
  objects[] = {};
class controls
{
class BG_ScreenMessageBox2: RscStructuredText
{
	idc = 1100;
	x = 0.38375 * safezoneW + safezoneX;
	y = 0.316 * safezoneH + safezoneY;
	w = 0.4125 * safezoneW;
	h = 0.088 * safezoneH;
};
};
};
/* #Biwyci
$[
	1.063,
	["BG_ScreenMessage",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1100,"BG_ScreenMessageBox",[1,"",["0.29375 * safezoneW + safezoneX","0.401 * safezoneH + safezoneY","0.4125 * safezoneW","0.088 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////



