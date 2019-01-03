//A function that will loop every 10 minutes. The function will save the mission state.

while {true} do
{
	sleep 300;
	[] call DIS_fnc_SaveSVR;
};