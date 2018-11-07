private ["_Side", "_GroupsWanted", "_AdditionalMessage", "_ActualGroups", "_ResponseTeam", "_grp", "_b", "_waypoint", "_waypoint2", "_AddNewsArray"];

_Side = _this select 0;
_GroupsWanted = _this select 1;
_TotalInfWanted = _GroupsWanted * 8;
_Target = _this select 2;
_AdditionalMessage = _this select 3;

private _WestRun = false;
if (_Side isEqualTo West) then
{
	_WestRun = true;
};

_ActualTroops = 0;
_ActualGroups = [];
_ResponseTeam = [];

if (_WestRun) then
{
	{
		_grp = (group _x);
		if !(_grp in _ActualGroups) then {_ActualGroups pushback _grp};
	} foreach W_ActiveUnits;
}
else
{
	{
		_grp = (group _x);
		if !(_grp in _ActualGroups) then {_ActualGroups pushback _grp};
	} foreach E_ActiveUnits;
};


//Lets have groups with less than 4 units join together.
{

	if (count (units _x) < 4) then
	{

		_ClosestGroup = [(_ActualGroups - [_x]),(leader _x),true] call dis_closestobj;

		if ((leader _ClosestGroup) distance (leader _x) < 1000) then
		{
			{
				[_x] joinSilent _ClosestGroup;
				true;
			} count (units _x);			
		};
	};
	true;
} count _ActualGroups;



{
	_leader = leader _x;
	if (((velocity _leader) select 0) < 1) then {_ResponseTeam pushback _x;{_ActualTroops = _ActualTroops + 1;} foreach (units _x);};
} foreach _ActualGroups;

/*
if (count _ResponseTeam < _GroupsWanted || {_ActualTroops < _TotalInfWanted}) then 
{
	[_Side,11,_Target,_AdditionalMessage] spawn dis_recruitunits;
};
*/

 if (count _ResponseTeam isEqualTo 0) then {_ResponseTeam = _ActualGroups;};
 
{
		
		sleep 1;
		_waypoint = _x addwaypoint[_Target,1];
		_waypoint setwaypointtype "MOVE";
		_waypoint setWaypointSpeed "NORMAL";
		_waypoint setWaypointBehaviour "AWARE";
		//_x setCurrentWaypoint [_x,(_waypoint select 1)];		
		_waypoint2 = _x addwaypoint[_Target,1];
		_waypoint2 setwaypointtype "MOVE";
		_waypoint2 setWaypointSpeed "NORMAL";
		_waypoint2 setWaypointBehaviour "AWARE";
		_x setBehaviour "AWARE";
		//[_x,_position] spawn {_Grp = _this select 0;_Pos = _this select 1;sleep 60;_WaypointReached = true;while {({alive _x} count (units _Grp)) > 0 && _WaypointReached} do {if (((leader _grp) distance _Pos) < 50) then {while {(count (waypoints _grp)) > 0} do {deleteWaypoint ((waypoints _grp) select 0);sleep 0.25;};_WaypointReached = false;};};};
		//[_x,_position] spawn dis_WTransportMon;
} foreach _ResponseTeam;


	_AddNewsArray = ["Attacking Target",
	format
	[
	"
	We are currently targeting %1 with %2 groups.<br/>
	%3
	"
	,(mapGridPosition _Target),count _ResponseTeam,_AdditionalMessage
	]
	];
	if (_WestRun) then {dis_WNewsArray pushback _AddNewsArray;publicVariable "dis_WNewsArray";} else {dis_ENewsArray pushback _AddNewsArray;publicVariable "dis_ENewsArray";};
	
	
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",_Side];
	["TARGET ACQUIRED",'#FFFFFF'] remoteExec ["MessageFramework",_Side];	
	