//This function will handle constantly changing the players visible and auditory co's.


waitUntil
{
	if (alive player) then
	{
		if (player isEqualTo (vehicle player)) then
		{
			private _PStance = stance player;
			if (_PStance isEqualTo "STAND") then
			{
				player setUnitTrait ["camouflageCoef",1];
				player setUnitTrait ["audibleCoef",1];
			};
			if (_PStance isEqualTo "CROUCH") then
			{
				player setUnitTrait ["camouflageCoef",0.6];
				player setUnitTrait ["audibleCoef",0.6];
			};
			if (_PStance isEqualTo "PRONE") then
			{
				player setUnitTrait ["camouflageCoef",0.4];
				player setUnitTrait ["audibleCoef",0.4];
			};		
		};
	};
	sleep 2;
	false
};

/*
0.1 - 50 meters standingbv
0.2 - 80 meters standing
0.3 - 110 meters standinf
[] spawn
{
	DIS_TESTY = false;
	sleep 4;
	DIS_TESTY = true;
	while {DIS_TESTY} do
	{
		_Var = player getUnitTrait "camouflageCoef";
		systemChat format ["_Var: %1",_Var];
		player setUnitTrait ["camouflageCoef",-100000];
		player setUnitTrait ["audibleCoef",-100000];
		sleep 0.1;
	};
};
*/