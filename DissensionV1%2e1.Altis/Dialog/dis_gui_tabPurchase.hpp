#define true 1
#define false 0

class RscDisTabPurchase
{
    idd= 30000;
    movingEnable = false;
    enableSimulation = true;
    fadein=0;
    duration = 1e+011;
    fadeout=0;
		onLoad = "uiNamespace setVariable ['DIS_TABPURC',_this select 0]";
		onUnload = "uiNamespace setVariable ['DIS_TABPURC',nil]";

    controlsBackground[]={};
    controls[]=
    {
        RscListBack,
        RscOpenArsenalBtn,
        RscVehsBtn,
        RscUnitsBtn,
        RscStructuresBtn,
        RscVehTree,
        RscVehBuyBtn,
        RscUnitsTree,
        RscUnitPic,
        RscRecruitBtn,
        RscRecruitGrpBtn,
        RscStructuresTree,
        RscStrucBuyBtn,
        RscTextInfoL,
        RscTextInfoR
    };
    objects[]={RscVehObj};


class RscListBack: IGUIBack
{
    idc = -1;
    x = 0.2025* safezoneW + safezoneX;
    y = 0.22 * safezoneH + safezoneY;
    w = 0.155 * safezoneW;
    h = 0.45 * safezoneH;
    colorBackground[] = {0,0,0,0.5};
};

class RscOpenArsenalBtn: RscActiveText
{
    idc = 30100;
    x = 0.2095 * safezoneW + safezoneX;
    y = 0.68 * safezoneH + safezoneY;
    w = 0.03 * safezoneW;
    h = 0.04 * safezoneH;
    color[] = {1,1,1,1};
    colorActive[] = {1,1,1,0.75};
    colorDisabled[] = {1,1,1,0};
    soundEnter[] = { "", 0, 1 };   // no sound
    soundPush[] = { "", 0, 1 };
    soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
    soundEscape[] = { "", 0, 1 };
    action = "";
    text= "\A3\ui_f\data\igui\cfg\simpletasks\types\rifle_ca.paa";
    tooltip = "Arsenal";
    default = true;
};
class RscVehsBtn: RscActiveText
{
    idc = 30200;
    x = 0.2465* safezoneW + safezoneX;
    y = 0.68 * safezoneH + safezoneY;
    w = 0.03 * safezoneW;
    h = 0.04 * safezoneH;
    color[] = {1,1,1,1};
    colorActive[] = {1,1,1,0.75};
    colorDisabled[] = {1,1,1,0};
    soundEnter[] = { "", 0, 1 };   // no sound
    soundPush[] = { "", 0, 1 };
    soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
    soundEscape[] = { "", 0, 1 };
    action = "[30201,30500] call dis_fnc_TabSwitchPurchTab";
    text= "\A3\Soft_F\MRAP_01\Data\UI\MRAP_01_Base_ca.paa";
    tooltip = "Vehicles";
    default = true;
};
class RscUnitsBtn: RscActiveText
{
    idc = 30300;
    x = 0.2835 * safezoneW + safezoneX;
    y = 0.68 * safezoneH + safezoneY;
    w = 0.03 * safezoneW;
    h = 0.04 * safezoneH;
    color[] = {1,1,1,1};
    colorActive[] = {1,1,1,0.75};
    colorDisabled[] = {1,1,1,0};
    soundEnter[] = { "", 0, 1 };   // no sound
    soundPush[] = { "", 0, 1 };
    soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
    soundEscape[] = { "", 0, 1 };
    action = "[30600,30601,30602,30603] call dis_fnc_TabSwitchPurchTab";
    text= "\A3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_toolbox_groups_ca.paa";
    tooltip = "Units";
    default = true;
};
class RscStructuresBtn: RscActiveText
{
    idc = 30400;
    x = 0.3205 * safezoneW + safezoneX;
    y = 0.68 * safezoneH + safezoneY;
    w = 0.03 * safezoneW;
    h = 0.04 * safezoneH;
    color[] = {1,1,1,1};
    colorActive[] = {1,1,1,0.75};
    colorDisabled[] = {1,1,1,0};
    soundEnter[] = { "", 0, 1 };   // no sound
    soundPush[] = { "", 0, 1 };
    soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
    soundEscape[] = { "", 0, 1 };
    action = "[30700,30701] call dis_fnc_TabSwitchPurchTab";
    text= "\A3\ui_f\data\map\mapcontrol\Tourism_CA.paa";
    tooltip = "Structures";
    default = true;
};
class RscVehBuyBtn: RscActiveText
{
    idc = 30500;
    x = 0.4425 * safezoneW + safezoneX;
    y = 0.73 * safezoneH + safezoneY;
    w = 0.0225 * safezoneW;
    h = 0.03 * safezoneH;
    color[] = {1,1,1,1};
    colorActive[] = {1,1,1,0.75};
    colorDisabled[] = {1,1,1,0};
    soundEnter[] = { "", 0, 1 };   // no sound
    soundPush[] = { "", 0, 1 };
    soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
    soundEscape[] = { "", 0, 1 };
    action = "call dis_fnc_TabPurchVeh;";
    text= "\A3\ui_f\data\map\diary\icons\tasksucceeded_ca.paa";
    tooltip = "Purchase Vehicle";
    default = true;
};
class RscVehTree : RscTree
    {
        idc = 30201;
        x = 0.195 * safezoneW + safezoneX;
        y = 0.215 * safezoneH + safezoneY;
        w = 0.1625 * safezoneW;
        h = 0.455 * safezoneH;
        sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
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
        onTreeSelChanged = "_this spawn dis_fnc_TabVehSel;";
        onTreeLButtonDown = "";
        onTreeDblClick = "";
        onTreeExpanded = "";
        onTreeCollapsed = "";
        onTreeMouseMove = "";
        onTreeMouseHold = "";
        onTreeMouseExit = "";
        class ScrollBar: RscTreeScrollBar{};
    };
class RscVehObj :  RscObject
{
    idc = 30202;
    type = 81;
    enableZoom = 1;
    model = "\A3\Air_F_Exp\VTOL_01\VTOL_01_armed_F.p3d";
    scale = 1;
    x = 0.575 * safezoneW + safezoneX;
    y = 0.325 * safezoneH + safezoneY;
    z = 40;
    direction[] = {0.25,0,0};
    up[] = {0,1,0};
    tooltip = "";
    tooltipColorShade[] = {0,0,0,1};
    tooltipColorText[] = {1,1,1,1};
    tooltipColorBox[] = {1,1,1,1};
    onMouseMoving = "";
    onMouseHolding = "";
    onMouseDown = "";

};
class RscTextInfoL: RscControlsGroup
    {
        idc = 30301;
        x = 0.3625 * safezoneW + safezoneX;
        y = 0.5 * safezoneH + safezoneY;
        w = 0.21625 * safezoneW;
        h = 0.22 * safezoneH;
        class VScrollbar
        {
            idc = 20;
            color[] = {1,1,1,0.5};
            width = 0.0125;
            autoScrollEnabled = 0;
            autoScrollSpeed = 0;
            autoScrollRewind = 0;
            colorActive[] = {1,1,1,1};
            colorDisabled[] = {1,1,1,0.3};
            thumb = "#(argb,8,8,3)color(0,0,0,1)";
            arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
            arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
            border = "#(argb,8,8,3)color(1,1,1,1)";
        };
        sizeEx = 0.02;
        class Controls
        {
            class textScrolltext: RscStructuredText
            {
                idc = 30302;
                x = 0;
                y = 0;
                w = 0.209 * safezoneW;
                h = 1;
                text = "";
                colorText[] = {1,1,1,1};
                shadow = 0;
                colorBackground[] = {0,0,0,0.5};
            };

        };
    };
class RscTextInfoR: RscControlsGroup
    {
        idc = 30401;
        x = 0.581 * safezoneW + safezoneX;
        y = 0.5 * safezoneH + safezoneY;
        w = 0.21625 * safezoneW;
        h = 0.22 * safezoneH;
        class VScrollbar
        {
            idc = 20;
            color[] = {1,1,1,0.5};
            width = 0.0125;
            autoScrollEnabled = 0;
            autoScrollSpeed = 0;
            autoScrollRewind = 0;
            colorActive[] = {1,1,1,1};
            colorDisabled[] = {1,1,1,0.3};
            thumb = "#(argb,8,8,3)color(0,0,0,1)";
            arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
            arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
            border = "#(argb,8,8,3)color(1,1,1,1)";
        };
        sizeEx = 0.02;
        class Controls
        {
            class textScrolltext: RscStructuredText
            {
                idc = 30402;
                x = 0;
                y = 0;
                w = 0.209 * safezoneW;
                h = 1;
                text = "";
                colorText[] = {1,1,1,1};
                shadow = 0;
                colorBackground[] = {0,0,0,0.5};
            };

        };
    };
class RscUnitsTree : RscTree
    {
        idc = 30600;
        x = 0.195 * safezoneW + safezoneX;
        y = 0.215 * safezoneH + safezoneY;
        w = 0.1625 * safezoneW;
        h = 0.455 * safezoneH;
        sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
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
        onTreeSelChanged = "_this call dis_fnc_TabUnitSel";
        onTreeLButtonDown = "";
        onTreeDblClick = "";
        onTreeExpanded = "";
        onTreeCollapsed = "";
        onTreeMouseMove = "";
        onTreeMouseHold = "";
        onTreeMouseExit = "";
        class ScrollBar: RscTreeScrollBar{};
    };
class RscUnitPic : RscPicture
    {
        idc = 30601;
        colorBackground[] = {0,0,0,1};
        colorText[] = {1,1,1,1};
        text = "";
        x = 0.44125 * safezoneW + safezoneX;
        y = 0.22 * safezoneH + safezoneY;
        w = 0.275 * safezoneW;
        h = 0.275 * safezoneH;
    };
class RscRecruitBtn: RscShortcutButton
{
    idc = 30602;
    text = "Recruit Unit";
    colorBackground[] = {0.4,0.4,0.4,1};
    colorBackground2[] = {0.4,0.4,0.4,1};
    colorBackgroundFocused[] = {0.4,0.4,0.4,1};
    colorFocused[] = {1,1,1,1};
    onButtonClick  = "[1] call Dis_fnc_recruitSel";
    x = 0.4425 * safezoneW + safezoneX;
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
		tooltip = "This feature has currently been REMOVED";
};
class RscRecruitGrpBtn: RscShortcutButton
{
    idc = 30603;
    text = "Recruit into group";
    colorBackground[] = {0.4,0.4,0.4,1};
    colorBackground2[] = {0.4,0.4,0.4,1};
    colorBackgroundFocused[] = {0.4,0.4,0.4,1};
    colorFocused[] = {1,1,1,1};
     onButtonClick  = "[1] call Dis_fnc_recruitSel;";
    x = 0.5225 * safezoneW + safezoneX;
    y = 0.73 * safezoneH + safezoneY;
    w = 0.125 * safezoneW;
    h = 0.03 * safezoneH;
    size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
        class TextPos
    {
        left = 0;
        top = 0;
        right = 0;
        bottom = 0;
    };
		tooltip = "Recruit an AI unit into your direct squad. YOU MUST BE THE LEADER OF A SQUAD TO DO THIS.";
};
class RscStructuresTree : RscTree
    {
        idc = 30700;
        x = 0.195 * safezoneW + safezoneX;
        y = 0.215 * safezoneH + safezoneY;
        w = 0.1625 * safezoneW;
        h = 0.455 * safezoneH;
        sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
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
        onTreeSelChanged = "_this spawn dis_fnc_TabStructSel;";
        onTreeLButtonDown = "";
        onTreeDblClick = "";
        onTreeExpanded = "";
        onTreeCollapsed = "";
        onTreeMouseMove = "";
        onTreeMouseHold = "";
        onTreeMouseExit = "";
        class ScrollBar: RscTreeScrollBar{};
    };
    class RscStrucBuyBtn: RscActiveText
    {
        idc = 30701;
        x = 0.4425 * safezoneW + safezoneX;
        y = 0.73 * safezoneH + safezoneY;
        w = 0.0225 * safezoneW;
        h = 0.03 * safezoneH;
        color[] = {1,1,1,1};
        colorActive[] = {1,1,1,0.75};
        colorDisabled[] = {1,1,1,0};
        soundEnter[] = { "", 0, 1 };   // no sound
        soundPush[] = { "", 0, 1 };
        soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
        soundEscape[] = { "", 0, 1 };
        action = "call dis_fnc_TabPurchStruc;";
        text= "\A3\ui_f\data\map\diary\icons\tasksucceeded_ca.paa";
        tooltip = "Purchase Structure";
        default = true;
    };

};