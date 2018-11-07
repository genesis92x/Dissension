//{deletemarker _x } foreach CompleteMapMarkerArray;
//{deletemarker _x } foreach ResourceDisplayMarkers;

//This script dynamically creates the resource system
//Created: 11/9/14 
//Modified : 11/26/16 - Modified from Degeneration
Dis_ResourceMapDone = false;

//Lets get the size of the world here - so we know how many markers to create.
_MapSize2 = worldSize;

//If the map does not have offset's defined, use Altis's size. Not the best work around.
if (_MapSize2 isEqualTo 0) then {_MapSize2 = 30720;};

//Divded the size by 1000 to get 1KMx1KM chunks
_TotalLength = _MapSize2/1000;

//Round the number
_TotalLengthRounded = round _TotalLength;


	//Start Debug Code
	if (Dis_debug isEqualTo 1) then {systemChat format ["ResourceGrid.sqf: _TotalLengthRounded = %1",_TotalLengthRounded];
								systemChat "ResourceGrid.sqf: STARTING LOCATIONS!";};
	//End Debug Code

//Initial offset that will work for most maps.
_StartingPosition = [500,500,0];

//Define needed variables.
_NewPosition = 0;
ResourceMapArrayCount = 0;
ResourceMapMarkerArray = [];
WaterMapMarkerArray = [];
ResourceMapMarkerArrayStarters = [];
ResourceDisplayMarkers = [];
IndLandControlled = [];

while {_TotalLengthRounded > _NewPosition} do 
{
	ResourceMapArrayCount = ResourceMapArrayCount + 1;
	_MarkerNames = format["%1_%2","ResourceMap",ResourceMapArrayCount];

	_marker1 = createMarker [_MarkerNames,_StartingPosition];

	_StartingPosition = [(_StartingPosition select 0),(_StartingPosition select 1) + 1000,0];

	_marker1 setmarkershape "RECTANGLE";
	_marker1 setmarkercolor "ColorGreen";
	_marker1 setmarkersize [500,500];


	_NewPosition = _NewPosition + 1;
	ResourceMapMarkerArrayStarters pushBackUnique _marker1;
};


	//Start Debug Code
	if (Dis_Debug isEqualTo 1) then {systemChat "DGN_CreateResourceMap.sqf: ADDING REST OF MAP!";};
	//End Debug Code


{
	_TotalLength = _MapSize2/1000;
	_NewPosition = 0;
	_GetMarkerPos = getMarkerPos _x;
	
	while {_TotalLength > _NewPosition} do
		{
			ResourceMapArrayCount = ResourceMapArrayCount + 1;
			_MarkerNames = format["%1_%2","ResourceMap",ResourceMapArrayCount];


			_StartingPosition = [(_GetMarkerPos select 0) + 1000,(_GetMarkerPos select 1),0];

			_GetMarkerPos = _StartingPosition;

			_marker1 = createMarker [_MarkerNames,_StartingPosition];

			_marker1 setmarkershape "RECTANGLE";
			_marker1 setmarkercolor "ColorGreen";
			_marker1 setmarkersize [500,500];


			_NewPosition = _NewPosition + 1;
			ResourceMapMarkerArray pushBackUnique _marker1;
		};
} foreach ResourceMapMarkerArrayStarters;

{
	ResourceMapMarkerArray pushBackUnique _x;
} foreach ResourceMapMarkerArrayStarters;

	//Start Debug Code
	if (Dis_Debug isEqualTo 1) then {systemChat "DGN_CreateResourceMap.sqf: REMOVING TILES THAT MAKE NO SENSE.";};
	//End Debug Code

{
	_MarkerPos = getMarkerPos _x;

	_x setMarkerAlpha 0;

	_CountAmount = 0;
	_CheckPos0 = [(_MarkerPos select 0),(_MarkerPos select 1),(_MarkerPos select 2)];
	_CheckPos1 = [(_MarkerPos select 0)+ 500,(_MarkerPos select 1),(_MarkerPos select 2)];
	_CheckPos2 = [(_MarkerPos select 0)- 500,(_MarkerPos select 1),(_MarkerPos select 2)];
	_CheckPos3 = [(_MarkerPos select 0),(_MarkerPos select 1) + 500,(_MarkerPos select 2)];
	_CheckPos4 = [(_MarkerPos select 0),(_MarkerPos select 1) - 500,(_MarkerPos select 2)];

	if (surfaceIsWater _CheckPos0) then {_CountAmount = _CountAmount + 1;};
	if (surfaceIsWater _CheckPos1) then {_CountAmount = _CountAmount + 1;};
	if (surfaceIsWater _CheckPos2) then {_CountAmount = _CountAmount + 1;};
	if (surfaceIsWater _CheckPos3) then {_CountAmount = _CountAmount + 1;};
	if (surfaceIsWater _CheckPos4) then {_CountAmount = _CountAmount + 1;};

	//If tile has more four spots of water - remove it from the ResourceMap array.
	if (_CountAmount > 1) then 
	{
		ResourceMapMarkerArray = ResourceMapMarkerArray - [_x];
		WaterMapMarkerArray pushBackUnique _x;
	};

} foreach ResourceMapMarkerArray;


	//Start Debug Code
	if (Dis_Debug isEqualTo 1) then 
	{
		systemChat format ["DGN_CreateResourceMap.sqf: TotalMarkers = %1",count ResourceMapMarkerArray];
		systemChat format ["DGN_CreateResourceMap.sqf: WaterMapMarkerArray = %1",count WaterMapMarkerArray];
	};
	//End Debug Code
