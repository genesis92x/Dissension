//This function will handle the spawning and handling of the supply crates that will be randomly created around players.

params ["_Obj"];

//Here I am experimenting with a new spawning method that should be easier on machines. Instead of spawning 20 crates at once, we space out the spawning by a small bit and slowly enable their simulation.
sleep (5 + (random 15));
private _position = [_Obj,750,5] call dis_randompos;
if (isNil "_position") exitWith {};
private _Supply = createVehicle ["B_supplyCrate_F",[0,0,0], [], 0, "CAN_COLLIDE"];
_Supply setVariable ["DIS_PLAYERVEH",true];
private _para = createVehicle ["B_Parachute_02_F", [0,0,200], [], 0, "CAN_COLLIDE"]; //Steerable_Parachute_F
_Supply attachTo [_para,[0,0,0]]; 


_para setpos [_position select 0,_position select 1,((_position select 2) + 300)];
_para spawn {sleep 260; if (alive _this) then {deleteVehicle _this;}};
_Supply allowdamage false;
_Supply setvariable ["DIS_PLAYERVEH",true];
_para setvariable ["DIS_PLAYERVEH",true];
waitUntil {((getpos _Supply) select 2) < 10};
detach _Supply;
private _smoke = "SmokeShellOrange" createVehicle (getpos _Supply);
_Supply setPos (getPos _Supply);

//Here it will continue like normal.

_Supply spawn {sleep 1200;deleteVehicle _this; };


//Globally create addactions for the crates.
[
[_Supply],
{
		private _Supply = _this select 0;

		//New fancy addaction. USE THIS NEW ONE!
		#define TARGET _Supply
		#define TITLE "Check Supplies"
		#define    ICON  ""
		#define    PROG_ICON    ""
		#define COND_ACTION "true"
		#define COND_PROGRESS "true"
		#define    CODE_START {["Checking Supplies...",'#FFFFFF'] call Dis_MessageFramework}
		#define    CODE_TICK {}
		#define CODE_END {["These supplies are safe!",'#FFFFFF'] call Dis_MessageFramework;}
		#define    CODE_INTERUPT {["Stopped checking supplies",'#FFFFFF'] call Dis_MessageFramework;}
		#define    ARGUMENTS []
		#define    DURATION 5
		#define    PRIORITY 1
		#define    REMOVE false
		#define SHOW_UNCON false
		
		[TARGET,TITLE,ICON,PROG_ICON,COND_ACTION,COND_PROGRESS,CODE_START,CODE_TICK,CODE_END,CODE_INTERUPT,ARGUMENTS,DURATION,PRIORITY,REMOVE,SHOW_UNCON] call bis_fnc_holdActionAdd;
		

		//New fancy addaction. USE THIS NEW ONE!
		#define TARGET _Supply
		#define TITLE "Claim Supplies"
		#define    ICON  ""
		#define    PROG_ICON    ""
		#define COND_ACTION "true"
		#define COND_PROGRESS "true"
		#define    CODE_START {["Taking Supplies...",'#FFFFFF'] call Dis_MessageFramework}
		#define    CODE_TICK {}
		private _CodeEnd =
		{
			if ((side player) isEqualTo East) then
				{
					E_RArray set [0,(E_RArray select 0) + 100];
					E_RArray set [1,(E_RArray select 1) + 100];
					E_RArray set [2,(E_RArray select 2) + 100];
					E_RArray set [3,(E_RArray select 3) + 100];
					DIS_PCASHNUM = DIS_PCASHNUM + 1000;
					["+1000 CASH AND +100 FOR EACH SUPPLY",'#FFFFFF'] call Dis_MessageFramework;
					deletevehicle (_this select 0);
				}
				else
				{
					W_RArray set [0,(W_RArray select 0) +	100];
					W_RArray set [1,(W_RArray select 1) +	100];
					W_RArray set [2,(W_RArray select 2) +	100];
					W_RArray set [3,(W_RArray select 3) +	100];	
					DIS_PCASHNUM = DIS_PCASHNUM + 1000;				
					["+1000 CASH AND +100 FOR EACH SUPPLY",'#FFFFFF'] call Dis_MessageFramework;
					deletevehicle (_this select 0);
				};
			};
		#define    CODE_INTERUPT {["Stopped taking supplies",'#FFFFFF'] call Dis_MessageFramework;}
		#define    ARGUMENTS []
		#define    DURATION 2
		#define    PRIORITY 1
		#define    REMOVE false
		#define SHOW_UNCON false
		
		[TARGET,TITLE,ICON,PROG_ICON,COND_ACTION,COND_PROGRESS,CODE_START,CODE_TICK,_CodeEnd,CODE_INTERUPT,ARGUMENTS,DURATION,PRIORITY,REMOVE,SHOW_UNCON] call bis_fnc_holdActionAdd;		
									
		if (player distance2D _Supply < 2100) then
		{
			private _m1 = createMarkerLocal [format ["%1",_Supply],(getpos _Supply)];
			_m1 setMarkerShapeLocal "ICON";
			_m1 setMarkerTypeLocal "u_installation";
			_m1 setmarkercolorLocal "ColorWhite";
			_m1 setmarkersizeLocal [1,1];
			waitUntil {!(alive _Supply)};
			deleteMarker _m1;
		};		
}

] remoteExec ["bis_fnc_Spawn",0]; 					