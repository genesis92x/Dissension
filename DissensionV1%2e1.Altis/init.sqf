//Set important variables here
// FIREWORKS INIT
//[[getPos (startpositions call BIS_fnc_selectRandom), 'normal','red'],"callFireworks",true,true] spawn BIS_fnc_MP;
// call compilefinal preprocessFileLineNumbers "oo_poker.sqf";
//[] execVM "PF\init.sqf";

if ("DISDEBUG" call BIS_fnc_getParamValue isEqualTo 0) then
{
	Dis_debug = true;
}
else
{
	Dis_debug = false;
};

//Compile functions
startLoadingScreen ["Loading..."];
//call compile preprocessFileLineNumbers "mapSwitchTextures.sqf";
[] call DIS_fnc_addoncheck;
[] call DIS_fnc_Compositions;
dis_closestobj = compileFinal preprocessfilelinenumbers "Functions\dis_closestobj.sqf";
dis_CheckIpad = compileFinal preprocessFileLineNumbers "Functions\dis_CheckIpad.sqf";
dis_IpadLBChanged = compileFinal preprocessFileLineNumbers "Functions\dis_IpadLBChanged.sqf";
dis_recruitunits = compileFinal preprocessFileLineNumbers "Functions\dis_recruitunits.sqf";
dis_ConvertLand = compileFinal preprocessFileLineNumbers "Functions\dis_ConvertLand.sqf";
dis_attacktarget = compileFinal preprocessFileLineNumbers "Functions\dis_attacktarget.sqf";
dis_createbuilding = compileFinal preprocessFileLineNumbers "Functions\dis_createbuilding.sqf";
dis_DefenceSpawnWATCH = compileFinal preprocessFileLineNumbers "MapMonitor\dis_DefenceSpawnWATCH.sqf";
dis_MarkerMonitor = compileFinal preprocessFileLineNumbers "Functions\dis_MarkerMonitor.sqf";
dis_CreateTasks = compileFinal preprocessFileLineNumbers "Functions\dis_CreateTasks.sqf";
dis_IncomeTimer = compileFinal preprocessFileLineNumbers "Functions\dis_IncomeTimer.sqf";
dis_PlayerRespawn = compileFinal preprocessFileLineNumbers "Functions\dis_PlayerRespawn.sqf";
dis_AIUniforms = compileFinal preprocessFileLineNumbers "Functions\dis_AIUniforms.sqf";
dis_WTransportMon = compileFinal preprocessFileLineNumbers "Functions\dis_WTransportMon.sqf";
dis_FragmentMove = compileFinal preprocessFileLineNumbers "Functions\dis_FragmentMove.sqf";
dis_ActionManagement = compileFinal preprocessFileLineNumbers "Functions\dis_ActionManagement.sqf";
DIS_IMPressed = compileFinal preprocessFileLineNumbers "Functions\DIS_IMPressed.sqf";
dis_WDeathReport = compileFinal preprocessFileLineNumbers "Functions\dis_WDeathReport.sqf";
dis_VehicleDespawn = compileFinal preprocessFileLineNumbers "Functions\dis_VehicleDespawn.sqf";
dis_VehicleManage = compileFinal preprocessFileLineNumbers "Functions\dis_VehicleManage.sqf";
dis_ClosestEnemy = compileFinal preprocessFileLineNumbers "Functions\dis_ClosestEnemy.sqf";
dis_UnitStuck = compileFinal preprocessFileLineNumbers "Functions\dis_UnitStuck.sqf";
dis_MessageFramework = compileFinal preprocessFileLineNumbers "Functions\dis_MessageFramework.sqf";
dis_IpadLBChangedMM = compileFinal preprocessFileLineNumbers "Functions\dis_IpadLBChangedMM.sqf";
dis_DMM = compileFinal preprocessFileLineNumbers "Functions\dis_DMM.sqf";
dis_CommanderPersonality = compileFinal preprocessFileLineNumbers "Functions\dis_CommanderPersonality.sqf";
dis_DefineWeapons = compileFinal preprocessFileLineNumbers "Functions\dis_DefineWeapons.sqf";
dis_LoadGearMenu = compileFinal preprocessFileLineNumbers "GearSystem\dis_LoadGearMenu.sqf";
dis_VehiclePurchase = compileFinal preprocessFileLineNumbers "Functions\dis_VehiclePurchase.sqf";
dis_VehiclePurchase2 = compileFinal preprocessFileLineNumbers "Functions\dis_VehiclePurchase2.sqf";
dis_StaticBuild = compileFinal preprocessFileLineNumbers "Functions\dis_StaticBuild.sqf";
dis_MissionCreation = compileFinal preprocessFileLineNumbers "Functions\dis_MissionCreation.sqf";
dis_BombDefusal = compileFinal preprocessFileLineNumbers "Missions\dis_BombDefusal.sqf";
Dis_HostageRescue = compileFinal preprocessFileLineNumbers "Missions\Dis_HostageRescue.sqf";
Dis_Ambush = compileFinal preprocessFileLineNumbers "Missions\Dis_Ambush.sqf";
Dis_Destroy = compileFinal preprocessFileLineNumbers "Missions\Dis_Destroy.sqf";
Dis_Escort = compileFinal preprocessFileLineNumbers "Missions\Dis_Escort.sqf";
Dis_Defence = compileFinal preprocessFileLineNumbers "Missions\Dis_Defence.sqf";
dis_threatassess = compileFinal preprocessFileLineNumbers "Functions\dis_threatassess.sqf";
Dis_CompiledTerritory = compileFinal preprocessFileLineNumbers "Functions\Dis_CompiledTerritory.sqf";
dis_ADistC = compileFinal preprocessFileLineNumbers "Functions\dis_ADistC.sqf";
dis_SpecialMission = compileFinal preprocessFileLineNumbers "Functions\dis_SpecialMission.sqf";
dis_randompos = compileFinal preprocessFileLineNumbers "Functions\dis_randompos.sqf";
dis_VehicleChanged = compileFinal preprocessFileLineNumbers "Functions\dis_VehicleChanged.sqf";

