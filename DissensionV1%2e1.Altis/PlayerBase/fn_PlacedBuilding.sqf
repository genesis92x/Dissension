//[_object,_unit] call DIS_fnc_PlacedBuilding;
//This function will run through a list of all the possible buildings and execute the appropriate code on them.
//CfgObjectsArray = ["B_CargoNet_01_ammo_F","B_Slingload_01_Repair_F","B_Slingload_01_Medevac_F","B_Slingload_01_Fuel_F","B_Slingload_01_Cargo_F","B_Slingload_01_Ammo_F","Land_RepairDepot_01_green_F"];

params ["_ObjectClass","_Player","_Object"];

//Prevent it from despawning
_Object setVariable ["DIS_PLAYERVEH",true,true];
_Object setVariable ["DIS_SPECIAL",true,true];
//[_Object,(side (group player))] call DIS_fnc_StructureMonitor;

private _Radar = player getVariable ["DIS_RADAR",""];
private _BRK = player getVariable ["DIS_BRKS",""];
private _HQ = player getVariable ["DIS_HQ",""];
private _PName = name player;
private _PID = getPlayerUID player;
private _Side = (side (group _Player));

private _Clear1 = nearestTerrainObjects [_Object, ["TREE","BUSH","HIDE"], 25];

[
	[_Clear1],
	{
		params ["_Clear1"];
		{
			_x hideObjectGlobal true;
		} foreach _Clear1;	
	}	
] remoteExecCall ["BIS_fnc_call",2];

_Object addAction ["<t color='#18FF2B'> <t size='1.25'>Disassemble</t></t>", 
{
	deleteVehicle (_this select 0);
	if (alive (_this select 0)) then 
	{
		DIS_FortificationArray pushback (_this select 3 select 0);
	};	
},[_ObjectClass],-200,false,false,"","true",15,false];

