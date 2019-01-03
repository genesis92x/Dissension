params ["_PreInfantryList","_grp","_Pole","_SSide","_Numr","_ClosestDefenceTown","_DefenceSpawnPos","_HeavyFactoryList","_AtkSide","_FactoryList","_AirList","_AssaultFrom","_AttackSpawnPos","_SpawnedUnitArray"];
private _SpwnCnt = 0;
private _Units = [];
private _DPolePos = getpos _ClosestDefenceTown;
private _PolePos = getpos _Pole;
if (isNil "_grp") then {_grp = createGroup _SSide;_grp setVariable ["DIS_IMPORTANT",true,true];};



//Side specific variables to be set here.

private _MoneyArray = E_RArray;
private _ActiveSide = E_ActiveUnits;
private _CurrentTickets = Dis_OpforTickets;
private _BarracksList = E_BarrackU;
private _LFactoryList = E_LFactU;
private _HFactoryList = E_HFactU;
private _AirfieldList = E_AirU;
private _MedicalList = E_MedU;
private _AdvInfList = E_AdvU;
private _TeamLeader = E_TeamLU;
private _SquadLeader = E_SquadLU;
private _BuildingList = [0,0,0];
private _Commander = Dis_EastCommander;
private _GroupName = E_Groups;
private _MarkerColor = "ColorRed";
private _MarkerType = "o_inf";	
private _ArmyFocus = E_CommanderInfo select 2;
private _AmountToSpawnVeh = 1;
private _TechBuildings = "ALL";
private _LightSpwn = (round (random 1));
private _HeavySpwn = (round (random 1));;
private _HeliSpwn = (round (random 1));;
private _AirSpwn = (round (random 1));;

switch (_SSide) do 
{
    case resistance: 
		{
			_BarracksList = _PreInfantryList;
			_LFactoryList = _FactoryList;
			_HFactoryList = _HeavyFactoryList;
			_AirfieldList = _AirList;
			_AdvInfList = _PreInfantryList;
			private _PreBuildingList = [];
			{
				_PreBuildingList pushBack (_x select 0);
			} foreach DIS_RESISTANCEASSAULTSPAWN;			
			_BuildingList = [_PreBuildingList,_DefenceSpawnPos,true,"dspwnunit11"] call dis_closestobj;			
			_ArmyFocus = "GUERRILLA";
			_TechBuildings = "ALL";
			_MoneyArray = [0,0,0,0];
			
			{
				private _UArray = _x;
				{
					private _Unit = _x;
					if !(_Unit isEqualType []) then
					{
						_UArray set [_forEachIndex,[_Unit,[0,0,0]]];
					};
				} foreach _UArray;
			} foreach [_BarracksList,_LFactoryList,_HFactoryList,_AirfieldList,_AdvInfList];			
			
		};
    case east: 
		{
			_MoneyArray = E_RArray;
			_ActiveSide = E_ActiveUnits;
			_CurrentTickets = Dis_OpforTickets;
			_BarracksList = E_BarrackU;
			_LFactoryList = E_LFactU;
			_HFactoryList = E_HFactU;
			_AirfieldList = E_AirU;
			_MedicalList = E_MedU;
			_AdvInfList = E_AdvU;
			_TeamLeader = E_TeamLU;
			_SquadLeader = E_SquadLU;
			private _PreBuildingList = [];
			{
				_PreBuildingList pushBack (_x select 0);
			} foreach DIS_EASTASSAULTSPAWN;					
			_BuildingList = [_PreBuildingList,_DefenceSpawnPos,true,"dspwnunit11"] call dis_closestobj;	
			_Commander = Dis_EastCommander;
			_GroupName = E_Groups;
			_MarkerColor = "ColorRed";
			_MarkerType = "o_inf";	
			_ArmyFocus = E_CommanderInfo select 2;
			_AmountToSpawnVeh = 1;
			_TechBuildings = E_Buildinglist;
		};
    case west: 
		{
			_WestRun = true;
			_MoneyArray = W_RArray;
			_ActiveSide = W_ActiveUnits;
			_CurrentTickets = Dis_BluforTickets;
			_BarracksList = W_BarrackU;
			_LFactoryList = W_LFactU;
			_HFactoryList = W_HFactU;
			_AirfieldList = W_AirU;	
			_MedicalList = W_MedU;
			_AdvInfList = W_AdvU;
			_TeamLeader = W_TeamLU;
			_SquadLeader = W_SquadLU;
			private _PreBuildingList = [];
			{
				_PreBuildingList pushBack (_x select 0);
			} foreach DIS_WESTCAMPRESPAWN;				
			_BuildingList =  [_PreBuildingList,_DefenceSpawnPos,true,"dspwnunit11"] call dis_closestobj;	
			_TechBuildings = W_Buildinglist;
			_Commander = Dis_WestCommander;
			_GroupName = W_Groups;
			_ArmyFocus = W_CommanderInfo select 2;
			_MarkerColor = "ColorBlue";
			_MarkerType = "b_inf";		
		};		
};



