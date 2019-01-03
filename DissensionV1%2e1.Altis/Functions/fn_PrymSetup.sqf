//Function for creating defensive structures that will get deleted by the end of the assault.
//[_DefendSide,_DefenceSpawnPos,_AttackSpawnPos,_Pole] call Dis_fnc_PrymSetup;

params ["_DefendSide","_DefenceSpawnPos","_AttackSpawnPos","_Pole"];


private _RandomNumber = (4 + (round (random 4)));
private _DefenceList = ["PrymSmallBase","PrymMortarNest","PrymMGNest","PrymAT2Nest","PrymAANest","PrymMineWall","DominicMGFortification","PrymDragonTeeth","PrymATMines","PrymMineObstacle"];


private _InfantryList = R_BarrackLU;
private _FactoryList = R_LFactDef;
private _HeavyFactoryList = R_HFactU;
private _GroupNames = R_Groups;
private _ControlledArray = IndControlledArray;
private _StaticList = R_StaticWeap;
private _AirList = R_AirU;


if (_DefendSide isEqualTo west) then
{
	_ActiveSide = W_ActiveUnits;
	_InfantryList = [];
	{
		_InfantryList pushback (_x select 0);
	} foreach W_BarrackU;

	_FactoryList = [];
	{
		_FactoryList pushback (_x select 0);
	} foreach W_LFactU;	
	
	
	_HeavyFactoryList = [];
	{
		_HeavyFactoryList pushback (_x select 0);
	} foreach W_HFactU;
	
	_AirList = [];
	{
		_AirList pushBack (_x select 0);
	} foreach W_AirU;
	
	_StaticList = [((W_StaticWeap select 0) select 0),((W_StaticWeap select 1) select 0),((W_StaticWeap select 2) select 0),((W_StaticWeap select 3) select 0)];
	
	_GroupNames = W_Groups;
	_ControlledArray = BluControlledArray;
	
};

if (_DefendSide isEqualTo east) then
{
	_ActiveSide = E_ActiveUnits;
	_InfantryList = [];
	{
		_InfantryList pushback (_x select 0);
	} foreach E_BarrackU;

	_FactoryList = [];
	{
		_FactoryList pushback (_x select 0);
	} foreach E_LFactU;	
	
	_HeavyFactoryList = [];
	{
		_HeavyFactoryList pushback (_x select 0);
	} foreach E_HFactU;	
	
	_AirList = [];
	{
		_AirList pushBack (_x select 0);
	} foreach E_AirU;
	
	_StaticList = [((E_StaticWeap select 0) select 0),((E_StaticWeap select 1) select 0),((E_StaticWeap select 2) select 0),((E_StaticWeap select 3) select 0)];	
	
	_GroupNames = E_Groups;
	_ControlledArray = OpControlledArray;
};


			private _grpGarrison = createGroup _DefendSide;
			_grpGarrison setVariable ["DIS_IMPORTANT",true,true];	

private _direction = _DefenceSpawnPos getdir _AttackSpawnPos;
for "_i" from 0 to _RandomNumber step 1 do
{
	private _SetForward = [_DefenceSpawnPos,(25 + (random 250)),_direction] call BIS_fnc_relPos;	
	private _RandomPos = _SetForward getpos [250 * sqrt random 1, random 360];
	private _RandomSafePos = [_RandomPos,0,250,0,0,1,0,[],[_RandomPos,_RandomPos]] call BIS_fnc_findSafePos;
	//SPAWN PREFAB SERVER SIDE
	[
		[_DefenceSpawnPos,_DefendSide,_RandomSafePos,_DefenceList,_Pole,_InfantryList,_AttackSpawnPos,_grpGarrison],
		{
			params ["_DefenceSpawnPos","_DefendSide","_RandomSafePos","_DefenceList","_Pole","_InfantryList","_AttackSpawnPos","_grpGarrison"];
			
			private _TerArray = [];
			{
				_x hideObjectGlobal true;
				_TerArray pushback _x;
				true;
			} count (nearestTerrainObjects [_RandomSafePos, [], 50,false]);
			private _RandomComposition = (selectrandom _DefenceList);
			private _compReference = [_RandomComposition,[(_RandomSafePos select 0),(_RandomSafePos select 1),0], [0,0,-0.1], (_AttackSpawnPos getDir _DefenceSpawnPos), true, true ] call LARs_fnc_spawnComp; 
			sleep 20;
		
			
			private _Objs = nearestObjects [_RandomSafePos, ["VR_Shape_base_F","VR_CoverObject_base_F"], 35];
			private _ObjsStatic = nearestObjects [_RandomSafePos, ["StaticWeapon"], 35];
			{
				private _Type = typeOf _x;
				if (_Type isEqualTo "Land_VR_Shape_01_cube_1m_F" && {35 > random 100}) then
				{
					private _Dir = getDir _x;
					private _unit = _grpGarrison createUnit [(selectRandom _InfantryList),(getposATL _x), [], 0, "CAN_COLLIDE"];
					_unit setVariable ["DIS_SPECIAL",true,true];
					_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
					[_unit,(typeOf _unit)] call DIS_fnc_UniformHandle;
					_unit setposATL (getposATL _x);
					_unit disableAI "PATH";
					_unit setdir _Dir;
					[_unit] joinSilent _grpGarrison;				
				};
				deleteVehicle _x;
			} foreach _Objs;			
			
			{
				if (isNull (Driver _x) && {getDammage _x < 1}) then
				{
					private _unit = _grpGarrison createUnit [(selectRandom _InfantryList),(getposATL _x), [], 0, "CAN_COLLIDE"];
					_unit setVariable ["DIS_SPECIAL",true,true];
					_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
					[_unit,(typeOf _unit)] call DIS_fnc_UniformHandle;
					_unit moveInAny _x;
					_unit disableAI "PATH";
					[_unit] joinSilent _grpGarrison;							
				};			
			} foreach _ObjsStatic;
			
			if (_RandomComposition isEqualTo "PrymMineWall" || {_RandomComposition isEqualTo "PrymMineObstacle"}) then
			{
				private _ObjsMines = nearestObjects [_RandomSafePos, ["MineBase"], 35];
				if (random 100 > 65) then
				{
					{
						private _Dir = getDir _x;
						private _Pos = getPos _x;
						deleteVehicle _x;
						private _mine = "APERSMineDispenser_Ammo_Scripted" createVehicle _Pos;
						_mine setDir _Dir;
						_mine setpos _Pos;					
						_mine setDamage 1;						
					} foreach _ObjsMines;
					
				}
				else
				{
					{
						deleteVehicle _x;
					} foreach _ObjsMines;
				};
			};
			
			while {_Pole getVariable ["DIS_ENGAGED",false]} do
			{
				sleep 5;
			};
			{
				_x hideObjectGlobal false;
				true;
			} count _TerArray;
			[_compReference] call LARs_fnc_deleteComp;					
		}
		
	] remoteExec ["bis_fnc_Spawn",2]; 	
	
	
};





