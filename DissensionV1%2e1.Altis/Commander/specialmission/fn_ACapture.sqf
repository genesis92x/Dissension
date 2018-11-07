//[] call DIS_fnc_CloseCapture;
//This function will make the AI commander seek a territory that is close, but farther away from the enemy AI. In short, expand AWAY from the enemy. IF POSSIBLE.
Params ["_CSide"];

private _Comm = objNull;
private _Buildinglist = [];
private _BarrackU = [];
private _LFactU = [];
private _HFactU = [];
private _AirU = [];
private _MedU = [];
private _AdvU = [];
private _TeamLU = [];
private _SquadLU = [];
private _CommF = objNull;
private _CommE = objNull;
private _Target = ObjNull;
private _AddNewsArray = "";
private _WestRun = false;
private _SummedOwned = [];
private _TAF = [];
private _TAE = [];
private _AttackPos = [0,0,0];
private _DefenceTerritory = [];
private _ESummedOwned = [];

if (_CSide isEqualTo West) then
{
	_BarrackU = W_BarrackU;
	_LFactU = W_LFactU;
	_HFactU = W_HFactU;
	_AirU = W_AirU;
	_MedU = W_MedU;
	_AdvU = W_AdvU;
	_TeamLU = W_TeamLU;
	_CommF = Dis_WestCommander;
	_CommE = Dis_EastCommander;
	_SquadLU = W_SquadLU;
	_TAF = West call dis_compiledTerritory;
	_TAE = East call dis_compiledTerritory;
	_WestRun = true;
	_Buildinglist = W_BuildingList;	
	_SummedOwned = BluLandControlled + BluControlledArray;	
	_ESummedOwned = OpLandControlled + OpControlledArray;
}
else
{
	_BarrackU = E_BarrackU;
	_LFactU = E_LFactU;
	_HFactU = E_HFactU;
	_AirU = E_AirU;
	_MedU = E_MedU;
	_AdvU = E_AdvU;
	_TeamLU = E_TeamLU;
	_CommE = Dis_WestCommander;
	_CommF = Dis_EastCommander;
	_SquadLU = E_SquadLU;
	_TAF = East call dis_compiledTerritory;
	_TAE = West call dis_compiledTerritory;
	_Buildinglist = E_BuildingList;
	_SummedOwned = OpLandControlled + OpControlledArray;
	_ESummedOwned = BluLandControlled + BluControlledArray;
};

// The first thing we need to do is locate what area we want to capture.
//CompleteRMArray pushback [_Marker,_FinalSelection,_x,false,_location];
//CompleteTaskResourceArray pushback [_Pole,[_CashFlowRandom,_PowerFlowRandom,_OilFlowRandom,_MaterialsFlowRandom],_Loc,_Pos];


//Lets compile all the capturable territories that are within a certain distance of each commander.
private _AttackArray = [];
private _EAttackArray = [];
{
	if (!((_x select 0) in _SummedOwned) && _CommF distance (_x select 0) < 3000) then
	{
		_AttackArray pushback (_x select 0);
	};	
	
	/*
	if (!((_x select 0) in _ESummedOwned) && _CommE distance (_x select 0) < 3000) then
	{
		_EAttackArray pushback (_x select 0);
	};		
	*/
	
} foreach CompleteTaskResourceArray;
	
	
{
	if (!((_x select 2) in _SummedOwned) && {_CommF distance (getMarkerPos (_x select 2)) < 3000}) then
	{
		_AttackArray pushback (_x select 4);
	};
	
	/*
	if (!((_x select 2) in _ESummedOwned) && {_CommE distance (getMarkerPos (_x select 2)) < 3000}) then
	{
		_EAttackArray pushback (_x select 4);
	};
	*/
	
	
} foreach CompleteRMArray;

//We need a location that is close to the defensive commander, but a good distance away from the enemy.
{
	private _Loc = _x;
	private _LocD = _x distance _CommF;

	if (_LocD > (_Loc distance _CommE)) then
	{
		_AttackArray = _AttackArray - [_Loc];
	};
	
} foreach _AttackArray;


private _ClosestTerrFriend = [_TAF,_AttackArray,true] call dis_ADistC;
private _ClosestFinal = getpos (_ClosestTerrFriend select 0 select 2);

_AdditionalMessage = "This location appears to be the safest to capture.";
[_CSide,12,0,0,0,0,_ClosestFinal,_AdditionalMessage] spawn dis_recruitunits;	