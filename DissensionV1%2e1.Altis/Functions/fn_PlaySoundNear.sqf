/*
	Author: Genesis

	Description:
		Will play a sound 'globally' for all players within a certain side and distance from a point.

	Parameter(s):
		0: side array [west,east,resistance]
		1: distance2D 200
		2: Center Point (getpos unit)
		3: Sound file to player "WEEEEESOUNDFILE"
		
	Returns:
		NOTHING
	
	Example1: [[west,east,resistance],200,(getpos _unit)] call DIS_fnc_PlaySoundNear;
*/
params ["_Sides","_Distance","_Pos","_Soundfile"];

if (hasInterface) then
{
	if (playerSide in _Sides && {((getpos player) distance2D _Pos < _Distance)}) then
	{
		playSound _SoundFile;	
	};	
};




