//Opening the dialog to recruit troops and stuff.
createDialog "Dis_RecruitUnits";

//Lets figure out the players side!
private _WestRun = false;
private _UnitList = E_BarrackU + E_AdvU;
if (PlayerSide isEqualTo West) then
{
	_WestRun = true;
	_UnitList = W_BarrackU + W_AdvU;
};


//We need to populate the listbox with units to use...
{
	private _Classname = _x select 0;
	private _Cost = ((_x select 1) select 3);
	private _DisplayName = getText (configfile >> "CfgVehicles" >> _ClassName >> "displayName");	
	private _Weapons = getArray (configfile >> "CfgVehicles" >> _ClassName >> "weapons");	
	private _index = lbAdd [1500,_DisplayName];
	_NewInformation = [_DisplayName,_Classname,_Cost,_Weapons];	
	private _RealData = lbSetData [1500,_index,format ["%1",_NewInformation]];
} foreach _UnitList;



private _display = (findDisplay 3017) displayCtrl 1500;
_display ctrlSetEventHandler ["LBSelChanged","[_this select 0,_this select 1] call DIS_fnc_UnitSel"];