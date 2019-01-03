params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];



if (_unit getVariable ["DGN_FIREDCANTALK",false]) then
{
	_Unit setVariable ["DGN_FIREDCANTALK",false];
	private _UnitSide = _unit getVariable ["DGN_UNITSIDE",resistance];
	_Unit spawn {sleep 60;_this setVariable ["DGN_FIREDCANTALK",true];};
	private _VL = selectRandom ["Sup_CASENEMY1","Sup_CASENEMY2","Sup_CASENEMY3","Sup_CASENEMY4"];
	[[_UnitSide],2000,(getpos _unit),_VL] remoteExecCall ["DIS_fnc_PlaySoundNear",0];
};