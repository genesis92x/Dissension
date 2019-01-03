params ["_unit", "_selection", "_damage", "_hitIndex", "_hitPoint", "_shooter", "_projectile"];

if (_unit getVariable ["DGN_GOINGDOWNCANTALK",false]) then
{

	
	
	private _UnitSide = _unit getVariable ["DGN_UNITSIDE",resistance];
	if (getDammage _unit > 0.5) then
	{
		[[_UnitSide],2000,(getpos _unit),"Sup_GOINGDOWN"] remoteExecCall ["DIS_fnc_PlaySoundNear",0]; //ENROUTE	
		_unit setVariable ["DGN_GOINGDOWNCANTALK",false];
		_unit spawn {sleep 35;_this setVariable ["DGN_GOINGDOWNCANTALK",true];};		
	};
	
};
