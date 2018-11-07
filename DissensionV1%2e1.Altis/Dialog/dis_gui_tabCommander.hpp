#define true 1
#define false 0

class RscDisTabCommander
{
    idd= 32000;
    movingEnable = false;
    enableSimulation = true;
    fadein=0;
    duration = 1e+011;
    fadeout=0;
    onLoad= "";

    controlsBackground[]={};
    controls[]=
    {
        RscCommandMap,
        RscTextInfo,
        RscOrdersText,
        RscOrdersListBox,
        RscMissionsText,
        RscMissionsListBox,
        RscAcceptMissionBtn
    };
    objects[]={};

    class RscCommandMap: RscMapControl
{
    access = 0;
    idc = 32100;
    type = CT_MAP_MAIN;
    style = ST_PICTURE;
    x = 0.44 * safezoneW + safezoneX;
    y = 0.22 * safezoneH + safezoneY;
    w = 0.35725 * safezoneW;
    h = 0.5 * safezoneH;
    colorBackground[] = {1.00, 1.00, 1.00, 1.00};
    colorText[] = {0.00, 0.00, 0.00, 1.00};
    scaleDefault = 0.1;
    onMouseButtonClick = "";
    onMouseButtonDblClick = "";
		class LineMarker
		{
				lineWidthThin = 0.008;
				lineWidthThick = 0.014;
				lineDistanceMin = 3e-005;
				lineLengthMin = 5;
		};			
};
class RscTextInfo: RscControlsGroup
    {
        idc = 32200;
        x = 0.2025* safezoneW + safezoneX;
        y = 0.22 * safezoneH + safezoneY;
        w = 0.235 * safezoneW;
        h = 0.23 * safezoneH;
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
                idc = 32201;
                x = 0;
                y = 0;
                w = 0.22975 * safezoneW;
                h = 1;
                text = "";
                colorText[] = {1,1,1,1};
                shadow = 0;
                colorBackground[] = {0,0,0,0.5};
            };

        };
    };
class RscOrdersText: RscStructuredText
{
    idc = 32300;
    colorText[] = {1,1,1,1};
    colorBackground[] = {0,0,0,0};
    x = 0.2025* safezoneW + safezoneX;
    y = 0.4525 * safezoneH + safezoneY;
    w = 0.11625 * safezoneW;
    h = 0.03 * safezoneH;
    text = "";
};
class RscOrdersListBox: RscListBox
{
    idc = 32301;
    x = 0.2025* safezoneW + safezoneX;
    y = 0.475 * safezoneH + safezoneY;
    w = 0.11625 * safezoneW;
    h = 0.245 * safezoneH;
    style = 16;
    font = "PuristaMedium";
    sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    shadow = 0;
    colorShadow[] = {0,0,0,0.5};
    period = 1.2;
    maxHistoryDelay = 1;
    rowHeight = 0;
    onLBSelChanged  = "_this call dis_fnc_TabOrderSel;";
    colorText[] ={1,1,1,1};
    colorDisabled[] ={1,1,1,0.25};
    colorScrollbar[] ={1,1,1,0.6};
    colorSelect[] = {0,0,0,1};
    colorSelect2[] = {0,0,0,1};
    colorSelectBackground[] = {0.95,0.95,0.95,1};
    colorSelectBackground2[] = {1,1,1,0.5};
    colorTextRight[] = {1,1,1,1};
    colorSelectRight[] = {0,0,0,1};
    colorSelect2Right[] = {0,0,0,1};
    colorBackground[] = {0,0,0,0.5};
    class ListScrollBar : RscTreeScrollBar
    {
        idc = -1;
        color[] = {1,1,1,0.5};
        width = 0;
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


};
class RscMissionsText: RscStructuredText
{
    idc = 32400;
    colorText[] = {1,1,1,1};
    colorBackground[] = {0,0,0,0};
    x = 0.32125 * safezoneW + safezoneX;
    y = 0.4525 * safezoneH + safezoneY;
    w = 0.11625 * safezoneW;
    h = 0.03 * safezoneH;
    text = "";
};
class RscMissionsListBox: RscListBox
{
    idc = 32401;
    x = 0.32125* safezoneW + safezoneX;
    y = 0.475 * safezoneH + safezoneY;
    w = 0.11625 * safezoneW;
    h = 0.245 * safezoneH;
    style = 16;
    font = "PuristaMedium";
    sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    shadow = 0;
    colorShadow[] = {0,0,0,0.5};
    period = 1.2;
    maxHistoryDelay = 1;
    rowHeight = 0;
    onLBSelChanged  = "_this call dis_fnc_TabMissionSel";
    colorText[] ={1,1,1,1};
    colorDisabled[] ={1,1,1,0.25};
    colorScrollbar[] ={1,1,1,0.6};
    colorSelect[] = {0,0,0,1};
    colorSelect2[] = {0,0,0,1};
    colorSelectBackground[] = {0.95,0.95,0.95,1};
    colorSelectBackground2[] = {1,1,1,0.5};
    colorTextRight[] = {1,1,1,1};
    colorSelectRight[] = {0,0,0,1};
    colorSelect2Right[] = {0,0,0,1};
    colorBackground[] = {0,0,0,0.5};
    arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
    arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
    class ListScrollBar : RscTreeScrollBar
    {
        idc = -1;
        color[] = {1,1,1,0.5};
        width = 0.021;
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
};
class RscAcceptMissionBtn: RscActiveText
{
    idc = 32402;
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
    action = "call DIS_fnc_AcceptMission;";
		
    text= "\A3\ui_f\data\map\diary\icons\tasksucceeded_ca.paa";
    tooltip = "Accept Mission";
    default = true;
};

};