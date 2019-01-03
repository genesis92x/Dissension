//This function will spawn and handle the troops that defend a town!
params ["_TownArray","_CforEachIndex","_Engaged","_SSide","_ClosestUnit"];
private _Pole = _TownArray select 2;
private _NameLocation = _TownArray select 1;
private _Marker = _TownArray select 3;
private _SpawnAmount = _TownArray select 8;
private _StrongHoldBuildings = _TownArray select 9;
private _SpwnedUnits = [];
private _ActiveSide = [];
private _HC = false;
//Lets mark the town as engaged, and inform the function that there are 0 currently spawned units.
_Pole setVariable ["DIS_ENGAGED",true,true];

private _EOUnits = [];
{
	if !((side (group _x)) isEqualTo _SSide) then
	{
		_EOUnits pushback _x;
	};	
} foreach allPlayers;

private _ClosestPlayer = [_EOUnits,_Pole,true,"152"] call dis_closestobj;
if (_ClosestPlayer distance2D _Pole < 3000) then
{
	_Pole setVariable ["DIS_TowerAlive",true];
}
else
{
	_Pole setVariable ["DIS_TowerAlive",false];
};

//Lets make sure each building gets refreshed to hold only 10 troops.
_StrongHoldBuildings call DIS_fnc_TownReset;

//Here we will put important variables that will be used throughout the function.
private _PolePos = getPosWorld _Pole;
private _OriginalAmount = _SpawnAmount;
private _MaxAtOnce = 8;
if (_SpawnAmount > 75) then {_MaxAtOnce = 8;};
if (_ClosestPlayer distance2D _Pole < 2000) then
{
	_MaxAtOnce = 10;
	if (_SpawnAmount > 75) then {_MaxAtOnce = 12;};
};
//Player Count to Garrsion # ratio
private _TSParam = "TOWNSCALING" call BIS_fnc_getParamValue;

//First if the max number of players is below a number, let's reduce the total number of spawning units.
switch ((count _EOUnits)) do
{
	case 1: {_MaxAtOnce = _MaxAtOnce - 3;};
	case 2: {_MaxAtOnce = _MaxAtOnce - 2};
	default {};
};

//Now let's calculate the ratio
private _FullPer = 0;
{
	_FullPer = _FullPer + (_TSParam/100);
} foreach _EOUnits; 

_SpawnAmount = _SpawnAmount + (_SpawnAmount * _FullPer);


private _Engaged = true;
private _CloseStill = true;

//Find what kinds of units we should be spawning. We will just define all the side specific units here.
private _InfantryList = R_BarrackHU;
private _FactoryList = R_LFactDef;
private _GroupNames = R_Groups;
private _ControlledArray = IndControlledArray;
private _StaticList = R_StaticWeap;
private _AirList = R_AirU;

private _AtkSide = _ClosestUnit;

if (_AtkSide isEqualTo resistance) then {DIS_ResistTSpwn = DIS_ResistTSpwn + 1;};
if (_AtkSide isEqualTo east) then {DIS_EastTSpwn = DIS_EastTSpwn + 1;};
if (_AtkSide isEqualTo west) then {DIS_WestTSpwn = DIS_WestTSpwn + 1;};

if (_SSide isEqualTo west) then
{
	_ActiveSide = W_ActiveUnits;
	_InfantryList = [];
	{
		_InfantryList pushback (_x select 0);
	} foreach W_BarrackU;

	_FactoryList = [];
	{
		_FactoryList pushback (_x select 0);
	} foreach W_LFactU;	
	
	_AirList = [];
	{
		_AirList pushBack (_x select 0);
	} foreach W_AirU;
	
	_StaticList = [((W_StaticWeap select 0) select 0),((W_StaticWeap select 1) select 0),((W_StaticWeap select 2) select 0),((W_StaticWeap select 3) select 0)];
	
	_GroupNames = W_Groups;
	_ControlledArray = BluControlledArray;
	
};

