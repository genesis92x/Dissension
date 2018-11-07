//Function for a helo to come and support the players for a short time.
if (DIS_PCASHNUM - 1000 < 0) exitWith {systemChat "You lack sufficient funds!";if (playerSide isEqualTo west) then {playsound "EVAInsufficentFunds"} else {playsound "LEGIONInsufficentFunds"};};
if (DIS_AbilityCoolDown) exitWith {systemChat "Abilities still on cool-down.";};
DIS_PCASHNUM = DIS_PCASHNUM - 1000;
playsound "Purchase";
DIS_AbilityCoolDown = true;[] spawn {sleep 300;DIS_AbilityCoolDown = false;};
["Air Support in-bound!",'#FFFFFF'] call Dis_MessageFramework;

private _Side = playerside;
private _AirList = E_AirU;
private _Commander = DIS_EastCommander;

if (_Side isEqualTo West) then
{
	_AirList = W_AirU;
	_Commander = DIS_WestCommander;
};

private _VehC = ((selectRandom _AirList) select 0);
private _veh = createVehicle [_VehC, [(random 150),(random 150),150], [], 0, "FLY" ];
createVehicleCrew _veh;
private _vehgrp = creategroup _Side;
{[_x] joinSilent _vehgrp;} foreach (crew _veh);
_veh setVariable ["DIS_BoatN",true];
_veh setvariable ["DIS_PLAYERVEH",true,true];


private _ComPos = getpos _Commander;
private _MovePosition = [_ComPos, 15, 250, 5, 0, 20, 0,[],[_ComPos,_ComPos]] call BIS_fnc_findSafePos;
systemChat format ["_MovePosition: %1",_MovePosition];
_veh setPos [(_MovePosition select 0),(_MovePosition select 1),100];

private _PlayerPos = getpos player;
private _waypoint = _vehgrp addwaypoint[_PlayerPos,0];
_waypoint setwaypointtype "MOVE";
_waypoint setWaypointSpeed "NORMAL";
_waypoint setWaypointBehaviour "COMBAT";
_vehgrp setCurrentWaypoint [_vehgrp,(_waypoint select 1)];	
private _waypoint2 = _vehgrp addwaypoint[_PlayerPos,0];
_waypoint2 setwaypointtype "MOVE";
_waypoint2 setWaypointSpeed "NORMAL";
_waypoint2 setWaypointBehaviour "COMBAT";

//Put marker on vehicle
private _Img = MISSION_ROOT + "Pictures\iconPlayer_ca.paa";
private _pos2 = visiblePositionASL _veh;
_pos2 set [2, ((_veh modelToWorld [0,0,0]) select 2) + 0.25];	
[(str _pos2), "onEachFrame", 
{
		params ["_Img","_pos2","_veh"];
		private _pos2 = visiblePositionASL _veh;
		_pos2 set [2, ((_veh modelToWorld [0,0,0]) select 2) + 0.25];		
		_Dist = (round (_veh distance2D player));
		call compile format 
		[
		'
		drawIcon3D
		[
			%1,
			[1,1,1,0.8],
			%2,
			1,
			1,
			0,
			"SUPPORT: %3 METERS",
			1,
			0.04,
			"RobotoCondensed",
			"center",
			false
		];
		'
		,str _Img,_pos2,(str _Dist)
		]
},
[_Img,_pos2,_veh]
] call BIS_fnc_addStackedEventHandler;
[(str _pos2),_veh] spawn {params ["_Name","_veh"];waitUntil {!(alive _veh)};[_Name, "onEachFrame"] call BIS_fnc_removeStackedEventHandler;};

[_vehgrp,_veh,_ComPos] spawn
{
	params ["_vehgrp","_veh","_ComPos"];
	sleep 900;
	["Air Support is RTB!",'#FFFFFF'] call Dis_MessageFramework;
	private _waypoint = _vehgrp addwaypoint[_ComPos,0];
	_waypoint setwaypointtype "MOVE";
	_waypoint setWaypointSpeed "NORMAL";
	_waypoint setWaypointBehaviour "SAFE";
	_vehgrp setCurrentWaypoint [_vehgrp,(_waypoint select 1)];	
	private _waypoint2 = _vehgrp addwaypoint[_ComPos,0];
	_waypoint2 setwaypointtype "MOVE";
	_waypoint2 setWaypointSpeed "NORMAL";
	_waypoint2 setWaypointBehaviour "SAFE";
	sleep 300;
	_veh setdamage 1;
	deleteVehicle _veh;
};