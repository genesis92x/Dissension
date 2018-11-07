//This function will create a cargo container that will repair, rearm, and refuel a certain amount of times before being depleted.
if (DIS_PCASHNUM - 1000 < 0) exitWith {systemChat "You lack sufficient funds!";if (playerSide isEqualTo west) then {playsound "EVAInsufficentFunds"} else {playsound "LEGIONInsufficentFunds"};};
if (DIS_AbilityCoolDown) exitWith {systemChat "Abilities still on cool-down.";};
DIS_PCASHNUM = DIS_PCASHNUM - 1000;
DIS_AbilityCoolDown = true;[] spawn {sleep 120;DIS_AbilityCoolDown = false;};
playsound "Purchase";
["FARP Air-Drop inbound!",'#FFFFFF'] call Dis_MessageFramework;

private _Bx = createVehicle ["Land_Cargo20_grey_F", [0,0,600], [], 0, "CAN_COLLIDE"];
private _para = createVehicle ["B_Parachute_02_F", [0,0,600], [], 0, "CAN_COLLIDE"];
_Bx attachTo [_para,[0,0,0]];
private _position = getPosWorld player;
_para setpos [_position select 0,_position select 1,((_position select 2) + 300)];	
_Bx setVariable ["DIS_RearmP",10,true];
_Bx setVariable ["DIS_PLAYERVEH",true,true];
playsound "drop_accomplished";
waitUntil {((getpos _Bx) select 2) < 4};
detach _Bx;

[
[_Bx,(side player)],
{
	params ["_Bx","_Side"];
	if (playerSide isEqualTo _Side) then
	{
		
		#define TARGET _Bx
		#define TITLE "Rearm/Resupply/Refuel Vehicle"
		#define    ICON  "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa"
		#define    PROG_ICON  "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa"
		#define COND_ACTION "true"
		#define COND_PROGRESS "true"
		#define    CODE_START {["Setting up Rearm...",'#FFFFFF'] call Dis_MessageFramework}
		#define    CODE_TICK {}
		#define CODE_END {["Rearm Complete!",'#FFFFFF'] call Dis_MessageFramework;[(_this select 1),(_this select 0)] spawn DIS_fnc_FARPB;}
		#define    CODE_INTERUPT {["Stopped Rearm Setup",'#FFFFFF'] call Dis_MessageFramework;}
		#define    ARGUMENTS []
		#define    DURATION 10
		#define    PRIORITY 1
		#define    REMOVE false
		#define SHOW_UNCON false
		[TARGET,TITLE,ICON,PROG_ICON,COND_ACTION,COND_PROGRESS,CODE_START,CODE_TICK,CODE_END,CODE_INTERUPT,ARGUMENTS,DURATION,PRIORITY,REMOVE,SHOW_UNCON] call bis_fnc_holdActionAdd;		
		
	
		private _Color = "ColorBlue";
		if (playerSide isEqualTo East) then {_Color = "ColorRed";};
		private _m1 = createMarkerLocal [format ["%1",_Bx],(getpos _Bx)];
		_m1 setmarkershapeLocal "ICON";
		_m1 setMarkerTypeLocal "u_installation";
		_m1 setmarkercolorLocal _Color;
		_m1 setmarkersizeLocal [1,1];
		_m1 setMarkerTextLocal "FARP";
		[_m1,_Bx] spawn 
		{
			params ["_m1","_Bx"];
			while {alive _Bx} do
			{
				_m1 setMarkerPosLocal (getposASL _Bx);
				sleep 10;
			};
		};
		waitUntil {!(alive _Bx)};
		deleteMarkerLocal _m1;
	};
	//Have the server remove the JIP function if the FARP is destroyed.
	if (isServer) then
	{
		waitUntil {!(alive _Bx)};
		remoteExec ["", "DIS_JIPFARP"]; 
	};
}

] remoteExec ["BIS_fnc_Spawn",0,"DIS_JIPFARP"];	