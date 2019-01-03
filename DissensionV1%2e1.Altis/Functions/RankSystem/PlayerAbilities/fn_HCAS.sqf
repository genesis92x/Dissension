//Function that drops a larger vehicle than an ATV
if (DIS_PCASHNUM - 600 < 0) exitWith {systemChat "You lack sufficient funds!";if (playerSide isEqualTo west) then {playsound "EVAInsufficentFunds"} else {playsound "LEGIONInsufficentFunds"};};
if (DIS_AbilityCoolDown) exitWith {systemChat "Abilities still on cool-down.";};
DIS_PCASHNUM = DIS_PCASHNUM - 600;
playsound "Purchase";
DIS_AbilityCoolDown = true;[] spawn {sleep 240;DIS_AbilityCoolDown = false;};

[[playerSide],1000,(getpos player),"Sup_CASInbound"] remoteExecCall ["DIS_fnc_PlaySoundNear",0]; //ENROUTE
["CAS Inbound",'#FFFFFF'] call Dis_MessageFramework;

private _VehC = "B_Heli_Transport_01_F";
private _SpawnSide = playerSide;
private _Commander = DIS_WestCommander;
if (_SpawnSide isEqualTo East) then {_VehC = "O_Heli_Light_02_dynamicLoadout_F";_Commander = DIS_EastCommander;};

//Spawn in the bird
private _veh = createVehicle [_VehC, [(random 150),(random 150),150], [], 0, "FLY" ];
_veh lock 2;
_veh spawn {sleep 1200;if (alive _this) then {deleteVehicle _this;};};
_veh allowdamage false;
private _vehgrp = creategroup _SpawnSide;
_vehgrp setVariable ["Vcm_Disable",true]; //Disable VCOM
createVehicleCrew _veh;
_veh setVariable ["DIS_BoatN",true];
_veh setvariable ["DIS_PLAYERVEH",true,true];
{[_x] joinSilent _vehgrp;} foreach (crew _veh);
_vehgrp setVariable ["DIS_BoatN",true,true];
_vehgrp setVariable ["DIS_IMPORTANT",true,true];
_veh setBehaviour "AWARE";	
_veh flyInHeight 100;

_veh setVariable ["DGN_UNITSIDE",_SpawnSide];
_veh setVariable ["DGN_FIREDCANTALK",true];
_veh setVariable ["DGN_GOINGDOWNCANTALK",true];
_veh setVariable ["DGN_INCCANTALK",true];
_veh addEventHandler ["Fired", {_this call DIS_fnc_HFired;}];
_veh addEventHandler ["IncomingMissile", {_this call DIS_fnc_HInc;}];
_veh addEventHandler ["Dammaged", {_this call DIS_fnc_HGoingDown;}];

//Move the helicraft to the commanders position
private _ComPos = getpos _Commander;
private _MovePosition = [_ComPos, 15, 250, 5, 0, 20, 0,[],[_ComPos,_ComPos]] call BIS_fnc_findSafePos;
_MovePosition = [(_MovePosition select 0),(_MovePosition select 1),10];
_HeliMovePos = _MovePosition findEmptyPosition [1,150,_VehC];
if (_HeliMovePos isEqualTo []) then {_HeliMovePos = _MovePosition;};
_veh setpos [(_HeliMovePos select 0),(_HeliMovePos select 1),((_HeliMovePos select 2) + 500)];



//Position for helicraft to go
private _SupportPos = getpos player;



//Add waypoint 
private _waypoint = _vehgrp addwaypoint[_SupportPos,0];
_waypoint setwaypointtype "LOITER";
_waypoint setWaypointSpeed "LIMITED";
_waypoint setWaypointBehaviour "AWARE";
_waypoint setWaypointLoiterRadius 200;
_waypoint setWaypointLoiterType "CIRCLE";
_vehgrp setCurrentWaypoint [_vehgrp,(_waypoint select 1)];	
private _waypoint2 = _vehgrp addwaypoint[_SupportPos,0];
_waypoint2 setwaypointtype "LOITER";
_waypoint2 setWaypointSpeed "LIMITED";
_waypoint2 setWaypointBehaviour "AWARE";
_waypoint2 setWaypointLoiterRadius 200;
_waypoint2 setWaypointLoiterType "CIRCLE";


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
			"LIGHT AIR SUPPORT",
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

[_veh,_SpawnSide] spawn
{
	params ["_veh","_SpawnSide"];
	waitUntil
	{
		{
			player reveal [_x,20];
		} foreach allunits select {!(side _x isEqualTo _SpawnSide) && {_x distance2D _veh < 600}};
		sleep 5;
		!(alive _veh);
	};


};

sleep 30;

_veh allowdamage true;

sleep 300;



if (alive (driver _veh)) then
{
	[[playerSide],1000,(getpos _veh),"Sup_CASOutbound"] remoteExecCall ["DIS_fnc_PlaySoundNear",0]; //OUTBOUND
	["CAS is leaving the AO.",'#FFFFFF'] call Dis_MessageFramework;
	
	private _waypoint = _vehgrp addwaypoint[_ComPos,0];
	_waypoint setwaypointtype "MOVE";
	_waypoint setWaypointSpeed "NORMAL";
	_waypoint setWaypointBehaviour "SAFE";
	_vehgrp setCurrentWaypoint [_vehgrp,(_waypoint select 1)];		
	sleep 30;
	{deleteVehicle _x;} foreach units _vehgrp;			
	deletevehicle _veh;
	
};	















