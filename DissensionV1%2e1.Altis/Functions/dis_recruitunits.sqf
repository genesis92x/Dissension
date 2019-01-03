//This function will control the spawning of units when the commander requests it to be done. 
//Function rewrote on 9/27/17 @ 1331 - rewrote on 11/16/17 @ 1922
//Goal is to make this function more optimized, and more controlled. This
//[Side,Inf,Light,Heavy,Heli,Air,_TargetLoc,_AdditionalMessage] spawn dis_recruitunits;
Params ["_Side","_AmountToSpawn","_LightSpwn","_HeavySpwn","_HeliSpwn","_AirSpwn","_TargetLocation","_AdditionalMessage","_Ignore"];

if (isNil "_Ignore") then {_Ignore = false;};
private _HC = false;
private _RMEXEC = 2;
if (("HC" call BIS_fnc_getParamValue) isEqualTo 1) then 
{
	if !(isNil "HC") then
	{
		if !(isNull HC) then
		{
			_HC = true;
			_RMEXEC = HC;
		};
	};
};

//Side specific variables
if (isNil "E_GuerC") then {E_GuerC = [];};
if (isNil "W_GuerC") then {W_GuerC = [];};
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
private _BuildingList = E_BuildingList;
private _Commander = Dis_EastCommander;
private _GroupName = E_Groups;
private _MarkerColor = "ColorRed";
private _MarkerType = "o_inf";	
private _ArmyFocus = E_CommanderInfo select 2;
private _AmountToSpawnVeh = 1;
private _CampList = E_GuerC;

private _WestRun = false;
if (_Side isEqualTo West) then 
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
	_BuildingList = W_BuildingList;
	_Commander = Dis_WestCommander;
	_GroupName = W_Groups;
	_ArmyFocus = W_CommanderInfo select 2;
	_MarkerColor = "ColorBlue";
	_MarkerType = "b_inf";		
	_CampList = W_GuerC;	
};

//Once we know which side we are looking at, we need to make sure we are not spawning more than the commander is allowed to do.
private _ActiveUnits = (count _ActiveSide);

if !(_Ignore) then
{
	if (dis_MaxUnit < _ActiveUnits) exitWith {};
}
else
{
	if ((dis_MaxUnit*4) < _ActiveUnits) exitWith {};
};

//If we don't have enough tickets, we should just quit now.
if (_CurrentTickets <= 0) exitWith {};

//Lets determine unique commander compositions.
if (_ArmyFocus isEqualTo "Infantry") then {_AmountToSpawn = _AmountToSpawn + 5};
if (_ArmyFocus isEqualTo "Heavy Armor") then {_HeavySpwn = _HeavySpwn + (round (random 2));};
if (_ArmyFocus isEqualTo "Light Armor") then {_LightSpwn = _LightSpwn + (round (random 3));};
if (_ArmyFocus isEqualTo "Helicraft") then {_HeliSpwn = _HeliSpwn + (round (random 2));};
if (_ArmyFocus isEqualTo "Aircraft") then {_AirSpwn = _AirSpwn  + (round (random 2));};

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

//Find the physical structures here
{
	_Phy = _x select 0;
	if !(isNil "_Phy") then
	{
		_Name = _x select 1;
		if (_Name isEqualTo "Barracks") then {_BarracksSwitch = true;_BarrackList pushback (_x select 0);};
		if (_Name isEqualTo "Light Factory") then {_LFactorySwitch = true;_LightFactoryList pushback (_x select 0);};
		if (_Name isEqualTo "Static Bay") then {_StaticSwitch = true;};
		if (_Name isEqualTo "Heavy Factory") then {_HFactorySwitch = true;_HeavyFactoryList pushback (_x select 0);};
		if (_Name isEqualTo "Air Field") then {_AFactorySwitch = true;_AirFieldFactoryList pushback (_x select 0);};
		if (_Name isEqualTo "Medical Bay") then {_MedBaySwitch = true;};
		if (_Name isEqualTo "Advanced Infantry Barracks") then {_AdvInfSwitch = true;_BarrackList pushback (_x select 0);};
	};
} foreach _BuildingList;


{
	_BarrackList pushback (_x select 0);
} foreach _CampList;

