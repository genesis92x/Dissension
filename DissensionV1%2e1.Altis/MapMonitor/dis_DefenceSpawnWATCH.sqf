//This function will automatically monitor the world and spawn troops appropriately to combat.
//This function monitors towns and grids.
DIS_DefenceSpawnGo = false;
sleep 30;
DIS_DefenceSpawnGo = true;
sleep 30;
waitUntil
{
	sleep 15;
	if !(DIS_DISABLED) then
	{
		[] call DIS_fnc_TownCheck;
	};
	!(DIS_DefenceSpawnGo)
};