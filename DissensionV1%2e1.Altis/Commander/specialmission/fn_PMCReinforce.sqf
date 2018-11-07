//[] call DIS_fnc_PMCParachute;
//Lets purchase some militia and have them parachute ontop of the enemy! Yay!!
//Lets make it cool by adding an awesome parachute effect.

Params ["_CSide"];

private _EComm = objNull;
private _Comm = objNull;
private _Target = ObjNull;
private _AddNewsArray = "";
private _EnemyA = [];
private _WestRun = false;
private _troops = [];

private _HC = false;
if (("HC" call BIS_fnc_getParamValue) isEqualTo 1) then 
{
	if !(isNil "HC") then
	{
		if !(isNull HC) then
		{
			_HC = true;
		};
	};
};


if (_CSide isEqualTo West) then
{
	_Comm = DIS_WestCommander;
	_EComm = DIS_EastCommander;		
	_troops = W_BarrackU;
	{
		_EnemyA pushback _x;
	} foreach (allgroups select {!(side _x isEqualTo West)});
	_WestRun = true;
	
}
else
{
	_Comm = DIS_EastCommander;	
	_EComm = DIS_WestCommander;	
	_troops = E_BarrackU;
	{
		_EnemyA pushback _x;
	} foreach (allgroups select {!(side _x isEqualTo East)});


	
};

//Send the message!
["PMC COMMANDER: UNIT REINFORCE",'#FFFFFF'] remoteExec ["MessageFramework",_CSide];	
_AddNewsArray = ["Hired Unit Para-drop",format 
[
"
	We have hired units to reinforce our troops.<br/>
"

,"Hai"
]
];
if (_WestRun) then {dis_WNewsArray pushback _AddNewsArray;publicVariable "dis_WNewsArray";} else {dis_ENewsArray pushback _AddNewsArray;publicVariable "dis_ENewsArray";};
["Beep_Target"] remoteExec ["PlaySoundEverywhere",_CSide];

//Lets spawn units on these doods!
private _Spawn = 12;
private _grp = createGroup _CSide;
_grp setVariable ["DIS_IMPORTANT",true];
private _Orgp = getpos _Comm;
private _SpwnPos = [_Orgp, 15, 250, 5, 0, 20, 0,[],[_Orgp,_Orgp]] call BIS_fnc_findSafePos;
while {_Spawn > 0} do
{
	private _unit = _grp createUnit [(selectRandom _troops) select 0,_SpwnPos, [], 25, "CAN_COLLIDE"];
	_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
	[_unit] joinSilent _grp;		
	if !(LIBACTIVATED) then {_unit call DIS_fnc_PMCUniforms};
	_Spawn = _Spawn - 1;
	sleep 2;
};

_grp setvariable ["DIS_PLAYERVEH",true];
_grp setVariable ["DIS_IMPORTANT",true];
private _waypoint = _grp addwaypoint[(getpos _EComm),1];
_waypoint setwaypointtype "MOVE";
_waypoint setWaypointSpeed "NORMAL";
private _waypoint2 = _grp addwaypoint[(getpos _EComm),1];
_waypoint2 setwaypointtype "MOVE";
_waypoint2 setWaypointSpeed "NORMAL";		
_waypoint setWaypointBehaviour "AWARE";		
_waypoint2 setWaypointBehaviour "AWARE";			
		
if (_HC) then
{
	_grp setGroupOwner (owner HC);
	_grp setVariable ["DIS_TRANSFERED",true];
};
		


