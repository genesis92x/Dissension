//Function for requesting a missile barrage on the selected region, a radius of 250 meters.

DIS_PICKLOCATION = [0,0,0];
openMap [true, true];
closeDialog 2;
["Select Barrage Position! The area is bombarded with 30 advanced artillery rounds, in a radius of 150 meters. ",'#FFFFFF'] call Dis_MessageFramework;

["DIS_RQSTMISSILE", "onMapSingleClick", 
	{
		//hintSilent str position (_this select 0)
		DIS_PICKLOCATION = _pos;
		if (DIS_PICKLOCATION distance2D player < 2000) then
		{
			if (DIS_WestCommander distance2D DIS_PICKLOCATION > 500 && {DIS_EastCommander distance2D DIS_PICKLOCATION > 500}) then
			{
				openMap [false, false];	
				private _pos = [(DIS_PICKLOCATION select 0),(DIS_PICKLOCATION select 1),5];
				["DIS_RQSTMISSILE", "onMapSingleClick"] call BIS_fnc_removeStackedEventHandler;
				_pos spawn
				{
					playSound "artillery_acknowledged";
					sleep 5;
					playSound "artillery_rounds_complete";
					sleep 5;
					playSound "artillery_accomplished";
					sleep 3;
					{
						sleep 1;
						private _rnd = random 150;
						private _dist = (_rnd + 1);
						private _dir = random 360;
						private _positions = [(_this select 0) + (sin _dir) * _dist, (_this select 1) + (cos _dir) * _dist,1000];
						private _shell = createVehicle ["Missile_AGM_02_F", _positions, [], 0, "CAN_COLLIDE"];  
						[_shell, -90, 0] call BIS_fnc_setPitchBank;
						
						true;
					} count [1,2,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30];						
				};
			}
			else
			{
				["You are selecting an area too close to the commander.",'#FFFFFF'] call Dis_MessageFramework;
			};
		}
		else
		{
			["You need to select an area less than 2000 meters away from you.",'#FFFFFF'] call Dis_MessageFramework;
		};
		
	}, []
] call BIS_fnc_addStackedEventHandler;