//Threat Responses
Dis_RGuer = compileFinal preprocessFileLineNumbers "Commander\threatresp\dis_Guerrilla.sqf";
Dis_RSE = compileFinal preprocessFileLineNumbers "Commander\threatresp\dis_SupportEnthusiast.sqf";

PlaySoundEverywhere = compileFinal "playsound (_this select 0)";
PlaySoundEverywhereDist = compileFinal "if (player distance (_this select 0) < 400) then {playsound (_this select 1)}";
MessageFramework = compileFinal "[(_this select 0),(_this select 1)] spawn Dis_MessageFramework;";
PlaySoundEverywhereSay3D = compileFinal "(_this select 0) say3D (_this select 1)";
DIS_playMoveEverywhere = compileFinal "(_this select 0) playMoveNow (_this select 1);";
DIS_switchMoveEverywhere = compileFinal "(_this select 0) switchMove (_this select 1);";

dis_MaxUnit = ("AISoftCap" call BIS_fnc_getParamValue);
Dis_WorldCenter = getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition");
endLoadingScreen;

//Load important server information here.
if (isServer) then
{
	//call compile preprocessFileLineNumbers "scripts\ServerCompleteInit.sqf";
	startLoadingScreen ["Doing some heavy lifting"];
	call compile preprocessfilelinenumbers "MapGen\MarkTowns.sqf";
	call compile preprocessfilelinenumbers "MapGen\ResourceGrid.sqf";
	endLoadingScreen;
	[] call DIS_fnc_SpawnCommanders;


	Dis_BluforTickets = 100;
	Dis_OpforTickets = 100;
	dis_WNewsArray = [];
	dis_ENewsArray = [];
	dis_NewsArray = [];
	W_CurMission = [];	
	E_SupplyP = [];
	W_SupplyP = [];	
	CASEBOMB = [];
	W_Markers = [];
	E_Markers = [];
	DIS_MissionID = 0;
	DIS_WestTSpwn = 0;
	DIS_EastTSpwn = 0;
	DIS_ResistTSpwn = 0;
	publicVariable "dis_NewsArray";
	publicVariable "Dis_BluforTickets";
	publicVariable "Dis_OpforTickets";

	[] spawn dis_DefenceSpawnWATCH;
	[] spawn dis_IncomeTimer;
	[] spawn dis_WTransportMon;

	//Lets get the AI groups setup
	[] call DIS_fnc_AIGroup;
	//[] spawn DIS_fnc_PlayerSquad;
	DIS_SessionID = (floor (random 1000));
	publicVariable "DIS_SessionID";
	DIS_WENGAGED = [];
	DIS_EENGAGED = [];
	publicVariable "DIS_WENGAGED";	
	publicVariable "DIS_EENGAGED";	
	DIS_TLimit = "ACTIVETOWNS" call BIS_fnc_getParamValue;	
	
	//[_RSide,_Marker,_RandomStatic,"StaticBuild"] call DIS_fnc_mrkersave;
	//if (isServer) then {[_Side,_Marker,_Group,"Recruit"] call DIS_fnc_mrkersave;};
	[] spawn
	{
		waitUntil
		{
			publicVariable "W_Markers";
			sleep 300;
			{
				private _Obj = _x select 2;
				private _Type = _x select 3;
				if !(isNil "_Obj") then
				{
					if (_Obj isEqualType objNull) then {if !(alive _Obj) then {W_Markers deleteAt _foreachIndex;};};
					if (_Obj isEqualType grpNull) then {if ({alive _x} count (units _Obj) < 1) then {W_Markers deleteAt _foreachIndex;};};
					//Remove supply points that are no longer full.
					if (_Type isEqualTo "Supply Point") then 
					{
						if !(_Obj getVariable ["DIS_Transporting", false]) then {W_Markers deleteAt _foreachIndex;};
					};
				}
				else
				{
					W_Markers deleteAt _foreachIndex;
				};
			} foreach W_Markers;
			false
		};
	};
	[] spawn
	{
		waitUntil
		{
			publicVariable "E_Markers";
			sleep 300;
			{
				private _Obj = _x select 2;
				private _Type = _x select 3;			
				if !(isNil "_Obj") then
				{
					if (_Obj isEqualType objNull) then {if !(alive _Obj) then {E_Markers deleteAt _foreachIndex;};};
					if (_Obj isEqualType grpNull) then {if ({alive _x} count (units _Obj) < 1) then {E_Markers deleteAt _foreachIndex;};};
					//Remove supply points that are no longer full.
					if (_Type isEqualTo "Supply Point") then 
					{
						if !(_Obj getVariable ["DIS_Transporting", false]) then {E_Markers deleteAt _foreachIndex;};
					};				
				}
				else
				{
					E_Markers deleteAt _foreachIndex;
				};
			} foreach E_Markers;
			false
		};
		
	};	
	
	[] execVM "Functions\dis_RespawnMarkers.sqf";	
	["Initialize"] call BIS_fnc_dynamicGroups;
	[] execVM "Vcomclean.sqf";
	[] spawn DIS_fnc_SaveSVRLoop;
	[] spawn
	{
		waitUntil
		{
			sleep 10;		
			[] call DIS_fnc_AIStruChk;		
			false
		};
	};	
	[] spawn DIS_fnc_PAUSE;	
	//[] spawn DIS_fnc_CombineSounds;
	//[] spawn DIS_fnc_StuLoop;
	

	[] spawn
	{
		waitUntil
		{
			sleep 300;
			[] call DIS_fnc_OrdnanceCheck;
			false
		};
	};
	
	private _AIComms = "AIComms" call BIS_fnc_getParamValue;
	if (_AIComms isEqualTo 1) then
	{
		[] call DIS_fnc_CommsInit;
	};
	[] spawn dis_UnitStuck;
	
	
	//Fast time
	setTimeMultiplier ("TimeSpeed" call BIS_fnc_getParamValue);
	
	//Delete player unit when dissconnecting. This prevents random "player" AI from being in player groups.
	addMissionEventHandler ["HandleDisconnect", 
	{
		params ["_unit", "_id", "_uid", "_name"];
		deleteVehicle _unit;
		false;
	}];
	
	
	//Eventhandler for when a player connects.
	addMissionEventHandler ["PlayerConnected",
	{
		params ["_id", "_uid", "_name", "_jip", "_owner"];
		["_id", "_uid", "_name", "_jip", "_owner"] spawn
		{
			params ["_id", "_uid", "_name", "_jip", "_owner"];
			if (_name isEqualTo "Genesis") then
			{
				sleep 30;
				_name spawn
				{
					["<img size='1' align='left' color='#ffffff' image='Pictures\types\land_ca.paa' /> MISSION CREATOR HAS JOINED!", format 
					["<t size='1'><br/>%1 has joined the game! He is probably here to mess everything up. Make sure to blame him for all your problems!
					</t>",_this]] remoteExec ["Haz_fnc_createNotification",0];				
				};
			};
		};
	}];	
	

	//Add mission eventhandler for removing ruined buildings overtime.
	addMissionEventHandler ["BuildingChanged", 
	{
		params ["_previousObject", "_newObject", "_isRuin"];
		if (local _newObject) then
		{
			if (_isRuin) then
			{
				deleteVehicle _newObject;
			};
		};
	}];
	
	[] spawn DIS_fnc_cratemonitor;	
};


//DEDICATED SERVER EXITS HERE
if (isDedicated) exitWith 
{
	enableEnvironment [false, false];
	[] execVM "Vcom\VcomInit.sqf";
};
//Headless clients launch Vcom!
if !(hasInterface) then
{
	[] execVM "Vcom\VcomInit.sqf";
};



//Variables for all clients
DIS_Contmrk = true;

sleep 0.01;
 
if (hasInterface) then
{
	[] call DIS_fnc_RspnCam;
	
	playmusic "LeadTrack01a_F_EXP";
	//After the game starts
	cutText ["","BLACK OUT",0.001];
	//["DissensionClip.ogv",[(0.37 * safezoneW + safezoneX),(0.37 * safezoneH + safezoneY),(0.25 * safezoneW),(0.25 * safezoneH)],[1,1,1,1],"BIS_fnc_playVideo_skipVideo",[0,0,0,0]] call BIS_fnc_playVideo;
	["DissensionClip.ogv",[(0.37 * safezoneW + safezoneX),(0.35 * safezoneH + safezoneY),(0.25 * safezoneW),(0.25 * safezoneH)],[1,1,1,1],"BIS_fnc_playVideo_skipVideo",[0,0,0,0]] call BIS_fnc_playVideo;
	cutText ["","BLACK IN",5];
	[
		[
			[format ["%1: Welcome to Dissension",(name player)],"align = 'center' shadow = '1' size = '1' font='PuristaBold'"],
			["","<br/>"],
			["Select a spawn location.","align = 'center' shadow = '1' size = '0.5'"]
		]
	] spawn BIS_fnc_typeText2;
};

waitUntil {!(isNil "W_Markers")};
waitUntil {!(isNil "E_Markers")};
waitUntil {(count BluLandControlled > 0)};
waitUntil {(count OpLandControlled > 0)};


[] call DIS_fnc_mrkersetup;	
	
waitUntil {!isNil("Dis_ResourceMapDone")};
if (hasInterface) then
{
	if (playerSide isEqualTo WEST) then
	{
	
		waitUntil {!isNil("Dis_WestCommander")};
		waitUntil {!((getpos Dis_WestCommander) isEqualTo [0,0,0])};	
		waitUntil {!(isNil "TownArray")};
	
		//Marker for command vehicle
		[] spawn 
		{
			private _Marker = createMarkerlocal ["COMMAND VEHICLE",[0,0,0]];
			_Marker setMarkerTypeLocal 'b_installation';
			_Marker setMarkerTextLocal "COMMAND VEHICLE";
			_Marker setMarkerShapeLocal 'ICON';
			_Marker setMarkerColorLocal "ColorBlue";
			_Marker setMarkerAlphaLocal 1;
			_Marker setMarkerSizeLocal [1,1];
			waitUntil
			{
				_Marker setMarkerPosLocal (getposASL Dis_WestCommander);
				sleep 30;
				!(alive Dis_WestCommander)
			};
			sleep 5;
			deleteMarker _Marker;		
		};
		
	}
	else
	{
		waitUntil {!isNil("Dis_EastCommander")};
		waitUntil {!((getpos Dis_EastCommander) isEqualTo [0,0,0])};
		waitUntil {!isNil("TownArray")};
	
		//Marker for command vehicle
		[] spawn 
		{
			private _Marker = createMarkerlocal ["COMMAND VEHICLE",[0,0,0]];
			_Marker setMarkerTypeLocal 'o_installation';
			_Marker setMarkerTextLocal "COMMAND VEHICLE";
			_Marker setMarkerShapeLocal 'ICON';
			_Marker setMarkerColorLocal "ColorRed";
			_Marker setMarkerAlphaLocal 1;
			_Marker setMarkerSizeLocal [1,1];				
			waitUntil
			{
				_Marker setMarkerPosLocal (getposASL Dis_EastCommander);
				sleep 30;
				!(alive Dis_EastCommander)
			};
			sleep 5;
			deleteMarker _Marker;		
		};	
	
	};
	
	waitUntil {alive player};
	_intro = [player, "Situation: Open War - Dissension between parties - Objective: Liberation of Island",80,nil,270,1] spawn BIS_fnc_establishingShot;
	WaitUntil{scriptDone _intro};
	[
		[
			[format ["%1:Equip your loadout!",(name player)],"align = 'center' shadow = '1' size = '1' font='PuristaBold'"],
			["","<br/>"],
			["Press ESC to access the Commander Interface","align = 'center' shadow = '1' size = '0.5'"]
		]
	] spawn BIS_fnc_typeText2;	
	
	startLoadingScreen ["Doing some heavy lifting"];
	[] call DIS_fnc_RankInit;
	[] call dis_LoadGearMenu;
	endLoadingScreen;		
	
};



//Code to run after being spawned in
if (hasInterface) then
{
	player addEventHandler ["respawn", {_this spawn dis_PlayerRespawn}];
	[player,nil] spawn dis_PlayerRespawn;

	_tabletFnc = [] spawn compile PreprocessFileLineNumbers "tabletFunctions.sqf";
	waitUntil {scriptDone _tabletFnc};
	
	[] execVM "Functions\dis_DisplayUI.sqf";
	
	//if !(isDedicated) then {sleep 5;[] spawn DIS_fnc_Init;};
};





//If this is being played in SP, abort the mission. NO SP HERE.
if !(isMultiplayer) then
{
	["DISSENSSION ONLY SUPPORT MP",'#FFFFFF'] remoteExec ["MessageFramework",0];
	systemChat "PLEASE HOST THE GAME MULTIPLAYER ONLY. IF YOU WANT TO PLAY SP, PASSWORD PROTECT YOUR LISTEN SERVER.";
	systemChat "PLEASE HOST THE GAME MULTIPLAYER ONLY. IF YOU WANT TO PLAY SP, PASSWORD PROTECT YOUR LISTEN SERVER.";
	sleep 15;
	["epicFail",false,2] call BIS_fnc_endMission;
};

if (hasInterface) then
{
//ADDON INJECTOR CHECK

if (isClass(configFile >> "CfgPatches" >> "NW_RTSE")) then 
{
	private _adminState = call BIS_fnc_admin;
	if (!(_adminState isEqualTo 2) && {!(isServer)}) then
	{
		["epicFail",false,2] call BIS_fnc_endMission;
	};
};



//Floating text lazy test here
Dis_ImageDirectory = "OPF";
if ((playerSide) isEqualTo WEST) then {Dis_ImageDirectory = "BLU"};
MISSION_ROOT = str missionConfigFile select [0, count str missionConfigFile - 15];
publicVariable "MISSION_ROOT";


Texture_For_Icon3d = MISSION_ROOT + "Functions\RankSystem\UnitIcon_ca.paa";	
["DissensionStuff", "onEachFrame", 
{
{
	if !(hasInterface) exitwith {};		
	if (_x distance2D player < 15 && {_x isEqualTo (vehicle _x)} && {playerSide isEqualTo (side _x)}) then
	{
		private _Currentlevel = _x getVariable ["DIS_Level",0];
		_pos2 = visiblePositionASL _x;
		_pos2 set [2, ((_x modelToWorld [0,0,0]) select 2) + 2.5];
		DIS_PlayerPos = _pos2;
		DIS_PlayerLevel = format ["%2: %1",_Currentlevel,(name _x)];
		drawIcon3D
		[
			Texture_For_Icon3d,
			[1,1,1,0.65],
			DIS_PlayerPos,
			2,
			2,
			0,
			DIS_PlayerLevel,
			2,
			0.04,
			"RobotoCondensed",
			"center",
			false
		];
	};
} foreach playableUnits; 
}] call BIS_fnc_addStackedEventHandler;


if (isNil "MEP_KD") then
{
		MEP_KD = (findDisplay 46) displayAddEventHandler ["KeyDown",
			{
				switch (_this select 1) do
				{
					case 197 : 
					{
						private _fitted = EarplugsFitted;
						switch (_fitted) do
						{
							case true: { EarplugsFitted = false; 2 fadeSound 1; titleText ["Earplugs removed", "PLAIN", 0.2] };
							case false: { EarplugsFitted = true; 2 fadeSound 0.2; titleText ["Earplugs fitted", "PLAIN", 0.2];  };
							default { };
						};				
					};
					case 47 :
					{
						if (speed player > 16) then
						{
							[] spawn {sleep 0.001;[player,"AovrPercMrunSrasWrflDf"] remoteExec ["DIS_switchMoveEverywhere",0];};
						};
					};
					case default
					{
						
					};				
				};
			}];
	DIS_MAction = "[] spawn dis_fnc_TabletOpen";	
	DIS_ESC = (findDisplay 46) displayAddEventHandler ["KeyDown",
		{
			if (_this select 1 isEqualTo 1) then
			{
				[] spawn
				{
					sleep 0.05;
					disableSerialization;
					private _D1 = findDisplay 49;
					if (!isNull _D1) then 
					{
						[] call DIS_fnc_SaveData;
						/*
						if (!(isStreamFriendlyUIEnabled)) then 
						{
							if (shownChat) then {
								showChat FALSE;
							};
						};
						*/
						{
							_Button = _D1 displayCtrl _x;
							if (!isNull _Button) then 
							{
								_Button ctrlSetText 'Command Interface';
								_Button buttonSetAction DIS_MAction;
								_Button ctrlSetTooltip 'Open the Commander Interface. Giving you access to all aspects of the battlefield.';
								_Button ctrlCommit 0;
							};
						} forEach [16700,2];
						(_D1 displayCtrl 103) ctrlEnable FALSE;
						(_D1 displayCtrl 103) ctrlSetText '';
						(_D1 displayCtrl 103) ctrlEnable FALSE;
						(_D1 displayCtrl 523) ctrlSetText (format ['%1',(name player)]);
						(_D1 displayCtrl 109) ctrlSetText (format ['%1',(Side player)]);
						(_D1 displayCtrl 104) ctrlEnable TRUE;
						(_D1 displayCtrl 104) ctrlSetText 'Leave Your Team';
						(_D1 displayCtrl 104) ctrlSetTooltip 'Abandon your post...';
					};
				};			
			};
		}];
		
		/*
		DIS_TENGAGED = (findDisplay 46) displayAddEventHandler ["KeyDown",
			{
				if (_this select 1 isEqualTo 36) then
				{
					if (playerSide isEqualTo West) then {West call DIS_fnc_AtkMrk;} else {East call DIS_fnc_AtkMrk;};
				};
			}];
			*/

	//sleep 1;

	//_hint1 = "<t color='#ff9d00' size='1.2' shadow='1' shadowColor='#000000' align='center'>** Earplugs Recieved **</t>";   //Item taken hint.
	//_hint2 = "          Use [Pause/Break] key to Insert and Remove";

	//hint parseText (hint1 + hint2);

	EarplugsFitted = false;
};
};

sleep 0.25;
[] call dis_DefineWeapons;
sleep 2;



if (hasInterface) then
{
	private _Revive = "DissensionRevive" call BIS_fnc_getParamValue;
	if (_Revive isEqualTo 1) then
	{
		[] execVM "Functions\dis_revivefnc.sqf";
	};
	[] execVM "QS_repackMags.sqf";
	[] execVM "Functions\Dis_PBmbPlant.sqf";
	//[] execVM "Functions\DIS_ScrollingText.sqf";
	[] execVM "QS_icons.sqf";
	["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
	if (("DynMusic" call BIS_fnc_getParamValue) isEqualTo 0) then
	{
		[] spawn DIS_fnc_DynamicMusic;
	};

	DIS_PACKPROTECT = 
	{
		params ["_Unit","_target"];
		private _BK = objectParent _target;
		if (!(_BK isEqualTo player) && {_BK isKindOf "Man"}) then
		{
			if (!(_BK in (units (group player))) && {alive _BK} && {(side _BK) isEqualTo (side player)}) exitWith
			{
				waitUntil {
					closeDialog 0;
					!(isNull (findDisplay 602))
				};
				closeDialog 602;
				systemChat "YOU ARE NOT IN THIS UNITS GROUP";
			};
		};
		true;
	};

	player addEventHandler ["InventoryOpened", {_this spawn DIS_PACKPROTECT;}];
	
	private _POVCam = "POVCam" call BIS_fnc_getParamValue;
	if (_POVCam isEqualTo 1) then
	{
		["DissensionPOV", "onEachFrame", 
		{
			if (isNull (objectParent player) && {cameraView isEqualTo "EXTERNAL"}) then  
			{
				player switchCamera "INTERNAL"; 
			};
		}] call BIS_fnc_addStackedEventHandler;
	};
	if (_POVCam isEqualTo 2) then
	{
		["DissensionPOV", "onEachFrame", 
		{
			if (cameraView isEqualTo "EXTERNAL") then  
			{
				player switchCamera "INTERNAL"; 
			};
		}] call BIS_fnc_addStackedEventHandler;
	};
	
	[] spawn DIS_fnc_SquadRadar;
	[] spawn dis_ActionManagement;
	[] execVM "FS\FR_Init.sqf";
	[] call DIS_fnc_DisarmOrd;
	private _Revive = "DissensionRevive" call BIS_fnc_getParamValue;
	//[["Dissension","DissensionIntro"],15,"",35,"",true,true,false,true] call BIS_fnc_advHint;	
	[] SPAWN 
	{
		sleep 20;
		["<img size='1' align='left' color='#ffffff' image='Pictures\Tasks_ca.paa' /> DISSENSION: PRESS H TO EXPAND", format ["<t size='0.75'>Dissension is a Team vs Team Capture the Island <t color='#00D506'>(CTI)</t> where the goal is to eliminate the opposing sides commander.<br/>To do this, you must first build your war machine by capturing <t color='#00D506'>grids</t> and <t color='#00D506'>towns</t>; these funnel resources (<t color='#00D506'>oil</t>/<t color='#00D506'>power</t>/<t color='#00D506'>cash</t>/<t color='#00D506'>materials</t>/<t color='#00D506'>tickets</t>) directly into your commander's wallet, and indirectly into your wallet.<br/>You only have to worry about cold hard <t color='#00D506'>cash</t>. <t color='#00D506'>Cash</t> is how you will be able to purchase your own <t color='#00D506'>gear</t>, <t color='#00D506'>vehicles</t>, <t color='#00D506'>units</t>, call in <t color='#00D506'>abilities</t>, and construct <t color='#00D506'>bases</t>.</t>"]] spawn Haz_fnc_createNotification;
	};
	
	private _GlobalTerrainGrid = "GlobalTerrainGrid" call BIS_fnc_getParamValue;
	setTerrainGrid _GlobalTerrainGrid;
	
	_Null = [] execFSM "DVD.fsm";
	[] execVM "Vcom\VcomInit.sqf";
};

//Function for sounds from units
private _AIComms = "AIComms" call BIS_fnc_getParamValue;
if (_AIComms isEqualTo 1) then
{
	[] call DIS_fnc_CommsInit;
};

[] spawn DIS_fnc_PlayerTownEnterCheck;
[] spawn DIS_fnc_StealthInit;


"layer_notifications" cutRsc ["rsc_notifications", "PLAIN"];

addMissionEventHandler ["Loaded",
{
	[] spawn
	{
		sleep 2;
		"layer_notifications" cutRsc ["rsc_notifications", "PLAIN"];
	};
}];


enableEnvironment [false, false];





/*
["New notification", "This is a notification!", [0, 0, 0, 1], [1, 1, 0, 1]] spawn Haz_fnc_createNotification;
["<img size='1' color='#ffffff' image='\A3\Ui_f\data\GUI\Cfg\Ranks\private_gs.paa'/> New notification", "This is a notification!"] spawn Haz_fnc_createNotification;
["<img size='1' align='right' color='#ffffff' image='\A3\Ui_f\data\GUI\Cfg\Ranks\private_gs.paa'/> New notification", "This is a notification!"] spawn Haz_fnc_createNotification;
["<img size='1' align='right' color='#ffffff' image='\A3\Ui_f\data\GUI\Cfg\Ranks\private_gs.paa'/> Rank Promotion", "Good work!", [1, 1, 1, 1], [0.12, 0.63, 0.94, 1]] spawn Haz_fnc_createNotification;
*/


