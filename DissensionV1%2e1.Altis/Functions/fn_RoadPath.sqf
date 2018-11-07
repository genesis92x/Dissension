//_this spawn DIS_fnc_RoadPath;
// _this = vehicle

if (_this getVariable ["DIS_VehMove",false]) exitWith {};
_this setVariable ["DIS_VehMove",true];

private _GoToPoint = [];
private _Group = (group (driver _this));
private _index = currentWaypoint _Group;
private _WPPos = getWPPos [_Group,_index];
if (_WPPos isEqualTo [0,0,0]) exitWith {_this setVariable ["DIS_VehMove",false];};
private _direction = _this getdir _WPPos;
private _NewPosition = [_this,25,_direction] call BIS_fnc_relPos;
private _FindRoadS = _NewPosition nearRoads 500;
private _SelRoad = [_FindRoads,_NewPosition,true] call dis_closestobj;	
private _NE = (driver _this) call dis_ClosestEnemy;
if (_SelRoad isEqualTo [0,0,0] || _SelRoad isEqualTo []) then 
{
private _EnemyPos = (getpos _NE);
private _FindRoadS = _EnemyPos nearRoads 500;
_SelRoad = [_FindRoads,_EnemyPos,true] call dis_closestobj;	
};

if (_SelRoad isEqualTo [0,0,0] || _SelRoad isEqualTo []) exitWith {};

while {(count _GoToPoint) < 60 && {_SelRoad distance _WPPos > 100}} do
{
	private _connectedRoads = roadsConnectedTo _SelRoad;
	private _NextRoad = [_connectedRoads,_WPPos,true] call dis_closestobj;
	if !(_NextRoad isEqualTo [0,0,0]) then
	{
		private _NextPos = getpos _NextRoad;
		_GoToPoint pushback _NextPos;
		_SelRoad = _NextRoad;
	};
	sleep 0.01;
};

_this setDriveOnPath _GoToPoint;
sleep 60;
_this setVariable ["DIS_VehMove",false];
