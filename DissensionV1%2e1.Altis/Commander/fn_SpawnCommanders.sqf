private _NewSave = "NewSave" call BIS_fnc_getParamValue;
private _CurrentMap = worldName;
private _LoadGame = (profileNamespace getVariable format["DIS_SG_%1",_CurrentMap]);
if (isNil "_LoadGame") then {_NewSave = 1;_LoadGame = 0;};
//_NewSave 1 means that we should start a brand new save.

	private ["_RanLoc1", "_position", "_list", "_SelectRoad", "_List", "_RanLoc", "_unit", "_veh", "_M"];
	//Spawn commanders in a random square
	private _SpawnLocation = FlagPoleArray;
	private _MaterialStart = "MaterialsResourceStart" call BIS_fnc_getParamValue;
	
	{
		private _PickRandom = selectrandom _SpawnLocation;
		
		//Lets spawn us close to the border of the map
		private _RanLoc1 = [_SpawnLocation,_PickRandom,false] call dis_closestobj;
		
		//Find random town to spawn in near the _RanLoc1
		private _NewArray = [];
		{
			if (_x distance2D _RanLoc1 < 3000) then
			{
				_NewArray pushback _x;
			};		
		} foreach _SpawnLocation;
		
		_RanLoc1 = selectRandom _NewArray;
		
		_SpawnLocation = _SpawnLocation - [_RanLoc1];
		if (_x isEqualTo West) then
		{
			_position = getPos _RanLoc1;
			if (_NewSave isEqualTo 1) then
			{
				BluControlledArray pushback _RanLoc1;		//TownArray _NewArray = [_marker1Names,_locationName,_FlagPole,_marker1,0,0,0,false,60];
				IndControlledArray = IndControlledArray - [_RanLoc1];
				publicVariable "BluControlledArray";			
				publicVariable "IndControlledArray";			
				{
					_FlagPole = _x select 2;
		
					if (_RanLoc1 isEqualTo _FlagPole) exitWith
					{
						_RanLoc1 setVariable ["DIS_Capture",[60,60,west],true];
						[
						[(_x select 3),West],
						{
								params ["_LandMarker","_Side"];			
								if (playerSide isEqualTo _Side) then
								{
									_LandMarker setMarkerColorLocal "ColorBlue";
									_LandMarker setMarkerAlphaLocal 0.3;	
								};
						}
						
						] remoteExec ["bis_fnc_Spawn",0]; 					
						
						
					}; 
				} foreach TownArray;
			}
			else
			{
				_Position = [0,0,0];
			};
			_grp = createGroup West;
			Dis_WestCommander = _grp createUnit ["B_GEN_Commander_F",[0,0,0], [], 0, "FORM"];
			[Dis_WestCommander] joinsilent _grp;
			_grp setGroupIdGlobal ["WEST COMMANDER"];		
			Dis_WestCommander allowdamage false;
			Dis_WestCommander addEventHandler ["HandleDamage", {0}];
			Dis_WestCommander hideObjectGlobal true;
			Dis_WestCommander enableSimulationGlobal false;
			Dis_WestCommander disableAI "MOVE";
			Dis_WestCommander lock true;
			Dis_WestCommander setVariable ["DIS_PLAYERVEH",true];
			_grp setVariable ["DIS_IMPORTANT",true];
			_grp setVariable ["Vcm_Disable",true];
			Dis_WestCommander	setpos _position;
	
			
			_SafePos = [Dis_WestCommander, 15, 150, 5, 0, 20, 0,[],[_position,_position]] call BIS_fnc_findSafePos;
			Dis_WestCommander setpos _SafePos;
			
	
			Dis_WestCommander call dis_CommanderPersonality;
			
			//W_RArray = [W_Oil,W_Power,W_Cash,W_Materials];
			W_RArray = 	[		100,			100,			100,				_MaterialStart];
			publicVariable "W_RArray";
			publicVariable "Dis_WestCommander";
			
			if (_NewSave isEqualTo 1) then
			{			
				_CR = [ResourceMapMarkerArray,Dis_WestCommander,true] call dis_closestobj;	
				[_CR,West] call dis_ConvertLand;
			};

			Dis_WestCommander setVectorUp [0,0,1];
			//Dis_WestCommander spawn {while {alive _this} do {sleep dis_ResourceTimer; Dis_BluforTickets = Dis_BluforTickets + 10; publicVariable "Dis_BluforTickets"};};
			//DIS_SAMTURRETS = ["B_SAM_System_01_F","B_AAA_System_01_F","B_SAM_System_02_F"];
			_Building = "Land_Bunker_01_HQ_F" createVehicle [0,0,0];
			_Building addEventHandler ["killed", {deleteVehicle (_this select 0);}];
			_Building spawn 
			{
				waitUntil
				{
					if (_this distance DIS_WestCommander > 50) then
					{
					_this setpos (getpos DIS_WestCommander);
					};
					sleep 30;
					!(alive _this)
				};					
			};
			Dis_WestCommander addEventHandler ["killed", 
			{
				[
					[],
					{
						if (hasInterface) then {East spawn DIS_fnc_WinGame};
						if (isServer) then
						{
							[East,8] call DIS_fnc_CommanderSpeak;
							sleep 2.5;
							private _Pos = getpos Dis_WestCommander;
							{
								createVehicle ["HelicopterExploSmall", ([_Pos,5,10] call dis_randompos), [], 0, "NONE"];
								sleep (0.2 + (random 0.5));
							} count [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];
							sleep 5;
							["commanderDead",false,true,true] call BIS_fnc_endMission;
							private _SV = profileNameSpace setVariable[format["DIS_SG_%1",worldName],nil];
							saveProfileNamespace;						
						};
					}
				] remoteExec ["bis_fnc_Spawn",0]; 		
			
			
			}
			];		

		};
		
		
		
		
		
		
		
		
		
		
		
		if (_x isEqualTo East) then
		{
			private _Remove1st = [_SpawnLocation,(getpos Dis_WestCommander),false] call dis_closestobj;
			
		//Find random town to spawn in near the _RanLoc1
		private _NewArray = [];
		{
			if (_x distance2D _Remove1st < 3000) then
			{
				_NewArray pushback _x;
			};		
		} foreach _SpawnLocation;
		
		_Remove1st = selectRandom _NewArray;			
			
			_position = getPos _Remove1st;
			if (_NewSave isEqualTo 0) then
			{
				_Position = [0,0,0];
			};
			
			_grp = createGroup East;
			Dis_EastCommander = _grp createUnit ["B_GEN_Commander_F",[0,0,0], [], 0, "FORM"];
			[Dis_EastCommander] joinsilent _grp;
			_grp setGroupIdGlobal ["EAST COMMANDER"];
			Dis_EastCommander allowdamage false;
			Dis_WestCommander addEventHandler ["HandleDamage", {0}];
			Dis_EastCommander setVariable ["DIS_PLAYERVEH",true];
			Dis_EastCommander lock true;		
			Dis_EastCommander hideObjectGlobal true;
			Dis_EastCommander enableSimulationGlobal false;	
			Dis_EastCommander disableAI "MOVE";			
			_grp setVariable ["DIS_IMPORTANT",true];
			_grp setVariable ["Vcm_Disable",true];


			if (_NewSave isEqualTo 1) then
			{
				OpControlledArray pushback _Remove1st;
				IndControlledArray = IndControlledArray - [_Remove1st];
				publicVariable "OpControlledArray";
				publicVariable "IndControlledArray";
				
				{
					_FlagPole = _x select 2;
					if (_Remove1st isEqualTo _FlagPole) exitWith
					{
						_Remove1st setVariable ["DIS_Capture",[60,60,east],true];
						[
						[(_x select 3),East],
						{
								params ["_LandMarker","_Side"];
								
								if (playerSide isEqualTo _Side) then
								{
									_LandMarker setMarkerColorLocal "ColorRed";
									_LandMarker setMarkerAlphaLocal 0.3;	
								};
						}
						
						] remoteExec ["bis_fnc_Spawn",0]; 			
						
					};
				} foreach TownArray;
			};

			Dis_EastCommander setpos _position;

			
			
			_SafePos = [Dis_EastCommander, 15, 150, 5, 0, 20, 0,[],[_position,_position]] call BIS_fnc_findSafePos;
			Dis_EastCommander setpos _SafePos;		
			
			
			Dis_EastCommander call dis_CommanderPersonality;
			
			//Create Variables for commander
			//E_RArray = [W_Oil,W_Power,W_Cash,W_Materials];
			E_RArray = 	[		100,			100,			100,				_MaterialStart];
			publicVariable "E_RArray";		
			publicVariable "Dis_EastCommander";
			
			if (_NewSave isEqualTo 1) then
			{
				_CR = [ResourceMapMarkerArray,Dis_EastCommander,true] call dis_closestobj;	
				[_CR,East] call dis_ConvertLand;		
			};
			
			Dis_EastCommander setVectorUp [0,0,1];
			_Building = "Land_Bunker_01_HQ_F" createVehicle [0,0,0];
			_Building addEventHandler ["killed", {deleteVehicle (_this select 0);}];
			_Building spawn 
			{
				waitUntil
				{
					if (_this distance DIS_EastCommander > 50) then
					{
					_this setpos (getpos DIS_EastCommander);
					};
					sleep 30;
					!(alive _this)
				};				
			};
			
			Dis_EastCommander addEventHandler ["killed", 
			{
				[
					[],
					{
						if (hasInterface) then {West spawn DIS_fnc_WinGame;};
						if (isServer) then
						{
							[West,8] call DIS_fnc_CommanderSpeak;
							sleep 2.5;
							private _Pos = getpos Dis_EastCommander;
							{
								createVehicle ["HelicopterExploSmall", ([_Pos,5,10] call dis_randompos), [], 0, "NONE"];
								sleep (0.2 + (random 0.5));
							} count [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];
							sleep 5;
							["commanderDead",false,true,true] call BIS_fnc_endMission;
							private _SV = profileNameSpace setVariable[format["DIS_SG_%1",worldName],nil];
							saveProfileNamespace;						
						};						
					}
				] remoteExec ["bis_fnc_Spawn",0]; 		
			
			
			}
			];
	
	
	
			
			
			
		};
	
	
	
	
	
	
	} foreach [West,East];


