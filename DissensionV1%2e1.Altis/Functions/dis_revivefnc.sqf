player setVariable ["DIS_INCAPACITATED",false,true];

DIS_StopDrag = 
{
	params ["_target"];
	private _caller = (_this select 3 select 0);
	systemChat format ["_caller: %1",_caller];
	_Caller setVariable ["DIS_Drag",false,true];
	[_caller,"AinjPpneMrunSnonWnonDb_release"] remoteExec ["DIS_playMoveEverywhere",0];
	[_target,"AcinPknlMstpSnonWnonDnon_AmovPknlMstpSnonWnonDnon"] remoteExec ["DIS_playMoveEverywhere",0];	
	DIS_GoD = false;
};


DIS_BeginDrag =
{
	params ["_target","_caller"];
	private _Drug = _target getVariable ["DIS_Drag",false];
	if (_Drug) exitWith {hint "Playing already being dragged!";};
	if !(lifeState _target isEqualTo "INCAPACITATED") exitWith {hint "UNIT IS NOT UNCONSCIOUS.";};
	_target setVariable ["DIS_Drag",true,true];
	[_caller,"AcinPknlMwlkSnonWnonDb"] remoteExec ["DIS_switchMoveEverywhere",0];
	[_target,"AinjPpneMrunSnonWnonDb_still"] remoteExec ["DIS_switchMoveEverywhere",0];
	
	private _Name = name _target;
	private _Addaction3 = [_caller,(format ["Drop %1",_Name]),"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa","_this distance _target < 2","true",{hint "Dropping...";},{},{hint "Dropping!";_this spawn DIS_StopDrag},{hint "Stopped dropping!";},[_target],0.25,0,true,true] call bis_fnc_holdActionAdd;									
	
	DIS_GoD = true;
	while {DIS_GoD && {alive _caller} && {alive _target}} do 
	{
		private _dir = getdir _caller;
		_target setdir (_dir - 180);
		_target setPosATL ([(getPosATL _caller),1,_dir] call BIS_fnc_relPos);
		sleep 0.05;
	};	
	_target setVariable ["DIS_Drag",false,true];
	
};


DIS_AnimWatch = {
	params ["_Unit","_anim"];
	private _HealA = false;
	private _Other = false;
	private _olddmg = 0;
	switch (_anim) do
	{
		case "ainvpknlmstpslaywrfldnon_medic": {_HealA = true;};
		case "ainvpknlmstpslaywrfldnon_medicother": {_HealA = true;_Other = true;};
		case "ainvppnemstpslaywrfldnon_medic": {_HealA = true;};
		case "ainvppnemstpslaywrfldnon_medicother": {_HealA = true;_Other = true;};
		default { };
	};
	if (_HealA) then
	{
		private _NearestM = objNull;
		if (_Other) then
		{
			private _L = nearestObjects [_Unit, ["man"], 5];
			_L = _L - [_Unit];
			if (_L isEqualTo []) exitWith {};
			_NearestM = [_L,_Unit,true,"165"] call dis_closestobj;
		}
		else
		{
			_NearestM = _Unit;
		};
		_olddmg = damage _NearestM;		
		private _items = items _Unit;
		private _HL = false;
		private _HH = false;
		{
			if (_x isEqualTo "Medikit") then {_HH = true;};
		} foreach _items;
		
		if !(_HH) then
		{
			{
				if (_x isEqualTo "FirstAidKit") then {_HL = true;};
			} foreach _items;	
		};

		if (_HH) exitWith
		{
			if (isPlayer _NearestM) then
			{
					[
					[_NearestM],
					{
							params ["_NearestM"];
											_NearestM setAnimSpeedCoef 1;
							[
							parseText 
							"
							<t font='PuristaBold' size='1.6' color='#1DFF30'>Healed With Medikit</t><br/>
							You are combat effective. 
							", 
							[0.25,1.1,1,1], [2,2], 2, 0.7, 0] spawn BIS_fnc_textTiles;
							_NearestM spawn {sleep 2;_this setdamage 0;};
					}
					] remoteExec ["bis_fnc_spawn",_NearestM];				
			};		
				if !(_NearestM isEqualTo _Unit) then 
				{
					[
					parseText 
					"
					<t font='PuristaBold' size='1.6' color='#1DFF30'>Healed With Medikit</t><br/>
					Unit is combat effective. 
					", 
					[0.25,1.1,1,1], [2,2], 2, 0.7, 0] spawn BIS_fnc_textTiles;	
					[
						[_Unit],
						{
								params ["_caller"];
								_caller addscore 2;
						}
					
					] remoteExec ["bis_fnc_Spawn",2];				
				};			
			
		};	
		if (_HL) exitwith 
		{
				if (isPlayer _NearestM) then
				{
					[
					[_NearestM,_olddmg],
					{
							params ["_NearestM","_olddmg"];
							_NearestM setAnimSpeedCoef 1;
							[
							parseText 
							"
							<t font='PuristaBold' size='1.6' color='#1DFF30'>Healed With FAK</t><br/>
							You still require a medikit for a full recovery. 
							", 
							[0.25,1.1,1,1], [2,2], 2, 0.7, 0] spawn BIS_fnc_textTiles;
							if (_olddmg > 0.6) then
							{
								_NearestM spawn {sleep 0.5;_this setdamage 0.6;};
							}
							else
							{
								[_NearestM,_olddmg] spawn {sleep 0.5;(_this select 0) setdamage (_this select 1);};
							};
					}
					] remoteExec ["bis_fnc_spawn",_NearestM];	
				};
				
				if !(_NearestM isEqualTo _Unit) then 
				{
					[
					parseText 
					"
					<t font='PuristaBold' size='1.6' color='#1DFF30'>Healed With FAK</t><br/>
					Unit still requires a medikit for a full recovery. 
					", 
					[0.25,1.1,1,1], [2,2], 2, 0.7, 0] spawn BIS_fnc_textTiles;		
				};
		};		
	};
};