if (_SSide isEqualTo east) then
{
	_ActiveSide = E_ActiveUnits;
	_InfantryList = [];
	{
		_InfantryList pushback (_x select 0);
	} foreach E_BarrackU;

	_FactoryList = [];
	{
		_FactoryList pushback (_x select 0);
	} foreach E_LFactU;	
	_AirList = [];
	{
		_AirList pushBack (_x select 0);
	} foreach E_AirU;
	
	_StaticList = [((E_StaticWeap select 0) select 0),((E_StaticWeap select 1) select 0),((E_StaticWeap select 2) select 0),((E_StaticWeap select 3) select 0)];	
	
	_GroupNames = E_Groups;
	_ControlledArray = OpControlledArray;
};

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


_Pole setVariable ["DIS_ASSAULTENDED",false,true];
[
	[_SSide,_SpwnedUnits,_SpawnAmount,_Pole,_StrongHoldBuildings,_infantrylist,_AirList,_AtkSide,_NameLocation,_MaxAtOnce,_PolePos,_HC,_StaticList,_FactoryList,_ActiveSide,_GroupNames,_ControlledArray,_CloseStill,_Engaged,_OriginalAmount,_Marker],
	{
	params ["_SSide","_SpwnedUnits","_SpawnAmount","_Pole","_StrongHoldBuildings","_infantrylist","_AirList","_AtkSide","_NameLocation","_MaxAtOnce","_PolePos","_HC","_StaticList","_FactoryList","_ActiveSide","_GroupNames","_ControlledArray","_CloseStill","_Engaged","_OriginalAmount","_Marker"];

	private _MineAdd = "VcomAIMineSupport" call BIS_fnc_getParamValue;
	
	//Here we will run the function to spawn in static weapons
	[_staticlist,_PolePos,_SSide,_InfantryList,_Pole] spawn
	{
		params ["_staticlist","_PolePos","_SSide","_InfantryList","_Pole"];
		[_staticlist,_PolePos,_SSide,_InfantryList,_Pole] call DIS_fnc_StSpwn;
	};
	
	//Here we will run the function to spawn in vehicles.
	[_PolePos,_FactoryList,_SSide,_InfantryList,_Pole] spawn
	{
		params ["_PolePos","_FactoryList","_SSide","_InfantryList","_Pole"];
		[_PolePos,_FactoryList,_SSide,_InfantryList,_Pole] call DIS_fnc_VehSpwn;
	};
	
	[_Pole,_NameLocation,_SSide,_AtkSide] spawn
	{
		params ["_Pole","_NameLocation","_SSide","_AtkSide"];
		[_Pole,_NameLocation,_SSide,_AtkSide] call DIS_fnc_DTowerSpawn;
	};
	
	
	
	//Now we need to handle the loop for monitoring the waves of units.
	//Waves of units should spawn every 10 seconds if there is room.
	
	private _grp = createGroup _SSide;
	_grp setVariable ["DIS_IMPORTANT",true,true];
	private _grpGarrison = createGroup _SSide;
	_grpGarrison setVariable ["DIS_IMPORTANT",true,true];
	
	
	
	//If it's night out, lets get some flares going.
	_Pole spawn
	{
		private _DayTime = date call BIS_fnc_sunriseSunsetTime;
		if !(_DayTime select 0 < daytime && {_DayTime select 1 > daytime}) then
		{
			_this call DIS_fnc_NightObj;
		};
	};
	
	//Create mission specific objects for the towns
	[_Pole,_SSide,_StrongHoldBuildings,_grpGarrison,_infantrylist,_AirList,_AtkSide,_NameLocation] spawn
	{
		[
			_this,
			{
				_this spawn DIS_fnc_TObjs;
			}
		] remoteExec ["bis_fnc_Spawn",2];
		_this call DIS_fnc_TownCacheSpawns;
	};
	
	[_grp,_Pole] spawn 
	{
			params ["_grp","_pole"];
			private _Eng = _Pole getVariable ["DIS_ENGAGED",false];
			waitUntil
			{
				sleep 10;
				if (_pole distance2D (leader _grp) > 600) then
				{
					//private _WaypointPos = [(getpos _CE),50,25] call dis_randompos;
					//private _Finalposition = [_WaypointPos, 1, 250, 5, 0, 20, 0,[],[_WaypointPos,_WaypointPos]] call BIS_fnc_findSafePos;
					while {(count (waypoints _grp)) > 0} do
					{
						deleteWaypoint ((waypoints _grp) select 0);
					};
					private _Finalposition = (getpos (leader _grp));
					if !(_Finalposition isEqualTo [0,0,0]) then
					{
					_waypoint = _grp addwaypoint[_Finalposition,1];
					_waypoint setwaypointtype "MOVE";
					_waypoint setWaypointSpeed "LIMITED";
					_waypoint setWaypointBehaviour (behaviour (leader _grp));
					_grp setCurrentWaypoint _waypoint;				
					private _Finalposition = (getpos _pole);
					_waypoint = _grp addwaypoint[_Finalposition,1];
					_waypoint setwaypointtype "MOVE";
					_waypoint setWaypointSpeed "LIMITED";
					_waypoint setWaypointBehaviour (behaviour (leader _grp));
					_grp setCurrentWaypoint _waypoint;
					};
				}
				else
				{
					while {(count (waypoints _grp)) > 0} do
					{
						deleteWaypoint ((waypoints _grp) select 0);
					};
					private _Finalposition = (getpos (leader _grp));
					if !(_Finalposition isEqualTo [0,0,0]) then
					{
						_waypoint = _grp addwaypoint[_Finalposition,1];
						_waypoint setwaypointtype "MOVE";
						_waypoint setWaypointSpeed "LIMITED";
						_waypoint setWaypointBehaviour (behaviour (leader _grp));
						_grp setCurrentWaypoint _waypoint;					
						private _WaypointPos = (getpos _pole);
						private _Finalposition = [_WaypointPos, 5, 150, 5, 0, 20, 0,[],[_WaypointPos,_WaypointPos]] call BIS_fnc_findSafePos;
						_waypoint = _grp addwaypoint[_Finalposition,1];
						_waypoint setwaypointtype "MOVE";
						_waypoint setWaypointSpeed "LIMITED";
						_waypoint setWaypointBehaviour (behaviour (leader _grp));
						_grp setCurrentWaypoint _waypoint;
					};
				
				};
				sleep 60;
				_Eng = _Pole getVariable ["DIS_ENGAGED",false];
				!(_Eng)
			};
	};
	
	
	_Pole setVariable ["DIS_Capture",[_OriginalAmount,_SpawnAmount,_SSide],true];
	private _DstReset = 0;
	private _HalfPoint = _SpawnAmount/2;
	private _TownReinforceBool = false;
	
	//Spawn bunkers that will be used for spawning as a last resor, near center.
	private _BunkerList = [];
	for "_i" from 1 to 4 step 1 do 
	{
		private _WaypointPos = [_PolePos,75,25] call dis_randompos;
		private _Finalposition = [_WaypointPos, 1, 25, 5, 0, 20, 0,[],[_WaypointPos,_WaypointPos]] call BIS_fnc_findSafePos;		
		private _LastSpawnBunker = createVehicle ["Land_Cargo_House_V1_F", _Finalposition, [], 0, "CAN_COLLIDE"];
		_LastSpawnBunker setDir (random 360);
		_BunkerList pushback _LastSpawnBunker;
	};



		waitUntil
		{
			//Lets find where all the units are on the map.
			//We will create lists of all the units.
		
			private _ActiveBaddies = [];
		
			//private _rtnarray = [_WestActive,_EastActive,_ResistanceActive,_OpBlu];
			private _FullList = [] call DIS_fnc_EmyLst;
			private _WestActive = _FullList select 0;
			private _EastActive = _FullList select 1;
			private _ResistanceActive = _FullList select 2;
			private _OpBlu = _FullList select 3;
			
			if (_SSide isEqualTo West) then {_ActiveBaddies = _EastActive};
			if (_SSide isEqualTo East) then {_ActiveBaddies = _WestActive};
			if (_SSide isEqualTo Resistance) then {_ActiveBaddies = _OpBlu;};
			
		
			//Lets pull the total number of currently spawned units from the town.
		
			//We can only allow X amount of units to be spawned at once.
			{
				if (!(alive _x) || isNull _x) then {_SpwnedUnits deleteAt _forEachIndex};
			} foreach _SpwnedUnits;
			
			if (!(_TownReinforceBool) && {_SpawnAmount < _HalfPoint}) then
			{
				[
					[_Pole,_SSide,_StrongHoldBuildings,_grpGarrison,_infantrylist,_AirList,_AtkSide,_NameLocation],
					{
						params ["_Pole","_SSide","_StrongHoldBuildings","_grpGarrison","_infantrylist","_AirList","_AtkSide","_NameLocation"];
						[_Pole,_SSide,_StrongHoldBuildings,_grpGarrison,_infantrylist,_AirList,_AtkSide,_NameLocation] spawn DIS_fnc_HalfPointReinforce;
					}
				] remoteExec ["bis_fnc_Spawn",2];
				_TownReinforceBool = true;
			};
			
			if ((count _SpwnedUnits) < _MaxAtOnce) then
			{
		
				//Lets spawn in the town's defence
				if (isNil "_SpwnedUnits") then {_SpwnedUnits = [];};
				if (isNil "_MaxAtOnce") then {_MaxAtOnce = 12;};
				//Lets do some check here to make sure we pass variables to the function correctly
				if (isNil "_grp") then 
				{
					_grp = createGroup _SSide;
					_grp setVariable ["DIS_IMPORTANT",true,true];
					if (_HC) then
					{
						_grp setGroupOwner (owner HC);
						_grp setVariable ["DIS_TRANSFERED",true,true];
					};			
				};
				if (isNil "_grpGarrison") then 
				{
					_grpGarrison = createGroup _SSide;
					_grpGarrison setVariable ["DIS_IMPORTANT",true,true];			
				};
				if (count _ActiveBaddies < 1) then {_ActiveBaddies = []};
				
				private _SpwnArray = [_InfantryList,_grp,_Pole,_StrongHoldBuildings,_grpGarrison,_SSide,(_MaxAtOnce - (count _SpwnedUnits)),_ActiveBaddies,_BunkerList,_MineAdd] call DIS_fnc_DSpwnUnit;
				_StrongHoldBuildings = _SpwnArray select 0;
				if (Dis_debug) then {systemChat format ["BUILDINGS LEFT IN TOWN: %1",(count _StrongHoldBuildings)];systemchat format ["%3: TO SPAWN:%1  TOTAL COUNT NOW: %2",(_MaxAtOnce - (count _SpwnedUnits)),(count _SpwnedUnits),_NameLocation];};
				private _Var1 = _Pole getVariable "DIS_Capture";
				_SpawnAmount = _Var1 select 1;
				_SpawnAmount = _SpawnAmount - (_SpwnArray select 1);
				_Var1 set [1,_SpawnAmount];
				_Pole setVariable ["DIS_Capture",_Var1,true];
				
				{
					_SpwnedUnits pushback _x;
				} foreach (_SpwnArray select 2);

			};
		
				//If the closest enemy is too far away, let us exit.
				private _ClosestUnit = [_ActiveBaddies,_PolePos,true,"defencespawn171"] call dis_closestobj;
				if (_ClosestUnit distance2D _PolePos > 1200) then
				{
					_DstReset = _DstReset + 1;
					if (_DstReset > 100) then
					{
						_Engaged = false;
						_CloseStill = false;
						[_SpwnedUnits,_Pole,_ActiveSide,_SSide] spawn
						{
							params ["_SpwnedUnits","_Pole","_ActiveSide","_SSide"];				
							{
								if (!(isPlayer _x) && {_x distance2D _Pole < 801} && {!(_x in _ActiveSide)} && {!(_x isEqualTo DIS_WestCommander)} && {!(_x isEqualTo DIS_EastCommander)}) then
								{
									_SpwnedUnits pushback _x;
								};
							} foreach (allunits select {(side _x) isEqualTo _SSide});				
		
							{
								_x setdamage 1;
							} foreach _SpwnedUnits;
						};
					};
				}
				else
				{
					_DstReset = 0;
				};		
			
			sleep 10;
			(_SpawnAmount < 1 || !(_CloseStill))
		};		
		_pole setVariable ["DIS_ASSAULTENDED",true,true];
		{
			deleteVehicle _x;
		} foreach _BunkerList;
		
		
	}
] remoteExec ["bis_fnc_Spawn",_RMEXEC];


