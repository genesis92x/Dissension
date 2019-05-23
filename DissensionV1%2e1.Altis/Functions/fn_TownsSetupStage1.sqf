/*
	Author: Genesis

	Description:
		Sets up the inital settings for taking a town. This is all the server side things that need to be taken care of before sending it off to the HC

	Parameter(s):
		0: Town Info
		1: Town Index Number 
		2: Engaged 
		3: Defending Side 
		4: Attacking Side

	Returns:
		0: 
	Example1: [_TownInfo,_IndexTT,_Engaged,_DefendSide,_AttackSide] call DIS_fnc_TownsSetupStage1;
*/
params ["_TownArray","_CforEachIndex","_Engaged","_SSide","_AtkSide","_TargetLand","_AttackPos","_AssaultFrom","_AttackSpawnPos","_DefenceSpawnPos","_ClosestDefenceTown"];

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
if (Dis_debug) then {diag_log format ["DISDEBUG: NEARESTPLAYER DISTANCE: %1 - %2",(_ClosestPlayer distance2D _Pole),_Pole];};
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


/*
	//Now we need to handle the loop for monitoring the waves of units.
	//Waves of units should spawn every 10 seconds if there is room.
	private _grp = createGroup _SSide;
	_grp setVariable ["DIS_IMPORTANT",true,true];
	private _grpGarrison = createGroup _SSide;
	_grpGarrison setVariable ["DIS_IMPORTANT",true,true];
*/

//private _MineAdd = "VcomAIMineSupport" call BIS_fnc_getParamValue;


_Pole setVariable ["DIS_ASSAULTENDED",false,true];
private _b = "CargoNet_01_box_F" createVehicle [-200,-200,-0];
_b enableSimulationGlobal false;
_b allowdamage false;