if (_SSide isEqualTo _AtkSide) then
{
	_DPolePos = getpos _AssaultFrom;
	_DefenceSpawnPos = _AttackSpawnPos;
};

if (_BuildingList distance2D _DefenceSpawnPos > 400) then
{
	_Buildinglist = [0,0,0];
};		


//If there is no camp, we cannot spawn anymore troops! Exit!!! ABOORRTTT.
//systemChat format ["SPAWN UNITS AT: %1",_BuildingList];
if (_BuildingList isEqualTo [0,0,0]) exitWith 
{
	if (_SSide isEqualTo _AtkSide) then
	{
		_Pole setVariable ["DIS_Captureattacker",[_OriginalAmount,-1000,_AtkSide],true];
	}
	else
	{
		_Pole setVariable ["DIS_Capture",[_OriginalAmount,-1000,_SSide],true];
	};
	_SpawnedUnitArray = [];
	_SpawnedUnitArray
};



//Lets determine unique commander compositions.
switch (_ArmyFocus) do 
{
	case "Infantry": 
	{
		_Numr = _Numr + 5;
	};
	case "GUERRILLA": 
	{
		_Numr = _Numr + 2;
		_LightSpwn = _LightSpwn + (round (random 1));
		_AirSpwn = 0;
		_HeliSpwn = 0;
		_HeavySpwn = 0;
	};
	case "Heavy Armor": 
	{
		_HeavySpwn = _HeavySpwn + (round (random 1));
	};
	case "Light Armor": 
	{
		_LightSpwn = _LightSpwn + (round (random 1));
	};
	case "Helicraft": 
	{
		_HeliSpwn = _HeliSpwn + (round (random 1));
	};
	case "Aircraft": 
	{
		_AirSpwn = _AirSpwn  + (round (random 1));
	};
	
};


//We need to not spawn a tank, or aircraft, or what-have-you if we already have our limit.
{
	switch (true) do 
	{
		case (_x isKindOf "Plane"): 
		{
			_AirSpwn = _AirSpwn - 1;
		};
		case (_x isKindOf "Helicopter"): 
		{
			_HeliSpwn = _HeliSpwn - 1;
		};
		case (_x isKindOf "Car"): 
		{
			_LightSpwn = _LightSpwn - 1;
		};
		case (_x isKindOf "Tank"): 
		{
			_HeavySpwn = _HeavySpwn - 1;
		};			
	};
} foreach _SpwnedUnits;



//We need to decide where we can spawn these troops. For that we need to find all the helpful structures.
private _CompleteList = [];
private _BarracksSwitch = false;
private _LFactorySwitch = false;
private _StaticSwitch = false;
private _HFactorySwitch = false;
private _AFactorySwitch = false;
private _MedBaySwitch = false;
private _AdvInfSwitch = false;
private _BarrackList = [];
private _LightFactoryList = [];
private _HeavyFactoryList = [];
private _AirFieldFactoryList =	[];
private _ShipFactoryList = [];
private _StructuresRemain = false;

