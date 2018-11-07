#define true 1
#define false 0

class RscDisTabPlayer
{
    idd= 33000;
    movingEnable = false;
    enableSimulation = true;
    fadein=0;
    duration = 1e+011;
    fadeout=0;
    onLoad= "";

    controlsBackground[]={};
    controls[]=
    {
        RscPlayerInfo,
        RscServerInfo,
        RscInfoSwitchBtn,
        RscRequestsListBox,
        RscPlayersListBox,
        RscRequestInfo,
        RscViewPlr,
        RscConfirmBtn,
        RscMoneyEdit
    };
    objects[]={};


class RscPlayerInfo: RscControlsGroup
{
    idc = 33100;
    x = 0.2025* safezoneW + safezoneX;
    y = 0.22 * safezoneH + safezoneY;
    w = 0.235 * safezoneW;
    h = 0.5 * safezoneH;
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
            idc = 33101;
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
class RscServerInfo: RscControlsGroup
{
    idc = 33200;
    x = 0.2025* safezoneW + safezoneX;
    y = 0.22 * safezoneH + safezoneY;
    w = 0.235 * safezoneW;
    h = 0.5 * safezoneH;
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
            idc = 33201;
            x = 0;
            y = 0;
            w = 0.22975 * safezoneW;
            h = 15;
            text = "";
            colorText[] = {1,1,1,1};
            shadow = 0;
            colorBackground[] = {0,0,0,0.5};
        };

    };
};
class RscInfoSwitchBtn: RscShortcutButton
{
    idc = 33300;
    x = 0.4435 * safezoneW + safezoneX;
    y = 0.73 * safezoneH + safezoneY;
    w = 0.028 * safezoneW;
    h = 0.03 * safezoneH;
    text = "INFO";
    tooltip = "Switch Info";
    colorBackground[] = {0.4,0.4,0.4,1};
    colorBackground2[] = {0.4,0.4,0.4,1};
    colorBackgroundFocused[] = {0.4,0.4,0.4,1};
    colorFocused[] = {1,1,1,1};
    onButtonClick  = "_this call dis_fnc_TabSwitchPlrInfo;";
    size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
        class TextPos
    {
        left = 0;
        top = 0;
        right = 0;
        bottom = 0;
    };
};
class RscRequestsListBox: RscListBox
{
    idc = 34000;
    x = 0.44 * safezoneW + safezoneX;
    y = 0.22 * safezoneH + safezoneY;
    w = 0.15 * safezoneW;
    h = 0.2475 * safezoneH;
    style = 16;
    font = "PuristaMedium";
    sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    shadow = 0;
    colorShadow[] = {0,0,0,0.5};
    period = 1.2;
    maxHistoryDelay = 1;
    rowHeight = 0;
    onLBSelChanged  = "_this call dis_fnc_TabRequestSel";
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
class RscPlayersListBox: RscListBox
{
    idc = 35000;
    x = 0.44 * safezoneW + safezoneX;
    y = 0.4725 * safezoneH + safezoneY;
    w = 0.15 * safezoneW;
    h = 0.2475 * safezoneH;
    style = 16;
    font = "PuristaMedium";
    sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    shadow = 0.25;
    colorShadow[] = {0,0,0,0.5};
    period = 1.2;
    maxHistoryDelay = 1;
    rowHeight = 0;
    onLBSelChanged  = "";
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
class RscRequestInfo: RscControlsGroup
{
    idc = 36000;
    x = 0.5925 * safezoneW + safezoneX;
    y = 0.22 * safezoneH + safezoneY;
    w = 0.20475 * safezoneW;
    h = 0.2125 * safezoneH;
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
            idc = 36001;
            x = 0;
            y = 0;
            w = 0.1995 * safezoneW;
            h = 1;
            text = "";
            colorText[] = {1,1,1,1};
            shadow = 0;
            colorBackground[] = {0,0,0,0.5};
        };

    };
};
class RscViewPlr : RscPicture
    {
        idc = 37000;
        colorBackground[] = {0,0,0,1};
        colorText[] = {1,1,1,1};
        text = "";
        x = 0.5925 * safezoneW + safezoneX;
        y = 0.4725 * safezoneH + safezoneY;
        w = 0.20475 * safezoneW;
        h = 0.2475 * safezoneH;
    };
class RscConfirmBtn: RscShortcutButton
{
    idc = 38000;
    text = "Confirm";
    colorBackground[] = {0.4,0.4,0.4,1};
    colorBackground2[] = {0.4,0.4,0.4,1};
    colorBackgroundFocused[] = {0.4,0.4,0.4,1};
    colorFocused[] = {1,1,1,1};
    onButtonClick  = "call dis_fnc_TabReqConfirm";
    x = 0.72 * safezoneW + safezoneX;
    y = 0.435 * safezoneH + safezoneY;
    w = 0.075 * safezoneW;
    h = 0.03 * safezoneH;
    size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
        class TextPos
    {
        left = 0;
        top = -0.0025;
        right = 0;
        bottom = 0;
    };
};
class RscMoneyEdit: RscEdit
{
    idc = 39000

    x = 0.5925 * safezoneW + safezoneX;
    y = 0.4365 * safezoneH + safezoneY;
    h = 0.0225 * safezoneW;
    w = 0.165 * safezoneH;
    colorBackground[] = {0,0,0,0.5};
    colorText[] = {0.95,0.95,0.95,1};
    colorDisabled[] = {1,1,1,1};
    colorSelection[] = {0,0,0,1};
    autocomplete = "";
    text = "Enter Amount";
    size = 1;
    style = 528
    font = "PuristaMedium";
    shadow = 0;
    sizeEx = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    canModify = 1;
};
};