//[] call DIS_fnc_StructureMonitor
//This function will monitor structures and see if they need to be deleted eventually.
params ["_Structure","_Side"];



[
[_Structure,_Side],
{
	params ["_Structure","_Side"];
	
	private _EmptyCounter = 0;
	while {alive _Structure} do 
	{
		if !(DIS_DISABLED) then
		{
			private _ClosestPlayer = [allPlayers,_Structure,true] call dis_closestobj;
			if (_ClosestPlayer distance _Structure > 600) then
			{
				_EmptyCounter = _EmptyCounter + 1;
			}
			else
			{
				_EmptyCounter = 0;
			};
			
			if (_EmptyCounter > 5) then
			{
				_Structure setDamage 1;
				deleteVehicle _Structure;
			};
		};
		sleep 900;
	};
	sleep 60;
	deleteVehicle _Structure;

}
	
] remoteExec ["bis_fnc_Spawn",2];