waitUntil
{
	private _VarCheck = _Pole getVariable ["DIS_ASSAULTENDED",false];
	sleep 5;
	_VarCheck
};

//NEXT WE NEED TO WAIT FOR THE TOTAL NEARBY ENEMY AI TO BE BELOW A CERTAIN THRESHOLD.
private _EnT = true;

[
	[_Pole,_SSide,_NameLocation,_AtkSide],
	{
			params ["_Pole","_SSide","_NameLocation","_AtkSide"];
			if (_AtkSide isEqualTo playerSide) then
			{
				["DISTASK",["MAIN OBJECTIVE",(MISSION_ROOT + "Pictures\types\danger_ca.paa"),(format ["%1: FINISH REMAINING TROOPS",(toUpper _NameLocation)]),""]] call BIS_fnc_showNotification;;
			};
	}
] remoteExec ["bis_fnc_Spawn",0];


private _RemainingUnits = [];
private _FullList = [];
private _WestRU = [];
private _EastRU = [];
private _ResRU = [];
private _OpBlu = [];
private _FinalCnt = [];

waitUntil
{
	
	//private _rtnarray = [_WestActive,_EastActive,_ResistanceActive,_OpBlu];
	_FullList = [] call DIS_fnc_EmyLst;
	_FullList params ["_WestActive","_EastActive","_ResistanceActive","_OpBlu"];
	
	switch (_SSide) do
	{
		case west: {_RemainingUnits = _WestActive;};
		case east: {_RemainingUnits = _EastActive;};
		case resistance: {_RemainingUnits = _ResistanceActive;};
		default {};
	};	
	
	_FinalCnt = [];
	{
		if (_x distance2D _PolePos < 500) then
		{
			_FinalCnt pushback _x;
		};
	} foreach _RemainingUnits;

	
	sleep 5;
	((count _FinalCnt) < 5)
};

