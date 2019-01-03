/*
	Author: Genesis

	Description:
		Finds nearest enemy town

	Parameter(s):
		0: TERRITORY FOUND
		1: FRIENDLY TERRITORIES
		2: ENEMY TERRITORIES

	Returns:
		0: Closest enemy town
		1: Closest enemy town position
		2: Closest friendly town from enemy town (Assault FROM area)
	
	Example1: private _ReturnArray = [(_CET select 2),_FriendlyTerritory,_EnemyTerritory] call DIS_fnc_NearestETown;
	
	
	//_pole setVariable ["DIS_ASSAULTSPAWNING",true];
*/
params ["_TOWNPOLE","_FriendlyTerritory","_EnemyTerritory"];

private _UncapturedArray = [];
{
	_Flag = (_x select 0);
	if (!(_Flag in _FriendlyTerritory) && {!(_Flag getVariable ["DIS_ASSAULTSPAWNING",false])}) then
	{
		_UncapturedArray pushback (_x select 0);
	};
} foreach CompleteTaskResourceArray;


private _AssaultFrom = [_FriendlyTerritory,_TOWNPOLE,true] call dis_closestobj;
private _AttackPos = getpos _TOWNPOLE;


_rtrn = [_TOWNPOLE,_AttackPos,_AssaultFrom];
_rtrn