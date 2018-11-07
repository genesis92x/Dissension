//This function is for monitoring vehicles and when they should despawn
_Veh = _this select 0;
_Unitgrp = _this select 1;
sleep 10;
while {alive _Veh} do
{
	_LE = leader _Unitgrp;
	if (behaviour (driver _Veh) isEqualTo "COMBAT" || {isNull (driver _veh)} || {!(alive (driver _veh))}) then
	{
		_Gunner = gunner _Veh;
		if (isNull _Gunner || {!(alive _Gunner)}) then 
		{
		_isWater = surfaceIsWater position _LE;
		if !(_isWater) then
		{
			_Transporting = _Unitgrp getVariable ["DIS_BoatN",false];
			if !(_Transporting) then
			{
				_CE = _LE call dis_ClosestEnemy;
				if (_CE distance _LE < 500) then
				{
					(driver _veh) forcespeed 0;
					_veh forcespeed 0;
					sleep 8;
					(driver _veh) forcespeed -1;
					deletevehicle _Veh;
				};
			};
		};
		};
	};

	sleep 10;
};