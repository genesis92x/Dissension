//[player,_dis_new_veh] call DIS_fnc_VehicleLock;
//This function will serve multiple purposes. Locking a vehicle, and preventing it from moving via other means (besides physics).

params ["_player","_Object"];

private _uid = getPlayerUID _player;

_Object setVariable ["DIS_LOCKID",_uid,true];

[
	[_uid,_Object],
	{
			params ["_uid","_Object"];
			#define TARGET _Object
			#define TITLE "Lock/Unlock Vehicle"
			#define    ICON  ""
			#define    PROG_ICON    ""
			#define COND_ACTION "true"
			#define COND_PROGRESS "true"
			#define    CODE_START {hint "Locking..."}
			#define    CODE_TICK {}
			private _CodeEnd = 
			{
				_uid = (_this select 3) select 0;
				_Object = (_this select 3) select 1;
				if ((getPlayerUID player) isEqualTo _uid) then
				{
					if ((locked _Object) isEqualTo 2) then {_Object setVehicleLock "UNLOCKED";hint "VEHICLE UNLOCKED";[[_Object],{params ["_Object"];_Object setVehicleLock "UNLOCKED";}] remoteExec ["bis_fnc_Spawn",0];} else {_Object setVehicleLock "LOCKED";hint "VEHICLE LOCKED";[[_Object],{params ["_Object"];_Object setVehicleLock "LOCKED";}] remoteExec ["bis_fnc_Spawn",0]; };
				}
				else
				{
					private _StillOwned = false;
					{
						if ((getPlayerUID _x) isEqualTo _uid) exitwith
						{
							_StillOwned = true;
						};
					} foreach allplayers; 
					if !(_StillOwned) then
					{
						hint "Owner of vehicle is missing! Setting ownership to you.";
						[[player,_Object],{params ["_player","_Object"];_Object setOwner (owner _player);}] remoteExec ["bis_fnc_Spawn",2]; 
						[player,_Object] call DIS_fnc_VehicleLock;
					}
					else
					{
						hint "You are not the owner! You cannot lock/unlock this vehicle.";
					};
				};
			};
			#define    CODE_INTERUPT {hint "Stopped Interaction"}
			#define    ARGUMENTS [_uid,_Object]
			#define    DURATION 1
			#define    PRIORITY -100
			#define    REMOVE false
			#define SHOW_UNCON false
		[TARGET,TITLE,ICON,PROG_ICON,COND_ACTION,COND_PROGRESS,CODE_START,CODE_TICK,_CodeEnd,CODE_INTERUPT,ARGUMENTS,DURATION,PRIORITY,REMOVE,SHOW_UNCON] call bis_fnc_holdActionAdd;
		
		
	}
] remoteExec ["bis_fnc_Spawn",0]; 	