//Compile the list of spawnable units.
if (_BarracksSwitch && {!(_AdvInfSwitch)}) then {_CompleteList pushback _BarracksList};
if (_LFactorySwitch) then {_CompleteList pushback _LFactoryList};
if (_StaticSwitch) then {};
if (_HFactorySwitch) then {_CompleteList pushback _HFactoryList};
if (_AFactorySwitch) then {_CompleteList pushback _AirfieldList};
if (_MedBaySwitch) then {_CompleteList pushback _MedicalList};
if (_AdvInfSwitch) then {_CompleteList pushback _AdvInfList};

//If the complete list is empty then we must have no structures to make units with - exit the function.
if (_CompleteList isEqualTo []) exitWith {};

//Lets compile a complete list of units we can actually spawn.
private _InfantryList = [];
private _Aircraftlist = [];
private _HelicopterList = [];
private _HeavyVehicleList = [];
private _LightVehicleList = [];
private _ShipList = [];
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

//Okay, lets spawn these troops
private _TotalSpawned = 0;
private _FailedAttempt = 0;
private _NewInfSpawnC = 0;
private _FinalInfSpawn = [];
private _FinalLVSpawn = [];
private _FinalHVSpawn = [];
private _FinalHeliSpawn = [];
private _FinalAirSpawn = [];
//Infantry Spawn
if (_AmountToSpawn > 0 && {(_BarracksSwitch || _AdvInfSwitch)} && {count _BarrackList > 0}) then
{
	while {_AmountToSpawn > _NewInfSpawnC && {_FailedAttempt < 50}} do
	{
		private _SpwnUnit = selectRandom _InfantryList;
		private _Unit = _SpwnUnit select 0;
		private _Cost = _SpwnUnit select 1;
		if (((_MoneyArray select 0) - (_Cost select 0)) > 0 && {((_MoneyArray select 1) - (_Cost select 1)) > 0} && {((_MoneyArray select 2) - (_Cost select 2)) > 0} && {((_MoneyArray select 3) - (_Cost select 3)) > 0}) then
		{
			_FinalInfSpawn pushback _Unit;
			_MoneyArray set [0,(_MoneyArray select 0) - (_Cost select 0)];
			_MoneyArray set [1,(_MoneyArray select 1) - (_Cost select 1)];
			_MoneyArray set [2,(_MoneyArray select 2) - (_Cost select 2)];
			_MoneyArray set [3,(_MoneyArray select 3) - (_Cost select 3)];
			_NewInfSpawnC = _NewInfSpawnC + 1;
			_TotalSpawned = _TotalSpawned + 1;
		}
		else
		{
			_FailedAttempt = _FailedAttempt + 1;
		};		
	};
};
//Light Vehicle spawn
private _NewLVehSpwn = 0;
if (_LightSpwn > 0 && {_LFactorySwitch} && {(count _LightFactoryList > 0)}) then
{
	_FailedAttempt = 0;
	while {_LightSpwn > _NewLVehSpwn && {_FailedAttempt < 50}} do
	{
		private _SpwnUnit = selectRandom _LightVehicleList;
		private _Unit = _SpwnUnit select 0;
		private _Cost = _SpwnUnit select 1;
		if (((_MoneyArray select 0) - (_Cost select 0)) > 0 && {((_MoneyArray select 1) - (_Cost select 1)) > 0} && {((_MoneyArray select 2) - (_Cost select 2)) > 0} && {((_MoneyArray select 3) - (_Cost select 3)) > 0}) then
		{
			_FinalLVSpawn pushback _Unit;
			_MoneyArray set [0,(_MoneyArray select 0) - (_Cost select 0)];
			_MoneyArray set [1,(_MoneyArray select 1) - (_Cost select 1)];
			_MoneyArray set [2,(_MoneyArray select 2) - (_Cost select 2)];
			_MoneyArray set [3,(_MoneyArray select 3) - (_Cost select 3)];
			_NewLVehSpwn = _NewLVehSpwn + 1;
			_TotalSpawned = _TotalSpawned + 1;
		}
		else
		{
			_FailedAttempt = _FailedAttempt + 1;
		};		
	};
};
//Heavy vehicle spawn
private _NewHVehSpwn = 0;	
if (_HeavySpwn > 0 && {_HFactorySwitch} && {(count _HeavyFactoryList > 0)}) then
{
	_FailedAttempt = 0;
	while {_HeavySpwn > _NewHVehSpwn && {_FailedAttempt < 50}} do
	{
		private _SpwnUnit = selectRandom _HeavyVehicleList;
		private _Unit = _SpwnUnit select 0;
		private _Cost = _SpwnUnit select 1;
		if (((_MoneyArray select 0) - (_Cost select 0)) > 0 && {((_MoneyArray select 1) - (_Cost select 1)) > 0} && {((_MoneyArray select 2) - (_Cost select 2)) > 0} && {((_MoneyArray select 3) - (_Cost select 3)) > 0}) then
		{
			_FinalHVSpawn pushback _Unit;
			_MoneyArray set [0,(_MoneyArray select 0) - (_Cost select 0)];
			_MoneyArray set [1,(_MoneyArray select 1) - (_Cost select 1)];
			_MoneyArray set [2,(_MoneyArray select 2) - (_Cost select 2)];
			_MoneyArray set [3,(_MoneyArray select 3) - (_Cost select 3)];
			_NewHVehSpwn = _NewHVehSpwn + 1;
			_TotalSpawned = _TotalSpawned + 1;
		}
		else
		{
			_FailedAttempt = _FailedAttempt + 1;
		};		
	};
};
//Heli vehicle spawn
private _NewHeVehSpwn = 0;	
if (_HeliSpwn > 0 && {_AFactorySwitch} && {count _HelicopterList > 0}) then
{
	_FailedAttempt = 0;
	while {_HeliSpwn > _NewHeVehSpwn && {_FailedAttempt < 50}} do
	{
		private _SpwnUnit = selectRandom _HelicopterList;
		private _Unit = _SpwnUnit select 0;
		private _Cost = _SpwnUnit select 1;
		if (((_MoneyArray select 0) - (_Cost select 0)) > 0 && {((_MoneyArray select 1) - (_Cost select 1)) > 0} && {((_MoneyArray select 2) - (_Cost select 2)) > 0} && {((_MoneyArray select 3) - (_Cost select 3)) > 0}) then
		{
			_FinalHeliSpawn pushback _Unit;
			_MoneyArray set [0,(_MoneyArray select 0) - (_Cost select 0)];
			_MoneyArray set [1,(_MoneyArray select 1) - (_Cost select 1)];
			_MoneyArray set [2,(_MoneyArray select 2) - (_Cost select 2)];
			_MoneyArray set [3,(_MoneyArray select 3) - (_Cost select 3)];
			_NewHeVehSpwn = _NewHeVehSpwn + 1;
			_TotalSpawned = _TotalSpawned + 1;
		}
		else
		{
			_FailedAttempt = _FailedAttempt + 1;
		};		
	};
};
//Air vehicle spawn
private _NewAirVehSpwn = 0;	
if (_AirSpwn > 0 && {_AFactorySwitch} && {(count _Aircraftlist) > 0}) then
{
	_FailedAttempt = 0;
	while {_AirSpwn > _NewAirVehSpwn && {_FailedAttempt < 50}} do
	{
		private _SpwnUnit = selectRandom _Aircraftlist;
		private _Unit = _SpwnUnit select 0;
		private _Cost = _SpwnUnit select 1;
		if (((_MoneyArray select 0) - (_Cost select 0)) > 0 && {((_MoneyArray select 1) - (_Cost select 1)) > 0} && {((_MoneyArray select 2) - (_Cost select 2)) > 0} && {((_MoneyArray select 3) - (_Cost select 3)) > 0}) then
		{
			_FinalAirSpawn pushback _Unit;
			_MoneyArray set [0,(_MoneyArray select 0) - (_Cost select 0)];
			_MoneyArray set [1,(_MoneyArray select 1) - (_Cost select 1)];
			_MoneyArray set [2,(_MoneyArray select 2) - (_Cost select 2)];
			_MoneyArray set [3,(_MoneyArray select 3) - (_Cost select 3)];
			_NewAirVehSpwn = _NewAirVehSpwn + 1;
			_TotalSpawned = _TotalSpawned + 1;
		}
		else
		{
			_FailedAttempt = _FailedAttempt + 1;
		};		
	};
};


