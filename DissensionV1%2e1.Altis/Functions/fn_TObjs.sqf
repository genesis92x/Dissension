//Function for creating side-objects within the town.
params ["_Pole","_SSide","_StrongHoldBuildings","_grpGarrison","_infantrylist","_AirList","_AtkSide","_NameLocation"];


private _InfantryList = R_BarrackLU;
private _FactoryList = R_LFactDef;
private _HeavyFactoryList = R_HFactU;
private _GroupNames = R_Groups;
private _ControlledArray = IndControlledArray;
private _StaticList = R_StaticWeap;
private _AirList = R_AirU;


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
	
	
	_HeavyFactoryList = [];
	{
		_HeavyFactoryList pushback (_x select 0);
	} foreach W_HFactU;
	
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
	
	_HeavyFactoryList = [];
	{
		_HeavyFactoryList pushback (_x select 0);
	} foreach E_HFactU;	
	
	_AirList = [];
	{
		_AirList pushBack (_x select 0);
	} foreach E_AirU;
	
	_StaticList = [((E_StaticWeap select 0) select 0),((E_StaticWeap select 1) select 0),((E_StaticWeap select 2) select 0),((E_StaticWeap select 3) select 0)];	
	
	_GroupNames = E_Groups;
	_ControlledArray = OpControlledArray;
};








//If the closest player is too far, we just need to exit the function. No need to execute this when no players are even present. AI will not complete side-objectives.
private _ClosestPlayer = [allplayers,_Pole,true,"TObj0"] call dis_closestobj;


if (count (allplayers select {(side _x) isEqualTo _AtkSide}) < 1) exitWith {};

