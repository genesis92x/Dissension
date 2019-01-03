params ["_list","_object","_order","_script"];

if (isNil "_script") then {_script = "Nil";};
//systemchat format ["%1",_object];
//_order = true, means closest first
//[_list,_object,_order,"SCRIPT1"] call dis_closestobj;

//Remove self from list, if applicable
private _Index = _list findIf {_x isEqualTo _object};
if (_Index > -1) then {_list deleteAt _Index;};

private _position = [0,0,0];
if (isNil "_object" || {isNil "_list"}) exitWith {_ClosestObject = [0,0,0];_ClosestObject};

switch (TypeName _object) do 
{
		case "OBJECT": {_position = getPosATL _object;};
		case "STRING": {_position = getMarkerPos _object;};
		case "ARRAY": {_position = _object;};
		case "GROUP": {_position = (getPosATL (leader _object));};
};

private _DistanceArray = [];
private _NewObjectDistance = 0;
{
	if !(isNil "_x") then
	{
		_CompareObjectPos = [0,0,0];
		switch (TypeName _x) do 
		{
				case "OBJECT": {_CompareObjectPos = getPosATL _x;};
				case "STRING": {_CompareObjectPos = getMarkerPos _x;};
				case "ARRAY": {_CompareObjectPos = _x;};
				case "GROUP": {_CompareObjectPos = (getPosATL (leader _x));};
		};
		_NewObjectDistance = _CompareObjectPos distance2D _position;
		_DistanceArray pushback [_NewObjectDistance,_x];
	};
} foreach _list;

_DistanceArray sort _order;

_ClosestObject = ((_DistanceArray select 0) select 1);

if (isNil "_ClosestObject") then {_ClosestObject = [0,0,0];};
_ClosestObject