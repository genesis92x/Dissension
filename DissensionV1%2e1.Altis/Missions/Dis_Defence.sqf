//Defence Mission
//Players must defend a town from being captured by enemy forces
//Completing the mission will reward the players with XP and the commander with extra points.

if (_this isEqualTo "West") then
{
	//We need to find a location for the players to defend...
	_DefendLocation = getpos (selectRandom BluControlledArray);

	//Pull commander position
	_Pos = getpos Dis_WestCommander;	

	//Lets create the marker for the players, and then give them 10 minutes to get into the town.
	[
	[_DefendLocation],
	{
			_pos = _this select 0;
			_rnd = random 325;
			_dist = (_rnd + 25);
			_dir = random 360;
			_position = [(_pos select 0) + (sin _dir) * _dist, (_pos select 1) + (cos _dir) * _dist, 0];
			dis_BMarker = createMarkerLocal [format ["ID_%1",_position],_position];
			dis_BMarker setMarkerShapeLocal "ICON";
			dis_BMarker setMarkerSizeLocal [1,1];
			dis_BMarker setMarkerColorLocal "ColorYellow";
			dis_BMarker setMarkerTypeLocal "mil_objective";
			dis_BMarker setMarkerTextLocal "Defend Here!";
			dis_BMarker setMarkerAlphaLocal 1;
			_time = 600;
			while {_time > 0} do 
			{
				_time = _time - 1;  
				hintSilent format["Assault Start: \n %1", [((_time)/60)+.01,"HH:MM"] call BIS_fnc_timetostring];
				sleep 1;
			};			

	}
	
	] remoteExec ["bis_fnc_Spawn",West]; 	
	
	_AddNewsArray = ["Defend Location","The enemy will attack the location marked on the map in 10 minutes! We must be ready to defend it!" ];
	dis_WNewsArray pushback _AddNewsArray;
	publicVariable "dis_WNewsArray";
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",West];
	
	W_CurMission = (_AddNewsArray select 1);
	publicVariable "W_CurMission";
	
	//Now we give the players 10 minutes to wait.
	sleep 600;
	
	
	//Next we will want to figure out where to spawn the AI.
	_rnd = random 1000;
	_dist = (_rnd + 500);
	_dir = random 360;
	_positions = [(_Pos select 0) + (sin _dir) * _dist, (_Pos select 1) + (cos _dir) * _dist, 0];
	
	_AttemptCounter = 0;
	_water = true;
	while {_water} do 
	{
		if (!(surfaceIsWater _positions) || _AttemptCounter > 50) then 
		{
			_water = false;
		}
		else
		{
			_rnd = random 1000;
			_dist = (_rnd + 500);
			_dir = random 360;
			_positions = [(_Pos select 0) + (sin _dir) * _dist, (_Pos select 1) + (cos _dir) * _dist, 0];	
			_AttemptCounter = _AttemptCounter + 1;
		};
		sleep 0.25;
	};		
	
	
	//Create group 1
	_grp = createGroup resistance;
	_RUA = R_BarrackLU;
	
	{
		_unit = _grp createUnit [(selectRandom _RUA) ,_positions, [], 25, "FORM"];
		[_unit] joinSilent _grp;	
		_unit addEventHandler ["HitPart", {_this call dis_HitPart}];
		_unit addEventHandler ["Hit", {_this call dis_HitDamage}];
		_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
		true;
	} count [1,2,3,4,5,6];
	
	
	
	//Create group 2
	_grp2 = createGroup resistance;
	_RUA = R_BarrackLU;
	
	{
		_unit = _grp2 createUnit [(selectRandom _RUA) ,_positions, [], 25, "FORM"];
		[_unit] joinSilent _grp2;	
		0 = _unit addEventHandler ["HitPart", {_this call dis_HitPart}];
		0 = _unit addEventHandler ["Hit", {_this call dis_HitDamage}];
		0 = _unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
	} count [1,2,3,4,5,6];	
	
	
	
	//Tell AI groups to move toward the town
	_waypoint = _grp addwaypoint[_DefendLocation,50,1];
	_waypoint setwaypointtype "MOVE";
	_waypoint setWaypointSpeed "NORMAL";	
	_waypoint = _grp2 addwaypoint[_DefendLocation,50,1];
	_waypoint setwaypointtype "MOVE";
	_waypoint setWaypointSpeed "NORMAL";		

	
	
	[] spawn {Dis_WMissionC = false; sleep 3600;Dis_WMissionC = true;};
	waitUntil {(({alive _x} count (units _grp)) < 1 && ({alive _x} count (units _grp2)) < 1) || {Dis_WMissionC} };
	W_CurMission = [""];
	publicVariable "W_CurMission";	
	
	
	//Reward player for completing the mission
	if !(Dis_WMissionC) then 
	{
			//If the mission is completed on time...
			[
			_positions,
			{
				deleteMarker dis_BMarker;
				if (player distance _this < 1000) then
				{
					DIS_PCASHNUM = DIS_PCASHNUM + 1000;
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
					(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>Defence Complete: + <t color='%2'>%1</t> </t></t></t>","$1000",_TextColor]);
					_RandomNumber cutFadeOut 30;				
								
				};
			}
			
			] remoteExec ["bis_fnc_Spawn",West]; 
	}
	else
	{
		//If the mission is not completed in time then...
		{(vehicle _x) setdamage 1;true} count (units _grp);
		{(vehicle _x) setdamage 1;true} count (units _grp2);
		[
		_positions,
		{
			deleteMarker dis_BMarker;
		}
		
		] remoteExec ["bis_fnc_Spawn",West]; 		
	
	};	
	//After 10 minutes, make missions selectable again.
	sleep 3600;
	W_PMissionS = false;

	//_FindBuilding = [_BarrackList,_TargetLocation,true] call dis_closestobj;

	
}
else
{
	//We need to find a location for the players to defend...
	_DefendLocation = getpos (selectRandom OpControlledArray);

	//Pull commander position
	_Pos = getpos Dis_EastCommander;	

	//Lets create the marker for the players, and then give them 10 minutes to get into the town.
	[
	[_DefendLocation],
	{
			_pos = _this select 0;
			_rnd = random 325;
			_dist = (_rnd + 25);
			_dir = random 360;
			_position = [(_pos select 0) + (sin _dir) * _dist, (_pos select 1) + (cos _dir) * _dist, 0];
			dis_EMarker = createMarkerLocal [format ["ID_%1",_position],_position];
			dis_EMarker setMarkerShapeLocal "ICON";
			dis_EMarker setMarkerSizeLocal [1,1];
			dis_EMarker setMarkerColorLocal "ColorYellow";
			dis_EMarker setMarkerTypeLocal "mil_objective";
			dis_EMarker setMarkerTextLocal "Defend Here!";
			dis_EMarker setMarkerAlphaLocal 1;
			_time = 600;
			while {_time > 0} do 
			{
				_time = _time - 1;  
				hintSilent format["Assault Start: \n %1", [((_time)/60)+.01,"HH:MM"] call BIS_fnc_timetostring];
				sleep 1;
			};			

	}
	
	] remoteExec ["bis_fnc_Spawn",East]; 	
	
	_AddNewsArray = ["Defend Location","The enemy will attack the location marked on the map in 10 minutes! We must be ready to defend it!" ];
	dis_ENewsArray pushback _AddNewsArray;
	publicVariable "dis_ENewsArray";
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",East];
	
	E_CurMission = (_AddNewsArray select 1);
	publicVariable "E_CurMission";
	
	//Now we give the players 10 minutes to wait.
	sleep 600;
	
	
	//Next we will want to figure out where to spawn the AI.
	_rnd = random 1000;
	_dist = (_rnd + 500);
	_dir = random 360;
	_positions = [(_Pos select 0) + (sin _dir) * _dist, (_Pos select 1) + (cos _dir) * _dist, 0];
	
	_AttemptCounter = 0;
	_water = true;
	while {_water} do 
	{
		if (!(surfaceIsWater _positions) || _AttemptCounter > 50) then 
		{
			_water = false;
		}
		else
		{
			_rnd = random 1000;
			_dist = (_rnd + 500);
			_dir = random 360;
			_positions = [(_Pos select 0) + (sin _dir) * _dist, (_Pos select 1) + (cos _dir) * _dist, 0];	
			_AttemptCounter = _AttemptCounter + 1;
		};
		sleep 0.25;
	};		
	
	
	//Create group 1
	_grp = createGroup resistance;
	_RUA = R_BarrackLU;
	
	{
		_unit = _grp createUnit [(selectRandom _RUA) ,_positions, [], 25, "FORM"];
		[_unit] joinSilent _grp;	
		_unit addEventHandler ["HitPart", {_this call dis_HitPart}];
		_unit addEventHandler ["Hit", {_this call dis_HitDamage}];
		_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
		true;
	} count [1,2,3,4,5,6];
	
	
	
	//Create group 2
	_grp2 = createGroup resistance;
	_RUA = R_BarrackLU;
	
	{
		_unit = _grp2 createUnit [(selectRandom _RUA) ,_positions, [], 25, "FORM"];
		[_unit] joinSilent _grp2;	
		_unit addEventHandler ["HitPart", {_this call dis_HitPart}];
		_unit addEventHandler ["Hit", {_this call dis_HitDamage}];
		_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
		true;
	} count [1,2,3,4,5,6];	
	
	
	
	//Tell AI groups to move toward the town
	_waypoint = _grp addwaypoint[_DefendLocation,50,1];
	_waypoint setwaypointtype "MOVE";
	_waypoint setWaypointSpeed "NORMAL";	
	_waypoint = _grp2 addwaypoint[_DefendLocation,50,1];
	_waypoint setwaypointtype "MOVE";
	_waypoint setWaypointSpeed "NORMAL";		

	
	
	[] spawn {Dis_EMissionC = false; sleep 3600;Dis_EMissionC = true;};
	waitUntil {(({alive _x} count (units _grp)) < 1 && ({alive _x} count (units _grp2)) < 1) || {Dis_EMissionC} };
	E_CurMission = [""];
	publicVariable "E_CurMission";	
	
	
	//Reward player for completing the mission
	if !(Dis_EMissionC) then 
	{
			//If the mission is completed on time...
			[
			_positions,
			{
				deleteMarker dis_EMarker;
				if (player distance _this < 1000) then
				{
					DIS_PCASHNUM = DIS_PCASHNUM + 1000;
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
					(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>Defence Complete: + <t color='%2'>%1</t> </t></t></t>","$1000",_TextColor]);
					_RandomNumber cutFadeOut 30;				
								
				};
			}
			
			] remoteExec ["bis_fnc_Spawn",East]; 
	}
	else
	{
		//If the mission is not completed in time then...
		{(vehicle _x) setdamage 1;true} count (units _grp);
		{(vehicle _x) setdamage 1;true} count (units _grp2);
		[
		_positions,
		{
			deleteMarker dis_EMarker;
		}
		
		] remoteExec ["bis_fnc_Spawn",East]; 		
	
	};	
	//After 10 minutes, make missions selectable again.
	sleep 3600;
	E_PMissionS = false;

	//_FindBuilding = [_BarrackList,_TargetLocation,true] call dis_closestobj;
	
	
};