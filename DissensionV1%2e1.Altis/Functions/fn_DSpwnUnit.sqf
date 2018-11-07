params ["_InfantryList","_grp","_Pole","_StrongHoldBuildings","_grpGarrison","_SSide","_Numr","_ActiveBaddies","_BunkerList","_MineAdd"];

private _SpwnCnt = 0;
private _Units = [];
private _PolePos = getpos _Pole;
if (isNil "_grp") then {_grp = createGroup _SSide;_grp setVariable ["DIS_IMPORTANT",true,true];};
if (isNil "_grpGarrison") then {_grpGarrison = createGroup _SSide;_grpGarrison setVariable ["DIS_IMPORTANT",true,true];};


//FILTER DOWN BADDIES IN THE SKY
{
	if ((getPosATL _x) select 2 > 10) then
	{
		_ActiveBaddies deleteAt _forEachIndex;
	};
} foreach _ActiveBaddies;

if (count _ActiveBaddies < 1) then {_ActiveBaddies = [(getpos _Pole)];};

if (count _StrongHoldBuildings > 0) then
{
	{
		private _Pos = getpos _x;
		private _NEB = [_ActiveBaddies,_Pos,true,"dspwnunit11"] call dis_closestobj;
		if (_NEB distance2D _Pos < 50) then
		{
			_StrongHoldBuildings deleteAt _ForEachIndex;
		};		
	} foreach _StrongHoldBuildings;
};


private _AIComms = "AIComms" call BIS_fnc_getParamValue;
for "_i" from 0 to _Numr step 1 do 
{
	private _SpwnPntD = [0,0,0];
	private _RandomBuilding = objNull;	
	if (count _StrongHoldBuildings > 0) then
	{
		private _NEB2 = [_ActiveBaddies,_PolePos,true,"dspwnunit18"] call dis_closestobj;				
		_RandomBuilding = ([_StrongHoldBuildings,_NEB2,true,"dspwnunit19"] call dis_closestobj);
		private _BSpwnChk = _RandomBuilding getVariable ["DIS_BuildingSpwn",4];
		if (_BSpwnChk isEqualTo 0) then
		{
			_StrongHoldBuildings = _StrongHoldBuildings - [_RandomBuilding];
		}
		else
		{
			_BSpwnChk = _BSpwnChk - 1;
			_RandomBuilding setVariable ["DIS_BuildingSpwn",_BSpwnChk];			
		};
		_SpwnPntD =  selectRandom ([_RandomBuilding] call BIS_fnc_buildingPositions);
	}
	else
	{
		//_SpwnPntD = [_PolePos, 10, 50, 5, 0, 1, 0,[],[_PolePos,_PolePos]] call BIS_fnc_findSafePos;
		_SpwnPntD = getpos (selectRandom _BunkerList);
		//_SpwnPntD = [[[_PolePos, 50]],[]] call BIS_fnc_randomPos;
	};
	if (isNil "_SpwnPntD" || _SpwnPntD isEqualTo [0,0,0]) then {_SpwnPntD = [[[_PolePos, 50]],[]] call BIS_fnc_randomPos;};

	private _unit = _grp createUnit [(selectRandom _InfantryList) ,_SpwnPntD, [], 0, "CAN_COLLIDE"];
	if (_AIComms isEqualTo 1) then
	{
		_unit call DIS_fnc_UnitInit;
	};					
	
	_Units pushback _unit;
	_SpwnCnt = _SpwnCnt + 1;
	//if (!(DIS_MODRUN) && {(_SSide isEqualTo resistance)}) then {_unit call dis_AIUniforms;};
	[_unit,(typeof _unit)] call DIS_fnc_UniformHandle;
	_unit setpos _SpwnPntD;
	[_unit] joinSilent _grp;
	_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled;}];
	
	
	if (count _StrongHoldBuildings > 0) then 
	{
		if !(_RandomBuilding isEqualTo []) then
		{
			private _MaxSpawn = 0;
			{
				if ((round (random 100)) < 15 && {_MaxSpawn < 5}) then
				{
					private _unit = _grpGarrison createUnit [(selectRandom _InfantryList), _x, [], 0, "CAN_COLLIDE"];
					_unit setpos _x;
					[_unit] joinSilent _grpGarrison;			
					_unit setUnitPos "UP";
					_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];		
					[_unit,(typeof _unit)] call DIS_fnc_UniformHandle;
					_MaxSpawn = _MaxSpawn + 1;
					_unit disableAI "PATH";
					_unit setVariable ["DIS_SPECIAL",true,true];
					if (DIS_DEBUG) then {systemChat format ["TOWN GARRISON: %2: %1",_MaxSpawn,(typeof _RandomBuilding)]};
					//if (!(DIS_MODRUN) && {(_SSide isEqualTo resistance)}) then {_unit call dis_AIUniforms;};	
					//if !(_SSide isEqualTo resistance) then {[_unit,(typeof _unit)] call DIS_fnc_UniformHandle;};				
				};
			} foreach ([_RandomBuilding] call BIS_fnc_buildingPositions);
		};
	};
};


if (_MineAdd isEqualTo 1) then
{
	{
		if (random 100 > 50) then
		{
			_x addMagazine [selectrandom DIS_MinesList,1];
		};
	} foreach _Units;
};




private _Rtrn = [_StrongHoldBuildings,_SpwnCnt,_Units];





_Rtrn