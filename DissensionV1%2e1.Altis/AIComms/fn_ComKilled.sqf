params ["_unit", "_killer", "_instigator", "_useEffects"];

private _unitG = group _Unit;
private _UnitU = units _UnitG;
private _DeathPos = getpos _Unit;

_UnitU = _UnitU - [_Unit];
private _CF = [_UnitU,_DeathPos,true] call dis_closestobj;

private _VoiceSel = [];
private _VoiceResp = [];
switch (side _unitG) do 
{
		case west: {_VoiceSel = DIS_Comms_BluforFDown;};
		case east: {_VoiceSel = DIS_Comms_OpforFDown;};
		case resistance: {_VoiceSel = DIS_Comms_ResistanceFDown;};
};	

switch (side (group _killer)) do 
{
		case west: {_VoiceResp = DIS_Comms_BluforEDown;};
		case east: {_VoiceResp = DIS_Comms_OpforEDown;};
		case resistance: {_VoiceResp = DIS_Comms_ResistanceEDown;};
};	

[_CF,(selectRandom _VoiceSel)] remoteExec ["PlaySoundEverywhereSay3D",0];

if (_killer isKindOf "MAN" && {!(isPlayer _killer)}) then
{
	[_killer,(selectRandom _VoiceResp)] remoteExec ["PlaySoundEverywhereSay3D",0];
};