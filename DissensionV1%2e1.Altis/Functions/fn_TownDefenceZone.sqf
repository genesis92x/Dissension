//This function will find and create three circles in a town that players can choose to hold/capture to reduce the difficulty of the town. This will also speed up capturing the town.
//AI will attempt to re-take these zones.
//[_StrongHoldBuildings,Resistance] spawn DIS_fnc_TownDefenceZone;


//First things first, lets figure out the passed variables.
params ["_StrongHoldBuildings","_SSide","_Pole","_OriginalAmount"];

if (_StrongHoldBuildings isEqualTo []) exitWith {};

{
	[_x,_SSide,_Pole,_OriginalAmount] spawn
	{
		sleep (random 15);
		params ["_SelStronghold","_SSide","_Pole","_OriginalAmount"];
		//Lets determine what list of units we can spawn
		private _InfantryList = R_BarrackLU;
		private _FactoryList = R_LFactDef;
		if (_SSide isEqualTo West) then
		{
			_InfantryList = [];
			{
				_InfantryList pushback (_x select 0);
			} foreach W_BarrackU;
		
			_FactoryList = [];
			{
				_FactoryList pushback (_x select 0);
			} foreach W_LFactU;	
			
			_GroupNames = W_Groups;
		};
		if (_SSide isEqualTo East) then
		{
			_InfantryList = [];
			{
				_InfantryList pushback (_x select 0);
			} foreach E_BarrackU;
		
			_FactoryList = [];
			{
				_FactoryList pushback (_x select 0);
			} foreach E_LFactU;	
			_GroupNames = E_Groups;
		};
		
		private _StrongHoldBuildingsPos = [_SelStronghold] call BIS_fnc_buildingPositions;
		
		private _grp = createGroup _SSide;
		if !(_StrongHoldBuildingsPos isEqualTo []) then
		{
			private _SpawnChance = 100;
			private _SpwnCount = 0;
			{
				if (_SpawnChance >= (random 100)) then
				{
					if (_SpwnCount < 6) then
					{
						_SpwnCount = _SpwnCount + 1;
						private _unit = _grp createUnit [(selectRandom _InfantryList) ,[0,0,0], [], 0, "NONE"];
						[_unit] joinSilent _grp;
						_unit setpos _x;
						_unit disableAI "PATH";
						_unit addEventHandler ["HitPart", {_this call dis_HitPart}];
						_unit addEventHandler ["Hit", {_this call dis_HitDamage}];
						_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
						private _SpwnAmnt = (_Pole getVariable "DIS_Capture") select 1;
						private _SSideN = (_Pole getVariable "DIS_Capture") select 2;
						_SpwnAmnt = _SpwnAmnt - 1;
						_Pole setVariable ["DIS_Capture",[_OriginalAmount,_SpwnAmnt,_SSideN],true];
					};
					sleep 1;
				};
				_SpawnChance = _SpawnChance - 10;
			} foreach _StrongHoldBuildingsPos;
		}
		else
		{
				private _SpwnAmnt = (_Pole getVariable "DIS_Capture") select 1;
				private _SSideN = (_Pole getVariable "DIS_Capture") select 2;				
				_SpwnAmnt = _SpwnAmnt - 8;
				_Pole setVariable ["DIS_Capture",[_OriginalAmount,_SpwnAmnt,_SSideN],true];					
			{
				private _unit = _grp createUnit [(selectRandom _InfantryList) ,[0,0,0], [], 0, "NONE"];
				[_unit] joinSilent _grp;
				_unit setpos (getpos _SelStronghold);
				_unit disableAI "PATH";
				_unit addEventHandler ["HitPart", {_this call dis_HitPart}];
				_unit addEventHandler ["Hit", {_this call dis_HitDamage}];
				_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];			
				sleep 1;
			} count [1,2,3,4];
		};
		
		private _Leader = leader _grp;
		private _MyNearestEnemy = _Leader call VCOMAI_ClosestEnemy;
		private _PreviousCount = {alive _x} count (units _grp);
		private _SpwnContinue = true;
		while {alive _Leader && {(_MyNearestEnemy distance _Leader < 1000)} && {_SpwnContinue} && {_Pole getVariable ["DIS_ENGAGED",false]}} do 
		{
			private _MyNearestEnemy = _Leader call VCOMAI_ClosestEnemy;
			if (_MyNearestEnemy distance _Leader < 800 && {_MyNearestEnemy distance _Leader > 100}) then
			{
				private _NewCount = {alive _x} count (units _grp);
				if (_NewCount - _PreviousCount < 1) then
				{
						{
							//private _position = [(getpos _Leader),50,25] call dis_randompos;
							private _unit = _grp createUnit [(selectRandom _InfantryList) ,[0,0,0], [], 0, "NONE"];
							[_unit] joinSilent _grp;
							_unit setpos (selectRandom _StrongHoldBuildingsPos);
							_unit addEventHandler ["HitPart", {_this call dis_HitPart}];
							_unit addEventHandler ["Hit", {_this call dis_HitDamage}];
							_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
							true;
						} count [1,2,3];
						private _position = [_Leader,300,250] call dis_randompos;
						_Finalposition = [_position, 1, 150, 5, 0, 20, 0,[],[_position,_position]] call BIS_fnc_findSafePos;
						_waypoint = _grp addwaypoint[_Finalposition,1];
						_waypoint setwaypointtype "MOVE";
						_waypoint setWaypointSpeed "NORMAL";
						_waypoint setWaypointBehaviour "SAFE";						
						private _SpwnAmnt = (_Pole getVariable "DIS_Capture") select 1;
						private _SSideN = (_Pole getVariable "DIS_Capture") select 2;						
						_SpwnAmnt = _SpwnAmnt - 3;
						if !(_SSide isEqualTo _SSideN) then {_SpwnContinue = false;};
						_Pole setVariable ["DIS_Capture",[_OriginalAmount,_SpwnAmnt,_SSideN],true];		
				};					
			};
			
			sleep (300 + (random 200));
		};
		

		{
			_x enableAI "PATH";
		} foreach (units _grp);
		
		private _Leader = leader _grp;		
		private _MyNearestEnemy = _Leader call VCOMAI_ClosestEnemy;
		_waypoint = _grp addwaypoint[(getpos _MyNearestEnemy),1];
		_waypoint setwaypointtype "MOVE";
		_waypoint setWaypointSpeed "NORMAL";
		_waypoint setWaypointBehaviour "SAFE";		
		
		

	};
} foreach _StrongHoldBuildings;
//_Pole setVariable ["DIS_Capture",[_OriginalAmount,_SpawnAmount,Resistance],true];	