//Requesting pickup via chopper. Players are trusting AI with this...
if (DIS_PCASHNUM - 250 < 0) exitWith {systemChat "You lack sufficient funds!";if (playerSide isEqualTo west) then {playsound "EVAInsufficentFunds"} else {playsound "LEGIONInsufficentFunds"};};
if (DIS_AbilityCoolDown) exitWith {systemChat "Abilities still on cool-down.";};
DIS_PCASHNUM = DIS_PCASHNUM - 250;
playsound "Purchase";
DIS_AbilityCoolDown = true;[] spawn {sleep 120;DIS_AbilityCoolDown = false;};
["Transport vehicle is in-bound from HQ.",'#FFFFFF'] call Dis_MessageFramework;
playsound "transport_lz_selected";


private _MkT = "b_motor_inf";
private _Commander = DIS_WestCommander;
private _SpawnSide = side (group player);

private _TransportVeh = (W_TransportUnit select 0);

if (_SpawnSide isEqualTo east) then
{
	_TransportVeh = (E_TransportUnit select 0);
};
if (_SpawnSide isEqualTo resistance) then
{
	_TransportVeh = (R_TransportUnit select 0);
};		





//Attempt to find a safe position for the heli to land
private _ppos = getpos player;
private _ActMoveToPosition = _ppos;

//Now we need to pop smoke on the location selected
private _smoke = "SmokeShellPurple" createVehicle _ActMoveToPosition;
private _HeliPad = createVehicle ["Land_HelipadEmpty_F",_ActMoveToPosition, [], 0, "CAN_COLLIDE"];
_HeliPad setpos _ActMoveToPosition;
_HeliPad spawn {sleep 600; if (alive _this) then {deleteVehicle _this};};
_HeliPad setvariable ["DIS_PLAYERVEH",true,true];
private _Clear1 = nearestTerrainObjects [_HeliPad, ["TREE","BUSH","HIDE"], 25];

[
[_Clear1],
{
	params ["_Clear1"];
	{
		_x hideObjectGlobal true;
	} foreach _Clear1;	
}
	
] remoteExecCall ["BIS_fnc_call",2];


private _veh = createVehicle [_TransportVeh, [(random 150),(random 150),150], [], 0, "FLY" ];
_veh lockDriver true;
_veh spawn {sleep 1200;if (alive _this) then {deleteVehicle _this;};};
_veh allowdamage false;
private _vehgrp = creategroup _SpawnSide;
createVehicleCrew _veh;
_veh setVariable ["DIS_BoatN",true];
_veh setvariable ["DIS_PLAYERVEH",true,true];
{[_x] joinSilent _vehgrp;_x disableAI "COVER";_x disableAI "AUTOCOMBAT";_x disableAI "AUTOTARGET";_x disableAI "TARGET";} foreach (crew _veh);
_vehgrp setVariable ["DIS_BoatN",true,true];
_vehgrp setVariable ["DIS_IMPORTANT",true,true];
_veh setBehaviour "SAFE";


private _ComPos = getpos _Commander;
private _MovePosition = [_ComPos, 15, 250, 5, 0, 20, 0,[],[_ComPos,_ComPos]] call BIS_fnc_findSafePos;
_MovePosition = [(_MovePosition select 0),(_MovePosition select 1),10];
_HeliMovePos = _MovePosition findEmptyPosition [1,150,_TransportVeh];
if (_HeliMovePos isEqualTo []) then {_HeliMovePos = _MovePosition;};
_veh setpos [(_HeliMovePos select 0),(_HeliMovePos select 1),((_HeliMovePos select 2) + 50)];

//Add waypoint 

private _waypoint = _vehgrp addwaypoint[_ActMoveToPosition,0];
_waypoint setwaypointtype "MOVE";
_waypoint setWaypointSpeed "NORMAL";
_waypoint setWaypointBehaviour "SAFE";
_vehgrp setCurrentWaypoint [_vehgrp,(_waypoint select 1)];	
private _waypoint2 = _vehgrp addwaypoint[_ActMoveToPosition,0];
_waypoint2 setwaypointtype "MOVE";
_waypoint2 setWaypointSpeed "NORMAL";
_waypoint2 setWaypointBehaviour "SAFE";



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
			"HELI: %3 METERS",
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
[(str _pos2),_veh] spawn {params ["_Name","_veh"];waitUntil {(_veh distance player < 50) || !(alive _veh)};[_Name, "onEachFrame"] call BIS_fnc_removeStackedEventHandler;};
	








