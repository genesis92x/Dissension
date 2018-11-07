//A function that will loop every 10 minutes. The function will save the mission state.

waitUntil
{
	uisleep 600;
	[] call DIS_fnc_SaveSVR;
	false
};