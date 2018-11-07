//Bomb defusal mission 
//Players must find, and defuse a bomb within the time limit.
//Completing the mission will reward the players with XP and the commander with extra points.
private ["_rnd", "_dist", "_dir", "_positions", "_AttemptCounter", "_water", "_grp", "_RUA", "_unit", "_position", "_null", "_AddNewsArray", "_RandomNumber", "_TextColor", "_xPosition", "_yPosition", "_randomvariableX", "_randomvariableY", "_NewXPosition", "_NewYPosition", "_ui", "_FindBuilding", "_BarrackList", "_TargetLocation"];
if (_this isEqualTo "West") then
{

//Bomb defusal mission 
//Players must find, and defuse a bomb within the time limit.
//Completing the mission will reward the players with XP and the commander with extra points.
private ["_rnd", "_dist", "_dir", "_positions", "_AttemptCounter", "_water", "_grp", "_RUA", "_unit", "_position", "_null", "_AddNewsArray", "_RandomNumber", "_TextColor", "_xPosition", "_yPosition", "_randomvariableX", "_randomvariableY", "_NewXPosition", "_NewYPosition", "_ui", "_FindBuilding", "_BarrackList", "_TargetLocation"];

	//We need to find a good location to put this bomb in. It can be anywhere.
	_Pos = getpos Dis_WestCommander;
	_rnd = random 2000;
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
	
	
	CODEINPUT = [];
	CODE = [(round(random 9)), (round(random 9)), (round(random 9)), (round(random 9)), (round(random 9)), (round(random 9))]; //6 digit code can be more or less
	WIRE = selectRandom ["BLUE", "WHITE", "YELLOW", "GREEN"];
	DEFUSED = false;
	ARMED = false;
	publicVariable "CODE";
	publicVariable "WIRE";
	publicVariable "DEFUSED";
	publicVariable "ARMED";
	publicVariable "CODEINPUT";
	
	CASEBOMB = "SatchelCharge_F" createVehicle [0,0,0];
	_Table = "Land_CampingTable_F" createVehicle [0,0,0];
	_Table setpos _positions;
	CASEBOMB setpos [_positions select 0,_positions select 1,(_positions select 2) + 2];	
	publicVariable "CASEBOMB";	

	_grp = createGroup resistance;
	_RUA = R_BarrackLU;
	
	{
		_unit = _grp createUnit [(selectRandom _RUA) ,_positions, [], 25, "FORM"];
		[_unit] joinSilent _grp;			
		_unit addEventHandler ["HitPart", {_this call dis_HitPart}];
		_unit addEventHandler ["Hit", {_this call dis_HitDamage}];
		_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];						
		true;
	} count [1,2,3,4,5,6,7,8,9,10,11,12];
	codeHolder = leader _grp;
	publicVariable "codeHolder";
	
	if (isDedicated) then {_null = [CASEBOMB, 1800] spawn COB_fnc_bombTimer;};
	[
	_positions,
	{
			private _rnd = random 325;
			private _dist = (_rnd + 0);
			private _dir = random 360;
			private _position = [(_this select 0) + (sin _dir) * _dist, (_this select 1) + (cos _dir) * _dist, 0];
			dis_BMarker = createMarkerLocal [format ["ID_%1",_position],_position];
			dis_BMarker setmarkershapelocal	"ELLIPSE";
			dis_BMarker setmarkersizelocal [500,500];
			dis_BMarker setMarkerColorLocal "ColorYellow";
			dis_BMarker setMarkerAlphaLocal 1;
			
			codeHolder addAction [("<t color='#E61616'>" + ("The Code") + "</t>"),"DEFUSE\searchAction.sqf","",1,true,true,"","(_target distance _this) < 6"];	
			CASEBOMB  addAction [("<t color='#E61616'>" + ("Defuse the Bomb") + "</t>"),"DEFUSE\defuseAction.sqf","",1,true,true,"","(_target distance _this) < 6"];
			if !(isServer) then {_null = [CASEBOMB, 1800] spawn COB_fnc_bombTimer};
			
			while {alive CASEBOMB} do
			{
				_rnd = _rnd - 10;
				if (_rnd < 0) then {_rnd = 0};
				_dist = (_rnd + 0);
				_dir = random 360;
				_position = [(_this select 0) + (sin _dir) * _dist, (_this select 1) + (cos _dir) * _dist, 0];	
				
				_size = getMarkerSize dis_BMarker;
				dis_BMarker setmarkersizelocal [(_size select 0) - 15,(_size select 1) - 15];				
				dis_BMarker setMarkerPosLocal _position;
				
				sleep 60;
			};
			
	}
	
	] remoteExec ["bis_fnc_Spawn",West]; 	
	
	_AddNewsArray = ["Defuse The Bomb","The rough area of a dirty bomb has been marked on the map with a yellow circle. Find and kill the squad defending it, find the code, and defuse the bomb. The squad leader should have the code, or the correct wire to cut. Make sure to know where he dies. The bomb is a small satchel on the ground - the yellow circle will slowly shrink around its rough location. The faster you complete the mission, the more money we get." ];
	dis_WNewsArray pushback _AddNewsArray;
	publicVariable "dis_WNewsArray";
	
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",West];
	
	W_CurMission = (_AddNewsArray select 1);
	publicVariable "W_CurMission";
	waitUntil {!(alive CASEBOMB)};
	W_CurMission = [""];
	publicVariable "W_CurMission";	
	
	//Reward player for completing the mission
	if (DEFUSED) then
	{
		[
		_positions,
		{
			deleteMarker dis_BMarker;
			if (player distance _this < 1000) then
			{
				DIS_PCASHNUM = DIS_PCASHNUM + (1000 + Dis_BTime);
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
				(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>Bomb defused: + <t color='%2'>%1</t> </t></t></t>",(1000 + Dis_BTime),_TextColor]);
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

//Bomb defusal mission 
//Players must find, and defuse a bomb within the time limit.
//Completing the mission will reward the players with XP and the commander with extra points.
private ["_rnd", "_dist", "_dir", "_positions", "_AttemptCounter", "_water", "_grp", "_RUA", "_unit", "_position", "_null", "_AddNewsArray", "_RandomNumber", "_TextColor", "_xPosition", "_yPosition", "_randomvariableX", "_randomvariableY", "_NewXPosition", "_NewYPosition", "_ui", "_FindBuilding", "_BarrackList", "_TargetLocation"];

	//We need to find a good location to put this bomb in. It can be anywhere.
	_Pos = getpos Dis_EastCommander;
	_rnd = random 2000;
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
	
	
	CODEINPUT = [];
	CODE = [(round(random 9)), (round(random 9)), (round(random 9)), (round(random 9)), (round(random 9)), (round(random 9))]; //6 digit code can be more or less
	WIRE = selectRandom ["BLUE", "WHITE", "YELLOW", "GREEN"];
	DEFUSED = false;
	ARMED = false;
	publicVariable "CODE";
	publicVariable "WIRE";
	publicVariable "DEFUSED";
	publicVariable "ARMED";
	publicVariable "CODEINPUT";
	
	CASEBOMB = "SatchelCharge_F" createVehicle [0,0,0];
	_Table = "Land_CampingTable_F" createVehicle [0,0,0];	
	_Table setpos _positions;
	CASEBOMB setpos [_positions select 0,_positions select 1,(_positions select 2) + 2];
	publicVariable "CASEBOMB";	

	_grp = createGroup resistance;
	_RUA = R_BarrackLU;
	
	{
		_unit = _grp createUnit [(selectRandom _RUA) ,_positions, [], 25, "FORM"];
		[_unit] joinSilent _grp;	
		_unit addEventHandler ["HitPart", {_this call dis_HitPart}];
		_unit addEventHandler ["Hit", {_this call dis_HitDamage}];
		_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];						
		true;
	} count [1,2,3,4,5,6,7,8,9,10,11,12];
	codeHolder = leader _grp;
	publicVariable "codeHolder";
	
	if (isDedicated) then {_null = [CASEBOMB, 1800] spawn COB_fnc_bombTimer;};
	[
	_positions,
	{
			private _rnd = random 325;
			private _dist = (_rnd + 0);
			private _dir = random 360;
			private _position = [(_this select 0) + (sin _dir) * _dist, (_this select 1) + (cos _dir) * _dist, 0];
			dis_EMarker = createMarkerLocal [format ["ID_%1",_position],_position];
			dis_EMarker setmarkershapelocal	"ELLIPSE";
			dis_EMarker setmarkersizelocal [500,500];
			dis_EMarker setMarkerColorLocal "ColorYellow";
			dis_EMarker setMarkerAlphaLocal 1;
			
			codeHolder addAction [("<t color='#E61616'>" + ("The Code") + "</t>"),"DEFUSE\searchAction.sqf","",1,true,true,"","(_target distance _this) < 3"];	
			CASEBOMB  addAction [("<t color='#E61616'>" + ("Defuse the Bomb") + "</t>"),"DEFUSE\defuseAction.sqf","",1,true,true,"","(_target distance _this) < 5"];
			if !(isServer) then {_null = [CASEBOMB, 1800] spawn COB_fnc_bombTimer;};
			
			while {alive CASEBOMB} do
			{
				_rnd = _rnd - 10;
				if (_rnd < 0) then {_rnd = 0};
				_dist = (_rnd + 0);
				_dir = random 360;
				_position = [(_this select 0) + (sin _dir) * _dist, (_this select 1) + (cos _dir) * _dist, 0];	
				
				_size = getMarkerSize dis_EMarker;
				dis_EMarker setmarkersizelocal [(_size select 0) - 15,(_size select 1) - 15];				
				dis_EMarker setMarkerPosLocal _position;
				
				sleep 60;
			};
			
	}
	
	] remoteExec ["bis_fnc_Spawn",East]; 	
	
	_AddNewsArray = ["Defuse The Bomb","The rough area of a dirty bomb has been marked on the map with a yellow circle. Find and kill the squad defending it, find the code, and defuse the bomb. The squad leader should have the code, or the correct wire to cut. Make sure to know where he dies. The bomb is a small satchel on the ground - the yellow circle will slowly shrink around its rough location. The faster you complete the mission, the more money we get." ];
	dis_ENewsArray pushback _AddNewsArray;
	publicVariable "dis_ENewsArray";
	
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",East];
	
	E_CurMission = (_AddNewsArray select 1);
	publicVariable "E_CurMission";
	waitUntil {!(alive CASEBOMB)};
	E_CurMission = [""];
	publicVariable "E_CurMission";	
	
	//Reward player for completing the mission
	if (DEFUSED) then
	{
		[
		_positions,
		{
			deleteMarker dis_EMarker;
			if (player distance _this < 1000) then
			{
				DIS_PCASHNUM = DIS_PCASHNUM + (1000 + Dis_BTime);
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
				(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>Bomb defused: + <t color='%2'>%1</t> </t></t></t>",(1000 + Dis_BTime),_TextColor]);
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