//Function that drops leaflets on the nearest resistance group. Will cause several units to give up the fight.
if (DIS_PCASHNUM - 400 < 0) exitWith {systemChat "You lack sufficient funds!";if (playerSide isEqualTo west) then {playsound "EVAInsufficentFunds"} else {playsound "LEGIONInsufficentFunds"};};
if (DIS_AbilityCoolDown) exitWith {systemChat "Abilities still on cool-down.";};
DIS_PCASHNUM = DIS_PCASHNUM - 400;
playsound "Purchase";
DIS_AbilityCoolDown = true;[] spawn {sleep 120;DIS_AbilityCoolDown = false;};
["Leaflets dropped to route wavering troops.",'#FFFFFF'] call Dis_MessageFramework;
private _Leaflets = "1Rnd_Leaflets_West_F";
private _VehC = "B_UAV_01_F";
if (side (group player) isEqualTo East) then {_VehC = "O_UAV_01_F";_Leaflets = "1Rnd_Leaflets_East_F";};

private _ReGroup = allGroups select {(side _x) isEqualTo resistance};
private _Leaders = [];
{
	_Leaders pushback (leader _x);
} foreach _ReGroup;

private _ClosestEn = [_Leaders,player,true] call dis_closestobj;

private _PPos = getpos _ClosestEn;	
private _para = createVehicle [_VehC, [0,0,500], [], 0, "FLY"];		
createVehicleCrew _para;
_para setpos [(_PPos select 0),(_PPos select 1),((_PPos select 2) +50)];
_para addMagazine _Leaflets;
_para addMagazine _Leaflets;
_para addWeapon "Bomb_Leaflets";
_para fire "Bomb_Leaflets";
_para fire "Bomb_Leaflets";
sleep 4;
deletevehicle _para;

private _RmvAmt = 0;
{
	if (_x distance2D _ClosestEn < 600) then
	{
		if (random 100 > 75) then
		{
				systemChat format ["%1",_x];
			 _x setDamage 1;
			_RmvAmt = _RmvAmt + 1;
		};
	};
} foreach (allunits select {(side _x) isEqualTo resistance});

[format ["Leaflets routed %1 troops!",_RmvAmt],'#FFFFFF'] call Dis_MessageFramework;