//BASIC VARIABLES NEED TO BE DEFINED BELOW
W_ActiveUnits = [];
W_ActivePollC = 0;
W_CurrentTargetArray = [1,1,1,1,1];
W_CurrentDecision = 0;
W_Barracks = false;
W_LightFactory = false;
W_HeavyFactory = false;
W_Airfield = false;
W_StaticBay = false;
W_MedicalBay = false;
W_AdvInfantry = false;
W_PlayerAwareness = true;
W_PlayerMissions = [];
W_CheckAIGroup = false;
W_LowResources = false;
W_LaunchOff = true;
publicvariable "W_PlayerMissions";	
E_ActiveUnits = [];
E_ActivePollC = 0;
E_CurrentTargetArray = [1,1,1,1,1];
E_CurrentDecision = 0;
E_Barracks = false;
E_LightFactory = false;
E_HeavyFactory = false;
E_Airfield = false;
E_StaticBay = false;
E_MedicalBay = false;
E_AdvInfantry = false;
E_PlayerAwareness = true;
E_PlayerMissions = [];
E_CheckAIGroup = false;
E_LowResources = false;
E_LaunchOff = true;
publicvariable "E_PlayerMissions";

DIS_OpForVsBluFor = false;
DIS_WestVsResistance = false;
DIS_EastVsResistance = false;
DIS_WESTCAMPRESPAWN = [];
DIS_EASTASSAULTSPAWN = [];
DIS_RESISTANCEASSAULTSPAWN = [];

