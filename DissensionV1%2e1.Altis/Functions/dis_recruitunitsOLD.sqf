//This function will control the spawning of units when the commander requests it to be done. 
//Function rewrote on 9/27/17 @ 1331
//Goal is to make this function more optimized, and more controlled.

Params ["_Side","_AmountToSpawn","_TargetLocation","_AdditionalMessage"];






//We will need to make changes based on what side is calling this function.

//Predefine variables here.
private _ActiveSide = nil;
private _CurrentTickets = nil;
private _WestRun = true;
private _StaticList = [];
private _BarracksList = nil;
private _LFactoryList = nil;
private _HFactoryList = nil;
private _AirfieldList = nil;
private _MedicalList = nil;
private _AdvInfList = nil;
private _TeamLeader = nil;
private _SquadLeader = nil;
private _BuildingList = nil;
private _MoneyArray = [0,0,0,0];
private _Commander = nil;
private _Tickets = 0;
private _GroupName = nil;
private _MarkerColor = nil;
private _MarkerType = nil;
private _CRoad = [0,0,0];

if (_Side isEqualTo West) then
{
	
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
	_MarkerColor = "ColorBlue";
	_MarkerType = "b_inf";	
};

if (_Side isEqualTo East) then
{
	_MoneyArray = E_RArray;
	_ActiveSide = E_ActiveUnits;
	_CurrentTickets = Dis_OpforTickets;
	_WestRun = false;
	_BarracksList = E_BarrackU;
	_LFactoryList = E_LFactU;
	_HFactoryList = E_HFactU;
	_AirfieldList = E_AirU;
	_MedicalList = E_MedU;
	_AdvInfList = E_AdvU;
	_TeamLeader = E_TeamLU;
	_SquadLeader = E_SquadLU;
	_BuildingList = E_BuildingList;
	_Commander = Dis_EastCommander;
	_GroupName = E_Groups;
	_MarkerColor = "ColorRed";
	_MarkerType = "o_inf";		
};

//We will just quit this function if the unit limit is reached on the side or on the map total.
private _MaxCount = "AISoftCap" call BIS_fnc_getParamValue;
private _ActiveUnits = count _ActiveSide;
if (dis_MaxUnit < _ActiveUnits || _MaxCount < _ActiveUnits) exitWith {};

//If we don't have enough tickets, we should just quit now.
if (_CurrentTickets <= 0) exitWith
{
	_AddNewsArray = ["No Manpower", 
	"
	We are out of tickets! We need more tickets before we can spawn any more units!
	"
	];
	if (_WestRun) then 
	{
		dis_WNewsArray pushback _AddNewsArray;
		publicVariable "dis_WNewsArray";
		["Beep_Target"] remoteExec ["PlaySoundEverywhere",West];
		["LACK OF MANPOWER: RECRUITMENT FAILED",'#FFFFFF'] remoteExec ["MessageFramework",West];
	} 
	else 
	{
		dis_ENewsArray pushback _AddNewsArray;
		publicVariable "dis_ENewsArray";
		["Beep_Target"] remoteExec ["PlaySoundEverywhere",East];
		["LACK OF MANPOWER: RECRUITMENT FAILED",'#FFFFFF'] remoteExec ["MessageFramework",East];	
	};
	
	
};

//Now we need to determine what the commander currently has access to.
//																	0																											1																							2																						3																													4													 									5																												6																					
//dis_ListOfBuildings = [[W_Barracks,[10,20,0,25],"Land_i_Barracks_V2_F"],[W_LightFactory,[20,40,0,50],"Land_MilOffices_V1_F"],[W_StaticBay,[15,25,0,20],"Land_Shed_Big_F"][W_HeavyFactory,[40,60,0,100],"Land_dp_smallFactory_F"],[W_Airfield,[80,120,0,200],"Land_Hangar_F"],[W_MedicalBay,[15,25,0,30],"Land_Research_house_V1_F"],[W_AdvInfantry,[30,30,0,30],"Land_Bunker_F"]];
//_Listofbuildings = [["Land_i_Barracks_V2_F","Barracks"],["Land_MilOffices_V1_F","Light Factory"],["Land_Shed_Big_F","Static Bay"],["Land_dp_smallFactory_F","Heavy Factory"],["Land_Hangar_F","Air Field"],["Land_Research_house_V1_F","Medical Bay"],["Land_Bunker_F","Advanced Infantry Barracks"]];

private _CompleteList = [];
private _BarracksSwitch = false;
private _LFactorySwitch = false;
private _StaticSwitch = false;
private _HFactorySwitch = false;
private _AFactorySwitch = false;
private _MedBaySwitch = false;
private _AdvInfSwitch = false;

