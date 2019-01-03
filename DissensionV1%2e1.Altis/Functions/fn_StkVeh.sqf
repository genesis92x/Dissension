params ["_UnitA","_grp"];

private _Leader = leader _grp;
private _b = behaviour _Leader;
private _Blacklist = [DIS_EASTCOMMANDER,DIS_WESTCOMMANDER];


private _RemoveUnits = [];
{
	if (isPlayer _x) then
	{
		_RemoveUnits pushback _x;
	};
} foreach _UnitA;

{
	private _PlayerUnit = _x;
	private _IndexA = _UnitA findif {_x isEqualTo _PlayerUnit};
	_UnitA deleteAt _IndexA;
} foreach _RemoveUnits;


if (!(_grp getVariable ["DIS_BoatN",false]) && {!(_b isEqualTo "COMBAT")}) then
{
	private _VehA = [];
	private _FootA = [];
	private _index = currentWaypoint _grp;
	private _WPPos = getWPPos [_grp,_index];	
	if !(_WPPos isEqualTo [0,0,0]) then
	{
		{
			if !(_x isEqualTo (vehicle _x)) then
			{
				_VehA pushBackUnique (vehicle _x);
			}
			else
			{
				_FootA pushBackUnique _x;
			};
		} foreach _UnitA;
		
		{
			if (!(_x isKindOf "AIR") && {!(isPlayer (driver _x))} && {!(_x in _Blacklist)} && {!(_x isKindOf "StaticWeapon")} && {!(_x getVariable ["DIS_SPECIAL",false])}) then
			{
				private _dst = _x getVariable ["DIS_Loc",[0,0,0]];
				if (_dst distance2D (getpos _x) < 6) then
				{
						private _direction = _x getdir _WPPos;
						private _NewPosition = [_x,250,_direction] call BIS_fnc_relPos;
						private _FindRoadS = _NewPosition nearRoads 100;
						private _FinalPos = [0,0,0];
						if (_FindRoadS isEqualTo []) then {_FinalPos = _NewPosition;} else {_SelRoad = [_FindRoads,_WPPos,true] call dis_closestobj;_FinalPos = (getpos _SelRoad)};
						private _position = [_FinalPos,0,500,0,0,1,0,[],[_FinalPos,_FinalPos]] call BIS_fnc_findSafePos;
						if (_position isEqualTo []) then {_position = _NewPosition};
						_x setpos _position;
				};
				_x setVariable ["DIS_Loc",(getpos _x)];
			};
		} foreach _VehA;
		{
				private _dst = _x getVariable ["DIS_Loc",[0,0,0]];
				if ((_dst distance2D (getpos _x) < 6 || _Leader distance2D _x > 300) && {!(_x in _Blacklist)} && {!(_x getVariable ["DIS_SPECIAL",false])}) then
				{
						private _direction = _x getdir _WPPos;
						private _NewPosition = [_x,250,_direction] call BIS_fnc_relPos;
						private _FindRoadS = _NewPosition nearRoads 100;
						private _FinalPos = [0,0,0];
						if (_FindRoadS isEqualTo []) then {_FinalPos = _NewPosition;} else {_SelRoad = [_FindRoads,_WPPos,true] call dis_closestobj;_FinalPos = (getpos _SelRoad)};
						private _position = [_FinalPos,0,500,0,0,1,0,[],[_FinalPos,_FinalPos]] call BIS_fnc_findSafePos;
						if (_position isEqualTo []) then {_position = _NewPosition};
						_x setpos _position;
				_x setVariable ["DIS_Loc",(getpos _x)];
			};
		} foreach _FootA;		
	};
};