//Pressing that recuit button!

//Are we close enough to recruit? And lets pull that recruit locationNull
private _Structures = "";
if ((side player) isEqualTo West) then
{
	_Structures = W_BuildingList;
}
else
{
	_Structures = E_BuildingList;
};

if (isNil "_Structures") exitWith
{
	_DI = "NOT INITIALIZED YET...COME BACK SOON.";
	hint format ["%1", _DI];
};

private _BarrackList = [];
{
	_Building = _x select 0;
	if !(isNil "_Building") then
	{
		_Type = _x select 1;
		if (_Type isEqualTo "Barracks") then {_BarrackList pushback (_x select 0);};
	};
} foreach _Structures;

if (_BarrackList isEqualTo []) exitWith
{
	_DI = "NO BARRACKS CREATED";
	hint format ["%1", _DI];
};

_NearestBuilding = [_BarrackList,player,true] call dis_closestobj;
if (_NearestBuilding distance player > 100) exitWith
{
	_DI = "TOO FAR FROM BARRACKS";
	hint format ["%1", _DI];
};



//We need to figure out what we need to do...does the unit spawn into the player group, or it's own group?
_tree = ((findDisplay 30000) displayCtrl (30600));
_sel = tvCurSel _tree;
_Classname = _tree tvData _sel;
_Cost = (_tree tvValue _sel);



if (DIS_PCASHNUM - _Cost < 0) exitWith {hint "You don't have enough cash!";if (playerSide isEqualTo west) then {playsound "EVAInsufficentFunds"} else {playsound "LEGIONInsufficentFunds"};};


private _PlayGroupLimit = "AIMaxInPlayerGroup" call BIS_fnc_getParamValue;
private _HighCommandLimit = "AIMaxInHighCommand" call BIS_fnc_getParamValue;
private _MaxRecruit = ((DIS_LvlA select 2) select 0);

if (_this select 0 isEqualTo 1) then
{
	if !((leader (group player)) isEqualTo player) exitWith {hint "You are not the squad leader!";};
	private _CountA = 0;
	{
		if !(isplayer _x) then
		{
			_CountA = _CountA + 1;
		};
	} foreach (units (group player));

	if (_PlayGroupLimit < (_CountA + 1)) exitWith {hint "Maxed AI reached!"};
	if (_MaxRecruit < (_CountA + 1)) exitWith {hint "Maxed AI reached!"};
	
	private _spos = (getpos _NearestBuilding);
	private _pos = [_spos, 15, 150, 5, 0, 20, 0,[],[_spos,_spos]] call BIS_fnc_findSafePos;	
	private _AI = (group player) createUnit [_Classname,_pos, [], 0, "CAN_COLLIDE"];
	(group player) setVariable ["DIS_IMPORTANT",true,true];
	DIS_PCASHNUM = DIS_PCASHNUM - _Cost;
	playsound "Purchase";	
}
else
{

	if ((Count Dis_PSpwnedCnt) > (_HighCommandLimit - 1)) exitWith {hint "Maxed AI reached!"};

	private _NewGroup = grpNull;
	private _ClosestUnit = "";

	if (count Dis_PSpwnedCnt > 0) then
	{
		_ClosestUnit = [Dis_PSpwnedCnt,(getpos _NearestBuilding),true] call dis_closestobj;
		if (_ClosestUnit distance (getpos _NearestBuilding) < 100) then
		{
			_NewGroup = (group _ClosestUnit);
		};
	}
	else
	{
		_NewGroup = createGroup playerside;
	};



	private _spos = (getpos _NearestBuilding);
	if (isNil "_NewGroup") then {_NewGroup = createGroup playerside;};
	private _pos = [_spos, 15, 150, 5, 0, 20, 0,[],[_spos,_spos]] call BIS_fnc_findSafePos;	
	private _AI =  _NewGroup createUnit [_Classname,_pos, [], 0, "CAN_COLLIDE"];
	_AI addEventHandler ["killed", {Dis_PSpwnedCnt = Dis_PSpwnedCnt - [(_this select 0)];}];
	Dis_PSpwnedCnt pushback _AI;
	DIS_PCASHNUM = DIS_PCASHNUM - _Cost;
	playsound "Purchase";
	_NewGroup setVariable ["DIS_IMPORTANT",true,true];

};
