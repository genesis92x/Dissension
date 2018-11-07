//Function for HALOing into a location. Some restrictions apply.
if (DIS_PCASHNUM - 400 < 0) exitWith {systemChat "You lack sufficient funds!";if (playerSide isEqualTo west) then {playsound "EVAInsufficentFunds"} else {playsound "LEGIONInsufficentFunds"};};
if (DIS_AbilityCoolDown) exitWith {systemChat "Abilities still on cool-down.";};
private _CE = player call dis_ClosestEnemy;
if (_CE distance2D player < 800) exitWith {["Unable to HALO. Enemy nearby.",'#FFFFFF'] call Dis_MessageFramework;};
DIS_PCASHNUM = DIS_PCASHNUM - 400;
playsound "Purchase";
DIS_AbilityCoolDown = true;[] spawn {sleep 120;DIS_AbilityCoolDown = false;};

openMap [true, true];
closeDialog 2;
["Select HALO position!",'#FFFFFF'] call Dis_MessageFramework;

["DIS_HALO", "onMapSingleClick", 
{
	private _NewPos = [(_pos select 0),(_pos select 1),1000];
	player setpos _NewPos;
	
	{
		if (local _x && {_x distance player < 151} && {!(isplayer _x)}) then
		{
			private _p = [_NewPos,250,5] call dis_randompos;
			private _chute = createVehicle ["Steerable_Parachute_F", [(_p select 0),(_p select 1),150],[], 0, "can_collide"];
			_x moveInAny _chute;
		};
	} foreach (units (group player));
	
	player addaction ["OPEN CHUTE",
	{
		private _pos = getpos player;
		private _NewPos = [(_pos select 0),(_pos select 1),((_pos select 2) + 2)];
		private _chute = createVehicle ["Steerable_Parachute_F", [0,0,100],[], 0, "can_collide"];
		_chute setpos _NewPos;
		private _v = velocity player;
		player moveInDriver _chute;
		_chute setVelocity _v;
		player setVelocity _v;
		player removeAction (_this select 2);
	}];
	
	private _Img = MISSION_ROOT + "Pictures\iconPlayer_ca.paa";
	private _pos2 = [(_Pos select 0),(_Pos select 1),(getTerrainHeightASL _Pos)];
	[(str _pos2), "onEachFrame", 
	{
			params ["_Img","_pos2"];
			call compile format 
			[
			'
			drawIcon3D
			[
				%1,
				[1,1,1,0.5],
				%2,
				1,
				1,
				0,
				"LZ",
				1,
				0.04,
				"RobotoCondensed",
				"center",
				false
			];
			'
			,str _Img,_pos2
			]
	},
	[_Img,_pos2]
	] call BIS_fnc_addStackedEventHandler;
	(str _pos2) spawn {waitUntil {((getpos player) select 2) < 2.5};[_this, "onEachFrame"] call BIS_fnc_removeStackedEventHandler;};
	openMap [false, false];
	["DIS_HALO", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
}] call BIS_fnc_addStackedEventHandler;



