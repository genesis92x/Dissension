//This will define any necessary variables and get out player setup :D
sleep 5;

//Array of current AI controlled by the player
Dis_PSpwnedCnt = [];
Dis_PlayerGroups = [];
Dis_GroupManage = true;
private _PlayerName = (name player);
//Let's define the function that will constantly monitor the AI units for us.
Dis_fnc_UnitLoop =
{
	private _Side = playerSide;
	private _PlayerName = (name player);	
	private _Color = "ColorRed";
	private _Inf = "o_inf";
	if (_Side isEqualTo West) then
	{
		_Color = "ColorBlue";
		_Inf = "b_inf";
	};
	while {Dis_GroupManage} do
	{
	
	
		{
			if !((group _x) in Dis_PlayerGroups) then
			{
				Dis_PlayerGroups pushback (group _x);				
			};
			if !(alive _x) then {Dis_PSpwnedCnt = Dis_PSpwnedCnt - [_x];};
		} foreach Dis_PSpwnedCnt;
	
		{
			if (count (units _x) < 1) then {Dis_PlayerGroups = Dis_PlayerGroups - [_x];};		
		} foreach Dis_PlayerGroups;
	
	
	
	
		sleep 30;
	};
};








DIS_fnc_KeyDown =
{
	params ["_Display","_Button","_shift","_ctrl","_alt"];
	if (visibleMap) then
	{
		if (_Button isEqualTo 35) then
		{
			"Dissension AI Control" hintC 
			[
			"Holding down CTRL and left clicking on a group will allow you to merge it with another.",
			"Holding down CTRL and left clicking twice on a group will split the group in half. You can not specifically control what units leave.",
			"Left click within 15 meters of a group will begin issuing a MOVE command. Left click anywhere on the map to clear all waypoints and issue a new move command.",
			"Holding down ALT and left clicking on a vehicle will allow you to embark troops.",
			"Holding down ALT and left clicking on a vehicle filled with AI will tell them to disembark."
			];
		};
	};	
		
	
};


DIS_CtrlActive = false;
DIS_LftClick = false;
DIS_AltActive = false;
DIS_CurrentMoveGroup = "";
DIS_CurrentMergeGroup = "";
DIS_CurrentEmbarkGroup = "";
DIS_FinalGroupMerge = "";

