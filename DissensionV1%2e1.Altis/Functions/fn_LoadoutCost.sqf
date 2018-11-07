//Function for calculating costs for a players gear.
private _Violation = false;
private _CashAmount = 0;
private _Mod = "Mod" call BIS_fnc_getParamValue;	
{

		if (_Mod isEqualTo 2 || _Mod isEqualTo 3) then 
		{
			//!(_author isEqualTo "LODU & tierprot") || !(_author isEqualTo "tierprot") || !(_author isEqualTo "LODU & El Tyranos") || !(_author isEqualTo "LODU & Lennard") || !(_author isEqualTo "AWAR") || !(_author isEqualTo "Lennard") || !(_author isEqualTo "Reyhard & Joarius")
			//_author = getText(configfile/"CfgWeapons"/_x/"author");
			if (_x in CfgWeaponsArray || {_x in CfgHeavyArray} || {_x in CfgPistolArray} || {_x in CfgLauncherArray}) then
			{
				_VIO = ["LIB",str _x] call BIS_fnc_inString;
				_VIO2 = ["FOW",str _x] call BIS_fnc_inString;
				if (!(_VIO) && !(_VIO2)) then {_Violation = true;player removeWeapon _x;};
			};
			if (_x in CfgHelmetsArray) then
			{
				_VIO = ["LIB",str _x] call BIS_fnc_inString;
				_VIO2 = ["FOW",str _x] call BIS_fnc_inString;
				if (!(_VIO) && !(_VIO2)) then {_Violation = true;removeHeadgear player;};
			};
			if (_x in CfgVestsArray) then
			{
				_VIO = ["LIB",str _x] call BIS_fnc_inString;
				_VIO2 = ["FOW",str _x] call BIS_fnc_inString;
				if (!(_VIO) && !(_VIO2)) then {_Violation = true;removeVest player;};						
			};
			if (_x in CfgRucksArray) then
			{	
				_VIO = ["LIB",str _x] call BIS_fnc_inString;	
				_VIO2 = ["FOW",str _x] call BIS_fnc_inString;						
				if (!(_VIO) && !(_VIO2)) then {_Violation = true;removeBackpack player;};					
			};	
			_uniform = uniform player;
			if !(_uniform isEqualTo "") then
			{
				_UVIO = ["LIB",str _uniform] call BIS_fnc_inString;	
				_VIO2 = ["FOW",str _uniform] call BIS_fnc_inString;				
				if (!(_UVIO) && !(_VIO2)) then {_Violation = true;removeUniform player;};	
			};

		};
		
		if (_Mod isEqualTo 4) then 
		{
			if (_x in CfgWeaponsArray || {_x in CfgHeavyArray} || {_x in CfgPistolArray} || {_x in CfgLauncherArray}) then
			{
				_VIO = ["UNS",str _x] call BIS_fnc_inString;
				if !(_VIO) then {_Violation = true;player removeWeapon _x;};
			};
			if (_x in CfgHelmetsArray) then
			{
				_VIO = ["UNS",str _x] call BIS_fnc_inString;
				if !(_VIO) then {_Violation = true;removeHeadgear player;};
			};
			if (_x in CfgVestsArray) then
			{
				_VIO = ["UNS",str _x] call BIS_fnc_inString;
				if !(_VIO) then {_Violation = true;removeVest player;};						
			};
			if (_x in CfgRucksArray) then
			{	
				_VIO = ["UNS",str _x] call BIS_fnc_inString;					
				if !(_VIO) then {_Violation = true;removeBackpack player;};					
			};	
			if (_x in CfgUniformsArray) then
			{
				_VIO = ["UNS",str _x] call BIS_fnc_inString;
				if !(_VIO) then {_Violation = true;removeUniform player;};	
			};			
		};
		
		if (_x in CfgWeaponsArray) then {_CashAmount = _CashAmount + 100;};
		if (_x in CfgHeavyArray) then {_CashAmount = _CashAmount + 200;};
		if (_x in CfgAttachmentsArray) then {_CashAmount = _CashAmount + 25;};
		if (_x in CfgEquipmentArray) then {_CashAmount = _CashAmount + 10;};
		if (_x in CfgVestsArray) then {_CashAmount = _CashAmount + 50;};
		if (_x in CfgHelmetsArray) then {_CashAmount = _CashAmount + 50;};
		if (_x in CfgPistolArray) then {_CashAmount = _CashAmount + 70;};
		if (_x in CfgLauncherArray) then {_CashAmount = _CashAmount + 200;};
		if (_x in CfgRucksArray) then {_CashAmount = _CashAmount + (getNumber(configfile >> "CfgVehicles" >> _x >> "maximumLoad"));};
		if (_x in CfgLightMagazine) then {_CashAmount = _CashAmount + 10;};
		if (_x in CfgPistolMagazine) then {_CashAmount = _CashAmount + 5;};
		if (_x in CfgHeavyMagazine) then {_CashAmount = _CashAmount + 15;};
		if (_x in CfgLauncherMagazine) then {_CashAmount = _CashAmount + 25;};
		if (_x in CfgFlareMagazine) then {_CashAmount = _CashAmount + 5;};
		if (_x in CfgGrenadeMagazine) then {_CashAmount = _CashAmount + 10;};
		if (_x in CfgUnknownMagazine) then {_CashAmount = _CashAmount + 5;};
} foreach _this;

private _rtn = [_CashAmount,_Violation];
_rtn