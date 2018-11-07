//Function that drops ammo for the player's group. Only for currently held primary weapon.
private _SquadUnits = units (group player);
if (DIS_PCASHNUM - 500 < 0) exitWith {systemChat "You lack sufficient funds!";if (playerSide isEqualTo west) then {playsound "EVAInsufficentFunds"} else {playsound "LEGIONInsufficentFunds"};};
if (DIS_AbilityCoolDown) exitWith {systemChat "Abilities still on cool-down.";};
DIS_PCASHNUM = DIS_PCASHNUM - 500;
DIS_AbilityCoolDown = true;[] spawn {sleep 120;DIS_AbilityCoolDown = false;};
private _MagazineList = [];
{
	//Find all players primary weapon
	private _Weap = primaryWeapon _x;
	if !(_Weap isEqualTo "") then
	{
		private _mags = getArray (configFile / "CfgWeapons" / _Weap / "magazines");
		private _mag = _mags select 0;
		_MagazineList pushback _mag;
	};
} foreach _SquadUnits;

playsound "Purchase";
["Squad Air Drop In-bound",'#FFFFFF'] call Dis_MessageFramework;
private _Bx1 = createVehicle ["B_supplyCrate_F", [0,0,600], [], 0, "CAN_COLLIDE"];
clearWeaponCargoGlobal _Bx1;
clearMagazineCargoGlobal _Bx1;
clearItemCargoGlobal _Bx1;
clearBackpackCargoGlobal _Bx1;
{
	_Bx1 addMagazineCargoGlobal [_x, 6];
} foreach _MagazineList;
private _para = createVehicle ["B_Parachute_02_F", [0,0,600], [], 0, "CAN_COLLIDE"];
_Bx1 attachTo [_para,[0,0,0]];
[_Bx1] spawn {params ["_Bx1"];sleep 900;if (alive _Bx1) then {deleteVehicle _Bx1;}};
private _position = getPosWorld player;
_para setpos [_position select 0,_position select 1,((_position select 2) + 300)];	
_Bx1 setVariable ["DIS_PLAYERVEH",true,true];
playsound "drop_accomplished";
waitUntil {((getpos _Bx1) select 2) < 2.5};
detach _Bx1;

[
[_Bx1],
{
	params ["_Bx1"];
	if (player distance2D _Bx1 < 2100) then
	{
		private _m1 = createMarkerLocal [format ["%1",_Bx1],(getpos _Bx1)];
		_m1 setmarkershapeLocal "ICON";
		_m1 setMarkerTypeLocal "u_installation";
		_m1 setmarkercolorLocal "ColorWhite";
		_m1 setmarkersizeLocal [1,1];
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
			2,
			2,
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

