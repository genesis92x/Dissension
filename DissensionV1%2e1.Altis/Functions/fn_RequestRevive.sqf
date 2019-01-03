//Function for AI to revive downed players 
//params [["_Downed",player,[objNull],1]];
params ["_Downed"];

//Let's look for any AI nearby
private _AIUnits = allunits select {!(isPlayer _x)};
_AIUnits = _AIUnits - [DIS_WESTCOMMANDER];
_AIUnits = _AIUnits - [DIS_EASTCOMMANDER];
private _dist = 300;
private _PSide = side (group _Downed);
private _AIRev = objNull;
private _AIList = [];
{
	if (isNull objectParent _x && {_x distance2D _Downed < _dist} && {(side (group _x)) isEqualTo _PSide}) then
	{
		_AIList pushback _x;
	};
} foreach _AIUnits;

if (_AIList isEqualTo []) exitWith {Hint "There are no AI to revive you. You must respawn or be revived by another player. Should have used TFR SOP camo.  PRYMSUSPEC would be dissapointed."};
private _AIRev = [_AIList,_Downed,true,"Rv1"] call dis_closestobj;

if !(isNull _AIRev) then
{
	hintsilent format ["AI %1 is on his way to revive you! He is %2m away.",(name _AIRev),(_AIRev distance2D _Downed)];
	[
	[_AIRev,_Downed],
	{
		params ["_AIRev","_Downed"];
		//Force the AI to move to the downed player
		while {alive _Downed && {alive _AIRev} && {_Downed distance2D _AIRev > 10}} do
		{
			sleep 5;
			doStop _AIRev;
			_AIRev doMove (getpos _Downed);
		};
		if (!(alive _AIRev) || !(alive _Downed) || !(lifeState _Downed isEqualTo "UNCONSCIOUS")) exitWith {};
		_AIRev disableai "anim";
		_AIRev setDir (_AIRev getdir _Downed);
		[_AIRev,"Acts_TreatingWounded_in"] remoteExec ["DIS_playMoveEverywhere",0];
		sleep 3.066;
		[_AIRev,"Acts_TreatingWounded02"] remoteExec ["DIS_playMoveEverywhere",0];
		sleep 8.032;
		[_AIRev,"Acts_TreatingWounded_out"] remoteExec ["DIS_playMoveEverywhere",0];
		_AIRev enableai "anim";		
    [
    [_Downed,_AIRev],
    {
            params ["_Downed","_AIRev"];
            if !(alive _Downed) exitWith {};
            
            private _Act = _Downed getVariable ["DIS_DRAGACT",0];
            private _RAct = _Downed getVariable ["DIS_REVIVEACT",0];
            [_Downed,_Act] call BIS_fnc_holdActionRemove;
            [_Downed,_RAct] call BIS_fnc_holdActionRemove;
            _Downed setVariable ["DIS_INCAPACITATED",false,true];        
            
            if (_Downed isEqualTo player) then
            {
                systemChat "You have been revived!";
                _Downed setUnconscious false;
                playMusic "";
                _Downed setVariable ["DIS_CurDamage",false];
                _Downed setVariable ["DIS_CurCap",0];
                [_Downed,"UnconsciousOutProne"] remoteExec ["DIS_playMoveEverywhere",0];
                [_Downed,DIS_SuAct] call BIS_fnc_holdActionRemove;
                _Downed setAnimSpeedCoef 0.65;_Downed setdamage 0.7;_Downed spawn {waitUntil {((damage player) < 0.2)};_this setAnimSpeedCoef 1;};
            };
    }
    
    ] remoteExecCall ["bis_fnc_call",0]; 		
		
	}
	] remoteExec ["bis_fnc_spawn",(owner _AIRev)];
	
	
	//Here we will have the downed unit constantly monitoring the AI coming to his rescue. If the AI dies...reset the search.
	while {alive _Downed && {alive _AIRev} && {_Downed distance2D _AIRev > 5} && {_Downed getVariable ["DIS_INCAPACITATED",false]}} do
	{
		hint format ["AI %1 is on his way to revive you! He is %2m away.",(name _AIRev),(_AIRev distance2D _Downed)];
		sleep 5;
	};
	if !(alive _Downed) exitWith {};
	if (!(alive _AIRev) && {lifeState _Downed isEqualTo "UNCONSCIOUS"}) exitWith 
	{
		hint format ["AI %1 has been KIA",(name _AIRev)];
		sleep 5;
		[_Downed] spawn DIS_fnc_RequestRevive;
	};
}
else
{
	hint format ["There are no friendly AI within %1m.  Should have used TFR SOP camo.  PRYMSUSPEC would be dissapointed.",_dist];
	if ((alive _Downed) && {lifeState _Downed isEqualTo "UNCONSCIOUS"}) exitWith 
	{
		hint format ["AI %1 has been KIA",(name _AIRev)];
		sleep 5;
		[_Downed] spawn DIS_fnc_RequestRevive;
	};	
};