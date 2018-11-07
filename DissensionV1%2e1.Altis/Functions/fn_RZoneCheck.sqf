//Function to constantly check if the player needs to spawn in the zone markers for a point.
DIS_ZoneSpawn = false;

waitUntil {!(isNil "CompleteTaskResourceArray")};
private _MarkerArray = [];
{
	_MarkerArray pushback (_x select 4);
} foreach CompleteTaskResourceArray;

while {alive player} do
{

	private _NMark = [_MarkerArray,player,true] call dis_closestobj;
	private _NPos = getMarkerPos _NMark;
	private _NSize = (getMarkerSize _NMark) select 0;
	if (!(DIS_ZoneSpawn) && _NPos distance2D player < (_NSize + 500)) then
	{
		[_NPos,_NSize] spawn DIS_fnc_RZone;
	};


	sleep 10;
};