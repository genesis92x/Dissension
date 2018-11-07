//Function for the players requesting assistance from AI commander.
if (DIS_PCASHNUM - 350 < 0) exitWith {systemChat "You lack sufficient funds!";if (playerSide isEqualTo west) then {playsound "EVAInsufficentFunds"} else {playsound "LEGIONInsufficentFunds"};};
if (DIS_AbilityCoolDown) exitWith {systemChat "Abilities still on cool-down.";};
DIS_PCASHNUM = DIS_PCASHNUM - 350;
DIS_AbilityCoolDown = true;[] spawn {sleep 120;DIS_AbilityCoolDown = false;};
playsound "Purchase";
["The commander is considering your request for support on your position...Check 'Recent Orders' for the outcome.",'#FFFFFF'] call Dis_MessageFramework;

private _pos = getpos player;
[
[_pos,(name player),(side (group player))],
{
	params ["_pos","_player","_grp"];
	private _AdditionalMessage = format ["Support requested by %1. Considering request...Look for a recruitment message if the request is approved.",_player];
	//[Side,Inf,Light,Heavy,Heli,Air,_TargetLoc,_AdditionalMessage,IgnoreLimits] spawn dis_recruitunits;
	if (_grp isEqualTo West) then
	{
		[West,12,1,1,1,1,_pos,_AdditionalMessage,true] spawn dis_recruitunits;
	}
	else
	{
		[East,12,1,1,1,1,_pos,_AdditionalMessage,true] spawn dis_recruitunits;
	};
}
	
] remoteExecCall ["BIS_fnc_call",2];