//After this point we need to hand actually spawning in the troops above.
private _GroupList = [];
private _grp = createGroup _Side;
_grp setVariable ["DIS_IMPORTANT",true];
_GroupList pushback _grp;

//The first step is to spawn the infantry first.
//INFANTRY
//

if (_BarracksSwitch) then
{
	if (_BarrackList isEqualTo []) then {_BarrackList = [_Commander];};
	_NearestBuilding = [_BarrackList,_TargetLocation,true] call dis_closestobj;
	_SpawnPosition = getpos _NearestBuilding;
	
	_rnd = random 100;
	_dist = (_rnd + 25);
	_dir = random 360;
	
	_positions = [(_SpawnPosition select 0) + (sin _dir) * _dist, (_SpawnPosition select 1) + (cos _dir) * _dist, 0];
	_position = [_positions,0,150,0,0,1,0,[],[_positions,_positions]] call BIS_fnc_findSafePos;
	if (_position isEqualTo []) then {_position = _positions};
	
	While {(count _FinalInfSpawn) > 0 && {_CurrentTickets > 0}} do
	{
			_ActualSpawnInf = (_FinalInfSpawn select 0);
			_unit = _grp createUnit [_ActualSpawnInf ,_position, [], 25, "CAN_COLLIDE"];
			[_unit,(typeOf _unit)] call DIS_fnc_UniformHandle;
			_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
			[_unit] joinSilent _grp;			
			_CurrentTickets = _CurrentTickets - 1;
			_ActiveSide pushback _unit;
			_FinalInfSpawn deleteAt 0;
			sleep 1;
	};
};
//
//LIGHT VEHICLES
//