//Marker for displaying what town is engaged for attacker.
[
	[_TownArray,_AssaultFrom,_ClosestDefenceTown],
	{
		sleep 10;
		params ["_TownInfo","_AssaultFrom","_ClosestDefenceTown"];
		if (hasInterface) then
		{
			private _pole = _TownInfo select 2;
			private _orgmrk = _TownInfo select 0;
			private _Name = _TownInfo select 1;
			_markername = floor (random 1000);
			_marker1 = createMarkerLocal [format ["%1-%2",_markername,_pole],(getpos _pole)];
			_marker1 setMarkerShapeLocal "ELLIPSE";
			If (playerSide isEqualTo west) then {_marker1 setMarkerColorLocal "ColorBlue"} else {_marker1 setMarkerColorLocal "ColorRed"};
			_marker1 setMarkerBrushLocal "FDiagonal";
			_marker1 setMarkerSizeLocal [((getMarkerSize _orgmrk) select 0),((getMarkerSize _orgmrk) select 1)];
			
			
			//ASSAULT OR DEFEND MARKER.
			private _marker1z = createMarker [format ["%1-%2",_pole,(random 100)],(getpos _pole)];
			_marker1z setMarkerShapeLocal "ICON";
			_marker1z setMarkerTypeLocal "mil_dot_noShadow";
			_marker1z setmarkercolorLocal "ColorWhite";
			_marker1z setmarkersizeLocal [1,1];			
			_marker1z setMarkerAlphaLocal 1;
			_marker1z setMarkerTextLocal "ASSAULT";
			
			
			//Marker on Attacking Town
			private _marker2z = createMarker [format ["%1-%2",_AssaultFrom,(random 100)],(getpos _AssaultFrom)];
			_marker2z setMarkerShapeLocal "ICON";
			_marker2z setMarkerTypeLocal "mil_dot_noShadow";
			_marker2z setmarkercolorLocal "ColorWhite";
			_marker2z setmarkersizeLocal [1,1];			
			_marker2z setMarkerAlphaLocal 1;
			_marker2z setMarkerTextLocal "FRIENDLY SUPPORT & VEHICLE FOB";			
			
			
			//Marker on Defence Town
			private _marker3z = createMarker [format ["%1-%2",_ClosestDefenceTown,(random 100)],(getpos _ClosestDefenceTown)];
			_marker3z setMarkerShapeLocal "ICON";
			_marker3z setMarkerTypeLocal "mil_dot_noShadow";
			_marker3z setmarkercolorLocal "ColorWhite";
			_marker3z setmarkersizeLocal [1,1];			
			_marker3z setMarkerAlphaLocal 1;
			_marker3z setMarkerTextLocal "ENEMY SUPPORT & VEHICLE FOB";				
			
			["<img size='1' align='left' color='#ffffff' image='Pictures\tridentEnemy_ca.paa' /> NEW OBJECTIVE ASSIGNED", format 
			["<t size='0.75'>CAPTURE TOWN: %1<br/> Town has been marked on map for capture.<br/>It is %2M away from your current position.<br/>Capturing it will reward you 500$.
			</t>",_Name,(round (player distance2D _pole))]] spawn Haz_fnc_createNotification;
	
			waituntil 
			{
				sleep 10;
				(_pole getVariable ["DIS_ASSAULTENDED",false])
			};
			deleteMarkerLocal _marker1;		
			deleteMarkerLocal _marker1z;		
			deleteMarkerLocal _marker2z;		
			deleteMarkerLocal _marker3z;		
		};
	}
] remoteExec ["bis_fnc_Spawn",_AtkSide,_b];
//Marker for displaying what town is engaged for defender.
[
	[_TownArray,_AssaultFrom,_ClosestDefenceTown],
	{
		sleep 10;
		params ["_TownInfo","_AssaultFrom","_ClosestDefenceTown"];
		if (hasInterface) then
		{
			private _pole = _TownInfo select 2;
			private _orgmrk = _TownInfo select 0;
			private _Name = _TownInfo select 1;
			_markername = floor (random 1000);
			_marker1 = createMarkerLocal [format ["%1-%2",_markername,_pole],(getpos _pole)];
			_marker1 setMarkerShapeLocal "ELLIPSE";
			If (playerSide isEqualTo west) then {_marker1 setMarkerColorLocal "ColorBlue"} else {_marker1 setMarkerColorLocal "ColorRed"};
			_marker1 setMarkerBrushLocal "FDiagonal";
			_marker1 setMarkerSizeLocal [((getMarkerSize _orgmrk) select 0),((getMarkerSize _orgmrk) select 1)];
			
			
			//ASSAULT OR DEFEND MARKER.
			private _marker1z = createMarker [format ["%1-%2",_pole,(random 100)],(getpos _pole)];
			_marker1z setMarkerShapeLocal "ICON";
			_marker1z setMarkerTypeLocal "mil_dot_noShadow";
			_marker1z setmarkercolorLocal "ColorWhite";
			_marker1z setmarkersizeLocal [1,1];			
			_marker1z setMarkerAlphaLocal 1;
			_marker1z setMarkerTextLocal "DEFEND";
			
			
			//Marker on Attacking Town
			private _marker2z = createMarker [format ["%1-%2",_AssaultFrom,(random 100)],(getpos _AssaultFrom)];
			_marker2z setMarkerShapeLocal "ICON";
			_marker2z setMarkerTypeLocal "mil_dot_noShadow";
			_marker2z setmarkercolorLocal "ColorWhite";
			_marker2z setmarkersizeLocal [1,1];			
			_marker2z setMarkerAlphaLocal 1;
			_marker2z setMarkerTextLocal "ENEMY SUPPORT & VEHICLE FOB";
			
			
			//Marker on Defence Town
			private _marker3z = createMarker [format ["%1-%2",_ClosestDefenceTown,(random 100)],(getpos _ClosestDefenceTown)];
			_marker3z setMarkerShapeLocal "ICON";
			_marker3z setMarkerTypeLocal "mil_dot_noShadow";
			_marker3z setmarkercolorLocal "ColorWhite";
			_marker3z setmarkersizeLocal [1,1];			
			_marker3z setMarkerAlphaLocal 1;
			_marker3z setMarkerTextLocal "FRIENDLY SUPPORT & VEHICLE FOB";				
			
			["<img size='1' align='left' color='#ffffff' image='Pictures\tridentEnemy_ca.paa' /> NEW OBJECTIVE ASSIGNED", format 
			["<t size='0.75'>CAPTURE TOWN: %1<br/> Town has been marked on map for capture.<br/>It is %2M away from your current position.<br/>Capturing it will reward you 500$.
			</t>",_Name,(round (player distance2D _pole))]] spawn Haz_fnc_createNotification;
	
			waituntil 
			{
				sleep 10;
				(_pole getVariable ["DIS_ASSAULTENDED",false])
			};
			deleteMarkerLocal _marker1;		
			deleteMarkerLocal _marker1z;		
			deleteMarkerLocal _marker2z;		
			deleteMarkerLocal _marker3z;		
		};
	}
] remoteExec ["bis_fnc_Spawn",_SSide,_b];



		if (Dis_Debug) then
		{
			diag_log format ["DISDEBUG: Side: %2 _infantrylist: %1",_infantrylist,_SSide];
		};

[
	[_SSide,_SpwnedUnits,_SpawnAmount,_Pole,_StrongHoldBuildings,_infantrylist,_AirList,_AtkSide,_NameLocation,_MaxAtOnce,_PolePos,_HC,_StaticList,_FactoryList,_ActiveSide,_GroupNames,_ControlledArray,_CloseStill,_Engaged,_OriginalAmount,_Marker,_TargetLand,_AttackPos,_AssaultFrom,_AttackSpawnPos,_DefenceSpawnPos,_ClosestDefenceTown,_HeavyFactoryList],
	{
		_this execFSM "TownEngagementSystemHC.fsm";
		_this execFSM "TownEngagementSystemHCATTACKER.fsm";
		//[_SSide,_SpwnedUnits,_SpawnAmount,_Pole,_StrongHoldBuildings,_infantrylist,_AirList,_AtkSide,_NameLocation,_MaxAtOnce,_PolePos,_HC,_StaticList,_FactoryList,_ActiveSide,_GroupNames,_ControlledArray,_CloseStill,_Engaged,_OriginalAmount,_Marker] spawn DIS_fnc_TownDefendStage2;	
	}
] remoteExec ["bis_fnc_call",_RMEXEC];


waitUntil
{
	private _VarCheck = _Pole getVariable ["DIS_ASSAULTENDED",false];
	sleep 5;
	_VarCheck
};	

_b setDamage 1;
deleteVehicle _b;

switch (true) do
{
    	case (_SSide isEqualTo West && _AtkSide isEqualTo East): 
		{
			[] spawn {sleep 90;DIS_OpForVsBluFor = false;DIS_OpforWantsToFight = false;sleep 30;DIS_BluforWantsToFight = false;};			
		};
    	case (_SSide isEqualTo East && _AtkSide isEqualTo West): 
		{
			[] spawn {sleep 90;DIS_OpForVsBluFor = false;DIS_BluforWantsToFight = false;sleep 30;DIS_OpforWantsToFight = false;};
		};
    	case (_SSide isEqualTo West && _AtkSide isEqualTo resistance): 
		{
			[] spawn {sleep 90;DIS_WestVsResistance = false;};
		};
    	case (_SSide isEqualTo resistance && _AtkSide isEqualTo West): 
		{
			[] spawn {sleep 90;DIS_WestVsResistance = false;};
		};
    	case (_SSide isEqualTo East && _AtkSide isEqualTo resistance): 
		{
			[] spawn {sleep 90;DIS_EastVsResistance = false;};
		};
    	case (_SSide isEqualTo resistance && _AtkSide isEqualTo east): 
		{
			[] spawn {sleep 90;DIS_EastVsResistance = false;};
		};
};




//This is for AFTER The battle.

//First we need to determine who won.


private _DefenderArray = _pole getVariable "DIS_Capture";
private _DefendersCount = _DefenderArray select 1;


//Defenders lost
if (_DefendersCount < 1) exitWith 
{

	//Counter Attack to buy time.
	private _ClstPlay = [allplayers,_PolePos,true,"323"] call dis_closestobj;
	if (_ClstPlay distance2D _PolePos < 1200) then
	{
		if (_Pole getVariable ["DIS_TowerAlive",false]) then
		{
			[_SSide,_AtkSide,_Pole] spawn DIS_fnc_CounterAttack;
		};
	};
	
	[
	[_Marker,_AtkSide,_NameLocation,_Pole,_SSide],
	{
			params ["_Marker","_Side","_NameLocation","_Pole","_SSide"];
			if !(hasInterface) exitWith {};
			if (playerSide isEqualTo _Side) then
			{
				if (_Side isEqualTo west) then {_Marker setMarkerColorLocal "ColorBlue";} else {_Marker setMarkerColorLocal "ColorRed";};
				_Marker setMarkerAlphaLocal 1;
				["DISTASK",["TOWN CAPTURED",(MISSION_ROOT + "Pictures\types\danger_ca.paa"),(format ["CAPTURED: %1",(toUpper _NameLocation)]),""]] call BIS_fnc_showNotification;
					[
					[
						[format ["%1: Occupied by our forces!",(toUpper _NameLocation)],"align = 'center' shadow = '1' size = '0.7' font='PuristaBold'"]
					]
				] spawn BIS_fnc_typeText2;					
			}
			else
			{
				if (playerSide isEqualTo _SSide) then
				{
					if (_SSide isEqualTo west) then 
					{
						if (getMarkerColor _Marker isEqualTo "ColorBlue") then
						{
							_Marker setMarkerColorLocal "ColorRed";
							_Marker setMarkerAlphaLocal 1;												
						};
					} else 
					{
						if (getMarkerColor _Marker isEqualTo "ColorRed") then
						{
							_Marker setMarkerColorLocal "ColorBlue";
							_Marker setMarkerAlphaLocal 1;												
						};
					};

					["DISTASK",["TOWN LOST",(MISSION_ROOT + "Pictures\types\danger_ca.paa"),(format ["LOST: %1",(toUpper _NameLocation)]),""]] call BIS_fnc_showNotification;
						[
							[
								[format ["%1: We must regroup!",(toUpper _NameLocation)],"align = 'center' shadow = '1' size = '0.7' font='PuristaBold'"]
							]
					] spawn BIS_fnc_typeText2;						
				};
			};
	}
	
	] remoteExec ["bis_fnc_Spawn",0];											
		
		
	switch (_AtkSide) do
	{
			case West: 
			{
				if !(_Pole in BluControlledArray) then {BluControlledArray pushback _Pole;publicVariable "BluControlledArray";};
				if (_Pole in IndControlledArray) then {IndControlledArray = IndControlledArray - [_Pole];publicVariable "IndControlledArray";};
				if (_Pole in OpControlledArray) then {OpControlledArray = OpControlledArray - [_Pole];publicVariable "OpControlledArray";[East,5] call DIS_fnc_CommanderSpeak;};
				[getMarkerPos _Marker, 'random','blue'] remoteExec ["GRAD_fireworks_fnc_prepareFireworks", 2];
					if (playerSide isEqualTo _SSide) then
					{
						_Marker setMarkerColor "ColorBlue";					
					};
					
				[
					[_Marker,_SSide],
					{
						params ["_Marker","_SSide"];
						if (playerSide isEqualTo _SSide) then
						{
							_Marker setMarkerColor "ColorWest";					
						};
					}
				
				] remoteExec ["bis_fnc_Spawn",0];						
					
				
			};	
			case East: 
			{
				if !(_Pole in OpControlledArray) then {OpControlledArray pushback _Pole;publicVariable "OpControlledArray";};		
				if (_Pole in IndControlledArray) then {IndControlledArray = IndControlledArray - [_Pole];publicVariable "IndControlledArray";};
				if (_Pole in BluControlledArray) then {BluControlledArray = BluControlledArray - [_Pole];publicVariable "BluControlledArray";[West,5] call DIS_fnc_CommanderSpeak;};		
				[getMarkerPos _Marker, 'random','red'] remoteExec ["GRAD_fireworks_fnc_prepareFireworks", 2];
				
				
				
				[
					[_Marker,_SSide],
					{
						params ["_Marker","_SSide"];
						if (playerSide isEqualTo _SSide) then
						{
							_Marker setMarkerColor "ColorRed";					
						};
					}
				
				] remoteExec ["bis_fnc_Spawn",0];						
				
				
			};				
	};
		
		_Pole setVariable ["DIS_Capture",[(_OriginalAmount + 10),(_OriginalAmount + 10),_AtkSide],true];
		(TownArray select _CforEachIndex) set [8,(_OriginalAmount + 10)];	
		[_AtkSide,4] call DIS_fnc_CommanderSpeak;
		
		
		[
		[_pole],
		{
			params ["_pole"];
			if (player distance2D _pole < 2000) then
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
			};
		}
		
		] remoteExec ["bis_fnc_Spawn",_AtkSide];		
		
		


};


//Defenders Won
if (_DefendersCount > 0) exitWith 
{


	[
	[_Marker,_AtkSide,_NameLocation,_Pole,_SSide],
	{
			params ["_Marker","_Side","_NameLocation","_Pole","_SSide"];
			if !(hasInterface) exitWith {};
			if (playerSide isEqualTo _Side) then
			{
				["DISTASK",["ASSAULT HALTED",(MISSION_ROOT + "Pictures\types\danger_ca.paa"),(format ["BATTLE LOST: %1",(toUpper _NameLocation)]),""]] call BIS_fnc_showNotification;
					[
					[
						[format ["%1: Fall back and regroup!",(toUpper _NameLocation)],"align = 'center' shadow = '1' size = '0.7' font='PuristaBold'"]
					]
				] spawn BIS_fnc_typeText2;					
			}
			else
			{
				if (playerSide isEqualTo _SSide) then
				{

					["DISTASK",["TOWN DEFENDED",(MISSION_ROOT + "Pictures\types\danger_ca.paa"),(format ["ASSAULT HALTED: %1",(toUpper _NameLocation)]),""]] call BIS_fnc_showNotification;
						[
							[
								[format ["%1: We have pushed back the assault!",(toUpper _NameLocation)],"align = 'center' shadow = '1' size = '0.7' font='PuristaBold'"]
						]
					] spawn BIS_fnc_typeText2;						
				};
			};
	}
	
	] remoteExec ["bis_fnc_Spawn",0];											
		
		
	switch (_SSide) do
	{
			case West: 
			{
				[getMarkerPos _Marker, 'random','blue'] remoteExec ["GRAD_fireworks_fnc_prepareFireworks", 2];
			};	
			case East: 
			{
				[getMarkerPos _Marker, 'random','red'] remoteExec ["GRAD_fireworks_fnc_prepareFireworks", 2];
			};				
	};
		
		_Pole setVariable ["DIS_Capture",[(_OriginalAmount + 10),(_OriginalAmount + 10),_SSide],true];
		(TownArray select _CforEachIndex) set [8,(_OriginalAmount + 10)];		
		
		[
		[_pole],
		{
			params ["_pole"];
			if (player distance2D _pole < 2000) then
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
				(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>Town Defended: + <t color='%2'>%1</t> </t></t></t>","$500",_TextColor]);
				_RandomNumber cutFadeOut 30;
			};
		}
		
		] remoteExec ["bis_fnc_Spawn",_SSide];		
		
		


};