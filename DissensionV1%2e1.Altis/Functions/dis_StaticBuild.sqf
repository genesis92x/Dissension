private ["_grp", "_waypoint", "_unit", "_StaticArray", "_DefenceArray", "_wPos", "_DistanceCheck", "_rnd", "_dist", "_dir", "_position", "_positionA", "_positionFIN2", "_list", "_Road", "_CRoad", "_positionFIN", "_CE", "_RoadStatic", "_RandomStatic", "_Marker", "_AddNewsArray"];
//This function will build static weapons for both OPFOR and Blufor.
_grp = _this select 0;
_waypoint = _this select 1;
_unit = _this select 2;
private _WestRun = false;
if ((side _grp) isEqualTo West) then {_WestRun = true;};

private _Mrkrcolor = "ColorRed";
private _RSide = East;
private _MrkrType = "o_installation";
private _StaticArray = E_StaticWeap;
if (_WestRun) then
{
	_Mrkrcolor = "ColorBlue";
	_RSide = West;
	_MrkrType = "b_installation";
	_StaticArray = W_StaticWeap;
};



_DefenceArray = ["Land_CncBarrierMedium4_F","Land_Bag_Fence_Long_F"];

//While the unit is moving we want to check for distance every 15 seconds or so. This does not need to be responsive at all.
_wPos = waypointPosition [_grp,(_waypoint select 1)];
_DistanceCheck = 100;
while {(leader _grp) distance _wPos > _DistanceCheck && {{alive _x} count (units _grp) > 0}} do
{
		sleep 15;
		if !((leader _grp) isEqualTo (vehicle (leader _grp))) then {_DistanceCheck = _DistanceCheck + 25;};
};


//Once the target destonation is reached...lets setup some statics!
//Lets setup 1 static on the road, and 1 static else-where. This is a basic system for now. Statics near roads will ensure 'choke-points' for vehicle AI, with random surprises elsewhere.
_rnd = (random 150);
_dist = (_rnd + 25);
_dir = random 360;

_position = [(_wPos select 0) + (sin _dir) * _dist, (_wPos select 1) + (cos _dir) * _dist, 0];
_positionA = [(_wPos select 0) + (sin _dir) * _dist, (_wPos select 1) + (cos _dir) * _dist, 0];
_positionFIN2 = _positionA findEmptyPosition [0,150,"B_HMG_01_high_F"];	

_list = _position nearRoads 1000;
if !(_list isEqualTo []) then
{
	_Road = [_list,_position,true] call dis_closestobj;
	_CRoad = getpos _Road;
}
else
{
	_CRoad = _position;
};
		
_positionFIN = _CRoad findEmptyPosition [0,150,"B_HMG_01_high_F"];	
if (_positionFIN isEqualTo []) then {_positionFIN = _CRoad};
if (_positionFIN2 isEqualTo []) then {_positionFIN2 = _positionA};



_CE = _unit call dis_ClosestEnemy;

//Static on road
_RoadStatic = ((selectRandom _StaticArray) select 0) createVehicle _positionFIN;
_RoadStatic setDir (_RoadStatic getdir _CE);
_grpS = creategroup (side _grp);
_grpS setVariable ["Vcm_Disable",true];
createVehicleCrew _RoadStatic;			
{[_x] joinsilent _grpS} forEach crew _RoadStatic;
_RoadStatic setpos (getpos _RoadStatic);

//Static in random position
_RandomStatic = ((selectRandom _StaticArray) select 0) createVehicle _positionFIN2;
_RandomStatic setvariable ["DIS_PLAYERVEH",true];
_RandomStatic setVariable ["DIS_SPECIAL",true];
_RoadStatic setvariable ["DIS_PLAYERVEH",true];
_RoadStatic setVariable ["DIS_SPECIAL",true];
_RandomStatic setDir (_RandomStatic getdir _CE);
_RandomStatic setpos (getpos _RandomStatic);
_grpS = creategroup (side _grp);
_grpS setVariable ["Vcm_Disable",true];
createVehicleCrew _RandomStatic;			
{[_x] joinsilent _grpS} forEach crew _RandomStatic;
{
	(group _x) setVariable ["Vcm_Disable",true];
} foreach (crew _RandomStatic);
{
	(group _x) setVariable ["Vcm_Disable",true];
} foreach (crew _RoadStatic);

