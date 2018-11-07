//Created on ???
// Modified on : 8/19/14 - 8/3/15

private _Unit = _this;
private _UnitSide = (side _Unit);
private _Array1 = [];
{
	_TargetSide = side _x;
	if ([_UnitSide, _TargetSide] call BIS_fnc_sideIsEnemy) then {_Array1 pushback _x;};
} forEach allUnits;

private _ReturnedEnemy = [_Array1,_Unit,true] call dis_closestobj;
if (isNil "_ReturnedEnemy") then {_ReturnedEnemy = [0,0,0]};

//_Unit setVariable ["VCOM_CLOSESTENEMY",_ReturnedEnemy,false];
_ReturnedEnemy