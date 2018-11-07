//This function will return a randomly generated point within the given parameters.
//_this select 0 = object
//_this select 1 = random distance
//_this select 2 = minimum distance
// [_b,15,10] call dis_randompos;
params ["_obj","_rndd","_mind"];

private _ComPos = [0,0,0];
if (typeName _obj isEqualTo "ARRAY") then {_ComPos = _obj} else {_Compos = getpos _obj;};
if (_ComPos isEqualTo [0,0,0]) exitWith {};
private _rnd = random _rndd;
private _dist = (_rnd + _mind);
private _dir = random 360;
private _positions = [(_ComPos select 0) + (sin _dir) * _dist, (_ComPos select 1) + (cos _dir) * _dist, 0];
_Finalposition = [_positions, 1, 50, 5, 0, 20, 0,[],[_positions,_positions]] call BIS_fnc_findSafePos;
_Finalposition = [(_Finalposition select 0),(_Finalposition select 1),(_ComPos select 2)];

_Finalposition