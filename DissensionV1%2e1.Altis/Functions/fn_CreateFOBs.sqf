/*
	Author: Genesis

	Description:
		Creates FOBs for assaulting/defending towns

	Parameter(s):
		0: FOB Position
		1: FOB Side

	Returns:
		0: FOB Structure
	Example1: [[1,2,3],East] call Dis_fnc_CreateFobs;
*/
params ["_Pos","_Side","_Pole"];

private _Prefablist = [];
private _Color = "";
private _MarkerName = "";



private _SpawnPos = [_Pos, 5, 150, 0, 0, 0.5, 0,[],[_Pos,_Pos]] call BIS_fnc_findSafePos;
private _b = "CargoNet_01_box_F" createVehicle [0,0,0];
switch (_Side) do 
{
		case west: 
		{
			_Prefablist = DIS_Barracks;
			_Color = "ColorBlue";
			_MarkerName = format["respawn_west_%1",round (random 100000)];
			DIS_WESTCAMPRESPAWN pushback [_b,"Barracks"];
			_b addEventHandler ["killed",
			{
				private _Object = _this select 0;
				_Variable1 = _Object getVariable "DIS_ObjArray";
				{
					deleteVehicle _x;
				} foreach _Variable1;				
				private _DeleteIndex = DIS_WESTCAMPRESPAWN findif {_Object isEqualTo (_x select 0)};
				if !(_DeleteIndex isEqualTo -1) then
				{
					DIS_WESTCAMPRESPAWN deleteAt _DeleteIndex;
				};			
				publicVariable "DIS_WESTCAMPRESPAWN";
				deleteVehicle _Object;
			}];
			_b addEventHandler ["deleted",
			{
				private _Object = _this select 0;
				_Variable1 = _Object getVariable "DIS_ObjArray";
				{
					deleteVehicle _x;
				} foreach _Variable1;				
				private _DeleteIndex = DIS_WESTCAMPRESPAWN findif {_Object isEqualTo (_x select 0)};
				if !(_DeleteIndex isEqualTo -1) then
				{
					DIS_WESTCAMPRESPAWN deleteAt _DeleteIndex;
				};			
				publicVariable "DIS_WESTCAMPRESPAWN";
			}];			
			W_BuildingList pushBack [_b,"Barracks"];
			publicVariable "W_BuildingList";
			publicVariable "DIS_WESTCAMPRESPAWN";
		};
		case east:
		{
			_Prefablist = DIS_EASTBarracks;
			_Color = "ColorRed";
			_MarkerName = format["respawn_east_%1",round (random 100000)];
			DIS_EASTASSAULTSPAWN pushback [_b,"Barracks"];
			_b addEventHandler ["killed",
			{
				private _Object = _this select 0;
				_Variable1 = _Object getVariable "DIS_ObjArray";
				{
					deleteVehicle _x;
				} foreach _Variable1;				
				private _DeleteIndex = DIS_EASTASSAULTSPAWN findif {_Object isEqualTo (_x select 0)};
				if !(_DeleteIndex isEqualTo -1) then
				{
					DIS_EASTASSAULTSPAWN deleteAt _DeleteIndex;
				};
				publicVariable "DIS_EASTASSAULTSPAWN";				
				deleteVehicle _Object;
			}];
			_b addEventHandler ["deleted",
			{
			
				private _Object = _this select 0;
				_Variable1 = _Object getVariable "DIS_ObjArray";
				{
					deleteVehicle _x;
				} foreach _Variable1;				
				private _DeleteIndex = DIS_EASTASSAULTSPAWN findif {_Object isEqualTo (_x select 0)};
				if !(_DeleteIndex isEqualTo -1) then
				{
					DIS_EASTASSAULTSPAWN deleteAt _DeleteIndex;
				};
				publicVariable "DIS_EASTASSAULTSPAWN";
			}];				
			E_BuildingList pushBack [_b,"Barracks"];
			publicVariable "E_BuildingList";
			publicVariable "DIS_EASTASSAULTSPAWN";
		};
		case resistance: 
		{
			_Prefablist = DIS_RESISTANCEBarracks;
			DIS_RESISTANCEASSAULTSPAWN pushback [_b,"Barracks"];
			_b addEventHandler ["killed",
			{
				private _Object = _this select 0;
				_Variable1 = _Object getVariable "DIS_ObjArray";
				private _DeleteIndex = DIS_RESISTANCEASSAULTSPAWN findif {_Object isEqualTo (_x select 0)};
				if !(_DeleteIndex isEqualTo -1) then
				{
					DIS_RESISTANCEASSAULTSPAWN deleteAt _DeleteIndex;
				};
				publicVariable "DIS_RESISTANCEASSAULTSPAWN";			
				{
					deleteVehicle _x;
				} foreach _Variable1;
				deleteVehicle _Object;
			}];
			_b addEventHandler ["deleted",
			{
				private _Object = _this select 0;
				_Variable1 = _Object getVariable "DIS_ObjArray";
				private _DeleteIndex = DIS_RESISTANCEASSAULTSPAWN findif {_Object isEqualTo (_x select 0)};
				if !(_DeleteIndex isEqualTo -1) then
				{
					DIS_RESISTANCEASSAULTSPAWN deleteAt _DeleteIndex;
				};
				publicVariable "DIS_RESISTANCEASSAULTSPAWN";				
				{
					deleteVehicle _x;
				} foreach _Variable1;
			}];				
			publicVariable "DIS_RESISTANCEASSAULTSPAWN";
			
			[_Pole,_b] spawn
			{
				params ["_Pole","_b"];
				if (isServer) then
				{
					waitUntil
					{
						sleep 5;
						_Pole getVariable ["DIS_ASSAULTENDED",false]
					};				
					_b setDamage 1;
				};			
			};
		};			
};

_b allowdamage false;
_b setpos _SpawnPos;
_b setVectorUp [0,0,1];
_b setvariable ["DIS_PLAYERVEH",true,true];
_b setVariable ["DIS_CANBLOWUP",true,true];
_b hideObjectGlobal true;


[_SpawnPos,[_Prefablist,"CmdBuild","Barracks"],_b,_Side] spawn DIS_fnc_SpawnPrefab; //_location setVariable ["DIS_ObjArray",_FinalObjArray];

//Create marker for players, so they can spawn off this structure.
if !(_Side isEqualTo resistance) then
{
	[
		[_SpawnPos,_MarkerName,_b,_Color,_Pole,_side],
		{
			params ["_SpawnPos","_MarkerName","_b","_Color","_Pole","_side"];
				if (hasInterface && {playerSide isEqualTo _side}) then
				{
					private _Marker = createMarkerlocal [_MarkerName,_SpawnPos];
					_Marker setMarkerShapelocal 'ICON';
					_Marker setMarkerColorlocal _Color;
					_Marker setMarkerAlphalocal 1;		
					_Marker setMarkerSizelocal [1,1];
					_Marker setMarkerDirlocal 0;	
					_Marker setMarkerTypelocal 'loc_Bunker';
					_Marker setMarkerTextlocal "!!ASSAULT RESPAWN!!";
					waitUntil 
					{
						sleep 5;
						_Pole getVariable ["DIS_ASSAULTENDED",false]
					};					
					deleteMarkerlocal _Marker;					
				};


				if (isServer) then
				{
					waitUntil 
					{
						sleep 5;
						_Pole getVariable ["DIS_ASSAULTENDED",false]
					};				
					_b setDamage 1;
				};
		}
	] remoteExec ["bis_fnc_Spawn",0,_b]; 	
};

_SpawnPos