//Find the physical structures here
if !(_TechBuildings isEqualTo "ALL") then
{
	{
		_Phy = _x select 0;
		if !(isNil "_Phy") then
		{
			_Name = _x select 1;
			if (_Name isEqualTo "Barracks") then {_BarracksSwitch = true;_BarrackList pushback (_x select 0);_StructuresRemain = true;};
			if (_Name isEqualTo "Light Factory") then {_LFactorySwitch = true;_LightFactoryList pushback (_x select 0);_StructuresRemain = true;};
			if (_Name isEqualTo "Static Bay") then {_StaticSwitch = true;};
			if (_Name isEqualTo "Heavy Factory") then {_HFactorySwitch = true;_HeavyFactoryList pushback (_x select 0);_StructuresRemain = true;};
			if (_Name isEqualTo "Air Field") then {_AFactorySwitch = true;_AirFieldFactoryList pushback (_x select 0);_StructuresRemain = true;};
			if (_Name isEqualTo "Medical Bay") then {_MedBaySwitch = true;};
			if (_Name isEqualTo "Advanced Infantry Barracks") then {_AdvInfSwitch = true;_BarrackList pushback (_x select 0);_StructuresRemain = true;};
		};
	} foreach _TechBuildings;
}
else
{
	_BarracksSwitch = true;
	_LFactorySwitch = true;
	_HFactorySwitch = true;
	_AFactorySwitch = true;
	_AdvInfSwitch = true;
	_StructuresRemain = true;
};


//If there are no unit producing structures on the map, then cancel.
if !(_StructuresRemain) exitWith {_SpawnedUnitArray = [];_SpawnedUnitArray};

//Compile the list of spawnable units.
private _CompleteList = [];
if (_BarracksSwitch && {!(_AdvInfSwitch)}) then {_CompleteList pushback _BarracksList};
if (_LFactorySwitch) then {_CompleteList pushback _LFactoryList};
if (_StaticSwitch) then {};
if (_HFactorySwitch) then {_CompleteList pushback _HFactoryList};
if (_AFactorySwitch) then {_CompleteList pushback _AirfieldList};
if (_MedBaySwitch) then {_CompleteList pushback _MedicalList};
if (_AdvInfSwitch) then {_CompleteList pushback _AdvInfList};

private _InfantryList = [];
private _Aircraftlist = [];
private _HelicopterList = [];
private _HeavyVehicleList = [];
private _LightVehicleList = [];
private _ShipList = [];

//Resistance units do not cost money.
{
	_GroupArray = _x;
	{
		_Unit = _x select 0;
		//_Cost = _x select 1;
		if (_Unit isKindOf "Man") then {_InfantryList pushback _x}; 
		if (_Unit isKindOf "Plane") then {_Aircraftlist pushback _x}; 
		if (_Unit isKindOf "Helicopter") then {_HelicopterList pushback _x}; 
		if (_Unit isKindOf "Tank") then {_HeavyVehicleList pushback _x}; 
		if (_Unit isKindOf "Car") then {_LightVehicleList pushback _x}; 
		if (_Unit isKindOf "Ship") then {_ShipList pushback _x}; 
	} foreach _GroupArray;
} foreach _CompleteList;


//Let's take a look at our money. If any is in the negative, we need to forget about spawning any units that use that resource.
//[W_Oil,W_Power,W_Cash,W_Materials];
_MoneyArray params ["_AOil","_APower","_ACash","_AMaterials"]; 


if (_AOil < 0) then {_Aircraftlist = [];_HelicopterList = [];_HeavyVehicleList = [];_LightVehicleList = [];_ShipList = [];};
if (_APower < 0) then {_Aircraftlist = [];_HelicopterList = [];_HeavyVehicleList = [];};
if (_AMaterials < 0) exitWith {_SpawnedUnitArray = [];_SpawnedUnitArray};//Everything takes materials. No point in even continuing.


//Infantry Spawn

//First we need to determine how many "special" units we have (vehicles). These detract from our overall number.
private _Numr = (_Numr - (_LightSpwn + _HeavySpwn + _HeliSpwn + _AirSpwn));

private _FinalInfSpawn = [];
private _FinalLVSpawn = [];
private _FinalHVSpawn = [];
private _FinalHeliSpawn = [];
private _FinalAirSpawn = [];


if (_Numr > 0 && {_BarracksSwitch}) then
{
	for "_i" from 0 to _Numr step 1 do 
	{
		private _SpwnUnit = selectRandom _InfantryList;
		_SpwnUnit params ["_Unit",["_Cost",0]];
		_FinalInfSpawn pushback _Unit;
		_MoneyArray set [0,(_MoneyArray select 0) - (_Cost select 0)];
		_MoneyArray set [1,(_MoneyArray select 1) - (_Cost select 1)];
		_MoneyArray set [2,(_MoneyArray select 2) - (_Cost select 2)];
		_MoneyArray set [3,(_MoneyArray select 3) - (_Cost select 3)];
	};
};

