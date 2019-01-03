//Function for allowing troops to transport from one area of the map to the next. Over water, over distances, and etc.
//This is probably the 3rd take on this function. The last A3 update appears to have broken some code that I use here...
//The function will be as simple as possible. It will sacrifice realism but will aim to work the majority of the time.
params ["_Leader","_wPos"];




//1st we need to see if the group actually needs to be transported across. Let's go ahead and define some basic variables here.
private _direction = _Leader getdir _wPos;
private _NewPosition = [0,0,0];
private _UnitPos = getpos _Leader;
private _Group = group _Leader;
private _MovementDistance = 50;
private _WpArrayCheck = [];
private _CargoCrate = nil;
private _myRope = "";
private _VicksInGrp = false;

//if the _wPos is [0,0,0] then we need to exit. This means if the AI are pathing to some stupid location, we need to stop them from doing that.
if (_wPos distance2D [0,0,0] < 100) exitWith {_Group setVariable ["DIS_FCheck",false];};

private _LandAgain = false;
While {_NewPosition distance2D _wPos > 150 && {{alive _x} count (units _Group) > 0}} do
{
	_NewPosition = [_UnitPos,_MovementDistance,_direction] call BIS_fnc_relPos;	
	if (surfaceIsWater _NewPosition) then {_WpArrayCheck pushback _NewPosition;_LandAgain = true;};
	_MovementDistance = _MovementDistance + 50;
	sleep 0.001;
};


private _ExecCheck = (count _WpArrayCheck);

//If there is greater than 1 water points, OR the travel distance is greater than 1.5KM, let's call in air transport.
if ((_ExecCheck > 0 && {_UnitPos distance2D _wPos > 200}) || _UnitPos distance2D _wPos > 3000) exitWith
{
		//Make sure the group is marked as important. And mark them as being transported
		_Group setVariable ["DIS_BoatN",true];
		_Group setVariable ["DIS_IMPORTANT",true];	
		
		//Now let's spawn in the appropriate air transport. This will simply spawn above them, and fly to the location. This acts more like a signal for the players to see somethign is being transported.
		private _SpawnSide = side (_Group);
		
		private _TransportVeh = (W_TransportUnit select 0);
		
		if (_SpawnSide isEqualTo east) then
		{
			_TransportVeh = (E_TransportUnit select 0);
		};
		if (_SpawnSide isEqualTo resistance) then
		{
			_TransportVeh = (R_TransportUnit select 0);
		};		
	
		private _veh = createVehicle [_TransportVeh, [(_UnitPos select 0),(_UnitPos select 1),((_UnitPos select 2) + 200)], [], 0, "FLY" ];
		private _SpawnPoint = getpos _veh;
		
		_veh allowdamage false;_veh spawn {sleep 30;_this allowDamage true;};
		private _HeliGroup = creategroup _SpawnSide;
		createVehicleCrew _veh;
		_veh setVariable ["DIS_BoatN",true];
		_veh setvariable ["DIS_PLAYERVEH",true,true];
		{[_x] joinSilent _HeliGroup;_x disableAI "COVER";_x disableAI "AUTOCOMBAT";_x disableAI "AUTOTARGET";_x disableAI "TARGET";} foreach (crew _veh);
		_HeliGroup setVariable ["DIS_BoatN",true];
		_HeliGroup setVariable ["DIS_IMPORTANT",true];
		_veh setBehaviour "SAFE";		
		_veh setdir _direction;		
		
		//Clean them up after a set amount of time
		[_HeliGroup,_veh] spawn 
		{
			params ["_HeliGroup","_Veh"];
			sleep 900;
			deleteVehicle _Veh;
			{deleteVehicle _x} foreach (units _HeliGroup);
		};
		
		
		//Now let's tell the bird to move to the waypoint.
		private _waypoint = _HeliGroup addwaypoint[_wPos,0];
		_waypoint setwaypointtype "MOVE";
		_waypoint setWaypointSpeed "NORMAL";
		_waypoint setWaypointBehaviour "AWARE";
		_HeliGroup setCurrentWaypoint [_HeliGroup,(_waypoint select 1)];	
		private _waypoint2 = _HeliGroup addwaypoint[_wPos,0];
		_waypoint2 setwaypointtype "MOVE";
		_waypoint2 setWaypointSpeed "NORMAL";
		_waypoint2 setWaypointBehaviour "AWARE";		
	
		//Now we need to check if the bird made it, or is dead.
		waitUntil
		{
			(!(alive _veh) || (!(alive (driver _veh))) || (_veh distance2D _wPos < 200))
		};
		
		private _VehPos = (getpos _Veh);	
		
		_veh land "LAND";
	
		waitUntil
		{
			(!(alive _veh) || (!(alive (driver _veh))) || ((getpos _veh) select 2 < 10))
		};	
		private _ActLandingLocation = getpos _veh;
		_veh setFuel 0;
		//Now we need to move all the units to the appropriate location
		{
			private _rnd = random 15;
			private _dist = (_rnd + 5);
			private _dir = random 360;
			private _positionsLand = [(_ActLandingLocation select 0) + (sin _dir) * _dist, (_ActLandingLocation select 1) + (cos _dir) * _dist, 0];
			private _position = _positionsLand findEmptyPosition [10,100,(typeOf (vehicle _x))];
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
					private _positionsLand = [(_ActLandingLocation select 0) + (sin _dir) * _dist, (_ActLandingLocation select 1) + (cos _dir) * _dist, 0];
					private _position = _positionsLand findEmptyPosition [10,100,(typeOf (vehicle _x))];
					if (_position isEqualTo []) then {_position = _positionsLand;};
					if !(surfaceisWater _position) then {_WaterGoGo = false};
					_Attempts = _Attempts + 1;
					sleep 0.01;
				};
			};
			private _Vehicle = vehicle _x;
			if !(_x isEqualTo _Vehicle) then
			{
				if !(_Vehicle isKindOf "AIR") then
				{
					if (driver _Vehicle isEqualTo _x) then
					{
						_Vehicle setpos _position;							
					};
				};
			}
			else
			{
					_x setpos _position;						
			};
		
			sleep 1;
		} forEach units (_Group);		
		
		//Now the bird needs to fly away
		sleep 20;
		_veh setFuel 1;
		private _waypoint = _HeliGroup addwaypoint[_SpawnPoint,0];
		_waypoint setwaypointtype "MOVE";
		_waypoint setWaypointSpeed "NORMAL";
		_waypoint setWaypointBehaviour "AWARE";
		_HeliGroup setCurrentWaypoint [_HeliGroup,(_waypoint select 1)];	
		private _waypoint2 = _HeliGroup addwaypoint[_SpawnPoint,0];
		_waypoint2 setwaypointtype "MOVE";
		_waypoint2 setWaypointSpeed "NORMAL";
		_waypoint2 setWaypointBehaviour "AWARE";			
		
		waitUntil
		{
			(!(alive _veh) || (!(alive (driver _veh))) || (_veh distance2D _SpawnPoint < 200))
		};	
		
		deleteVehicle _Veh;
		{deleteVehicle _x} foreach (units _HeliGroup);		
		
};