{
	_Phy = _x select 0;
	_Name = _x select 1;
	if (_Name isEqualTo "Barracks") then {_BarracksSwitch = true;};
	if (_Name isEqualTo "Light Factory") then {_LFactorySwitch = true;};
	if (_Name isEqualTo "Static Bay") then {_StaticSwitch = true;};
	if (_Name isEqualTo "Heavy Factory") then {_HFactorySwitch = true;};
	if (_Name isEqualTo "Air Field") then {_AFactorySwitch = true;};
	if (_Name isEqualTo "Medical Bay") then {_MedBaySwitch = true;};
	if (_Name isEqualTo "Advanced Infantry Barracks") then {_AdvInfSwitch = true;};
} foreach _BuildingList;

if (_BarracksSwitch) then {_CompleteList pushback _BarracksList};
if (_LFactorySwitch) then {_CompleteList pushback _LFactoryList};
if (_StaticSwitch) then {_CompleteList pushback _StaticList};
if (_HFactorySwitch) then {_CompleteList pushback _HFactoryList};
if (_AFactorySwitch) then {_CompleteList pushback _AirfieldList};
if (_MedBaySwitch) then {_CompleteList pushback _MedicalList};
if (_AdvInfSwitch) then {_CompleteList pushback _AdvInfList};
if (_AdvInfSwitch) then {_CompleteList pushback _AdvInfList};

//If _CompleteList == [] then that means we have no unit producing structures! We have to wait >:|
if (_CompleteList isEqualTo []) exitWith 
{
	_AddNewsArray = ["Recruitment Failed", 
	"
	We have no structures to make units with.
	"
	];
	if (_WestRun) then 
	{
		dis_WNewsArray pushback _AddNewsArray;
		publicVariable "dis_WNewsArray";
		["Beep_Target"] remoteExec ["PlaySoundEverywhere",West];
		["NO UNIT PRODUCING STRUCTURES: RECRUITMENT FAILED",'#FFFFFF'] remoteExec ["MessageFramework",West];
	} 
	else 
	{
		dis_ENewsArray pushback _AddNewsArray;
		publicVariable "dis_ENewsArray";
		["Beep_Target"] remoteExec ["PlaySoundEverywhere",East];
		["NO UNIT PRODUCING STRUCTURES: RECRUITMENT FAILED",'#FFFFFF'] remoteExec ["MessageFramework",East];	
	};		
};

//AI will prefer a ratio of men,vehicles,aircraft. So let's see how many infantry/vehicles/aircraft we can even spawn
_InfantryList = [];
_LightVehicleList = [];
_HeavyVehicleList = [];
_Aircraftlist = [];
_ShipList = [];

//Lets compile a complete list of units we can actually spawn.
{
	_GroupArray = _x;
	{
		_Unit = _x select 0;
		//_Cost = _x select 1;
		if (_Unit isKindOf "Man") then {_InfantryList pushback _x}; 
		if (_Unit isKindOf "Air") then {_Aircraftlist pushback _x}; 
		if (_Unit isKindOf "Tank") then {_HeavyVehicleList pushback _x}; 
		if (_Unit isKindOf "Car") then {_LightVehicleList pushback _x}; 
		if (_Unit isKindOf "Ship") then {_ShipList pushback _x}; 
	} foreach _GroupArray;
} foreach _CompleteList;

//Lets determine how much of each to spawn in.
//W_CommanderInfo = [_RandomName,_BirthDate,_FinalFocus,_MoodTrait];
//_FinalFocus = ["Infantry","Heavy Armor","Light Armor","Helicraft","Aircraft"];
_ArmyFocus = W_CommanderInfo select 2;


private _PrefInfRatio = 0.70;
private _PrefLRatio = 0.15;
private _PrefHRatio = 0.05;
private _PrefAirRatio = 0.05;
private _PrefShipRatio = 0.05;

if (_ArmyFocus isEqualTo "Infantry") then 
{
	_PrefInfRatio = 0.80;
	_PrefLRatio = 0.5;
	_PrefHRatio = 0.05;
	_PrefAirRatio = 0.05;
	_PrefShipRatio = 0.05;
};
if (_ArmyFocus isEqualTo "Heavy Armor") then 
{
	_PrefInfRatio = 0.65;
	_PrefLRatio = 0.05;
	_PrefHRatio = 0.20;
	_PrefAirRatio = 0.05;
	_PrefShipRatio = 0.05;
};
if (_ArmyFocus isEqualTo "Light Armor") then 
{
	_PrefInfRatio = 0.65;
	_PrefLRatio = 0.20;
	_PrefHRatio = 0.05;
	_PrefHRatio = 0.05;
	_PrefAirRatio = 0.05;
	_PrefShipRatio = 0.05;
};
if (_ArmyFocus isEqualTo "Helicraft" || {_ArmyFocus isEqualTo "Aircraft"}) then 
{
	_PrefInfRatio = 0.65;
	_PrefLRatio = 0.05;
	_PrefHRatio = 0.05;
	_PrefAirRatio = 0.20;
	_PrefShipRatio = 0.05;
};


