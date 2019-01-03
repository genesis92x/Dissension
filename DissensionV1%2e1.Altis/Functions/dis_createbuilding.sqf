private ["_BuildingArray", "_Variable", "_Structure", "_Cost", "_Side", "_Commander", "_ResourceArray", "_ComPos", "_position", "_rnd", "_dist", "_dir", "_positions", "_b", "_StructureName", "_Listofbuildings", "_Color", "_MarkerName", "_Loc", "_Marker", "_AddNewsArray"];
sleep 1;
_BuildingArray = _this select 0;
_Variable = _BuildingArray select 0;
_Structure = _BuildingArray select 2;
_Cost = _BuildingArray select 1;
_Side = _this select 1;

private _PosSAVE = _this select 2;
private _SavedStruc = false;
if (isNil "_PosSAVE") then {_PosSAVE = [0,0,0];};
if !(_PosSAVE isEqualTo [0,0,0]) then 
{ 
	_SavedStruc = true;
};

_Commander = "FREEDOM!";
_ResourceArray = "MONEYMONEYMONEY";
private _WestRun = false;
private _BuildingListU = [];
if (_Side isEqualTo West) then {_Commander = Dis_WestCommander;_WestRun = true;_BuildingListU = W_BuildingList;} else {_Commander = Dis_EastCommander;_BuildingListU = E_BuildingList;};

if (_Side isEqualTo West) then
{
	W_RArray set [0,(W_RArray select 0) - (_Cost select 0)];
	W_RArray set [1,(W_RArray select 1) - (_Cost select 1)];
	W_RArray set [2,(W_RArray select 2) - (_Cost select 2)];
	W_RArray set [3,(W_RArray select 3) - (_Cost select 3)];
}
else
{
	E_RArray set [0,(E_RArray select 0) - (_Cost select 0)];
	E_RArray set [1,(E_RArray select 1) - (_Cost select 1)];
	E_RArray set [2,(E_RArray select 2) - (_Cost select 2)];
	E_RArray set [3,(E_RArray select 3) - (_Cost select 3)];
};

private _ComPos = (getpos _Commander);

private _Locations = selectBestPlaces [_ComPos, 150, "(1 - houses) * (1 + meadow) * (1 - sea)", 1, 1];
private _Sel = (selectRandom _Locations) select 0;

private _position = _Sel findEmptyPosition [0,100,_Structure];

_rnd = random 100;
_dist = (_rnd + 100);
_dir = random 360;
_positions = [(_Sel select 0) + (sin _dir) * _dist, (_Sel select 1) + (cos _dir) * _dist, 0];
if (_position isEqualTo []) then {_position = _positions};

//_b = _Structure createVehicle [0,0,0];

private _Prefablist = [];
private _AirField = false;
if (_Side isEqualTo west) then
{
switch (_Structure) do 
{
    case "Land_Cargo_House_V1_F": 
		{
			_Prefablist = DIS_Barracks;
		};
    case "Land_Research_HQ_F": 
		{
			_Prefablist = DIS_LightVehicleFactory;		
		};
    case "Land_Cargo_House_V3_F": 
		{
			_Prefablist = DIS_Barracks;		
		};
    case "Land_BagBunker_Large_F": 
		{
			_Prefablist = DIS_HeavyVehicleFactory;	
		};
    case "Land_Research_house_V1_F": 
		{
			_Prefablist = DIS_AircraftFactory;
			_AirField = true;
		};
    case "Land_Medevac_house_V1_F": 
		{
			_Prefablist = DIS_MedicalClinic;		
		};	
    case "Land_Bunker_F": 
		{
			_Prefablist = DIS_AdvancedBarracks;		
		};			
};
}
else
{
switch (_Structure) do 
{
    case "Land_Cargo_House_V1_F": 
		{
			_Prefablist = DIS_EASTBarracks;
		};
    case "Land_Research_HQ_F": 
		{
			_Prefablist = DIS_EASTLightVehicleFactory;		
		};
    case "Land_Cargo_House_V3_F": 
		{
			_Prefablist = DIS_EASTBarracks;		
		};
    case "Land_BagBunker_Large_F": 
		{
			_Prefablist = DIS_EASTHeavyVehicleFactory;	
		};
    case "Land_Research_house_V1_F": 
		{
			_Prefablist = DIS_EASTAircraftFactory;
			_AirField = true;
		};
    case "Land_Medevac_house_V1_F": 
		{
			_Prefablist = DIS_EASTMedicalClinic;		
		};	
    case "Land_Bunker_F": 
		{
			_Prefablist = DIS_EASTAdvancedBarracks;		
		};			
};

};