if (_LightSpwn > 0 && {_LFactorySwitch}) then
{
for "_i" from 0 to _LightSpwn step 1 do 
{
	private _SpwnUnit = selectRandom _LightVehicleList;
	_SpwnUnit params ["_Unit",["_Cost",0]];
	_FinalLVSpawn pushback _Unit;
	_MoneyArray set [0,(_MoneyArray select 0) - (_Cost select 0)];
	_MoneyArray set [1,(_MoneyArray select 1) - (_Cost select 1)];
	_MoneyArray set [2,(_MoneyArray select 2) - (_Cost select 2)];
	_MoneyArray set [3,(_MoneyArray select 3) - (_Cost select 3)];
};
};

if (_HeavySpwn > 0 && {_HFactorySwitch}) then
{
for "_i" from 0 to _HeavySpwn step 1 do 
{
	private _SpwnUnit = selectRandom _HeavyVehicleList;
	_SpwnUnit params ["_Unit",["_Cost",0]];
	_FinalHVSpawn pushback _Unit;
	_MoneyArray set [0,(_MoneyArray select 0) - (_Cost select 0)];
	_MoneyArray set [1,(_MoneyArray select 1) - (_Cost select 1)];
	_MoneyArray set [2,(_MoneyArray select 2) - (_Cost select 2)];
	_MoneyArray set [3,(_MoneyArray select 3) - (_Cost select 3)];
};
};

if (_HeliSpwn > 0 && {_AFactorySwitch}) then
{
for "_i" from 0 to _HeliSpwn step 1 do 
{
	private _SpwnUnit = selectRandom _HelicopterList;
	_SpwnUnit params ["_Unit",["_Cost",0]];
	_FinalHeliSpawn pushback _Unit;
	_MoneyArray set [0,(_MoneyArray select 0) - (_Cost select 0)];
	_MoneyArray set [1,(_MoneyArray select 1) - (_Cost select 1)];
	_MoneyArray set [2,(_MoneyArray select 2) - (_Cost select 2)];
	_MoneyArray set [3,(_MoneyArray select 3) - (_Cost select 3)];
};
};

if (_AirSpwn > 0 && {_AFactorySwitch}) then
{
for "_i" from 0 to _AirSpwn step 1 do 
{
	private _SpwnUnit = selectRandom _Aircraftlist;
	_SpwnUnit params ["_Unit",["_Cost",0]];
	_FinalAirSpawn pushback _Unit;
	_MoneyArray set [0,(_MoneyArray select 0) - (_Cost select 0)];
	_MoneyArray set [1,(_MoneyArray select 1) - (_Cost select 1)];
	_MoneyArray set [2,(_MoneyArray select 2) - (_Cost select 2)];
	_MoneyArray set [3,(_MoneyArray select 3) - (_Cost select 3)];
};
};


if (count _FinalInfSpawn > 0) then
{
{
	private _unit = _grp createUnit [_x ,_DefenceSpawnPos, [], 50, "CAN_COLLIDE"];
	[_unit,(typeOf _unit)] call DIS_fnc_UniformHandle;
	_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
	[_unit] joinSilent _grp;
	_SpawnedUnitArray pushback _Unit;
} foreach _FinalInfSpawn;
};


if (count _FinalLVSpawn > 0) then
{
{
		private _rnd = random 400;
		private _dist = (_rnd + 25);
		private _dir = random 360;
		
		private _position = [(_DPolePos select 0) + (sin _dir) * _dist, (_DPolePos select 1) + (cos _dir) * _dist, 0];
		
		private _CRoad = [0,0,0];
		_list = _position nearRoads 500;
		if !(_list isEqualTo []) then
		{
			_Road = [_list,_position,true] call dis_closestobj;
			_CRoad = getpos _Road;
		}
		else
		{
			_CRoad = _position;
		};
				
		if (isNil "_CRoad") then {_CRoad = _position;};
		_MoveToPosition = [_CRoad, 15, 250, 5, 0, 20, 0,[],[_CRoad,_CRoad]] call BIS_fnc_findSafePos;
		_positionFIN = _MoveToPosition findEmptyPosition [0,150,_x];	
		if (_positionFIN isEqualTo []) then {_positionFIN = _MoveToPosition};		
		
		_veh = createVehicle [_x,_positionFIN, [], 0, "CAN_COLLIDE"];
		_veh lock 2;

		_veh setVelocity [0,0,0];
		createVehicleCrew _veh;			
		{[_x] joinsilent _grp;_x addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];} forEach crew _veh;
		_SpawnedUnitArray pushback _veh;
} foreach _FinalLVSpawn;
};


