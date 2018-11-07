//Function for when AI reloads.
params ["_unit", "_weapon", "_muzzle", "_newMagazine", "_oldMagazine"];

private _VoiceSel = [];
switch (side _unit) do 
{
		case west: {_VoiceSel = DIS_Comms_BluforReloading;};
		case east: {_VoiceSel = DIS_Comms_OpforReloading;};
		case resistance: {_VoiceSel = DIS_Comms_ResistanceReloading;};
};	

[_unit,(selectRandom _VoiceSel)] remoteExec ["PlaySoundEverywhereSay3D",0];