publicVariable "ResourceMapMarkerArray";
publicVariable "WaterMapMarkerArray";

CompleteMapMarkerArray = [];
CompleteMapMarkerArray append ResourceMapMarkerArray;
CompleteMapMarkerArray append WaterMapMarkerArray;


publicVariable "CompleteMapMarkerArray";


CompleteRMArray = [];
//Lets generate the random resources!
{
	_Pos = getMarkerPos _x;
	
	_ResourceDistroRandom = selectRandom [1,2,3,4];
	_CashFlowRandom = round (random 30);
	_PowerFlowRandom = round (random 30);
	_OilFlowRandom = round (random 30);
	_MaterialsFlowRandom = round (random 60);
	_FinalSelection = false;
	
	if (_CashFlowRandom isEqualTo 0) then {_CashFlowRandom = 1;};
	if (_PowerFlowRandom isEqualTo 0) then {_PowerFlowRandom = 1;};
	if (_OilFlowRandom isEqualTo 0) then {_OilFlowRandom = 1;};
	if (_MaterialsFlowRandom isEqualTo 0) then {_MaterialsFlowRandom = 1;};	

	_Marker = createMarker [format["Zone_%1_Resource_Marker",_Pos],_Pos];
	_Marker setMarkerShape 'ICON';
	_Marker setMarkerColor 'ColorOrange';
	_Marker setMarkerAlpha 0.4;
	_Marker setMarkerDir 0;

	ResourceDisplayMarkers pushBackUnique _Marker;
	
	if (_ResourceDistroRandom isEqualTo 1) then 
	{
		_Marker setMarkerType 'loc_Tourism';
		_Marker setMarkerText format ["Cash: %1",_CashFlowRandom];
		_FinalSelection = ["Cash",_CashFlowRandom];
	};
	
	if (_ResourceDistroRandom isEqualTo 2) then 
	{
		_Marker setMarkerType 'loc_Power';
		_Marker setMarkerText format ["Power: %1",_PowerFlowRandom];
		_FinalSelection = ["Power",_PowerFlowRandom];
	};	
	if (_ResourceDistroRandom isEqualTo 3) then 
	{
		_Marker setMarkerType 'loc_Fuelstation';
		_Marker setMarkerText format ["Oil: %1",_OilFlowRandom];
		_FinalSelection = ["Fuel",_OilFlowRandom];
	};	
	if (_ResourceDistroRandom isEqualTo 4) then 
	{
		_Marker setMarkerType 'loc_Stack';
		_Marker setMarkerText format ["Materials: %1",_MaterialsFlowRandom];
		_FinalSelection = ["Materials",_MaterialsFlowRandom];
	};		
	_Marker setMarkerSize [0.5,0.5];
	_location = createSimpleObject ["Land_WoodenCrate_01_F",[0,0,0]]; 
	_location setpos _pos;	
	_location setVariable ["DIS_PLAYERVEH",true];
	_location hideObjectGlobal true;
	_location allowdamage false;
	_location enableSimulationGlobal false;
	private _LocPos = getpos _location;
	private _SafePosSpwn = [_LocPos, 1, 250, 5, 0, 20, 0,[],[_LocPos,_LocPos]] call BIS_fnc_findSafePos;
	CompleteRMArray pushBackUnique [_Marker,_FinalSelection,_x,false,_location,_SafePosSpwn];
	IndLandControlled pushBackUnique _x;
} foreach ResourceMapMarkerArray;

//Lets make towns give all 3 bonuses!
//_NewArray = [_marker1Names,_locationName,_FlagPole,_marker1,0];

CompleteTaskResourceArray = [];

