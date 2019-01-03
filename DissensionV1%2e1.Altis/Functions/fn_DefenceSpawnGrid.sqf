//This function will spawn and handle the troops that defend a grid!
params ["_DisplayMarkerArray","_CforEachIndex","_Engaged","_SSide"];
private _FinalSelection = _DisplayMarkerArray select 1;
private _DisplayMarker = _DisplayMarkerArray select 2;
private _location = _DisplayMarkerArray select 4;
private _locationPos = getpos _location;
private _SpwnLoc = _DisplayMarkerArray select 5;
private _DstReset = 0;
private _ActiveSide = [];
private _AIComms = "AIComms" call BIS_fnc_getParamValue;

_GridMPos = getMarkerPos _DisplayMarker;
_MaxAtOnce = 4;

//Find what kinds of units we should be spawning. Or setup any side specific variables here.
private _InfantryList = R_BarrackLU;
private _FactoryList = R_LFactDef;
private _GroupNames = R_Groups;
private _ControlledArray = IndControlledArray;
_location setVariable ["DIS_ENGAGED",true];

if (_SSide isEqualTo West) then
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
	
	_GroupNames = W_Groups;
	_ControlledArray = BluControlledArray;
};
if (_SSide isEqualTo East) then
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
	_GroupNames = E_Groups;
	_ControlledArray = OpControlledArray;
};



_Engaged = true;
_SpawnAmount = 18;
_OriginalAmount = 18;
_location setVariable ["DIS_Capture",[_OriginalAmount,_SpawnAmount,_SSide],true];						
_CloseStill = true;
_defeat = false;
_dis_CurSpwn = [];

//Lets get to spawning these units. First we need to create the group to put them in.
private _grp = createGroup _SSide;
_grp setVariable ["DIS_IMPORTANT",true];

private _HC = false;
if (("HC" call BIS_fnc_getParamValue) isEqualTo 1) then 
{
	if !(isNil "HC") then
	{
		if !(isNull HC) then
		{
			_HC = true;
		};
	};
};
if (_HC) then
{
	_grp setGroupOwner (owner HC);
	_grp setVariable ["DIS_TRANSFERED",true];
};

//Lets start the main battle loop. This is where the function will spend most of its time.
private _grpArray = [_grp];
private _CompleteArray = [];

