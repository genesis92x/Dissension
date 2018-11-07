//Function that drops ammo for the player. Personalized only, for currently held primary weapon.

//Find players primary weapon
private _Weap = primaryWeapon player;
if (_Weap isEqualTo "") exitWith {systemChat "You have no weapon!";};
if (DIS_PCASHNUM - 150 < 0) exitWith {systemChat "You lack sufficient funds!";if (playerSide isEqualTo west) then {playsound "EVAInsufficentFunds"} else {playsound "LEGIONInsufficentFunds"};};
if (DIS_AbilityCoolDown) exitWith {systemChat "Abilities still on cool-down.";};
DIS_PCASHNUM = DIS_PCASHNUM - 150;
DIS_AbilityCoolDown = true;[] spawn {sleep 120;DIS_AbilityCoolDown = false;};
playsound "Purchase";
["Personal Air Drop In-bound",'#FFFFFF'] call Dis_MessageFramework;
private _mags = getArray (configFile / "CfgWeapons" / _Weap / "magazines");
private _mag = _mags select 0;

private _Bx1 = createVehicle ["Land_WoodenCrate_01_F", [0,0,600], [], 0, "CAN_COLLIDE"];
private _para = createVehicle ["B_Parachute_02_F", [0,0,600], [], 0, "CAN_COLLIDE"];
_Bx1 attachTo [_para,[0,0,0]];
[_Bx1] spawn {params ["_Bx1"];sleep 900;if (alive _Bx1) then {deleteVehicle _Bx1;}};
_Bx1 setVariable ["DIS_PLAYERVEH",true,true];
private _position = getPosWorld player;
_para setpos [_position select 0,_position select 1,((_position select 2) + 300)];	
playsound "drop_accomplished";
waitUntil {((getpos _Bx1) select 2) < 2.5};
detach _Bx1;

[
[_Bx1,_mag],
{
	params ["_Bx1","_mag"]; 
	#define TARGET _Bx1
	#define TITLE "Open Crate"
	#define    ICON  "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa"
	#define    PROG_ICON  "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa"
	#define COND_ACTION "true"
	#define COND_PROGRESS "true"
	#define    CODE_START {["Opening Crate...",'#FFFFFF'] call Dis_MessageFramework}
	#define    CODE_TICK {}
	#define CODE_END {["Crate Opened!",'#FFFFFF'] call Dis_MessageFramework;private _A1 = createVehicle ["Land_ammobox_rounds_F", (getpos (_this select 0)), [], 0, "CAN_COLLIDE"];private _supply = "Supply500" createVehicle [0,0,0];_supply attachTo [_A1, [0,0,0.5]];_supply addMagazineCargoGlobal [((_this select 3) select 1), 6];deleteVehicle (_this select 0);[_A1,_supply] spawn {params ["_A1","_Supply"];sleep 900;if (alive _A1) then {deleteVehicle _A1;deleteVehicle _Supply;};};}
	#define    CODE_INTERUPT {["Stopped Opening Crate",'#FFFFFF'] call Dis_MessageFramework;}
	#define    ARGUMENTS [_Bx1,_mag]
	#define    DURATION 5
	#define    PRIORITY 1
	#define    REMOVE false
	#define SHOW_UNCON false
	[TARGET,TITLE,ICON,PROG_ICON,COND_ACTION,COND_PROGRESS,CODE_START,CODE_TICK,CODE_END,CODE_INTERUPT,ARGUMENTS,DURATION,PRIORITY,REMOVE,SHOW_UNCON] call bis_fnc_holdActionAdd;		
	
	if (player distance2D _Bx1 < 2100) then
	{
		private _m1 = createmarkerlocal [format ["%1",_Bx1],(getpos _Bx1)];
		_m1 setMarkerShapeLocal "ICON";
		_m1 setMarkerTypeLocal "u_installation";
		_m1 setMarkerColorLocal "ColorWhite";
		_m1 setMarkerSizeLocal [1,1];
		waitUntil {!(alive _Bx1)};
		deleteMarkerLocal _m1;
	};
}

] remoteExec ["BIS_fnc_Spawn",0];	

private _Img = MISSION_ROOT + "Pictures\ActionMenu_ca.paa";
[str _Bx1, "onEachFrame", 
{
	params ["_Img","_Bx1"];
	if (alive _Bx1 && player distance2D _Bx1 < 600) then
	{
		_pos2 = visiblePositionASL _Bx1;
		_pos2 set [2, ((_Bx1 modelToWorld [0,0,0]) select 2) + 0.25];
		call compile format 
		[
		'
		drawIcon3D
		[
			%1,
			[1,1,1,0.4],
			%2,
			0.75,
			0.75,
			0,
			"Ammo Box",
			1,
			0.04,
			"RobotoCondensed",
			"center",
			false
		];
		'
		,str _Img,_pos2
		]
	}
	else
	{
		[str _Bx1, "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
	};
},
[_Img,_Bx1]
] call BIS_fnc_addStackedEventHandler;














