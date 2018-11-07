//Lets constantly monitor groups and see if they need to have boats to get across water.
//This is hopefully cheaper than each group having its own function running.

private _DISTransport = "DISTransport" call BIS_fnc_getParamValue;
if (_DISTransport isEqualTo 1) then
{

waitUntil
{
	sleep 15;
	{
		private _Group = _x;
		if !(isPlayer (leader _Group)) then
		{
			private _Leader = leader _x;
			if (!(_Group getVariable ["DIS_BoatN",false]) && {(getpos _Leader) select 2 < 10} && {alive _leader}) then
			{
				private _curwp = currentWaypoint _x;
				private _wPos = waypointPosition [_x,_curwp];
				if (!(_wPos isEqualTo [0,0,0]) && {!(_wPos isEqualTo Dis_WorldCenter)} && {!(_Group getVariable ["DIS_FCheck",false])}) then
				{
					[_Leader,_wPos] spawn DIS_fnc_FragmentMove;
					_Group setVariable ["DIS_FCheck",true];
				};
			};
		};
	} foreach allGroups;
	false
};


};