/* 
private _VehSpwn = (round (random 2));
private _VehActualSpwn = 0;
private _positionVEHS = [0,0,0];
while {_VehSpwn > _VehActualSpwn} do 
{

	private _list = _SpwnLoc nearRoads 500;
	private _positionR = [_SpwnLoc,250,50] call dis_randompos;
	private _SelectRoad = [_list,_positionR,true] call dis_closestobj;
	if (!(isNil "_SelectRoad") && {!(_SelectRoad isEqualTo [])} && {!(_SelectRoad isEqualTo [0,0,0])}) then
	{
		_positionVEHS = (getpos _SelectRoad);
	}
	else
	{
		_positionVEHS = _positionR;
	};
	
	private _positionVEHS = [_positionVEHS, 1, 150, 5, 0, 20, 0,[],[_positionVEHS,_positionVEHS]] call BIS_fnc_findSafePos;		
	private _veh = (selectRandom _FactoryList) createVehicle _positionVEHS;	
	_veh setpos _positionVEHS;
	_veh addEventHandler ["HitPart", {_this call dis_HitPart}];_veh addEventHandler ["Hit", {_this call dis_HitDamage}];_veh addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
	_veh setUnloadInCombat [true, false];
	private _grpVeh = createGroup _SSide;
	_grpArray pushback _grpVeh;
	
	private _VehSpwn = 0;
	private _VehSeats = fullCrew [_veh,"",true];
	{
		//[<NULL-object>,"cargo",2,[],false]
		if (!((_x select 0) isEqualTo "cargo") && _VehSpwn < 6) then 
		{
			_VehSpwn = _VehSpwn + 1;
			private _unitDO = _grpVeh createUnit [(selectRandom _InfantryList),[0,0,0], [], 25, "FORM"];
			_unitDO moveInAny _veh;
			[_unitDO] joinsilent _grpVeh;_unitDO addEventHandler ["HitPart", {_this call dis_HitPart}];_unitDO addEventHandler ["Hit", {_this call dis_HitDamage}];_unitDO addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
			if (!(DIS_MODRUN) && (_SSide isEqualTo resistance)) then {_unitDO call dis_AIUniforms;};
		};
	} foreach _VehSeats;		
	_VehActualSpwn = _VehActualSpwn + 1;

};

 */

 [_grp,_location] spawn 
{
	params ["_grp","_location"];
		private _Eng = _location getVariable ["DIS_ENGAGED",false];
		while {_Eng} do
		{
			if (_location distance2D (leader _grp) > 600) then
			{
				//private _WaypointPos = [(getpos _CE),50,25] call dis_randompos;
				//private _Finalposition = [_WaypointPos, 1, 250, 5, 0, 20, 0,[],[_WaypointPos,_WaypointPos]] call BIS_fnc_findSafePos;
				while {(count (waypoints _grp)) > 0} do
				{
					deleteWaypoint ((waypoints _grp) select 0);
				};				
				private _Finalposition = (getpos _location);
				_waypoint = _grp addwaypoint[_Finalposition,1];
				_waypoint setwaypointtype "MOVE";
				_waypoint setWaypointSpeed "LIMITED";
				_waypoint setWaypointBehaviour "SAFE";
				_grp setCurrentWaypoint _waypoint;
			}
			else
			{
				while {(count (waypoints _grp)) > 0} do
				{
					deleteWaypoint ((waypoints _grp) select 0);
				};					
				private _WaypointPos = [(getpos _location),50,25] call dis_randompos;
				if !(_WaypointPos isEqualTo [0,0,0]) then
				{
					private _Finalposition = [_WaypointPos, 1, 250, 5, 0, 20, 0,[],[_WaypointPos,_WaypointPos]] call BIS_fnc_findSafePos;
					_waypoint = _grp addwaypoint[_Finalposition,1];
					_waypoint setwaypointtype "MOVE";
					_waypoint setWaypointSpeed "LIMITED";
					_waypoint setWaypointBehaviour "SAFE";
					_grp setCurrentWaypoint _waypoint;
				};
			
			};
			sleep 300;
			_Eng = _location getVariable ["DIS_ENGAGED",false];
		};
};
 