_b = "CargoNet_01_box_F" createVehicle [0,0,0];
_bPos = _position;
private _Rlist = _position nearRoads 20;
if (count _Rlist > 0) then
{
	_TCnt = 0;
	_LoopyDoo = true;
	while {_LoopyDoo} do
	{
		_TCnt = _TCnt + 1;
		_rnd = random 50;
		_dist = (_rnd + 10);
		_dir = random 360;
		_positions = [(_bPos select 0) + (sin _dir) * _dist, (_bPos select 1) + (cos _dir) * _dist, 0];
		private _Rlist = _positions nearRoads 20;
		if (count _Rlist < 1 || {_TCnt > 30}) then {_LoopyDoo = false;};
		sleep 0.05;
	};


}; 

if (surfaceIsWater _positions) then
{

	_AttemptCounter = 0;
	_water = true;
	while {_water} do 
	{
		_AttemptCounter = _AttemptCounter + 1;
		_rnd = random 275;
		_dist = (_rnd + 25);
		_dir = random 360;
	
		_positions = [(_bPos select 0) + (sin _dir) * _dist, (_bPos select 1) + (cos _dir) * _dist, 0];	
		if (!(surfaceIsWater _positions) || _AttemptCounter > 50) then {_water = false;_position = _positions;};
		sleep 0.05;
	};
};


_position = [_positions, 1, 150, 0, 0, 0.1, 0,[],[_positions,_positions]] call BIS_fnc_findSafePos;
if !(_SavedStruc) then
{
	_b setpos _position;
}
else
{
	_b setposATL _PosSAVE;
	_position = _PosSAVE;
};


if (_AirField) then
{
	private _b2 = "Land_Cargo20_grey_F" createVehicle [0,0,0];
	_b2 setVariable ["DIS_PLAYERVEH",true];
	_b setVariable ["DIS_RearmBox",_b2];
	private _position2 = [_position, 5, 25, 3, 0, 10, 0,[],[_position,_position]] call BIS_fnc_findSafePos;	
	_b2 setpos _position2;
	_b2 enableSimulationGlobal false;
	_b2 allowdamage false;
	_b2 spawn GOM_fnc_addAircraftLoadoutToObject;
};


_StructureName = "Wut";


//														Barracks															LightFactory													StaticBay																	HeavyFactory													AirField														Medbay																				Advanced Units
_Listofbuildings = [["Land_Cargo_House_V1_F","Barracks"],["Land_Research_HQ_F","Light Factory"],["Land_Cargo_House_V3_F","Static Bay"],["Land_BagBunker_Large_F","Heavy Factory"],["Land_Research_house_V1_F","Air Field"],["Land_Medevac_house_V1_F","Medical Bay"],["Land_Bunker_F","Advanced Infantry Barracks"]];

{
	if (_Structure isEqualTo (_x select 0)) then
	{
		_StructureName = (_x select 1);
	};
} foreach _Listofbuildings;

private _CompareBAry = [];
{
	if (_StructureName isEqualTo (_x select 1)) then
	{
		_CompareBAry pushback (_x select 0);
	};
} foreach _BuildingListU;


private _ClosestStructure = [_CompareBAry,_position,true] call dis_closestobj;
if (_ClosestStructure distance _b < 1000) exitWith {deleteVehicle _b;};
[_position,[_Prefablist,"CmdBuild",_StructureName],_b,_Side] spawn DIS_fnc_SpawnPrefab;

_Color = "ColorBlack";
if (_Side isEqualTo West) then {_Color = "ColorBlue";_MarkerName = format["respawn_west_%1",round (random 100000)];} else {_Color = "ColorRed";_MarkerName = format["respawn_east_%1",round (random 100000)];};
_Loc = (getposASL _b);


[
[_StructureName,_Loc,_MarkerName,_Color,_Side],
{
	if !(isServer) then
	{
		params ["_StructureName","_Loc","_MarkerName","_Color","_Side"];
		waitUntil {alive player};
		if (playerSide isEqualTo _Side) then
		{
			private _Marker = "";
			if (_StructureName isEqualTo "Barracks") then {_Marker = createMarkerlocal [_MarkerName,_Loc];} else {_Marker = createMarkerlocal [format["Building_%1",_Loc],_Loc];};
			_Marker setMarkerShapelocal 'ICON';
			_Marker setMarkerColorlocal _Color;
			_Marker setMarkerAlphalocal 1;		
			_Marker setMarkerSizelocal [1,1];
			_Marker setMarkerDirlocal 0;	
			_Marker setMarkerTypelocal 'loc_Bunker';
			_Marker setMarkerTextlocal format ["%1",_StructureName];
		};
		
		
	};
}

] remoteExec ["bis_fnc_Spawn",0]; 	