{
	if (_x select 0 isEqualTo _pole) then
	{
		DIS_WENGAGED deleteAt _forEachindex;
	};
} foreach DIS_WENGAGED;
publicVariable "DIS_WENGAGED";


{
	if (_x select 0 isEqualTo _pole) then
	{
		DIS_EENGAGED deleteAt _forEachindex;
	};
} foreach DIS_EENGAGED;
publicVariable "DIS_EENGAGED";

/*
[
[_Pole,_SSide],
{
		params ["_Pole","_SSide"];
		if ((group player) isEqualTo _SSide) then
		{
			private _m1 = _Pole getVariable ["DIS_MEngaged",""];
			deleteMarkerLocal _m1;
		};
}

] remoteExec ["bis_fnc_Spawn",0];		
*/

if (_AtkSide isEqualTo resistance) then {DIS_ResistTSpwn = DIS_ResistTSpwn - 1;};
if (_AtkSide isEqualTo east) then {DIS_EastTSpwn = DIS_EastTSpwn - 1;};
if (_AtkSide isEqualTo west) then {DIS_WestTSpwn = DIS_WestTSpwn - 1;};

[_SpwnedUnits,_Pole,_ActiveSide,_SSide] spawn
{
	params ["_SpwnedUnits","_Pole","_ActiveSide","_SSide"];
	{
		if (!(isPlayer _x) && {_x distance2D _Pole < 801} && {!(_x in _ActiveSide)} && {!(_x isEqualTo DIS_WestCommander)} && {!(_x isEqualTo DIS_EastCommander)}) then
		{
			_SpwnedUnits pushback _x;
		};
	} foreach (allunits select {(side _x) isEqualTo _SSide});	
	sleep 300;

	{
		_x setdamage 1;
	} foreach _SpwnedUnits;
};


