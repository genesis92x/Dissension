//Function for communicating to a side what town is under attack.
//if (side (group _ClosestUnit)) then {West call DIS_fnc_AtkMrk;} else {East call DIS_fnc_AtkMrk;};

params ["_SIDE"];
playSound "Beep_Target";

if (_Side isEqualTo West) then
{
	{
		private _pole = _x select 0;
		private _orgmrk = _x select 1;
		_markername = floor (random 1000);
		_marker1 = createMarkerLocal [format ["%1-%2",_markername,_pole],(getpos _pole)];
		_marker1 setMarkerShapeLocal "ELLIPSE";
		_marker1 setMarkerColorLocal "ColorBlue";
		_marker1 setMarkerBrushLocal "FDiagonal";
		_marker1 setMarkerSizeLocal [((getMarkerSize _orgmrk) select 0),((getMarkerSize _orgmrk) select 1)];
		_marker1 spawn {sleep 30;deleteMarkerLocal _this;};
	} foreach DIS_WENGAGED;
	systemChat "SHOWING ALL ENGAGED TOWNS BY BLUFOR";
	if (count W_CurrentTargetArray > 0) then
	{
		private _SelTown = W_CurrentTargetArray select 0;

		
		private _TotalPoles = [];
		{
			_TotalPoles pushback (_x select 2);
		} foreach TownArray;
		{
			_TotalPoles pushBack (_x select 4);
		} foreach CompleteRMArray;

		
		private _NearestTown = [_TotalPoles,_SelTown,true] call dis_closestobj;
		
		{
			private _Pole = _x select 2;
			if (_NearestTown isEqualTo _Pole && {_NearestTown distance2D _Pole < 15}) exitWith
			{
				private _LocationName = _x select 1;
				private _TotalDistance = _NearestTown distance2D player;
				[format ["CURRENT TARGETED TOWN IS: %1. IT IS %2M away.",(toUpper _LocationName),(round _TotalDistance)],'#46C202'] spawn Dis_MessageFramework;
			};
		} foreach TownArray;
		{
			private _Pole = _x select 4;
			if (_NearestTown isEqualTo _Pole && {_NearestTown distance2D _Pole < 15}) exitWith
			{
				private _LocationName = markerText (_x select 0);
				private _TotalDistance = _NearestTown distance2D player;
				[format ["CURRENT TARGETED GRID IS: %1. IT IS %2M away.",_LocationName,(round _TotalDistance)],'#46C202'] spawn Dis_MessageFramework;
			};
		} foreach CompleteRMArray;		
	};
}
else
{

	{
		private _pole = _x select 0;
		private _orgmrk = _x select 1;	
		_markername = floor (random 1000);
		_marker1 = createMarkerLocal [format ["%1-%2",_markername,_pole],(getpos _pole)];
		_marker1 setMarkerShapeLocal "ELLIPSE";
		_marker1 setMarkerColorLocal "ColorRed";
		_marker1 setMarkerBrushLocal "FDiagonal";
		_marker1 setMarkerSizeLocal [((getMarkerSize _orgmrk) select 0),((getMarkerSize _orgmrk) select 1)];
		_marker1 spawn {sleep 30;deleteMarkerLocal _this;};
	} foreach DIS_EENGAGED;
	systemChat "SHOWING ALL ENGAGED TOWNS BY OPFOR";
	if (count E_CurrentTargetArray > 0) then
	{
		private _SelTown = E_CurrentTargetArray select 0;
		private _TotalPoles = [];
		{
			_TotalPoles pushback (_x select 2);
		} foreach TownArray;
		{
			_TotalPoles pushBack (_x select 4);
		} foreach CompleteRMArray;
		
		private _NearestTown = [_TotalPoles,_SelTown,true] call dis_closestobj;
		
		
		{
			private _Pole = _x select 2;
			if (_NearestTown isEqualTo _Pole && {_NearestTown distance2D _Pole < 15}) exitWith
			{
				private _LocationName = _x select 1;
				private _TotalDistance = _NearestTown distance2D player;
				[format ["CURRENT TARGETED TOWN IS: %1. IT IS %2M away.",(toUpper _LocationName),(round _TotalDistance)],'#46C202'] spawn Dis_MessageFramework;
			};
		} foreach TownArray;
		{
			private _Pole = _x select 4;
			if (_NearestTown isEqualTo _Pole && {_NearestTown distance2D _Pole < 15}) exitWith
			{
				private _LocationName = markerText (_x select 0);
				private _TotalDistance = _NearestTown distance2D player;
				[format ["CURRENT TARGETED GRID IS: %1. IT IS %2M away.",_LocationName,(round _TotalDistance)],'#46C202'] spawn Dis_MessageFramework;
			};
		} foreach CompleteRMArray;
	
	};	

};