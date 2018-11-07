//This function will assess the potential threat of an enemy force. It should consider not just the threat from the commander, but all owned spaces.
/*
1) Distance of enemy
2) Size of enemy force (Not just the group size, but total size)
3) What kind of vehicles
4) Appropriate response
*/


private _Commander = "nil";
private _ArList = "nil";

if (_this isEqualTo West) then {_Commander = DIS_WestCommander;_ArList = W_DistArray;} else {_Commander = DIS_EastCommander;_ArList = E_DistArray;};

private _EDist = ((_ArList select 0) select 0);

//Threat levels will be on a scale of 0-10. Why? Because I can. 
private _Thr = 0;

//The response we undertake will be partly determined by distance.
//The closer the enemy, the higher the threat level.
if (_EDist >= 3000) then 
{
	_Thr = _Thr + 1;
};

if (_EDist < 3000 && _EDist >= 2000) then 
{
	_Thr = _Thr + 2;
};

if (_EDist < 2000 && _EDist >= 1000) then 
{
	_Thr = _Thr + 3;
};

if (_EDist < 1000 && _EDist >= 0) then 
{
	_Thr = _Thr + 4;
};

//Now. Let's see what kind of force we are dealing with here...This will be another heavy calculation I assume...We don't want to simply pull the group size, but all possible troops within a range roughly the same as the triggering unit.
private _Cnt = 0;
//Distance variance that we will count extra troops.
private _tol = 3500;
private _RList = [];
{
	private _ADist = _x select 0;
	private _SelCom = _x select 2;
	if (_ADist < _tol) then
	{
		if !(_SelCom in _RList) then 
		{
			_RList pushback _SelCom;
		};
		_Cnt = _Cnt + 1;
	};
	if (_Cnt > 12) exitWith {};
	true;
} count _ArList;


//Now, lets pull what KIND of vehicles we are facing...this will help the AI commanders respond with appropriate units. Experimental.
private _Inf = false;
private _Car = false;
private _Tank = false;
private _Air = false;

//Lets see how many entries we have attacking us. In this case these are groups so we need to count the units in each group.
private _RCnt = 0;
{
	{
		_RCnt = _RCnt + 1;
		if (vehicle _x isKindOf "Man") then {_Inf = true;};
		if (vehicle _x isKindOf "Car") then {_Car = true;};
		if (vehicle _x isKindOf "Tank") then {_Tank = true;};
		if (vehicle _x isKindOf "Air") then {_Air = true;};
	} count (units _x);
	true;
} count _RList;

//Lets adjust the threat level depending on the unit count.
if (_RCnt >= 50) then {_Thr = _Thr + 6;};
if (_RCnt >= 30 && _RCnt < 50) then {_Thr = _Thr + 4;};
if (_RCnt >= 10 && _RCnt < 30) then {_Thr = _Thr + 2;};
if (_RCnt >= 1 && _RCnt < 10) then {_Thr = _Thr + 1;};

//Finally lets return that threat assessment
private _Rrtn = [_Thr,[_Inf,_Car,_Tank,_Air]];

_Rrtn

	