private _InfantryList2 = [];
private _LightVehicleList2 = [];
private _HeavyVehicleList2 = [];
private _Aircraftlist2 = [];
private _ShipList2 = [];

{
	if (_x isKindOf "Man") then {_InfantryList2 pushback _x}; 
	if (_x isKindOf "Air") then {_Aircraftlist2 pushback _x}; 
	if (_x isKindOf "Tank") then {_HeavyVehicleList2 pushback _x}; 
	if (_x isKindOf "Car") then {_LightVehicleList2 pushback _x}; 
	if (_x isKindOf "Ship") then {_ShipList2 pushback _x};
} foreach _ActiveSide;


//Once we have the breakdown of each we can divide each one by the total sum to figure out their current percentages.
private _InfRatio = 0;
private _LRatio = 0;
private _HRatio = 0;
private _AirRatio = 0;
private _ShipRatio = 0;


_TotalSum = (count _InfantryList2) + (count _Aircraftlist2) + (count _HeavyVehicleList2) + (count _LightVehicleList2) + (count _ShipList2);
if !(_TotalSum isEqualTo 0) then
{
	_InfRatio = (count _InfantryList2)/_TotalSum;
	_LRatio = (count _LightVehicleList2)/_TotalSum;
	_HRatio = (count _HeavyVehicleList2)/_TotalSum;
	_AirRatio = (count _Aircraftlist2)/_TotalSum;
	_ShipRatio = (count _ShipList2)/_TotalSum;
}
else
{
	_InfRatio = 0;
	_LRatio = 0;
	_HRatio = 0;
	_AirRatio = 0;
	_ShipRatio = 0;
};

//_MoneyArray = [W_Oil,W_Power,W_Cash,W_Materials];
//Okay. Lets begin making up deficts here
private _TotalSpawned = 0;
private _FailedAttempt = 0;
private _FinalASpawn = [];
private _FinalHSpawn = [];
private _FinalLSpawn = [];
private _FinalInfSpawn = [];
private _FinalSSpawn = [];
private _AnySpawnedYet = 0;


