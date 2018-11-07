//[] call DIS_fnc_PMCReinforce;
//This function allows the PMC to spawn extra troops near the opponent, and have them attack

Params ["_CSide"];

private _Comm = objNull;
private _Target = ObjNull;
private _AddNewsArray = "";
private _WestRun = false;
private _EBuildinglist = [];
private _SummedOwned = [];
private _CommanderAct = nil;
private _MCaptureArray = [];
private _CommanderCall = nil;


if (_CSide isEqualTo West) then
{
	_EBuildinglist = E_BuildingList;	
	_SummedOwned = OpControlledArray;	
	_WestRun = true;
	_CommanderAct = DIS_EastCommander;
	_CommanderCall = DIS_WestCommander;
}
else
{
	_EBuildinglist = W_BuildingList;
	_SummedOwned = BluLandControlled + BluControlledArray;
	_CommanderAct = DIS_WestCommander;	
	_CommanderCall = DIS_EastCommander;	
};

//CompleteTaskResourceArray pushback [_Pole,[_CashFlowRandom,_PowerFlowRandom,_OilFlowRandom,_MaterialsFlowRandom],_Loc,_Pos];	
{
	if !((_x select 0) in _SummedOwned) then
	{
		_MCaptureArray pushback (_x select 0);
	};	
} foreach CompleteTaskResourceArray;


private _SpwnTown = [_MCaptureArray,_CommanderAct,true] call dis_closestobj;
private _SpwnPos = (getpos _SpwnTown);


//Send the message!
["PMC COMMANDER: HIRING MILITIA TO ATTACK",'#FFFFFF'] remoteExec ["MessageFramework",_CSide];
_AddNewsArray = ["Recruiting Mercenaries",format 
[
"
	We are recruiting mercenaries to attack our enemy! They will spawn at this location %1 and move to the nearest enemy.<br/>
"

,(mapGridPosition _SpwnPos)
]
];
if (_WestRun) then {dis_WNewsArray pushback _AddNewsArray;publicVariable "dis_WNewsArray";} else {dis_ENewsArray pushback _AddNewsArray;publicVariable "dis_ENewsArray";};
["Beep_Target"] remoteExec ["PlaySoundEverywhere",_CSide];


private _grp = createGroup resistance;
_grp setVariable ["DIS_IMPORTANT",true];

private _SpwnCnt = 18;
while {_SpwnCnt > 0} do
{
	private _unit = _grp createUnit [(selectRandom R_BarrackLU),_SpwnPos, [], 25, "FORM"];
	[_unit] joinSilent _grp;
	_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];								
	if !(LIBACTIVATED) then {_unit call DIS_fnc_PMCUniforms};
	_SpwnCnt = _SpwnCnt - 1;
	sleep 1;
};

private _waypoint2 = _grp addwaypoint[(getpos _CommanderAct),1];
_waypoint2 setwaypointtype "MOVE";
_waypoint2 setWaypointSpeed "NORMAL";
_waypoint2 setWaypointBehaviour "AWARE";


