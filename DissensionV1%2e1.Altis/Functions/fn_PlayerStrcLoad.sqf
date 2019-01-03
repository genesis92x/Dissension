//This function handles loading and creating player built structures.
//This will also handle giving structures back over to the player if they are present again in the map.
//[_Pos,_PhysicalObj,_Type,_PID,_Player] call DIS_fnc_PlayerStrcLoad;

params ["_Pos","_PhysicalObj","_Type","_PID","_PName","_Side","_Dir","_Vector"];

if (isNil "_PhysicalObj") exitWith {};
private _Object = _PhysicalObj createVehicle [0,0,0];
_Object addEventHandler ["HandleDamage", {0}];
_Object setposATL _Pos;
_Object setdir _Dir;
_Object setVectorUp _Vector;
_Object setVariable ["DIS_PLAYERVEH",true,true];


private _Clear1 = nearestTerrainObjects [_Object, ["TREE","BUSH","HIDE"], 25];
{
	_x hideObjectGlobal true;
} foreach _Clear1;	


//W_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];
//params ["_ObjectClass","_Player","_Object",["_PName",nil]];

//Prevent it from despawning
_Object setVariable ["DIS_PLAYERVEH",true,true];
[_Object,_Side] call DIS_fnc_StructureMonitor;
_Object addEventHandler ["HandleDamage", {0}];