if (isServer) then
{
		if (_WestRun) then
		{
			if (_StructureName isEqualTo "Barracks") then {_Marker = createMarkerlocal [_MarkerName,_Loc];W_BuildingList pushback [_b,"Barracks"];} else {_Marker = createMarkerlocal [format["Building_%1",_Loc],_Loc];W_BuildingList pushback [_b,format ["%1",_StructureName]];};
		}
		else
		{
			if (_StructureName isEqualTo "Barracks") then {_Marker = createMarkerlocal [_MarkerName,_Loc];E_BuildingList pushback [_b,"Barracks"];} else {_Marker = createMarkerlocal [format["Building_%1",_Loc],_Loc];E_BuildingList pushback [_b,format ["%1",_StructureName]];};
		};
		
	_Marker setMarkerShapelocal 'ICON';
	_Marker setMarkerColorlocal _Color;
	_Marker setMarkerAlphalocal 0;
	_Marker setMarkerSizelocal [1,1];
	_Marker setMarkerDirlocal 0;	
	_Marker setMarkerTypelocal 'loc_Bunker';
	_Marker setMarkerTextlocal format ["%1",_StructureName];		
	if (hasInterface) then 
	{
		if ((side player) isEqualTo _Side) then {_Marker setMarkerAlphaLocal 1;};
		if !(alive player) then
		{
			[_Side,_Marker] spawn
			{
				params ["_Side","_Marker"];
				
				waitUntil {alive player};
				if ((side player) isEqualTo _Side) then {_Marker setMarkerAlphaLocal 1;};
			};
		};
	};
	

	
};
if (isServer) then {[_Side,_Marker,_Loc,"Building",_StructureName,_b] call DIS_fnc_mrkersave; };

_b setVariable ["dis_Marker",[_Marker,_StructureName]];
_b setpos [(getpos _B) select 0,(getpos _B) select 1,(getpos _B) select 2];
_b setVectorUp [0,0,1];
_b setvariable ["DIS_PLAYERVEH",true];
_b hideObjectGlobal true;
//_Clear = nearestTerrainObjects [_b, ["Tree","Bush"], 200];
_Clear = nearestTerrainObjects [_b, [], 50];
{
	_x hideObjectGlobal true;
} foreach _Clear;

if (_WestRun) then
{
	_b addEventHandler ["killed",
	{
		_Variable = (_this select 0) getVariable "dis_Marker";
		_Variable1 = (_this select 0) getVariable "DIS_ObjArray";
		_Marker = _Variable select 0;
		_StructureName = _Variable select 1;
		if (_StructureName isEqualTo "Air Field") then {_Variable2 = (_this select 0) getVariable "DIS_RearmBox";deleteVehicle _Variable2;};
		deleteMarker _Marker;
		W_BuildingList = W_BuildingList - [(_this select 0),_StructureName];
		{
			deleteVehicle _x;
		} foreach _Variable1;
	}];
	
	{
		if (_Structure isEqualTo (_x select 2)) exitWith {_x set [0,true];};
	} foreach dis_ListOfBuildings;
	
	
	_AddNewsArray = ["Construction Complete",format ["We have created a new structure! This %1 will allow us to spawn troops in a better location and unlock new tech options.",_StructureName] ];
	dis_WNewsArray pushback _AddNewsArray;
	publicVariable "dis_WNewsArray";
	publicVariable "W_BuildingList";
	[West,2] call DIS_fnc_CommanderSpeak;
}
else
{
	_b addEventHandler ["killed",
	{
		_Variable = (_this select 0) getVariable "dis_Marker";
		_Variable1 = (_this select 0) getVariable "DIS_ObjArray";
		_Marker = _Variable select 0;
		_StructureName = _Variable select 1;
		deleteMarker _Marker;
		if (_StructureName isEqualTo "Air Field") then {_Variable2 = (_this select 0) getVariable "DIS_RearmBox";deleteVehicle _Variable2;};		
		E_BuildingList = E_BuildingList - [(_this select 0),_StructureName];
		{
			deleteVehicle _x;
		} foreach _Variable1;		
	}];
	
	{
		if (_Structure isEqualTo (_x select 2)) exitWith {_x set [0,true];};
	} foreach dis_EListOfBuildings;
	
	
	_AddNewsArray = ["Construction Complete",format ["We have created a new structure! This %1 will allow us to spawn troops in a better location and unlock new tech options.",_StructureName] ];
	dis_ENewsArray pushback _AddNewsArray;
	publicVariable "dis_ENewsArray";
	publicVariable "E_BuildingList";
	[East,2] call DIS_fnc_CommanderSpeak;
};
["Beep_Target"] remoteExec ["PlaySoundEverywhere",_Side];
["CONSTRUCTION COMPLETE",'#FFFFFF'] remoteExec ["MessageFramework",_Side];


