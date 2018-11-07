//dis_VehicleChanged
_Line1 = _this select 0; //Dialog Control Number
_index = _this select 1; //Index number
_classname = lbData [1500,_index];

_picture = getText(configfile/"CfgVehicles"/_classname/"Icon");

_HasIcon = [".paa",_picture] call BIS_fnc_inString;
if (_HasIcon) then
{
	if !(isNil "_picture") then
	{
		ctrlSetText [1200, format ["%1",_picture]];
	};
}
else
{
	if !(isNil "_picture") then
	{
		ctrlSetText [1200, format ["%1",_picture]];
	};
};

_CashAmount = 0;
if (_classname in CfgCarsArray) then {_CashAmount = 300;};
if (_classname in CfgLightArmorsArray) then {_CashAmount = 500;};
if (_classname in CfgHeavyArmorsArray) then {_CashAmount = 1000;};
if (_classname in CfgHelicoptersArray) then {_CashAmount = 700;};
if (_classname in CfgPlanesArray) then {_CashAmount = 1000;};
if (_classname in CfgBoatsArray) then {_CashAmount = 250;};
if (_classname in CfgUGVArray) then {_CashAmount = 325;};
if (_classname in CfgUAVArray) then {_CashAmount = 325;};

private _armor = getNumber(configfile/"CfgVehicles"/_classname/"armor");
private _armorStructural = getNumber(configfile/"CfgVehicles"/_classname/"armorStructural");
private _transport = getNumber(configfile/"CfgVehicles"/_classname/"transportSoldier");
private _weapons = (configfile/"CfgVehicles"/_classname/"Turrets") call BIS_fnc_getCfgSubClasses;

if !(isNil "_armor") then {_CashAmount = _CashAmount + _armor;}; //m113 = 200
if !(isNil "_armorStructural") then {_CashAmount = _CashAmount + _armorStructural;}; //m113 = 350
if !(isNil "_transport") then {_CashAmount = _CashAmount + (_transport * 10);}; //m113 = 9
if !(isNil "_weapons") then 
{
	{
		private _Total = count(getArray(configfile/"CfgVehicles"/_classname/"Turrets"/_x/"weapons"));
		_CashAmount = _CashAmount + (150 * _Total);
		true;
	} count _weapons;
};


((findDisplay (3016)) displayCtrl 1001) ctrlSetText (format ["Cost: %1",_CashAmount]);
if ((DIS_PCASHNUM - _CashAmount) < 0) then {((findDisplay (3016)) displayCtrl 1001) ctrlSetTextColor [0.99,0.13,0.09,1];} else {((findDisplay (3016)) displayCtrl 1001) ctrlSetTextColor [0,0.76,0,1];};
