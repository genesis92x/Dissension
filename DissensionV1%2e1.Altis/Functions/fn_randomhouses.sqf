/*
	Author: Genesis

	Description:
		Picks random amount of objects from an array, and returns them. Debug mode creates markers named "HOUSE SPAWN". Originally intended to find VIRTUALIZED HOUSES for AI to spawn in.
		
	Parameter(s):
		0: Buildings list

	Returns:
		0: List of random buildings
	Example1: private _HouseList = [_StrongHoldBuildings] call DIS_fnc_randomhouses;	
*/


private _RandomHouses = [];
private _MaxNumber = 0;
private _Houselists = _this;

{
	if (_MaxNumber < 10) then
	{
		private _RHouse1 = (selectRandom _Houselists);
		_RandomHouses pushback _RHouse1;
		_Houselists = _Houselists - [_RHouse1];
		_MaxNumber = _MaxNumber + 1;
		if (Dis_debug) then
		{
			if (isNil "DIS_TESTMARKERARRAY") then {DIS_TESTMARKERARRAY = [];};
			private _Marker = createMarkerlocal [(str _x),(getPosWorld _x)];
			_Marker setMarkerShapelocal 'ICON';
			_Marker setMarkerColorlocal "ColorBlack";
			_Marker setMarkerAlphalocal 1;		
			_Marker setMarkerSizelocal [1,1];
			_Marker setMarkerDirlocal 0;	
			_Marker setMarkerTypelocal 'loc_Bunker';
			_Marker setMarkerTextlocal "HOUSE SPAWN";
			DIS_TESTMARKERARRAY pushback _Marker;
		};
	};
} foreach _this;


_RandomHouses