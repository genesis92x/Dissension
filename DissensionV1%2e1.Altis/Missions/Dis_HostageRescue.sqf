//Hostage Rescue Mission
//Players must find, and rescue hostages
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
	
	
	
	_grp = createGroup resistance;
	_RUA = R_BarrackLU;
	
	{
		_unit = _grp createUnit [(selectRandom _RUA) ,_positions, [], 25, "FORM"];
		[_unit] joinSilent _grp;		
		_unit addEventHandler ["HitPart", {_this call dis_HitPart}];
		_unit addEventHandler ["Hit", {_this call dis_HitDamage}];
		_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];						
		true;
	} count [1,2,3,4,5,6,7,8];
	
	_rnd = random 250;
	_dist = (_rnd + 25);
	_dir = random 360;
	_nposition = [(_positions select 0) + (sin _dir) * _dist, (_positions select 1) + (cos _dir) * _dist, 0];	
	
	
	_grp2 = createGroup resistance;
	{
		_unit = _grp2 createUnit [(selectRandom _RUA) ,_positions, [], 25, "FORM"];
		[_unit] joinSilent _grp2;			
		_unit addEventHandler ["HitPart", {_this call dis_HitPart}];
		_unit addEventHandler ["Hit", {_this call dis_HitDamage}];
		_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];						
		true;
	} count [1,2,3,4,5,6];	
	
	//Spawn in civilians that need to be rescued
	_RUC = ["C_Man_casual_3_F","C_Man_casual_2_F","C_Man_casual_1_F"];
	_grp3 = createGroup civilian;
	{
		_unit = _grp3 createUnit [(selectRandom _RUC) ,_positions, [], 25, "FORM"];
		[_unit] joinSilent _grp3;		
		_unit spawn {sleep 5;_this disableAI "MOVE";};
		true;
	} count [1,2,3];
	
	Dis_HR = 0;
	publicVariable "Dis_HR";
	[
	[_positions,_grp3],
	{
			_pos = _this select 0;
			_grp3 = _this select 1;
			_rnd = random 325;
			_dist = (_rnd + 25);
			_dir = random 360;
			_position = [(_pos select 0) + (sin _dir) * _dist, (_pos select 1) + (cos _dir) * _dist, 0];
			dis_BMarker = createMarkerLocal [format ["ID_%1",_position],_position];
			dis_BMarker setmarkershapeLocal "ELLIPSE";
			dis_BMarker setmarkersizeLocal [500,500];
			dis_BMarker setMarkerColorLocal "ColorYellow";
			dis_BMarker setMarkerAlphaLocal 1;
			{
				_x switchMove "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon";
				_x addAction [("<t color='#E61616'>" + ("Rescue Hostage") + "</t>"),{Dis_HR = Dis_HR + 1;publicVariable "Dis_HR";deleteVehicle (_this select 0);},"",1,true,true,"","(_target distance _this) < 10"];	
				true;
			} count (units _grp3);
	}
	
	] remoteExec ["bis_fnc_Spawn",West]; 	
	
	_AddNewsArray = ["Rescue the Hostages","A group of civilians with mission critical intel are being held against their will. We need to locate and rescue these hostages. They will be lightly guarded by a few resistance members." ];
	dis_WNewsArray pushback _AddNewsArray;
	publicVariable "dis_WNewsArray";
	
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",West];
	
	W_CurMission = (_AddNewsArray select 1);
	publicVariable "W_CurMission";
	
	[] spawn {sleep 3600;Dis_HR = 6;};
	waitUntil {Dis_HR > 2};
	W_CurMission = [""];
	publicVariable "W_CurMission";	
	
	//Reward player for completing the mission
	if !(Dis_HR isEqualTo 6) then
	{
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
			(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>Hostages Rescued: + <t color='%2'>%1</t> </t></t></t>","$1000",_TextColor]);
			_RandomNumber cutFadeOut 30;				
						
		};
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
	
	
	
	_grp = createGroup resistance;
	_RUA = R_BarrackLU;
	
	{
		_unit = _grp createUnit [(selectRandom _RUA) ,_positions, [], 25, "FORM"];
		[_unit] joinSilent _grp;		
		_unit addEventHandler ["HitPart", {_this call dis_HitPart}];
		_unit addEventHandler ["Hit", {_this call dis_HitDamage}];
		_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
		true;	
	} count [1,2,3,4,5,6,7,8];
	
	_rnd = random 250;
	_dist = (_rnd + 25);
	_dir = random 360;
	_nposition = [(_positions select 0) + (sin _dir) * _dist, (_positions select 1) + (cos _dir) * _dist, 0];	
	
	
	_grp2 = createGroup resistance;
	{
		_unit = _grp2 createUnit [(selectRandom _RUA) ,_positions, [], 25, "FORM"];
		[_unit] joinSilent _grp2;
		_unit addEventHandler ["HitPart", {_this call dis_HitPart}];
		_unit addEventHandler ["Hit", {_this call dis_HitDamage}];
		_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
		true;	
	} count [1,2,3,4,5,6];	
	
	//Spawn in civilians that need to be rescued
	_RUC = ["C_Man_casual_3_F","C_Man_casual_2_F","C_Man_casual_1_F"];
	_grp3 = createGroup civilian;
	{
		_unit = _grp3 createUnit [(selectRandom _RUC) ,_positions, [], 25, "FORM"];
		[_unit] joinSilent _grp3;		
		_unit spawn {sleep 2;_this disableAI "MOVE";};
		true;
	} count [1,2,3];
	
	Dis_HRE = 0;
	publicVariable "Dis_HRE";
	[
	[_positions,_grp3],
	{
			_pos = _this select 0;
			_grp3 = _this select 1;
			_rnd = random 325;
			_dist = (_rnd + 25);
			_dir = random 360;
			_position = [(_pos select 0) + (sin _dir) * _dist, (_pos select 1) + (cos _dir) * _dist, 0];
			dis_EMarker = createMarkerLocal [format ["ID_%1",_position],_position];
			dis_EMarker setmarkershapeLocal "ELLIPSE";
			dis_EMarker setmarkersizeLocal [500,500];
			dis_EMarker setMarkerColorLocal "ColorYellow";
			dis_EMarker setMarkerAlphaLocal 1;
			{
			0 = _x switchMove "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon";
			0 = _x addAction [("<t color='#E61616'>" + ("Rescue Hostage") + "</t>"),{Dis_HRE = Dis_HRE + 1;publicVariable "Dis_HRE";deleteVehicle (_this select 0);},"",1,true,true,"","(_target distance _this) < 10"];	
			} count (units _grp3);
	}
	
	] remoteExec ["bis_fnc_Spawn",East]; 	
	
	_AddNewsArray = ["Rescue the Hostages","A group of civilians with mission critical intel are being held against their will. We need to locate and rescue these hostages. They will be lightly guarded by a few resistance members." ];
	dis_ENewsArray pushback _AddNewsArray;
	publicVariable "dis_ENewsArray";
	
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",East];
	
	E_CurMission = (_AddNewsArray select 1);
	publicVariable "E_CurMission";
	
	[] spawn {sleep 3600;Dis_HRE = 6;};
	waitUntil {Dis_HRE > 2};
	E_CurMission = [""];
	publicVariable "E_CurMission";	
	
	//Reward player for completing the mission
	if !(Dis_HRE isEqualTo 6) then
	{
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
			(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>Hostages Rescued: + <t color='%2'>%1</t> </t></t></t>","$1000",_TextColor]);
			_RandomNumber cutFadeOut 30;				
						
		};
	}
	
	] remoteExec ["bis_fnc_Spawn",East]; 	
	};
	//After 10 minutes, make missions selectable again.
	sleep 3600;
	E_PMissionS = false;

	//_FindBuilding = [_BarrackList,_TargetLocation,true] call dis_closestobj;
	
};