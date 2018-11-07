	private _WestActive = [];
	private _EastActive = [];
	private _ResistanceActive = [];
	private _OpBlu = [];
	
	{
		if ((side (group _x)) isEqualTo west) then {_WestActive pushback _x;_OpBlu pushback _x;};
		if ((side (group _x)) isEqualTo east) then {_EastActive pushback _x;_OpBlu pushback _x;};
		if ((side (group _x)) isEqualTo resistance) then {_ResistanceActive pushback _x;};
	} foreach allunits;	
	
	{
			private _EnemyForce = [];
			private _Pole = _x select 2;
			private _SSide = resistance;
			private _PoleList = [];
			if (_Pole in IndControlledArray) then {_EnemyForce = _OpBlu;_PoleList = IndControlledArray;};
			if (_Pole in BluControlledArray) then {_EnemyForce = _EastActive + _ResistanceActive;_SSide = west;_PoleList = BluControlledArray;};
			if (_Pole in OpControlledArray) then {_EnemyForce = _WestActive + _ResistanceActive;_SSide = east;_PoleList = OpControlledArray;};
			private _PolePos = getpos _Pole;
			private _Marker = _x select 3;
			
			//Check if any enemy unit is close enough to be activated.
			private _ClosestUnit = [_EnemyForce,_PolePos,true] call dis_closestobj;
			private _ClosestPlayer = [(allplayers select {[_SSide,(side _x)] call BIS_fnc_sideIsEnemy;}),_PolePos,true] call dis_closestobj;
			private _ClosestTown = [_PoleList,_ClosestPlayer,true] call dis_closestobj;
			if (((_ClosestUnit distance _PolePos) < (((getMarkerSize _Marker) select 0) - 10) && {((getpos _ClosestUnit) select 2) < 40}) || (_ClosestTown isEqualTo _Pole && {_ClosestPlayer distance2D _ClosestTown < 1001} &&  {((getpos _ClosestPlayer) select 2) < 40})) then
			{
				private _Engaged = _x select 7;
				if (!(_Engaged) && !(_Pole getVariable ["DIS_ENGAGED",false])) then
				{
					//Since the grid is not already active we need to activate it and spawn dem enemies
					(TownArray select _forEachIndex) set [7,true];
					[_x,_forEachIndex,_Engaged,_SSide] spawn DIS_fnc_DefenceSpawn;
					
					[
					[_Pole,_SSide],
					{
							params ["_Pole","_SSide"];
							
							if (playerSide isEqualTo _SSide) then
							{
									private _m1 = createMarkerLocal [format ["%1",_Pole],(getpos _Pole)];
									_m1 setmarkershapeLocal "ICON";
									_m1 setMarkerTypeLocal "mil_warning";
									_m1 setmarkercolorLocal "ColorWhite";
									_m1 setmarkersizeLocal [1,1];
									_m1 setMarkerTextLocal "ENGAGED";
									_Pole setVariable ["DIS_MEngaged",_m1];
							};
					}
					
					] remoteExec ["bis_fnc_Spawn",0];										
					
			
					
				};
			}
			else
			{
				private _Engaged = _x select 7;
				if (!(_Engaged) && !(_Pole getVariable ["DIS_ENGAGED",false])) then
				{
					if (DIS_ReinforceTick > 115) then
					{
						private _OriginalAmount = (_Pole getVariable "DIS_Capture") select 0;
						private _SpwnAmnt = (_Pole getVariable "DIS_Capture") select 1;
						if (isNil "_SpwnAmnt") then {_SpwnAmnt = 25};
						if (isNil "_OriginalAmount") then {_OriginalAmount = _SpwnAmnt;};					
						_SpwnAmnt = _SpwnAmnt + 5;
						_Pole setVariable ["DIS_Capture",[_OriginalAmount,_SpwnAmnt,_SSide],true];
						//_Pole setVariable ["DIS_ENGAGED",false,true];				
						//(TownArray select _forEachIndex) set [7,false];
					};
	
			};

		};
	} foreach TownArray;
	
	{
		private _EnemyForce = [];
		private _Sel = _x select 1;
		private _GridM = _x select 2;
		private _location = _x select 4;
		private _GridMPos = (getMarkerPos _GridM);
		private _SSide = resistance;
		if (_GridM in IndLandControlled) then {_EnemyForce = _OpBlu;};
		if (_GridM in BluLandControlled) then {_EnemyForce = _EastActive + _ResistanceActive;_SSide = west;};
		if (_GridM in OpLandControlled) then {_EnemyForce = _WestActive + _ResistanceActive;_SSide = east;};		
		
		private _ClosestUnit = [_EnemyForce,_GridMPos,true] call dis_closestobj;
					
		
		if ((_ClosestUnit distance _GridMPos) < 490 && {((getpos _ClosestUnit) select 2) < 40}) then
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
				private _ObjArray = _location getVariable ["DIS_ObjArray",[]];
				if !(_ObjArray isEqualTo []) then
				{
					{
						deleteVehicle _x;
					} foreach _ObjArray;
					_location setVariable ["DIS_ObjArray",[]];
				};
				if (DIS_ReinforceTick > 115) then
				{
					private _OriginalAmount = (_location getVariable "DIS_Capture") select 0;
					private _SpwnAmnt = (_location getVariable "DIS_Capture") select 1;
					if (isNil "_SpwnAmnt") then {_SpwnAmnt = 25};	
					if (isNil "_OriginalAmount") then {_OriginalAmount = _SpwnAmnt;};
					_SpwnAmnt = _SpwnAmnt + 3;	
					_location setVariable ["DIS_Capture",[_OriginalAmount,_SpwnAmnt,_SSide],true];
					//(CompleteRMArray select _forEachIndex) set [3,false];	
					//_location setVariable ["DIS_ENGAGED",false];
				};

		};
		
	} foreach CompleteRMArray;	
	