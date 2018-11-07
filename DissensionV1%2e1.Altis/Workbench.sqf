private _list = [] call DIS_fnc_EmyLst;
private _Enem = (_list select 0) + (_list select 2);
private _PBuildingList = W_BuildingList;
private _BuildingList = [];

{
	(_x select 0) pushBack _BuildingList;
	true;
} count _PBuildingList;

{
	if (!(isplayer (leader _x)) && {side _x isEqualTo east}) then
	{
		private _lead = leader _x;
		private _pos = getPosASL _lead;
		private _ClstPlayer = [allplayers,_pos,true] call dis_closestobj;
		private _ClstBuild = [_BuildingList,_pos,true] call dis_closestobj;
		if (_ClstPlayer distance2D _lead > 700 && {_ClstBuild distance2D _lead > 700}) then
		{
			{
				if (_x distance2D _lead < 700 && {!(isplayer _x)} && {!(_x isEqualTo DIS_WestCommander)} && {!(_x isEqualTo DIS_EastCommander)}) then
				{
					(vehicle _x) setdamage 1;
				};
				true;
			} count _Enem;
		};		
	};
} foreach allgroups;
if (Dis_debug isEqualTo 1) then {systemChat "KILLED UNITS TO COMPENSATE FOR PLAYER DISADVANTAGE.";};
DIS_EPLYERADV = false;[] spawn {sleep 300;DIS_EPLYERADV = true;};
