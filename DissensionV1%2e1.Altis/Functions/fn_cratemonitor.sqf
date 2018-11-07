//This will loop continually to spawn crates around players.

sleep 60;

while {true} do
{
	
	//Lets spawn in 10 boxes around players just as the old boxes are starting to despawn.
	private _justPlayers = allPlayers - entities "HeadlessClient_F";		
	private _PCount = (count _JustPlayers);
	if (_PCount > 0) then
	{
		private _SpawnCount = 0;
		private _MaxSpwn = (_PCount + (_PCount/2));
		if (_MaxSpwn > 5) then {_MaxSpwn = 5};
		
		while {_SpawnCount < _MaxSpwn} do
		{
			_SpawnCount = _SpawnCount + 1;
			private _ChosenPlayer = selectRandom _justPlayers;		
			[_ChosenPlayer] spawn DIS_fnc_cratespawn;
			sleep (10 + (random 300));
		};
		sleep 1800;
	};
};

