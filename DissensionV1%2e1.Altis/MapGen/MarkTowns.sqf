//Finds the center of the world
_CenterlocationPos = getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition");

//Create a marker to be referenced later. This marker is in the center of the world.
_MarkerNames = random 10000;
_marker1Names = format["marker_%1",_MarkerNames];
_markercenter1 = createMarker [_marker1Names,_CenterlocationPos];
_markercenter1 setMarkerShape "ICON";
_markercenter1 setMarkerType "Empty";
_markercenter1 setmarkersize [0,0];

_LocationCheckArray = ["NameLocal","NameVillage","NameCity","NameCityCapital"];
TownArray = [];
TownCount = 0;
IndControlledArray = [];
BluControlledArray = [];
OpControlledArray = [];
FlagPoleArray = [];
SmallTownArray = [];
MediumTownArray = [];
LargeTownArray = [];
BluLandControlled = [];
OpLandControlled = [];

//VILLAGE SETUP
_nearbyLocations1 = nearestLocations [getMarkerPos _markercenter1, ["NameVillage"], 30000];
{
	_GotPosition = getPos _x;
	private _ClosestOther = [FlagPoleArray,_GotPosition,true] call dis_closestobj;
	if (_ClosestOther distance _GotPosition > 600) then
	{
	TownCount = TownCount + 1;
	
	_CountAmount = 0;
	_CheckPos0 = [(_GotPosition select 0),(_GotPosition select 1),(_GotPosition select 2)];
	_CheckPos1 = [(_GotPosition select 0)+ 200,(_GotPosition select 1),(_GotPosition select 2)];
	_CheckPos2 = [(_GotPosition select 0)- 200,(_GotPosition select 1),(_GotPosition select 2)];
	_CheckPos3 = [(_GotPosition select 0),(_GotPosition select 1) + 200,(_GotPosition select 2)];
	_CheckPos4 = [(_GotPosition select 0),(_GotPosition select 1) - 200,(_GotPosition select 2)];
	
	if (surfaceIsWater _CheckPos0) then
	{
	_CountAmount = _CountAmount + 1;
	};
	if (surfaceIsWater _CheckPos1) then
	{
	_CountAmount = _CountAmount + 1;
	};
	if (surfaceIsWater _CheckPos2) then
	{
	_CountAmount = _CountAmount + 1;
	};
	if (surfaceIsWater _CheckPos3) then
	{
	_CountAmount = _CountAmount + 1;
	};
	if (surfaceIsWater _CheckPos4) then
	{
	_CountAmount = _CountAmount + 1;
	};
	
	if (_CountAmount < 4) then
	{
		_FlagPole = createSimpleObject ["Sign_F",[0,0,0]]; 
		_FlagPole setvariable ["DIS_PLAYERVEH",true];
		_FlagPole setpos _GotPosition;
		_FlagNames = random 10000;
		_marker1Namesz = format["%2_%1",_FlagNames,TownCount];
		_marker1z = createMarker [_marker1Namesz,_GotPosition];
		_marker1z setmarkershape "ICON";
		_marker1z setMarkerType "mil_dot_noShadow";
		_marker1z setmarkercolor "ColorWhite";
		_marker1z setmarkersize [1,1];
		if (Dis_debug isEqualTo 0) then 
		{
			_marker1z setMarkerAlpha 0;
		};
		//_poleaddaction = _FlagPole addaction ["Reclaim", ""];
		//_locationName = name _x;
		_locationName = text _x;
		_MarkerNames = random 10000;
		_marker1Names = format["%2_%1",_MarkerNames,TownCount];
		_marker1 = createMarker [_marker1Names,_GotPosition];
		_marker1 setmarkershape "ELLIPSE";
		_marker1 setmarkercolor "ColorGreen";
		_marker1 setMarkerBrush "Border";
		_marker1 setmarkersize [500,500];
		if (Dis_debug isEqualTo 0) then {
		_marker1 setMarkerAlpha 0;
		};
		
		
		
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			//////////////////////////////////////STRONGHOLD LOCATION IN TOWNS//////////////////////////////////////////////////
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			private _AllObjects = nearestObjects [_FlagPole, ["Building"],350];
			private _ArrayCount = [];
			{
				if ((typeof _x) in DIS_BuildingListVanilla && {(count _ArrayCount) < 100}) then 
				{
					_ArrayCount pushback _x;
				};
			} foreach _AllObjects;
			
			
			//Now we select 3
			private _FinalStrongholds = _ArrayCount;
			
			
			/*
				{
					private _RandomPoint = selectRandom _ArrayCount;
					if !(isNil "_RandomPoint") then
					{
						if (!(_RandomPoint isEqualTo []) && {!(_ArrayCount isEqualTo [])}) then
						{
							_FinalStrongholds pushBack _RandomPoint;
							_ArrayCount = _ArrayCount - [_RandomPoint];
						};
					};
				} count [1,2];
			*/
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			//////////////////////////////////////STRONGHOLD LOCATION IN TOWNS//////////////////////////////////////////////////
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
		
		
		
		
		_NewArray = [_marker1Names,_locationName,_FlagPole,_marker1,0,0,0,false,20,_FinalStrongholds];
		FlagPoleArray pushback _FlagPole;
		TownArray pushback _NewArray;
		IndControlledArray pushback _FlagPole;
		
		
		SmallTownArray = SmallTownArray + [_FlagPole];
	};
	};
} forEach _nearbyLocations1;