while {_TotalSpawned < _AmountToSpawn && {_FailedAttempt < 25}} do
{
	//Lets spawn some infantry!
	if (count _InfantryList > 0) then 
	{
		if (_InfRatio < _PrefInfRatio || _AnySpawnedYet isEqualto 10 || (count _LightVehicleList <= 0)) then
		{
			_DivideAmount = round (_AmountToSpawn * _PrefInfRatio);
			_NewInfSpawnC = 0;
			while {_TotalSpawned < _AmountToSpawn && {_NewInfSpawnC < _DivideAmount} && {_FailedAttempt < 25}} do
			{
				_RandomSel = selectRandom _InfantryList;			
				_Unit = _RandomSel select 0;
				_Cost = _RandomSel select 1;
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
			_AnySpawnedYet = 1;
		};	
	};
	
	//Lets spawn some Light Vehicles!
	if (count _LightVehicleList > 0) then 
	{
		if (_LRatio < _PrefLRatio || _AnySpawnedYet isEqualto 10) then
		{
			_DivideAmount = round (_AmountToSpawn * _PrefLRatio);
			_NewLSpawnC = 0;
			while {_TotalSpawned < _AmountToSpawn && {_NewLSpawnC < _DivideAmount} && {_FailedAttempt < 25}} do
			{
				_RandomSel = selectRandom _LightVehicleList;			
				_Unit = _RandomSel select 0;
				_Cost = _RandomSel select 1;
				
				if (((_MoneyArray select 0) - (_Cost select 0)) > 0 && {((_MoneyArray select 1) - (_Cost select 1)) > 0} && {((_MoneyArray select 2) - (_Cost select 2)) > 0} && {((_MoneyArray select 3) - (_Cost select 3)) > 0}) then
				{
					_FinalLSpawn pushback [_Unit,_Cost];
					_MoneyArray set [0,(_MoneyArray select 0) - (_Cost select 0)];
					_MoneyArray set [1,(_MoneyArray select 1) - (_Cost select 1)];
					_MoneyArray set [2,(_MoneyArray select 2) - (_Cost select 2)];
					_MoneyArray set [3,(_MoneyArray select 3) - (_Cost select 3)];
					_NewLSpawnC = _NewLSpawnC + 1;
					_TotalSpawned = _TotalSpawned + 2;
				}
				else
				{
					_FailedAttempt = _FailedAttempt + 1;
				};				
				
			};
			_AnySpawnedYet = 2;
		};	
	
	};

	//Lets spawn some Heavy Vehicles!
	if (count _HeavyVehicleList > 0) then
	{
		if (_HRatio < _PrefHRatio || _AnySpawnedYet isEqualto 10) then
		{
			_DivideAmount = round (_AmountToSpawn * _PrefHRatio);
			_NewHSpawnC = 0;
			while {_TotalSpawned < _AmountToSpawn && {_NewHSpawnC < _DivideAmount} && {_FailedAttempt < 25}} do
			{
				_RandomSel = selectRandom _HeavyVehicleList;			
				_Unit = _RandomSel select 0;
				_Cost = _RandomSel select 1;
				
				if (((_MoneyArray select 0) - (_Cost select 0)) > 0 && {((_MoneyArray select 1) - (_Cost select 1)) > 0} && {((_MoneyArray select 2) - (_Cost select 2)) > 0} && {((_MoneyArray select 3) - (_Cost select 3)) > 0}) then
				{
					_FinalHSpawn pushback [_Unit,_Cost];
					_MoneyArray set [0,(_MoneyArray select 0) - (_Cost select 0)];
					_MoneyArray set [1,(_MoneyArray select 1) - (_Cost select 1)];
					_MoneyArray set [2,(_MoneyArray select 2) - (_Cost select 2)];
					_MoneyArray set [3,(_MoneyArray select 3) - (_Cost select 3)];
					_NewHSpawnC = _NewHSpawnC + 1;
					_TotalSpawned = _TotalSpawned + 3;
				}
				else
				{
					_FailedAttempt = _FailedAttempt + 1;
				};				
				
			};
			_AnySpawnedYet = 3;			
		};		
	};
	
	//Lets spawn some aircraft!
	if (count _Aircraftlist > 0) then 
	{
		if (_AirRatio < _PrefAirRatio || _AnySpawnedYet isEqualto 10) then
		{
			_DivideAmount = round (_AmountToSpawn * _PrefAirRatio);
			_NewASpawnC = 0;
			while {_TotalSpawned < _AmountToSpawn && {_NewASpawnC < _DivideAmount} && {_FailedAttempt < 25}} do
			{
				_RandomSel = selectRandom _Aircraftlist;			
				_Unit = _RandomSel select 0;
				_Cost = _RandomSel select 1;
				
				if (((W_RArray select 0) - (_Cost select 0)) > 0 && {((W_RArray select 1) - (_Cost select 1)) > 0} && {((W_RArray select 2) - (_Cost select 2)) > 0} && {((W_RArray select 3) - (_Cost select 3)) > 0}) then
				{
					_FinalASpawn pushback _Unit;
					W_RArray set [0,(W_RArray select 0) - (_Cost select 0)];
					W_RArray set [1,(W_RArray select 1) - (_Cost select 1)];
					W_RArray set [2,(W_RArray select 2) - (_Cost select 2)];
					W_RArray set [3,(W_RArray select 3) - (_Cost select 3)];
					_NewASpawnC = _NewASpawnC + 1;
					_TotalSpawned = _TotalSpawned + 4;
				}
				else
				{
					_FailedAttempt = _FailedAttempt + 1;
				};				
				
			};
			_AnySpawnedYet = 4;
		};		
	};
	
	//Lets spawn some boats!
	if (count _ShipList > 0) then 
	{
		if (_ShipRatio < _PrefShipRatio || _AnySpawnedYet isEqualto 10) then
		{
			_DivideAmount = round (_AmountToSpawn * _PrefShipRatio);
			_NewSSpawnC = 0;
			while {_TotalSpawned < _AmountToSpawn && {_NewSSpawnC < _DivideAmount} && {_FailedAttempt < 25}} do
			{
				_RandomSel = selectRandom _ShipList;			
				_Unit = _RandomSel select 0;
				_Cost = _RandomSel select 1;
				
				if (((W_RArray select 0) - (_Cost select 0)) > 0 && {((W_RArray select 1) - (_Cost select 1)) > 0} && {((W_RArray select 2) - (_Cost select 2)) > 0} && {((W_RArray select 3) - (_Cost select 3)) > 0}) then
				{
					_FinalSSpawn pushback _Unit;
					W_RArray set [0,(W_RArray select 0) - (_Cost select 0)];
					W_RArray set [1,(W_RArray select 1) - (_Cost select 1)];
					W_RArray set [2,(W_RArray select 2) - (_Cost select 2)];
					W_RArray set [3,(W_RArray select 3) - (_Cost select 3)];
					_NewSSpawnC = _NewSSpawnC + 1;
					_TotalSpawned = _TotalSpawned + 5;
				}
				else
				{
					_FailedAttempt = _FailedAttempt + 1;
				};
				
			};
			_AnySpawnedYet = 5;
		};		
	};	
	if (_AnySpawnedYet isEqualTo 0) then {_AnySpawnedYet = 10};	
	_FailedAttempt = _FailedAttempt + 1;	
	

};


if (_TotalSpawned isEqualTo 0) exitWith
{
	_AddNewsArray = ["Recruitment Failed", 
	"
	We could not request additional units due to resource restrictions. Get more territories!.
	"
	];
	if (_WestRun) then 
	{
		dis_WNewsArray pushback _AddNewsArray;
		publicVariable "dis_WNewsArray";
		["Beep_Target"] remoteExec ["PlaySoundEverywhere",West];
		["RECRUITMENT FAILED",'#FFFFFF'] remoteExec ["MessageFramework",West];
	} 
	else 
	{
		dis_ENewsArray pushback _AddNewsArray;
		publicVariable "dis_ENewsArray";
		["Beep_Target"] remoteExec ["PlaySoundEverywhere",East];
		["RECRUITMENT FAILED",'#FFFFFF'] remoteExec ["MessageFramework",East];	
	};	
};


//Finally...Lets spawn the actual units
//Lets separate all our buildings so we know where to spawn our units.
private _BarrackList = [];
private _LightFactoryList = [];
private _HeavyFactoryList = [];
private _AirFieldFactoryList =	[];
private _ShipFactoryList = [];
private _GroupList = [];
{
	_Building = _x select 0;
	if !(isNil "_Building") then
	{
		_Type = _x select 1;
		if (_Type isEqualTo "Barracks") then {_BarrackList pushback (_x select 0);};
		if (_Type isEqualTo "Light Factory") then {_LightFactoryList pushback (_x select 0);};
		if (_Type isEqualTo "Heavy Factory") then {_HeavyFactoryList pushback (_x select 0);};
		if (_Type isEqualTo "Air Field") then {_AirFieldFactoryList pushback (_x select 0);};
		if (_Type isEqualTo "Ship Factory") then {_ShipFactoryList pushback (_x select 0);};
	};
} foreach _BuildingList;





//Lets physically spawn the infantry first.
if (_BarrackList isEqualTo []) then {_BarrackList = [_Commander];};
_NearestBuilding = [_BarrackList,_TargetLocation,true] call dis_closestobj;
_SpawnPosition = getpos _NearestBuilding;

_rnd = random 100;
_dist = (_rnd + 25);
_dir = random 360;

_positions = [(_SpawnPosition select 0) + (sin _dir) * _dist, (_SpawnPosition select 1) + (cos _dir) * _dist, 0];
_position = [_positions,0,150,0,0,1,0,[],[]] call BIS_fnc_findSafePos;
//_position = _positions findEmptyPosition [0,250,"I_Soldier_LAT_F"];	
if (_position isEqualTo []) then {_position = _positions};

private _grp = createGroup _Side;
if ((count _FinalInfSpawn) > 0 && _CurrentTickets > 0) then
{
	private _unit = _grp createUnit [(_TeamLeader select 0 select 0),_position, [], 25, "FORM"];
	[_unit] joinSilent _grp;	
	_GroupList pushback _grp;
	_CurrentTickets = _CurrentTickets - 1;
	_ActiveSide pushback _unit;
};
_FinalInfSpawnC = count _FinalInfSpawn;
While {(count _FinalInfSpawn) > 0 && _CurrentTickets > 0} do
{
		_ActualSpawnInf = (_FinalInfSpawn select 0);
		_unit = _grp createUnit [_ActualSpawnInf ,_position, [], 25, "FORM"];
		[_unit] joinSilent _grp;			
		_CurrentTickets = _CurrentTickets - 1;
		_ActiveSide pushback _unit;
		_FinalInfSpawn set [0,"DELETE"];
		_FinalInfSpawn = _FinalInfSpawn - ["DELETE"];
		sleep 1;
};










//Lets physically spawn the light vehicles second.
if (_LightFactoryList isEqualTo []) then {_LightFactoryList = [_Commander];};
_NearestBuilding = [_LightFactoryList,_TargetLocation,true] call dis_closestobj;
_NearestTown = [FlagPoleArray,_NearestBuilding,true] call dis_closestobj;
_SpawnPosition = getpos _NearestTown;



_FinalLSpawnC = count _FinalLSpawn;
private _Unitgrp = createGroup _Side;
_GroupList pushback _Unitgrp;
While {(count _FinalLSpawn) > 0 && _CurrentTickets > 0} do
{
		
		//if (count (units _Unitgrp) > 12) then {_Unitgrp = createGroup _Side;_GroupList pushback _Unitgrp;};
		_ActualSpawnLight = (_FinalLSpawn select 0);
		
		
		_rnd = random 400;
		_dist = (_rnd + 25);
		_dir = random 360;
		
		_position = [(_SpawnPosition select 0) + (sin _dir) * _dist, (_SpawnPosition select 1) + (cos _dir) * _dist, 0];
		
		
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
				
		_MoveToPosition = [_CRoad, 15, 250, 5, 0, 20, 0,[],[_CRoad,_CRoad]] call BIS_fnc_findSafePos;
		_positionFIN = _MoveToPosition findEmptyPosition [0,150,(_ActualSpawnLight select 0)];	
		if (_positionFIN isEqualTo []) then {_positionFIN = _MoveToPosition};		
		
		_veh = (_ActualSpawnLight select 0) createVehicle _positionFIN;
		_veh allowdamage false;
		_veh spawn {sleep 10;_this allowdamage true;};
		createVehicleCrew _veh;			
		private _Unitgrp = createGroup _Side;
		{[_x] joinsilent _Unitgrp} forEach crew _veh;
		_GroupList pushback _Unitgrp;
		
		_MaterialCost = (((_FinalLSpawn select 0) select 1) select 3);
		
		
		for "_i" from 1 to (round (_MaterialCost/5)) do 
		{
			_SpawnUnit = selectrandom _InfantryList;
			_unit = _Unitgrp createUnit [(_SpawnUnit select 0) ,_positionFIN, [], 25, "FORM"];
			[_unit] joinSilent _Unitgrp;
			_Unit moveInAny _veh;
			_ActiveSide pushback _Unit;
			_CurrentTickets = _CurrentTickets - 1;
			_FinalInfSpawnC = _FinalInfSpawnC + 1;
			sleep 1;
		};
		[_Unitgrp,(_ActualSpawnLight select 0)] spawn dis_VehicleManage;		
		[_veh,_Unitgrp] spawn dis_VehicleDespawn;
		_veh spawn dis_UnitStuck;
		
		
		_CurrentTickets = _CurrentTickets - 1;
		_ActiveSide pushback _veh;
		_FinalLSpawn set [0,"DELETE"];
		_FinalLSpawn = _FinalLSpawn - ["DELETE"];
		sleep 1;
};


//Lets physically spawn the heavy vehicles.
//Vehicles will each individually be in their own group

if (_HeavyFactoryList isEqualTo []) then {_HeavyFactoryList = [_Commander];};
_NearestBuilding = [_HeavyFactoryList,_TargetLocation,true] call dis_closestobj;
_SpawnPosition = getpos _NearestBuilding;



_FinalHSpawnC = count _FinalHSpawn;
While {(count _FinalHSpawn) > 0 && _CurrentTickets > 0} do
{
		_ActualSpawnHeavy = (_FinalHSpawn select 0);
		
		_rnd = random 100;
		_dist = (_rnd + 25);
		_dir = random 360;
		_position = [(_SpawnPosition select 0) + (sin _dir) * _dist, (_SpawnPosition select 1) + (cos _dir) * _dist, 0];

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
				
		_positionFIN = _CRoad findEmptyPosition [0,150,(_ActualSpawnHeavy select 0)];	
		if (_positionFIN isEqualTo []) then {_positionFIN = _CRoad};

		_veh = (_ActualSpawnHeavy select 0) createVehicle _positionFIN;
		_veh spawn dis_UnitStuck;
		_CurrentTickets = _CurrentTickets - 1;
		_ActiveSide pushback _veh;
		_FinalHSpawn set [0,"DELETE"];
		_FinalHSpawn = _FinalHSpawn - ["DELETE"];
		_grp = creategroup _Side;
		createVehicleCrew _veh;			
		{[_x] joinsilent _grp} forEach crew _veh;
		_GroupList pushback (group _veh);	
		sleep 1;
		
};





//Lets physically spawn the air vehicles.
//Vehicles will each individually be in their own group

if (_AirFieldFactoryList isEqualTo []) then {_AirFieldFactoryList = [_Commander];};
_NearestBuilding = [_AirFieldFactoryList,_TargetLocation,true] call dis_closestobj;
_SpawnPosition = getpos _NearestBuilding;





_FinalASpawnC = count _FinalASpawn;
While {(count _FinalASpawn) > 0 && _CurrentTickets > 0} do
{

		_ActualSpawnAir = (_FinalASpawn select 0);			
		_rnd = random 100;
		_dist = (_rnd + 25);
		_dir = random 360;
		
		_position = [(_SpawnPosition select 0) + (sin _dir) * _dist, (_SpawnPosition select 1) + (cos _dir) * _dist, 0];

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
				
		_positionFIN = _CRoad findEmptyPosition [0,150,(_ActualSpawnAir select 0)];	
		if (_positionFIN isEqualTo []) then {_positionFIN = _CRoad};

		_veh = createVehicle [(_ActualSpawnAir select 0),_positionFIN, [], 0, "FLY"];
		//_veh addEventHandler ["killed",{W_ActiveUnits = W_ActiveUnits - [(_this select 0)];}];
		_CurrentTickets = _CurrentTickets - 1;
		_ActiveSide pushback _veh;
		_FinalASpawn set [0,"DELETE"];
		_FinalASpawn = _FinalASpawn - ["DELETE"];
		_grp = creategroup _Side;
		createVehicleCrew _veh;			
		{[_x] joinsilent _grp} forEach crew _veh;
		_GroupList pushback (group _veh);	
		sleep 1;
		
};



//Lets physically spawn the boat vehicles.
//Vehicles will each individually be in their own group

if (_ShipFactoryList isEqualTo []) then {_ShipFactoryList = [_Commander];};
_NearestBuilding = [_ShipFactoryList,_TargetLocation,true] call dis_closestobj;
_SpawnPosition = getpos _NearestBuilding;


_rnd = random 100;
_dist = (_rnd + 25);
_dir = random 360;

_positions = [(_SpawnPosition select 0) + (sin _dir) * _dist, (_SpawnPosition select 1) + (cos _dir) * _dist, 0];
_position = _positions findEmptyPosition [0,150,"I_Soldier_LAT_F"];	
if (_position isEqualTo []) then {_position = _positions};


_FinalSSpawnC = count _FinalSSpawn;
While {(count _FinalSSpawn) > 0 && _CurrentTickets > 0} do
{

		_ActualSpawnShip = (_FinalSSpawn select 0);
		_veh = _ActualSpawnShip createVehicle _position;
		//_veh addEventHandler ["killed",{W_ActiveUnits = W_ActiveUnits - [(_this select 0)];}];
		_CurrentTickets = _CurrentTickets - 1;
		_ActiveSide pushback _veh;
		_FinalSSpawn set [0,"DELETE"];
		_FinalSSpawn = _FinalSSpawn - ["DELETE"];
		_grp = creategroup _Side;
		createVehicleCrew _veh;			
		{[_x] joinsilent _grp} forEach crew _veh;
		_GroupList pushback (group _veh);	
		sleep 1;
		
};

/*
{
	private _OrigGroupA = _x;
	private _CntUnits = (count (units _OrigGroupA));
	if ((_CntUnits/2) > 9) then
	{
		private _CargoCount = 0;
		private _CargoList = [];
		{
			if !(_x isEqualTo (vehicle _x)) then
			{
				if (((assignedVehicleRole _x) select 0) isEqualTo "cargo") then {_CargoCount = _CargoCount + 1;_CargoList pushback _x;};
			};
		} foreach (units _OrigGroupA);
		
		private _newgrp = creategroup _Side;
		private _TransferCntTotal = (_CntUnits/2);
		private _TransferCnt = 0;
		while {_TransferCnt < _TransferCntTotal} do
		{
			private _NewUnit = selectRandom _CargoList;
			if !(isNil "_NewUnit") then
			{
				[_NewUnit] joinsilent _newgrp;
				_TransferCnt = _TransferCnt + 1;
				_CargoList = _CargoList - [_NewUnit];
				sleep 0.1;
			};
		};
		_GroupList pushback _newgrp;			
	};
} foreach _GroupList;
*/

{

		sleep 5;

		
		_rnd = random 150;
		_dist = (_rnd + 10);
		_dir = random 360;
		_position = [(_TargetLocation select 0) + (sin _dir) * _dist, (_TargetLocation select 1) + (cos _dir) * _dist, 0];
		private _FindRoadS = _position nearRoads 250;
		if !(_FindRoadS isEqualTo []) then {private _CloseRoad = [_FindRoadS,_position,true] call dis_closestobj;_position = (getpos _CloseRoad)};
		_waypoint = _x addwaypoint[_position,1];
		_waypoint setwaypointtype "MOVE";
		_waypoint setWaypointSpeed "NORMAL";
		_waypoint2 = _x addwaypoint[_position,1];
		_waypoint2 setwaypointtype "MOVE";
		_waypoint2 setWaypointSpeed "NORMAL";		
		_waypoint setWaypointBehaviour "SAFE";		
		_waypoint2 setWaypointBehaviour "SAFE";					


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
		
		
		//Lets setup a way to force our units into combat when possible. The commander can still provide orders, but occassionally they should just move to engage nearby targets.
		[_x,_Side] spawn 
		{
			params ["_grp","_Side"];
			while {({alive _x} count (units _grp)) > 0} do
			{
				sleep 900;
				private _SummedOwned = [];				
				if (_Side isEqualTo West) then {_SummedOwned = BluControlledArray;};
				if (_Side isEqualTo East) then {_SummedOwned = OpControlledArray;};

				private _MCaptureArray = [];				
				{
					if (!((_x select 0) in _SummedOwned)) then
					{
						_MCaptureArray pushback (_x select 0);
					};	
				} foreach CompleteTaskResourceArray;

				
				private _Lead = (leader _grp);
				if ((speed _Lead) isEqualTo 0) then
				{
					private _Enem = [_MCaptureArray,_Lead,true] call dis_closestobj;
					_waypoint = _grp addwaypoint[(getpos _Enem),1];
					_waypoint setwaypointtype "MOVE";
					_waypoint setWaypointSpeed "NORMAL";
					_grp setBehaviour "SAFE";
				};
			};
		};
		
		[
		[_x,_SelGroupName,_MarkerColor,_MarkerType,_Side],
		{
			params ["_Group","_SelGroupName","_MarkerColor","_MarkerType","_Side"];
			private _Marker = createMarkerLocal [format ["ID_%1",_Group],[0,0,0]];
			_Marker setMarkerColorLocal _MarkerColor;
			_Marker setMarkerTypeLocal _MarkerType;		
			_Marker setMarkerShapeLocal 'ICON';
			
			if (isServer) then {[_Side,_Marker,_Group,"Recruit"] call DIS_fnc_mrkersave;};
			if (playerSide isEqualTo _Side) then
			{
				_Marker setMarkerAlphaLocal 1;
			}
			else
			{
				_Marker setMarkerAlphaLocal 0;
			};			
			
			
			while {({alive _x} count (units _Group)) > 0} do
			{
				_Marker setMarkerDirLocal (getdir (leader _Group));	
				_Marker setMarkerTextLocal format ["%2: %1",({alive _x} count (units _Group)),_SelGroupName];
				_Marker setMarkerPosLocal (getposASL (leader _Group));
				_Marker setMarkerSizeLocal [0.5,0.5];				
				sleep 1.25;
			};
			sleep 5;
			deleteMarker _Marker;
		}
		
		] remoteExec ["bis_fnc_Spawn",0]; 
		
		
} foreach _GroupList;




//Lastly. We need to have the AI commander update everyone on wtf just happened.


_FailedRecruitment = "Yes. All units successfully recruited";

if (_WestRun) then 
{
W_RArray = _MoneyArray;
W_ActiveUnits = _ActiveSide;
Dis_BluforTickets = _CurrentTickets;

publicVariable "W_RArray";
publicVariable "W_ActiveUnits";
publicVariable "Dis_BluforTickets";

if (_FailedAttempt >= 25) then {_FailedRecruitment = "No. We ran out of necessary resources for all requested units.";};
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

,_FinalInfSpawnC,_FinalLSpawnC,_FinalHSpawnC,_FinalASpawnC,_FinalSSpawnC,_FailedRecruitment,(mapGridPosition _TargetLocation),_AdditionalMessage
]
];
dis_WNewsArray pushback _AddNewsArray;
publicVariable "dis_WNewsArray";

["Beep_Target"] remoteExec ["PlaySoundEverywhere",West];
["RECRUITMENT",'#FFFFFF'] remoteExec ["MessageFramework",West];
}
else
{
E_RArray = _MoneyArray;
E_ActiveUnits = _ActiveSide;
Dis_OpforTickets = _CurrentTickets;

publicVariable "E_RArray";
publicVariable "E_ActiveUnits";
publicVariable "Dis_OpforTickets";

if (_FailedAttempt >= 25) then {_FailedRecruitment = "No. We ran out of necessary resources for all requested units.";};
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

,_FinalInfSpawnC,_FinalLSpawnC,_FinalHSpawnC,_FinalASpawnC,_FinalSSpawnC,_FailedRecruitment,(mapGridPosition _TargetLocation),_AdditionalMessage
]
];
dis_ENewsArray pushback _AddNewsArray;
publicVariable "dis_ENewsArray";

["Beep_Target"] remoteExec ["PlaySoundEverywhere",East];
["RECRUITMENT",'#FFFFFF'] remoteExec ["MessageFramework",East];







};
