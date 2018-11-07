//Function runs when the plays chooses to purchase a vehicle.
private _index = lbCurSel 1500;
private _VehType = lbData [1500,_index];

if (isNil "_VehType") exitWith {};

//Lets create a marker near the closest structure. For now it doesn't matter what the structure is - as long as the necessary buildings are available.
private _HeavyFactory = false;
private _LightFactory = false;
private _Aircraft = false;
private _PlayerSide = "I FIGHT FOR NO MAN";
private _BuildingList = "NO BUILDINGS FOR CHU";

if (side (group player) isEqualTo WEST) then
{
	_Playerside = "West";
	_BuildingList = W_BuildingList;
}
else
{
	_Playerside = "East";
	_BuildingList = E_BuildingList;
};

private _BuildingA = [];
{
	private _StructureName = _x select 1;
	private _Structure = _x select 0;
	_BuildingA pushback _Structure;
	if (_StructureName isEqualTo "Light Factory") then {_LightFactory = true;};
	if (_StructureName isEqualTo "Heavy Factory") then {_HeavyFactory = true;};

} foreach _BuildingList;

private _ClosestStructure = [_BuildingA,(getpos player),true] call dis_closestobj;

private _ClosestStructureP = getpos _ClosestStructure;
private _rnd = random 100;
private _dist = (_rnd + 25);
private _dir = random 360;

private _position = [(_ClosestStructureP select 0) + (sin _dir) * _dist, (_ClosestStructureP select 1) + (cos _dir) * _dist, 0];

private _list = _position nearRoads 1000;
private _CRoad = [];
if !(_list isEqualTo []) then
{
	_CRoad = getpos ([_list,_position,true] call dis_closestobj);
}
else
{
	_CRoad = _position;
};
		
private _positionFIN = _CRoad findEmptyPosition [0,150,"B_Heli_Transport_03_F"];	
if (_positionFIN isEqualTo []) then {_positionFIN = _CRoad};	



private _CashAmount = 0;
if (_vehType in CfgCarsArray) then {_CashAmount = _CashAmount + 300;};
if (_vehType in CfgLightArmorsArray) then {_CashAmount = _CashAmount + 500;};
if (_vehType in CfgHeavyArmorsArray) then {_CashAmount = _CashAmount + 1000;};
if (_vehType in CfgHelicoptersArray) then {_CashAmount = _CashAmount + 700;};
if (_vehType in CfgPlanesArray) then {_CashAmount = _CashAmount + 1500;};
if (_vehType in CfgBoatsArray) then {_CashAmount = _CashAmount + 250;};
if (_vehType in CfgUGVArray) then {_CashAmount = _CashAmount + 325;};
if (_vehType in CfgUAVArray) then {_CashAmount = _CashAmount + 325;};
if !(_Defined) then {_CashAmount = _CashAmount + 250;};	
private _PreviewCost = DIS_PCASHNUM - _CashAmount;

if (_PreviewCost < 0) exitWith {};
		
closeDialog 3016;

		
private _dis_new_veh = objNull;
if (_vehType isKindOf "Air") then 
{
	Hint "AIR";
	_dis_new_veh = createVehicle [ _vehType, _positionFIN, [], 0, "FLY" ];

	if (_vehType isKindOf "Plane") then 
	{
		_vel = velocity _dis_new_veh;
		_dir = direction _dis_new_veh;
		_speed = 1000;
		_dis_new_veh setVelocity [
			(_vel select 0) + (sin _dir * _speed), 
			(_vel select 1) + (cos _dir * _speed), 
			(_vel select 2)
		];
		_dis_new_veh setPosATL [ ( position _dis_new_veh select 0 ), ( position _dis_new_veh select 1 ),800];	
		//_add = _dis_new_veh spawn GOM_fnc_addAircraftLoadoutToObject;		
	};
}
else
{
	Hint "LAND";
	_dis_new_veh = createVehicle [ _vehType,_positionFIN, [], 0, "CAN_COLLIDE" ];
};
_dis_new_veh allowdamage false;
_dis_new_veh spawn {sleep 30; _this allowdamage true;};

		
player allowdamage false;
		

DIS_PCASHNUM = DIS_PCASHNUM - _CashAmount;

player moveinDriver _dis_new_veh;
playsound "Purchase";

[] spawn {sleep 10;player allowdamage true;};
	