if (_LFactorySwitch) then 
{
if (_LightFactoryList isEqualTo []) then {_LightFactoryList = [_Commander];};
_NearestBuilding = [_LightFactoryList,_TargetLocation,true] call dis_closestobj;
_NearestTown = [FlagPoleArray,_NearestBuilding,true] call dis_closestobj;
_SpawnPosition = getpos _NearestTown;


While {(count _FinalLVSpawn) > 0 && {_CurrentTickets > 0}} do
{
		
		//if (count (units _Unitgrp) > 12) then {_Unitgrp = createGroup _Side;_GroupList pushback _Unitgrp;};
		_ActualSpawnLight = (_FinalLVSpawn select 0);
		
		
		_rnd = random 400;
		_dist = (_rnd + 25);
		_dir = random 360;
		
		_position = [(_SpawnPosition select 0) + (sin _dir) * _dist, (_SpawnPosition select 1) + (cos _dir) * _dist, 0];
		
		private _CRoad = [0,0,0];
		_list = _position nearRoads 1000;
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
		_positionFIN = _MoveToPosition findEmptyPosition [0,150,_ActualSpawnLight];	
		if (_positionFIN isEqualTo []) then {_positionFIN = _MoveToPosition};		
		
		_veh = createVehicle [_ActualSpawnLight,_positionFIN, [], 0, "CAN_COLLIDE"];
		_veh lock true;
		_veh setvariable ["DIS_PLAYERVEH",true];
		_grp addVehicle _veh;
		_veh allowdamage false;
		_veh spawn {sleep 10;_this allowdamage true;};
		createVehicleCrew _veh;			
		{[_x] joinsilent _grp;_ActiveSide pushback _x;_x addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];} forEach crew _veh;

		
		/*
		private _VehSpwn = 0;
		private _VehSeats = fullCrew [_veh,"",true];
		{
			//[<NULL-object>,"cargo",2,[],false]
			if (isNull (_x select 0) && _VehSpwn < 12) then  
			{
				_VehSpwn = _VehSpwn + 1;
				private _SpawnUnit = selectrandom _InfantryList;
				private _unitDO = _grp createUnit [(_SpawnUnit select 0),_positionFIN, [], 25, "CAN_COLLIDE"];
				[_unitDO,(typeof _UnitDO)] call DIS_fnc_UniformHandle;
				_unitDO moveInAny _veh;
				[_unitDO] joinsilent _grp;_unitDO addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
				_ActiveSide pushback _unitDO;
			};
		} foreach _VehSeats;			
		*/
		
		
		
		
		
		//[_Unitgrp,(_ActualSpawnLight select 0)] spawn dis_VehicleManage;
		//[_veh,_Unitgrp] spawn dis_VehicleDespawn;

		
		
		_CurrentTickets = _CurrentTickets - 1;
		_ActiveSide pushback _veh;
		_FinalLVSpawn deleteAt 0;
		sleep 1;
};
};
//
//HEAVY VEHICLES
//

