//This function spawns caches inside houses. Capturing these will decrease the number of spawns in a town
params ["_Pole","_SSide","_StrongHoldBuildings","_grpGarrison","_infantrylist","_AirList","_AtkSide","_NameLocation"];

//Let's store the complete list of ammocaches created throughout the town.
private _AmmoCacheList = [];

{
	if (alive _x && {!(isObjectHidden _x)}) then
	{
		if (round (random 100) < 25) then
		{
			private _BuildingPos = [_x] call BIS_fnc_buildingPositions;
			if (count _BuildingPos > 0) then
			{
				private _RdnPos = selectRandom _BuildingPos;
				private _AmmoCache = "Box_FIA_Wps_F" createVehicle [0,0,0];
				_AmmoCacheList pushback _AmmoCache;
				
				_AmmoCache setPosATL _RdnPos;
				_AmmoCache setVelocity [0,0,0];
				_AmmoCache setVariable ["DIS_POLE",_Pole];
				_AmmoCache setvariable ["DIS_PLAYERVEH",true,true];

				_AmmoCache addEventHandler ["Killed", 
				{
					private _Pole = (_this select 0) getVariable "DIS_POLE";
					private _Var1 = _Pole getVariable "DIS_Capture";
					private _SpawnAmount = _Var1 select 1;
					_Var1 set [1,(_SpawnAmount - 5)];
					_Pole setVariable ["DIS_Capture",_Var1,true];
					(_this select 0) spawn {sleep 10;deleteVehicle _this;};
				}];
				
				[
					[_AmmoCache],
					{
						params ["_AmmoCache"];
						private _Addaction = [_AmmoCache,"CAPTURE ENEMY MUNITIONS","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","_this distance _target < 1000","true",{hint "Destroying!";},{},{(_this select 0) setdamage 1;hint "GARRISON FORCE REDUCED BY 5";},{hint "Stopped!"},[],8,0,true,true] call bis_fnc_holdActionAdd;
					}
				] remoteExec ["bis_fnc_call",0,_AmmoCache]; 

					
			};
		};
	};
} foreach _StrongHoldBuildings;

if (count _AmmoCacheList > 0) then
{
	["FIND ENEMY CACHES TO REDUCE TOWN GARRISON COUNT.",'#46C202'] remoteExec ["MessageFramework",_AtkSide];
	
	[_AmmoCacheList,_Pole] spawn
	{
		params ["_AmmoCacheList","_Pole"];
		waitUntil {!(_Pole getVariable ["DIS_ENGAGED",false])};
		{
			if (alive _x) then
			{
				deleteVehicle _x;
			};
		} foreach _AmmoCacheList;
	};
};