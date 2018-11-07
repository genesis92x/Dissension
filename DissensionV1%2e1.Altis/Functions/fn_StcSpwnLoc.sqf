params ["_Side","_Location"];


private _WestRun = false;
if (_Side isEqualTo West) then {_WestRun = true;};

private _Mrkrcolor = "ColorRed";
private _RSide = East;
private _MrkrType = "o_installation";
private _StaticArray = E_StaticWeap;
private _Com = DIS_EastCommander;
if (_WestRun) then
{
	_Mrkrcolor = "ColorBlue";
	_RSide = West;
	_MrkrType = "b_installation";
	_StaticArray = W_StaticWeap;
	_Com = DIS_WestCommander;
};

private _FinalA = _Com getVariable ["DIS_STATICLIST",[]];

private _CE = _Com call dis_ClosestEnemy;
private _grpS = (group _Com);
_grpS setVariable ["Vcm_Disable",true];
for "_i" from 0 to 5 do
{
	private _rnd = (random 150);
	private _dist = (_rnd + 25);
	private _dir = random 360;
	private _position = [(_Location select 0) + (sin _dir) * _dist, (_Location select 1) + (cos _dir) * _dist, 0];
	private _SpwnPos = [_position, 15, 250, 6, 0, 20, 0,[],[_position,_position]] call BIS_fnc_findSafePos;
	
	//Static on road
	private _RoadStatic = ((selectRandom _StaticArray) select 0) createVehicle _SpwnPos;
	_RoadStatic setvariable ["DIS_PLAYERVEH",true];
	_RoadStatic setpos (getpos _RoadStatic);
	_RoadStatic setDir (_RoadStatic getdir _CE);
	createVehicleCrew _RoadStatic;			
	{[_x] joinsilent _grpS;_x setvariable ["DIS_PLAYERVEH",true];} forEach crew _RoadStatic;
	_FinalA pushback _RoadStatic;	
};

for "_i" from 0 to 4 do
{
	private _rnd = (random 50);
	private _dist = (_rnd + 10);
	private _dir = random 360;
	private _position = [(_Location select 0) + (sin _dir) * _dist, (_Location select 1) + (cos _dir) * _dist, 0];
	private _SpwnPos = [_position, 5, 10, 1, 0, 20, 0,[],[_position,_position]] call BIS_fnc_findSafePos;
	
	//Static on road
	private _RoadStatic = ((selectRandom _StaticArray) select 0) createVehicle _SpwnPos;
	_RoadStatic setvariable ["DIS_PLAYERVEH",true];
	_RoadStatic setpos (getpos _RoadStatic);
	_RoadStatic setDir (_RoadStatic getdir _CE);
	createVehicleCrew _RoadStatic;			
	{[_x] joinsilent _grpS;_x setvariable ["DIS_PLAYERVEH",true];} forEach crew _RoadStatic;
	_FinalA pushback _RoadStatic;	
};



{
	if (!(alive _x) || isNull _x) then
	{
		deleteVehicle _x;
		_FinalA deleteAt _forEachIndex;
	};
} foreach _FinalA;


if (count _FinalA > 9) then
{
	for "_i" from 0 to 9 do
	{
		private _delete = _FinalA select 0;
		{deleteVehicle _x;} forEach crew _delete;
		deleteVehicle _delete;
		_FinalA deleteAt 0;
	};	
};


_Com setVariable ["DIS_STATICLIST",_FinalA];
