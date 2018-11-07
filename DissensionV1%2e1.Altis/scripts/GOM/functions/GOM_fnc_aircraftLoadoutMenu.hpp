//GOM_fnc_aircraftLoadout V1.341 made by Grumpy Old Man 17-5-2017
//this serves as an example how to add the loadout menu as radio comm module

class GOM_aircraftLoadoutMenu
{
    text = "Aircraft Loadout Module";
    submenu = "";
    expression = "[player] spawn GOM_fnc_aircraftLoadout"; // Code executed upon activation
    icon = "\a3\Ui_f\data\gui\Cfg\CommunicationMenu\call_ca.paa"; // Icon displayed permanently next to the command menu
    cursor = "\a3\Ui_f\data\gui\Cfg\CommunicationMenu\call_ca.paa"; // Custom cursor displayed when the item is selected
    enable = "1"; // Simple expression condition for enabling the item
    removeAfterExpressionCall = 0; // 1 to remove the item after calling
};