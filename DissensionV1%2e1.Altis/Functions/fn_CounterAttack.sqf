//This function will handle AI launching auto-counter attacks to take towns.
params ["_SSide","_AttackSide","_Pole"];

//Find what kinds of units we should be spawning. Or setup any side specific variables here.
private _InfantryList = R_BarrackLU + R_BarrackHU;
private _FactoryList = R_LFactU + R_HFactU;
private _ControlledArray = IndControlledArray;
private _PolePos = getpos _Pole;

if (_SSide isEqualTo WEST) then
{
	_InfantryList = [];
	{
		_InfantryList pushback (_x select 0);
	} foreach (W_BarrackU + W_AdvU);

	_FactoryList = [];
	{
		_FactoryList pushback (_x select 0);
	} foreach (W_LFactU + W_HFactU);	

	_ControlledArray = BluControlledArray;
};
if (_SSide isEqualTo EAST) then
{

	_InfantryList = [];
	{
		_InfantryList pushback (_x select 0);
	} foreach (E_BarrackU + E_AdvU);

	_FactoryList = [];
	{
		_FactoryList pushback (_x select 0);
	} foreach (E_LFactU + E_HFactU);	

	_ControlledArray = OpControlledArray;
};

_ControlledArray = _ControlledArray - [_Pole];
private _NearestTown = [_ControlledArray,_PolePos,true] call dis_closestobj;
if (_NearestTown isEqualTo [0,0,0]) then {_NearestTown = _Pole;};
private _NearestTownPos = (getpos _NearestTown);
private _direction = _NearestTown getdir _PolePos;
private _RoadSpawnRough = [_NearestTownPos,200,_direction] call BIS_fnc_relPos;
private _Rlist = _RoadSpawnRough nearRoads 200;	

if (_NearestTownPos distance2D _PolePos > 2000) exitWith {};

private _VehSpwn = (round (random 4));
private _VehActualSpwn = 0;
private _positionVEHS = [0,0,0];
private _grpVeh = createGroup _SSide;
_grpVeh setVariable ["DIS_IMPORTANT",true];
while {_VehSpwn > _VehActualSpwn} do 
{

	private _positionR = [_NearestTownPos,250,50] call dis_randompos;
	private _SelectRoad = [_Rlist,_positionR,true] call dis_closestobj;
	if (!(isNil "_SelectRoad") && {!(_SelectRoad isEqualTo [])} && {!(_SelectRoad isEqualTo [0,0,0])}) then
	{
		_positionVEHS = (getpos _SelectRoad);
	}
	else
	{
		_positionVEHS = _positionR;
	};
	private _veh = createVehicle [(selectRandom _FactoryList),_positionVEHS, [], 0, "CAN_COLLIDE"];
	private _positionVEHS = [_positionVEHS, 1, 150, 5, 0, 20, 0,[],[_positionVEHS,_positionVEHS]] call BIS_fnc_findSafePos;
	_veh forceFollowRoad true;	
	_veh setpos _positionVEHS;
	_veh addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
	//_veh setUnloadInCombat [true, false];
	_grpVeh addVehicle _veh;
	private _VehSeats = fullCrew [_veh,"",true];
	{
		//[<NULL-object>,"cargo",2,[],false]
		
		if !((_x select 0) isEqualTo "cargo") then 
		{
			private _unitDO = _grpVeh createUnit [(selectRandom _InfantryList),_positionVEHS, [], 25, "CAN_COLLIDE"];
			_unitDO addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
			_unitDO moveInAny _veh;
		};
	} foreach _VehSeats;		
	_veh setdir _direction;
	_VehActualSpwn = _VehActualSpwn + 1;
	sleep 2;
};
private _WaypointPos = [_PolePos,50,50] call dis_randompos;		
private _Finalposition = [_WaypointPos, 1, 150, 5, 0, 20, 0,[],[_WaypointPos,_WaypointPos]] call BIS_fnc_findSafePos;
sleep 60;
_waypoint = _grpVeh addwaypoint[_Finalposition,1];
_waypoint setwaypointtype "MOVE";
_waypoint setWaypointSpeed "NORMAL";
_waypoint setWaypointBehaviour "AWARE";	
_waypoint2 = _grpVeh addwaypoint[_Finalposition,1];
_waypoint2 setwaypointtype "MOVE";
_waypoint2 setWaypointSpeed "NORMAL";
_waypoint2 setWaypointBehaviour "AWARE";
_grpVeh setCurrentWaypoint _waypoint;
