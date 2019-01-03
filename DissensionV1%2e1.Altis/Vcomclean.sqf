//Vcomclean.sqf
//This function will go around and clean up objects and empty containers! Adjust the settings below.
sleep 5;

VCOM_CleanUpScript = true;

//The distance2D a dead unit has to be from the player to be removed.
private _DeadUnitDist = 200;
private _DeadUnitMax = 25;
private _DeadVehDist = 200;
private _DeadVehicleMax = 5;
private _Geardistance2D = 500;
private _GearMax = 25;

waitUntil
{
	//Delete Units
	{
		private _Player = [PlayableUnits,_x,true] call dis_closestobj;
		if (_Player distance2D _x > _DeadUnitDist || (count allDeadMen > _DeadUnitMax)) then 
		{
			deleteVehicle _x;
		};
	} foreach allDeadMen;

	//Delete Vehicles
	private _allVehicles = (allDead - allDeadMen);
	{
	  private _Player = [PlayableUnits,_x,true] call dis_closestobj;
		if (_Player distance2D _x > _DeadVehDist || (count _allVehicles > _DeadVehicleMax)) then 
		{
			deleteVehicle _x;
		};
	} foreach _allVehicles;

	//Gear
	{
		private _Player = [PlayableUnits,_x,true] call dis_closestobj;
		if (_Player distance2D _x > _Geardistance2D  || (count _allVehicles > _GearMax) && {!(_x getVariable ["DIS_PLAYERVEH",false])}) then
		{
			deleteVehicle _x;
		};
	} foreach (allMissionObjects "WeaponHolder");
	//Empty Vehicles
	{
		private _Player = [PlayableUnits,_x,true] call dis_closestobj;
		if (_Player distance2D _x > _DeadVehDist && {!(_x getVariable ["DIS_PLAYERVEH",false])}) then
		{
			private _Crew = crew _x;
			private _CargoList = [];
			{
				if (!((assignedVehicleRole _x) isEqualTo []) && alive _x) then {_CargoList pushback _x;};
			} foreach _Crew;
			if (count _CargoList < 1) then {deleteVehicle _x;};
		};
	} foreach vehicles;
	
	//Empty Groups
	{if ((count units _x) isEqualTo 0) then {[_x] remoteExec ["deleteGroup", (groupOwner _x)];}} forEach allGroups;
	

	sleep 300;
	!(VCOM_CleanUpScript)
};
