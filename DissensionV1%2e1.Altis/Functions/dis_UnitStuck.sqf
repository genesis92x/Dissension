//This function will constantly check the spawned group for units that are stuck. This method is experimental.
//Issues this aims to fix: AI groups, with active waypoints, that will refuse to move. This will move them a fraction of the distance to the waypoint.
//This issue seems to occur with vehicles - so we will only have this execute when the units are in vehicles.
//This function will only setup the loop, and will call another function while the group remains alive.

waitUntil
{
	{
		[(units _x),_x] call DIS_fnc_StkVeh;
		sleep 1;
	} foreach allgroups;
	sleep 60;	
	false
};
