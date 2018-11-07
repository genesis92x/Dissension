params ["_Leader","_wPos"];

//private _direction = [_Leader,_wPos] call BIS_fnc_dirTo;
private _direction = _Leader getdir _wPos;
private _NewPosition = [0,0,0];
private _UnitPos = getpos _Leader;
private _Group = group _Leader;
private _MovementDistance = 50;
private _WpArrayCheck = [];
private _CargoCrate = nil;
private _myRope = "";
private _VicksInGrp = false;

private _LandAgain = false;
private _LandingLocation = [0,0,0];
While {_NewPosition distance2D _wPos > 150 && {{alive _x} count (units _Group) > 0}} do
{
	_NewPosition = [_UnitPos,_MovementDistance,_direction] call BIS_fnc_relPos;	
	if (surfaceIsWater _NewPosition) then {_WpArrayCheck pushback _NewPosition;_LandAgain = true;} else {if (_LandAgain) then {_LandingLocation = _NewPosition;};};
	_MovementDistance = _MovementDistance + 50;
	sleep 0.001;
};

if (!(_LandAgain) || (_LandingLocation isEqualTo [0,0,0])) then {_LandingLocation = _NewPosition};
private _ExecCheck = (count _WpArrayCheck);

if (_ExecCheck > 0 || _UnitPos distance2D _wPos > 1500) exitWith
{
		_Group setVariable ["DIS_BoatN",true];
		_Group setVariable ["DIS_IMPORTANT",true];

	
		private _SpawnSide = side (_Group);

		private _BoatVeh = "B_Heli_Transport_01_F";
		private _Commander = DIS_WestCommander;
		if (_SpawnSide isEqualTo east) then
		{
			_BoatVeh = "O_Heli_Light_02_unarmed_F";
			_Commander = DIS_EastCommander;
		};
		if (_SpawnSide isEqualTo resistance) then
		{
			_BoatVeh = "I_Heli_light_03_unarmed_F";
			_Commander = _Leader;
		};
	
		private _FirstMovePos = _WpArrayCheck select 0;
		if (isNil "_FirstMovePos") exitWith {_Group setVariable ["DIS_BoatN",false];_Group setVariable ["DIS_IMPORTANT",false];};
		//private _BestAreaArray = (selectBestPlaces [_FirstMovePos, 500, "10*meadow + hills", 100, 1]) select 0 select 0;
		private _BestAreaArray = (selectBestPlaces [_Leader, 500, "10*meadow + hills", 100, 1]) select 0 select 0;
		private _MoveToPosition = [_BestAreaArray, 15, 250, 5, 0, 20, 0,[],[_UnitPos,_UnitPos]] call BIS_fnc_findSafePos;
		
		private _ActMoveToPosition = _MoveToPosition findEmptyPosition [1,150,_BoatVeh];
		if (_ActMoveToPosition isEqualTo []) then {_ActMoveToPosition = _MoveToPosition;};
		private _waypoint = _Group addwaypoint[_ActMoveToPosition,0,1];
		_waypoint setwaypointtype "MOVE";
		_waypoint setWaypointSpeed "NORMAL";
		_waypoint setWaypointBehaviour "SAFE";			
	

		private _DistanceCheck = 50;
		if !((leader _group) isEqualTo (vehicle (leader _group))) then {_DistanceCheck = 150;};
		while {(leader _group) distance2D _MoveToPosition > _DistanceCheck && {{alive _x} count (units _Group) > 0}} do
		{
			sleep 5;
			if !((leader _group) isEqualTo (vehicle (leader _group))) then {_DistanceCheck = _DistanceCheck + 25;};
		};
		if ({alive _x} count (units _Group) < 1) exitWith {};
	
		while {(count (waypoints _Group)) > 0} do
		{
			deleteWaypoint ((waypoints _Group) select 0);
		};		
		
		sleep 5;
		private _HeliPad = createVehicle ["Land_HelipadEmpty_F",_ActMoveToPosition, [], 0, "CAN_COLLIDE"];
		_HeliPad spawn {sleep 120; if (alive _this) then {deleteVehicle _this};};
		private _Clear1 = nearestTerrainObjects [_HeliPad, [], 25];
		{
			_x hideObjectGlobal true;
		} foreach _Clear1;
		
		private _veh = createVehicle [_BoatVeh, [(random 150),(random 150),150], [], 0, "FLY" ];
		_veh spawn {sleep 900;if (alive _this) then {deleteVehicle _this;};{deleteVehicle _x} foreach (crew _this)};
		_veh allowdamage false;_veh spawn {sleep 30;_this allowDamage true;};
		private _boatgroup = creategroup _SpawnSide;
		createVehicleCrew _veh;
		_veh setVariable ["DIS_BoatN",true];
		_veh setvariable ["DIS_PLAYERVEH",true,true];
		{[_x] joinSilent _boatgroup;_x disableAI "COVER";_x disableAI "AUTOCOMBAT";_x disableAI "AUTOTARGET";_x disableAI "TARGET";} foreach (crew _veh);
		_boatgroup setVariable ["DIS_BoatN",true];
		_boatgroup setVariable ["DIS_IMPORTANT",true];
		_veh setBehaviour "SAFE";		
		_veh setdir _direction;		
		

		private _ComPos = getpos _Commander;
		private _MovePosition = [_ComPos, 15, 250, 5, 0, 20, 0,[],[_ComPos,_ComPos]] call BIS_fnc_findSafePos;
		_MovePosition = [(_MovePosition select 0),(_MovePosition select 1),10];
		_HeliMovePos = _MovePosition findEmptyPosition [1,150,_BoatVeh];
		if (_HeliMovePos isEqualTo []) then {_HeliMovePos = _MovePosition;};
		_veh setpos [(_HeliMovePos select 0),(_HeliMovePos select 1),((_HeliMovePos select 2) + 50)];
		

		private _waypoint = _boatgroup addwaypoint[_ActMoveToPosition,0];
		_waypoint setwaypointtype "MOVE";
		_waypoint setWaypointSpeed "NORMAL";
		_waypoint setWaypointBehaviour "AWARE";
		_boatgroup setCurrentWaypoint [_boatgroup,(_waypoint select 1)];	
		private _waypoint2 = _boatgroup addwaypoint[_ActMoveToPosition,0];
		_waypoint2 setwaypointtype "MOVE";
		_waypoint2 setWaypointSpeed "NORMAL";
		_waypoint2 setWaypointBehaviour "AWARE";
		sleep 5;

		
		while {alive _veh && {alive (driver _veh)} && {_veh distance2D _ActMoveToPosition > 150}} do
		{
			sleep 1;
		};
		
		if ({alive _x} count (units _Group) < 1) exitWith 
		{
			{deleteVehicle _x} foreach (crew _veh);
			deleteVehicle _veh;
		};
		
		_veh land "LAND";
		sleep 10;

		{
			_x enableSimulationGlobal false;
			_x hideObjectGlobal true;		
			if !(_x isEqualTo (vehicle _x)) then 
			{
				_x enableSimulationGlobal false;
				_x hideObjectGlobal true;
				(vehicle _x) enableSimulationGlobal false;
				(vehicle _x) hideObjectGlobal true;
				_VicksInGrp = true;
			};				
		} foreach (units _Group);		
		
		sleep 10;

			private _BestAreaArray = (selectBestPlaces [_LandingLocation, 500, "10*meadow + hills", 100, 1]) select 0 select 0;
			_ActLandingLocation = _BestAreaArray findEmptyPosition [1,150,_BoatVeh];
			if (_ActLandingLocation isEqualTo []) then {_ActLandingLocation = _LandingLocation;};			
			private _waypoint = _boatgroup addwaypoint[_ActLandingLocation,0];
			_waypoint setwaypointtype "MOVE";
			_waypoint setWaypointSpeed "NORMAL";
			_waypoint setWaypointBehaviour "AWARE";
			_boatgroup setCurrentWaypoint [_boatgroup,(_waypoint select 1)];	
			private _waypoint2 = _boatgroup addwaypoint[_ActLandingLocation,0];
			_waypoint2 setwaypointtype "MOVE";
			_waypoint2 setWaypointSpeed "NORMAL";
			_waypoint2 setWaypointBehaviour "AWARE";
			deleteVehicle _Helipad;		
			private _HeliPad = createVehicle ["Land_HelipadEmpty_F",_ActLandingLocation, [], 0, "CAN_COLLIDE"];
			_HeliPad spawn {sleep 120; if (alive _this) then {deleteVehicle _this};};
			while {alive _veh && {alive (driver _veh)} && {(getpos _veh) select 2 > 20}} do
			{
				sleep 1;
			};		
			
			if ({alive _x} count (units _Group) < 1) exitWith 
			{
				{deleteVehicle _x} foreach (crew _veh);
				deleteVehicle _veh;			
			};
			
			private _Clear2 = nearestTerrainObjects [_HeliPad, [], 25];
			{
				_x hideObjectGlobal true;
			} foreach _Clear2;			
			
			
			
			while {alive _veh && {alive (driver _veh)} && {(getpos _veh) select 2 < 20}} do
			{
				sleep 1;
			};
			
			if ({alive _x} count (units _Group) < 1) exitWith 
			{
				{deleteVehicle _x} foreach (crew _veh);
				deleteVehicle _veh;			
			};
		
			if (_VicksInGrp) then
			{
				_CargoCrate = "B_Slingload_01_Cargo_F" createVehicle (getpos _veh);
				_CargoCrate setmass 15;
				_myRope = ropeCreate [_veh,[0,0,-2],_CargoCrate, [0, 0, -3],10];
				_CargoCrate spawn {sleep 300;deleteVehicle _this};
			};
			
			
			while {alive _veh && {alive (driver _veh)} && {_veh distance2D _ActLandingLocation > 150}} do
			{
				sleep 1;
			};	
			if ({alive _x} count (units _Group) < 1) exitWith 
			{
				{deleteVehicle _x} foreach (crew _veh);
				deleteVehicle _veh;			
			};	
			
			_veh land "LAND";			
			
			while {alive _veh &&  {alive (driver _veh)} && {(getpos _veh) select 2 > 10}} do
			{
				sleep 1;
			};	
			
			if ({alive _x} count (units _Group) < 1) exitWith 
			{
				{deleteVehicle _x} foreach (crew _veh);
				deleteVehicle _veh;			
			};
			
			if (_VicksInGrp) then
			{	
				ropeDestroy _myRope;	
			};
			
			
				private _Compos = (getpos _veh);			
			{
				private _rnd = random 15;
				private _dist = (_rnd + 5);
				private _dir = random 360;
				private _positionsLand = [(_ComPos select 0) + (sin _dir) * _dist, (_ComPos select 1) + (cos _dir) * _dist, 0];
				private _position = _positionsLand findEmptyPosition [10,100,(typeOf _x)];
				if (_position isEqualTo []) then {_position = _positionsLand;};
				if (surfaceIsWater _position) then 
				{
					private _WaterGoGo = true;
					private _Attempts = 0;
					while {_WaterGoGo && {_Attempts < 50}} do
					{
						private _rnd = random 100;
						private _dist = (_rnd + 5);
						private _dir = random 360;
						private _positionsLand = [(_ComPos select 0) + (sin _dir) * _dist, (_ComPos select 1) + (cos _dir) * _dist, 0];
						private _position = _positionsLand findEmptyPosition [1,100,(typeOf _x)];
						if !(surfaceisWater _position) then {_WaterGoGo = false};
						_Attempts = _Attempts + 1;
						sleep 0.25;
					};
				};
				if !(_x isEqualTo vehicle _x) then
				{
					if (driver (vehicle _x) isEqualTo _x) then
					{
						(vehicle _x) setpos _position;
						(vehicle _x) enableSimulationGlobal true;
						(vehicle _x) hideObjectGlobal false;
						_x enableSimulationGlobal true;
						_x hideObjectGlobal false;								
					};
						_x enableSimulationGlobal true;
						_x hideObjectGlobal false;		
				}
				else
				{
						_x setpos _position;
						_x enableSimulationGlobal true;
						_x hideObjectGlobal false;						
				};
			
				sleep 1;
			} forEach units (_Group);
			
	
			_Group setVariable ["DIS_BoatN",false];		
			private _waypoint3 = _Group addwaypoint[_wPos,0];
			_waypoint3 setwaypointtype "MOVE";
			_waypoint3 setWaypointSpeed "NORMAL";
			_waypoint3 setWaypointBehaviour "AWARE";
			private _waypoint4 = _Group addwaypoint[_wPos,0];
			_waypoint4 setwaypointtype "MOVE";
			_waypoint4 setWaypointSpeed "NORMAL";
			_waypoint4 setWaypointBehaviour "AWARE";					
			sleep 15;
			
			private _waypoint = _boatgroup addwaypoint[_HeliMovePos,0];
			_waypoint setwaypointtype "MOVE";
			_waypoint setWaypointSpeed "NORMAL";
			_waypoint setWaypointBehaviour "AWARE";
			_boatgroup setCurrentWaypoint [_boatgroup,(_waypoint select 1)];	
			private _waypoint2 = _boatgroup addwaypoint[_HeliMovePos,0];
			_waypoint2 setwaypointtype "MOVE";
			_waypoint2 setWaypointSpeed "NORMAL";
			_waypoint2 setWaypointBehaviour "AWARE";			
			
			
			
			while {alive _veh &&  {alive (driver _veh)} && {_veh distance2D _HeliMovePos > 150}} do
			{
				sleep 1;
			};		

			{
				_x hideObjectGlobal false;
			} foreach _Clear2;
			{
				_x hideObjectGlobal false;
			} foreach _Clear1;			
			
			_veh land "LAND";			
			sleep 45;
			{deleteVehicle _x;} foreach units _boatgroup;			
			deletevehicle _veh;
			_Group setVariable ["DIS_FCheck",false];
			
};

_Group setVariable ["DIS_FCheck",false];