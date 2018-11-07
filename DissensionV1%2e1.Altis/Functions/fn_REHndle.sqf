//This function will actually charge the player and do the action required.

params ["_ActionP","_Request"];


private _VehR = (vehicle player);
if (_VehR isEqualTo player) exitWith {["You need to be in a vehicle.",'#FFFFFF'] call Dis_MessageFramework;};

if (_Request isEqualTo "Repair") exitWith 
{
	private _pdm = getDammage _VehR;
	if (_pdm isEqualTo 0) then {_pdm = 0.1};
	private _cst = (floor (250/_pdm));
	if (_cst > 600) then {_cst = 600;};
	if (DIS_PCASHNUM - _cst < 0) exitWith {["You lack funds for repair!",'#FFFFFF'] call Dis_MessageFramework;};
	DIS_PCASHNUM = DIS_PCASHNUM - _cst;
	_VEhR setDamage 0;
	[format ["Completed. You have been charged %1$",_cst]] call Dis_MessageFramework;
};

if (_Request isEqualTo "Ammo") exitWith
{
	private _cst = 300;
	
	if (DIS_PCASHNUM - _cst < 0) exitWith {["You lack funds for rearm!",'#FFFFFF'] call Dis_MessageFramework;};
	DIS_PCASHNUM = DIS_PCASHNUM - _cst;

	_VehR setVehicleAmmo 0;
	private _type = (typeof _VehR);
	private _magazines = getArray(configFile >> "CfgVehicles" >> _type >> "magazines");
	
	if (count _magazines > 0) then 
	{
		_removed = [];
		{
			if (!(_x in _removed)) then {
				_VehR removeMagazines _x;
				_removed pushback _x;
			};
		} forEach _magazines;
		{
			_VehR addMagazine _x;
		} forEach _magazines;
	};
	
	private _count = count (configFile >> "CfgVehicles" >> _type >> "Turrets");
	
	if (_count > 0) then 
	{
		for "_i" from 0 to (_count - 1) do {
			_config = (configFile >> "CfgVehicles" >> _type >> "Turrets") select _i;
			_magazines = getArray(_config >> "magazines");
			_removed = [];
			{
				if (!(_x in _removed)) then {
					_VehR removeMagazines _x;
					_removed pushback _x;
				};
			} forEach _magazines;
			{
				_VehR addMagazine _x;
			} forEach _magazines;
			_count_other = count (_config >> "Turrets");
			if (_count_other > 0) then {
				for "_i" from 0 to (_count_other - 1) do {
					_config2 = (_config >> "Turrets") select _i;
					_magazines = getArray(_config2 >> "magazines");
					_removed = [];
					{
						if (!(_x in _removed)) then {
							_VehR removeMagazines _x;
							_removed pushback _x;
						};
					} forEach _magazines;
					{
						_VehR addMagazine _x;
					} forEach _magazines;
				};
			};
		};
	};
	_VehR setVehicleAmmo 1;
	[format ["Completed. You have been charged %1$",_cst]] call Dis_MessageFramework;

};

if (_Request isEqualTo "Fuel") exitWith 
{
	private _pdm = fuel _VehR;
	private _cst = (floor (250*_pdm));
	
	if (DIS_PCASHNUM - _cst < 0) exitWith {["You lack funds for refuel!",'#FFFFFF'] call Dis_MessageFramework;};
	DIS_PCASHNUM = DIS_PCASHNUM - _cst;
	_VEhR setFuel 1;
	[format ["Completed. You have been charged %1$",_cst],'#FFFFFF'] call Dis_MessageFramework;
	
};

