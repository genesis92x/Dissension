//Function for rearming a vehicle completely.
params ["_caller","_Crate"];
private _RearmA = _Crate getVariable ["DIS_RearmP",0];
_RearmA = _RearmA - 1;
_Crate setVariable ["DIS_RearmP",_RearmA,true];
if (_RearmA < 0) exitwith {["FARP is out of resources and will be removed soon.",'#FFFFFF'] call Dis_MessageFramework;};
DIS_AbilityCoolDown = true;[] spawn {sleep 120;DIS_AbilityCoolDown = false;};

private _object = (vehicle _caller);
if (_object isKindOf "Man") exitwith {Hint "Can't run on an infantry!";};
private _type = typeOf _object;

private _ReloadTime = 5;
_object setFuel 0;
_object setVehicleAmmo 0;

_object vehicleChat format ["Servicing %1... Please stand by...", _type];

_magazines = getArray(configFile >> "CfgVehicles" >> _type >> "magazines");

if (count _magazines > 0) then {
	_removed = [];
	{
		if (!(_x in _removed)) then {
			_object removeMagazines _x;
			_removed = _removed + [_x];
		};
	} forEach _magazines;
	{
		_object vehicleChat format ["Reloading %1", _x];
		sleep _ReloadTime;
		_object addMagazine _x;
	} forEach _magazines;
};

_count = count (configFile >> "CfgVehicles" >> _type >> "Turrets");

if (_count > 0) then {
	for "_i" from 0 to (_count - 1) do {
		_config = (configFile >> "CfgVehicles" >> _type >> "Turrets") select _i;
		_magazines = getArray(_config >> "magazines");
		_removed = [];
		{
			if (!(_x in _removed)) then {
				_object removeMagazines _x;
				_removed = _removed + [_x];
			};
		} forEach _magazines;
		{
			_object vehicleChat format ["Reloading %1", _x];
			sleep _ReloadTime;
			_object addMagazine _x;
			sleep _ReloadTime;
		} forEach _magazines;
		_count_other = count (_config >> "Turrets");
		if (_count_other > 0) then {
			for "_i" from 0 to (_count_other - 1) do {
				_config2 = (_config >> "Turrets") select _i;
				_magazines = getArray(_config2 >> "magazines");
				_removed = [];
				{
					if (!(_x in _removed)) then {
						_object removeMagazines _x;
						_removed = _removed + [_x];
					};
				} forEach _magazines;
				{
					_object vehicleChat format ["Reloading %1", _x]; 
					sleep _ReloadTime;
					_object addMagazine _x;
					sleep _ReloadTime;
				} forEach _magazines;
			};
		};
	};
};
_object setVehicleAmmo 1;	// Reload turrets / drivers magazine

sleep _ReloadTime;
_object vehicleChat "Repairing...";
_object setDamage 0;
sleep _ReloadTime;
_object vehicleChat "Refueling...";
_object setFuel 1;
sleep _ReloadTime;
_object vehicleChat format ["%1 is ready...", _type];
if (_RearmA < 1) exitWith {deleteVehicle _Crate;};


