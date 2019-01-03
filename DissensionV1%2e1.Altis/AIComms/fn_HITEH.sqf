params ["_unit", "_source", "_damage", "_instigator"];
if (((_unit getVariable ["DIS_TIMESAID",time]) + 3) > time) then
{
_unit setVariable ["DIS_TIMESAID",time];
private _UnitG = group _Unit;

if ((side _UnitG) isEqualTo (side _Source)) exitWith
{
	private _FriendlyF = [];
	switch (side _UnitG) do {
			case west: {_FriendlyF = DIS_Comms_BluforFriendlyF;};
			case east: {_FriendlyF = DIS_Comms_OpforFriendlyF;};
			case resistance: {_FriendlyF = DIS_Comms_ResistanceFriendlyF;};
	};
	[_unit,(selectRandom _FriendlyF)] remoteExec ["PlaySoundEverywhereSay3D",0];	
};

private _VoiceSel = [];
private _VoiceResp = [];
switch (side _UnitG) do {
		case west: {_VoiceSel = DIS_Comms_BluforWounded;_VoiceResp = DIS_Comms_BluforEDown;};
		case east: {_VoiceSel = DIS_Comms_OpforWounded;_VoiceResp = DIS_Comms_OpforEDown;};
		case resistance: {_VoiceSel = DIS_Comms_ResistanceWounded;_VoiceResp = DIS_Comms_ResistanceEDown;};
};	

[_unit,(selectRandom _VoiceSel)] remoteExec ["PlaySoundEverywhereSay3D",0];

if (_source isKindOf "MAN" && {!(isPlayer _source)}) then
{
	[_source,(selectRandom _VoiceResp)] remoteExec ["PlaySoundEverywhereSay3D",0];
};
};