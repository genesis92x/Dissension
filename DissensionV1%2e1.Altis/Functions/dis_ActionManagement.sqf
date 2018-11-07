waitUntil {alive player};
uisleep 2;
private _ActionA = false;
private _ACT = 0;
private _ACT2 = 1;
private _NB = [0,0,0];

if (side (group player) isEqualTo West) then
{
	waitUntil {!(isNil "W_BuildingList")};
	waitUntil
	{
			while {_NB distance2D player > 1000} do
			{
				private _BuildingArray = [];
				{
					_BuildingArray pushback (_x select 0);
				} foreach W_BuildingList;	
				_NB = [_BuildingArray,getpos player,true] call dis_closestobj;
				uisleep 10;
			};
	
			_ACT = player addaction ["Group Management",{disableSerialization;([] call BIS_fnc_displayMission) createDisplay "RscDisplayDynamicGroups";}];
			_ACT2 = player addaction ["OPEN TABLET",{[] spawn dis_fnc_TabletOpen;}];
			
			while {_NB distance2D player < 1000} do
			{
				private _BuildingArray = [];
				{
					_BuildingArray pushback (_x select 0);
				} foreach W_BuildingList;	
				_NB = [_BuildingArray,getpos player,true] call dis_closestobj;
				uisleep 10;
			};			
			
			player removeAction _ACT;
			player removeAction _ACT2;
			uisleep 10;
			false
	};
}
else
{
	waitUntil {!(isNil "E_BuildingList")};
	waitUntil
	{
			while {_NB distance2D player > 1000} do
			{
				private _BuildingArray = [];
				{
					_BuildingArray pushback (_x select 0);
				} foreach W_BuildingList;	
				_NB = [_BuildingArray,getpos player,true] call dis_closestobj;
				uisleep 10;
			};
	
			_ACT = player addaction ["Group Management",{disableSerialization;([] call BIS_fnc_displayMission) createDisplay "RscDisplayDynamicGroups";}];
			_ACT2 = player addaction ["OPEN TABLET",{[] spawn dis_fnc_TabletOpen;}];
			
			while {_NB distance2D player < 1000} do
			{
				private _BuildingArray = [];
				{
					_BuildingArray pushback (_x select 0);
				} foreach W_BuildingList;	
				_NB = [_BuildingArray,getpos player,true] call dis_closestobj;
				uisleep 10;
			};			
			
			player removeAction _ACT;
			player removeAction _ACT2;
			uisleep 10;
			false
	};





};