if (_HFactorySwitch) then 
{
if (_HeavyFactoryList isEqualTo []) then {_HeavyFactoryList = [_Commander];};
_NearestBuilding = [_HeavyFactoryList,_TargetLocation,true] call dis_closestobj;
_NearestTown = [FlagPoleArray,_NearestBuilding,true] call dis_closestobj;
_SpawnPosition = getpos _NearestTown;


While {(count _FinalHVSpawn) > 0 && {_CurrentTickets > 0}} do
{
		
		//if (count (units _Unitgrp) > 12) then {_Unitgrp = createGroup _Side;_GroupList pushback _Unitgrp;};
		_ActualSpawnLight = (_FinalHVSpawn select 0);
		
		
		_rnd = random 400;
		_dist = (_rnd + 25);
		_dir = random 360;
		
		_position = [(_SpawnPosition select 0) + (sin _dir) * _dist, (_SpawnPosition select 1) + (cos _dir) * _dist, 0];
		
		private _CRoad = [0,0,0];
		_list = _position nearRoads 1000;
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
		_positionFIN = _MoveToPosition findEmptyPosition [0,150,_ActualSpawnLight];	
		if (_positionFIN isEqualTo []) then {_positionFIN = _MoveToPosition};		
		
		_veh = createVehicle [_ActualSpawnLight,_positionFIN, [], 0, "CAN_COLLIDE"];
		_veh lock true;
		createVehicleCrew _veh;			
		_veh setvariable ["DIS_PLAYERVEH",true];		
		_grp addVehicle _veh;		
		_veh allowdamage false;
		_veh spawn {sleep 10;_this allowdamage true;};		
		{[_x] joinsilent _grp;_ActiveSide pushback _x;_x addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];} forEach crew _veh;
		

		//[_Unitgrp,(_ActualSpawnLight select 0)] spawn dis_VehicleManage;		
		//[_veh,_Unitgrp] spawn dis_VehicleDespawn;
		//_veh spawn dis_UnitStuck;
		
		
		_CurrentTickets = _CurrentTickets - 1;
		_ActiveSide pushback _veh;
		_FinalHVSpawn deleteAt 0;
		sleep 1;
};
};
//
//HELI VEHICLES
//

if (_AFactorySwitch) then 
{
if (_AirFieldFactoryList isEqualTo []) then {_AirFieldFactoryList = [_Commander];};
_NearestBuilding = [_AirFieldFactoryList,_TargetLocation,true] call dis_closestobj;
_NearestTown = [FlagPoleArray,_NearestBuilding,true] call dis_closestobj;
_SpawnPosition = getpos _NearestTown;


While {(count _FinalHeliSpawn) > 0 && {_CurrentTickets > 0}} do
{
		
		//if (count (units _Unitgrp) > 12) then {_Unitgrp = createGroup _Side;_GroupList pushback _Unitgrp;};
		_ActualSpawnLight = (_FinalHeliSpawn select 0);
		
		
		_rnd = random 400;
		_dist = (_rnd + 25);
		_dir = random 360;
		
		_position = [(_SpawnPosition select 0) + (sin _dir) * _dist, (_SpawnPosition select 1) + (cos _dir) * _dist, 0];
		
		private _CRoad = [0,0,0];
		_list = _position nearRoads 1000;
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
		_positionFIN = _MoveToPosition findEmptyPosition [0,150,_ActualSpawnLight];	
		if (_positionFIN isEqualTo []) then {_positionFIN = _MoveToPosition};		
		
		_veh = createVehicle [_ActualSpawnLight,_positionFIN, [], 0, "FLY"];
		_veh lock true;
		_veh setvariable ["DIS_PLAYERVEH",true];		
		_grp addVehicle _veh;
		_veh allowdamage false;
		_veh spawn {sleep 10;_this allowdamage true;};
		createVehicleCrew _veh;	
		{[_x] joinsilent _grp;_ActiveSide pushback _x;_x addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];} forEach crew _veh;

		

		//[_Unitgrp,(_ActualSpawnLight select 0)] spawn dis_VehicleManage;		
		//[_veh,_Unitgrp] spawn dis_VehicleDespawn;
		//_veh spawn dis_UnitStuck;
		
		
		_CurrentTickets = _CurrentTickets - 1;
		_ActiveSide pushback _veh;
		_FinalHeliSpawn deleteAt 0;
		sleep 1;
};