switch (_PhysicalObj) do {
    case "Land_Research_HQ_F": 
		{
		
			private _Color = "ColorBlue";
			if (_Side isEqualTo East) then {_Color = "ColorRed";};	
					
			_Object spawn GOM_fnc_addAircraftLoadoutToObject;
			[
				[_Object,_Player,_Side,_Color,_PName,_PID],
				{
						params ["_Object","_Player","_Side","_Color","_PName","_PID"];
						if (isServer) then 
						{
							if (_Side isEqualTo West) then {W_BuildingList pushback [_Object,"PHQ",_PID,_PName];publicVariable "W_BuildingList";} else {E_BuildingList pushback [_Object,"PHQ",_PID,_PName];publicVariable "E_BuildingList";};
						};
							waitUntil {alive player};
							if ((side (group player)) isEqualTo _Side) then
							{
								private _Marker = createMarkerlocal [(str _Object),(getpos _Object)];
								_Marker setMarkerShapelocal 'ICON';
								_Marker setMarkerColorlocal _Color;
								_Marker setMarkerAlphalocal 1;		
								_Marker setMarkerSizelocal [0.5,0.5];
								_Marker setMarkerDirlocal 0;	
								_Marker setMarkerTypelocal 'loc_Bunker';
								_Marker setMarkerTextlocal (format ["HQ: %1",_PName]);
								_Marker setMarkerPosLocal (getpos _Object);
								_markername = floor (random 1000);
								_marker1 = createMarkerLocal [format ["%1-%2",_Marker,_Object],(getpos _Object)];
								_marker1 setMarkerShapeLocal "ELLIPSE";
								_marker1 setMarkerColorLocal _Color;
								_marker1 setMarkerBrushLocal "FDiagonal";
								_marker1 setMarkerSizeLocal [300,300];	
								_Marker setMarkerPosLocal (getpos _Object);
								_Object setVariable ["dis_marker",[_Marker,_marker1]];							
								_Object addEventHandler ["killed",
								{
									_Variable = (_this select 0) getVariable "dis_Marker";
									deleteMarker (_Variable select 0);
									deleteMarker (_Variable select 1);
								}];			
								_Object addEventHandler ["deleted",
								{
									_Variable = (_this select 0) getVariable "dis_Marker";
									deleteMarker (_Variable select 0);
									deleteMarker (_Variable select 1);
								}];								
								
							};
					}
					
				] remoteExec ["bis_fnc_Spawn",0,_Object];			
		};
    case "Land_Research_house_V1_F": 
		{
		
			//Respawn Point
			
			private _RespawnMName = format["respawn_west_%1",(floor (random 10000))];
			private _Color = "ColorBlue";
			if (_Side isEqualTo East) then {_RespawnMName = format["respawn_east_%1",(floor (random 10000))];_Color = "ColorRed";};
			[
			[_Object,player,_RespawnMName,_Color,_Side,_PName,_PID],
			{
					params ["_Object","_Player","_RespawnMName","_Color","_Side","_PName","_PID"];
					if (isServer) then 
					{
						if (_Side isEqualTo West) then {W_BuildingList pushback [_Object,"Barracks",_PID,_PName];publicVariable "W_BuildingList";} else {E_BuildingList pushback [_Object,"Barracks",_PID,_PName];publicVariable "E_BuildingList";};
					};

						if ((side (group player)) isEqualTo _Side) then
						{
							_Object addEventHandler ["killed",
							{
								_Variable = (_this select 0) getVariable "dis_Marker";
								deleteMarker (_Variable select 0);
							}];			
							_Object addEventHandler ["deleted",
							{
								_Variable = (_this select 0) getVariable "dis_Marker";
								deleteMarker (_Variable select 0);
							}];								
							private _Marker = createMarkerlocal [_RespawnMName,(getpos _Object)];
							_Marker setMarkerShapelocal 'ICON';
							_Marker setMarkerColorlocal _Color;
							_Marker setMarkerAlphalocal 1;		
							_Marker setMarkerSizelocal [0.5,0.5];
							_Marker setMarkerDirlocal 0;	
							_Marker setMarkerTypelocal 'loc_Bunker';
							_Marker setMarkerTextlocal format ["Respawn: %1",_PName];
							_Marker setMarkerPosLocal (getpos _Object);
							_Object setVariable ["dis_marker",[_Marker]];
							_Object addEventHandler ["killed",
							{
								_Variable = (_this select 0) getVariable "dis_Marker";
								deleteMarker (_Variable select 0);
								
							}];						
							_Object addEventHandler ["deleted",
							{
								_Variable = (_this select 0) getVariable "dis_Marker";
								deleteMarker (_Variable select 0)
								
							}];							
						};
				}
				
				] remoteExec ["bis_fnc_Spawn",0,_Object];


			
		};
		
		
		
		
    case "Land_Radar_Small_F": 
		{
			//Comms Tower
			private _Color = "ColorBlue";
			if (_Side isEqualTo East) then {_Color = "ColorRed";};
			
			[_Object,_Side] spawn
			{
				params ["_Object","_Side"];
				while {alive _Object} do
				{
					private _Units = allUnits select {!((side _x) isEqualTo _Side)};
					private _CU = [_Units,_Object,true,"171"] call dis_closestobj;
					if (!((stance _CU) isEqualTo "PRONE") && {_CU distance2D _Object < 301}) then
					{
						systemChat "There are enemy units close to your base.";
					};
					sleep 15;
				};
			};
			
			[
			[_Object,_Player,_Side,_Color,_PName,_PID],
			{
					params ["_Object","_Player","_Side","_Color","_PName","_PID"];
						if (isServer) then 
						{
							if (_Side isEqualTo West) then {W_BuildingList pushback [_Object,"CommsTower",_PID,_PName];publicVariable "W_BuildingList";} else {E_BuildingList pushback [_Object,"CommsTower",_PID,_PName];publicVariable "E_BuildingList";};
						};
						if ((side (group player)) isEqualTo _Side) then
						{
							private _Marker = createMarkerlocal [(str _Object),(getposASL _Object)];
							_Marker setMarkerShapelocal 'ICON';
							_Marker setMarkerColorlocal _Color;
							_Marker setMarkerAlphalocal 1;		
							_Marker setMarkerSizelocal [0.5,0.5];
							_Marker setMarkerDirlocal 0;	
							_Marker setMarkerTypelocal 'loc_Bunker';
							_Marker setMarkerTextlocal (format ["Comms Tower: %1",_PName]);
							_Marker setMarkerPosLocal (getpos _Object);
							_Object setVariable ["dis_marker",[_Marker]];
							_Object addEventHandler ["killed",
							{
								_Variable = (_this select 0) getVariable "dis_Marker";
								deleteMarker (_Variable select 0);
								if (local _Object) then {player setVariable ["DIS_Radar",""];};
							}];
							_Object addEventHandler ["deleted",
							{
								_Variable = (_this select 0) getVariable "dis_Marker";
								deleteMarker (_Variable select 0);
								if (local _Object) then {player setVariable ["DIS_Radar",""];};
							}];									
							
						};
				}
				
				] remoteExec ["bis_fnc_Spawn",0,_Object];			
		};		
		
    case "Land_Bunker_F": 
		{
			//Vehicle Hangar
			private _Color = "ColorBlue";
			if (_Side isEqualTo East) then {_Color = "ColorRed";};
			
			//The hangar is a special cupcake and needs a special action for it's selling abilities and cargo abilities.
			//These actions will be JIP friendly
			[
			[_Object],
			{
					params ["_Object"];
					private _Obj = [_Object,"Sell Vehicle","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","_this distance _target < 30","true",{hint "Selling...";},{},{hint "Sold!";[_this,"Sold"] call DIS_fnc_REHndle;},{hint "Stopped selling!";},[],5,-100,false,false] call bis_fnc_holdActionAdd;
					private _Obj = [_Object,"Sell All Cargo","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","_this distance _target < 30","true",{hint "Selling...";},{},{hint "Sold!";[_this,"Sell All Cargo"] call DIS_fnc_REHndle;},{hint "Stopped selling!";},[],5,-100,false,false] call bis_fnc_holdActionAdd;
							
			}
				
			] remoteExec ["bis_fnc_Spawn",0,_Object];						
			
			[
			[_Object,_Player,_Side,_Color,_PName,_PID],
			{
					params ["_Object","_Player","_Side","_Color","_PName","_PID"];
					if (isServer) then 
					{
						if (_Side isEqualTo West) then {W_BuildingList pushback [_Object,"Hangar",_PID,_PName];publicVariable "W_BuildingList";} else {E_BuildingList pushback [_Object,"Hangar",_PID,_PName];publicVariable "E_BuildingList";};
					};
						if ((side (group player)) isEqualTo _Side) then
						{
							private _Marker = createMarkerlocal [(str _Object),(getPosASL _Object)];
							_Marker setMarkerShapelocal 'ICON';
							_Marker setMarkerColorlocal _Color;
							_Marker setMarkerAlphalocal 1;		
							_Marker setMarkerSizelocal [0.5,0.5];
							_Marker setMarkerDirlocal 0;	
							_Marker setMarkerTypelocal 'loc_Bunker';
							_Marker setMarkerTextlocal (format ["Vehicle Hangar: %1",_PName]);
							_Marker setMarkerPosLocal (getpos _Object);
							_Object setVariable ["dis_marker",[_Marker]];							
							_Object addEventHandler ["killed",
							{
								_Variable = (_this select 0) getVariable "dis_Marker";
								deleteMarker (_Variable select 0);
							}];
							_Object addEventHandler ["deleted",
							{
								_Variable = (_this select 0) getVariable "dis_Marker";
								deleteMarker (_Variable select 0);
							}];									
							
						};
				}
				
				] remoteExec ["bis_fnc_Spawn",0,_Object];			
		};
		
		case "B_SAM_System_01_F":
		{
		
			private _nwgrp = createGroup _Side;
			createVehicleCrew _Object;
			{[_x] joinSilent _nwgrp;} foreach (crew _Object);
			_nwgrp setVariable ["DIS_IMPORTANT",true,true];
			[
			[_Object,_PName,_Side,_PID],
			{
					params ["_Object","_PName","_Side","_PID"];
					if (isServer) then 
					{
						if (_Side isEqualTo West) then {W_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];publicVariable "W_BuildingList";} else {E_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];publicVariable "E_BuildingList";};
					};
				}
				
				] remoteExec ["bis_fnc_Spawn",0];		
		};
		case "B_SAM_System_02_F":
		{
			private _nwgrp = createGroup _Side;
			createVehicleCrew _Object;
			{[_x] joinSilent _nwgrp;} foreach (crew _Object);
			_nwgrp setVariable ["DIS_IMPORTANT",true,true];
			[
			[_Object,_PName,_Side,_PID],
			{
					params ["_Object","_PName","_Side","_PID"];
					if (isServer) then 
					{
						if (_Side isEqualTo West) then {W_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];publicVariable "W_BuildingList";} else {E_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];publicVariable "E_BuildingList";};
					};
				}
				
				] remoteExec ["bis_fnc_Spawn",0];		
		};
		case "B_AAA_System_01_F":
		{
			private _nwgrp = createGroup _Side;
			createVehicleCrew _Object;
			{[_x] joinSilent _nwgrp;} foreach (crew _Object);
			_nwgrp setVariable ["DIS_IMPORTANT",true,true];
			[
			[_Object,_PName,_Side,_PID],
			{
					params ["_Object","_PName","_Side","_PID"];
					if (isServer) then 
					{
						if (_Side isEqualTo West) then {W_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];publicVariable "W_BuildingList";} else {E_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];publicVariable "E_BuildingList";};
					};
				}
				
				] remoteExec ["bis_fnc_Spawn",0];		
		};		
		case "B_CargoNet_01_ammo_F":
		{
			clearWeaponCargoGlobal _Object;
			clearMagazineCargoGlobal _Object;
			clearItemCargoGlobal _Object;
			_Object setVariable ["DIS_PLAYERVEH",true,true];
			_Object call dis_fnc_RearmRep;
			[
			[_Object,_PName,_Side,_PID],
			{
					params ["_Object","_PName","_Side","_PID"];
					if (isServer) then 
					{
						if (_Side isEqualTo West) then {W_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];publicVariable "W_BuildingList";} else {E_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];publicVariable "E_BuildingList";};
					};
				}
				
				] remoteExec ["bis_fnc_Spawn",0];		
		};
		case "B_Slingload_01_Repair_F":
		{
			clearWeaponCargoGlobal _Object;
			clearMagazineCargoGlobal _Object;
			clearItemCargoGlobal _Object;
			_Object setVariable ["DIS_PLAYERVEH",true,true];
			_Object call dis_fnc_RearmRep;
			[
			[_Object,_PName,_Side,_PID],
			{
					params ["_Object","_PName","_Side","_PID"];
					if (isServer) then 
					{
						if (_Side isEqualTo West) then {W_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];publicVariable "W_BuildingList";} else {E_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];publicVariable "E_BuildingList";};
					};
				}
				
				] remoteExec ["bis_fnc_Spawn",0];					
		};		
		case "B_Slingload_01_Medevac_F":
		{
			clearWeaponCargoGlobal _Object;
			clearMagazineCargoGlobal _Object;
			clearItemCargoGlobal _Object;
			_Object setVariable ["DIS_PLAYERVEH",true,true];
			_Object call dis_fnc_RearmRep;	
			[
			[_Object,_PName,_Side,_PID],
			{
					params ["_Object","_PName","_Side","_PID"];
					if (isServer) then 
					{
						if (_Side isEqualTo West) then {W_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];publicVariable "W_BuildingList";} else {E_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];publicVariable "E_BuildingList";};
					};
				}
				
				] remoteExec ["bis_fnc_Spawn",0];					
		};	
		case "B_Slingload_01_Fuel_F":
		{
			clearWeaponCargoGlobal _Object;
			clearMagazineCargoGlobal _Object;
			clearItemCargoGlobal _Object;
			_Object setVariable ["DIS_PLAYERVEH",true,true];
			_Object call dis_fnc_RearmRep;	
			[
			[_Object,_PName,_Side,_PID],
			{
					params ["_Object","_PName","_Side","_PID"];
					if (isServer) then 
					{
						if (_Side isEqualTo West) then {W_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];publicVariable "W_BuildingList";} else {E_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];publicVariable "E_BuildingList";};
					};
				}
				
				] remoteExec ["bis_fnc_Spawn",0];					
		};	
		case "B_Slingload_01_Cargo_F":
		{
			clearWeaponCargoGlobal _Object;
			clearMagazineCargoGlobal _Object;
			clearItemCargoGlobal _Object;
			_Object setVariable ["DIS_PLAYERVEH",true,true];
			_Object call dis_fnc_RearmRep;			
			[
			[_Object,_PName,_Side,_PID],
			{
					params ["_Object","_PName","_Side","_PID"];
					if (isServer) then 
					{
						if (_Side isEqualTo West) then {W_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];publicVariable "W_BuildingList";} else {E_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];publicVariable "E_BuildingList";};
					};
				}
				
				] remoteExec ["bis_fnc_Spawn",0];					
		};	
		case "B_Slingload_01_Ammo_F":
		{
			clearWeaponCargoGlobal _Object;
			clearMagazineCargoGlobal _Object;
			clearItemCargoGlobal _Object;
			_Object setVariable ["DIS_PLAYERVEH",true,true];
			_Object call dis_fnc_RearmRep;		
			[
			[_Object,_PName,_Side,_PID],
			{
					params ["_Object","_PName","_Side","_PID"];
					if (isServer) then 
					{
						if (_Side isEqualTo West) then {W_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];publicVariable "W_BuildingList";} else {E_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];publicVariable "E_BuildingList";};
					};
				}
				
				] remoteExec ["bis_fnc_Spawn",0];					
		};			
		case "Land_RepairDepot_01_green_F":
		{
			clearWeaponCargoGlobal _Object;
			clearMagazineCargoGlobal _Object;
			clearItemCargoGlobal _Object;
			_Object setVariable ["DIS_PLAYERVEH",true,true];
			_Object call dis_fnc_RearmRep;
			[
			[_Object,_PName,_Side,_PID],
			{
					params ["_Object","_PName","_Side","_PID"];
					if (isServer) then 
					{
						if (_Side isEqualTo West) then {W_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];publicVariable "W_BuildingList";} else {E_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];publicVariable "E_BuildingList";};
					};
				}
				
				] remoteExec ["bis_fnc_Spawn",0];			
		};
    default 
		{
			systemChat "DEFAULT";
			[
			[_Object,_PName,_Side,_PID],
			{
					params ["_Object","_PName","_Side","_PID"];
					if (isServer) then 
					{
						if (_Side isEqualTo West) then {W_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];publicVariable "W_BuildingList";} else {E_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];publicVariable "E_BuildingList";};
					};
				}
				
				] remoteExec ["bis_fnc_Spawn",0];				
		};
};

