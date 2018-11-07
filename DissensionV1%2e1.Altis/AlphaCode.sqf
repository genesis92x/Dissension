private _AttackPos = [0,0,0];
private _SummedOwned = BluLandControlled + BluControlledArray;
private _MCaptureArray = [];

{
	if !((_x select 0) in _SummedOwned) then
	{
		_MCaptureArray pushback (_x select 0);
	};	
} foreach CompleteTaskResourceArray;


{
	if !((_x select 2) in _SummedOwned) then
	{
		private _CFT = [_SummedOwned,(_x select 2),true] call dis_closestobj;
		if (typename _CFT isEqualTo "STRING") then {_CFT = (getMarkerPos _CFT)};
		if (_CFT distance2D (getMarkerPos (_x select 2)) < 1001) then
		{ 
			_MCaptureArray pushback (_x select 2);
		};
	};	
} foreach CompleteRMArray;
	
	systemChat format ["%1",_MCaptureArray];
	
private _WinnerLand = ([_MCaptureArray,_this,true] call dis_closestobj);
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
