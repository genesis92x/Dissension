//Destroy Mission
//Player must find and destroy a structure that is heavily guarded
//Completing the mission will reward the players with XP and the commander with extra points.

private ["_rnd", "_dist", "_dir", "_positions", "_AttemptCounter", "_water", "_grp", "_RUA", "_unit", "_nposition", "_grp2", "_RUC", "_grp3", "_position", "_AddNewsArray", "_RandomNumber", "_TextColor", "_xPosition", "_yPosition", "_randomvariableX", "_randomvariableY", "_NewXPosition", "_NewYPosition", "_ui", "_FindBuilding", "_BarrackList", "_TargetLocation"];

if (_this isEqualTo "West") then
{
	//We need to find a good location to put the hostages in. It can be anywhere.
	_Pos = getpos Dis_WestCommander;
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
	

	_target = "I_APC_Wheeled_03_cannon_F" createVehicle _positions;
	_target lock true;
	
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

	[
	[_positions],
	{
			_pos = _this select 0;
			_rnd = random 325;
			_dist = (_rnd + 25);
			_dir = random 360;
			_position = [(_pos select 0) + (sin _dir) * _dist, (_pos select 1) + (cos _dir) * _dist, 0];
			dis_BMarker = createMarkerLocal [format ["ID_%1",_position],_position];
			dis_BMarker setMarkerShapeLocal "ELLIPSE";
			dis_BMarker setMarkerSizeLocal [500,500];
			dis_BMarker setMarkerColorLocal "ColorYellow";
			dis_BMarker setMarkerAlphaLocal 1;
			

	}
	
	] remoteExec ["bis_fnc_Spawn",West]; 	
	
	_AddNewsArray = ["Destroy Heavy Armor","A group of independent have hidden a heavy vehicle at the marked location. It is guarded by a small group. Move in, destroy the guards and the tank." ];
	dis_WNewsArray pushback _AddNewsArray;
	publicVariable "dis_WNewsArray";
	
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",West];
	
	W_CurMission = (_AddNewsArray select 1);
	publicVariable "W_CurMission";
	
	[] spawn {Dis_WMissionC = false; sleep 3600;Dis_WMissionC = true;}; 
	waitUntil {!(alive _target) || {Dis_WMissionC}};
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
				(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>Vehicle Destroyed: + <t color='%2'>%1</t> </t></t></t>","$1000",_TextColor]);
				_RandomNumber cutFadeOut 30;				
							
			};
		}
		
		] remoteExec ["bis_fnc_Spawn",West]; 	
	}
	else
	{
		//If the mission is not completed in time then...
		{0= (vehicle _x) setdamage 1;} count (units _grp);
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
	
	//We need to find a good location to put the hostages in. It can be anywhere.
	_Pos = getpos Dis_EastCommander;
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
	

	_target = "I_APC_Wheeled_03_cannon_F" createVehicle _positions;
	_target lock true;
	
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

	[
	[_positions],
	{
			_pos = _this select 0;
			_rnd = random 325;
			_dist = (_rnd + 25);
			_dir = random 360;
			_position = [(_pos select 0) + (sin _dir) * _dist, (_pos select 1) + (cos _dir) * _dist, 0];
			dis_EMarker = createMarkerLocal [format ["ID_%1",_position],_position];
			dis_EMarker setMarkerShapeLocal "ELLIPSE";
			dis_EMarker setMarkerSizeLocal [500,500];
			dis_EMarker setMarkerColorLocal "ColorYellow";
			dis_EMarker setMarkerAlphaLocal 1;

	}
	
	] remoteExec ["bis_fnc_Spawn",East]; 	
	
	_AddNewsArray = ["Destroy Heavy Armor","A group of independent have hidden a heavy vehicle at the marked location. It is guarded by a small group. Move in, destroy the guards and the tank." ];
	dis_ENewsArray pushback _AddNewsArray;
	publicVariable "dis_ENewsArray";
	
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",East];
	
	E_CurMission = (_AddNewsArray select 1);
	publicVariable "E_CurMission";
	
	[] spawn {Dis_EMissionC = false; sleep 3600;Dis_EMissionC = true;}; 
	waitUntil {!(alive _target) || {Dis_EMissionC}};
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
				(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>Vehicle Destroyed: + <t color='%2'>%1</t> </t></t></t>","$1000",_TextColor]);
				_RandomNumber cutFadeOut 30;				
							
			};
		}
		
		] remoteExec ["bis_fnc_Spawn",East]; 	
	}
	else
	{
		//If the mission is not completed in time then...
		{(vehicle _x) setdamage 1;true;} count (units _grp);
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