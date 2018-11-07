//Escort Mission
//Players must make sure that the single AI unit makes it to his destination without dying.
//Completing the mission will reward the players with XP and the commander with extra points.

private ["_grpE", "_Escort", "_rnd", "_dist", "_dir", "_positions", "_AttemptCounter", "_water", "_grp", "_RUA", "_nposition", "_unit", "_grp2", "_waypoint", "_position", "_AddNewsArray", "_RandomNumber", "_TextColor", "_xPosition", "_yPosition", "_randomvariableX", "_randomvariableY", "_NewXPosition", "_NewYPosition", "_ui", "_FindBuilding", "_BarrackList", "_TargetLocation"];

if (_this isEqualTo "West") then
{
//Escort Mission
//Players must make sure that the single AI unit makes it to his destination without dying.
//Completing the mission will reward the players with XP and the commander with extra points.
hint "RUN";
private ["_grpE", "_Escort", "_rnd", "_dist", "_dir", "_positions", "_AttemptCounter", "_water", "_grp", "_RUA", "_nposition", "_unit", "_grp2", "_waypoint", "_position", "_AddNewsArray", "_RandomNumber", "_TextColor", "_xPosition", "_yPosition", "_randomvariableX", "_randomvariableY", "_NewXPosition", "_NewYPosition", "_ui", "_FindBuilding", "_BarrackList", "_TargetLocation"];


	//We need to find a good location to put the hostages in. It can be anywhere.
	_Pos = getpos Dis_WestCommander;	
	
	//Lets spawn the unit to be escorted ontop of the commander.
	_grpE = createGroup west;
	_Escort = _grpE createUnit ["B_Story_SF_Captain_F" ,_pos, [], 50, "FORM"];
	[_Escort] joinSilent _grpE;	
	
	//Next we will want to figure out where he will be going.
	_rnd = random 3000;
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
			_rnd = random 2000;
			_dist = (_rnd + 500);
			_dir = random 360;
			_positions = [(_Pos select 0) + (sin _dir) * _dist, (_Pos select 1) + (cos _dir) * _dist, 0];	
			_AttemptCounter = _AttemptCounter + 1;
		};
		sleep 0.25;
	};		
	
	
	//Next we need to spawn enemies to come after him.
	
	
	//Create group 1
	_grp = createGroup resistance;
	_RUA = R_BarrackLU;
	
	
	_rnd = random 25;
	_dist = (_rnd + 25);
	_dir = random 360;
	_nposition = [(_positions select 0) + (sin _dir) * _dist, (_positions select 1) + (cos _dir) * _dist, 0];		
	
	{
		_unit = _grp2 createUnit [(selectRandom _RUA) ,_nposition, [], 25, "FORM"];
		[_unit] joinSilent _grp2;		
		_unit addEventHandler ["HitPart", {_this call dis_HitPart}];
		_unit addEventHandler ["Hit", {_this call dis_HitDamage}];
		_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
		true;
	} count [1,2,3,4,5,6,7,8];
	
	
	//Create group 2
	_grp2 = createGroup resistance;
	{
		_unit = _grp2 createUnit [(selectRandom _RUA) ,_nposition, [], 25, "FORM"];
		[_unit] joinSilent _grp2;				
		 _unit addEventHandler ["HitPart", {_this call dis_HitPart}];
		 _unit addEventHandler ["Hit", {_this call dis_HitDamage}];
		 _unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
		 true;
	} count [1,2,3,4,5,6,7,8];
	
	//Tell AI groups to move toward the escorted unit
	_waypoint = _grp addwaypoint[_Pos,50,1];
	_waypoint setwaypointtype "MOVE";
	_waypoint setWaypointSpeed "NORMAL";	
	_waypoint = _grp2 addwaypoint[_Pos,50,1];
	_waypoint setwaypointtype "MOVE";
	_waypoint setWaypointSpeed "NORMAL";		
	
	//Tell the escort unit to move to the position
	_waypoint = _grpE addwaypoint[_positions,50,1];
	_waypoint setwaypointtype "MOVE";
	_waypoint setWaypointSpeed "NORMAL";	
	_waypoint = _grpE addwaypoint[_positions,50,2];
	_waypoint setwaypointtype "MOVE";
	_waypoint setWaypointSpeed "NORMAL";	
	_Escort domove _positions;
	
	[
	[_positions,_Escort],
	{
			_pos = _this select 0;
			_Escort = _this select 1;
			_rnd = random 325;
			_dist = (_rnd + 25);
			_dir = random 360;
			_position = [(_pos select 0) + (sin _dir) * _dist, (_pos select 1) + (cos _dir) * _dist, 0];
			dis_BMarker = createMarkerLocal [format ["ID_%1",_position],_position];
			dis_BMarker setMarkerShapeLocal "ICON";
			dis_BMarker setMarkerTypeLocal "mil_destroy";
			dis_BMarker setMarkerSizeLocal [1,1];
			dis_BMarker setMarkerColorLocal "ColorYellow";
			dis_BMarker setMarkerTextLocal "Escort Here!";
			dis_BMarker setMarkerAlphaLocal 1;
			
			
			_Marker = createMarkerLocal ["ESCORT",[0,0,0]];
			_Marker setMarkerAlphaLocal 1;
			_Marker setMarkerSizeLocal [1,1];			
			_Marker setMarkerColorLocal "ColorBlue";
			_Marker setMarkerShapeLocal 'ICON';
			_Marker setMarkerTypeLocal 'mil_objective';
			_Marker setMarkerTextLocal "ESCORT";			
			
			while {alive _Escort} do
			{
				_Marker setMarkerDirLocal (getdir _Escort);	
				_Marker setMarkerPosLocal (getposASL _Escort);
				sleep 10;
			};
			sleep 5;
			deleteMarker _Marker;				

	}
	
	] remoteExec ["bis_fnc_Spawn",West]; 	
	
	_AddNewsArray = ["Escort VIP","A VIP who has important information refuses to stay in our safety. Escort the bastard to the marked location safely. He will be traveling by foot to not attract any undue attention." ];
	dis_WNewsArray pushback _AddNewsArray;
	publicVariable "dis_WNewsArray";
	
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",West];
	
	W_CurMission = (_AddNewsArray select 1);
	publicVariable "W_CurMission";
	
	[] spawn {Dis_WMissionC = false; sleep 1800;Dis_WMissionC = true;};
	waitUntil {!(alive _Escort) || {Dis_WMissionC} || {(_Escort distance _positions < 75)}};
	W_CurMission = [""];
	publicVariable "W_CurMission";	
	
	
	//Reward player for completing the mission
	if !(Dis_WMissionC) then 
	{
		if (_Escort distance _positions < 75) then
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
					(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>Escort Complete: + <t color='%2'>%1</t> </t></t></t>","$1000",_TextColor]);
					_RandomNumber cutFadeOut 30;				
								
				};
			}
			
			] remoteExec ["bis_fnc_Spawn",West]; 
			deleteVehicle _Escort;
		};
	}
	else
	{
		//If the mission is not completed in time then...
		{(vehicle _x) setdamage 1;true} count (units _grp);
		{(vehicle _x) setdamage 1;true} count (units _grp2);
		[
		[],
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
	

//Escort Mission
//Players must make sure that the single AI unit makes it to his destination without dying.
//Completing the mission will reward the players with XP and the commander with extra points.
private ["_grpE", "_Escort", "_rnd", "_dist", "_dir", "_positions", "_AttemptCounter", "_water", "_grp", "_RUA", "_nposition", "_unit", "_grp2", "_waypoint", "_position", "_AddNewsArray", "_RandomNumber", "_TextColor", "_xPosition", "_yPosition", "_randomvariableX", "_randomvariableY", "_NewXPosition", "_NewYPosition", "_ui", "_FindBuilding", "_BarrackList", "_TargetLocation"];


	//We need to find a good location to put the hostages in. It can be anywhere.
	_Pos = getpos Dis_EastCommander;	
	
	//Lets spawn the unit to be escorted ontop of the commander.
	_grpE = createGroup East;
	_Escort = "B_Story_SF_Captain_F" createUnit [_pos,_grpE];
	_Escort = _grpE createUnit ["B_Story_SF_Captain_F" ,_pos, [], 25, "FORM"];
	[_Escort] joinSilent _grpE;		
	
	//Next we will want to figure out where he will be going.
	_rnd = random 3000;
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
			_rnd = random 2000;
			_dist = (_rnd + 500);
			_dir = random 360;
			_positions = [(_Pos select 0) + (sin _dir) * _dist, (_Pos select 1) + (cos _dir) * _dist, 0];	
			_AttemptCounter = _AttemptCounter + 1;
		};
		sleep 0.25;
	};		
	
	
	//Next we need to spawn enemies to come after him.
	
	
	//Create group 1
	_grp = createGroup resistance;
	_RUA = R_BarrackLU;
	
	
	_rnd = random 25;
	_dist = (_rnd + 25);
	_dir = random 360;
	_nposition = [(_positions select 0) + (sin _dir) * _dist, (_positions select 1) + (cos _dir) * _dist, 0];		
	
	{
		_unit = _grp createUnit [(selectRandom _RUA) ,_nposition, [], 25, "FORM"];
		[_unit] joinSilent _grp;		
		_unit addEventHandler ["HitPart", {_this call dis_HitPart}];
		_unit addEventHandler ["Hit", {_this call dis_HitDamage}];
		_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
		true;
	} count [1,2,3,4,5,6,7,8];
	
	
	//Create group 2
	_grp2 = createGroup resistance;
	{
		_unit = _grp2 createUnit [(selectRandom _RUA) ,_nposition, [], 25, "FORM"];
		[_unit] joinSilent _grp2;			
		_unit addEventHandler ["HitPart", {_this call dis_HitPart}];
		_unit addEventHandler ["Hit", {_this call dis_HitDamage}];
		_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
		true;
	} count [1,2,3,4,5,6,7,8];
	
	//Tell AI groups to move toward the escorted unit
	_waypoint = _grp addwaypoint[_Pos,50,1];
	_waypoint setwaypointtype "MOVE";
	_waypoint setWaypointSpeed "NORMAL";	
	_waypoint = _grp2 addwaypoint[_Pos,50,1];
	_waypoint setwaypointtype "MOVE";
	_waypoint setWaypointSpeed "NORMAL";		
	
	//Tell the escort unit to move to the position
	_waypoint = _grpE addwaypoint[_positions,50,1];
	_waypoint setwaypointtype "MOVE";
	_waypoint setWaypointSpeed "NORMAL";	
	_waypoint = _grpE addwaypoint[_positions,50,1];
	_waypoint setwaypointtype "MOVE";
	_waypoint setWaypointSpeed "NORMAL";	
	
	[
	[_positions,_Escort],
	{
			_pos = _this select 0;
			_Escort = _this select 1;
			_rnd = random 325;
			_dist = (_rnd + 25);
			_dir = random 360;
			_position = [(_pos select 0) + (sin _dir) * _dist, (_pos select 1) + (cos _dir) * _dist, 0];
			dis_EMarker = createMarkerLocal [format ["ID_%1",_position],_position];
			dis_EMarker setMarkerShapeLocal "ICON";
			dis_EMarker setMarkerTypeLocal "mil_destroy";
			dis_EMarker setMarkerSizeLocal [1,1];
			dis_EMarker setMarkerColorLocal "ColorYellow";
			dis_EMarker setMarkerTextLocal "Escort Here!";
			dis_EMarker setMarkerAlphaLocal 1;
			
			
			_Marker = createMarkerLocal ["ESCORT",[0,0,0]];
			_Marker setMarkerAlphaLocal 1;
			_Marker setMarkerSizeLocal [1,1];			
			_Marker setMarkerColorLocal "ColorBlue";
			_Marker setMarkerShapeLocal 'ICON';
			_Marker setMarkerTypeLocal 'mil_objective';
			_Marker setMarkerTextLocal "ESCORT";			
			
			while {alive _Escort} do
			{
				_Marker setMarkerDirLocal (getdir _Escort);	
				_Marker setMarkerPosLocal (getposASL _Escort);
				sleep 10;
			};
			sleep 5;
			deleteMarker _Marker;				

	}
	
	] remoteExec ["bis_fnc_Spawn",East]; 	
	
	_AddNewsArray = ["Escort VIP","A VIP who has important information refuses to stay in our safety. Escort the bastard to the marked location safely. He will be traveling by foot to not attract any undue attention." ];
	dis_ENewsArray pushback _AddNewsArray;
	publicVariable "dis_ENewsArray";
	
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",East];
	
	E_CurMission = (_AddNewsArray select 1);
	publicVariable "E_CurMission";
	
	[] spawn {Dis_EMissionC = false; sleep 1800;Dis_EMissionC = true;};
	waitUntil {!(alive _Escort) || {Dis_EMissionC} || {(_Escort distance _positions < 75)}};
	E_CurMission = [""];
	publicVariable "E_CurMission";	
	
	
	//Reward player for completing the mission
	if !(Dis_EMissionC) then 
	{
		if (_Escort distance _positions < 75) then
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
					(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>Escort Complete: + <t color='%2'>%1</t> </t></t></t>","$1000",_TextColor]);
					_RandomNumber cutFadeOut 30;				
								
				};
			}
			
			] remoteExec ["bis_fnc_Spawn",East]; 
			deleteVehicle _Escort;
		};
	}
	else
	{
		//If the mission is not completed in time then...
		{(vehicle _x) setdamage 1;true} count (units _grp);
		{(vehicle _x) setdamage 1;true} count (units _grp2);
		[
		[],
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