//_NewArray = [_marker1Names,_locationName,_FlagPole,_marker1,0,0,0,false,30];
{
	_Marker = _x select 3;
	_Pole = _x select 2;
	_Pole hideObjectGlobal true;
	_Pole allowdamage false;
	_Pole enableSimulationGlobal false;	
	_Loc = _x select 1;
	_Pos = getMarkerPos _Marker;	
	if !(_Pole in SmallLocationArray) then
	{
		_CashFlowRandom = round (random 30);
		_PowerFlowRandom = round (random 30);
		_OilFlowRandom = round (random 30);
		_MaterialsFlowRandom = round (random 60);
		
		if (_CashFlowRandom isEqualTo 0) then {_CashFlowRandom = 1;};
		if (_PowerFlowRandom isEqualTo 0) then {_PowerFlowRandom = 1;};
		if (_OilFlowRandom isEqualTo 0) then {_OilFlowRandom = 1;};
		if (_MaterialsFlowRandom isEqualTo 0) then {_MaterialsFlowRandom = 1;};	
		
		//_Pole setVariable ["Dis_Info",[_CashFlowRandom,_PowerFlowRandom,_OilFlowRandom,_MaterialsFlowRandom],true];
		CompleteTaskResourceArray pushBackUnique [_Pole,[_CashFlowRandom,_PowerFlowRandom,_OilFlowRandom,_MaterialsFlowRandom],_Loc,_Pos,_Marker];
	}
	else
	{
		_AllObjects = nearestObjects [_Pos, [], 200];
		_MaterialsFlowRandom = 0;
		_OilFlowRandom = 0;
		_PowerFlowRandom = 0;
		_CashFlowRandom = 0;
		{
			_Wood = ["Wood",str _x] call BIS_fnc_inString;
			_Timber = ["timber",str _x] call BIS_fnc_inString;
			_Bulldozer = ["bulldozer",str _x] call BIS_fnc_inString;
			_Excavator = ["excavator",str _x] call BIS_fnc_inString;
			_Haultruck = ["haultruck",str _x] call BIS_fnc_inString;
			_Crane = ["crane",str _x] call BIS_fnc_inString;
			_Shop = ["shop",str _x] call BIS_fnc_inString;
			_Warehouse = ["warehouse",str _x] call BIS_fnc_inString;
			_Cargo = ["cargo",str _x] call BIS_fnc_inString;
			if (_Wood || {_Timber} || {_Bulldozer} || {_Excavator}|| {_Haultruck}|| {_Crane}|| {_Shop}|| {_Warehouse} || {_Cargo}) then
			{
				_MaterialsFlowRandom = _MaterialsFlowRandom + 1;
			};
			_Pipe = ["pipe",str _x] call BIS_fnc_inString;
			_Fuel = ["fuel",str _x] call BIS_fnc_inString;
			if (_Pipe || {_Fuel}) then
			{
				_OilFlowRandom = _OilFlowRandom + 1;
			};
			_Radar = ["radar",str _x] call BIS_fnc_inString;
			_Poles = ["pole",str _x] call BIS_fnc_inString;
			_Power = ["power",str _x] call BIS_fnc_inString;
			_Factory = ["factory",str _x] call BIS_fnc_inString;
			if (_Radar || {_Poles} || {_Power} || {_Factory}) then
			{
				_PowerFlowRandom = _PowerFlowRandom + 1;
			};		
			_market = ["market",str _x] call BIS_fnc_inString;
			_boat = ["boat",str _x] call BIS_fnc_inString;
			_water = ["water",str _x] call BIS_fnc_inString;
			if (_market || {_boat} || {_water}) then
			{
				_CashFlowRandom = _CashFlowRandom + 1;
			};
			
		} foreach _AllObjects;
	
		if (_MaterialsFlowRandom > 15) then {_MaterialsFlowRandom = 15};
		if (_OilFlowRandom > 15) then {_OilFlowRandom = 15};
		if (_CashFlowRandom > 15) then {_CashFlowRandom = 15};
		if (_PowerFlowRandom > 15) then {_PowerFlowRandom = 15};
		if ((_MaterialsFlowRandom + _OilFlowRandom + _CashFlowRandom + _PowerFlowRandom) isEqualTo 0) then {_MaterialsFlowRandom = 1;_OilFlowRandom = 1;_CashFlowRandom = 1;_PowerFlowRandom = 1;};
		CompleteTaskResourceArray pushBackUnique [_Pole,[_CashFlowRandom,_PowerFlowRandom,_OilFlowRandom,_MaterialsFlowRandom],_Loc,_Pos,_Marker];	
	
	};
} foreach TownArray;










publicVariable "CompleteTaskResourceArray";
publicVariable "CompleteRMArray";
publicVariable "IndLandControlled";
Dis_ResourceMapDone = true;
publicVariable "Dis_ResourceMapDone";