//CITY SETUP
_nearbyLocations1 = nearestLocations [getMarkerPos _markercenter1, ["NameCity"], 30000];
{
_GotPosition = getPos _x;
private _ClosestOther = [FlagPoleArray,_GotPosition,true] call dis_closestobj;
if (_ClosestOther distance _GotPosition > 600) then
{
TownCount = TownCount + 1;

_CountAmount = 0;
_CheckPos0 = [(_GotPosition select 0),(_GotPosition select 1),(_GotPosition select 2)];
_CheckPos1 = [(_GotPosition select 0)+ 300,(_GotPosition select 1),(_GotPosition select 2)];
_CheckPos2 = [(_GotPosition select 0)- 300,(_GotPosition select 1),(_GotPosition select 2)];
_CheckPos3 = [(_GotPosition select 0),(_GotPosition select 1) + 300,(_GotPosition select 2)];
_CheckPos4 = [(_GotPosition select 0),(_GotPosition select 1) - 300,(_GotPosition select 2)];

if (surfaceIsWater _CheckPos0) then
{
_CountAmount = _CountAmount + 1;
};
if (surfaceIsWater _CheckPos1) then
{
_CountAmount = _CountAmount + 1;
};
if (surfaceIsWater _CheckPos2) then
{
_CountAmount = _CountAmount + 1;
};
if (surfaceIsWater _CheckPos3) then
{
_CountAmount = _CountAmount + 1;
};
if (surfaceIsWater _CheckPos4) then
{
_CountAmount = _CountAmount + 1;
};

if (_CountAmount < 4) then
{
_FlagPole = createSimpleObject ["Sign_F",[0,0,0]]; 
_FlagPole setvariable ["DIS_PLAYERVEH",true];
_FlagPole setpos _GotPosition;
_FlagNames = random 10000;
_marker1Namesz = format["%2_%1",_FlagNames,TownCount];
_marker1z = createMarker [_marker1Namesz,_GotPosition];
_marker1z setmarkershape "ICON";
_marker1z setMarkerType "mil_dot_noShadow";
_marker1z setmarkercolor "ColorWhite";
_marker1z setmarkersize [1,1];
if (Dis_debug isEqualTo 0) then {
_marker1z setMarkerAlpha 0;
};
//_poleaddaction = _FlagPole addaction ["Reclaim", "VCOMZombie\ZFunctions\VCOM_Reclaim.sqf"];
//_locationName = name _x;
_locationName = text _x;
_MarkerNames = random 10000;
_marker1Names = format["%2_%1",_MarkerNames,TownCount];
_marker1 = createMarker [_marker1Names,_GotPosition];
_marker1 setmarkershape "ELLIPSE";
_marker1 setmarkercolor "ColorGreen";
_marker1 setMarkerBrush "Border";
if (Dis_debug isEqualTo 0) then {
_marker1 setMarkerAlpha 0;
};
_marker1 setmarkersize [600,600];



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////STRONGHOLD LOCATION IN TOWNS//////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
private _AllObjects = nearestObjects [_FlagPole, ["Building"],450];
			private _ArrayCount = [];
			{
				if ((typeof _x) in DIS_BuildingListVanilla && {(count _ArrayCount) < 100}) then 
				{
					_ArrayCount pushback _x;
					
				};
			} foreach _AllObjects;


			//Now we select 3
			private _FinalStrongholds = _ArrayCount;
			
			/*
				{
					private _RandomPoint = selectRandom _ArrayCount;
					if !(isNil "_RandomPoint") then
					{
						if (!(_RandomPoint isEqualTo []) && {!(_ArrayCount isEqualTo [])}) then
						{
							//private _StrongholdMarker = createMarker [(format ["%1-%2",_RandomPoint,(random 1000)]),(getpos _RandomPoint)];
							//_StrongholdMarker setmarkershape "RECTANGLE";
							//_StrongholdMarker setmarkercolor "ColorBlack";
							//_StrongholdMarker setMarkerBrush "Grid";
							//_StrongholdMarker setmarkersize [15,15];
							//_StrongholdMarker setMarkerText "Stronghold";
							//_StrongholdMarker setMarkerDir (getDir _RandomPoint);
							_FinalStrongholds pushBack _RandomPoint;
							_ArrayCount = _ArrayCount - [_RandomPoint];
						};
					};
				} count [1,2,3];
			*/
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////STRONGHOLD LOCATION IN TOWNS//////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




_NewArray = [_marker1Names,_locationName,_FlagPole,_marker1,0,0,0,false,40,_FinalStrongholds];
FlagPoleArray pushback _FlagPole;
TownArray pushback _NewArray;
IndControlledArray pushback _FlagPole;

MediumTownArray = MediumTownArray + [_FlagPole];
};
};
} forEach _nearbyLocations1;

