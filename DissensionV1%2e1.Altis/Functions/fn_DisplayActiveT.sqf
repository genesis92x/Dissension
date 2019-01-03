params ["_TownInfo","_DefendSide"];

private _Pole = _TownInfo select 2;
private _NameLocation = _TownInfo select 1;
private _Marker = _TownInfo select 3;
private _SpawnAmount = _TownInfo select 8;
private _StrongHoldBuildings = _TownInfo select 9;

if (isNil "_Pole") exitWIth {};

[
	[_Pole,_NameLocation,_DefendSide],
	{
		if !(hasInterface) exitwith {};	
		params ["_Pole","_NameLocation","_DefendSide"];
		sleep 10;
		private _GetInfo = _Pole getVariable "DIS_Captureattacker";
		private _AttackerSide = _GetInfo select 2;
		systemChat format ["_AttackerSide:: %1",_AttackerSide];
		if (_AttackerSide isEqualTo playerSide) then
		{
		waitUntil {!(isNil "MISSION_ROOT")};
		private _Img = MISSION_ROOT + "Pictures\tridentEnemy_ca.paa";
		[((str _Pole) + "ENGAGED"), "onEachFrame", 
		{
			params ["_Img","_Pole","_NameLocation","_DefendSide"];
			if ((_Pole getVariable ["DIS_ENGAGED",false])) then
			{
				_pos2 = getpos _Pole;
				_pos2 set [2,((_pos2 select 2) + 100)];
				_alphaText = round(linearConversion[1,8000, player distance2D _Pole, 1, 0, true]);
				call compile format 
				[
				'
				drawIcon3D
				[
					%1,
					[0.9,0.08,0,%3],
					%2,
					0.75,
					0.75,
					0,
					%4,
					2,
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
		[_Img,_Pole,_NameLocation,_DefendSide]
		] call BIS_fnc_addStackedEventHandler;			
		}
		else
		{
			waitUntil {!(isNil "MISSION_ROOT")};
			params ["_Pole","_NameLocation","_DefendSide"];
			if (playerSide isEqualTo _DefendSide) then
			{
				private _Img = MISSION_ROOT + "Pictures\defend_ca.paa";
				[((str _Pole) + "DEFEND"), "onEachFrame", 
				{
					params ["_Img","_Pole","_NameLocation","_DefendSide"];
					if ((_Pole getVariable ["DIS_ENGAGED",false])) then
					{
						_pos2 = getpos _Pole;
						_pos2 set [2,((_pos2 select 2) + 100)];
						_alphaText = round(linearConversion[1,8000, player distance2D _Pole, 1, 0, true]);
						call compile format 
						[
						'
						drawIcon3D
						[
							%1,
							[0,0.19,0.88,,%3],
							%2,
							0.75,
							0.75,
							0,
							%4,
							2,
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
						[((str _Pole) + "DEFEND"), "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
					};
				},
				[_Img,_Pole,_NameLocation]
			] call BIS_fnc_addStackedEventHandler;						
			};
		};

	}
	
] remoteExec ["bis_fnc_Spawn",0]; 	