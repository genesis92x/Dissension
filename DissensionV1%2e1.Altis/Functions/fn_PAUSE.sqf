//Function for pausing the game
_Pause = "DISPAUSE" call BIS_fnc_getParamValue;
if (_Pause isEqualTo 0) exitWith {};
DIS_PAUSECON = true;
DIS_DISABLED = false;

waitUntil
{
	private _P = allPlayers - entities "HeadlessClient_F";
	if (count _P < 1) then
	{
		DIS_DISABLED = true;
		{
			if !(isPlayer _x) then
			{
				_x enableSimulationGlobal false;
				(vehicle _x) enableSimulationGlobal false;
			};
		} foreach allunits;
	}
	else
	{
		if (DIS_DISABLED) then
		{
			{
				if !(isPlayer _x) then
				{
					_x enableSimulationGlobal true;
					(vehicle _x) enableSimulationGlobal true;
				};
			} foreach allunits;		
			DIS_DISABLED = false;	
		};	
	};

	sleep 5;
	!(DIS_PAUSECON)
};





/*
while {DIS_PAUSECON} do
{
	private _P = allPlayers - entities "HeadlessClient_F";
	if (count _P < 1) then
	{
		DIS_DISABLED = true;
		{
			if !(isPlayer _x) then
			{
				_x enableSimulationGlobal false;
				(vehicle _x) enableSimulationGlobal false;
			};
		} foreach allunits;
	}
	else
	{
		if (DIS_DISABLED) then
		{
			{
				if !(isPlayer _x) then
				{
					_x enableSimulationGlobal true;
					(vehicle _x) enableSimulationGlobal true;
				};
			} foreach allunits;		
			DIS_DISABLED = false;	
		};	
	};

	sleep 5;
};