//CAPITAL SETUP
_nearbyLocations1 = nearestLocations [getMarkerPos _markercenter1, ["NameCityCapital"], 30000];
{
_GotPosition = getPos _x;
private _ClosestOther = [FlagPoleArray,_GotPosition,true] call dis_closestobj;
if (_ClosestOther distance _GotPosition > 600) then
{	
TownCount = TownCount + 1;
_CountAmount = 0;
_CheckPos0 = [(_GotPosition select 0),(_GotPosition select 1),(_GotPosition select 2)];
_CheckPos1 = [(_GotPosition select 0)+ 500,(_GotPosition select 1),(_GotPosition select 2)];
_CheckPos2 = [(_GotPosition select 0)- 500,(_GotPosition select 1),(_GotPosition select 2)];
_CheckPos3 = [(_GotPosition select 0),(_GotPosition select 1) + 500,(_GotPosition select 2)];
_CheckPos4 = [(_GotPosition select 0),(_GotPosition select 1) - 500,(_GotPosition select 2)];

if (surfaceIsWater _CheckPos0) then
{
_CountAmount = _CountAmount + 1;
};
if (surfaceIsWater _CheckPos1) then
{
_CountAmount = _CountAmount + 1;
};
if (surfaceIsWater _CheckPos2) then
{
_CountAmount = _CountAmount + 1;
};
if (surfaceIsWater _CheckPos3) then
{
_CountAmount = _CountAmount + 1;
};
if (surfaceIsWater _CheckPos4) then
{
_CountAmount = _CountAmount + 1;
};

if (_CountAmount < 4) then
{
_FlagPole = createSimpleObject ["Sign_F",[0,0,0]]; 
_FlagPole setvariable ["DIS_PLAYERVEH",true];

_FlagPole setpos _GotPosition;
_FlagNames = random 10000;
_marker1Namesz = format["%2_%1",_FlagNames,TownCount];
_marker1z = createMarker [_marker1Namesz,_GotPosition];
_marker1z setmarkershape "ICON";
_marker1z setMarkerType "mil_dot_noShadow";
_marker1z setmarkercolor "ColorWhite";
_marker1z setmarkersize [1,1];
if (Dis_debug isEqualTo 0) then {
_marker1z setMarkerAlpha 0;
};
//_poleaddaction = _FlagPole addaction ["Reclaim", "VCOMZombie\ZFunctions\VCOM_Reclaim.sqf"];
//_locationName = name _x;
_locationName = text _x;
_MarkerNames = random 10000;
_marker1Names = format["%2_%1",_MarkerNames,TownCount];
_marker1 = createMarker [_marker1Names,_GotPosition];
_marker1 setmarkershape "ELLIPSE";
_marker1 setmarkercolor "ColorGreen";
_marker1 setMarkerBrush "Border";
if (Dis_debug isEqualTo 0) then {
_marker1 setMarkerAlpha 0;
};
_marker1 setmarkersize [1000,1000];


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////STRONGHOLD LOCATION IN TOWNS//////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
private _AllObjects = nearestObjects [_FlagPole, ["Building"],650];
			private _ArrayCount = [];
			{
				if ((typeof _x) in DIS_BuildingListVanilla && {(count _ArrayCount) < 100}) then 
				{
					_ArrayCount pushback _x;
					
				};
			} foreach _AllObjects;


			//Now we select 3
			private _FinalStrongholds = _ArrayCount;
			
			/*
				{
					private _RandomPoint = selectRandom _ArrayCount;
					if !(isNil "_RandomPoint") then
					{
						if (!(_RandomPoint isEqualTo []) && {!(_ArrayCount isEqualTo [])}) then
						{
							//private _StrongholdMarker = createMarker [(format ["%1-%2",_RandomPoint,(random 1000)]),(getpos _RandomPoint)];
							//_StrongholdMarker setmarkershape "RECTANGLE";
							//_StrongholdMarker setmarkercolor "ColorBlack";
							//_StrongholdMarker setMarkerBrush "Grid";
							//_StrongholdMarker setmarkersize [15,15];
							//_StrongholdMarker setMarkerText "Stronghold";
							//_StrongholdMarker setMarkerDir (getDir _RandomPoint);
							_FinalStrongholds pushBack _RandomPoint;
							_ArrayCount = _ArrayCount - [_RandomPoint];
						};
					};
				} count [1,2,3];
			*/
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////STRONGHOLD LOCATION IN TOWNS//////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



_NewArray = [_marker1Names,_locationName,_FlagPole,_marker1,0,0,0,false,70,_FinalStrongholds];

FlagPoleArray pushback _FlagPole;
TownArray pushback _NewArray;
IndControlledArray pushback _FlagPole;

LargeTownArray = LargeTownArray + [_FlagPole];




};
};
} forEach _nearbyLocations1;











