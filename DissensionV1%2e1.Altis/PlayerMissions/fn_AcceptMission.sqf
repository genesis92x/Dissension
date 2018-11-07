//_this = [Control #27100,[3,1]]
//["TEST","WEEE ARE THE CHAMPIONS MY FRIENDS.",[],["Test","Test"]]
//  		select 0														select 1																																																			select 2								s3		s4
//['SUPPLY POINT',format ['The supply point, located at %1, is full and needs transport to the nearest structure.',(mapGridPosition _Building)],[(netId _Building),_ReturnLocPos],[],DIS_MissionID];

//We need to check 2 things. First, does the group ALREADY have an assigned task? Second, is this the SQUAD LEADER accepting the task?


private _PGroup = group player;
if !(leader _PGroup isEqualTo player) exitWith {systemChat "YOU ARE NOT THE SQUAD LEADER. ONLY SQUAD LEADERS CAN ASSIGN TASKS."};
_PMission = _PGroup getVariable ["DIS_PMAssigned",[]];

if (count _PMission > 0) exitWith {systemChat "YOU ARE ALREADY ASSIGNED TO A TASK. COMPLETE THAT TASK FIRST, OR ABANDON THE TASK."};

//Now we need to assign this mission to the group.




private _missionsList = ((findDisplay 32000) displayCtrl (32401));
private _CurSel = lbCurSel _missionsList;
if (_CurSel isEqualTo -1) exitWith {systemChat "PICK A MISSION";};
private _PreData = _missionsList lbData _CurSel;
private _Data = call compile _PreData;
_PGroup setVariable ["DIS_PMAssigned",_Data,true];

private _WestRun = false;
if (playerSide isEqualTo West) then
{
	_WestRun = true;
};

//Now we need to update the mission list with the assigned group.

private _Description = _Data select 1;
private _MissionId = _Data select 4;
if (_WestRun) then 
{
	{
		if (_MissionId isEqualTo (_x select 4)) exitWith
		{
				_Data set [3,[netId _PGroup]];
				W_PlayerMissions set [_forEachIndex,_Data];
		};
	
	} foreach W_PlayerMissions;
	publicVariable "W_PlayerMissions";
} 
else 
{
	{
		if (_MissionId isEqualTo (_x select 4)) exitWith
		{
				_Data set [3,[netId _PGroup]];
				E_PlayerMissions set [_forEachIndex,_Data];
		};
	
	} foreach E_PlayerMissions;
	publicVariable "E_PlayerMissions";
};


["TaskAssigned",["Mission Accepted"]] call bis_fnc_showNotification;

_handle = _Data execFSM "PlayerMissions.fsm";
closeDialog 2;
systemchat "MISSION ASSIGNED";
["Beep_Target"] remoteExec ["PlaySoundEverywhere",(side _PGroup)];
[format ["Squad %2, has accepted the mission: %1",(_Data select 0),(groupId _PGroup)],'#FFFFFF'] remoteExec ["MessageFramework",(side _PGroup)];	

//private _wp =_PGroup addWaypoint [position player, 0];

