params ["_CSide","_Buildings"];


//W_SupplyP = [];
//Lets determine some faction specific factors here. Things like units to use and etc.
private _BarrackU = [];
private _LFactU = [];
private _HFactU = [];
private _AirU = [];
private _MedU = [];
private _AdvU = [];
private _TeamLU = [];
private _SquadLU = [];
private _Comm = "No";
private _color = "colorblack";
private _MarkerName = "No";
private _Buildinglist = "no";
private _camps = [];
private _EnemyArray = [];
private _WestRun = false;


if (_CSide isEqualTo West) then
{
	_BarrackU = W_BarrackU;
	_LFactU = W_LFactU;
	_HFactU = W_HFactU;
	_AirU = W_AirU;
	_MedU = W_MedU;
	_AdvU = W_AdvU;
	_TeamLU = W_TeamLU;
	_SquadLU = W_SquadLU;
	_Comm = Dis_WestCommander;
	_Buildinglist = W_BuildingList;
	_camps = W_GuerC;	
	_Color = "ColorBlue";
	_WestRun = true;

}
else
{
	_BarrackU = W_BarrackU;
	_LFactU = W_LFactU;
	_HFactU = W_HFactU;
	_AirU = W_AirU;
	_MedU = W_MedU;
	_AdvU = W_AdvU;
	_TeamLU = W_TeamLU;
	_SquadLU = W_SquadLU;
	_Comm = Dis_EastCommander;	
	_Buildinglist = E_BuildingList;
	_camps = E_GuerC;	
	_Color = "ColorRed";
	_WestRun = false;

};
	
	
	private _TotalTerr = [_CSide,false,false] call dis_compiledTerritory;
	{
		private _Loc = _x;
		private _Added = false;
		
		//We need to check if the location already has a supply point.
		//We also need to check if we need to remove the bunkers from the other faction.
		if (_WestRun) then 
		{
			if (_Loc in W_SupplyP) then {_Added = true;};
			if (_Loc in E_SupplyP) then 
			{
				E_SupplyP = E_SupplyP - [_Loc];
				private _SP = _Loc getVariable ["DIS_SP",objNull];
				if !(isNull _SP) then {deleteVehicle _SP;};
			};
		}
		else
		{
			if (_Loc in E_SupplyP) then {_Added = true;};		
			if (_Loc in W_SupplyP) then 
			{
				W_SupplyP = W_SupplyP - [_Loc];
				private _SP = _Loc getVariable ["DIS_SP",objNull];
				if !(isNull _SP) then {deleteVehicle _SP;};
			};			
		};
		
		//If the location does NOT have a supply point, then...
		if !(_Added) exitWith
		{
			//Add the supply point to the Supply array.
			if (_WestRun) then {W_SupplyP pushback _Loc;} else {E_SupplyP pushback _Loc;};
			
			//We need to find a good spawn location in the area.
			private _LocPos = (getpos _Loc);
			private _Locations = selectBestPlaces [_LocPos, 50, "(1 - houses) * (1 + meadow) * (1 - sea)", 1, 1];
			private _Sel = (selectRandom _Locations) select 0;
			private _position = _Sel findEmptyPosition [0,200,(_Buildings select 0)];
			if (_position isEqualTo []) then {_position = _Sel;};
			
			
			//We now need to spawn in the buildings/nets we want the cargo to spawn in.
			private _b = (_Buildings select 0) createVehicle _position;
			_Loc setVariable ["DIS_SP",_b];
			
			//Create a marker for friendlies on the appropriate side
			[
			[_b,_color,_CSide],
			{
					private _Building = _this select 0;
					private _color = _this select 1;
					private _CSide = _this select 2;
					private _Marker = createMarkerLocal [format ["ID_%1",_Building],[0,0,0]];
					_Marker setMarkerColorLocal _color;
					_Marker setMarkerSizeLocal [0.5,0.5];			
					_Marker setMarkerShapeLocal 'ICON';		
					_Marker setMarkerTypeLocal "b_installation";
					_Marker setMarkerDirLocal (getdir (_Building));	
					_Marker setMarkerTextLocal "Supply Point";
					_Marker setMarkerPosLocal (getposASL (_Building));
					_Building setVariable ["DIS_Marker",_Marker];
					_Building addEventHandler ["killed", {private _M = (_this select 0) getVariable ["DIS_Marker",null]; deleteMarker _M;}];
					_Building addEventHandler ["Deleted", {private _M = (_this select 0) getVariable ["DIS_Marker",null]; deleteMarker _M;}];
					if (isServer) then {[_CSide,_Marker,_Building,"SupplyCreate"] call DIS_fnc_mrkersave;};
					if (playerSide isEqualTo _CSide) then
					{
						_Marker setMarkerAlphaLocal 1;
					}
					else
					{
						_Marker setMarkerAlphaLocal 0;
					};				
		
		
			}
			
			] remoteExec ["bis_fnc_Spawn",0]; 					
					
			
			
			
			
			
			
			
			
			//Now. From here we will let the supplycreate loop handle spawning resources for these areas.
		};
		
		
		
		
		
		true;
	} count _TotalTerr;