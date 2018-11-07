private _WestActive = [];
private _EastActive = [];
private _ResistanceActive = [];
private _OpBlu = [];

{
	private _g = _x;
	if (side _g isEqualTo west) then {{_WestActive pushback _x;_OpBlu pushback _x;} foreach (units _g);};
	if (side _g isEqualTo east) then {{_EastActive pushback _x;_OpBlu pushback _x;} foreach (units _g);};
	if (side _g isEqualTo resistance) then {{_ResistanceActive pushback _x;} foreach (units _g);};
} foreach allgroups;	

/*
{
	//[_WestActive,_EastActive,_ResistanceActive,_x,_OpBlu,_forEachIndex] spawn
	//{
		//params ["_WestActive","_EastActive","_ResistanceActive","_x","_OpBlu","_forEachIndex"];
		private _EnemyForce = [];
		private _Pole = _x select 2;
		private _SSide = resistance;
		private _PoleList = [];
		if (_Pole in IndControlledArray) then {_EnemyForce = _OpBlu;_PoleList = IndControlledArray;};
		if (_Pole in BluControlledArray) then {_EnemyForce = _EastActive;_SSide = west;_PoleList = BluControlledArray;};
		if (_Pole in OpControlledArray) then {_EnemyForce = _WestActive;_SSide = east;_PoleList = OpControlledArray;};
		private _PolePos = getPosWorld _Pole;
		private _Marker = _x select 3;

			private _ActiveCnt = 0;
			//Check if any enemy unit is close enough to be activated.
			private _ClosestUnit = [_EnemyForce,_PolePos,true,"towncheck25"] call dis_closestobj;
			if (side (group _ClosestUnit) isEqualTo west) then {_ActiveCnt = DIS_WestTSpwn;};
			if (side (group _ClosestUnit) isEqualTo east) then {_ActiveCnt = DIS_EastTSpwn;};
			if (_ActiveCnt < DIS_TLimit) then 
			{
			private _ClosestPlayer = [(allplayers select {[_SSide,(side (group _x))] call BIS_fnc_sideIsEnemy;}),_PolePos,true,"towncheck26"] call dis_closestobj;
			private _ClosestTown = [_PoleList,_ClosestPlayer,true,"towncheck27"] call dis_closestobj;
			private _sidecu = side (Group _ClosestUnit);
			private _Terr = [_sidecu,false,false] call dis_compiledTerritory; //This will ONLY return towns
			private _ClosestTer = [_Terr,_PolePos,true] call dis_closestobj;
			if (((_ClosestUnit distance2D _PolePos) < (((getMarkerSize _Marker) select 0) - 10) && {_ClosestTer distance2D _PolePos < 3001} && {((getpos _ClosestUnit) select 2) < 30}) || (_ClosestTown isEqualTo _Pole && {_ClosestPlayer distance2D _ClosestTown < 1100} && {((getpos _ClosestPlayer) select 2) < 30})) then
			{
				private _Engaged = _x select 7;
				if (!(_Engaged) && {!(_Pole getVariable ["DIS_ENGAGED",false])}) then
				{
					//Since the grid is not already active we need to activate it and spawn dem enemies
					(TownArray select _forEachIndex) set [7,true];
					[_x,_forEachIndex,_Engaged,_SSide,_ClosestUnit] spawn DIS_fnc_DefenceSpawn;
					[_x] call DIS_fnc_DisplayActiveT;
					if ((side (group _ClosestUnit)) isEqualTo West) then {DIS_WENGAGED pushBack [_Pole,_Marker];publicVariable "DIS_WENGAGED";} else {DIS_EENGAGED pushBack [_Pole,_Marker]; publicVariable "DIS_EENGAGED";};
				};
			};
		};
	//};
	//sleep 1;
} foreach TownArray;
*/

{
	//[_WestActive,_EastActive,_ResistanceActive,_x,_OpBlu,_forEachindex] spawn
	//{
	//params ["_WestActive","_EastActive","_ResistanceActive","_x","_OpBlu","_forEachIndex"];
	private _EnemyForce = [];
	private _Sel = _x select 1;
	private _GridM = _x select 2;
	private _location = _x select 4;
	private _GridMPos = (getMarkerPos _GridM);
	private _SSide = resistance;
	if (_GridM in IndLandControlled) then {_EnemyForce = _OpBlu;};
	if (_GridM in BluLandControlled) then {_EnemyForce = _EastActive;_SSide = west;};
	if (_GridM in OpLandControlled) then {_EnemyForce = _WestActive;_SSide = east;};		
			
	private _ClosestUnit = [_EnemyForce,_GridMPos,true] call dis_closestobj;
	private _sidecu = side (Group _ClosestUnit);
	
	private _Terr = [_sidecu,true] call dis_compiledTerritory;
	private _ClosestTer = [_Terr,_GridMPos,true] call dis_closestobj;
	
	if ((_ClosestUnit distance2D _GridMPos) < 490 && {((getpos _ClosestUnit) select 2) < 40} && {_ClosestTer distance2D _GridMPos < 3001}) then
	{
		//Lets check if the marker is already active.	
		private _Engaged = _x select 3;	
		if (!(_Engaged) && {!(_location getVariable ["DIS_ENGAGED",false])} && {((_location getVariable ["DIS_ObjArray",[]]) isEqualTo [])}) then
		{
			private _SpwnLoc = _x select 5;	
			//Since the grid is not already active we need to activate it and spawn dem enemies
			[_SpwnLoc,_Sel,_location] spawn DIS_fnc_SpawnPrefab;
			//[(getpos player),["Power",25],player] spawn DIS_fnc_SpawnPrefab;
			(CompleteRMArray select _forEachIndex) set [3,true];			
			[_x,_forEachIndex,_Engaged,_SSide] spawn DIS_fnc_DefenceSpawnGrid;
		};
	}
	else
	{
			//_location setVariable ["DIS_ENGAGED",false];
			//(CompleteRMArray select _forEachIndex) set [3,false];		
			private _ObjArray = _location getVariable ["DIS_ObjArray",[]];
			if !(_ObjArray isEqualTo []) then
			{
				{
					deleteVehicle _x;
				} foreach _ObjArray;
				_location setVariable ["DIS_ObjArray",[]];
			};
	};
	//};
	//sleep 1;
} foreach CompleteRMArray;	