DIS_StartRevive =
{
	params ["_target","_caller"];
	if (stance player isEqualTo "STAND" || stance player isEqualTo "CROUCH") then {[_caller,"AinvPknlMstpSnonWnonDr_medic0"] remoteExec ["DIS_playMoveEverywhere",0];};
	if (stance player isEqualTo "PRONE") then {[_caller,"ainvppnemstpslaywrfldnon_medicother"] remoteExec ["DIS_playMoveEverywhere",0];};
	private _MedDebri = selectRandom ["MedicalGarbage_01_3x3_v1_F","MedicalGarbage_01_3x3_v2_F"];
	private _veh = _MedDebri createVehicle (getposATL _target);
	_veh setposATL (getposATL _target);
	_veh spawn {sleep 30; deleteVehicle _this;};
};

DIS_OnRevive = 
{
	params ["_unit","_caller"];
	[
	[_unit,_caller],
	{
			params ["_unit","_caller"];
			if (isDedicated) exitwith {};
			if !(alive _unit) exitWith {};
			
			private _Act = _unit getVariable ["DIS_DRAGACT",0];
			private _RAct = _unit getVariable ["DIS_REVIVEACT",0];
			[_unit,_Act] call BIS_fnc_holdActionRemove;
			[_unit,_RAct] call BIS_fnc_holdActionRemove;
			_unit setVariable ["DIS_INCAPACITATED",false,true];		
			
			if (_unit isEqualTo player) then
			{
				systemChat "You have been revived!";
				_unit setUnconscious false;
				playMusic "";
				_unit setVariable ["DIS_CurDamage",false];
				_unit setVariable ["DIS_CurCap",0];
				[_unit,"UnconsciousOutProne"] remoteExec ["DIS_playMoveEverywhere",0];
				[_unit,DIS_SuAct] call BIS_fnc_holdActionRemove;
				_unit setAnimSpeedCoef 0.65;_unit setdamage 0.7;_unit spawn {waitUntil {((damage player) < 0.2)};_this setAnimSpeedCoef 1;};
			};
			if (player isEqualTo _caller) then
			{
					_TextColor = '';
					switch ((side _caller)) do 
					{
						case East: {_TextColor = '#E31F00'};
						case West: {_TextColor = '#0A52F7'};
						case Resistance: {_TextColor = '#02FF09'};
						default {_TextColor = '#FDEE05'};
					};
			
			
					disableSerialization;
					_RandomNumber = random 10000;
					
					private _xPosition = 0.15375 * safezoneW + safezoneX;
					private _yPosition = 0.201 * safezoneH + safezoneY;     
						
					private _randomvariableX = random 0.05;
					private _randomvariableY = random 0.05;
					
					_NewXPosition = _xPosition - _randomvariableX;
					_NewYPosition = _yPosition - _randomvariableY;
					
					_RandomNumber cutRsc ["KOZHUD_3","PLAIN"];
					_ui = uiNamespace getVariable "KOZHUD_3";
					(_ui displayCtrl 1100) ctrlSetPosition [_NewXPosition,_NewYPosition];
					(_ui displayCtrl 1100) ctrlCommit 0; 
					(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>You revived: <t color='%2'>%1</t> </t></t></t>",name _unit,_TextColor]);
					_RandomNumber cutFadeOut 10;		
					
					_NewYPosition2 = _NewYPosition + 0.05;		
					(_RandomNumber + 1) cutRsc ["KOZHUD_4","PLAIN"];					
					_ui = uiNamespace getVariable "KOZHUD_4";
					(_ui displayCtrl 1100) ctrlSetPosition [_NewXPosition,_NewYPosition2];
					(_ui displayCtrl 1100) ctrlCommit 0;     
					(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'><t color='%2'>+%1 XP  +%3 CASH</t> </t></t></t>",100,_TextColor,150]);
					(_RandomNumber + 1) cutFadeOut 10;
					DIS_PCASHNUM = DIS_PCASHNUM + 150;
					private _SetExperience = _caller getVariable ["DIS_Experience",0];	
					_SetExperience = _SetExperience + 100;			
					_caller setVariable ["BG_Experience",_SetExperience];				
					[
						[_caller],
						{
								params ["_caller"];
								_caller addscore 5;
						}
					
					] remoteExec ["bis_fnc_Spawn",2]; 

					
			};
	}
	
	] remoteExecCall ["bis_fnc_call",0]; 


};


DIS_HandleDam = 
{
	params ["_unit", "_hitSelection", "_damage","_source","_projectile","_hitPartIndex","_instigator","_hitPoint"];
	if (local _unit) then
	{
		private _Veh = objectParent _unit;
		if !(isNull _Veh) then
		{
			if (damage _Veh > 0.99) then
			{
				[_unit,_veh] spawn
				{
					params ["_unit","_veh"];
					waitUntil {((getpos _veh) select 2) < 5};
					sleep 3;
					_unit action ["Eject",_veh];
				};
			};
		};
		_NewDamage = 0;
		if !(_hitSelection isEqualTo "") exitWith 
		{
			private _predm = _unit getHit _hitSelection;
			private _NewDamage = _predm + _damage; 
			if (_NewDamage > 0.9) then
			{
				private _Incap = _unit getVariable ["DIS_CurCap",diag_tickTime];
				if (_Incap isEqualTo 0) then {_Incap = diag_tickTime;};
				if ((_Incap + 5) < diag_tickTime) exitWith {};
				if (!(_unit getVariable ["DIS_CurDamage",false]) && {(_hitSelection isEqualTo "body" || _hitSelection isEqualTo "head")} && {_NewDamage > 0.9}) then
				{
					_unit setVariable ["DIS_CurDamage",true];
					_unit setVariable ["DIS_CurCap",diag_tickTime];
					_unit setUnconscious true;
					playMusic "LeadTrack04_F_EXP";
					if !(vehicle _unit isEqualTo _unit) then
					{
						//_unit setpos (getpos _unit);
						_unit action ["Eject",(vehicle _unit)];
					};
					[
						[_unit],
						{
								params ["_unit"];
								if !(hasInterface) exitwith {};


								if !(player isEqualTo _unit) then
								{
									DIS_GoD = false;
									private _Name = name _unit;
									private _Addaction = [_unit,(format ["Revive %1",_Name]),"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa","_this distance _target < 2","true",{hint "Reviving!";_this spawn DIS_StartRevive;},{},{hint "Revived!";_this spawn DIS_OnRevive;[player,"amovpknlmstpsraswrfldnon"] remoteExec ["DIS_playMoveEverywhere",0];},{hint "Stopped reviving!";[player,"amovpknlmstpsraswrfldnon"] remoteExec ["DIS_switchMoveEverywhere",0];},[],8,0,true,false] call bis_fnc_holdActionAdd;
									private _Addaction2 = [_unit,(format ["Drag %1",_Name]),"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa","_this distance _target < 2","true",{hint "Dragging...";},{},{hint "Dragging!";_this spawn DIS_BeginDrag},{hint "Stopped dragging!";},[],1,0,true,false] call bis_fnc_holdActionAdd;
									_unit setVariable ["DIS_DRAGACT",_Addaction2];
									_unit setVariable ["DIS_REVIVEACT",_Addaction];
								}
								else
								{
									_unit setVariable ["DIS_INCAPACITATED",true,true];
									[_unit] spawn DIS_fnc_RequestRevive;
									DIS_SuAct = [_unit,"Commit Suicide","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa","_this distance _target < 2","true",{},{},{player setdamage 1;playMusic "";},{},[],4,0,true,true] call bis_fnc_holdActionAdd;
									[
									parseText 
									"
									<t font='PuristaBold' size='1.6' color='#F94601'>Severely Wounded</t><br/>
									You require immediate medical attention...
									", 
									[0.25,0.75,1,1], [10,10], 7, 0.7, 0] spawn BIS_fnc_textTiles;							
								};
						}
						
					] remoteExecCall ["bis_fnc_call",0]; 
					
					
					[
						[_unit],
						{
									params ["_DwnedUnit"];
									if !(hasInterface) exitwith {};
									if !(side (group _DwnedUnit) isEqualTo playerSide) exitWith {};
									//Below if for marking downed friendlies
									private _Img = MISSION_ROOT + "Pictures\reviveMedic.paa";
									[((str _DwnedUnit) + "Downed"), "onEachFrame", 
									{
										params ["_Img","_DwnedUnit"];
										if (alive _DwnedUnit && {_DwnedUnit getVariable ["DIS_INCAPACITATED",true]}) then
										{
											_pos2 = visiblePositionASL _DwnedUnit;
											_pos2 set [2, ((_DwnedUnit modelToWorld [0,0,0]) select 2) + 0.25];
											_alphaText = round(linearConversion[50, 500, player distance2D _DwnedUnit, 1, 0, true]);
											call compile format 
											[
											'
											drawIcon3D
											[
												%1,
												[0.94,0.08,0,%4],
												%2,
												0.75,
												0.75,
												0,
												%3,
												1,
												0.04,
												"RobotoCondensed",
												"center",
												false
											];
											'
											,str _Img,_pos2,str (name _DwnedUnit),_alphaText
											]
										}
										else
										{
											[((str _DwnedUnit) + "Downed"), "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
										};
									},
									[_Img,_DwnedUnit]
									] call BIS_fnc_addStackedEventHandler;	
						}
						
					] remoteExecCall ["bis_fnc_call",0];					
					
					
					
					
					
					
				};
				_NewDamage = 0.9;
			};
			_unit setHit [_hitSelection, _NewDamage];
			enableCamShake true;
			addCamShake [5, 1, 25];
			[20] call BIS_fnc_bloodEffect;			
			_NewDamage
		};
		_NewDamage
	};
};

if (hasInterface) then
{
	player addEventHandler ["animdone",{_this call DIS_AnimWatch;}];
	DIS_Revive = player addEventHandler ["handleDamage",{_this call DIS_HandleDam;}];
	DIS_Revive2 = player addEventHandler ["respawn",{player setVariable ["DIS_CurDamage",false];player setVariable ["DIS_CurCap",0];}];
};