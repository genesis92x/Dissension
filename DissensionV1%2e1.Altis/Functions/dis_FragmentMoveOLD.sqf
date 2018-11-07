	private ["_WpArrayCheck", "_Unit", "_WayPointPosition", "_UnitPos", "_direction", "_MovementDistance", "_LetsCount", "_NewPosition", "_WaypointPosition", "_WaterCount", "_WaterArray", "_BoatNeeded", "_WaterCheck", "_FirstWaterPos", "_MoveToPosition", "_waypoint", "_DistanceCheck", "_InVehicle", "_veh", "_LeaderPos", "_Leaderdir", "_SpawnPos", "_Range", "_speed", "_Attached", "_LandCount", "_PositionA", "_rnd", "_dist", "_dir", "_positions", "_Position", "_isWater", "_OrgVeh", "_Veh", "_VehGroup", "_waypoint2", "_TM", "_GlobalContinue"];
	_WpArrayCheck = [];
	
	_Unit = _this select 0;
	_Group = group _Unit;
	_SpawnSide = side _Group;
	_WayPointPosition = _this select 1;
	
	//_UnitPos = getpos _Unit;
	_UnitPos = getpos (leader _Unit);
	
	_direction = [_UnitPos,_WayPointPosition] call BIS_fnc_dirTo;
	
	_MovementDistance = 15;
	
	_LetsCount = true;

	While {_LetsCount && {{alive _x} count (units _Group) > 0}} do
	{
		_NewPosition = [_UnitPos,_MovementDistance,_direction] call BIS_fnc_relPos;	
		if (surfaceIsWater _NewPosition) then {_WpArrayCheck pushback [true,_NewPosition]} else {_WpArrayCheck pushback [false,_NewPosition]};
		_MovementDistance = _MovementDistance + 50;
		if (_NewPosition distance _WaypointPosition < 100) then {_LetsCount = false};
		sleep 0.001;
	};
	
	
	_WaterCount = 0;
	_WaterArray = [];
	_BoatNeeded = false;
	{
		_WaterCheck = _x select 0;
		_Pos = _x select 1;
		
		if (_WaterCheck) then {_WaterCount = _WaterCount + 1;_WaterArray pushback (_x select 1);};
		if (_WaterCount >= 2) exitWith {_BoatNeeded = true;};
		
	} foreach _WpArrayCheck;

	
	if (_BoatNeeded) then
	{
		//SYSTEMCHAT format ["_BoatNeeded: %1",_BoatNeeded];
		//SYSTEMCHAT format ["_group: %1",_group];
		_group setVariable ["DIS_BoatN",true];
		_FirstWaterPos = _WaterArray select 0;
		_MoveToPosition = [_FirstWaterPos, 0, 250, 1, 0, 1, 1] call BIS_fnc_findSafePos;
		//(leader _group) doMove _MoveToPosition;
		_waypoint = _Group addwaypoint[_MoveToPosition,50,1];
		_waypoint setwaypointtype "MOVE";
		_waypoint setWaypointSpeed "NORMAL";
		_waypoint setWaypointBehaviour "AWARE";		

	
	//Now we need to wait for the group to get close to that position.
	_DistanceCheck = 50;
	if !((leader _group) isEqualTo (vehicle (leader _group))) then {_DistanceCheck = 150;};
	while {(leader _group) distance _MoveToPosition > _DistanceCheck && {{alive _x} count (units _Group) > 0}} do
	{
		sleep 4;
		if !((leader _group) isEqualTo (vehicle (leader _group))) then {_DistanceCheck = _DistanceCheck + 25;};
	};
	
	sleep 5;

		
		//SYSTEMCHAT format ["_InVehicle: %1",_InVehicle];	
			_curwp = currentWaypoint _group;
			deleteWaypoint [_group, _curwp];
			_veh = "B_Boat_Armed_01_minigun_F" createVehicle [0,0,0];
			_boatgroup = creategroup _SpawnSide;
			createVehicleCrew _veh;
			_boatgroup setVariable ["DIS_BoatN",true];
			{[_x] joinSilent _boatgroup;} foreach (crew _veh);
			
			_veh spawn dis_UnitStuck;
			_veh allowdamage false;
			_LeaderPos = getpos (leader _Group);
			_Leaderdir = getdir (leader _Group);

			
			{
				//_x moveInAny _veh;
				_x enableSimulationGlobal false;
				_x hideObjectGlobal true;
				if !(_x isEqualTo vehicle _x) then {(vehicle _x) enableSimulationGlobal false;(vehicle _x) hideObjectGlobal true;};				
			} foreach (units _Group);
			_veh setBehaviour "SAFE";
	
			_SpawnPos = [_LeaderPos, 0, 250, 1, 2, 1, 0] call BIS_fnc_findSafePos;
			if (Dis_WorldCenter isEqualTo _SpawnPos) then 
			{
				_Range = 350;
				while {Dis_WorldCenter isEqualTo _SpawnPos} do
				{
					_SpawnPos = [_LeaderPos, 0, _Range, 1, 2, 1, 0] call BIS_fnc_findSafePos;	
					_Range = _Range + 100;
					sleep 0.05;
				};	
			};
			
			_veh setpos _SpawnPos;
			
			//SYSTEMCHAT format ["_WayPointPosition: %1",_WayPointPosition];
			//SYSTEMCHAT format ["_boatgroup1: %1",_boatgroup];
			_waypoint = _boatgroup addwaypoint[_WayPointPosition,0];
			_waypoint setwaypointtype "MOVE";
			_waypoint setWaypointSpeed "NORMAL";
			_waypoint setWaypointBehaviour "AWARE";
			_boatgroup setCurrentWaypoint [_boatgroup,(_waypoint select 1)];	
			_waypoint2 = _boatgroup addwaypoint[_WayPointPosition,0];
			_waypoint2 setwaypointtype "MOVE";
			_waypoint2 setWaypointSpeed "NORMAL";
			_waypoint2 setWaypointBehaviour "AWARE";
	
			/*
			_direction = [(getpos _veh),_WayPointPosition] call BIS_fnc_dirTo;
			_veh setdir _direction;
			_veh spawn {sleep 10;_this allowdamage true};

			_speed = 50;
			_veh setVelocity [(sin _direction*_speed),(cos _direction*_speed),1];						
			*/
			
			//SYSTEMCHAT format ["_boatgroup: %1",_boatgroup];
			//SYSTEMCHAT format ["_boatgroup UNIT count: %1",count (units _boatgroup)];
			_Attached = true;
			_LandCount = 0;
			sleep 10;			
			while {_Attached && {{alive _x} count (units _boatgroup) > 0}} do
			{
				sleep 3;
				_PositionA = getpos (leader _boatgroup);
				/*
				_rnd = random 15;
				_dist = (_rnd + 100);
				_dir = random 360;
				_positions = [(_Position select 0) + (sin _dir) * _dist, (_Position select 1) + (cos _dir) * _dist, 0];	
				*/
				
				_positions = [_PositionA, 0, 50, 1, 0, 1, 1] call BIS_fnc_findSafePos;
				if (Dis_WorldCenter isEqualTo _positions) then 
				{
					_Range = 100;
					while {Dis_WorldCenter isEqualTo _positions} do
					{
						_positions = [_PositionA, 0, _Range, 1, 0, 1, 1] call BIS_fnc_findSafePos;	
						_Range = _Range + 100;
						sleep 0.05;
					};	
				};

				
				_isWater = surfaceIsWater _positions;
				if (_positions distance (leader _boatgroup) > 150) then {_isWater = true;};	
				if !(_isWater) then {_LandCount = _LandCount + 2} else {if (_LandCount > 0) then {_LandCount = _LandCount - 1;}};							
				//Time to drop off these vehicle.
				if (_LandCount >= 6) then 
				{
					sleep 5;
					while {speed _veh > 10} do
					{
						sleep 2;
						//SYSTEMCHAT format ["_veh move: %1",_veh];
					};				
					//SYSTEMCHAT format ["(leader _boatgroup: %1",(leader _boatgroup)];
					_PositionA = getpos (leader _boatgroup);						
					_positions = [_PositionA, 0, 50, 1, 0.7, 1, 1] call BIS_fnc_findSafePos;		
					if (Dis_WorldCenter isEqualTo _positions) then 
					{
						_Range = 100;
						while {Dis_WorldCenter isEqualTo _positions} do
						{
							_positions = [_PositionA, 1, _Range, 1, 0.7, 1, 1] call BIS_fnc_findSafePos;	

							_Range = _Range + 250;
							sleep 0.05;
						};	
					};




					
					{
						private _Compos = _positions;
						private _rnd = random 50;
						private _dist = (_rnd + 5);
						private _dir = random 360;
						private _positionsLand = [(_ComPos select 0) + (sin _dir) * _dist, (_ComPos select 1) + (cos _dir) * _dist, 0];
						private _position = _positionsLand findEmptyPosition [10,100,"B_Survivor_F"];
						if (_position isEqualTo []) then {_position = _positionsLand;};
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
						}
						else
						{
								_x setpos _position;
								_x enableSimulationGlobal true;
								_x hideObjectGlobal false;						
						};
					} forEach units (_group);
					_group setVariable ["DIS_BoatN",false];
					_Attached = false;

				};
			};
			if ({alive _x} count (units _boatgroup) < 1) then
			{
				{if !(_x isEqualTo vehicle _x) then {deletevehicle (vehicle _x);};deleteVehicle _x;} forEach units (_group); 
			};
			{deleteVehicle _x; } foreach units _boatgroup;			
			deletevehicle _veh;

			
			_LandCount = 0;
			_WaterCount = 0;
			_GlobalContinue = false;
	};