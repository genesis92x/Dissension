//This function creates a more interesting town experience by having a random set of reinforcements occur when a town gets to half captured.
params ["_Pole","_SSide","_StrongHoldBuildings","_grpGarrison","_infantrylist","_AirList","_AtkSide","_NameLocation"];

/*
	EVENTS THAT CAN OCCUR:
	
	PARADROP
	VEHICLE REINFORCE
	HELICRAFT MASS LANDING - 4 birds try to drop squads into the town.
	STRONGHOLD BUILDING
	SQUAD LEADER RETREAT

*/

_grpGarrison setVariable ["DIS_IMPORTANT",true];


//First we need to decide WHAT we are even doing
private _Event = selectRandom ["PARADROP","VEHICLEREINFORCE","HELILANDING","STRONGHOLD"];

//Makes sure there are actually stronghold buildings in this town.
if (count _StrongHoldBuildings < 1) then
{
	if (_Event isEqualTo "STRONGHOLD") then
	{
		_Event = selectRandom ["PARADROP","VEHICLEREINFORCE","HELILANDING"];
	};
};

switch (_Event) do
{
	case "PARADROP" : 
	{
		private _SpawnAmount = 23;
		private _SpawnedArray = [];
		while {_SpawnAmount > 0} do
		{
			private _unit = _grpGarrison createUnit [(selectRandom _infantrylist),[0,0,0], [], 25, "CAN_COLLIDE"];
			_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled;}];
			[_unit] joinSilent _grpGarrison;		
			_unit allowdamage false;
			_SpawnedArray pushback _unit;
			_SpawnAmount = _SpawnAmount - 1;
		};
	
		[format ["%1: ENEMY TROOPS PARADROPPING ONTO THE TOWN!",(toUpper _NameLocation)],'#FE2411'] remoteExec ["MessageFramework",_AtkSide];	
		
		[format ["<img size='1' align='left' color='#ffffff' image='Pictures\types\land_ca.paa' /> PARADROP: %1",(toUpper _NameLocation)], format 
		["<t size='1'><br/>The enemy is dropping troops to reinforce the town!
		</t>",_NameLocation]] remoteExec ["Haz_fnc_createNotification",_AtkSide];	

		
		
		private _BenchLimit = 0;
		private _SPos = getpos _Pole;
		private _rndp = [_SPos,150,5] call dis_randompos;		
		private _para = createVehicle ["B_Parachute_02_F", [(_rndp select 0),(_rndp select 1),250], [], 0, "CAN_COLLIDE"];
		private _Pod = createVehicle ["Land_Pod_Heli_Transport_04_bench_F",[(_rndp select 0),(_rndp select 1),250], [], 0, "CAN_COLLIDE"];
		_Pod setVariable ["DIS_PLAYERVEH",true];		
		_Pod attachTo [_para,[0,0,0]];
		_Pod spawn {waitUntil {((getpos _this) select 2) < 5 || !(alive _this)};deleteVehicle _this;};
		{
			_x moveInAny _Pod;
			_x allowdamage true;
			if (_BenchLimit isEqualTo 8) then
			{
				_rndp = [_SPos,150,5] call dis_randompos;		
				_para = createVehicle ["B_Parachute_02_F",  [(_rndp select 0),(_rndp select 1),250], [], 0, "CAN_COLLIDE"];
				_Pod = createVehicle ["Land_Pod_Heli_Transport_04_bench_F",[(_rndp select 0),(_rndp select 1),250], [], 0, "CAN_COLLIDE"];	
				_Pod attachTo [_para,[0,0,0]]; 
				_Pod setVariable ["DIS_PLAYERVEH",true];
				_Pod spawn {waitUntil {((getpos _this) select 2) < 5 || !(alive _this)};deleteVehicle _this;};
				_BenchLimit = 0;
			};
			_BenchLimit = _BenchLimit + 1;
			sleep 0.25;
		} foreach _SpawnedArray;	
	
		
		//CLEANUP SRCIPT
		[_Pole,_SpawnedArray] spawn
		{
			params ["_Pole","_SpawnedArray"];
			waitUntil {!(_Pole getVariable ["DIS_ENGAGED",false])};
			sleep 120;
			{
				if !(isNull _x) then
				{
					deleteVehicle _x;
				};
			} foreach _SpawnedArray;				
		};			
	};
	
	case "VEHICLEREINFORCE" : 
	{
		[_SSide,_AtkSide,_Pole] spawn DIS_fnc_CounterAttack;
		[format ["%1: ENEMY IS REQUESTING HEAVY SUPPORT! IT IS POSSIBLE THEY MAY HAVE GOTTEN THE REQUEST FOR HELP OUT.",(toUpper _NameLocation)],'#FE2411'] remoteExec ["MessageFramework",_AtkSide];
		[format ["<img size='1' align='left' color='#ffffff' image='Pictures\types\land_ca.paa' /> HEAVY SUPPORT: %1",(toUpper _NameLocation)], format 
		["<t size='1'><br/>The enemy is requesting heavy vehicle support!
		</t>",_NameLocation]] remoteExec ["Haz_fnc_createNotification",_AtkSide];			
		
	};
	case "HELILANDING" : 
	{
		private _TransportHeliClassname = "I_Heli_light_03_unarmed_F";
		private _ControlledArray = IndControlledArray;

		if (_SSide isEqualTo WEST) then
		{
			_TransportHeliClassname = "B_Heli_Transport_01_F";
			_ControlledArray = BluControlledArray;
		};
		if (_SSide isEqualTo EAST) then
		{
			_TransportHeliClassname = "O_Heli_Light_02_unarmed_F";
			_ControlledArray = OpControlledArray;
		};
		private _PolePos = getpos _Pole;
		private _NearestTown = [_ControlledArray,_PolePos,true] call dis_closestobj;
		private _NearestTownPos = (getpos _NearestTown);
		private _direction = _NearestTown getdir _PolePos;
		private _RoadSpawnRough = [_NearestTownPos,2000,_direction] call BIS_fnc_relPos;	
		private _BirdList = [];
		private _UnitSpawnGroup = createGroup _SSide;
		_UnitSpawnGroup setVariable ["DIS_BoatN",true];
		_UnitSpawnGroup setVariable ["DIS_IMPORTANT",true];		
		for "_i" from 1 to 4 step 1 do
		{
			private _Bird = createVehicle [_TransportHeliClassname,_RoadSpawnRough, [], 400, "FLY"];			
			createVehicleCrew _Bird;
			private _CurrentBirdGroup = (group (driver _Bird));
			_BirdList pushback _CurrentBirdGroup;
			_CurrentBirdGroup setCombatMode "BLUE";
			{_x disableAI "TARGET";_x disableAI "AUTOTARGET";_x disableAI "FSM";_x disableAI "SUPPRESSION";_x disableAI "COVER";_x disableAI "AUTOCOMBAT";_x disableAI "MINEDETECTION";} foreach (crew _bird);
					//Spawn units into the bird.
					private _UnitList = [];
					for "_i" from 1 to 6 step 1 do
					{
						private _unit = _UnitSpawnGroup createUnit [(selectRandom _infantrylist),[0,0,0], [], 25, "CAN_COLLIDE"];
						_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled;}];
						[_unit] joinSilent _UnitSpawnGroup;		
						_UnitList pushback _unit;
						_Unit moveInAny _Bird;
					};
					
					
					private _ComPos = getpos _Pole;
					private _MovePosition = [_ComPos, 15, 400, 5, 0, 20, 0,[],[_ComPos,_ComPos]] call BIS_fnc_findSafePos;
					_MovePosition = [(_MovePosition select 0),(_MovePosition select 1),10];
					_HeliMovePos = _MovePosition findEmptyPosition [1,150,_TransportHeliClassname];
					if (_HeliMovePos isEqualTo []) then {_HeliMovePos = _MovePosition;};
					
			
					private _waypoint = _CurrentBirdGroup addwaypoint[_HeliMovePos,0];
					_waypoint setwaypointtype "MOVE";
					_waypoint setWaypointSpeed "NORMAL";
					_waypoint setWaypointBehaviour "AWARE";
					_CurrentBirdGroup setCurrentWaypoint [_CurrentBirdGroup,(_waypoint select 1)];	
					private _waypoint2 = _CurrentBirdGroup addwaypoint[_HeliMovePos,0];
					_waypoint2 setwaypointtype "MOVE";
					_waypoint2 setWaypointSpeed "NORMAL";
					_waypoint2 setWaypointBehaviour "AWARE";			
					
					[_CurrentBirdGroup,_Bird,_HeliMovePos,_UnitList,_RoadSpawnRough] spawn
					{
						params ["_CurrentBirdGroup","_Bird","_HeliMovePos","_UnitList","_RoadSpawnRough"];
						waitUntil {!(alive _Bird) || _Bird distance2D _HeliMovePos < 100};
						_Bird land "LAND";
						waitUntil {((getpos _Bird) select 2 < 3) || !(alive _Bird)};
						if !(alive _Bird) exitWith {sleep 30;{deleteVehicle _x} foreach (crew _bird);deleteVehicle _Bird;};
						{
							unassignVehicle _x;
							doGetOut _x;
						} foreach _UnitList;
						sleep 10;
						private _waypoint = _CurrentBirdGroup addwaypoint[_RoadSpawnRough,0];
						_waypoint setwaypointtype "MOVE";
						_waypoint setWaypointSpeed "NORMAL";
						_waypoint setWaypointBehaviour "AWARE";
						_CurrentBirdGroup setCurrentWaypoint [_CurrentBirdGroup,(_waypoint select 1)];	
						private _waypoint2 = _CurrentBirdGroup addwaypoint[_RoadSpawnRough,0];
						_waypoint2 setwaypointtype "MOVE";
						_waypoint2 setWaypointSpeed "NORMAL";
						_waypoint2 setWaypointBehaviour "AWARE";							
						waitUntil {!(alive _Bird) || _Bird distance2D _RoadSpawnRough < 100};
						{deleteVehicle _x} foreach (crew _bird);
						deleteVehicle _Bird;
					};	
				
		};
		
		
		
		
		
		//private _HeliPad = createVehicle ["Land_HelipadEmpty_F",_ActMoveToPosition, [], 0, "CAN_COLLIDE"];
		
		[format ["%1: ENEMY TRANSPORT AIRCRAFT IS IN-BOUND. BE READY FOR THEIR ARRIVAL.",(toUpper _NameLocation)],'#FE2411'] remoteExec ["MessageFramework",_AtkSide];
		[format ["<img size='1' align='left' color='#ffffff' image='Pictures\types\land_ca.paa' />ENEMY REINFORCEMENTS: %1",(toUpper _NameLocation)], format 
		["<t size='1'><br/>The enemy is requesting heavy vehicle support!
		</t>",_NameLocation]] remoteExec ["Haz_fnc_createNotification",_AtkSide];		
	
		//CLEANUP SRCIPT
		[_Pole,_UnitSpawnGroup,_BirdList] spawn
		{
			params ["_Pole","_UnitSpawnGroup","_BirdList"];
			waitUntil {!(_Pole getVariable ["DIS_ENGAGED",false])};
			sleep 120;
			{
				{
					if !(isNull _x) then
					{
						deleteVehicle _x;
					};
				} foreach (units _x);
			} foreach _BirdList;
			{
				if !(isNull _x) then
				{
					deleteVehicle _x;
				};
			} foreach (units _UnitSpawnGroup);				
		};	
	
	};	
	case "STRONGHOLD" : 
	{
			private _SelectedBuilding = objNull;
			private _LargestBuildings = [];
			private _UnitLists = [];
			private _ActiveBaddies = allunits select {(side _x isEqualTo _AtkSide)};
			{
				private _Pos = getpos _x;
				private _NEB = [_ActiveBaddies,_Pos,true,"dspwnunit11"] call dis_closestobj;
				if (_NEB distance2D _Pos > 26) then
				{
					private _BuildingPositions = [_x] call BIS_fnc_buildingPositions;
					_LargestBuildings pushback [(count _BuildingPositions),_BuildingPositions,_x];
				};		
			} foreach _StrongHoldBuildings;
			private _BoxArray = [];
			//Now lets find the largest building we have
			_LargestBuildings sort false;
			_SelectedBuilding = _LargestBuildings select 0;
			
			private _SelectedBuildingPositions = _SelectedBuilding select 1;
			private _SelectedBuildingObj = _SelectedBuilding select 2;
			{
				private _unit = _grpGarrison createUnit [(selectRandom _InfantryList), _x, [], 0, "CAN_COLLIDE"];
				_UnitLists pushback _Unit;
				_unit setpos _x;
				[_unit] joinSilent _grpGarrison;			
				_unit setUnitPos "UP";
				_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];		
				[_unit,(typeof _unit)] call DIS_fnc_UniformHandle;
				_unit disableAI "PATH";
				_unit setVariable ["DIS_SPECIAL",true];
				if (random 100 < 40) then
				{
					private _Box = "Box_IED_Exp_F" createVehicle _x;
					_Box setvariable ["DIS_PLAYERVEH",true,true];
					_Box setposATL _x;
					_BoxArray pushback _Box;
				};
			} foreach _SelectedBuildingPositions;
			
			[
				[_BoxArray],
				{
					params ["_BoxArray"];
					{
						if !(isNull _x) then
						{
							private _Addaction = [_x,"DESTROY ENEMY MUNITIONS","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa","_this distance _target < 1000","true",{hint "Taking!";},{},{(_this select 0) spawn {_this call dis_fnc_ClaimDocument;deleteVehicle _this;};},{hint "Stopped!"},[],2,0,true,true] call bis_fnc_holdActionAdd;
						};
					} foreach _BoxArray;						
				}
			] remoteExec ["bis_fnc_spawn",0]; 
			
			
			[format ["%1: ENEMIES HAVE GROUPED TO FORM A STRONGHOLD. THEY HAVE VALUABLE WEAPON CRATES LOCATED THROUGHOUT THE HOUSE.",(toUpper _NameLocation)],'#FE2411'] remoteExec ["MessageFramework",_AtkSide];
			[format ["<img size='1' align='left' color='#ffffff' image='Pictures\types\land_ca.paa' />ENEMY STRONGHOLD: %1",(toUpper _NameLocation)], format 
			["<t size='1'><br/>The enemy has garrisoned an unknown structure. Look for caches located inside the building.
			</t>",_NameLocation]] remoteExec ["Haz_fnc_createNotification",_AtkSide];					
			
			//CLEANUP SRCIPT
			[_Pole,_UnitLists,_BoxArray] spawn
			{
				params ["_Pole","_UnitLists","_BoxArray"];
				waitUntil {!(_Pole getVariable ["DIS_ENGAGED",false])};
				sleep 120;
				{
					if !(isNull _x) then
					{
						deleteVehicle _x;
					};
				} foreach _UnitLists;
				{
					if !(isNull _x) then
					{
						deleteVehicle _x;
					};
				} foreach _BoxArray;				
			};
			
	};
};