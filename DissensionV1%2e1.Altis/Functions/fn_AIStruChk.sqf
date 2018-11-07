//Function for monitoring structures for AI. When AI get too close, for an extended period of time, the structure is destroyed. This is how the AI will *Kill* the commander.
//For players - players will be able to plant "satchels" on structures - which will cause a warning, where players will have 5 minutes to defuse the bomb.

//We want to constantly monitor every structure and check for the nearest enemy.
if (isNil "W_BuildingList") exitWith {};
if (isNil "E_BuildingList") exitWith {};
private _EnA = (allunits select {side _x isEqualTo East});
_Ena = _Ena - allplayers;

//Structures only array
private _SArray = [];
{
	_SArray pushback (_x select 0);
} foreach W_BuildingList;

{
	private _Cst = [_SArray,_x,true] call dis_closestobj;	
	if (_Cst distance2D _x < 100 && {!(_Cst getVariable ["DIS_StrB",false])} && {!(_x getVariable ["DIS_BMBUNIT",false])}) then
	{
		_x doMove (getPos _Cst);
		_x setVariable ["DIS_BMBUNIT",true];
		_x spawn {sleep 30;_this setVariable ["DIS_BMBUNIT",false];};
		[_x,_Cst] spawn 
		{
			params ["_U","_S"];
			private _Y = true;
			while {alive _U && {_Y}} do
			{
				if (_U distance2D _S < 15) then
				{
					[_U,_S] spawn DIS_fnc_StrBomb;
					_Y = false;
				};
				sleep 5;
			};
		};		
	};	
	
} foreach _EnA;



private _EnA = (allunits select {side _x isEqualTo West});
_Ena = _Ena - allplayers;

//Structures only array
private _SArray = [];
{
	_SArray pushback (_x select 0);
} foreach E_BuildingList;

{
	private _Cst = [_SArray,_x,true] call dis_closestobj;	
	if (_Cst distance2D _x < 100 && {!(_Cst getVariable ["DIS_StrB",false])} && {!(_x getVariable ["DIS_BMBUNIT",false])}) then
	{
		_x doMove (getPos _Cst);
		_x setVariable ["DIS_BMBUNIT",true];
		_x spawn {sleep 30;_this setVariable ["DIS_BMBUNIT",false];};
		[_x,_Cst] spawn 
		{
			params ["_U","_S"];
			private _Y = true;
			while {alive _U && {_Y}} do
			{
				if (_U distance2D _S < 15) then
				{
					[_U,_S] spawn DIS_fnc_StrBomb;
					_Y = false;
				};
				sleep 5;
			};
		};		
	};	
	
} foreach _EnA;