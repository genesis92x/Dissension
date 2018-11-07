params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];

if (random 100 < 15) then
{
	private _VoiceSel = [];
	switch (side _unit) do 
	{
			case west: {_VoiceSel = DIS_Comms_BluforRandom;};
			case east: {_VoiceSel = DIS_Comms_OpforRandom;};
			case resistance: {_VoiceSel = DIS_Comms_ResistanceRandom;};
	};	
	
	[_unit,(selectRandom _VoiceSel)] remoteExec ["PlaySoundEverywhereSay3D",0];
};