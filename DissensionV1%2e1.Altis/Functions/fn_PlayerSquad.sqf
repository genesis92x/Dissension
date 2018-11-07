//
sleep 5;
while {true} do 
{
	{
		if (isPlayer (leader _x)) then
		{
			_AlreadySet = _x getVariable ["DIS_PGROUP",false];
			if !(_AlreadySet) then
			{
				_x setVariable ["DIS_PGROUP",true];
				[
				[_x],
				{
					_Group = _this select 0;
					_Marker = createMarkerLocal [format ["ID_%1",_Group],[0,0,0]];
					_Color = "ColorRed";
					_Icon = "o_inf";
					if (side _Group isEqualTo West) then {_Color = "ColorBlue";_Icon = "b_inf";};
					_Marker setMarkerColorLocal _Color;
					_Marker setMarkerTypeLocal _Icon;
					_Marker setMarkerShapeLocal 'ICON';
					_Marker setMarkerSizeLocal [0.5,0.5];						
					
					if (playerSide isEqualTo (side _Group)) then
					{
						_Marker setMarkerAlphaLocal 1;
					}
					else
					{
						_Marker setMarkerAlphaLocal 0;
					};			
					
					while {({alive _x} count (units _Group)) > 0} do
					{
						_Marker setMarkerDirLocal (getdir (leader _Group));	
						_Marker setMarkerTextLocal format ["%1 - %2",groupId _group,({alive _x} count (units _Group))];
						_Marker setMarkerPosLocal (getposASL (leader _Group));			
						sleep 1.25;
					};
					_Group setVariable ["DIS_PGROUP",false];
					sleep 5;
					deleteMarker _Marker;
				}
				
				] remoteExec ["bis_fnc_Spawn",0];
			};
		};
	} foreach allgroups;
	sleep 35;
};