DIS_fnc_MouseDown =
{
	params ["_Display","_Button","_xC","_yC","_shift","_ctrl","_alt"];
	if (count Dis_PlayerGroups > 0) then
	{
	if (visibleMap) then
	{
		_pos = (findDisplay 12 displayCtrl 51) ctrlMapScreenToWorld getMousePosition;		
		
		//LEFT CLICK THEN ALT LEFT CLICK. This will command any units not inside vehicles to load into nearby vehicles
		if (_Button isEqualTo 0 && _alt || DIS_AltActive) exitWith
		{
			if !(DIS_AltActive) then
			{
				(findDisplay 12 displayCtrl 51)  ctrlMapCursor ["Track", "Track3D"];
				DIS_AltActive = true;
				DIS_CurrentEmbarkGroup = [Dis_PlayerGroups,_pos,true] call dis_closestobj;
				hint format ["Click near a vehicle to tell the group %1 to embark! Click near their embarked vehicle to have the units disembark.",DIS_CurrentEmbarkGroup];
			}
			else
			{
				(findDisplay 12 displayCtrl 51)  ctrlMapCursor ["Track", "Track"];
				DIS_FinalEmbarkGroup = nearestObjects [_pos, ["AllVehicles"], 15];
				systemChat format ["DIS_FinalEmbarkGroup: %1",DIS_FinalEmbarkGroup];
				{
					if (_x isKindOf "MAN") then {DIS_FinalEmbarkGroup = DIS_FinalEmbarkGroup - [_x];};
				} foreach DIS_FinalEmbarkGroup;
				if (count DIS_FinalEmbarkGroup < 1) exitWith {DIS_AltActive = false;hint "No nearby vehicle selected.";};		

				//Embark Group
				if (leader DIS_CurrentEmbarkGroup isEqualTo vehicle (leader DIS_CurrentEmbarkGroup)) then 
				{
					private _Units =  (units DIS_CurrentEmbarkGroup);
					private _vehicle1 = DIS_FinalEmbarkGroup select 0;
					if (leader DIS_CurrentEmbarkGroup distance _vehicle1 > 25) exitWith {hint "Units too far to embark in the vehicle!";};					
					{
						[_x] allowGetIn true;
						_x moveInAny _Vehicle1;
						if (_x isEqualTo (vehicle _x)) then
						{
							if (count DIS_FinalEmbarkGroup > 1) then
							{
								_x moveInAny DIS_FinalEmbarkGroup select 1;
							};
						};
					} foreach _Units;
					
					hint format ["%1 Units embarking...",DIS_CurrentEmbarkGroup];
				} 
				//DisEmbark Group				
				else
				{
					private _Units =  (units DIS_CurrentEmbarkGroup);
					hint format ["%1 Units Disembarking!",DIS_CurrentEmbarkGroup];
					{
						[_x] orderGetIn false;
						[_x] allowGetIn false;
					} foreach _Units;
				};				
				DIS_AltActive = false;				
			};
		};		
		
		
		//CTRL
		if (_ctrl && (_Button isEqualTo 0)) exitWith
		{
			if !(DIS_CtrlActive) then
			{
				(findDisplay 12 displayCtrl 51)  ctrlMapCursor ["Track", "Track3D"];
				DIS_CtrlActive = true;
				DIS_CurrentMergeGroup = [Dis_PlayerGroups,_pos,true] call dis_closestobj;
				hint format ["Click another group to merge %1! Or click the same group to split it.",DIS_CurrentMergeGroup];
			}
			else
			{
				(findDisplay 12 displayCtrl 51)  ctrlMapCursor ["Track", "Track"];
				DIS_FinalGroupMerge = [Dis_PlayerGroups,_pos,true] call dis_closestobj;
				if (isNil "DIS_FinalGroupMerge" || {isNull DIS_FinalGroupMerge}) exitWith {};
				
				//Split Group
				if (DIS_CurrentMergeGroup isEqualTo DIS_FinalGroupMerge) then 
				{
					private _Units =  (units DIS_CurrentMergeGroup);
					private _GroupCount = count _Units;
					private _HalfCount = round (_groupCount/2);
					private _NewGroup = creategroup playerside;
					for "_i" from 0 to _HalfCount do 
					{
						private _rndUnit = selectrandom _Units;
						[_rndUnit] joinSilent _NewGroup;
						_Units = _Units - [_rndUnit];
					};
					hint format ["%1 Group Split!",DIS_CurrentMergeGroup];
					if !(leader _NewGroup in Dis_PSpwnedCnt) then {Dis_PSpwnedCnt pushback (leader _NewGroup)};
				} 
				//Merge Group				
				else
				{
					hint format ["Merging with group %1!",DIS_FinalGroupMerge];
					{
						[_x] joinsilent DIS_FinalGroupMerge;
					} foreach (units DIS_CurrentMergeGroup);
				};				
				DIS_CtrlActive = false;
				
			};	
					
		};		
		
		//JUST LEFT CLICK		
		if (_Button isEqualTo 0 && !(_ctrl)) exitWith
		{
			DIS_CurrentMoveGroup = [Dis_PlayerGroups,_pos,true] call dis_closestobj;
			if (!(DIS_LftClick) && (leader DIS_CurrentMoveGroup) distance _pos < 20) exitWith
			{
				(findDisplay 12 displayCtrl 51)  ctrlMapCursor ["Track", "Move3D"];			
				hint format ["Click to order %1 group to move!",DIS_CurrentMoveGroup];			
				DIS_LftClick = true;
			};
			
			if (DIS_LftClick) then
			{
				_pos = (findDisplay 12 displayCtrl 51) ctrlMapScreenToWorld getMousePosition;	
				private _Grid = mapGridPosition _pos;
				DIS_LftClick = false;				
				(findDisplay 12 displayCtrl 51)  ctrlMapCursor ["Track", "Track"];	
				[_pos,_Grid] spawn
				{
					params ["_pos","_Grid"];
					while {(count (waypoints DIS_CurrentMoveGroup)) > 0} do
					{
						deleteWaypoint ((waypoints DIS_CurrentMoveGroup) select 0);
					};				
					_waypoint = DIS_CurrentMoveGroup addwaypoint[_pos,1];			
					_waypoint setwaypointtype "MOVE";
					_waypoint setWaypointSpeed "NORMAL";
					_waypoint2 = DIS_CurrentMoveGroup addwaypoint[_pos,1];
					_waypoint2 setwaypointtype "MOVE";
					_waypoint2 setWaypointSpeed "NORMAL";		
					_waypoint showWaypoint "ALWAYS";
					_waypoint2 showWaypoint "ALWAYS";						
					hint format ["Group %1 has been ordered to move to %2!",DIS_CurrentMoveGroup,_Grid];
					
					//Lets add a marker on the map so that we know where the group is going.
					private _MarkerName = format ["IDWP_%1",DIS_CurrentMoveGroup];
					if !(getMarkerColor _MarkerName isEqualTo "") then {deleteMarker _MarkerName};
					_Marker = createMarkerLocal [_MarkerName,[0,0,0]];
					_Color = "ColorYellow";
					_Icon = "o_inf";
					if (side DIS_CurrentMoveGroup isEqualTo West) then {_Icon = "b_inf";};
					_Marker setMarkerColorLocal _Color;
					_Marker setMarkerTypeLocal _Icon;
					_Marker setMarkerShapeLocal 'ICON';
					_Marker setMarkerSizeLocal [0.5,0.5];	
					_Marker setMarkerTextLocal format ["AI - %1 MOVE",(name Player)];
					_Marker setMarkerPosLocal _pos;
					//Monitor marker and delete it if the group gets close.
					[_Marker,DIS_CurrentMoveGroup] spawn
					{
						params ["_Marker","_Group"];
						while {{alive _x} count (units _Group) > 1 && {(leader _Group) distance (getMarkerPos _Marker) > 25} && {!(getMarkerColor _Marker isEqualTo "")}} do
						{
							sleep 5;
						};
						deleteMarker _Marker;
					};
					
				};
			};
		};	
		
	};	
	};
};


waitUntil {alive player};
[] spawn Dis_fnc_UnitLoop;
Dis_MouseDown = (findDisplay 46) displayAddEventHandler ["MouseButtonDown", "_this call DIS_fnc_MouseDown"];
Dis_ButtonDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "_this call DIS_fnc_KeyDown"];


