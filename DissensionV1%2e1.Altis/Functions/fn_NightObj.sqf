//Function for spawning  flares and generators.
params ["_Pole"];

private _PolePos = getpos _Pole;

for "_i" from 0 to 2 do
{
	private _rndp = [_PolePos,50,150] call dis_randompos;
	private _NBP = getpos (nearestBuilding _rndp);
	private _SpwnPntD = [_NBP, 5, 25, 5, 0, 50, 0,[],[_NBP,_NBP]] call BIS_fnc_findSafePos;	
	private _Generator = "Land_DieselGroundPowerUnit_01_F" createVehicle _SpwnPntD;
	_Generator setvariable ["DIS_PLAYERVEH",true,true];
	_Generator allowdamage false;	
	_Generator setpos _SpwnPntD;
	_Generator addEventHandler ["Killed", 
	{
			{
				
				private "_lamp";
				_lamp = _x;
				
				{ _lamp setHit [ format [ "Light_%1_hitpoint", _x ], 1 ] } forEach [ 1, 2, 3 ];
				
			} foreach ( nearestObjects [ (_this select 0), ["Lamps_base_F"], 250] );
	
	}];	
	
	[
	[_Generator],
	{
		params ["_Generator"];
		private _Addaction = [_Generator,"Destroy Generator","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa","_this distance _target < 2","true",{hint "Destroying...";},{},{hint "Destroyed!";(_this select 0) setdamage 1;[player,"Acts_CrouchingCoveringRifle01"] remoteExec ["DIS_switchMoveEverywhere",0];[] spawn {sleep 5;[player,""] remoteExec ["DIS_switchMoveEverywhere",0];};},{},[],8,0,true,true] call bis_fnc_holdActionAdd;		
	}
	] remoteExec ["bis_fnc_Spawn",0]; 	
	
	[_Generator,_Pole] spawn
	{
		while {alive (_this select 0) && {(_this select 1) getVariable ["DIS_ENGAGED",false]}} do
		{
			[(_this select 0),"bobcat_engine_loop"] remoteExec ["PlaySoundEverywhereSay3D",0];	
			sleep 5;
		};
		deleteVehicle (_this select 0);
	};
	

};


while {(_Pole getVariable ["DIS_ENGAGED",false])} do
{
	private _rndp = [_PolePos,25,100] call dis_randompos;
	_Flare = "F_40mm_White" createVehicle [ _rndp select 0, _rndp select 1, 300]; 
	_Flare setvelocity [35,0,-0.1];
	sleep 60;
};
