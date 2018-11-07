//Function that will go through, every so often, and tag mines.
//Mines/Satchels will go from completely active to -> UXO -> Removed.

private _ExpTimer = 1800;
private _MineArray = ["BombCluster_02_UXO1_Ammo_F","BombCluster_02_UXO4_Ammo_F","BombCluster_02_UXO3_Ammo_F","BombCluster_02_UXO2_Ammo_F"];

_Bombs = [5000,5000] nearobjects ["timebombcore", 20000];
_Mines = [5000,5000] nearobjects ["minebase", 20000];
_Bombs append _Mines;

{
	private _Type = (typeof _x);
	if ((_x getVariable ["DIS_TPlace",time]) + _ExpTimer < time && {!(_Type in _MineArray)}) then
	{
		private _Pos = getpos _x;
		deleteVehicle _x;
		(selectRandom _MineArray) createvehicle _Pos;
	}
	else
	{
		if ((_x getVariable ["DIS_TPlace",time]) + _ExpTimer < time) then
		{
			deleteVehicle _x;
		};
	};
} foreach _Bombs;