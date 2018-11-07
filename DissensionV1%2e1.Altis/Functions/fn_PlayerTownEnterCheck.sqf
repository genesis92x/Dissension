//Function that checks if the player comes within 1km of a town. Then it displays a message, and who owns it.
sleep 30;
private _CurrentTown = objNull;
waitUntil
{
	sleep 5;
	//[_marker1Names,_locationName,_FlagPole,_marker1,0,0,0,false,70,_FinalStrongholds];
	private _NearestTown = [FlagPoleArray,(getpos Player),true] call dis_closestobj;
	if !(_NearestTown isEqualTo _CurrentTown) then
	{
		{
			private _Pole = _x select 2;
			if (_NearestTown isEqualTo _Pole && {player distance _Pole < 1001}) exitWith
			{
				_CurrentTown = _Pole;
				private _LocationName = _x select 1;
				[
					[
						[format ["%1",(toUpper _LocationName)],"align = 'left' shadow = '0' size = '0.75' font='PuristaBold'"],
						["","<br/>"],
						[format ["%1",([daytime] call BIS_fnc_timeToString)],"align = 'left' shadow = '0' size = '0.75' font='PuristaBold'"]
												
					]
				] spawn BIS_fnc_typeText2;	
			};
		} foreach TownArray;
	};
	false
};