//
//AIR VEHICLES
//
if (_AirFieldFactoryList isEqualTo []) then {_AirFieldFactoryList = [_Commander];};
_NearestBuilding = [_AirFieldFactoryList,_TargetLocation,true] call dis_closestobj;
_NearestTown = [FlagPoleArray,_NearestBuilding,true] call dis_closestobj;
_SpawnPosition = getpos _NearestTown;


While {(count _FinalAirSpawn) > 0 && {_CurrentTickets > 0}} do
{
		
		//if (count (units _Unitgrp) > 12) then {_Unitgrp = createGroup _Side;_GroupList pushback _Unitgrp;};
		_ActualSpawnLight = (_FinalAirSpawn select 0);
		
		
		_rnd = random 400;
		_dist = (_rnd + 25);
		_dir = random 360;
		
		_position = [(_SpawnPosition select 0) + (sin _dir) * _dist, (_SpawnPosition select 1) + (cos _dir) * _dist, 0];
		
		private _CRoad = [0,0,0];
		_list = _position nearRoads 1000;
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
		_positionFIN = _MoveToPosition findEmptyPosition [0,150,_ActualSpawnLight];	
		if (_positionFIN isEqualTo []) then {_positionFIN = _MoveToPosition};		
		
		_veh = createVehicle [_ActualSpawnLight,_positionFIN, [], 0, "FLY"];	
		_veh lock true;
		_veh setvariable ["DIS_PLAYERVEH",true];		
		_veh allowdamage false;
		_veh spawn {sleep 10;_this allowdamage true;};
		createVehicleCrew _veh;			
		{[_x] joinsilent _grp;_ActiveSide pushback _x;_x addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];} forEach crew _veh;
		

		//[_Unitgrp,(_ActualSpawnLight select 0)] spawn dis_VehicleManage;		
		//[_veh,_Unitgrp] spawn dis_VehicleDespawn;
		//_veh spawn dis_UnitStuck;
		
		
		_CurrentTickets = _CurrentTickets - 1;
		_ActiveSide pushback _veh;
		_FinalAirSpawn deleteAt 0;
		sleep 1;
};

};

if (_HC) then
{
	_grp setGroupOwner (owner HC);
	_grp setVariable ["DIS_TRANSFERED",true];
};
	
