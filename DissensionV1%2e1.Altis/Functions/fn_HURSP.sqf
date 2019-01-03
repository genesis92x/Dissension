//Function for monitoring players and attacking them appropriately.
private _EnemySide = East;
if (_this isEqualTo West) then {W_CurrentDWNHU = false;} else {E_CurrentDWNHU = false;_EnemySide = West;};

private _EOUnits = [];
private _HeavySpwn = 0;
private _LightSpwn = 0;
private _HeliSpwn = 0;
private _AirSpwn = 0;
private _InfPresence = 12;
private _PArty = [];
private _TTLCnt = 0;

if (_this isEqualTo West) then
{
	private _AirLst = E_AirU;
	private _VehLst = E_HFactU;
}
else
{
	private _AirLst = W_AirU;
	private _VehLst = W_HFactU;
};

{
	if !((side (group _x)) isEqualTo _this) then
	{
		_EOUnits pushback _x;
	};	
} forEach allPlayers;

private _CETer = _EnemySide call DIS_fnc_ClstET;
private _CETDist = _CETer select 1;
private _CETPos = _CETer select 0;

private _ClosestEn = [_EOUnits,_CETPos,true] call dis_closestobj;

{
	if (_x distance2D _CETPos < 2000) then
	{
		if ((vehicle _x) isKindOf "Tank") then {_HeavySpwn = _HeavySpwn + 2;}; 
		if ((vehicle _x) isKindOf "Car") then {_LightSpwn = _LightSpwn + 2;}; 
		if ((vehicle _x) isKindOf "Helicopter") then {_HeliSpwn = _HeliSpwn + 2;}; 
		if ((vehicle _x) isKindOf "Plane") then {_AirSpwn = _AirSpwn + 2;}; 
		if ((vehicle _x) isKindOf "Man") then {_InfPresence = _InfPresence + 6;}; 
		_TTLCnt = _TTLCnt + 1;
		private _Txt = getNumber(configfile >> "CfgVehicles" >> (typeOf (vehicle _x)) >> "artilleryScanner");
		if (_Txt isEqualTo 1) then
		{
			_PArty pushback _x;
		};	
	};

} foreach _EOUnits;

if (_TTLCnt < 1) exitWith 
{
	if (_this isEqualTo West) then {[] spawn {sleep 60;W_CurrentDWNHU = true;};} else {[] spawn {sleep 60;E_CurrentDWNHU = true;};};
};

if (_InfPresence > 24) then {_InfPresence = 24};
[_this,_InfPresence,_LightSpwn,_HeavySpwn,_HeliSpwn,_AirSpwn,(getpos _ClosestEn),"Deploying troops to meet player forces.",true] spawn dis_recruitunits;
[_this,9] call DIS_fnc_CommanderSpeak;

sleep 30;
if (count _PArty > 0) then 
{
	private _ClstArty = [_PArty,_CETPos,true] call dis_closestobj;
	[_this,0,0,0,2,2,(getpos _ClstArty),"Deploying aircraft to deal with player artillery units.",true] spawn dis_recruitunits;
};

if (_this isEqualTo West) then {[] spawn {sleep 1200;W_CurrentDWNHU = true;};} else {[] spawn {sleep 1200;E_CurrentDWNHU = true;};};