private _KillTCT = 0;
while {_SpawnAmount > 0 && {_CloseStill}} do
{
	//Lets find where all the units are on the map.
	private _WestActive = [];
	private _EastActive = [];
	private _ResistanceActive = [];
	private _OpBlu = [];
	private _ActiveBaddies = [];
	_KillTCT = _KillTCT + 1;
	{
		if ((side _x) isEqualTo WEST) then {_WestActive pushback _x;_OpBlu pushback _x;};
		if ((side _x) isEqualTo EAST) then {_EastActive pushback _x;_OpBlu pushback _x;};
		if ((side _x) isEqualTo RESISTANCE) then {_ResistanceActive pushback _x;};
	} foreach allunits;		
	
	if (_SSide isEqualTo West) then {_ActiveBaddies = _EastActive + _ResistanceActive;};
	if (_SSide isEqualTo East) then {_ActiveBaddies = _WestActive + _ResistanceActive;};
	if (_SSide isEqualTo Resistance) then {_ActiveBaddies = _OpBlu;};

	private _GroupCnt =  {alive _x} count (units _grp);

	private _position = getpos _location;
	if (_KillTCT > 300) then
	{
		{
			_x setDamage 1;
		} foreach (units _grp);
		_KillTCT = 0;
	};
	if (_GroupCnt < _MaxAtOnce) then
	{

		//Find the perfect spawning position
		private _AttemptCounter = 0;
		private _water = true;
		while {_water} do 
		{
			_rnd = random 275;
			_dist = (_rnd + 25);
			_dir = random 360;
		
			private _positions = [(_SpwnLoc select 0) + (sin _dir) * _dist, (_SpwnLoc select 1) + (cos _dir) * _dist, 0];
			_position = _positions findEmptyPosition [0,150,"I_Soldier_LAT_F"];		
			_AttemptCounter = _AttemptCounter + 1;
			private _NE = [_ActiveBaddies,_position,true] call dis_closestobj;
			if (!(surfaceIsWater _position) && _NE distance _position > 100 || _AttemptCounter > 50) then {_water = false;};
			sleep 0.25;
		};		
		
		if (_position isEqualTo []) then {_position = _positions};
		//private _Finalposition = [_position, 1, 150, 5, 0, 20, 0,[],[_position,_position]] call BIS_fnc_findSafePos;
		private _Finalposition = [[[_position, 150]],["water"]] call BIS_fnc_randomPos;
		private _NE = [_ActiveBaddies,_position,true] call dis_closestobj;
		if (_NE distance2D _SpwnLoc > 150) then
		{
			_Finalposition = _SpwnLoc;
		};
		private _unit = _grp createUnit [(selectRandom _InfantryList) ,_Finalposition, [], 25, "FORM"];
		if (_AIComms isEqualTo 1) then
		{
			_unit call DIS_fnc_UnitInit;
		};			
		_CompleteArray pushback _unit;
		[_unit] joinSilent _grp;	
		_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];								
		//_unit spawn dis_UnitStuck;		
				
		if (!(DIS_MODRUN) && {(_SSide isEqualTo resistance)}) then {_unit call dis_AIUniforms;};
		_SpawnAmount = (_location getVariable "DIS_Capture") select 1;
		_SpawnAmount = _SpawnAmount - 1;
		_location setVariable ["DIS_Capture",[_OriginalAmount,_SpawnAmount,_SSide],true];	
					
				
		
		//If the closest enemy is too far away, let us exit this horseshit.
		_ClosestUnit = [_ActiveBaddies,_GridMPos,true] call dis_closestobj;
		if (_ClosestUnit distance _GridMPos > 550) then
		{
			_DstReset = _DstReset + 1;
			if (_DstReset > 60) then
			{
				_Engaged = false;
				_CloseStill = false;
				[_CompleteArray,_location,_ActiveSide,_SSide] spawn
				{
					params ["_CompleteArray","_location","_ActiveSide","_SSide"];				
					{
						if (!(isPlayer _x) && {_x distance2D (getpos _location) < 801} && {!(_x in _ActiveSide)} && {!(_x isEqualTo DIS_WestCommander)} && {!(_x isEqualTo DIS_EastCommander)}) then
						{
							_CompleteArray pushback _x;
						};
					} foreach (allunits select {(side _x) isEqualTo _SSide});				

					{
						if (alive _x) then
						{
							_x setDamage 1;
						};
					} foreach _CompleteArray;		
				};
			};					
		}
		else
		{
			_DstReset = 0;
		};
			
			
									

		
	
	};	
	sleep 1;
};



//This is for AFTER The battle.
[_CforEachIndex,_location,_CompleteArray] spawn
{
	params ["_CforEachIndex","_location","_CompleteArray"];
	(CompleteRMArray select _CforEachIndex) set [3,false];		
	_location setVariable ["DIS_ENGAGED",false];
	private _ObjArray = _location getVariable ["DIS_ObjArray",[]];
	if !(_ObjArray isEqualTo []) then
	{
		{
			deleteVehicle _x;
		} foreach _ObjArray;
		_location setVariable ["DIS_ObjArray",[]];
	};
	sleep 60;
		{
			if (alive _x) then
			{
				_x setDamage 1;
			};
		} foreach _CompleteArray;	
};



