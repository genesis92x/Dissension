//Function for creating and dropping a vehicle from the air.
if (DIS_PCASHNUM - 550 < 0) exitWith {systemChat "You lack sufficient funds!";if (playerSide isEqualTo west) then {playsound "EVAInsufficentFunds"} else {playsound "LEGIONInsufficentFunds"};};
if (DIS_AbilityCoolDown) exitWith {systemChat "Abilities still on cool-down.";};
DIS_PCASHNUM = DIS_PCASHNUM - 550;
playsound "Purchase";
DIS_AbilityCoolDown = true;[] spawn {sleep 120;DIS_AbilityCoolDown = false;};
["Personal ATV Drop In-bound",'#FFFFFF'] call Dis_MessageFramework;
private _VehC = "B_Quadbike_01_F";
private _MkT = "b_motor_inf";
if (side (group player) isEqualTo East) then {_VehC = "O_Quadbike_01_F";_MkT = "o_motor_inf";};

private _Veh = createVehicle [_VehC, [0,0,600], [], 0, "CAN_COLLIDE"];
clearWeaponCargoGlobal _Veh;
clearMagazineCargoGlobal _Veh;
clearItemCargoGlobal _Veh;
clearBackpackCargoGlobal _Veh;

private _para = createVehicle ["B_Parachute_02_F", [0,0,600], [], 0, "CAN_COLLIDE"]; 
_Veh attachTo [_para,[0,0,0]];
_Veh setvariable ["DIS_PLAYERVEH",true,true];
private _position = getPosWorld player;
_para setpos [_position select 0,_position select 1,((_position select 2) + 300)];	
playsound "drop_accomplished";
waitUntil {((getpos _Veh) select 2) < 2.5};
detach _Veh;

[
[_Veh,_MkT],
{
	params ["_Veh","_MkT"];
	if (player distance2D _Veh < 2100) then
	{
		private _m1 = createMarker [format ["%1",_Veh],(getpos _Veh)];
		_m1 setmarkershape "ICON";
		_m1 setMarkerType _MkT;
		_m1 setmarkercolor "ColorWhite";
		_m1 setmarkersize [1,1];
		sleep 120;
		deleteMarker _m1;
	};
}

] remoteExec ["BIS_fnc_Spawn",0];	