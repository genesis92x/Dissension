params ["_TownArray"];
private _Pole = _TownArray select 2;
private _NameLocation = _TownArray select 1;
private _Marker = _TownArray select 3;
private _SpawnAmount = _TownArray select 8;
private _StrongHoldBuildings = _TownArray select 9;



[
	[_Pole,_NameLocation],
	{
		if !(hasInterface) exitwith {};	

		sleep 10;
		waitUntil {!(isNil "MISSION_ROOT")};
		params ["_Pole","_NameLocation"];
		private _Img = MISSION_ROOT + "Pictures\tridentEnemy_ca.paa";
		[((str _Pole) + "ENGAGED"), "onEachFrame", 
		{
			params ["_Img","_Pole","_NameLocation"];
			if ((_Pole getVariable ["DIS_ENGAGED",false])) then
			{
				_pos2 = getposATL _Pole;
				_pos2 set [2,(_pos2 select 2) + 100];
				_alphaText = linearConversion[1,8000, player distance2D _Pole, 1, 0, true];
				call compile format 
				[
				'
				drawIcon3D
				[
					%1,
					[1,1,1,%3],
					%2,
					0.75,
					0.75,
					0,
					%4,
					1,
					0.04,
					"RobotoCondensed",
					"center",
					false
				];
				'
				,str _Img,_pos2,_alphaText,(str _NameLocation)
				]
			}
			else
			{
				[((str _Pole) + "ENGAGED"), "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
			};
		},
		[_Img,_Pole,_NameLocation]
		] call BIS_fnc_addStackedEventHandler;			
	

	}
	
] remoteExec ["bis_fnc_Spawn",0]; 	