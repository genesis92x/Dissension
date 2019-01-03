//Lets construct a report on the number of units lost

if (_this isEqualTo West) then
{
	_CurrentCount = W_ActivePollC;
	_CurrentActive = count W_ActiveUnits;
	
	
	_DeadCount = 0;
	_AliveCount = 0;
	{
		if !(isPlayer _x) then
		{
			if (!(alive _x) || isNull _x) then
			{
				_DeadCount = _DeadCount + 1;
				if (_x in W_ActiveUnits) then {_x spawn {W_ActiveUnits = W_ActiveUnits - [_this];sleep 600;hideBody _this; sleep 6; deleteVehicle _this;}};
			}
			else
			{
				if !(isNull (driver _x)) then
				{
					_AliveCount = _AliveCount + 1;
				}
				else
				{
					_DeadCount = _DeadCount + 1;
					if (_x in W_ActiveUnits) then {_x spawn {W_ActiveUnits = W_ActiveUnits - [_this];sleep 600;hideBody _this; sleep 6; deleteVehicle _this;}};;			
				};
			};
			if (isNull _x) then
			{
				if (_x in W_ActiveUnits) then {_x spawn {W_ActiveUnits = W_ActiveUnits - [_this];};};					
			};	
			private _m = magazinesAmmoFull _x;
			private _a = 0;
			{
				if (_x select 3 isEqualTo 1) then {_a = _a + 1;};			
			} foreach _m;
			if (_a < 3) then
			{
				_x setVehicleAmmoDef 1;
			};
			
			private _m = magazinesAmmoFull (vehicle _x);
			private _a = 0;
			{
				if (_x select 3 isEqualTo -1) then {_a = _a + 1;};			
			} foreach _m;
			if (_a < 6) then
			{
				private _Weap = primaryWeapon (vehicle _x);
				if !(_Weap isEqualTo "") then
				{
					private _mags = getArray (configFile / "CfgWeapons" / _Weap / "magazines");
					private _mag = (selectRandom _mags);
					(vehicle _x) addMagazines [_mag, 1];
				};				
			};		
			private _NE = _x call dis_ClosestEnemy;
			if (_NE distance2D _x > 1000) then 
			{
				_x setDamage 0;
				(vehicle _x) setDamage 0;
				(vehicle _x) setFuel 1;
			};			
		};
	} foreach allunits select {side _x isEqualTo west};
	
	/*
	{
		if (!(isPlayer _x) && {!(_x in W_ActiveUnits)} && {!(_x isEqualTo DIS_WestCommander)} && {!((group _x) getVariable ["DIS_BoatN",false])} && {!((group _x) getVariable ["DIS_IMPORTANT",false])}) then
		{
			private _NE = _x call dis_ClosestEnemy;
			if (_NE distance2D _x > 1200) then
			{
				_x setdamage 1;
			};
		};
	} foreach (allUnits select {(side (group _x) isEqualTo West)});
	*/

	
	
	
	//Lets see if we lost alot of troops - or gained a good amount of troops
	
	//We have less than 50 of our previously known troops alive.
	
	/*
	if (_DeadCount > _AliveCount/2) then 
	{
	
		_AddNewsArray = ["Heavy Casualties:",format ["We lost %1 men! We currently have %2 still alive. This is down from the %3 men we used to have.",_DeadCount,_AliveCount,_CurrentActive]  ];
		dis_WNewsArray pushback _AddNewsArray;
		publicVariable "dis_WNewsArray";
		
		["Beep_Target"] remoteExec ["PlaySoundEverywhere",West];
		["HEAVY CASUALTIES",'#FFFFFF'] remoteExec ["MessageFramework",West];	
		W_CurrentDecisionM = true;
		W_CurrentDecisionC = true;
		W_CurrentDecisionO = true;
		W_CurrentDecisionP = true;
		W_CurrentDecisionEXP = true;
		W_CurrentDecisionD = true;
		W_CurrentDecisionT = true;
		W_CurrentTargetArray = [];
	};
	*/
	if (count (W_ActiveUnits select {alive _x}) < 12) then
	{
		W_CurrentDecisionM = true;
		W_CurrentDecisionC = true;
		W_CurrentDecisionO = true;
		W_CurrentDecisionP = true;
		W_CurrentDecisionD = true;
		W_CurrentDecisionT = true;
		if !(W_CurrentTargetArray isEqualTo [1,1,1,1,1]) then {W_CurrentTargetArray = []};	
	};

}
else
{
	_CurrentCount = E_ActivePollC;
	_CurrentActive = count E_ActiveUnits;
	
	
	_DeadCount = 0;
	_AliveCount = 0;
	{
		if (!(alive _x) || isNull _x) then
		{
			_DeadCount = _DeadCount + 1;
			_x spawn {E_ActiveUnits = E_ActiveUnits - [_this];sleep 600;hideBody _this; sleep 6; deleteVehicle _this;};
		}
		else
		{
			if !(isNull (driver _x)) then
			{
				_AliveCount = _AliveCount + 1;
			}
			else
			{
				_DeadCount = _DeadCount + 1;
				_x spawn {E_ActiveUnits = E_ActiveUnits - [_this];sleep 600;hideBody _this; sleep 6; deleteVehicle _this;};			
			};
		};
		if (isNull _x) then
		{
			_x spawn {E_ActiveUnits = E_ActiveUnits - [_this];};					
		};
		
		private _m = magazinesAmmoFull (vehicle _x);
		private _a = 0;
		{
			if (_x select 3 isEqualTo -1) then {_a = _a + 1;};			
		} foreach _m;
		if (_a < 6) then
		{
			private _Weap = primaryWeapon (vehicle _x);
			if !(_Weap isEqualTo "") then
			{
				private _mags = getArray (configFile / "CfgWeapons" / _Weap / "magazines");
				private _mag = (selectRandom _mags);
				(vehicle _x) addMagazines [_mag, 1];
			};				
		};		
		
	} foreach E_ActiveUnits;
	
	
	{
		if !(isPlayer _x) then
		{
			if (!(alive _x) || isNull _x) then
			{
				_DeadCount = _DeadCount + 1;
				if (_x in E_ActiveUnits) then {_x spawn {E_ActiveUnits = E_ActiveUnits - [_this];sleep 600;hideBody _this; sleep 6; deleteVehicle _this;}};
			}
			else
			{
				if !(isNull (driver _x)) then
				{
					_AliveCount = _AliveCount + 1;
				}
				else
				{
					_DeadCount = _DeadCount + 1;
					if (_x in E_ActiveUnits) then {_x spawn {E_ActiveUnits = E_ActiveUnits - [_this];sleep 600;hideBody _this; sleep 6; deleteVehicle _this;}};;			
				};
			};
			if (isNull _x) then
			{
				if (_x in E_ActiveUnits) then {_x spawn {E_ActiveUnits = E_ActiveUnits - [_this];};};					
			};	
			private _m = magazinesAmmoFull _x;
			private _a = 0;
			{
				if (_x select 3 isEqualTo 1) then {_a = _a + 1;};			
			} foreach _m;
			if (_a < 3) then
			{
				_x setVehicleAmmoDef 1;
			};
			
			private _m = magazinesAmmoFull (vehicle _x);
			private _a = 0;
			{
				if (_x select 3 isEqualTo -1) then {_a = _a + 1;};			
			} foreach _m;
			if (_a < 6) then
			{
				private _Weap = primaryWeapon (vehicle _x);
				if !(_Weap isEqualTo "") then
				{
					private _mags = getArray (configFile / "CfgWeapons" / _Weap / "magazines");
					private _mag = (selectRandom _mags);
					(vehicle _x) addMagazines [_mag, 1];
				};				
			};		
			private _NE = _x call dis_ClosestEnemy;
			if (_NE distance2D _x > 1000) then 
			{
				_x setDamage 0;
				(vehicle _x) setDamage 0;
				(vehicle _x) setFuel 1;
			};			
		};
	} foreach allunits select {side _x isEqualTo east};	
	
	
	
	/*
	{
		if (!(isPlayer _x) && {!(_x in E_ActiveUnits)} && {!(_x isEqualTo DIS_EastCommander)} && {!((group _x) getVariable ["DIS_BoatN",false])} && {!((group _x) getVariable ["DIS_IMPORTANT",false])}) then
		{
			private _NE = _x call dis_ClosestEnemy;
			if (_NE distance2D _x > 1200) then
			{
				_x setdamage 1;			
			};
		};
	} foreach (allUnits select {(side (group _x) isEqualTo East)});	
	*/
	
	//Lets see if we lost alot of troops - or gained a good amount of troops
	
	//We have less than 50 of our previously known troops alive.
	
	/*
	if (_DeadCount > _AliveCount/2) then 
	{
	
		_AddNewsArray = ["Heavy Casualties:",format ["We lost %1 men! We currently have %2 still alive. This is down from the %3 men we used to have.",_DeadCount,_AliveCount,_CurrentActive]  ];
		dis_ENewsArray pushback _AddNewsArray;
		publicVariable "dis_ENewsArray";
		["Beep_Target"] remoteExec ["PlaySoundEverywhere",East];
		["HEAVY CASUALTIES",'#FFFFFF'] remoteExec ["MessageFramework",East];	
		E_CurrentDecisionM = true;
		E_CurrentDecisionC = true;
		E_CurrentDecisionO = true;
		E_CurrentDecisionP = true;
		E_CurrentDecisionEXP = true;
		E_CurrentDecisionD = true;
		E_CurrentDecisionT = true;
		E_CurrentTargetArray = [];		
	};
	*/
	if (count (E_ActiveUnits select {alive _x}) < 12) then
	{
		E_CurrentDecisionM = true;
		E_CurrentDecisionC = true;
		E_CurrentDecisionO = true;
		E_CurrentDecisionP = true;
		E_CurrentDecisionD = true;
		E_CurrentDecisionT = true;
		if !(E_CurrentTargetArray isEqualTo [1,1,1,1,1]) then {E_CurrentTargetArray = []};	
	};



};