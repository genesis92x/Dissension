private ["_Logic", "_Chosenarray", "_CompleteObjectArray", "_PosCheck", "_PosCheckX", "_PosCheckY", "_class", "_objZ", "_objectXadd", "_objectYadd", "_playerposX", "_playerposY", "_Objectdamage", "_newobjectX", "_newobjectY", "_object", "_newpos", "_newpos2", "_DirectionCheck", "_newobjectpos", "_BoundingArray", "_p1", "_p2", "_maxWidth", "_maxLength", "_SendArray"];
//[(getpos player),["Power",25],player] spawn DIS_fnc_SpawnPrefab;
//Creates objects that are given within an array.
//_FinalSelection = ["Materials",_MaterialsFlowRandom];
_SpwnLoc = _this select 0;
private _Type = ((_this select 1) select 0);
private _TypeValue = ((_this select 1) select 1);
private _StructureName = ((_this select 1) select 2);
if (isNil "_StructureName") then {_StructureName = ""};
private _FinalImage = "";
private _location = _this select 2;
private _Side = _this select 3;
private _FinalObjArray = [];
private _ObjArray = [];
private _Clear = nearestTerrainObjects [_SpwnLoc, [], 25];
{
	_x hideObjectGlobal true;
} foreach _Clear;

if !(_TypeValue isEqualTo "CmdBuild") then
{

switch (_Type) do 
{
    case "Materials": 
		{
			if (_TypeValue < 11) then	{_ObjArray = DIS_MaterialsCamp1;};
			if (_TypeValue >= 11 && {_TypeValue <= 20}) then	{	_ObjArray = DIS_MaterialsCamp2;	};
			if (_TypeValue > 20) then	{_ObjArray = DIS_MaterialsCamp3;};
		};
    case "Fuel": 
		{
			if (_TypeValue < 11) then 
			{
				_ObjArray = DIS_OilCamp1;
			};
			if (_TypeValue >= 11 && {_TypeValue <= 20}) then
			{
				_ObjArray = DIS_OilCamp2;
			};
			if (_TypeValue > 20) then
			{
				_ObjArray = DIS_OilCamp3;
			};		
		};
    case "Power": 
		{
			if (_TypeValue < 11) then 
			{
				_ObjArray = DIS_PowerCamp1;
			};
			if (_TypeValue >= 11 && {_TypeValue <= 20}) then
			{
				_ObjArray = DIS_PowerCamp2;
			};
			if (_TypeValue > 20) then
			{
				_ObjArray = DIS_PowerCamp3;
			};			
		};
    case "Cash": 
		{
			if (_TypeValue < 11) then 
			{
				_ObjArray = DIS_CashCamp1;
			};
			if (_TypeValue >= 11 && {_TypeValue <= 20}) then
			{
				_ObjArray = DIS_CashCamp2;
			};
			if (_TypeValue > 20) then
			{
				_ObjArray = DIS_CashCamp3;
			};			
		};
};
}
else
{
	//_Listofbuildings = [["Land_Cargo_House_V1_F","Barracks"],["Land_Research_HQ_F","Light Factory"],["Land_Cargo_House_V3_F","Static Bay"],["Land_BagBunker_Large_F","Heavy Factory"],["Land_Research_house_V1_F","Air Field"],["Land_Medevac_house_V1_F","Medical Bay"],["Land_Bunker_F","Advanced Infantry Barracks"]];
	switch (_StructureName) do 
	{
			case "Barracks": 
			{
				_FinalImage = "Pictures\TFRB.jpg";
			};
			case "Light Factory": 
			{
				_FinalImage = "Pictures\TFRLVF.jpg";
			};
			case "Static Bay": 
			{
				_FinalImage = "";
			};
			case "Heavy Factory": 
			{
				_FinalImage = "Pictures\TFRHVF.jpg";
			};
			case "Air Field": 
			{
				_FinalImage = "Pictures\TFRAIR.jpg";
			};
			case "Medical Bay": 
			{
				_FinalImage = "Pictures\TFRMED.jpg";
			};
			case "Advanced Infantry Barracks": 
			{
				_FinalImage = "";
			};

	};
	_ObjArray = _Type;
};


