//This function will manage AI and know when to spawn vehicles back in for them.
private ["_Veh", "_Go", "_LE", "_NE", "_Position", "_list", "_position", "_Road", "_CRoad", "_Sveh"];

_Group = _this select 0;
_Veh = _this select 1;
_Go = true;

while {{alive _x} count (units _Group) > 0 && {_Go}} do
{
	_LE = leader _Group;
	if (_LE isEqualTo (vehicle _LE)) then
	{
		_NE = _LE call dis_ClosestEnemy;
		
		if (_NE distance _LE > 800) then
		{
			//_Group setBehaviour "SAFE";
			
			private _index = currentWaypoint _Group;
			[_Group,_index] setWaypointBehaviour "SAFE";			
			_Position = getpos _LE;
			_list = _position nearRoads 1000;
			if !(_list isEqualTo []) then
			{
				_Road = [_list,_position,true] call dis_closestobj;
				_CRoad = getpos _Road;
			}
			else
			{
				_CRoad = _position;
			};
		
				_Sveh = _Veh createVehicle _CRoad;
				_Sveh spawn dis_UnitStuck;
				_Sveh spawn {sleep 10;_this allowdamage true;};
				[_Sveh,_Group] spawn dis_VehicleDespawn;
			{
				_x moveinAny _Sveh;
			} foreach units _group;
			sleep 120;
		};
		
	};
	sleep 15;
};