{

		sleep 5;
		_x setvariable ["DIS_PLAYERVEH",true];
		private _waypoint = _x addwaypoint[_TargetLocation,1];
		_waypoint setwaypointtype "MOVE";
		_waypoint setWaypointSpeed "NORMAL";
		private _waypoint2 = _x addwaypoint[_TargetLocation,1];
		_waypoint2 setwaypointtype "MOVE";
		_waypoint2 setWaypointSpeed "NORMAL";		
		_waypoint setWaypointBehaviour "AWARE";		
		_waypoint2 setWaypointBehaviour "AWARE";		
		_x setCurrentWaypoint _waypoint;

		//[_x,_position] spawn {_Grp = _this select 0;_Pos = _this select 1;sleep 60;_WaypointReached = true;while {({alive _x} count (units _Grp)) > 0 && _WaypointReached} do {if (((leader _grp) distance _Pos) < 50) then {while {(count (waypoints _grp)) > 0} do {deleteWaypoint ((waypoints _grp) select 0);sleep 0.25;};_WaypointReached = false;};};};
		//[_x,_position] spawn dis_WTransportMon;
		
		//Lets find a groupname to assign to this group.
		//Once we find a group name we need to update the array!
		_AvailableGroups = [];
		{
			//["DEVIL",time,time,0,false],
			_InUse = _x select 4;
			if !(_InUse) then {_AvailableGroups pushback [_x,_forEachIndex];};
		} foreach _GroupName;
		_SelRaw = selectRandom _AvailableGroups;
		_SelIndex = _SelRaw select 1;
		_SelInfo = _SelRaw select 0;
		_SelGroupName = _SelInfo select 0;
		_GroupName set [_SelIndex,[(_SelInfo select 0),time,(_SelInfo select 2),(_SelInfo select 3),true,_x]];
		if (_WestRun) then {W_Groups = _GroupName;} else {E_Groups = _GroupName;};
		_x setGroupIdGlobal [_SelGroupName];
		//End of finding the group name!	
		
		//Lets setup the variable to remember how many units this groups has.
		_x setVariable ["DIS_Frstspwn",(count (units _x))];
		
		
		//Lets setup a way to force our units into combat when possible. The commander can still provide orders, but occasionally they should just move to engage nearby targets.
		
		//If we are running a HC, we need to spawn the following function there, and not on the server.
		
		[
		[_x,_Side],
		{
			params ["_grp","_Side"];
			//_grp spawn dis_UnitStuck;
			
			{
				private _AIComms = "AIComms" call BIS_fnc_getParamValue;
				if (_AIComms isEqualTo 1) then
				{
					_x call DIS_fnc_UnitInit;
				};
				private _VehUnit = vehicle _x;
				if (_VehUnit isEqualTo _x) then
				{
					_VehUnit lock 2;
				};
			} foreach (units _grp);
			
			waitUntil
			{
				sleep 60;
				private _Leader = (leader _grp);
				private _NE = _Leader call dis_ClosestEnemy;
				if ((speed _Leader) < 0.1) then
				{
					private _SummedOwned = [];				
					if (_Side isEqualTo west) then {_SummedOwned = BluControlledArray;};
					if (_Side isEqualTo east) then {_SummedOwned = OpControlledArray;};
	
					private _MCaptureArray = [];				
					{
						private _Po = _x select 0;
						if !(_Po in _SummedOwned) then
						{
							_MCaptureArray pushback (_x select 0);
						};	
					} foreach CompleteTaskResourceArray;
	
					//private _Enem = [_MCaptureArray,_Leader,true] call dis_closestobj;
					private _Enem = E_CurrentTargetArray select 0;
					if (_Side isEqualTo West) then {_Enem = W_CurrentTargetArray select 0;};
					if (isNil "_Enem") then {_Enem = [];};
					if !(_Enem isEqualTo []) then
					{
						while {(count (waypoints _grp)) > 1} do
						{
							deleteWaypoint ((waypoints _grp) select 0);
						};
						if !(_Enem isEqualTo [0,0,0]) then
						{
							private _waypoint = _grp addwaypoint[_Enem,1];
							_waypoint setwaypointtype "MOVE";
							_waypoint setWaypointSpeed "NORMAL";
							private _waypoint2 = _grp addwaypoint[_Enem,1];
							_waypoint2 setwaypointtype "MOVE";
							_waypoint2 setWaypointSpeed "NORMAL";					
							_grp setBehaviour "AWARE";
							_grp setCurrentWaypoint _waypoint2;
							
							[
								[_grp,_Side,_Enem],
								{
									params ["_Group","_Side","_TargetLocation"];
									if !(hasInterface) exitWith {};
									if (playerSide isEqualTo _Side) then
									{
										private _Arrow1 = [(getpos (leader _Group)), _TargetLocation, [0.11,0.11,0.11,0.7],[6,3/10,10]] call BIS_fnc_drawArrow;
										_Arrow1 spawn {sleep 120;_this call BIS_fnc_drawArrow;};
									};
								}
								
							] remoteExec ["bis_fnc_Spawn",0]; 					
						};
					};
				};
				(({alive _x} count (units _grp)) < 1)
			};
		}
		] remoteExec ["bis_fnc_Spawn",_RMEXEC];
		
		/*
		[
		[_x,_SelGroupName,_MarkerColor,_MarkerType,_Side,_TargetLocation],
			{
				params ["_Group","_SelGroupName","_MarkerColor","_MarkerType","_Side","_TargetLocation"];
				//private _Marker = createMarkerLocal [format ["ID_%1",_Group],[0,0,0]];
				//_Marker setMarkerColorLocal _MarkerColor;
				//_Marker setMarkerTypeLocal _MarkerType;		
				//_Marker setMarkerShapeLocal 'ICON';
				
				//if (isServer) then {[_Side,_Marker,_Group,"Recruit"] call DIS_fnc_mrkersave;};
				if (playerSide isEqualTo _Side) then
				{
					//_Marker setMarkerAlphaLocal 1;
					private _Arrow1 = [(getpos (leader _Group)), _TargetLocation, [0.11,0.11,0.11,0.7],[6,3/10,10]] call BIS_fnc_drawArrow;
					_Arrow1 spawn {sleep 50;_this call BIS_fnc_drawArrow;};
				}
				else
				{
					//_Marker setMarkerAlphaLocal 0;
				};			
				
				//_Marker setMarkerSizeLocal [0.5,0.5];	
				waitUntil
				{
					if (playerSide isEqualTo _Side) then
					{
							private _ldr = (leader _Group);
							private _ldrp = getpos _ldr;
							private _index = currentWaypoint _Group;					
							private _wPos = waypointPosition [_Group, _index];
							if (!(_wPos isEqualTo [0,0,0]) && {!(_ldrp isEqualTo [0,0,0])}) then
							{
								private _Arrow1 = [_ldrp,_wPos, [0.11,0.11,0.11,0.7],[6,3/10,10]] call BIS_fnc_drawArrow;
								_Arrow1 spawn {sleep 50;_this call BIS_fnc_drawArrow;};					
							};
					};
					//_Marker setMarkerDirLocal (getdir (leader _Group));
					//_Marker setMarkerTextLocal format ["%2: %1",({alive _x} count (units _Group)),_SelGroupName];
					//_Marker setMarkerPosLocal (getposASL (leader _Group));		
					sleep 60;
					(({alive _x} count (units _Group)) < 1)
				};
				//sleep 5;
				//deleteMarkerLocal _Marker;
			}
			
		] remoteExec ["bis_fnc_Spawn",0]; 
		*/
		
} foreach _GroupList;


