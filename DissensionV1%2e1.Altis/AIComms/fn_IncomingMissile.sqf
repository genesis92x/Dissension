params ["_target", "_ammo", "_vehicle", "_instigator"];

if (((_unit getVariable ["DIS_TIMESAID",time]) + 3) > time) then
{
_unit setVariable ["DIS_TIMESAID",time];
private _VoiceSel = [];
switch (side _target) do 
{
		case west: {_VoiceSel = DIS_Comms_BluforIncom;};
		case east: {_VoiceSel = DIS_Comms_OpforIncom;};
		case resistance: {_VoiceSel = DIS_Comms_ResistanceIncom;};
};	

[_target,(selectRandom _VoiceSel)] remoteExec ["PlaySoundEverywhereSay3D",0];
};