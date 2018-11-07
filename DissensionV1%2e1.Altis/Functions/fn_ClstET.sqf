//West call DIS_fnc_ClstET;
//Pulling the closest owned territory
Params ["_Side"];
private _FriendlyOwned = [];
private _EnemyOwned = [];

if (_Side isEqualTo West) then
{
	_FriendlyOwned = BluLandControlled + BluControlledArray;
	_EnemyOwned = OpLandControlled + OpControlledArray;
}
else
{
	_FriendlyOwned = OpLandControlled + OpControlledArray;
	_EnemyOwned = BluLandControlled + BluControlledArray;	
};
private _NearestPos = [0,0,0];


private _ClosestEA = [_FriendlyOwned,_EnemyOwned,true] call dis_ADistC;
private _ClosestE = _ClosestEA select 0 select 2;
private _Dist = _ClosestEA select 0 select 0;
if !(_ClosestE isEqualTo []) then
{
	if (typename _ClosestE isEqualTo "STRING") then 
	{
		_LandChosen = true;
		_NearestPos = getMarkerPos _ClosestE;
	} 
	else
	{
		_TownChosen = true;
		_NearestPos = getPos _ClosestE;
	};
};

private _rtna = [_NearestPos,_Dist];

_rtna