_FailedRecruitment = "Yes. All units successfully recruited";

if (_WestRun) then 
{
	W_RArray = _MoneyArray;
	W_ActiveUnits = _ActiveSide;
	Dis_BluforTickets = _CurrentTickets;
	
	publicVariable "W_RArray";
	publicVariable "W_ActiveUnits";
	publicVariable "Dis_BluforTickets";
	
	if (_FailedAttempt >= 25) then 
	{
		_FailedRecruitment = "No. We ran out of necessary resources for all requested units.";
		W_LowResources = true;
	};
	_AddNewsArray = ["Recruitment",format 
	[
	"We have recruited units to further our cause! May they crush our enemies!<br/>
	%8<br/>
	Their current target location is: %7<br/><br/>
	RECRUITMENT REPORT:<br/>
	%1 Infantry.<br/>
	%2 Light Vehicles<br/>
	%3 Heavy Vehicles<br/>
	%4 Aircraft<br/>
	%5 Ships<br/><br/>
	Were we able to recruit all requested units?<br/>
	%6<br/>
	END OF REPORT
	"
	
	,_NewInfSpawnC,_NewLVehSpwn,_NewHVehSpwn,_NewHeVehSpwn,_NewAirVehSpwn,_FailedRecruitment,(mapGridPosition _TargetLocation),_AdditionalMessage
	]
	];
	dis_WNewsArray pushback _AddNewsArray;
	publicVariable "dis_WNewsArray";
	
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",West];
	["RECRUITMENT",'#FFFFFF'] remoteExec ["MessageFramework",West];
	[West,11] call DIS_fnc_CommanderSpeak;
}
else
{
	E_RArray = _MoneyArray;
	E_ActiveUnits = _ActiveSide;
	Dis_OpforTickets = _CurrentTickets;
	
	publicVariable "E_RArray";
	publicVariable "E_ActiveUnits";
	publicVariable "Dis_OpforTickets";
		
	if (_FailedAttempt >= 25) then {_FailedRecruitment = "No. We ran out of necessary resources for all requested units.";E_LowResources = true;};
	_AddNewsArray = ["Recruitment",format 
	[
	"We have recruited units to further our cause! May they crush our enemies!<br/>
	%8<br/>
	Their current target location is: %7<br/><br/>
	RECRUITMENT REPORT:<br/>
	%1 Infantry.<br/>
	%2 Light Vehicles<br/>
	%3 Heavy Vehicles<br/>
	%4 Helicraft<br/>
	%5 Aircraft<br/><br/>
	Were we able to recruit all requested units?<br/>
	%6<br/>
	END OF REPORT
	"
	
	,_NewInfSpawnC,_NewLVehSpwn,_NewHVehSpwn,_NewHeVehSpwn,_NewAirVehSpwn,_FailedRecruitment,(mapGridPosition _TargetLocation),_AdditionalMessage
	]
	];
	dis_ENewsArray pushback _AddNewsArray;
	publicVariable "dis_ENewsArray";
	
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",East];
	["RECRUITMENT",'#FFFFFF'] remoteExec ["MessageFramework",East];
	[East,11] call DIS_fnc_CommanderSpeak;
	
	





};