{_unit deleteVehicleCrew _x} forEach crew _unit;
deleteVehicle _unit;

sleep 2;


[
[_RandomStatic,_Mrkrcolor,_MrkrType,_RSide],
{
	_RandomStatic = _this select 0;
	_Mrkrcolor = _this select 1;
	_MrkrType = _this select 2;
	_RSide = _this select 3;
	_Marker = createMarkerLocal [format ["ID_%1",_RandomStatic],(getpos _RandomStatic)];
	if (isServer) then {[_RSide,_Marker,_RandomStatic,"StaticBuild"] call DIS_fnc_mrkersave; };
	_Marker setMarkerTextLocal format ["%1",(configFile >>  "CfgVehicles" >> (typeof _RandomStatic) >> "displayName")call BIS_fnc_getCfgData];	
	_Marker setMarkerTypeLocal _MrkrType;	
	_Marker setMarkerShapeLocal 'ICON';
	_Marker setMarkerColorLocal _Mrkrcolor;
	_Marker setMarkerSizeLocal [0.25,0.25];	
	
	if (hasInterface) then
	{
		waitUntil {alive player};
		if (playerSide isEqualTo _RSide) then
		{
			_Marker setMarkerAlphaLocal 1;
		}
		else
		{
			_Marker setMarkerAlphaLocal 0;
		};			
		
		private _CrewStatic = crew _RandomStatic;		
		while {(count _CrewStatic isEqualTo 1) && {!(isNull _RandomStatic)}} do
		{
			_Marker setMarkerDirLocal (getdir _RandomStatic);
			private _CrewStatic = crew _RandomStatic;
			if (count _CrewStatic isEqualTo 1) then
			{
				private _CE = ((crew _RandomStatic) select 0) call dis_ClosestEnemy;
				if (_CE distance _RandomStatic > 200) then {_RandomStatic setDir (_RandomStatic getdir _CE);};
			};
			sleep 30;
		};
		sleep 5;
		deleteMarker _Marker;
	};
}

] remoteExec ["bis_fnc_Spawn",0]; 

sleep 2;
[
	[_RoadStatic,_Mrkrcolor,_MrkrType,_RSide],
	{
		_RoadStatic = _this select 0;
		_Mrkrcolor = _this select 1;
		_MrkrType = _this select 2;
		_RSide = _this select 3;
		_Marker = createMarkerLocal [format ["ID_%1",_RoadStatic],[0,0,0]];
		_Marker setMarkerTextLocal format ["%1",(configFile >>  "CfgVehicles" >> (typeof _RoadStatic) >> "displayName")call BIS_fnc_getCfgData];	
		_Marker setMarkerPosLocal (getposASL _RoadStatic);
		_Marker setMarkerShapeLocal 'ICON';
		_Marker setMarkerColorLocal _Mrkrcolor;
		_Marker setMarkerSizeLocal [0.25,0.25];
		_Marker setMarkerTypeLocal _MrkrType;		
		
		if (isServer) then {[_RSide,_Marker,_RoadStatic,"StaticBuild"] call DIS_fnc_mrkersave; };
		if (hasInterface) then
		{
			waitUntil {alive player};	
			if (playerSide isEqualTo _RSide) then
			{
				_Marker setMarkerAlphaLocal 1;
			}
			else
			{
				_Marker setMarkerAlphaLocal 0;
			};		
			private _CrewStatic = crew _RoadStatic;		
			while {(count _CrewStatic isEqualTo 1) && {!(isNull _RoadStatic)}} do
			{
				_Marker setMarkerDirLocal (getdir _RoadStatic);	
				private _CrewStatic = crew _RoadStatic;
				if (count _CrewStatic isEqualTo 1) then
				{			
					private _CE = ((crew _RoadStatic) select 0) call dis_ClosestEnemy;
					if (_CE distance _RoadStatic > 200) then {_RoadStatic setDir (_RoadStatic getdir _CE);};		
				};
				sleep 30;
			};
			sleep 5;
			deleteMarker _Marker;
		};
	}
	
] remoteExec ["bis_fnc_Spawn",0]; 






