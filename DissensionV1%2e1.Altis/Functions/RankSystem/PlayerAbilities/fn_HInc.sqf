params ["_target", "_ammo", "_vehicle", "_instigator"];




if (_target getVariable ["DGN_INCCANTALK",false]) then
{
	_target setVariable ["DGN_INCCANTALK",false];
	_target spawn {sleep 15;_this setVariable ["DGN_INCCANTALK",true];};
	private _UnitSide = _target getVariable ["DGN_UNITSIDE",resistance];	
	[[_UnitSide],2000,(getpos _target),(selectRandom ["Sup_CASENEMYMISSILE","Sup_CASENEMYMISSILE2","Sup_CASENEMYMISSILE3"])] remoteExecCall ["DIS_fnc_PlaySoundNear",0]; //ENROUTE	
};