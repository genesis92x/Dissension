/*
	Author: Genesis

	Description:
		Finds nearest friendly town

	Parameter(s):
		0: Starting Town
		1: Side

	Returns:
		0: Closest friendly town
		1: Index of town in TownArray
		3: Town Complete information -> [_marker1Names,_locationName,_FlagPole,_marker1,0,0,0,false,20,_FinalStrongholds];
	Example1: [_Obj1,resistance] call Dis_fnc_ClosestFriendlyTown;
*/
params ["_Town","_Side"];
private _TownRtrn = [];

switch (_Side) do 
{
    case resistance: 
		{
			private _ClstLoc = [IndControlledArray,_Town,true] call dis_closestobj;
			private _IndexRtn = TownArray findIf {(_x select 2) isEqualTo _ClstLoc};
			_TownRtrn = [_ClstLoc,_IndexRtn,(TownArray select _IndexRtn)];
		};
    case east: 
		{
			private _ClstLoc = [OpControlledArray,_Town,true] call dis_closestobj;
			private _IndexRtn = TownArray findIf {(_x select 2) isEqualTo _ClstLoc};
			_TownRtrn = [_ClstLoc,_IndexRtn,(TownArray select _IndexRtn)];
		};
    case west: 
		{
			private _ClstLoc = [BluControlledArray,_Town,true] call dis_closestobj;
			private _IndexRtn = TownArray findIf {(_x select 2) isEqualTo _ClstLoc};
			_TownRtrn = [_ClstLoc,_IndexRtn,(TownArray select _IndexRtn)];
		};		
};


_TownRtrn