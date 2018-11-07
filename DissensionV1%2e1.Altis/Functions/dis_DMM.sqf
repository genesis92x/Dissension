//This function switches the Ipad to the "Main Menu"

disableSerialization;

if (isNull (findDisplay 3014)) then
{
	#define dis_IpadMenu	(3014)
	createDialog "dis_IPAD";
	((findDisplay (3014)) displayCtrl 1200) ctrlSetText "Pictures\IPad.paa";  
};

((findDisplay (3014)) displayCtrl (1100)) ctrlSetPosition [0,0];
((findDisplay (3014)) displayCtrl (1100)) ctrlCommit 0;
((findDisplay (3014)) displayCtrl (1500)) ctrlSetEventHandler ["KeyDown","_this call DIS_IMPressed"];

((findDisplay (3014)) displayCtrl 1600) ctrlSetPosition [-0.051,0.5,0.1,0.1];
((findDisplay (3014)) displayCtrl (1600)) ctrlCommit 0;



_MMA = ["----SELECT MENU----","COMMANDER INFO","RECENT ORDERS","CURRENT MISSION","EQUIPMENT PURCHASE","VEHICLE PURCHASE","RANK","GAME INFO","----END MENU----"];

lbClear 1500;

{
	lbAdd [1500,_x];
} foreach _MMA;


_display = (findDisplay 3014) displayCtrl 1500;
_display ctrlSetEventHandler ["LBSelChanged","[_this select 0,_this select 1] call dis_IpadLBChangedMM"];

lbSetCurSel [1500, 0];
lbSetCurSel [1500, -1];
_DI = "SELECT A MENU";
((findDisplay (3014)) displayCtrl (1100)) ctrlSetPosition [0,0];
((findDisplay (3014)) displayCtrl (1100)) ctrlCommit 0;
((findDisplay (3014)) displayCtrl (1100)) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>%1</t></t></t>",_DI]);	
