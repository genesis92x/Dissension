//This function will be called every 60 seconds to check for stuck units and execute code appropariately.
private _Blacklist = allplayers;
_Blacklist pushback DIS_WESTCOMMANDER;
_Blacklist pushback DIS_EASTCOMMANDER;
{
	if (!(_x in _Blacklist) && {!(_x isKindOf "StaticWeapon")} && {!(_x getVariable ["DIS_SPECIAL",false])}) then
	{
		//Now let's figure out if the unit is stuck or not.
		private _Var = _x getVariable ["DIS_STKV",[(getPosWorld _x),0,0]];
		_Var params ["_DSTK","_NSTK","_NTM"];
		
		private _NPOS = getPosWorld _x;
		if (_DSTK distance2D _NPOS < 5) then
		{
			if (_NSTK isEqualTo 10) then
			{
				if (_NTM isEqualTo 3) then
				{
					//We have tried to move the unit 3 times, now we just destroy it.
					if (([allplayers,_x,true,"ST"] call dis_closestobj) distance2D _x > 200) then
					{
						private _OP = objectParent _x;
						if (isNull _OP) then
						{
							_x setDamage 1;
						}
						else
						{
							{
								_x setDamage 1;
							} foreach (crew _OP);
							_OP setdamage 1;
						};
					};
				}
				else
				{
					//Move unit before attempting to destroy it.
					private _ClstEn = _x call dis_ClosestEnemy;
					private _direction = _x getdir _ClstEn;
					private _NewPosition = [_x,250,_direction] call BIS_fnc_relPos;
					private _FindRoadS = _NewPosition nearRoads 100;
					private _FinalPos = [0,0,0];
					if (_FindRoadS isEqualTo []) then {_FinalPos = _NewPosition;} else {_SelRoad = [_FindRoads,_ClstEn,true] call dis_closestobj;_FinalPos = (getpos _SelRoad)};
					private _position = [_FinalPos,0,400,0,0,1,0,[],[_FinalPos,_FinalPos]] call BIS_fnc_findSafePos;
					if (_position isEqualTo []) then {_position = _NewPosition};
					(vehicle _x) setpos _position;
					
					
					_NTM = _NTM + 1;
					_NSTK = 0;
					_x setVariable ["DIS_STKV",[_NPOS,_NSTK,_NTM]];				
				};
			}
			else
			{
				_NSTK = _NSTK + 1;
				_x setVariable ["DIS_STKV",[_NPOS,_NSTK,_NTM]];
			};
			
		};		
	};	
} foreach allunits;