if (_Request isEqualTo "Sold") exitWith 
{
	if (_VehR isEqualTo player) exitWith {["You need to be in a vehicle.",'#FFFFFF'] call Dis_MessageFramework;};
	private _Driver = driver _VehR;
	if !(_Driver isEqualTo player) exitWith {["YOU MUST BE THE DRIVER TO SELL A VEHICLE.",'#FFFFFF'] call Dis_MessageFramework;};
	private _Classname = (typeof (vehicle player));
	private _rtn = 0;
	if (_Classname in CfgCarsArray) then {_rtn = _rtn + 500;};
	if (_Classname in CfgLightArmorsArray) then {_rtn = _rtn + 700;};
	if (_Classname in CfgHeavyArmorsArray) then {_rtn = _rtn + 1500;};
	if (_Classname in CfgHelicoptersArray) then {_rtn = _rtn + 2000;};
	if (_Classname in CfgPlanesArray) then {_rtn = _rtn + 2500;};
	if (_Classname in CfgBoatsArray) then {_rtn = _rtn + 250;};
	if (_rtn isEqualTo 0) then {_rtn = 250};

	private _armor = getNumber(configfile >> "CfgVehicles" >> _classname >> "armor");
	private _armorStructural = getNumber(configfile >> "CfgVehicles" >> _classname >> "armorStructural");
	private _transport = [_classname,true] call BIS_fnc_crewCount;
	private _weapons = [];
	if !(isNil "_armor") then {_rtn = _rtn + (_armor/2);}; //m113 = 200
	if !(isNil "_armorStructural") then {_rtn = _rtn + (_armorStructural/2);}; //m113 = 350
	if !(isNil "_transport") then {_rtn = _rtn + (_transport * 15);}; //m113 = 9
	
	DIS_PCASHNUM = DIS_PCASHNUM + _rtn;
	[format ["Completed. You have received %1$",_rtn],'#FFFFFF'] call Dis_MessageFramework;
	playsound "Sell";
	private _VehP = (getpos _VehR);
	player setpos _VehP;
	deleteVehicle _VehR;
	private _Debr = ["Land_Mil_WallBig_debris_F","Land_HistoricalPlaneDebris_01_F","Land_HistoricalPlaneDebris_02_F","Land_HistoricalPlaneDebris_03_F","Land_HistoricalPlaneDebris_04_F"];
	private _A = [];
	{
		private _P = [_VehP,1,1] call dis_randompos;
		private _object = createSimpleObject [_x,_P]; 
		_object setdir (random 360);
		_object setpos (getpos _object);
		_A pushback _Object;
		true;
	} count _Debr;
	_A spawn {sleep 30;{deleteVehicle _x;true} count _this;};
};

if (_Request isEqualTo "Sell All Cargo") exitWith 
{
	if (_VehR isEqualTo player) exitWith {["You need to be in a vehicle.",'#FFFFFF'] call Dis_MessageFramework;};
	private _Driver = driver _VehR;
	if !(_Driver isEqualTo player) exitWith {["YOU MUST BE THE DRIVER TO EMPTY A VEHICLE.",'#FFFFFF'] call Dis_MessageFramework;};
	
	_WeaponCargo = weaponcargo _VehR;
	_MagazineCargo = magazinecargo _VehR;
	_BackpackCargo = backpackcargo _VehR;
	_ItemCargo = itemcargo _VehR;
	
	
	_WeaponAmount = count _WeaponCargo;
	_MagazineAmount = count _MagazineCargo;
	_BackpackAmount = count _BackpackCargo;
	_ItemAmount  = count _ItemCargo;
	
		{
			_BackPack = (_x select 1);
			_WC = weaponCargo _BackPack; if (isnil "_WC") then {_WC = [];};
			_MC = magazineCargo _BackPack; if (isnil "_MC") then {_MC = [];};
			_IC = itemCargo _BackPack; if (isnil "_IC") then {_IC = [];};
			
		if !(_WC isEqualTo []) then
		{
			{
				_WeaponAmount = _WeaponAmount + 1;
			} foreach _WC;	
		};
		if !(_MC isEqualTo []) then
		{					
			{
				_MagazineAmount = _MagazineAmount + 1;
			} foreach _MC;
		};
		if !(_IC isEqualTo []) then
		{
			{
				_ItemAmount = _ItemAmount + 1;
			} foreach _IC;
		};

		} foreach (everyContainer _VehR);		
	
	
	_SupplyValueWeapon = 100;
	_SupplyValueMagazine = 2;
	_SupplyValueBackpack = 20;
	_SupplyValueItem = 2;

	_NewSupplyAmountWeapons = _WeaponAmount * _SupplyValueWeapon;
	_NewSupplyAmountMagazine = _MagazineAmount * _SupplyValueMagazine;
	_NewSupplyAmountBackpack = _BackpackAmount * _SupplyValueBackpack;
	_NewSupplyAmountItem = _ItemAmount * _SupplyValueItem;
	
	
		
	_TotalSupplyGained = _NewSupplyAmountWeapons + _NewSupplyAmountMagazine + _NewSupplyAmountBackpack + _NewSupplyAmountItem;
	
	clearWeaponCargoGlobal _VehR;
	clearMagazineCargoGlobal _VehR;
	clearBackpackCargoGlobal _VehR;
	clearItemCargoGlobal _VehR;	
	DIS_PCASHNUM = DIS_PCASHNUM + _TotalSupplyGained;
	playsound "Sell";
	[format ["Completed. You have received %1$",_TotalSupplyGained],'#FFFFFF'] call Dis_MessageFramework;
};
