//Function that allows the player to construct two sandbags.
if (DIS_PCASHNUM - 250 < 0) exitWith {systemChat "You lack sufficient funds!";if (playerSide isEqualTo west) then {playsound "EVAInsufficentFunds"} else {playsound "LEGIONInsufficentFunds"};};
if (DIS_AbilityCoolDown) exitWith {systemChat "Abilities still on cool-down.";};
DIS_PCASHNUM = DIS_PCASHNUM - 250;
playsound "Purchase";
DIS_AbilityCoolDown = true;[] spawn {sleep 120;DIS_AbilityCoolDown = false;};
["Sandbags purchased.",'#FFFFFF'] call Dis_MessageFramework;

if (isNil "DIS_FortificationArray") then
{
	DIS_FortificationArray = [];
};	

private _str = "Land_BagFence_Long_F";
for "_i" from 0 to 9 step 1 do 
{
	DIS_FortificationArray pushback _str;
};

DIS_DIGINACT = true;
[] spawn {sleep 60;DIS_DIGINACT = false;};
[] spawn DIS_fnc_DeployFortification;