while {alive _veh && {_veh distance2D _ActMoveToPosition > 150}} do
{
	sleep 1;
};
_veh land "LAND";

DIS_PICKLOCATION = [0,0,0];
waitUntil {player in _veh};
playsound "transport_welcome";

openMap [true, true];
closeDialog 2;
["Select LZ position!",'#FFFFFF'] call Dis_MessageFramework;
["DIS_RQSTPICKUP", "onMapSingleClick", 
{
	private _veh = _this select 4;
	DIS_PICKLOCATION = _pos;
		
	private _Img = MISSION_ROOT + "Pictures\iconPlayer_ca.paa";
	//private _pos2 = [(_Pos select 0),(_Pos select 1),(getTerrainHeightASL _Pos)];
	private _pos2 = [(_Pos select 0),(_Pos select 1),5];
	[(str _pos2), "onEachFrame", 
	{
			params ["_Img","_pos2","_veh"];
			call compile format 
			[
			'
			drawIcon3D
			[
				%1,
				[1,1,1,0.5],
				%2,
				1,
				1,
				0,
				"LZ",
				1,
				0.04,
				"RobotoCondensed",
				"center",
				false
			];
			'
			,str _Img,_pos2
			]
	},
	[_Img,_pos2,_veh]
	] call BIS_fnc_addStackedEventHandler;
	[(str _pos2),_veh] spawn {params ["_Name","_veh"];waitUntil {(player distance DIS_PICKLOCATION < 50) || !(alive _veh)};[_Name, "onEachFrame"] call BIS_fnc_removeStackedEventHandler;};
	openMap [false, false];
	["DIS_RQSTPICKUP", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
},
[_veh]
] call BIS_fnc_addStackedEventHandler;



waitUntil {!(DIS_PICKLOCATION isEqualTo [0,0,0])};


_ActLandingLocation = DIS_PICKLOCATION;		
private _waypoint = _vehgrp addwaypoint[_ActLandingLocation,0];
_waypoint setwaypointtype "MOVE";
_waypoint setWaypointSpeed "NORMAL";
_waypoint setWaypointBehaviour "SAFE";
_vehgrp setCurrentWaypoint [_vehgrp,(_waypoint select 1)];	
private _waypoint2 = _vehgrp addwaypoint[_ActLandingLocation,0];
_waypoint2 setwaypointtype "MOVE";
_waypoint2 setWaypointSpeed "NORMAL";
_waypoint2 setWaypointBehaviour "SAFE";
deleteVehicle _Helipad;		
private _HeliPad = createVehicle ["Land_HelipadEmpty_F",_ActLandingLocation, [], 0, "CAN_COLLIDE"];
_HeliPad setpos _ActLandingLocation;
_HeliPad setVariable ["DIS_PLAYERVEH",true,true];
_HeliPad spawn {sleep 600; if (alive _this) then {deleteVehicle _this};};
_veh spawn {sleep 60;_this allowdamage true;};	

while {alive _veh && {_veh distance2D _ActLandingLocation > 150}} do
{
	sleep 1;
};

private _Clear2 = nearestTerrainObjects [_HeliPad, ["TREE","BUSH","HIDE"], 25];

[
[_Clear2],
{
	params ["_Clear2"];
	{
		_x hideObjectGlobal true;
	} foreach _Clear2;	
}
	
] remoteExecCall ["BIS_fnc_call",2];

playsound "transport_accomplished";
if !(alive _veh) exitWith {playsound "transport_destroyed";};	
_veh land "LAND";	

sleep 30;

private _waypoint = _vehgrp addwaypoint[_HeliMovePos,0];
_waypoint setwaypointtype "MOVE";
_waypoint setWaypointSpeed "NORMAL";
_waypoint setWaypointBehaviour "SAFE";
_vehgrp setCurrentWaypoint [_vehgrp,(_waypoint select 1)];	
private _waypoint2 = _vehgrp addwaypoint[_HeliMovePos,0];
_waypoint2 setwaypointtype "MOVE";
_waypoint2 setWaypointSpeed "NORMAL";
_waypoint2 setWaypointBehaviour "SAFE";

waitUntil {(_veh distance _HeliMovePos < 150) || !(alive _veh)};
{deleteVehicle _x;} foreach units _vehgrp;			
deletevehicle _veh;
[
[_Clear1,_Clear2],
{
	params ["_Clear1","_Clear2"];
	{
		_x hideObjectGlobal false;
	} foreach _Clear2;
	{
		_x hideObjectGlobal false;
	} foreach _Clear1;		
}
	
] remoteExecCall ["BIS_fnc_call",2];