E_BuildingList = [];
E_BuildingList pushback [Dis_EastCommander,"COMMANDER"];	
W_BuildingList = [];
W_BuildingList pushback [Dis_WestCommander,"COMMANDER"];
	
dis_EListOfBuildings = 
[
	[E_Barracks,[10,20,0,25],"Land_Cargo_House_V1_F"],
	[E_LightFactory,[20,40,0,50],"Land_Research_HQ_F"],
	[E_StaticBay,[15,25,0,20],"Land_Cargo_House_V3_F"],
	[E_HeavyFactory,[40,60,0,100],"Land_BagBunker_Large_F"],
	[E_Airfield,[80,120,0,200],"Land_Research_house_V1_F"],
	[E_MedicalBay,[15,25,0,30],"Land_Medevac_house_V1_F"],
	[E_AdvInfantry,[30,30,0,30],"Land_Bunker_F"]
];	
	
dis_ListOfBuildings = 
[
	[W_Barracks,[10,20,0,25],"Land_Cargo_House_V1_F"],
	[W_LightFactory,[20,40,0,50],"Land_Research_HQ_F"],
	[W_StaticBay,[15,25,0,20],"Land_Cargo_House_V3_F"],
	[W_HeavyFactory,[40,60,0,100],"Land_BagBunker_Large_F"],
	[W_Airfield,[80,120,0,200],"Land_Research_house_V1_F"],
	[W_MedicalBay,[15,25,0,30],"Land_Medevac_house_V1_F"],
	[W_AdvInfantry,[30,30,0,30],"Land_Bunker_F"]
];
	
	
[_NewSave,_LoadGame] spawn
{
	sleep 0.25;
	params ["_NewSave","_LoadGame"];
	if (_NewSave isEqualTo 0) then
	{
		
		
		//private _SV = profileNameSpace setVariable[format["DIS_SG_%1",_CurrentMap],[[_WOwnedGrids,_WOwnedTowns,_WBuildingList,W_RArray,Dis_BluforTickets,_WComPos],[_EOwnedGrids,_EOwnedTowns,_EBuildingList,E_RArray,Dis_OpforTickets,_EComPos]]];	
		private _WList = _LoadGame select 0;
		if !(isNil "_WList") then
		{
			private _EList = _LoadGame select 1;
			waitUntil {!(isNil "W_Markers")};
			waitUntil {!(isNil "E_Markers")};
			waitUntil {!isNil("Dis_ResourceMapDone")}; 
			waitUntil {!isNil("Dis_WestCommander")};
			waitUntil {!isNil("Dis_EastCommander")};
			waitUntil {!(isNil "TownArray")};		
			[West,_WList] call DIS_fnc_SaveLoad;
			[East,_EList] call DIS_fnc_SaveLoad;
			[] spawn {sleep 15;Dis_EastCommander execFSM "AICommander.fsm";};
			[] spawn {sleep 15;Dis_WestCommander execFSM "AICommander.fsm";};
		};
		
	}
	else
	{
	
	
			[] spawn {sleep 15;Dis_EastCommander execFSM "AICommander.fsm";};
			[] spawn {sleep 15;Dis_WestCommander execFSM "AICommander.fsm";};
	
	
	};
	
};