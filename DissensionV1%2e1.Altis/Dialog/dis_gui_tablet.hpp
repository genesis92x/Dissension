#define true 1
#define false 0

class RscDisTablet
{
    idd= 27000;
    movingEnable = false;
    enableSimulation = true;
    fadein=0;
    duration = 1e+011;
    fadeout=0;
    onLoad= "";
    onUnload= "[] call dis_fnc_TabClose;";

    controlsBackground[]={};
    controls[]=
    {
        RscTabletBack,
        RscToolBarBack,
        RscTabletPowerBtn,
        RscPlayerInfo,
        RscPlayerBtn,
        RscCommanderBtn,
        RscPurchaseBtn,
        RscTabletInfo
    };
    objects[]={};

class RscTabletBack : RscPicture
    {
        idc = 27001;
        colorBackground[] = {0,0,0,1};
        colorText[] = {1,1,1,1};
        text = "Pictures\sTab_dissension.paa";
        x = 0.125 * safezoneW + safezoneX;
        y = 0.125 * safezoneH + safezoneY;
        w = 0.75 * safezoneW;
        h = 0.75 * safezoneH;
    };
class RscToolBarBack: IGUIBack
{
    idc = -1;
    x = 0.20 * safezoneW + safezoneX;
    y = 0.725 * safezoneH + safezoneY;
    w = 0.6 * safezoneW;
    h = 0.04 * safezoneH;
    colorBackground[] = {0,0,0,0.75};
};

class RscTabletPowerBtn: RscActiveText
{
    idc = 27002;
    x = 0.6425 * safezoneW + safezoneX;
    y = 0.8 * safezoneH + safezoneY;
    w = 0.03 * safezoneW;
    h = 0.04 * safezoneH;
    color[] = {1,1,1,0};
    colorActive[] = {1,1,1,0};
    colorDisabled[] = {1,1,1,0};
    soundEnter[] = { "", 0, 1 };   // no sound
    soundPush[] = { "", 0, 1 };
    soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
    soundEscape[] = { "", 0, 1 };
    action = "closeDialog 2";
    text= "Pictures\sTab_dissension.paa";
    tooltip = "Power";
    default = true;
};

class RscPlayerBtn: RscShortcutButton
{
    idc = 27300;
    text = "Player";
    colorBackground[] = {0.4,0.4,0.4,1};
    colorBackground2[] = {0.4,0.4,0.4,1};
    colorBackgroundFocused[] = {0.4,0.4,0.4,1};
    colorFocused[] = {1,1,1,1};
    onButtonClick  = "_this spawn dis_fnc_TabPlrOpen;";
    x = 0.2025 * safezoneW + safezoneX;
    y = 0.73 * safezoneH + safezoneY;
    w = 0.075 * safezoneW;
    h = 0.03 * safezoneH;
    size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
        class TextPos
    {
        left = 0;
        top = 0;
        right = 0;
        bottom = 0;
    };
};
class RscCommanderBtn: RscShortcutButton
{
    idc = 27301;
    text = "Commander";
    colorBackground[] = {0.4,0.4,0.4,1};
    colorBackground2[] = {0.4,0.4,0.4,1};
    colorBackgroundFocused[] = {0.4,0.4,0.4,1};
    colorFocused[] = {1,1,1,1};
    onButtonClick  = "_this call dis_fnc_TabCommanderOpen;";
    x = 0.2825 * safezoneW + safezoneX;
    y = 0.73 * safezoneH + safezoneY;
    w = 0.075 * safezoneW;
    h = 0.03 * safezoneH;
    size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
        class TextPos
    {
        left = 0;
        top = 0;
        right = 0;
        bottom = 0;
    };
};
class RscPurchaseBtn: RscShortcutButton
{
    idc = 27302;
    text = "Equipment";
    colorBackground[] = {0.4,0.4,0.4,1};
    colorBackground2[] = {0.4,0.4,0.4,1};
    colorBackgroundFocused[] = {0.4,0.4,0.4,1};
    colorFocused[] = {1,1,1,1};
    onButtonClick  = "_this call dis_fnc_TabPurchOpen;";
    x = 0.3625 * safezoneW + safezoneX;
    y = 0.73 * safezoneH + safezoneY;
    w = 0.075 * safezoneW;
    h = 0.03 * safezoneH;
    size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
        class TextPos
    {
        left = 0;
        top = 0;
        right = 0;
        bottom = 0;
    };
};

class RscPlayerInfo: RscStructuredText
{
    idc = 27400;
    colorText[] = {1,1,1,1};
    colorBackground[] = {1,0,0,0};
    class Attributes
    {
        font = "RobotoCondensed";
        color = "#ffffff";
        align = "left";
        shadow = 1;
    };
        x = 0.58 * safezoneW + safezoneX;
        y = 0.73 * safezoneH + safezoneY;
        w = 0.215 * safezoneW;
        h = 0.03 * safezoneH;
    text = "";
    size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
    shadow = 1;
};
class RscTabletInfo: RscStructuredText
{
    idc = 27500;
    colorText[] = {0.5,0.5,0.5,0.25};
    class Attributes
    {
        font = "RobotoCondensed";
        color = "#ffffff";
        align = "center";
        shadow = 1;
    };
        x = 0.2 * safezoneW + safezoneX;
        y = 0.80 * safezoneH + safezoneY;
        w = 0.4 * safezoneW;
        h = 0.03 * safezoneH;
    text = "";
    size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
    shadow = 1;
};


};