/*
	Author: Genesis

	Description:
		Finds nearest resistance town

	Parameter(s):
		0: TERRITORY ARRAY

	Returns:
		0: Closest enemy town
		1: Closest enemy town position
		2: Closest friendly town from enemy town (Assault FROM area)
	
	Example1: private _ReturnArray = [_FriendlyArray] call DIS_fnc_NearestRTown;
	
	
	//_pole setVariable ["DIS_ASSAULTSPAWNING",true];
*/
params ["_FriendlyArray"];

private _UncapturedArray = [];
private _AttackPos = [0,0,0];
{
	_Flag = (_x select 0);
	if (!(_Flag in _FriendlyArray) && {_Flag in IndControlledArray} && {!(_Flag getVariable ["DIS_ASSAULTSPAWNING",false])}) then
	{
		_UncapturedArray pushback (_x select 0);
	};
} foreach CompleteTaskResourceArray;

private _CET = ([_FriendlyArray,_UncapturedArray,true] call dis_ADistC) select 0;//Returns [Distance,Array1 Object,Array2 Object];

if !(isNil "_CET") then
{
private _WinnerLand = _CET select 2;
private _AssaultFrom = _CET select 1;
_LandChosen = false;
_TownChosen = false;

if !(_WinnerLand isEqualTo []) then
{
	if (typename _WinnerLand isEqualTo "STRING") then 
	{
		_LandChosen = true;
		_AttackPos = getMarkerPos _WinnerLand;
	} 
	else 
	{
		_TownChosen = true;
		_AttackPos = getPos _WinnerLand;
	};
};

_rtrn = [_WinnerLand,_AttackPos,_AssaultFrom];
_rtrn
}
else
{
_rtrn = [0,0,0];
_rtrn
};