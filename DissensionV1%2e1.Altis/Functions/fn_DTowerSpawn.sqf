//Function for the Defensive tower 
params ["_Pole","_NameLocation","_SSide","_AtkSide"];

private _PolePos = getposATL _Pole;
private _SpwnPos = [_PolePos, 2, 400, 5, 0, 20, 0,[],[_PolePos,_PolePos]] call BIS_fnc_findSafePos;
private _Tower = "Land_TTowerBig_2_F" createVehicle _SpwnPos;
private _Tower2 = "Land_PowerGenerator_F" createVehicle _SpwnPos;
_Tower2 disableCollisionWith _Tower;
_Tower setpos _Spwnpos;
_Tower allowdamage false;
_Tower2 allowdamage false;
_Tower setvariable ["DIS_PLAYERVEH",true,true];
_Tower2 setvariable ["DIS_PLAYERVEH",true,true];
_Tower2 setposATL (getposATL _Tower);
_Tower2 setVelocity [0,0,0];
_Pole setVariable ["DIS_TowerAlive",true,true];
_Tower setVariable ["DIS_TowerPole",_Pole,true];
_Tower setVariable ["DIS_TowerBox",_Tower2,true];
_Tower2 setVariable ["DIS_TowerBox",_Tower,true];
_Tower2 setVectorUp [0,0,1];
_Tower setVectorUp [0,0,1];

/*
[
	[_Tower2],
	{
		params ["_Tower2"];
		_Tower2 enableSimulationGlobal false;
	}
	
] remoteExec ["bis_fnc_Spawn",2]; 
*/

_Tower addEventHandler ["Killed", 
{
	private _VR = (_this select 0) getVariable "DIS_TowerPole";
	private _Bx = (_this select 0) getVariable "DIS_TowerBox";
	_VR setVariable ["DIS_TowerAlive",false,true];
	deleteVehicle _Bx;

			private _Tower = (_this select 0);
			private _DO = _Tower getVariable "DIS_DSOBT";
			private _AO = _Tower getVariable "DIS_ASOBT";
			[_DO,"FAILED"] call BIS_fnc_taskSetState;
			[_AO,"SUCCEEDED"] call BIS_fnc_taskSetState;

	[
		[(_this select 0)],
		{
			params ["_Tower"];
			if (player distance2D _Tower < 3000) then
			{
				["DISTASK",["CAPTURE TOWN",(MISSION_ROOT + "Pictures\types\radio_ca.paa"),"DESTROYED COMMS TOWER",""]] call BIS_fnc_showNotification;
				[
				[
					["Comms Relay Destroyed - Counterattack halted.","align = 'center' shadow = '1' size = '0.5' font='PuristaBold'"]
				]
				] spawn BIS_fnc_typeText2;				
			};
		}
		
	] remoteExec ["bis_fnc_Spawn",0]; 	
	(_this select 0) spawn {sleep 30; deleteVehicle _this;}; 
	
	
}];	

[_Tower,_Tower2,_Pole] spawn
{
	params ["_Tower","_Tower2","_Pole"];
	while {_Pole getVariable ["DIS_ENGAGED",false]} do
	{
		sleep 5;
	};
	deleteVehicle _Tower;
	deleteVehicle _Tower2;
};