//This is for AFTER The battle.
if (_Engaged && {_CloseStill}) then
{


	_defeat = true;						

	//Lets look at all the units and where they are at
	_WestActive = [];
	_EastActive = [];
	_ResistanceActive = [];
	_OpBlu = [];
	_MarkerSize = 1200;
	{
		if (side (group _x) isEqualTo west && {alive _x} && {_x distance2D _PolePos <= _MarkerSize}) then {_WestActive pushback _x;_OpBlu pushback _x;};
		if (side (group _x) isEqualTo east && {alive _x} && {_x distance2D _PolePos <= _MarkerSize}) then {_EastActive pushback _x;_OpBlu pushback _x;};
		if (side (group _x) isEqualTo resistance && {alive _x} && {_x distance2D _PolePos <= _MarkerSize}) then {_ResistanceActive pushback _x;};
	} foreach allunits;

	//West Win
	//private _WinArray = [[(count _WestActive),west,_WestActive],[(count _EastActive),east,_EastActive],[(count _ResistanceActive),resistance,_ResistanceActive]];
	private _WinArray = [[(count _WestActive),west,_WestActive],[(count _EastActive),east,_EastActive]];
	private _LosingSide = "";
	{
		if ((_x select 1) isEqualTo _SSide || (_x select 0) < 1) then {_LosingSide = _x;_WinArray = _WinArray - [_x];};
	} foreach _WinArray;
	_WinArray sort false;
	
	if !(_WinArray isEqualTo []) then
	{
	private _FinalWinner = ((_Winarray select 0) select 1);

	if ((_FinalWinner isEqualTo West) && {!(_SSide isEqualTo West)}) then
	{
		private _ClstPlay = [allplayers,_PolePos,true,"323"] call dis_closestobj;
		if (_ClstPlay distance2D _PolePos < 1200) then
		{
			if (_Pole getVariable ["DIS_TowerAlive",false]) then
			{
				[_SSide,West,_Pole] spawn DIS_fnc_CounterAttack;
			};
		};
		
		[] spawn
		{
			sleep 300;
			W_CurrentTargetArray = [];
			W_CurrentDecisionEXP = true;	
		};
		//W_CurrentDecisionM = true;
		//W_CurrentDecisionT = true;								
		
		[
		[_Marker,West,_NameLocation,_WinArray,_Pole],
		{
				params ["_Marker","_Side","_NameLocation","_WinArray","_Pole"];
				private _EnemyNum = _WinArray select 1 select 0;
				private _FriendlyNum = _WinArray select 0 select 0;
				if (playerSide isEqualTo _Side || player distance2D _Pole < 1000) then
				{
					_Marker setMarkerColorLocal "ColorBlue";
					_Marker setMarkerAlphaLocal 1;
					["DISTASK",["TOWN CAPTURED",(MISSION_ROOT + "Pictures\types\danger_ca.paa"),(format ["CAPTURED: %1",(toUpper _NameLocation)]),""]] call BIS_fnc_showNotification;
					[
					[
						[format ["%1: Occupied by Blufor",(toUpper _NameLocation)],"align = 'center' shadow = '1' size = '0.7' font='PuristaBold'"]
					]
					] spawn BIS_fnc_typeText2;					
				}
				else
				{
					if (getMarkerColor _Marker isEqualTo "ColorRed") then
					{
						_Marker setMarkerColorLocal "ColorBlue";
						_Marker setMarkerAlphaLocal 1;												
					};
				};
		}
		
		] remoteExec ["bis_fnc_Spawn",0];											
		
		if !(_Pole in BluControlledArray) then {BluControlledArray pushback _Pole;publicVariable "BluControlledArray";};
		if (_Pole in IndControlledArray) then {IndControlledArray = IndControlledArray - [_Pole];publicVariable "IndControlledArray";};
		if (_Pole in OpControlledArray) then {OpControlledArray = OpControlledArray - [_Pole];publicVariable "OpControlledArray";[East,5] call DIS_fnc_CommanderSpeak;};
		
		_Pole setVariable ["DIS_Capture",[(_OriginalAmount + 10),(_OriginalAmount + 10),West],true];
		(TownArray select _CforEachIndex) set [8,(_OriginalAmount + 10)];	
		//Victory fireworks!
		[West,4] call DIS_fnc_CommanderSpeak;
		[getMarkerPos _Marker, 'random','blue'] remoteExec ["GRAD_fireworks_fnc_prepareFireworks", 2];
		{
			if (isPlayer _x) then
			{
			
					[
					[_x],
					{
						DIS_PCASHNUM = DIS_PCASHNUM + 500;
						disableSerialization;
						_RandomNumber = random 10000;
						_TextColor = '#E31F00';		
						_xPosition = 0.15375 * safezoneW + safezoneX;
						_yPosition = 0.201 * safezoneH + safezoneY;     
							
						_randomvariableX = random 0.05;
						_randomvariableY = random 0.05;
						
						_NewXPosition = _xPosition - _randomvariableX;
						_NewYPosition = _yPosition - _randomvariableY;
						
						_RandomNumber cutRsc ["KOZHUD_3","PLAIN"];
						_ui = uiNamespace getVariable "KOZHUD_3";
						(_ui displayCtrl 1100) ctrlSetPosition [_NewXPosition,_NewYPosition];
						(_ui displayCtrl 1100) ctrlCommit 0; 
						(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>Town Taken: + <t color='%2'>%1</t> </t></t></t>","$500",_TextColor]);
						_RandomNumber cutFadeOut 30;														
					}
					
					] remoteExec ["bis_fnc_Spawn",_x];													
			}
			else
			{
				/*
				if (leader _x isEqualTo _x) then
				{
					if (_x isEqualTo (vehicle _x)) then
					{					
					private _RfsGrp = (group _x);
					private _OrgUCnt = _RfsGrp getVariable ["DIS_Frstspwn",12];
					while {_OrgUCnt > ({alive _x} count (units _RfsGrp)) - 1} do
					{
						private _unit = _RfsGrp createUnit [(selectRandom W_BarrackU) select 0,(getpos _x), [], 25, "FORM"];
						[_unit] joinSilent _RfsGrp;
						sleep 1;
					};
					};
				};
			*/
			};			
		} foreach _WestActive;
	};
	
	//East Win
	if ((_FinalWinner isEqualTo east) && {!(_SSide isEqualTo east)}) then
	{
		private _ClstPlay = [allplayers,_PolePos,true,"323"] call dis_closestobj;
		if (_ClstPlay distance2D _PolePos < 1200) then
		{	
			if (_Pole getVariable ["DIS_TowerAlive",false]) then
			{		
				[_SSide,East,_Pole] spawn DIS_fnc_CounterAttack;
			};
		};
		
		[] spawn
		{
			sleep 300;
			E_CurrentTargetArray = [];
			E_CurrentDecisionEXP = true;	
		};		

		//E_CurrentDecisionM = true;
		//E_CurrentDecisionT = true;								
		
		
		[
		[_Marker,East,_NameLocation,_WinArray,_Pole],
		{
				params ["_Marker","_Side","_NameLocation","_WinArray","_Pole"];
				private _EnemyNum = _WinArray select 1 select 0;
				private _FriendlyNum = _WinArray select 0 select 0;
				

				if (playerSide isEqualTo _Side || player distance2D _Pole < 1000) then
				{
					_Marker setMarkerColorLocal "ColorRed";
					_Marker setMarkerAlphaLocal 1;
					["DISTASK",["TOWN CAPTURED",(MISSION_ROOT + "Pictures\types\danger_ca.paa"),(format ["CAPTURED: %1",(toUpper _NameLocation)]),""]] call BIS_fnc_showNotification;
					[
					[
						[format ["%1: Occupied by Opfor",(toUpper _NameLocation)],"align = 'center' shadow = '1' size = '1' font='PuristaBold'"]
					]
					] spawn BIS_fnc_typeText2;					
				}
				else
				{
					if (getMarkerColor _Marker isEqualTo "ColorBlue") then
					{
						_Marker setMarkerColorLocal "ColorRed";
						_Marker setMarkerAlphaLocal 1;											
					};
				};
		}
		
		] remoteExec ["bis_fnc_Spawn",0];									
		
		
		if !(_Pole in OpControlledArray) then {OpControlledArray pushback _Pole;publicVariable "OpControlledArray";};		
		if (_Pole in IndControlledArray) then {IndControlledArray = IndControlledArray - [_Pole];publicVariable "IndControlledArray";};
		if (_Pole in BluControlledArray) then {BluControlledArray = BluControlledArray - [_Pole];publicVariable "BluControlledArray";[West,5] call DIS_fnc_CommanderSpeak;};		
	
		
		[getMarkerPos _Marker, 'random','red'] remoteExec ["GRAD_fireworks_fnc_prepareFireworks", 2];									
		_Pole setVariable ["DIS_Capture",[(_OriginalAmount + 10),(_OriginalAmount + 10),East],true];
		(TownArray select _CforEachIndex) set [8,(_OriginalAmount + 10)];

		//{_x setdamage 1} foreach _ResistanceActive;
		[East,4] call DIS_fnc_CommanderSpeak;
		{
			if (isPlayer _x) then
			{
			
					[
					[_x],
					{
						DIS_PCASHNUM = DIS_PCASHNUM + 500;
						disableSerialization;
						_RandomNumber = random 10000;
						_TextColor = '#E31F00';		
						_xPosition = 0.15375 * safezoneW + safezoneX;
						_yPosition = 0.201 * safezoneH + safezoneY;     
							
						_randomvariableX = random 0.05;
						_randomvariableY = random 0.05;
						
						_NewXPosition = _xPosition - _randomvariableX;
						_NewYPosition = _yPosition - _randomvariableY;
						
						_RandomNumber cutRsc ["KOZHUD_3","PLAIN"];
						_ui = uiNamespace getVariable "KOZHUD_3";
						(_ui displayCtrl 1100) ctrlSetPosition [_NewXPosition,_NewYPosition];
						(_ui displayCtrl 1100) ctrlCommit 0; 
						(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>Town Taken: + <t color='%2'>%1</t> </t></t></t>","$500",_TextColor]);
						_RandomNumber cutFadeOut 30;														
					}
					
					] remoteExec ["bis_fnc_Spawn",_x];													
			}
			else
			{
				/*
				if (leader _x isEqualTo _x) then
				{
					if (_x isEqualTo (vehicle _x)) then
					{
					private _RfsGrp = (group _x);
					private _OrgUCnt = _RfsGrp getVariable ["DIS_Frstspwn",12];
					while {_OrgUCnt > ({alive _x} count (units _RfsGrp)) - 1} do
					{
						private _unit = _RfsGrp createUnit [(selectRandom E_BarrackU) select 0,(getpos _x), [], 25, "FORM"];
						[_unit] joinSilent _RfsGrp;
						sleep 1;
					};
					};
				};
				*/
			};			
		} foreach _EastActive;									
		
		
		
		
	};

	//Resistance Win
	if ((_FinalWinner isEqualTo resistance) && {!(_SSide isEqualTo resistance)}) then
	{
		//E_CurrentDecisionM = true;
		//E_CurrentDecisionT = true;								
		
	
		
		[
			[_Marker],
			{
				params ["_Marker"];
				_Marker setMarkerColorLocal "ColorGreen";
				_Marker setMarkerAlphaLocal 1;
			}
			
		] remoteExec ["bis_fnc_Spawn",0];									
		
		
		if !(_Pole in IndControlledArray) then {IndControlledArray pushback _Pole;publicVariable "IndControlledArray";};			
		if (_Pole in OpControlledArray) then {OpControlledArray = OpControlledArray - [_Pole];publicVariable "OpControlledArray";};
		if (_Pole in BluControlledArray) then {BluControlledArray = BluControlledArray - [_Pole];publicVariable "BluControlledArray";};		
	
		
		[getMarkerPos _Marker, 'random','green'] remoteExec ["GRAD_fireworks_fnc_prepareFireworks", 2];									
		_Pole setVariable ["DIS_Capture",[(_OriginalAmount + 10),(_OriginalAmount + 10),resistance],true];
		(TownArray select _CforEachIndex) set [8,(_OriginalAmount + 10)];	
		//{_x setdamage 1} foreach _ResistanceActive;

		
	};	
	}
	else
	{
		_Pole setVariable ["DIS_Capture",[_OriginalAmount,_OriginalAmount,_SSide],true];
	
		//Lets have the group always hunting down enemies!
		(TownArray select _CforEachIndex) set [7,false];		
		_Pole setVariable ["DIS_ENGAGED",false,true];	
	};
	
	[_CforEachIndex,_Pole] spawn
	{
		params ["_CforEachIndex","_Pole"];
		sleep 15;
		(TownArray select _CforEachIndex) set [7,false];		
		_Pole setVariable ["DIS_ENGAGED",false,true];
	};
	
	
	
}
else
{
	_Pole setVariable ["DIS_Capture",[_OriginalAmount,_OriginalAmount,_SSide],true];
	//Lets have the group always hunting down enemies!
	(TownArray select _CforEachIndex) set [7,false];		
	_Pole setVariable ["DIS_ENGAGED",false,true];
};