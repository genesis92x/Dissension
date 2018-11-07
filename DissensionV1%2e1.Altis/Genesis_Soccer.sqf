//To use this script, create a file called "init.sqf" in your root mission folder
//Then in the init.sqf copy and paste this line " [] execVM "Genesis_Soccer.sqf; "
//Should work now!
if (!(isNil "Dis_ResourceMapDone")) exitWith {};
if (isNil "PlaySoundEverywhere") then
{
	PlaySoundEverywhere = compileFinal "_this select 0 say3D (_this select 1);";
};
player setvariable ["Soccer_Hit",false,true];
MY_KEYDOWN_FNCDCGETIN =
{
    switch (_this) do {
        case 29: 
				{
					if (player getVariable "Soccer_Hit") then
					{
						player setvariable ["Soccer_Hit",false,true];
						hint "Low kick.";
					}
					else
					{
						player setvariable ["Soccer_Hit",true,true];
						hint "High kick.";
					};
        };

    };
};
VCOMKEYBINDINGDCGET = (findDisplay 46) displayAddEventHandler ["KeyDown","_this select 1 spawn MY_KEYDOWN_FNCDCGETIN;false;"];






if (isServer) then
{
	SoccerBallArray = [];
	Soccerball = "Land_Football_01_F" createvehicle [(getpos rawr)];

SoccerBallArray pushback Soccerball;
sleep 5;

while {alive Soccerball} do
{
	_Closestplayer = [allPlayers,Soccerball] call BIS_fnc_NearestPosition;
	if (_Closestplayer distance Soccerball <= 0.8) then
	{
		[[SoccerBall,"AddItemOK"],"PlaySoundEverywhere"] call BIS_fnc_MP;
		_GetVelocity = velocity _Closestplayer;
		_playervelocityX = _GetVelocity select 0;
		_playervelocityY = _GetVelocity select 1;
		_playervelocityZ = _GetVelocity select 2;
	
		_boostX = _playervelocityX * 3;
		_boostY = _playervelocityY * 3;
		_boostZ = _playervelocityZ * 3;
		_Punt = _Closestplayer getVariable ["Soccer_Hit",false];
		_Boost = 1;
		if (_Punt) then {_Boost = 8;};
		Soccerball setVelocity [_boostX,_boostY,_boostZ + _Boost];
	};
	sleep 0.01;
};
	if (!(isNil "Dis_ResourceMapDone")) exitWith {deleteVehicle Soccerball;};
};