[
	[_Tower,_Pole,_Tower2,_SSide,_AtkSide],
	{
	
		if (Dis_debug) then 
		{
			diag_log format ["DISDEBUG: TOWER SPAWN: TOWER:%1 POLE:%2 TOWER2:%3 SSIDE:%4 ATTACKSIDE:%5",(_this select 0),(_this select 1),(_this select 2),(_this select 3),(_this select 4)];
		};	
	
		if !(hasInterface) exitwith {};		
		sleep 10;
		waitUntil {!(isNil "MISSION_ROOT")};
		params ["_Tower","_Pole","_Tower2","_SSide","_AtkSide"];
		if !(playerSide isEqualTo _SSide) then
		{
			private _Addaction = [_Tower2,"Destroy Relay Tower","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa","_this distance _target < 1000","true",{hint "Destroying!";},{},{hint "Tower will detonate in 40 seconds! Run!";(_this select 0) spawn {sleep 40;private _tst = _this getVariable "DIS_TowerBox";		private _strpos = getpos _tst;private _NN = 10;{private _NewPos = [(_strpos select 0),(_strpos select 1),((_strpos select 2) + _NN)];createVehicle ["HelicopterExploSmall",_NewPos, [], 0, "CAN_COLLIDE"];_NN = _NN + 10;true;sleep 0.5;} count [1,2,3,4];_tst setDamage 1;}},{hint "Stopped!"},[],8,0,true,true] call bis_fnc_holdActionAdd;
		};

		if (_AtkSide isEqualTo playerSide) then
		{
			private _ObjM = createMarkerlocal [(format ["%1",_Tower]),(getpos _Tower)];
			_ObjM setmarkershapelocal "ICON";
			_ObjM setMarkerTypelocal "mil_end";
			_ObjM setmarkercolorlocal "ColorEAST";
			_ObjM setmarkersizelocal [0.4,0.4];
			_ObjM setMarkerAlphalocal 1;
			_ObjM setMarkerTextLocal "COMMS TOWER";
			[_ObjM,_Tower,_Pole] spawn
			{
				params ["_Mrk","_Tower","_Pole"];
				waitUntil {!(alive _Tower) || !(_Pole getVariable ["DIS_ENGAGED",false])};
				deleteMarker _Mrk;
			};
		};
		
		
		private _Img = MISSION_ROOT + "Pictures\types\destroy_ca.paa";
		[((str _Tower) + "DESTROY"), "onEachFrame", 
		{
			params ["_Img","_Tower","_Pole","_Tower2"];
			if (alive _Tower && {_Pole getVariable ["DIS_ENGAGED",false]}) then
			{
				_pos2 = getPos _Tower;
				_pos2 set [2,(_pos2 select 2) + 2];
				_alphaText = round (linearConversion[25, 800, player distance2D _Tower, 1, 0, true]);
				call compile format 
				[
				'
				drawIcon3D
				[
					%1,
					[1,1,1,%3],
					%2,
					0.75,
					0.75,
					0,
					"Comms Array",
					1,
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
				[((str _Tower) + "DESTROY"), "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
			};
		},
		[_Img,_Tower,_Pole,_Tower2]
		] call BIS_fnc_addStackedEventHandler;			
	

	}
	
] remoteExec ["bis_fnc_Spawn",0,_Tower]; 

	[_Tower,_Pole,_SSide,_AtkSide] spawn
	{
		params ["_Tower","_Pole","_SSide","_AtkSide"];
		sleep 5;


		//Marker for tasks
		private _ObjMM = createMarker [(format ["%1",(random 10000)]),(getpos _Tower)];
		_ObjMM setmarkershape "ICON";
		_ObjMM setMarkerType "Empty";
		_pole setVariable ["DIS_TASKMM",_ObjMM];

		//Defend task!
		private _ObjN = _pole getVariable "DIS_DefendTID";
		private _ObjSN = _pole getVariable ["DIS_DefendTISSO",[]];
		private _ObjNSN = (format ["%1-%2",_Pole,"TOWERSPAWND"]); 
		_ObjSN pushBack _ObjNSN;
		_pole setVariable ["DIS_DefendTISSO",_ObjSN];
		[_SSide,[_ObjNSN,_ObjN], ["Prevent the enemy forces from planting charges on our comms tower! The comms tower will call in support if we are losing this battle!","Protect Comms Array",_ObjMM], (getpos _Tower), "CREATED", 90, true, "", true] call BIS_fnc_taskCreate;
		_Tower setVariable ["DIS_DSOBT",_ObjNSN];

		//Attack task!
		private _ObjN = _pole getVariable "DIS_AttackTID";
		private _ObjSN = _pole getVariable ["DIS_AttackTISSO",[]];
		private _ObjNSN = (format ["%1-%2",_Pole,"TOWERSPAWNA"]); 
		_ObjSN pushBack _ObjNSN;
		_pole setVariable ["DIS_AttackTISSO",_ObjSN];
		[_AtkSide,[_ObjNSN,_ObjN], ["Plant charges on this comms tower! This comms tower will provide signficiant support to enemy forces if they are losing the battle! Use the HOLD ACTION on the generator to plant charges this comms tower!","Destroy Comms Tower",_ObjMM], (getpos _Tower), "CREATED", 90, true, "", true] call BIS_fnc_taskCreate;
		_Tower setVariable ["DIS_ASOBT",_ObjNSN];
	};