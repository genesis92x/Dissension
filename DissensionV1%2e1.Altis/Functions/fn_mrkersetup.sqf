//"Scout","Static","Harass"
/*
		W_Markers = [];
		E_Markers = [];
		[West,_Marker,_Unit,"StaticDeploy"] call DIS_fnc_mrkersave; 
		[[WEST,"respawn_west_97735",[6162.66,8462.3,40.4825],"Building"]]
*/

DIS_MrkerSetup = true;
if (playerSide isEqualTo West) then
{
	{
		_x execFSM "MarkerUpdate.fsm";
	} foreach W_Markers;
	
	//_NewArray = [_marker1Names,_locationName,_FlagPole,_marker1,0,0,0,false,60];
	{
		_FlagPole = _x select 2;
		_marker1 = _x select 3;
		if (_FlagPole in BluControlledArray) then
		{
			_marker1 setMarkerColorLocal "ColorBlue";
			_marker1 setMarkerAlphaLocal 0.3;
		};
	} foreach TownArray;
	

	{
			_x setMarkerColorLocal "ColorBlue";
			_x setMarkerAlphaLocal 0.3;
	} foreach BluLandControlled;
	//_SummedOwned = BluLandControlled + BluControlledArray;
	
	
}
else
{
	{
		_x execFSM "MarkerUpdate.fsm";
	} foreach E_Markers;
	
	//_NewArray = [_marker1Names,_locationName,_FlagPole,_marker1,0,0,0,false,60];
	{
		_FlagPole = _x select 2;
		_marker1 = _x select 3;
		if (_FlagPole in OpControlledArray) then
		{
			_marker1 setMarkerColorLocal "ColorRed";
			_marker1 setMarkerAlphaLocal 0.3;
		};
	} foreach TownArray;
		
	{
			_x setMarkerColorLocal "ColorRed";
			_x setMarkerAlphaLocal 0.3;
	} foreach OpLandControlled;
	//_SummedOwned = OpLandControlled + OpControlledArray;	
	
};



/*
EXAMPLE
_test = [WEST,"respawn_west_49397",[1792.03,8226.99,16.7712],"Building","Barracks"];
_Side = _test select 0;
_MarkerName = _test select 1;
_loc = _test select 2;
_Style = _test select 3;
_StructureName = _test select 4;

private _Marker = "";

	_Color = 'ColorRed';
_WestRun = false;
if (_Side isEqualTo West) then
{
	_WestRun = true;
	_Color = 'ColorBlue';
};

if (_WestRun) then
{
	if (_StructureName isEqualTo "Barracks") then {_Marker = createMarkerlocal [_MarkerName,_Loc];} else {_Marker = createMarkerlocal [format["Building_%1",_Loc],_Loc];};
}
else
{
	if (_StructureName isEqualTo "Barracks") then {_Marker = createMarkerlocal [_MarkerName,_Loc];} else {_Marker = createMarkerlocal [format["Building_%1",_Loc],_Loc];};
};



_Marker setMarkerShapelocal 'ICON';
_Marker setMarkerColorlocal _Color;
_Marker setMarkerAlphalocal 1;
_Marker setMarkerSizelocal [1,1];
_Marker setMarkerDirlocal 0;	
_Marker setMarkerTypelocal 'loc_Bunker';
_Marker setMarkerTextlocal format ["%1",_StructureName];		
systemChat format ["%1",_Color];



*/