switch (_ObjectClass) do {
    case "Land_Research_HQ_F": 
		{
			//Player Base HQ
			if !(_HQ isEqualTo "") exitWith 
			{
				DIS_FortificationArray pushback "Land_Research_HQ_F";
				systemChat "You already have an HQ placed!";
				deleteVehicle _Object;
			};
			player setVariable ["DIS_HQ",_Object];			
			
			_Side = (side (group _Player));
			private _Color = "ColorBlue";
			if (_Side isEqualTo East) then {_Color = "ColorRed";};

			_Object addEventHandler ["killed",
			{
				player setVariable ["DIS_HQ",""];
			}];		
			_Object addEventHandler ["deleted",
			{
				player setVariable ["DIS_HQ",""];
			}];		
					
			_Object spawn GOM_fnc_addAircraftLoadoutToObject;
			private _Pos = getpos _Object;
			
			_Object addAction ["<t color='#18FF2B'> <t size='1.0'>Respawn Build Crate</t></t>", 
			{
				private _CargoBox = player getVariable ["DIS_CargoBox",nil];
				if !(isNil "_CargoBox") then
				{
					_Cargobox setpos (getpos player);
				};
			},[_ObjectClass],-200,false,false,"","true",15,false];			
			
			
			
			
			[
			[_Object,_Player,_Side,_Color,_PName,_PID,_Pos],
			{
					params ["_Object","_Player","_Side","_Color","_PName","_PID","_Pos"];
					sleep 10;
						if (isServer) then 
						{
							_Object setVariable ["DIS_BINFO",[_Object,"PHQ",_PID,_PName]];
							_Object allowdamage false;
							if (_Side isEqualTo West) then 
							{
								W_BuildingList pushback [_Object,"PHQ",_PID,_PName];
								_Object addEventHandler ["killed",
								{
									params ["_Object", "_killer", "_instigator", "_useEffects"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									W_BuildingList = W_BuildingList - _Array;
									publicVariable "W_BuildingList";									
								}];
								_Object addEventHandler ["deleted",
								{
									params ["_Object"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									W_BuildingList = W_BuildingList - _Array;
									publicVariable "W_BuildingList";
								}];
								publicVariable "W_BuildingList";
							} 
							else 
							{
								E_BuildingList pushback [_Object,"PHQ",_PID,_PName];
								_Object addEventHandler ["killed",
								{
									params ["_Object", "_killer", "_instigator", "_useEffects"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									E_BuildingList = E_BuildingList - _Array;
									publicVariable "E_BuildingList";
								}];
								_Object addEventHandler ["deleted",
								{
									params ["_Object"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									E_BuildingList = E_BuildingList - _Array;
									publicVariable "E_BuildingList";
								}];	
								publicVariable "E_BuildingList";
							};							
						};
						waitUntil {alive player};
						if ((side (group player)) isEqualTo _Side) then
						{
							private _Marker = createMarkerlocal [(str _Object),_Pos];
							_Marker setMarkerShapelocal 'ICON';
							_Marker setMarkerColorlocal _Color;
							_Marker setMarkerAlphalocal 1;		
							_Marker setMarkerSizelocal [0.5,0.5];
							_Marker setMarkerDirlocal 0;	
							_Marker setMarkerTypelocal 'loc_Bunker';
							_Marker setMarkerTextlocal (format ["HQ: %1",_PName]);
							_Marker setMarkerPosLocal _Pos;
							_markername = floor (random 1000);
							_marker1 = createMarkerLocal [format ["%1-%2",_Marker,_Object],_Pos];
							_marker1 setMarkerShapeLocal "ELLIPSE";
							_marker1 setMarkerColorLocal _Color;
							_marker1 setMarkerBrushLocal "FDiagonal";
							_marker1 setMarkerSizeLocal [300,300];	
							_marker1 setMarkerPosLocal _Pos;
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
			if !(_BRK isEqualTo "") exitWith 
			{
				DIS_FortificationArray pushback "Land_Research_house_V1_F";
				systemChat "You already have a barracks placed!";
				deleteVehicle _Object;
			};
			player setVariable ["DIS_RDR",_Object];
			
			
			_Object addEventHandler ["killed",
			{
				player setVariable ["DIS_RDR",""];
			}];		
			_Object addEventHandler ["deleted",
			{
				player setVariable ["DIS_RDR",""];
			}];				

					
			private _RespawnMName = format["respawn_west_%1",(floor (random 10000))];
			private _Side = (side (group player));
			private _Color = "ColorBlue";
			if (_Side isEqualTo East) then {_RespawnMName = format["respawn_east_%1",(floor (random 10000))];_Color = "ColorRed";};
			private _Pos = getpos _Object;
			[
			[_Object,player,_RespawnMName,_Color,_Side,_PName,_PID,_Pos],
			{
					sleep 10;
					params ["_Object","_Player","_RespawnMName","_Color","_Side","_PName","_PID","_Pos"];
					if (isServer) then 
					{
						_Object setVariable ["DIS_BINFO",[_Object,"Barracks",_PID,_PName]];
						_Object allowdamage false;
						if (_Side isEqualTo West) then 
						{
							W_BuildingList pushback [_Object,"Barracks",_PID,_PName];
							_Object addEventHandler ["killed",
							{
								params ["_Object", "_killer", "_instigator", "_useEffects"];
								private _Array = _Object getVariable ["DIS_BINFO",[]];
								W_BuildingList = W_BuildingList - _Array;
								publicVariable "W_BuildingList";		
							}];
							_Object addEventHandler ["deleted",
							{
								params ["_Object"];
								private _Array = _Object getVariable ["DIS_BINFO",[]];
								W_BuildingList = W_BuildingList - _Array;
								publicVariable "W_BuildingList";
							}];
							publicVariable "W_BuildingList";
						} 
						else 
						{
							E_BuildingList pushback [_Object,"Barracks",_PID,_PName];
							_Object addEventHandler ["killed",
							{
								params ["_Object", "_killer", "_instigator", "_useEffects"];
								private _Array = _Object getVariable ["DIS_BINFO",[]];
								E_BuildingList = E_BuildingList - _Array;
								publicVariable "E_BuildingList";	
							}];
							_Object addEventHandler ["deleted",
							{
								params ["_Object"];
								private _Array = _Object getVariable ["DIS_BINFO",[]];
								E_BuildingList = E_BuildingList - _Array;
								publicVariable "E_BuildingList";
							}];	
							publicVariable "E_BuildingList";
						};							
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
							private _Marker = createMarkerlocal [_RespawnMName,_Pos];
							_Marker setMarkerShapelocal 'ICON';
							_Marker setMarkerColorlocal _Color;
							_Marker setMarkerAlphalocal 1;		
							_Marker setMarkerSizelocal [0.5,0.5];
							_Marker setMarkerDirlocal 0;	
							_Marker setMarkerTypelocal 'loc_Bunker';
							_Marker setMarkerTextlocal format ["Respawn: %1",_PName];
							_Marker setMarkerPosLocal _Pos;
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
			if !(_Radar isEqualTo "") exitWith 
			{
				DIS_FortificationArray pushback "Land_Radar_Small_F";
				systemChat "You already have a radar placed!";
				deleteVehicle _Object;
			};
			player setVariable ["DIS_Radar",_Object];
			private _Side = (side (group player));
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
						sleep 10;
						if (isServer) then 
						{
							_Object setVariable ["DIS_BINFO",[_Object,"CommsTower",_PID,_PName]];
							_Object allowdamage false;
							if (_Side isEqualTo West) then 
							{
								W_BuildingList pushback [_Object,"CommsTower",_PID,_PName];
								_Object addEventHandler ["killed",
								{
									params ["_Object", "_killer", "_instigator", "_useEffects"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									W_BuildingList = W_BuildingList - _Array;
									publicVariable "W_BuildingList";
								}];
								_Object addEventHandler ["deleted",
								{
									params ["_Object"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									W_BuildingList = W_BuildingList - _Array;
									publicVariable "W_BuildingList";
								}];
								publicVariable "W_BuildingList";
							} 
							else 
							{
								E_BuildingList pushback [_Object,"CommsTower",_PID,_PName];
								_Object addEventHandler ["killed",
								{
									params ["_Object", "_killer", "_instigator", "_useEffects"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									E_BuildingList = E_BuildingList - _Array;
									publicVariable "E_BuildingList";
								}];
								_Object addEventHandler ["deleted",
								{
									params ["_Object"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									E_BuildingList = E_BuildingList - _Array;
									publicVariable "E_BuildingList";
								}];
								publicVariable "E_BuildingList";
							};							
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

			private _Side = (side (group _Player));
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
					sleep 10;		
						if (isServer) then 
						{
							_Object setVariable ["DIS_BINFO",[_Object,"Hangar",_PID,_PName]];
							_Object allowdamage false;
							if (_Side isEqualTo West) then 
							{
								W_BuildingList pushback [_Object,"Hangar",_PID,_PName];
								_Object addEventHandler ["killed",
								{
									params ["_Object", "_killer", "_instigator", "_useEffects"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									W_BuildingList = W_BuildingList - _Array;
									publicVariable "W_BuildingList";
								}];
								_Object addEventHandler ["deleted",
								{
									params ["_Object"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									W_BuildingList = W_BuildingList - _Array;
									publicVariable "W_BuildingList";
								}];
								publicVariable "W_BuildingList";
							} 
							else 
							{
								E_BuildingList pushback [_Object,"Hangar",_PID,_PName];
								_Object addEventHandler ["killed",
								{
									params ["_Object", "_killer", "_instigator", "_useEffects"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									E_BuildingList = E_BuildingList - _Array;
									publicVariable "E_BuildingList";
								}];
								_Object addEventHandler ["deleted",
								{
									params ["_Object"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									E_BuildingList = E_BuildingList - _Array;
									publicVariable "E_BuildingList";
								}];
								publicVariable "E_BuildingList";
							};							
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
			if (isNil "DIS_SAM1") then {DIS_SAM1 = false;};
			if (DIS_SAM1) exitWith
			{
				DIS_FortificationArray pushback "B_SAM_System_01_F";
				systemChat "You already have this SAM placed!";
				deleteVehicle _Object;			
			};
			DIS_SAM1 = true;
			_Object addEventHandler ["killed",
			{
				DIS_SAM1 = false;
			}];
			_Object addEventHandler ["deleted",
			{
				DIS_SAM1 = false;
			}];			
			private _nwgrp = createGroup (side player);
			createVehicleCrew _Object;
			{[_x] joinSilent _nwgrp;_x setVariable ["DIS_PLAYERVEH",true,true];_x setVariable ["DIS_SPECIAL",true,true];} foreach (crew _Object);
			_nwgrp setVariable ["DIS_IMPORTANT",true,true];
			_Object setVariable ["DIS_PLAYERVEH",true,true];
			_Object setVariable ["DIS_SPECIAL",true,true];
			[
			[_Object,_PName,_Side,_PID],
			{
						params ["_Object","_PName","_Side","_PID"];					
						if (isServer) then 
						{
							_Object setVariable ["DIS_BINFO",[_Object,"FORTIFICATION",_PID,_PName]];
							_Object allowdamage false;
							if (_Side isEqualTo West) then 
							{
								W_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];
								_Object addEventHandler ["killed",
								{
									params ["_Object", "_killer", "_instigator", "_useEffects"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									W_BuildingList = W_BuildingList - _Array;
									publicVariable "W_BuildingList";
								}];
								_Object addEventHandler ["deleted",
								{
									params ["_Object"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									W_BuildingList = W_BuildingList - _Array;
									publicVariable "W_BuildingList";
								}];
								publicVariable "W_BuildingList";
							} 
							else 
							{
								E_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];
								_Object addEventHandler ["killed",
								{
									params ["_Object", "_killer", "_instigator", "_useEffects"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									E_BuildingList = E_BuildingList - _Array;
									publicVariable "E_BuildingList";
								}];
								_Object addEventHandler ["deleted",
								{
									params ["_Object"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									E_BuildingList = E_BuildingList - _Array;
									publicVariable "E_BuildingList";
								}];	
								publicVariable "E_BuildingList";
							};							
						};					
					
				}
				
				] remoteExec ["bis_fnc_Spawn",0];		
		};
		case "B_SAM_System_02_F":
		{
			if (isNil "DIS_SAM2") then {DIS_SAM2 = false;};
			if (DIS_SAM2) exitWith
			{
				DIS_FortificationArray pushback "B_SAM_System_02_F";
				systemChat "You already have this SAM placed!";
				deleteVehicle _Object;			
			};
			DIS_SAM2 = true;
			_Object addEventHandler ["killed",
			{
				DIS_SAM2 = false;
			}];
			_Object addEventHandler ["deleted",
			{
				DIS_SAM2 = false;
			}];					
			private _nwgrp = createGroup (side player);
			createVehicleCrew _Object;
			{[_x] joinSilent _nwgrp;_x setVariable ["DIS_PLAYERVEH",true,true];_x setVariable ["DIS_SPECIAL",true,true];} foreach (crew _Object);
			_nwgrp setVariable ["DIS_IMPORTANT",true,true];
			_Object setVariable ["DIS_SPECIAL",true,true];
			_Object setVariable ["DIS_PLAYERVEH",true,true];
			[
			[_Object,_PName,_Side,_PID],
			{
					params ["_Object","_PName","_Side","_PID"];
						if (isServer) then 
						{
							_Object setVariable ["DIS_BINFO",[_Object,"FORTIFICATION",_PID,_PName]];
							_Object allowdamage false;
							if (_Side isEqualTo West) then 
							{
								W_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];
								_Object addEventHandler ["killed",
								{
									params ["_Object", "_killer", "_instigator", "_useEffects"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									W_BuildingList = W_BuildingList - _Array;
									publicVariable "W_BuildingList";
								}];
								_Object addEventHandler ["deleted",
								{
									params ["_Object"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									W_BuildingList = W_BuildingList - _Array;
									publicVariable "W_BuildingList";
								}];
								publicVariable "W_BuildingList";
							} 
							else 
							{
								E_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];
								_Object addEventHandler ["killed",
								{
									params ["_Object", "_killer", "_instigator", "_useEffects"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									E_BuildingList = E_BuildingList - _Array;
									publicVariable "E_BuildingList";
								}];
								_Object addEventHandler ["deleted",
								{
									params ["_Object"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									E_BuildingList = E_BuildingList - _Array;
									publicVariable "E_BuildingList";
								}];
								publicVariable "E_BuildingList";
							};							
						};							
				}
				
			] remoteExec ["bis_fnc_Spawn",0];		
		};
		case "B_AAA_System_01_F":
		{
			if (isNil "DIS_SAM3") then {DIS_SAM3 = false;};
			if (DIS_SAM3) exitWith
			{
				DIS_FortificationArray pushback "B_SAM_System_02_F";
				systemChat "You already have this SAM placed!";
				deleteVehicle _Object;			
			};
			DIS_SAM3 = true;
			_Object addEventHandler ["killed",
			{
				DIS_SAM3 = false;
			}];
			_Object addEventHandler ["deleted",
			{
				DIS_SAM3 = false;
			}];			
			private _nwgrp = createGroup (side player);
			createVehicleCrew _Object;
			{[_x] joinSilent _nwgrp;_x setVariable ["DIS_PLAYERVEH",true,true];_x setVariable ["DIS_SPECIAL",true,true];} foreach (crew _Object);
			_nwgrp setVariable ["DIS_IMPORTANT",true,true];
			_Object setVariable ["DIS_SPECIAL",true,true];
			_Object setVariable ["DIS_PLAYERVEH",true,true];
			[
			[_Object,_PName,_Side,_PID],
			{
					params ["_Object","_PName","_Side","_PID"];
						if (isServer) then 
						{
							_Object setVariable ["DIS_BINFO",[_Object,"FORTIFICATION",_PID,_PName]];
							_Object allowdamage false;
							if (_Side isEqualTo West) then 
							{
								W_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];
								_Object addEventHandler ["killed",
								{
									params ["_Object", "_killer", "_instigator", "_useEffects"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									W_BuildingList = W_BuildingList - _Array;
									publicVariable "W_BuildingList";
								}];
								_Object addEventHandler ["deleted",
								{
									params ["_Object"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									W_BuildingList = W_BuildingList - _Array;
									publicVariable "W_BuildingList";
								}];
								publicVariable "W_BuildingList";
							} 
							else 
							{
								E_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];
								_Object addEventHandler ["killed",
								{
									params ["_Object", "_killer", "_instigator", "_useEffects"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									E_BuildingList = E_BuildingList - _Array;
									publicVariable "E_BuildingList";
								}];
								_Object addEventHandler ["deleted",
								{
									params ["_Object"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									E_BuildingList = E_BuildingList - _Array;
									publicVariable "E_BuildingList";
								}];
								publicVariable "E_BuildingList";
							};							
						};							
				}
				
			] remoteExec ["bis_fnc_Spawn",0];		
		};	
		case "O_SAM_System_04_F":
		{
			if (isNil "DIS_SAM4") then {DIS_SAM4 = false;};
			if (DIS_SAM4) exitWith
			{
				DIS_FortificationArray pushback "B_SAM_System_02_F";
				systemChat "You already have this SAM placed!";
				deleteVehicle _Object;			
			};
			DIS_SAM4 = true;
			_Object addEventHandler ["killed",
			{
				DIS_SAM4 = false;
			}];
			_Object addEventHandler ["deleted",
			{
				DIS_SAM4 = false;
			}];			
			private _nwgrp = createGroup (side player);
			createVehicleCrew _Object;
			{[_x] joinSilent _nwgrp;_x setVariable ["DIS_PLAYERVEH",true,true];_x setVariable ["DIS_SPECIAL",true,true];} foreach (crew _Object);
			_nwgrp setVariable ["DIS_IMPORTANT",true,true];
			_Object setVariable ["DIS_SPECIAL",true,true];
			_Object setVariable ["DIS_PLAYERVEH",true,true];
			[
			[_Object,_PName,_Side,_PID],
			{
					params ["_Object","_PName","_Side","_PID"];
						if (isServer) then 
						{
							_Object setVariable ["DIS_BINFO",[_Object,"FORTIFICATION",_PID,_PName]];
							_Object allowdamage false;
							if (_Side isEqualTo West) then 
							{
								W_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];
								_Object addEventHandler ["killed",
								{
									params ["_Object", "_killer", "_instigator", "_useEffects"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									W_BuildingList = W_BuildingList - _Array;
									publicVariable "W_BuildingList";
								}];
								_Object addEventHandler ["deleted",
								{
									params ["_Object"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									W_BuildingList = W_BuildingList - _Array;
									publicVariable "W_BuildingList";
								}];
								publicVariable "W_BuildingList";
							} 
							else 
							{
								E_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];
								_Object addEventHandler ["killed",
								{
									params ["_Object", "_killer", "_instigator", "_useEffects"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									E_BuildingList = E_BuildingList - _Array;
									publicVariable "E_BuildingList";
								}];
								_Object addEventHandler ["deleted",
								{
									params ["_Object"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									E_BuildingList = E_BuildingList - _Array;
									publicVariable "E_BuildingList";
								}];	
								publicVariable "E_BuildingList";
							};							
						};							
				}
				
			] remoteExec ["bis_fnc_Spawn",0];		
		};	
		case "B_SAM_System_03_F":
		{
			if (isNil "DIS_SAM5") then {DIS_SAM5 = false;};
			if (DIS_SAM5) exitWith
			{
				DIS_FortificationArray pushback "B_SAM_System_02_F";
				systemChat "You already have this SAM placed!";
				deleteVehicle _Object;			
			};
			DIS_SAM5 = true;
			_Object addEventHandler ["killed",
			{
				DIS_SAM5 = false;
			}];
			_Object addEventHandler ["deleted",
			{
				DIS_SAM5 = false;
			}];			
			private _nwgrp = createGroup (side player);
			createVehicleCrew _Object;
			{[_x] joinSilent _nwgrp;_x setVariable ["DIS_PLAYERVEH",true,true];_x setVariable ["DIS_SPECIAL",true,true];} foreach (crew _Object);
			_nwgrp setVariable ["DIS_IMPORTANT",true,true];
			_Object setVariable ["DIS_SPECIAL",true,true];
			_Object setVariable ["DIS_PLAYERVEH",true,true];
			[
			[_Object,_PName,_Side,_PID],
			{
					params ["_Object","_PName","_Side","_PID"];
						if (isServer) then 
						{
							_Object setVariable ["DIS_BINFO",[_Object,"FORTIFICATION",_PID,_PName]];
							_Object allowdamage false;
							if (_Side isEqualTo West) then 
							{
								W_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];
								_Object addEventHandler ["killed",
								{
									params ["_Object", "_killer", "_instigator", "_useEffects"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									W_BuildingList = W_BuildingList - _Array;
									publicVariable "W_BuildingList";
								}];
								_Object addEventHandler ["deleted",
								{
									params ["_Object"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									W_BuildingList = W_BuildingList - _Array;
									publicVariable "W_BuildingList";
								}];
								publicVariable "W_BuildingList";
							} 
							else 
							{
								E_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];
								_Object addEventHandler ["killed",
								{
									params ["_Object", "_killer", "_instigator", "_useEffects"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									E_BuildingList = E_BuildingList - _Array;
									publicVariable "E_BuildingList";
								}];
								_Object addEventHandler ["deleted",
								{
									params ["_Object"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									E_BuildingList = E_BuildingList - _Array;
									publicVariable "E_BuildingList";
								}];
								publicVariable "E_BuildingList";
							};							
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
							_Object setVariable ["DIS_BINFO",[_Object,"FORTIFICATION",_PID,_PName]];
							_Object allowdamage false;
							if (_Side isEqualTo West) then 
							{
								W_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];
								_Object addEventHandler ["killed",
								{
									params ["_Object", "_killer", "_instigator", "_useEffects"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									W_BuildingList = W_BuildingList - _Array;
									publicVariable "W_BuildingList";
								}];
								_Object addEventHandler ["deleted",
								{
									params ["_Object"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									W_BuildingList = W_BuildingList - _Array;
									publicVariable "W_BuildingList";
								}];
								publicVariable "W_BuildingList";
							} 
							else 
							{
								E_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];
								_Object addEventHandler ["killed",
								{
									params ["_Object", "_killer", "_instigator", "_useEffects"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									E_BuildingList = E_BuildingList - _Array;
									publicVariable "E_BuildingList";
								}];
								_Object addEventHandler ["deleted",
								{
									params ["_Object"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									E_BuildingList = E_BuildingList - _Array;
									publicVariable "E_BuildingList";
								}];
								publicVariable "E_BuildingList";
							};							
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
							_Object setVariable ["DIS_BINFO",[_Object,"FORTIFICATION",_PID,_PName]];
							_Object allowdamage false;
							if (_Side isEqualTo West) then 
							{
								W_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];
								_Object addEventHandler ["killed",
								{
									params ["_Object", "_killer", "_instigator", "_useEffects"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									W_BuildingList = W_BuildingList - _Array;
									publicVariable "W_BuildingList";
								}];
								_Object addEventHandler ["deleted",
								{
									params ["_Object"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									W_BuildingList = W_BuildingList - _Array;
									publicVariable "W_BuildingList";
								}];
								publicVariable "W_BuildingList";
							} 
							else 
							{
								E_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];
								_Object addEventHandler ["killed",
								{
									params ["_Object", "_killer", "_instigator", "_useEffects"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									E_BuildingList = E_BuildingList - _Array;
									publicVariable "E_BuildingList";
								}];
								_Object addEventHandler ["deleted",
								{
									params ["_Object"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									E_BuildingList = E_BuildingList - _Array;
									publicVariable "E_BuildingList";
								}];	
								publicVariable "E_BuildingList";
							};							
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
							_Object setVariable ["DIS_BINFO",[_Object,"FORTIFICATION",_PID,_PName]];
							_Object allowdamage false;
							if (_Side isEqualTo West) then 
							{
								W_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];
								_Object addEventHandler ["killed",
								{
									params ["_Object", "_killer", "_instigator", "_useEffects"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									W_BuildingList = W_BuildingList - _Array;
									publicVariable "W_BuildingList";
								}];
								_Object addEventHandler ["deleted",
								{
									params ["_Object"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									W_BuildingList = W_BuildingList - _Array;
									publicVariable "W_BuildingList";
								}];
								publicVariable "W_BuildingList";
							} 
							else 
							{
								E_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];
								_Object addEventHandler ["killed",
								{
									params ["_Object", "_killer", "_instigator", "_useEffects"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									E_BuildingList = E_BuildingList - _Array;
									publicVariable "E_BuildingList";
								}];
								_Object addEventHandler ["deleted",
								{
									params ["_Object"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									E_BuildingList = E_BuildingList - _Array;
									publicVariable "E_BuildingList";
								}];
								publicVariable "E_BuildingList";
							};							
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
							_Object setVariable ["DIS_BINFO",[_Object,"FORTIFICATION",_PID,_PName]];
							_Object allowdamage false;
							if (_Side isEqualTo West) then 
							{
								W_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];
								_Object addEventHandler ["killed",
								{
									params ["_Object", "_killer", "_instigator", "_useEffects"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									W_BuildingList = W_BuildingList - _Array;
									publicVariable "W_BuildingList";
								}];
								_Object addEventHandler ["deleted",
								{
									params ["_Object"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									W_BuildingList = W_BuildingList - _Array;
									publicVariable "W_BuildingList";
								}];
								publicVariable "W_BuildingList";
							} 
							else 
							{
								E_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];
								_Object addEventHandler ["killed",
								{
									params ["_Object", "_killer", "_instigator", "_useEffects"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									E_BuildingList = E_BuildingList - _Array;
									publicVariable "E_BuildingList";
								}];
								_Object addEventHandler ["deleted",
								{
									params ["_Object"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									E_BuildingList = E_BuildingList - _Array;
									publicVariable "E_BuildingList";
								}];	
								publicVariable "E_BuildingList";
							};							
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
							_Object setVariable ["DIS_BINFO",[_Object,"FORTIFICATION",_PID,_PName]];
							_Object allowdamage false;
							if (_Side isEqualTo West) then 
							{
								W_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];
								_Object addEventHandler ["killed",
								{
									params ["_Object", "_killer", "_instigator", "_useEffects"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									W_BuildingList = W_BuildingList - _Array;
									publicVariable "W_BuildingList";
								}];
								_Object addEventHandler ["deleted",
								{
									params ["_Object"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									W_BuildingList = W_BuildingList - _Array;
									publicVariable "W_BuildingList";
								}];
								publicVariable "W_BuildingList";
							} 
							else 
							{
								E_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];
								_Object addEventHandler ["killed",
								{
									params ["_Object", "_killer", "_instigator", "_useEffects"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									E_BuildingList = E_BuildingList - _Array;
									publicVariable "E_BuildingList";
								}];
								_Object addEventHandler ["deleted",
								{
									params ["_Object"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									E_BuildingList = E_BuildingList - _Array;
									publicVariable "E_BuildingList";
								}];
								publicVariable "E_BuildingList";
							};							
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
							_Object setVariable ["DIS_BINFO",[_Object,"FORTIFICATION",_PID,_PName]];
							_Object allowdamage false;
							if (_Side isEqualTo West) then 
							{
								W_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];
								_Object addEventHandler ["killed",
								{
									params ["_Object", "_killer", "_instigator", "_useEffects"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									W_BuildingList = W_BuildingList - _Array;
									publicVariable "W_BuildingList";
								}];
								_Object addEventHandler ["deleted",
								{
									params ["_Object"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									W_BuildingList = W_BuildingList - _Array;
									publicVariable "W_BuildingList";
								}];
								publicVariable "W_BuildingList";
							} 
							else 
							{
								E_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];
								_Object addEventHandler ["killed",
								{
									params ["_Object", "_killer", "_instigator", "_useEffects"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									E_BuildingList = E_BuildingList - _Array;
									publicVariable "E_BuildingList";
								}];
								_Object addEventHandler ["deleted",
								{
									params ["_Object"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									E_BuildingList = E_BuildingList - _Array;
									publicVariable "E_BuildingList";
								}];
								publicVariable "E_BuildingList";
							};							
						};		
				}
				
				] remoteExec ["bis_fnc_Spawn",0];			
		};
    default 
		{
			systemChat "DEFAULT";
			private _Side = (side (group player));
			[
			[_Object,_PName,_Side,_PID],
			{
					params ["_Object","_PName","_Side","_PID"];
						if (isServer) then 
						{
							_Object setVariable ["DIS_BINFO",[_Object,"FORTIFICATION",_PID,_PName]];
							_Object allowdamage false;
							if (_Side isEqualTo West) then 
							{
								W_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];
								_Object addEventHandler ["killed",
								{
									params ["_Object", "_killer", "_instigator", "_useEffects"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									W_BuildingList = W_BuildingList - _Array;
									publicVariable "W_BuildingList";
								}];
								_Object addEventHandler ["deleted",
								{
									params ["_Object"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									W_BuildingList = W_BuildingList - _Array;
									publicVariable "W_BuildingList";
								}];
								publicVariable "W_BuildingList";
							} 
							else 
							{
								E_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];
								_Object addEventHandler ["killed",
								{
									params ["_Object", "_killer", "_instigator", "_useEffects"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									E_BuildingList = E_BuildingList - _Array;
									publicVariable "E_BuildingList";
								}];
								_Object addEventHandler ["deleted",
								{
									params ["_Object"];
									private _Array = _Object getVariable ["DIS_BINFO",[]];
									E_BuildingList = E_BuildingList - _Array;
									publicVariable "E_BuildingList";
								}];
								publicVariable "E_BuildingList";
							};							
						};		
				}
				
				] remoteExec ["bis_fnc_Spawn",0];				
		};
};