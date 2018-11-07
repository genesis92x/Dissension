//This function handles replaces the default vehicles/objects repair,rearm,refuel functions
//This will allow us to charge a player for rearming their vehicle. We can also give vehicles *charges*, or usage amounts.

//We need to check if the vehicle has repair,fuel, and ammo
private _rep = getRepairCargo _this;
private _fue = getFuelCargo _this;
private _amm = getAmmoCargo _this;

//If the vehicle has repair cargo 
if (_rep > 0) then
{
	_this setRepairCargo 0;
	[
		[_this],
		{
			params ["_veh"];
			private _RepAct = [_veh,"Repair","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","_this distance _target < 30","true",{hint "Repairing!";},{},{hint "Repaired!";[_this,"Repair"] call DIS_fnc_REHndle;},{hint "Stopped repairing!";},[],10,-100,false,false] call bis_fnc_holdActionAdd;
		}
	] remoteExec ["bis_fnc_Spawn",0,_this]; 									
};
if (_fue > 0) then
{
	_this setFuelCargo 0;
	[
		[_this],
		{
			params ["_veh"];
			private _RepAct = [_veh,"Refuel","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","_this distance _target < 30","true",{hint "Refuelling!";},{},{hint "Refuelled!";[_this,"Fuel"] call DIS_fnc_REHndle;},{hint "Stopped refuelling!";},[],10,-100,false,false] call bis_fnc_holdActionAdd;
		}
	] remoteExec ["bis_fnc_Spawn",0,_this]; 			
};
if (_amm > 0) then
{
	_this setAmmoCargo 0;
	[
		[_this],
		{
			params ["_veh"];
			private _RepAct = [_veh,"Rearm","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa","_this distance _target < 30","true",{hint "Rearming!";},{},{hint "Rearmed!";[_this,"Ammo"] call DIS_fnc_REHndle;},{hint "Stopped rearming!";},[],10,-100,false,false] call bis_fnc_holdActionAdd;
		}
	] remoteExec ["bis_fnc_Spawn",0,_this]; 	
};