if (count _FinalHVSpawn > 0) then
{
{
		private _rnd = random 400;
		private _dist = (_rnd + 25);
		private _dir = random 360;
		
		private _position = [(_DPolePos select 0) + (sin _dir) * _dist, (_DPolePos select 1) + (cos _dir) * _dist, 0];
		
		private _CRoad = [0,0,0];
		_list = _position nearRoads 500;
		if !(_list isEqualTo []) then
		{
			_Road = [_list,_position,true] call dis_closestobj;
			_CRoad = getpos _Road;
		}
		else
		{
			_CRoad = _position;
		};
				
		if (isNil "_CRoad") then {_CRoad = _position;};
		_MoveToPosition = [_CRoad, 15, 250, 5, 0, 20, 0,[],[_CRoad,_CRoad]] call BIS_fnc_findSafePos;
		_positionFIN = _MoveToPosition findEmptyPosition [0,150,_x];	
		if (_positionFIN isEqualTo []) then {_positionFIN = _MoveToPosition};		
		
		_veh = createVehicle [_x,_positionFIN, [], 0, "CAN_COLLIDE"];
		_veh lock 2;

		_veh setVelocity [0,0,0];
		createVehicleCrew _veh;			
		{[_x] joinsilent _grp;_x addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];} forEach crew _veh;
		_SpawnedUnitArray pushback _veh;
} foreach _FinalHVSpawn;
};


if (count _FinalHeliSpawn > 0) then
{
{
		private _rnd = random 400;
		private _dist = (_rnd + 25);
		private _dir = random 360;
		
		private _position = [(_DPolePos select 0) + (sin _dir) * _dist, (_DPolePos select 1) + (cos _dir) * _dist, 1000];		
		_veh = createVehicle [_x,_position, [], 0, "FLY"];
		_veh lock 2;
		createVehicleCrew _veh;			
		{[_x] joinsilent _grp;_x addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];} forEach crew _veh;
		_SpawnedUnitArray pushback _veh;
} foreach _FinalHeliSpawn;
};


if (count _FinalAirSpawn > 0) then
{
{
		private _rnd = random 400;
		private _dist = (_rnd + 25);
		private _dir = random 360;
		
		private _position = [(_DPolePos select 0) + (sin _dir) * _dist, (_DPolePos select 1) + (cos _dir) * _dist, 1000];		
		_veh = createVehicle [_x,_position, [], 0, "FLY"];
		_veh lock 2;
		createVehicleCrew _veh;			
		{[_x] joinsilent _grp;_x addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];} forEach crew _veh;
		_SpawnedUnitArray pushback _veh;
} foreach _FinalAirSpawn;
};


private _waypoint = _grp addwaypoint[_PolePos,1];
_waypoint setwaypointtype "MOVE";
_waypoint setWaypointSpeed "NORMAL";
private _waypoint2 = _grp addwaypoint[_PolePos,1];
_waypoint2 setwaypointtype "MOVE";
_waypoint2 setWaypointSpeed "NORMAL";		
_waypoint setWaypointBehaviour "AWARE";		
_waypoint2 setWaypointBehaviour "AWARE";		
_grp setCurrentWaypoint _waypoint;


private _AIComms = "AIComms" call BIS_fnc_getParamValue;
{
	if (_x isKindOf "Man") then
	{
		if (_AIComms isEqualTo 1) then
		{
			_x call DIS_fnc_UnitInit;
		};
	
	}
	else
	{
	 { 
		if (_AIComms isEqualTo 1) then
		{
			_x call DIS_fnc_UnitInit;
		};		
	 } foreach (crew _x);
	};

} foreach _SpawnedUnitArray;


_SpawnedUnitArray