//Lets define our list of side-objects that can be completed here.
private _SideObj = selectRandom ["HeavyBunker","AirTower","Assassinate","Artillery","DefendPointA","Shoothouse"];
//private _SideObj = "Shoothouse";
//private _SideObj = "Shoothouse";
private _PolePos = getposATL _Pole;
private _RndPos = [_PolePos, 25, 100, 5, 0, 20, 0,[],[_PolePos,_PolePos]] call BIS_fnc_findSafePos;
private _ObjSpwnPos = [0,0,0];
if (Dis_debug) then {diag_log format ["DISDEBUG CHANGED: SIDEOBJECTIVE: %1 AT %2",_SideObj,_NameLocation];};
switch (_SideObj) do
{
	case "HeavyBunker" : 
	{
	
		[
			[_Pole,_SSide,_AtkSide,_NameLocation],
			{
				params ["_Pole","_SSide","_AtkSide","_NameLocation"];
				if (player distance2D _Pole < 6000 && {!(playerSide isEqualTo _SSide)} && {(_AtkSide isEqualTo playerSide)}) then
				{
					["DISTASK",[format ["SIDE OBJECTIVE: %1",_NameLocation],(MISSION_ROOT + "Pictures\types\attack_ca.paa"),"CLAIM BUNKER",""]] call BIS_fnc_showNotification;
					[
					[
						["Claim the Bunker","align = 'center' shadow = '1' size = '0.5' font='RobotoCondensed'"],
						["","<br/>"],
						["The Town Will Constantly Replenish Troops","align = 'center' shadow = '1' size = '0.5' font='RobotoCondensed'"]
					]
					] spawn BIS_fnc_typeText2;					
				};
			}
			
		] remoteExec ["bis_fnc_Spawn",0,_Pole]; 	
	
		private _OpenAreas = selectBestPlaces [_PolePos, 250, "meadow", 25, 1];	
		private _PrePos = ((_OpenAreas select 0) select 0);
		private _FinalPos = [_PrePos, 10, 300, 0, 0, 0.05, 0, [], [_PrePos,_PrePos]] call BIS_fnc_findSafePos;

		private _Generator = "Land_PowerGenerator_F" createVehicle _ObjSpwnPos;
		_Generator setvariable ["DIS_PLAYERVEH",true,true];
		_Generator allowdamage false;	
		_Generator addEventHandler ["HandleDamage", {0}];
		_Generator setVariable ["DIS_TowerPole",_Pole,true];
		
		_Generator addEventHandler ["Killed", 
		{
			private _Pole = (_this select 0) getVariable "DIS_TowerPole";
			private _Generator = (_this select 0);

			private _DO = _Generator getVariable "DIS_DSOB";
			private _AO = _Generator getVariable "DIS_ASOB";
			[_DO,"FAILED"] call BIS_fnc_taskSetState;
			[_AO,"SUCCEEDED"] call BIS_fnc_taskSetState;

			[
				[_Generator],
				{
					params ["_Generator"];


					if (player distance2D _Generator < 6000) then
					{
						["DISTASK",["SIDE OBJECTIVE COMPLETED",(MISSION_ROOT + "Pictures\types\danger_ca.paa"),"BUNKER CLAIMED",""]] call BIS_fnc_showNotification;
						[
							[
								["Bunker Eliminated - Town Replenish Halted.","align = 'center' shadow = '1' size = '0.5' font='RobotoCondensed'"]
							]
						] spawn BIS_fnc_typeText2;				
					};
				}
				
			] remoteExec ["bis_fnc_Spawn",0]; 	
			(_this select 0) spawn {sleep 30; deleteVehicle _this;};
			}];
					

		
		//SPAWN PREFAB SERVER SIDE
		[
			[_FinalPos,_Generator,_Pole,_SSide],
			{
				params ["_FinalPos","_Generator","_Pole","_SSide"];
				
				private _TerArray = [];
				{
					_x hideObjectGlobal true;
					_TerArray pushback _x;
					true;
				} count (nearestTerrainObjects [_FinalPos, [], 50,false]);					
				private _compReference = ["HeavyBunker",[(_FinalPos select 0),(_FinalPos select 1),0], [0,0,0], (random 360), true, true ] call LARs_fnc_spawnComp; 
				while {_Pole getVariable ["DIS_ENGAGED",false]} do
				{
					[_Generator,"bobcat_engine_loop"] remoteExec ["PlaySoundEverywhereSay3D",0];	
					sleep 5;
				};
				{
					_x hideObjectGlobal false;
					true;
				} count _TerArray;
				deleteVehicle _Generator;
				private _Mens = nearestObjects [(getposATL _Generator), ["Man"], 50];
				{if (!(isPlayer _x) && {!(isplayer (leader _x))}) then {_x setDamage 1;};true;} count (_Mens select {(side _x isEqualTo _SSide)});
				[_compReference] call LARs_fnc_deleteComp;					
			}
			
		] remoteExec ["bis_fnc_Spawn",2]; 			
		
		sleep 15;
		private _Objs = nearestObjects [_FinalPos, ["VR_Shape_base_F","VR_CoverObject_base_F"], 100];
		{
			private _Type = typeOf _x;
			if (_Type isEqualTo "Land_VR_Shape_01_cube_1m_F") then
			{
				private _Dir = getDir _x;	
				private _unit = _grpGarrison createUnit [(selectRandom _InfantryList) ,(getposATL _x), [], 0, "CAN_COLLIDE"];
				_unit setVariable ["DIS_SPECIAL",true,true];
				_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
				[_unit,(typeOf _unit)] call DIS_fnc_UniformHandle;
				_unit setposATL (getposATL _x);
				_unit disableAI "PATH";
				_unit setdir _Dir;
				[_unit] joinSilent _grpGarrison;				
			};
			if (_Type isEqualTo "Land_VR_CoverObject_01_kneelHigh_F") then
			{
				_ObjSpwnPos = getposATL _x;
			};
			deleteVehicle _x;
		} foreach _Objs;
		
		_Generator setposATL _ObjSpwnPos;
		
		//Marker for tasks
		private _ObjMM = createMarker [(format ["%1",(random 10000)]),(getpos _Generator)];
		_ObjMM setmarkershape "ICON";
		_ObjMM setMarkerType "Empty";
		_pole setVariable ["DIS_TASKM",_ObjMM];

		//Defend task!
		private _ObjN = _pole getVariable "DIS_DefendTID";
		private _ObjSN = _pole getVariable ["DIS_DefendTISSO",[]];
		private _ObjNSN = (format ["%1-%2",_Pole,"HeavyBunkerD"]); 
		_ObjSN pushBack _ObjNSN;
		_pole setVariable ["DIS_DefendTISSO",_ObjSN];
		[_SSide,[_ObjNSN,_ObjN], ["Prevent the enemy forces from claiming this bunker! This bunker greatly increases our reinforcements over time.","Defend Bunker Area",_ObjMM], (getpos _Generator), "CREATED", 90, true, "", true] call BIS_fnc_taskCreate;
		_Generator setVariable ["DIS_DSOB",_ObjNSN];

		//Attack task!
		private _ObjN = _pole getVariable "DIS_AttackTID";
		private _ObjSN = _pole getVariable ["DIS_AttackTISSO",[]];
		private _ObjNSN = (format ["%1-%2",_Pole,"HeavyBunkerA"]); 
		_ObjSN pushBack _ObjNSN;
		_pole setVariable ["DIS_AttackTISSO",_ObjSN];
		[_AtkSide,[_ObjNSN,_ObjN], ["This bunker is constantly replenishing the enemies reinforcements! We must claim it to halt these reinforcements. Use the HOLD ACTION on the generator to claim this bunker!","Claim Bunker Area",_ObjMM], (getpos _Generator), "CREATED", 90, true, "", true] call BIS_fnc_taskCreate;
		_Generator setVariable ["DIS_ASOB",_ObjNSN];


		[
			[_Generator,_Pole,_SSide,_AtkSide],
			{
				if !(hasInterface) exitwith {};	

				sleep 15;
				waitUntil {!(isNil "MISSION_ROOT")};
				params ["_Generator","_Pole","_SSide","_AtkSide"];
			
				if !(playerSide isEqualTo _SSide) then 
				{					
					private _Addaction = [_Generator,"Claim Bunker Area","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa","_this distance _target < 1000","true",{hint "Destroying!";},{},{(_this select 0) spawn {_this setDamage 1;};},{hint "Stopped!"},[],8,0,true,true] call bis_fnc_holdActionAdd;
				};
				if (_AtkSide isEqualTo playerSide) then
				{
					private _ObjM = createMarkerlocal [(format ["%1_%2",_Pole,(getpos _Generator)]),(getpos _Generator)];
					_ObjM setmarkershapelocal "ICON";
					_ObjM setMarkerTypelocal "mil_end";
					_ObjM setmarkercolorlocal "ColorEAST";
					_ObjM setmarkersizelocal [0.4,0.4];
					_ObjM setMarkerAlphalocal 1;
					_ObjM setMarkerTextLocal "SIDE OBJ: HEAVY BUNKER";
					[_ObjM,_Pole,_Generator] spawn
					{
						params ["_Mrk","_Pole","_Generator"];
						waitUntil {!(alive _Generator) || !(_Pole getVariable ["DIS_ENGAGED",false])};
						deleteMarker _Mrk;
					};		
				};
				
				private _Img = MISSION_ROOT + "Pictures\types\danger_ca.paa";
				[((str _Generator) + "DESTROY"), "onEachFrame", 
				{
					params ["_Img","_Generator","_Pole"];
					if (alive _Generator && {_Pole getVariable ["DIS_ENGAGED",false]}) then
					{
						_pos2 = getposATL _Generator;
						_pos2 set [2,(_pos2 select 2) + 2];
						_alphaText = round(linearConversion[25, 2000, player distance2D _Generator, 1, 0, true]);
						call compile format 
						[
						'
						drawIcon3D
						[
							%1,
							[0.95,0.95,0,%3],
							%2,
							0.75,
							0.75,
							0,
							"Heavy Bunker",
							2,
							0.04,
							"RobotoCondensed",
							"center",
							false
						];
						'
						,str _Img,_pos2,_alphaText
						]
					}
					else
					{
						[((str _Generator) + "DESTROY"), "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
					};
				},
				[_Img,_Generator,_Pole]
				] call BIS_fnc_addStackedEventHandler;			
			
		
			}
			
		] remoteExec ["bis_fnc_Spawn",0,_Generator]; 		


		[_Generator,_Pole,_SSide] spawn
		{
			params ["_Generator","_Pole","_SSide"];
			while {alive _Generator && {_Pole getVariable ["DIS_ENGAGED",false]}} do
			{
				[_Generator,"bobcat_engine_loop"] remoteExec ["PlaySoundEverywhereSay3D",0];	
				sleep 120;
				private _Var1 = _Pole getVariable "DIS_Capture";
				private _SpawnAmount = _Var1 select 1;
				if (_SpawnAmount < 200) then
				{
					_Var1 set [1,(_SpawnAmount + 5)];
					_Pole setVariable ["DIS_Capture",_Var1,true];				
				};
			};
		};


	};
	case "AirTower" : 
	{
	
		[
			[_Pole,_SSide,_AtkSide,_NameLocation],
			{
				params ["_Pole","_SSide","_AtkSide","_NameLocation"];
				if (player distance2D _Pole < 3000	&& {!(playerSide isEqualTo _SSide)} && {(_AtkSide isEqualTo playerSide)}) then
				{
					["DISTASK",[format ["SIDE OBJECTIVE: %1",_NameLocation],(MISSION_ROOT + "Pictures\types\attack_ca.paa"),"CLAIM AIRTOWER",""]] call BIS_fnc_showNotification;
					[
					[
						["Claim the AirTower","align = 'center' shadow = '1' size = '0.5' font='RobotoCondensed'"],
						["","<br/>"],
						["The Town Will Constantly Call for Air Support","align = 'center' shadow = '1' size = '0.5' font='RobotoCondensed'"]
					]
					] spawn BIS_fnc_typeText2;				
				};
			}
			
		] remoteExec ["bis_fnc_Spawn",0]; 	
	
		private _OpenAreas = selectBestPlaces [_PolePos, 250, "meadow", 25, 1];	
		private _PrePos = ((_OpenAreas select 0) select 0);
		private _FinalPos = [_PrePos, 10, 300, 0, 0, 0.05, 0, [], [_PrePos,_PrePos]] call BIS_fnc_findSafePos;

		private _Generator = "Land_PowerGenerator_F" createVehicle [0,0,0];
		_Generator allowdamage false;		
		_Generator addEventHandler ["HandleDamage", {0}];		
		_Generator setvariable ["DIS_PLAYERVEH",true,true];
		_Generator setvariable ["DIS_AtkSide",_AtkSide,true];
		_Generator setVariable ["DIS_TowerPole",_Pole,true];
		
		_Generator addEventHandler ["Killed", 
		{
			private _AtkSide = (_this select 0) getVariable "DIS_AtkSide";
			private _Generator = (_this select 0);

			private _DO = _Generator getVariable "DIS_DSOB";
			private _AO = _Generator getVariable "DIS_ASOB";
			[_DO,"FAILED"] call BIS_fnc_taskSetState;
			[_AO,"SUCCEEDED"] call BIS_fnc_taskSetState;

			[
				[(_this select 0),_AtkSide],
				{
					params ["_Generator","_AtkSide"];
					if (player distance2D _Generator < 3000 && {(_AtkSide isEqualTo playerSide)}) then
					{
						["DISTASK",["SIDE OBJECTIVE COMPLETED",(MISSION_ROOT + "Pictures\danger_ca.paa"),"CLAIMED AIRTOWER",""]] call BIS_fnc_showNotification;
						[
						[
							["Tower Eliminated - CAS Support Halted","align = 'center' shadow = '1' size = '0.5' font='RobotoCondensed'"]
						]
						] spawn BIS_fnc_typeText2;				
					};
				}
				
			] remoteExec ["bis_fnc_Spawn",0]; 	
			(_this select 0) spawn {sleep 30; deleteVehicle _this;}; 
			
			
			}];			
			
			
		//SPAWN PREFAB SERVER SIDE
		[
			[_FinalPos,_Generator,_Pole,_SSide],
			{
				params ["_FinalPos","_Generator","_Pole","_SSide"];
				private _TerArray = [];
				{
					_x hideObjectGlobal true;
					_TerArray pushback _x;
				} forEach (nearestTerrainObjects [_FinalPos, [], 50,false]);				
				private _compReference = ["AirTower",[(_FinalPos select 0),(_FinalPos select 1),0], [0,0,0], (random 360), true, true ] call LARs_fnc_spawnComp; 
				while {_Pole getVariable ["DIS_ENGAGED",false]} do
				{
					[_Generator,"bobcat_engine_loop"] remoteExec ["PlaySoundEverywhereSay3D",0];	
					sleep 5;
				};
				{
					_x hideObjectGlobal false;
				} forEach _TerArray;
				deleteVehicle _Generator;
				private _Mens = nearestObjects [(getposATL _Generator), ["Man"], 50];
				{if (!(isPlayer _x) && {!(isplayer (leader _x))}) then {_x setDamage 1;};true;} count (_Mens select {(side _x isEqualTo _SSide)});
				[_compReference] call LARs_fnc_deleteComp;					
			}
			
		] remoteExec ["bis_fnc_Spawn",2];
		
		sleep 15;
		private _Objs = nearestObjects [_FinalPos, ["VR_Shape_base_F","VR_CoverObject_base_F"], 100];
		{
			private _Type = typeOf _x;
			if (_Type isEqualTo "Land_VR_Shape_01_cube_1m_F") then
			{		
				private _Dir = getDir _x;			
				private _unit = _grpGarrison createUnit [(selectRandom _InfantryList) ,(getposATL _x), [], 0, "CAN_COLLIDE"];
				_unit setVariable ["DIS_SPECIAL",true,true];
				_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
				[_unit,(typeOf _unit)] call DIS_fnc_UniformHandle;
				_unit setposATL (getposATL _x);
				_unit disableAI "PATH";
				_unit setdir _Dir;
				[_unit] joinSilent _grpGarrison;				
			};
			if (_Type isEqualTo "Land_VR_CoverObject_01_kneelHigh_F") then
			{
				_ObjSpwnPos = getposATL _x;
			};
			deleteVehicle _x;
		} foreach _Objs;
		
			_Generator setposATL _ObjSpwnPos;
			
		
		[
			[_Generator,_Pole,_SSide,_AtkSide],
			{
				if !(hasInterface) exitwith {};		
				sleep 15;
				waitUntil {!(isNil "MISSION_ROOT")};
				params ["_Generator","_Pole","_SSide","_AtkSide"];
				if !(playerSide isEqualTo _SSide) then {
					private _Addaction = [_Generator,"Claim Air Tower","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa","_this distance _target < 1000","true",{hint "Destroying!";},{},{(_this select 0) spawn {_this setDamage 1;};},{hint "Stopped!"},[],8,0,true,true] call bis_fnc_holdActionAdd;
				};
				
				if (_AtkSide isEqualTo playerSide) then
				{			
					private _ObjM = createMarkerlocal [(format ["%1_%2",_Pole,(getpos _Generator)]),(getpos _Generator)];
					_ObjM setmarkershapelocal "ICON";
					_ObjM setMarkerTypelocal "mil_end";
					_ObjM setmarkercolorlocal "ColorEAST";
					_ObjM setmarkersizelocal [0.4,0.4];
					_ObjM setMarkerAlphalocal 1;
					_ObjM setMarkerTextLocal "SIDE OBJ: AIR TOWER";
					[_ObjM,_Pole,_Generator] spawn
					{
						params ["_Mrk","_Pole","_Generator"];
						waitUntil {!(alive _Generator) || !(_Pole getVariable ["DIS_ENGAGED",false])};
						deleteMarker _Mrk;
					};		
				};	
				
				private _Img = MISSION_ROOT + "Pictures\tridentEnemy_ca.paa";
				[((str _Generator) + "DESTROY"), "onEachFrame", 
				{
					params ["_Img","_Generator","_Pole"];
					if (alive _Generator && {_Pole getVariable ["DIS_ENGAGED",false]}) then
					{
						_pos2 = getposATL _Generator;
						_pos2 set [2,(_pos2 select 2) + 2];
						_alphaText = round(linearConversion[25, 2000, player distance2D _Generator, 1, 0, true]);
						call compile format 
						[
						'
						drawIcon3D
						[
							%1,
							[0.95,0.95,0,%3],
							%2,
							0.75,
							0.75,
							0,
							"Air Controller",
							2,
							0.04,
							"RobotoCondensed",
							"center",
							false
						];
						'
						,str _Img,_pos2,_alphaText
						]
					}
					else
					{
						[((str _Generator) + "DESTROY"), "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
					};
				},
				[_Img,_Generator,_Pole]
				] call BIS_fnc_addStackedEventHandler;			
			
		
			}
			
		] remoteExec ["bis_fnc_Spawn",0,_Generator];

		[_Generator,_Pole,_SSide,_AirList,_PolePos] spawn
		{
			params ["_Generator","_Pole","_SSide","_AirList","_PolePos"];
			private _FlyGroup = createGroup _SSide;
			_FlyGroup setVariable ["DIS_IMPORTANT",true,true];
			while {alive _Generator && {_Pole getVariable ["DIS_ENGAGED",false]}} do
			{
				_veh = createVehicle [(selectRandom _AirList),([[[_PolePos, 1000]],[]] call BIS_fnc_randomPos), [], 0, "FLY"];	
				_veh setvariable ["DIS_PLAYERVEH",true];		
				_veh allowdamage false;
				_veh spawn {sleep 10;_this allowdamage true;};
				createVehicleCrew _veh;			
				{[_x] joinsilent _FlyGroup;_x addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];} forEach crew _veh;
				private _waypoint = _FlyGroup addwaypoint[_PolePos,1];
				_waypoint setwaypointtype "MOVE";
				_waypoint setWaypointSpeed "NORMAL";
				private _waypoint2 = _FlyGroup addwaypoint[_PolePos,1];
				_waypoint2 setwaypointtype "MOVE";
				_waypoint2 setWaypointSpeed "NORMAL";		
				_waypoint setWaypointBehaviour "AWARE";		
				_waypoint2 setWaypointBehaviour "AWARE";		
				_FlyGroup setCurrentWaypoint _waypoint;				
				waitUntil {!(alive (driver _veh))};
				sleep 300;
				
			};
		};	

		//Marker for tasks
		private _ObjMM = createMarker [(format ["%1",(random 10000)]),(getpos _Generator)];
		_ObjMM setmarkershape "ICON";
		_ObjMM setMarkerType "Empty";
		_pole setVariable ["DIS_TASKM",_ObjMM];

		//Defend task!
		private _ObjN = _pole getVariable "DIS_DefendTID";
		private _ObjSN = _pole getVariable ["DIS_DefendTISSO",[]];
		private _ObjNSN = (format ["%1-%2",_Pole,"HeavyBunkerD"]); 
		_ObjSN pushBack _ObjNSN;
		_pole setVariable ["DIS_DefendTISSO",_ObjSN];
		[_SSide,[_ObjNSN,_ObjN], ["Prevent the enemies claiming this air tower! This tower will call in air support periodically while it is in our control.","Defend Air Tower",_ObjMM], (getpos _Generator), "CREATED", 90, true, "", true] call BIS_fnc_taskCreate;
		_Generator setVariable ["DIS_DSOB",_ObjNSN];

		//Attack task!
		private _ObjN = _pole getVariable "DIS_AttackTID";
		private _ObjSN = _pole getVariable ["DIS_AttackTISSO",[]];
		private _ObjNSN = (format ["%1-%2",_Pole,"HeavyBunkerA"]); 
		_ObjSN pushBack _ObjNSN;
		_pole setVariable ["DIS_AttackTISSO",_ObjSN];
		[_AtkSide,[_ObjNSN,_ObjN], ["Capture this air tower! This air tower will call in air support periodically while is it is under enemy control. Use the HOLD ACTION on the generator to claim this bunker!","Claim Air Tower",_ObjMM], (getpos _Generator), "CREATED", 90, true, "", true] call BIS_fnc_taskCreate;
		_Generator setVariable ["DIS_ASOB",_ObjNSN];		
	};
	case "Assassinate" : 
	{
	
		[
			[_Pole,_SSide,_AtkSide,_NameLocation],
			{
				params ["_Pole","_SSide","_AtkSide","_NameLocation"];
				if (player distance2D _Pole < 3000 && {!(playerSide isEqualTo _SSide)} && {(_AtkSide isEqualTo playerSide)}) then
				{
					["DISTASK",[format ["SIDE OBJECTIVE: %1",_NameLocation],(MISSION_ROOT + "Pictures\types\attack_ca.paa"),"STEALTH ASSASSINATE",""]] call BIS_fnc_showNotification;
					[
					[
						["Assassinate Marked Target","align = 'center' shadow = '1' size = '0.5' font='RobotoCondensed'"],
						["","<br/>"],
						["Do Not Alert The Town","align = 'center' shadow = '1' size = '0.5' font='RobotoCondensed'"]
					]
					] spawn BIS_fnc_typeText2;				
				};
			}
			
		] remoteExec ["bis_fnc_Spawn",0]; 	
	
		private _Building = false;
		private _ClstBuilding = objNull;
		private _SpwnPos = [0,0,0];
		if (count _StrongHoldBuildings > 0) then
		{
			_ClstBuilding = [_StrongHoldBuildings,_RndPos,true,"TObj1"] call dis_closestobj;
			_Building = true;
		}
		else
		{
			_SpwnPos = _RndPos;
		};
		
		private _SpwnUnit = "I_Story_Officer_01_F";
		
		if (_SSide isEqualTo West) then
		{
			_SpwnUnit = "B_Story_SF_Captain_F";
		};
		
		if (_SSide isEqualTo East) then
		{
			_SpwnUnit = "O_A_soldier_TL_F";
		};		
	
		private _unit = objNull;
		if (_Building) then
		{
			private _SpwnPntD =  selectRandom ([_ClstBuilding] call BIS_fnc_buildingPositions);
			_unit = _grpGarrison createUnit [_SpwnUnit ,_SpwnPntD, [], 0, "CAN_COLLIDE"];
			_unit setVariable ["DIS_SPECIAL",true,true];
			_unit setPosATL (_SpwnPntD);
			[_unit] joinSilent _grpGarrison;
			_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];			
		}
		else
		{
			_unit = _grpGarrison createUnit [_SpwnUnit ,_RndPos, [], 0, "CAN_COLLIDE"];
			_unit setVariable ["DIS_SPECIAL",true,true];
			_unit setPosATL [(_RndPos select 0),(_RndPos select 1),0];
			_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
			[_unit] joinSilent _grpGarrison;
		};
	
		[
			[_unit,_Pole,_SSide,_AtkSide],
			{
				if !(hasInterface) exitwith {};		
				sleep 15;
				waitUntil {!(isNil "MISSION_ROOT")};
				params ["_unit","_Pole","_SSide","_AtkSide"];
				if (playerSide isEqualTo _SSide) exitWith {};
				private _Img = MISSION_ROOT + "Pictures\tridentEnemy_ca.paa";
				[((str _unit) + "DESTROY"), "onEachFrame", 
				{
					params ["_Img","_unit","_Pole"];
					if (alive _unit && {_Pole getVariable ["DIS_ENGAGED",false]}) then
					{
						_pos2 = getposATL _unit;
						_pos2 set [2,(_pos2 select 2) + 2];
						_alphaText = round(linearConversion[25, 2000, player distance2D _unit, 1, 0, true]);
						call compile format 
						[
						'
						drawIcon3D
						[
							%1,
							[0.95,0.95,0,%3],
							%2,
							0.5,
							0.5,
							0,
							"Assassinate",
							2,
							0.04,
							"RobotoCondensed",
							"center",
							false
						];
						'
						,str _Img,_pos2,_alphaText
						]
					}
					else
					{
						[((str _unit) + "DESTROY"), "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
					};
				},
				[_Img,_unit,_Pole]
				] call BIS_fnc_addStackedEventHandler;			

			}
			
		] remoteExec ["bis_fnc_Spawn",0,_unit];	
	
		[_unit,_pole,_AtkSide,_NameLocation] spawn
		{
			params ["_unit","_pole","_AtkSide","_NameLocation"];
			private _Aware = false;
			private _UGroup = (group _Unit);
			while {alive _unit && {!(_Aware)} && {_Pole getVariable ["DIS_ENGAGED",false]}} do
			{
				{
					if ((leader _x) distance2D _Unit < 300 && {((behaviour (leader _x)) isEqualTo "COMBAT")}) exitWith 
					{
						_Aware = true;

						private _Unit = (_this select 0);

						private _DO = _Unit getVariable "DIS_DSOB";
						private _AO = _Unit getVariable "DIS_ASOB";
						[_DO,"SUCCEEDED"] call BIS_fnc_taskSetState;
						[_AO,"FAILED"] call BIS_fnc_taskSetState;

						[
							[_unit,_AtkSide,_NameLocation],
							{
								params ["_unit","_AtkSide","_NameLocation"];
								if (player distance2D _unit < 3000 && {(_AtkSide isEqualTo playerSide)}) then
								{
									["DISTASK",[format ["SIDE OBJECTIVE FAILED: %1",_NameLocation],(MISSION_ROOT + "Pictures\types\land_ca.paa"),"FAILED TO ASSASSINATE",""]] call BIS_fnc_showNotification;
									[
									[
										["Town Alerted - Troop Count Doubled","align = 'center' shadow = '1' size = '0.5' font='RobotoCondensed'"]
									]
									] spawn BIS_fnc_typeText2;				
								};
							}
						] remoteExec ["bis_fnc_Spawn",0]; 								
					};
				} foreach (allgroups select {(side _x) isEqualTo (side _UGroup)});
				sleep 30;
			};				
			if (_Pole getVariable ["DIS_ENGAGED",false]) then
			{
				if (_Aware) then
				{
					private _Var1 = _Pole getVariable "DIS_Capture";
					private _SpawnAmount = _Var1 select 1;
					_Var1 set [1,(_SpawnAmount*2)];
					_Pole setVariable ["DIS_Capture",_Var1,true];					
				}
				else
				{
					private _Var1 = _Pole getVariable "DIS_Capture";
					private _SpawnAmount = _Var1 select 1;
					_Var1 set [1,(_SpawnAmount/2)];
					_Pole setVariable ["DIS_Capture",_Var1,true];

					private _DO = _Unit getVariable "DIS_DSOB";
					private _AO = _Unit getVariable "DIS_ASOB";
					[_DO,"FAILED"] call BIS_fnc_taskSetState;
					[_AO,"SUCCEEDED"] call BIS_fnc_taskSetState;

					[
						[_unit,_AtkSide,_NameLocation],
						{
							params ["_unit","_AtkSide","_NameLocation"];
							if (player distance2D _unit < 3000 && {(_AtkSide isEqualTo playerSide)}) then
							{
								["DISTASK",[format ["SIDE OBJECTIVE COMPLETED: %1",_NameLocation],(MISSION_ROOT + "Pictures\types\danger_ca.paa"),"TARGET ASSASSINATED",""]] call BIS_fnc_showNotification;
								[
									[
										["Officer Assassinated - Troop Count Halved","align = 'center' shadow = '1' size = '0.5' font='RobotoCondensed'"]
									]
								] spawn BIS_fnc_typeText2;				
							};
						}
						
					] remoteExec ["bis_fnc_Spawn",0]; 							
				};
			};
			deleteVehicle _unit;
		};	

		//Marker for tasks
		private _ObjMM = createMarker [(format ["%1",(random 10000)]),(getpos _unit)];
		_ObjMM setmarkershape "ICON";
		_ObjMM setMarkerType "Empty";
		_pole setVariable ["DIS_TASKM",_ObjMM];

		//Defend task!
		private _ObjN = _pole getVariable "DIS_DefendTID";
		private _ObjSN = _pole getVariable ["DIS_DefendTISSO",[]];
		private _ObjNSN = (format ["%1-%2",_Pole,"HeavyBunkerA"]); 
		_ObjSN pushBack _ObjNSN;
		_pole setVariable ["DIS_DefendTISSO",_ObjSN];
		[_SSide,[_ObjNSN,_ObjN], ["Protect this VIP! If the enemy is detected before the VIP is killed, the VIP will double the amount of reinforcements in the zone. If he is killed before enemies are detected, our reinforcements will be cut in half.","Protect the VIP",_ObjMM], (getpos _unit), "CREATED", 90, true, "", true] call BIS_fnc_taskCreate;
		_unit setVariable ["DIS_DSOB",_ObjNSN];

		//Attack task!
		private _ObjN = _pole getVariable "DIS_AttackTID";
		private _ObjSN = _pole getVariable ["DIS_AttackTISSO",[]];
		private _ObjNSN = (format ["%1-%2",_Pole,"HeavyBunkerD"]); 
		_ObjSN pushBack _ObjNSN;
		_pole setVariable ["DIS_AttackTISSO",_ObjSN];
		[_AtkSide,[_ObjNSN,_ObjN], ["Assassinate the VIP before becoming detected! If the enemy detects us before the VIP is killed, the VIP will double the amount of reinforcements in the zone. If he is killed before we are are detected, their reinforcements will be cut in half.","Assassinate the VIP",_ObjMM], (getpos _unit), "CREATED", 90, true, "", true] call BIS_fnc_taskCreate;	
		_unit setVariable ["DIS_ASOB",_ObjNSN];
	};
	case "Artillery" : 
	{
		[
			[_Pole,_SSide,_AtkSide,_NameLocation],
			{
				params ["_Pole","_SSide","_AtkSide","_NameLocation"];
				if (player distance2D _Pole < 6000 && {!(playerSide isEqualTo _SSide)} && {(_AtkSide isEqualTo playerSide)}) then
				{
					["DISTASK",[format ["SIDE OBJECTIVE: %1",_NameLocation],(MISSION_ROOT + "Pictures\types\attack_ca.paa"),"KILL ARTILLERY SPOTTER",""]] call BIS_fnc_showNotification;
					[
					[
						["Eliminate Artillery Spotter","align = 'center' shadow = '1' size = '0.5' font='RobotoCondensed'"],
						["","<br/>"],
						["The Town Will Constantly Call for Artillery Support","align = 'center' shadow = '1' size = '0.5' font='RobotoCondensed'"]
					]
					] spawn BIS_fnc_typeText2;				
				};
			}
			
		] remoteExec ["bis_fnc_Spawn",0];

		private _Building = false;
		private _ClstBuilding = objNull;
		private _SpwnPos = [0,0,0];
		if (count _StrongHoldBuildings > 0) then
		{
			_ClstBuilding = [_StrongHoldBuildings,_RndPos,true,"TObj1"] call dis_closestobj;
			_Building = true;
		}
		else
		{
			_SpwnPos = _RndPos;
		};
		
		private _SpwnUnit = "I_Story_Officer_01_F";
		
		if (_SSide isEqualTo West) then
		{
			_SpwnUnit = "B_Story_SF_Captain_F";
		};
		
		if (_SSide isEqualTo East) then
		{
			_SpwnUnit = "O_A_soldier_TL_F";
		};		
	
		private _unit = objNull;
		if (_Building) then
		{
			private _SpwnPntD =  selectRandom ([_ClstBuilding] call BIS_fnc_buildingPositions);
			_unit = _grpGarrison createUnit [_SpwnUnit ,_SpwnPntD, [], 0, "CAN_COLLIDE"];
			_unit setVariable ["DIS_SPECIAL",true,true];
			_unit setPosATL (_SpwnPntD);
			[_unit] joinSilent _grpGarrison;
			_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];			
		}
		else
		{
			_unit = _grpGarrison createUnit [_SpwnUnit ,_RndPos, [], 0, "CAN_COLLIDE"];
			_unit setVariable ["DIS_SPECIAL",true,true];
			_unit setPosATL [(_RndPos select 0),(_RndPos select 1),0];
			_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
			[_unit] joinSilent _grpGarrison;
		};
		
		//Marker for tasks
		private _ObjMM = createMarker [(format ["%1",(random 10000)]),(getpos _unit)];
		_ObjMM setmarkershape "ICON";
		_ObjMM setMarkerType "Empty";
		_pole setVariable ["DIS_TASKM",_ObjMM];

		//Defend task!
		private _ObjN = _pole getVariable "DIS_DefendTID";
		private _ObjSN = _pole getVariable ["DIS_DefendTISSO",[]];
		private _ObjNSN = (format ["%1-%2",_Pole,"HeavyBunkerA"]); 
		_ObjSN pushBack _ObjNSN;
		_pole setVariable ["DIS_DefendTISSO",_ObjSN];
		[_SSide,[_ObjNSN,_ObjN], ["The artillery spotter will periodically call in artillery on enemy locations. Once he dies, he will no longer be able to call in artillery support.","Protect Artillery Spotter",_ObjMM], (getpos _unit), "CREATED", 90, true, "", true] call BIS_fnc_taskCreate;
		_unit setVariable ["DIS_DSOB",_ObjNSN];

		//Attack task!
		private _ObjN = _pole getVariable "DIS_AttackTID";
		private _ObjSN = _pole getVariable ["DIS_AttackTISSO",[]];
		private _ObjNSN = (format ["%1-%2",_Pole,"HeavyBunkerD"]); 
		_ObjSN pushBack _ObjNSN;
		_pole setVariable ["DIS_AttackTISSO",_ObjSN];
		[_AtkSide,[_ObjNSN,_ObjN], ["The artillery spotter will periodically call in artillery on enemy locations. Once he dies, he will no longer be able to call in artillery support.","Assassinate Artillery Spotter",_ObjMM], (getpos _unit), "CREATED", 90, true, "", true] call BIS_fnc_taskCreate;		
		_unit setVariable ["DIS_ASOB",_ObjNSN];	

		
		[
			[_unit,_Pole,_SSide,_AtkSide],
			{
				if !(hasInterface) exitwith {};		
				sleep 15;
				waitUntil {!(isNil "MISSION_ROOT")};
				params ["_unit","_Pole","_SSide","_AtkSide"];
				if (playerSide isEqualTo _SSide) exitWith {};
				private _Img = MISSION_ROOT + "Pictures\tridentEnemy_ca.paa";
				[((str _unit) + "DESTROY"), "onEachFrame", 
				{
					params ["_Img","_unit","_Pole"];
					if (alive _unit && {_Pole getVariable ["DIS_ENGAGED",false]}) then
					{
						_pos2 = getposATL _unit;
						_pos2 set [2,(_pos2 select 2) + 2];
						_alphaText = round(linearConversion[25, 2000, player distance2D _unit, 1, 0, true]);
						call compile format 
						[
						'
						drawIcon3D
						[
							%1,
							[0.95,0.95,0,%3],
							%2,
							0.5,
							0.5,
							0,
							"Eliminate",
							2,
							0.04,
							"RobotoCondensed",
							"center",
							false
						];
						'
						,str _Img,_pos2,_alphaText
						]
					}
					else
					{
						[((str _unit) + "DESTROY"), "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
					};
				},
				[_Img,_unit,_Pole]
				] call BIS_fnc_addStackedEventHandler;			

			}
			
		] remoteExec ["bis_fnc_Spawn",0,_unit];	
		
		[_unit,_Pole,_SSide] spawn
		{
			params ["_unit","_Pole","_SSide"];
			private _Aware = false;
			while {alive _unit && {_Pole getVariable ["DIS_ENGAGED",false]}} do
			{
				sleep 120;
				{
					if ((behaviour (leader _x)) isEqualTo "COMBAT" && {(leader _x) distance2D _unit < 1000}) then 
					{
						_Aware = true;						
					};
					true;
				} count (allgroups select {(side _x) isEqualTo _SSide});
				if (_Aware) then
				{
					private _AllGroup = [];
					{
						if ((leader _x distance2D _unit) < 500) then
						{
							_AllGroup pushBack (leader _x);
						};
						true;
					} count (allgroups select {!((side _x) isEqualTo _SSide)});
					if (count _AllGroup > 0) then
					{
						private _pos = (getpos (selectRandom _AllGroup));
						private _smoke = "SmokeShellRed" createVehicle _pos;
						sleep 30;
						_pos spawn
						{
							{
								sleep 1;
								private _rnd = random 110;
								private _dist = (_rnd + 1);
								private _dir = random 360;
								private _positions = [(_this select 0) + (sin _dir) * _dist, (_this select 1) + (cos _dir) * _dist,1000];
								private _shell = createVehicle ["Missile_AGM_02_F", _positions, [], 0, "CAN_COLLIDE"];  
								[_shell, -90, 0] call BIS_fnc_setPitchBank;
							} foreach [1,2,4,5,6,7,8,9,10,11,12];
						};
					};
				};
			};

			private _DO = _unit getVariable "DIS_DSOB";
			private _AO = _unit getVariable "DIS_ASOB";
			[_DO,"FAILED"] call BIS_fnc_taskSetState;
			[_AO,"SUCCEEDED"] call BIS_fnc_taskSetState;

		};	


	};
	case "DefendPointA" : 
	{
			
		[
			[_Pole,_SSide,_AtkSide,_NameLocation],
			{
				params ["_Pole","_SSide","_AtkSide","_NameLocation"];
				if (player distance2D _Pole < 3000 && {!(playerSide isEqualTo _SSide)} && {(_AtkSide isEqualTo playerSide)}) then
				{
					["DISTASK",[format ["SIDE OBJECTIVE: %1",_NameLocation],(MISSION_ROOT + "Pictures\types\attack_ca.paa"),"CAPTURE AND DEFEND COMPOUND",""]] call BIS_fnc_showNotification;
					[
					[
						["Capture and Defend Military Compound","align = 'center' shadow = '1' size = '0.5' font='RobotoCondensed'"],
						["","<br/>"],
						["Objective will Call for Reinforcements.","align = 'center' shadow = '1' size = '0.5' font='RobotoCondensed'"]
					]
					] spawn BIS_fnc_typeText2;				
				};
			}
			
		] remoteExec ["bis_fnc_Spawn",0]; 	
		private _OpenAreas = selectBestPlaces [_PolePos, 250, "meadow", 25, 1];	
		private _PrePos = ((_OpenAreas select 0) select 0);
		private _FinalPos = [_PrePos, 10, 300, 0, 0, 0.05, 0, [], [_PrePos,_PrePos]] call BIS_fnc_findSafePos;
		
		private _Generator = "C_IDAP_CargoNet_01_supplies_F" createVehicle [0,0,0];
		_Generator setvariable ["DIS_PLAYERVEH",true,true];
		_Generator allowdamage false;	
		_Generator addEventHandler ["HandleDamage", {0}];
		_Generator setVariable ["DIS_TowerPole",_Pole,true];			
		_Generator setVariable ["DIS_PUSHED",false,true];
		
		
		//SPAWN PREFAB SERVER SIDE
		[
			[_FinalPos,_Generator,_Pole,_SSide],
			{
				params ["_FinalPos","_Generator","_Pole","_SSide"];
				private _TerArray = [];
				{
					_x hideObjectGlobal true;
					_TerArray pushback _x;
					true;
				} count (nearestTerrainObjects [_FinalPos, [], 50,false]);				
				private _compReference = ["DefendPointA",[(_FinalPos select 0),(_FinalPos select 1),0], [0,0,0], (random 360), true, true ] call LARs_fnc_spawnComp; 
				while {_Pole getVariable ["DIS_ENGAGED",false]} do
				{
					[_Generator,"bobcat_engine_loop"] remoteExec ["PlaySoundEverywhereSay3D",0];	
					sleep 5;
				};
				{
					_x hideObjectGlobal false;
					true;
				} count _TerArray;
				deleteVehicle _Generator;
				private _Mens = nearestObjects [(getposATL _Generator), ["Man"], 50];
				{if (!(isPlayer _x) && {!(isplayer (leader _x))}) then {_x setDamage 1;};true;} count (_Mens select {(side _x isEqualTo _SSide)});
				[_compReference] call LARs_fnc_deleteComp;					
			}
			
		] remoteExec ["bis_fnc_Spawn",2];		
		
		sleep 15;			
		private _Objs = nearestObjects [_FinalPos, ["VR_Shape_base_F","VR_CoverObject_base_F"], 100];
		{
			private _Type = typeOf _x;
			if (_Type isEqualTo "Land_VR_Shape_01_cube_1m_F") then
			{
				private _Dir = getDir _x;				
				private _unit = _grpGarrison createUnit [(selectRandom _InfantryList) ,(getposATL _x), [], 0, "CAN_COLLIDE"];
				_unit setVariable ["DIS_SPECIAL",true,true];
				_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
				[_unit,(typeOf _unit)] call DIS_fnc_UniformHandle;
				_unit setposATL (getposATL _x);
				_unit disableAI "PATH";
				_unit setUnitPos "UP";
				_unit setdir _Dir;
				[_unit] joinSilent _grpGarrison;				
			};
			if (_Type isEqualTo "Land_VR_CoverObject_01_kneelHigh_F") then
			{
				_ObjSpwnPos = getpos _x;
			};
			deleteVehicle _x;
		} foreach _Objs;

		_Generator setpos [(_ObjSpwnPos select 0),(_ObjSpwnPos select 1),((_ObjSpwnPos select 2) + 3)];

		[
			[_Generator,_Pole,_SSide,_InfantryList,_AtkSide],
			{
				params ["_Generator","_Pole","_SSide","_InfantryList","_AtkSide"];
				if (playerSide isEqualTo _SSide) exitWith {};
				
				if !(playerSide isEqualTo _SSide) then
				{
					//private _Addaction = [_Generator,"Defend the Compound","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa","_this distance _target < 1000","true",{hint "Claiming!";},{},{[[(_this select 3 select 0),(_this select 3 select 1),(_this select 3 select 2),(_this select 3 select 3),(_this select 3 select 4),(_this select 3 select 5)],{_this call (_this select 4);}] remoteExec ["bis_fnc_Spawn",2];},{hint "Stopped!"},[_Generator,_Pole,_SSide,_InfantryList,_DIS_TEMPF,_AtkSide],8,0,true,true] call bis_fnc_holdActionAdd;
					private _Addaction = [_Generator,"Begin the Defence!","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa","_this distance _target < 1000","true",{hint "Claiming!";},{},{(_this select 0) spawn {_this setDamage 1;};},{hint "Stopped!"},[],8,0,true,true] call bis_fnc_holdActionAdd;				
				};
				if (_AtkSide isEqualTo playerSide) then
				{						
					private _ObjM = createMarkerlocal [(format ["%1_%2",_Pole,(getpos _Generator)]),(getpos _Generator)];
					_ObjM setmarkershapelocal "ICON";
					_ObjM setMarkerTypelocal "mil_end";
					_ObjM setmarkercolorlocal "ColorEAST";
					_ObjM setmarkersizelocal [0.4,0.4];
					_ObjM setMarkerAlphalocal 1;
					_ObjM setMarkerTextLocal "SIDE OBJ: MILITARY COMPOUND";
					[_ObjM,_Pole,_Generator] spawn
					{
						params ["_Mrk","_Pole","_Generator"];
						waitUntil {!(alive _Generator) || !(_Pole getVariable ["DIS_ENGAGED",false])};
						deleteMarker _Mrk;
					};
				};
										
				
				private _Img = MISSION_ROOT + "Pictures\defend_ca.paa";
				[((str _Generator) + "DESTROY"), "onEachFrame", 
				{
					params ["_Img","_Generator","_Pole"];
					if (alive _Generator && {_Pole getVariable ["DIS_ENGAGED",false]}) then
					{
						_pos2 = getposATL _Generator;
						_pos2 set [2,(_pos2 select 2) + 2];
						_alphaText = round(linearConversion[25, 2000, player distance2D _Generator, 1, 0, true]);
						call compile format 
						[
						'
						drawIcon3D
						[
							%1,
							[0.95,0.95,0,%3],
							%2,
							0.75,
							0.75,
							0,
							"Military Compound",
							2,
							0.04,
							"RobotoCondensed",
							"center",
							false
						];
						'
						,str _Img,_pos2,_alphaText
						]
					}
					else
					{
						[((str _Generator) + "DESTROY"), "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
					};
				},
				[_Img,_Generator,_Pole]
				] call BIS_fnc_addStackedEventHandler;			
			
		
			}
			
		] remoteExec ["bis_fnc_Spawn",0,_Generator]; 		

		
		
		[_Generator,_Pole,_SSide,_AtkSide,_NameLocation] spawn
		{
			params ["_Generator","_Pole","_SSide","_AtkSide","_NameLocation"];
			private _Aware = false;
			private _Msg = false;
			while {alive _Generator && {_Pole getVariable ["DIS_ENGAGED",false]}} do
			{
				sleep 30;
				{
					if ((behaviour (leader _x)) isEqualTo "COMBAT" && {(leader _x) distance2D _Generator < 1000}) then 
					{
						_Aware = true;						
					};
					true;
				} count (allgroups select {(side _x) isEqualTo _SSide});
				if (_Aware) then
				{
					if !(_Msg) then
					{
					[
						[_Pole,_AtkSide,_NameLocation],
						{
							params ["_Pole","_AtkSide","_NameLocation"];
							if (player distance2D _Pole < 3000 && {(_AtkSide isEqualTo playerSide)}) then
							{
								["DISTASK",[format ["SIDE OBJECTIVE: %1",_NameLocation],(MISSION_ROOT + "Pictures\types\land_ca.paa"),"ENEMY ALERTED",""]] call BIS_fnc_showNotification;
								[
								[
									["Enemies Alerted: Town Being Reinforced","align = 'center' shadow = '1' size = '0.5' font='RobotoCondensed'"]
								]
								] spawn BIS_fnc_typeText2;		
							};
						}
						
					] remoteExec ["bis_fnc_Spawn",0]; 	
					_Msg = true;
					};
					private _Var1 = _Pole getVariable "DIS_Capture";
					private _SpawnAmount = _Var1 select 1;
					private _SpawnAmount = _Var1 select 1;
					if (_SpawnAmount < 100) then
					{					
						_Var1 set [1,(_SpawnAmount + 6)];
						_Pole setVariable ["DIS_Capture",_Var1,true];
					};
				};
			};	
		};

		[_Generator,_Pole,_SSide,_InfantryList,_AtkSide,_NameLocation] spawn
		{
						params ["_Generator","_Pole","_SSide","_InfantryList","_AtkSide","_NameLocation"];		
						waitUntil {!(alive _Generator)};
						_Generator hideObjectGlobal true;						
						private _SpwnT = 0;		
						private _NGroup = createGroup _SSide;
						private _waypoint = _NGroup addwaypoint[(getpos _Generator),1];
						_waypoint setwaypointtype "MOVE";
						_waypoint setWaypointSpeed "NORMAL";
						private _waypoint2 = _NGroup addwaypoint[(getpos _Generator),1];
						_waypoint2 setwaypointtype "MOVE";
						_waypoint2 setWaypointSpeed "NORMAL";		
						_waypoint setWaypointBehaviour "AWARE";		
						_waypoint2 setWaypointBehaviour "AWARE";		
						_NGroup setCurrentWaypoint _waypoint;						
						[
							[_Pole,_SSide,_AtkSide,_NameLocation],
							{
								params ["_Pole","_SSide","_AtkSide","_NameLocation"];
								if (player distance2D _Pole < 3000 && {!(playerSide isEqualTo _SSide)} && {(_AtkSide isEqualTo playerSide)}) then
								{
									["DISTASK",[format ["SIDE OBJECTIVE: %1",_NameLocation],(MISSION_ROOT + "Pictures\types\defend_ca.paa"),"DEFEND COMPOUND",""]] call BIS_fnc_showNotification;
									[
										[
											["Enemy Forces Assaulting the Compound.","align = 'center' shadow = '1' size = '0.5' font='RobotoCondensed'"]
										]
									] spawn BIS_fnc_typeText2;		
								};
							}
							
						] remoteExec ["bis_fnc_Spawn",0]; 							
						
						
						while {_SpwnT < 35 && {_Pole getVariable ["DIS_ENGAGED",false]}} do
						{
							private _unit = _NGroup createUnit [(selectRandom _InfantryList),(getpos _Pole), [], 0, "CAN_COLLIDE"];
							_unit setVariable ["DIS_SPECIAL",true,true];
							_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
							[_unit,(typeOf _unit)] call DIS_fnc_UniformHandle;
							_SpwnT = _SpwnT + 1;
							sleep 0.01;
							waitUntil {({alive _x} count (units _NGroup)) < 12};
						};		

							private _DO = _Generator getVariable "DIS_DSOB";
							private _AO = _Generator getVariable "DIS_ASOB";
							[_DO,"FAILED"] call BIS_fnc_taskSetState;
							[_AO,"SUCCEEDED"] call BIS_fnc_taskSetState;						

						[
							[_Pole,_AtkSide,_NameLocation],
							{
								params ["_Pole","_AtkSide","_NameLocation"];
								if (player distance2D _Pole < 3000 && {(_AtkSide isEqualTo playerSide)}) then
								{
									["DISTASK",[format ["SIDE OBJECTIVE COMPLETED: %1",_NameLocation],(MISSION_ROOT + "Pictures\types\danger_ca.paa"),"COMPOUND DEFENDED",""]] call BIS_fnc_showNotification;
									[
									[
										["Compound Defended. Side Objective Completed.","align = 'center' shadow = '1' size = '0.5' font='RobotoCondensed'"]
									]
									] spawn BIS_fnc_typeText2;		
								};
							}
							
						] remoteExec ["bis_fnc_Spawn",0];						
		
		};
	
		//Marker for tasks
		private _ObjMM = createMarker [(format ["%1",(random 10000)]),(getpos _Generator)];
		_ObjMM setmarkershape "ICON";
		_ObjMM setMarkerType "Empty";
		_pole setVariable ["DIS_TASKM",_ObjMM];

		//Defend task!
		private _ObjN = _pole getVariable "DIS_DefendTID";
		private _ObjSN = _pole getVariable ["DIS_DefendTISSO",[]];
		private _ObjNSN = (format ["%1-%2",_Pole,"HeavyBunkerA"]); 
		_ObjSN pushBack _ObjNSN;
		_pole setVariable ["DIS_DefendTISSO",_ObjSN];
		[_SSide,[_ObjNSN,_ObjN], ["Prevent the enemies from capturing the compound! This compound will constantly reinforce the town. If the enemy claims this compound we will launch a counter attack to retake it.","Defend Compound",_ObjMM], (getpos _Generator), "CREATED", 90, true, "", true] call BIS_fnc_taskCreate;
		_Generator setVariable ["DIS_dSOB",_ObjNSN];	

		//Attack task!
		private _ObjN = _pole getVariable "DIS_AttackTID";
		private _ObjSN = _pole getVariable ["DIS_AttackTISSO",[]];
		private _ObjNSN = (format ["%1-%2",_Pole,"HeavyBunkerD"]); 
		_ObjSN pushBack _ObjNSN;
		_pole setVariable ["DIS_AttackTISSO",_ObjSN];
		[_AtkSide,[_ObjNSN,_ObjN], ["This compound will constantly reinforce the town. If we claim this compound the enemy will launch a counter attack to retake it.","Claim Compound",_ObjMM], (getpos _Generator), "CREATED", 90, true, "", true] call BIS_fnc_taskCreate;
		_Generator setVariable ["DIS_ASOB",_ObjNSN];	
	};	
	case "Shoothouse" :
	{
		
		[
			[_Pole,_SSide,_AtkSide,_NameLocation],
			{
				params ["_Pole","_SSide","_AtkSide","_NameLocation"];
				if (player distance2D _Pole < 6000 && {!(playerSide isEqualTo _SSide)} && {(_AtkSide isEqualTo playerSide)}) then
				{
					["DISTASK",[format ["SIDE OBJECTIVE: %1",_NameLocation],(MISSION_ROOT + "Pictures\types\documents_ca.paa"),"RECOVER DOCUMENTS",""]] call BIS_fnc_showNotification;
					[
					[
						["Recover Intel Documents","align = 'center' shadow = '1' size = '0.5' font='RobotoCondensed'"],
						["","<br/>"],
						["Each Intel Provides Cash and XP","align = 'center' shadow = '1' size = '0.5' font='RobotoCondensed'"]
					]
					] spawn BIS_fnc_typeText2;					
				};
			}
			
		] remoteExec ["bis_fnc_Spawn",0,_Pole]; 	
	
		private _OpenAreas = selectBestPlaces [_PolePos, 300, "meadow", 25, 1];	
		private _PrePos = ((_OpenAreas select 0) select 0);
		private _FinalPos = [_PrePos, 10, 500, 0, 0, 0.05, 0, [], [_PrePos,_PrePos]] call BIS_fnc_findSafePos;
		_FinalPos set [2,0];
		private _CSH = selectRandom ["SH1","Barracks","HeavyCamp1"];
		
		//SPAWN PREFAB SERVER SIDE
		private _RMES = (str _FinalPos);	
		[
			[_CSH,_FinalPos,_Pole,_SSide,_RMES],
			{
				params ["_CSH","_FinalPos","_Pole","_SSide","_RMES"];
				private _TerArray = [];
				{
					_x hideObjectGlobal true;
					_TerArray pushback _x;
				} forEach (nearestTerrainObjects [_FinalPos, [], 50,false]);				
				private _compReference = [_CSH,[(_FinalPos select 0),(_FinalPos select 1),0], [0,0,0], (random 360), true, true ] call LARs_fnc_spawnComp; 
				while {_Pole getVariable ["DIS_ENGAGED",false]} do
				{
					sleep 5;
				};
				{
					_x hideObjectGlobal false;
				} forEach _TerArray;
				private _Mens = nearestObjects [_FinalPos, ["Man"], 50];
				{if (!(isPlayer _x) && {!(isplayer (leader _x))}) then {_x setDamage 1;};true;} count (_Mens select {(side _x isEqualTo _SSide)});
				[_compReference] call LARs_fnc_deleteComp;
				remoteExecCall ["",_RMES]; 
			}
			
		] remoteExec ["bis_fnc_Spawn",2];			
		
		sleep 15;
		private _DocumentA = [];
		private _Objs = nearestObjects [_FinalPos, ["VR_Shape_base_F","VR_CoverObject_base_F","Items_base_F"], 50];
		{
			private _Type = typeOf _x;
			_x setvariable ["DIS_PLAYERVEH",true,true];
			if (_Type isEqualTo "Land_VR_Shape_01_cube_1m_F") then
			{
				if (random 100 > 50) then
				{
					private _Dir = getDir _x;					
					private _unit = _grpGarrison createUnit [(selectRandom _InfantryList) ,(getposATL _x), [], 0, "CAN_COLLIDE"];
					_unit setVariable ["DIS_SPECIAL",true,true];
					_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
					[_unit,(typeOf _unit)] call DIS_fnc_UniformHandle;
					_unit setposATL (getposATL _x);
					_unit disableAI "PATH";
					_unit setdir _Dir;
					[_unit] joinSilent _grpGarrison;	
				};
				deleteVehicle _x;
			};
			if (_Type isEqualTo "Land_File1_F") then
			{
				_DocumentA pushback _x;
				private _Pos = getpos _x;
				_x setpos [(_Pos select 0),(_Pos select 1),((_Pos select 2) + 2)];
			};
		} foreach _Objs;
		
		//Marker for tasks
		private _ObjMM = createMarker [(format ["%1",(random 10000)]),_FinalPos];
		_ObjMM setmarkershape "ICON";
		_ObjMM setMarkerType "Empty";
		_pole setVariable ["DIS_TASKM",_ObjMM];

		//Defend task!
		private _ObjN = _pole getVariable "DIS_DefendTID";
		private _ObjSN = _pole getVariable ["DIS_DefendTISSO",[]];
		private _ObjNSN = (format ["%1-%2",_Pole,"HeavyBunkerA"]); 
		_ObjSN pushBack _ObjNSN;
		_pole setVariable ["DIS_DefendTISSO",_ObjSN];
		[_SSide,[_ObjNSN,_ObjN], ["Prevent enemy forces from capturing this intel! The intel gives them XP and money! Objective will only be removed once main objective is completed.","Protect Intel",_ObjMM], _FinalPos, "CREATED", 90, true, "", true] call BIS_fnc_taskCreate;


		//Attack task!
		private _ObjN = _pole getVariable "DIS_AttackTID";
		private _ObjSN = _pole getVariable ["DIS_AttackTISSO",[]];
		private _ObjNSN = (format ["%1-%2",_Pole,"HeavyBunkerD"]); 
		_ObjSN pushBack _ObjNSN;
		_pole setVariable ["DIS_AttackTISSO",_ObjSN];
		[_AtkSide,[_ObjNSN,_ObjN], ["Capture this intel! Each captured intel will provide XP and money! Objective will only be removed once main objective is completed.","Capture Intel",_ObjMM], _FinalPos, "CREATED", 90, true, "", true] call BIS_fnc_taskCreate;

		[
			[_FinalPos,_Pole,_SSide,_AtkSide,_DocumentA],
			{
				if !(hasInterface) exitwith {};	

				params ["_FinalPos","_Pole","_SSide","_AtkSide","_DocumentA"];
				[_FinalPos,_Pole,_SSide,_AtkSide,_DocumentA] spawn
				{
					sleep 45;
					waitUntil {!(isNil "MISSION_ROOT")};
					params ["_FinalPos","_Pole","_SSide","_AtkSide","_DocumentA"];
					
					{
						if !(isNull _x) then
						{
							private _Addaction = [_x,"Recover Documents","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa","_this distance _target < 1000","true",{hint "Taking!";},{},{(_this select 0) spawn {_this call dis_fnc_ClaimDocument;deleteVehicle _this;};},{hint "Stopped!"},[],2,0,true,true] call bis_fnc_holdActionAdd;
						};
					} foreach _DocumentA;
					
					if (_AtkSide isEqualTo playerSide) then
					{
						private _ObjM = createMarkerlocal [(format ["%1_%2",_Pole,_FinalPos]),_FinalPos];
						_ObjM setmarkershapelocal "ICON";
						_ObjM setMarkerTypelocal "mil_end";
						_ObjM setmarkercolorlocal "ColorEAST";
						_ObjM setmarkersizelocal [0.4,0.4];
						_ObjM setMarkerAlphalocal 1;
						_ObjM setMarkerTextLocal "SIDE OBJ: RECOVER DOCUMENTS";
						[_ObjM,_Pole] spawn
						{
							params ["_ObjM","_Pole"];
							waitUntil {!(_Pole getVariable ["DIS_ENGAGED",false])};
							deleteMarker _ObjM;
						};		
					};
					
					private _Img = MISSION_ROOT + "Pictures\types\documents_ca.paa";
					_pos2 = _FinalPos;
					_pos2 set [2,(_pos2 select 2) + 5];					
					[((str _FinalPos) + "DESTROY"), "onEachFrame", 
					{
						params ["_Img","_FinalPos","_Pole","_pos2"];
						if (_Pole getVariable ["DIS_ENGAGED",false]) then
						{
							_alphaText = round(linearConversion[25, 2000, player distance2D _FinalPos, 1, 0, true]);
							call compile format 
							[
							'
							drawIcon3D
							[
								%1,
								[0.95,0.95,0,%3],
								%2,
								0.75,
								0.75,
								0,
								"Capture Documents",
								2,
								0.04,
								"RobotoCondensed",
								"center",
								false
							];
							'
							,str _Img,_pos2,_alphaText
							]
						}
						else
						{
							[((str _FinalPos) + "DESTROY"), "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
						};
					},
					[_Img,_FinalPos,_Pole,_pos2]
					] call BIS_fnc_addStackedEventHandler;			
			};
		
			}
			
		] remoteExecCall ["bis_fnc_Spawn",0,_RMES];
	};	
	case default
	{
	
	};
};





/*
if (count _StrongHoldBuildings > 0) then
{
	private _ClstBuilding = [_StrongHoldBuildings,_RndPos,true,"TObj1"] call dis_closestobj;
};

		_compReference = ["HeavyBunker",(getpos player), [0,0,0], (random 360), true, true ] call LARs_fnc_spawnComp; 
		_compReference spawn {sleep 5;[ _this ] call LARs_fnc_deleteComp; };
		
		copyToClipboard str (typeof cursorObject);
		
		
		
		

		"Land_VR_CoverObject_01_kneelHigh_F"
		"Land_VR_Shape_01_cube_1m_F"