_CompleteObjectArray = [];
_PosCheckX = _SpwnLoc select 0;
_PosCheckY = _SpwnLoc select 1;

{
_class = (_x select 0);
_objZ = (_x select 5);
_objectXadd = (_x select 3);
_objectYadd = (_x select 4);
_playerposX = (_x select 6 select 0);
_playerposY = (_x select 6 select 1);
_Objectdamage = _x select 7;
_newobjectX = [];
_newobjectY = [];

if (_playerposX > _PosCheckX) then {_newobjectX = _PosCheckX - _objectXadd};
if (_playerposX < _PosCheckX) then {_newobjectX = _PosCheckX - _objectXadd};
if (_playerposY > _PosCheckY) then {_newobjectY = _PosCheckY - _objectYadd};
if (_playerposY < _PosCheckY) then {_newobjectY = _PosCheckY - _objectYadd};




_newobjectpos = [_newobjectX,_newobjectY,_objZ];
//_object = _class createVehicle [0,0,0];
_object = createSimpleObject [_class,_newobjectpos]; 
_CompleteObjectArray pushback _object;
//_object enableSimulationGlobal false;
_object allowdamage false;
_object lock 2;


sleep 0.001;
_object setposATL _newobjectpos;
_object setDir (_x select 1);

_BoundingArray = boundingBoxReal _object;
_p1 = _BoundingArray select 0;
_p2 = _BoundingArray select 1;
_maxWidth = abs ((_p2 select 0) - (_p1 select 0));
_maxLength = abs ((_p2 select 1) - (_p1 select 1));

if ((_maxWidth > 4)&& ((_maxLength) > 4)) then {

_object setPos (getpos _object);

};

_object setVectorUp surfaceNormal position _object;
//_object setVectorUP (surfaceNormal [(getPosATL _object) select 0,(getPosATL _object) select 1]);  
//_object enableSimulation true;
sleep 0.001;
//_object allowdamage true;
_object setDamage _Objectdamage;
_object setvariable ["DIS_PLAYERVEH",true];
_FinalObjArray pushback _object;
} foreach (_ObjArray select 0);

_location setVariable ["DIS_ObjArray",_FinalObjArray];

if (_StructureName isEqualTo "Barracks") then
{
	
	if (_Side isEqualTo West) then
	{
		private _objects = nearestObjects [_SpwnLoc, [],25];
		{
				if (typeOf _x isEqualTo "Land_MedicalTent_01_white_generic_open_F") then
				{
					[_x] spawn
					{
						sleep 5;
						params ["_Sign"];
						[
						[_Sign],
						{
								params ["_Sign"];
								sleep 10;
								_Sign setObjectTexture [0,"\A3\Structures_F_Orange\Humanitarian\Camps\Data\MedicalTent_01_tropic_F_CO.paa"];
						}
						] remoteExec ["bis_fnc_spawn",0,_Sign];		
					};
				};	
		} foreach _objects;
	};
};


[_SpwnLoc,_FinalImage,_StructureName] spawn
{
	params ["_SpwnLoc","_FinalImage","_StructureName"];
	sleep 5;
	private _objects = nearestObjects [_SpwnLoc, [],25];
	{
		if (typeOf _x isEqualTo "SignAd_Sponsor_ARMEX_F") then
		{
			[
			[_x,_FinalImage],
			{
					params ["_Sign","_FinalImage"];
					sleep 10;
					_Sign setObjectTexture [0,_FinalImage];
			}
			] remoteExec ["bis_fnc_spawn",0,_x];				
		};
			
		
	} foreach _objects;
};

/*
_SendArray = DIS_TestObj select 1;
if ((count _SendArray) > 0) then 
{
	[_SendArray,_Logic] spawn DIS_CreatePeople.sqf;
};
*/