if (_Engaged && {_CloseStill}) then
{



	_defeat = true;						

	//Lets look at all the units and where they are at
	_WestActive = [];
	_EastActive = [];
	_ResistanceActive = [];
	_OpBlu = [];
	{
		if (side _x isEqualTo West && _x distance _GridMPos <= 600) then {_WestActive pushback _x;_OpBlu pushback _x;};
		if (side _x isEqualTo East && _x distance _GridMPos <= 600) then {_EastActive pushback _x;_OpBlu pushback _x;};
		if (side _x isEqualTo Resistance && _x distance _GridMPos <= 600) then {_ResistanceActive pushback _x;};
	} foreach allunits;
	
		
	//West Win
	private _WinArray = [[(count _WestActive),west,_WestActive],[(count _EastActive),east,_EastActive],[(count _ResistanceActive),resistance,_ResistanceActive]];
	private _LosingSide = "";
	{
		if ((_x select 1) isEqualTo _SSide) then {_LosingSide = _x;_WinArray = _WinArray - [_x];};
	} foreach _WinArray;
	_WinArray sort false;
	private _FinalWinner = ((_Winarray select 0) select 1);
	if ((_FinalWinner isEqualTo West) && {!(_SSide isEqualTo West)}) then
	{
		//W_CurrentDecisionM = true;
		//W_CurrentDecisionT = true;								
		_LosingSide spawn
		{
			sleep 600;
			{
				if (!(isPlayer _x) && {!(isPlayer (leader (group _x)))}) then
				{
					_x setdamage 1;
				};
			} foreach (_this select 2);
		
		};		
		
		[
		[_DisplayMarker,West],
		{
				params ["_DisplayMarker","_Side"];
				
				if (playerSide isEqualTo _Side) then
				{
					_DisplayMarker setMarkerColorLocal "ColorBlue";
					_DisplayMarker setMarkerAlphaLocal 0.3;
				}
				else
				{
					if (getMarkerColor _DisplayMarker isEqualTo "ColorRed") then
					{
						_DisplayMarker setMarkerColorLocal "ColorBlue";					
						_DisplayMarker setMarkerAlphaLocal 0.3;
					};
				};
		}
		
		] remoteExec ["bis_fnc_Spawn",0];											
		
		if !(_DisplayMarker in BluLandControlled) then {BluLandControlled pushBack _DisplayMarker;publicVariable "BluLandControlled";};		
		if (_DisplayMarker in IndLandControlled) then {IndLandControlled = IndLandControlled - [_DisplayMarker];publicVariable "IndLandControlled";};
		if (_DisplayMarker in OpLandControlled) then {OpLandControlled = OpLandControlled - [_DisplayMarker];publicVariable "OpLandControlled";};
		_location setVariable ["DIS_Capture",[30,30,West],true];
		
		//Victory fireworks!
		[getMarkerPos _DisplayMarker, 'random','blue'] remoteExec ["GRAD_fireworks_fnc_prepareFireworks", 2];
		{
			if (isPlayer _x) then
			{
			
					[
					[_x],
					{
						DIS_PCASHNUM = DIS_PCASHNUM + 250;
						disableSerialization;
						_RandomNumber = random 10000;
						_TextColor = '#E31F00';		
						_xPosition = 0.15375 * safezoneW + safezoneX;
						_yPosition = 0.201 * safezoneH + safezoneY;     
							
						_randomvariableX = random 0.05;
						_randomvariableY = random 0.05;
						
						_NewXPosition = _xPosition - _randomvariableX;
						_NewYPosition = _yPosition - _randomvariableY;
						
						_RandomNumber cutRsc ["KOZHUD_3","PLAIN"];
						_ui = uiNamespace getVariable "KOZHUD_3";
						(_ui displayCtrl 1100) ctrlSetPosition [_NewXPosition,_NewYPosition];
						(_ui displayCtrl 1100) ctrlCommit 0; 
						(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>Grid Taken: + <t color='%2'>%1</t> </t></t></t>","$250",_TextColor]);
						_RandomNumber cutFadeOut 30;														
					}
					
					] remoteExec ["bis_fnc_Spawn",_x];													
			}
			else
			{
			/*
				if (leader _x isEqualTo _x) then
				{
					if (_x isEqualTo (vehicle _x)) then
					{
						private _RfsGrp = (group _x);
						private _OrgUCnt = _RfsGrp getVariable ["DIS_Frstspwn",12];
						while {_OrgUCnt > (count (units _RfsGrp)) - 1} do
						{
							private _unit = _RfsGrp createUnit [(selectRandom W_BarrackU) select 0,(getpos _x), [], 25, "FORM"];
							[_unit] joinSilent _RfsGrp;
							sleep 1;
						};
					};
				};
			*/
			};
		} foreach _WestActive;
		W_CurrentTargetArray = [];
		W_CurrentDecisionEXP = true;
		publicVariable "W_CurrentTargetArray";
	};
	
	//East Win
	if ((_FinalWinner isEqualTo east) && {!(_SSide isEqualTo east)}) then
	{
		//E_CurrentDecisionM = true;
		//E_CurrentDecisionT = true;								
		
		_LosingSide spawn
		{
			sleep 600;
			{
				if (!(isPlayer _x) && {!(isPlayer (leader (group _x)))}) then
				{
					_x setdamage 1;
				};
			} foreach (_this select 2);
		
		};		
		
		[
		[_DisplayMarker,East],
		{
				params ["_DisplayMarker","_Side"];
				
				if (playerSide isEqualTo _Side) then
				{
					_DisplayMarker setMarkerColorLocal "ColorRed";
					_DisplayMarker setMarkerAlphaLocal 0.3;
				}
				else
				{
					if (getMarkerColor _DisplayMarker isEqualTo "ColorBlue") then
					{
						_DisplayMarker setMarkerColorLocal "ColorRed";		
						_DisplayMarker setMarkerAlphaLocal 0.3;		
					};
				};
		}
		
		] remoteExec ["bis_fnc_Spawn",0];									
		
		if !(_DisplayMarker in OpLandControlled) then {OpLandControlled pushBack _DisplayMarker;publicVariable "OpLandControlled";};
		if (_DisplayMarker in IndLandControlled) then {IndLandControlled = IndLandControlled - [_DisplayMarker];publicVariable "IndLandControlled";};
		if (_DisplayMarker in BluLandControlled) then {BluLandControlled = BluLandControlled - [_DisplayMarker];publicVariable "BluLandControlled";};		
	
		[getMarkerPos _DisplayMarker, 'random','red'] remoteExec ["GRAD_fireworks_fnc_prepareFireworks", 2];									
		_location setVariable ["DIS_Capture",[30,30,East],true];
		//{_x setdamage 1} foreach _ResistanceActive;
		
		{
			if (isPlayer _x) then
			{
			
					[
						[_x],
						{
							DIS_PCASHNUM = DIS_PCASHNUM + 250;
							disableSerialization;
							_RandomNumber = random 10000;
							_TextColor = '#E31F00';		
							_xPosition = 0.15375 * safezoneW + safezoneX;
							_yPosition = 0.201 * safezoneH + safezoneY;     
								
							_randomvariableX = random 0.05;
							_randomvariableY = random 0.05;
							
							_NewXPosition = _xPosition - _randomvariableX;
							_NewYPosition = _yPosition - _randomvariableY;
							
							_RandomNumber cutRsc ["KOZHUD_3","PLAIN"];
							_ui = uiNamespace getVariable "KOZHUD_3";
							(_ui displayCtrl 1100) ctrlSetPosition [_NewXPosition,_NewYPosition];
							(_ui displayCtrl 1100) ctrlCommit 0; 
							(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>Town Taken: + <t color='%2'>%1</t> </t></t></t>","$250",_TextColor]);
							_RandomNumber cutFadeOut 30;														
						}
						
					] remoteExec ["bis_fnc_Spawn",_x];													
			}
			else
			{
				/*
				if (leader _x isEqualTo _x) then
				{
					if (_x isEqualTo (vehicle _x)) then
					{
						private _RfsGrp = (group _x);
						private _OrgUCnt = _RfsGrp getVariable ["DIS_Frstspwn",12];
						while {_OrgUCnt > ({alive _x} count (units _RfsGrp)) - 1} do
						
						{
							private _unit = _RfsGrp createUnit [(selectRandom E_BarrackU) select 0,(getpos _x), [], 25, "FORM"];
							[_unit] joinSilent _RfsGrp;
							sleep 1;
						};
					};
				};
			*/
			};
			
			
		} foreach _EastActive;									
		E_CurrentTargetArray = [];
		E_CurrentDecisionEXP = true;
		publicVariable "E_CurrentTargetArray";
		
		
		
	};

		{
			if (alive _x) then
			{
				_x setDamage 1;
			};
		} foreach _CompleteArray;	
	
}
else
{

		{
			if (alive _x) then
			{
				_x setDamage 1;
			};
		} foreach _CompleteArray;
	_location setVariable ["DIS_Capture",[_OriginalAmount,_OriginalAmount,_SSide],true];
	_location setVariable ["DIS_ENGAGED",false];
	(CompleteRMArray select _CforEachIndex) set [3,false];		
		
};


