_nearbyLocations1 = nearestLocations [getMarkerPos _markercenter1, ["NameLocal"], 30000];

SmallLocationArray = [];
{
_markerPos = getPos _x;
private _ClosestOther = [FlagPoleArray,_markerPos,true] call dis_closestobj;
if (_ClosestOther distance _markerPos > 600) then
{
	_AllObjects = nearestObjects [_markerPos, ["Building"], 200];
	_GotPosition = [0,0,0];
	if (count _AllObjects < 1) then {_GotPosition = _markerPos;} 
	else 
	{
		_CordXArray = 0;
		_CordYArray = 0;
		_CordZArray = 0;
		_CCount = 0;
		{
			private _Pos = getpos _x;
			_CordXArray = _CordXArray + (_Pos select 0);
			_CordYArray = _CordYArray + (_Pos select 1);
			_CordZArray = _CordZArray + (_Pos select 2);
			_CCount = _CCount + 1;
		} foreach _AllObjects;
			
		
		_GotPosition = [(_CordXArray/(_CCount)),(_CordYArray/(_CCount)),(_CordZArray/(_CCount))];
	};

	
	_CountAmount = 0;
	_CheckPos0 = [(_GotPosition select 0),(_GotPosition select 1),(_GotPosition select 2)];
	_CheckPos1 = [(_GotPosition select 0)+ 200,(_GotPosition select 1),(_GotPosition select 2)];
	_CheckPos2 = [(_GotPosition select 0)- 200,(_GotPosition select 1),(_GotPosition select 2)];
	_CheckPos3 = [(_GotPosition select 0),(_GotPosition select 1) + 200,(_GotPosition select 2)];
	_CheckPos4 = [(_GotPosition select 0),(_GotPosition select 1) - 200,(_GotPosition select 2)];
	
	if (surfaceIsWater _CheckPos0) then
	{
	_CountAmount = _CountAmount + 1;
	};
	if (surfaceIsWater _CheckPos1) then
	{
	_CountAmount = _CountAmount + 1;
	};
	if (surfaceIsWater _CheckPos2) then
	{
	_CountAmount = _CountAmount + 1;
	};
	if (surfaceIsWater _CheckPos3) then
	{
	_CountAmount = _CountAmount + 1;
	};
	if (surfaceIsWater _CheckPos4) then
	{
	_CountAmount = _CountAmount + 1;
	};
	
	if (_CountAmount < 3) then
	{
		_FlagPole = createSimpleObject ["Sign_F",[0,0,0]];
		_FlagPole setvariable ["DIS_PLAYERVEH",true];
		_FlagPole setpos _GotPosition;
		_FlagNames = random 10000;
		_marker1Namesz = format["%2_%1",_FlagNames,TownCount];
		_marker1z = createMarker [_marker1Namesz,_GotPosition];
		_marker1z setmarkershape "ICON";
		_marker1z setMarkerType "mil_dot_noShadow";
		_marker1z setmarkercolor "ColorWhite";
		_marker1z setmarkersize [1,1];
		if (Dis_debug isEqualTo 0) then 
		{
			_marker1z setMarkerAlpha 0;
		};

		_locationName = text _x;
		_MarkerNames = random 10000;
		_marker1Names = format["%2_%1",_MarkerNames,TownCount];
		_marker1 = createMarker [_marker1Names,_GotPosition];
		_marker1 setmarkershape "ELLIPSE";
		_marker1 setmarkercolor "ColorGreen";
		_marker1 setMarkerBrush "Border";
		_marker1 setmarkersize [400,400];
		if (Dis_debug isEqualTo 0) then {
		_marker1 setMarkerAlpha 0;
		};
		
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			//////////////////////////////////////STRONGHOLD LOCATION IN TOWNS//////////////////////////////////////////////////
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			private _AllObjects = nearestObjects [_FlagPole, ["Building"],200];
			private _ArrayCount = [];
			{
				if ((typeof _x) in DIS_BuildingListVanilla && {(count _ArrayCount) < 100}) then 
				{
					_ArrayCount pushback _x;
					
				};
			} foreach _AllObjects;
			
			
			//Now we select 3
			private _FinalStrongholds = _ArrayCount;
			
			/*
				{
					private _RandomPoint = selectRandom _ArrayCount;
					if !(isNil "_RandomPoint") then
					{
						if (!(_RandomPoint isEqualTo []) && {!(_ArrayCount isEqualTo [])}) then
						{
							//private _StrongholdMarker = createMarker [(format ["%1-%2",_RandomPoint,(random 1000)]),(getpos _RandomPoint)];
							//_StrongholdMarker setmarkershape "RECTANGLE";
							//_StrongholdMarker setmarkercolor "ColorBlack";
							//_StrongholdMarker setMarkerBrush "Grid";
							//_StrongholdMarker setmarkersize [15,15];
							//_StrongholdMarker setMarkerText "Stronghold";
							//_StrongholdMarker setMarkerDir (getDir _RandomPoint);				
							_FinalStrongholds pushBack _RandomPoint;
							_ArrayCount = _ArrayCount - [_RandomPoint];
						};
					};
				} count [1];
			*/
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			//////////////////////////////////////STRONGHOLD LOCATION IN TOWNS//////////////////////////////////////////////////
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
		
		
		_NewArray = [_marker1Names,_locationName,_FlagPole,_marker1,0,0,0,false,20,_FinalStrongholds];
		FlagPoleArray pushback _FlagPole;
		TownArray pushback _NewArray;
		IndControlledArray pushback _FlagPole;
		
		
		SmallLocationArray = SmallLocationArray + [_FlagPole];
	};
	};

} foreach _nearbyLocations1;





//let's see if we want to limit the map size, for a quicker fast paced game or a long drawn out game.
private _TownLimitDist = "RegionSize" call BIS_fnc_getParamValue;
private _PickARandomSpot = selectRandom FlagPoleArray;
private _NewFlagArray = [];
private _NewTownArray = [];
{
	if (_x distance2D _PickARandomSpot < _TownLimitDist) then
	{
		_NewFlagArray pushback _x;
	};
} foreach FlagPoleArray;

FlagPoleArray = [];


{
	if ((_x select 2) in _NewFlagArray) then
	{
		_NewTownArray pushback _x;
	}
	else
	{
		deleteMarker (_x select 3);
		deleteVehicle (_x select 2);
	};
} foreach TownArray;
TownArray = [];


TownArray = _NewTownArray;
FlagPoleArray = _NewFlagArray;









publicVariable "TownArray";
publicVariable "FlagPoleArray";

[] spawn
{
	sleep 2;
	publicVariable "TownArray";
	publicVariable "FlagPoleArray";
};