/*
Script Name: QS Magazine Repack
File: QS_repackMags.sqf
Author:
	
	Quiksilver
	
Last Modified:

	31/08/2016 A3 1.62 by Quiksilver

Description:

	Repack Magazines
	
Example:

	player call QS_fnc_clientRepackMagazines;
	
Default Controls:

	[L.Ctrl]+[Reload]
__________________________________________________________*/
TRUE spawn {
	if (isDedicated) exitWith {diag_log '***** Mag Repack ***** Error ***** Is dedicated server *****';};
	if (!hasInterface) exitWith {diag_log '***** Mag Repack ***** Error ***** Client has no interface *****';};
	waitUntil {
		sleep 0.1;
		(!isNull (findDisplay 46))
	};
	QS_fnc_returnArrayIndex = compileFinal "
		params ['_array','_value','_index'];
		private ['_i','_nestedArray','_currentIndex']; 
		scopeName '0';
		_i = -1;
		{
			if (!(_index isEqualTo -1)) then {
				if ((_x select _index) isEqualTo _value) then {
					_i = _forEachIndex;
					breakTo '0';
				}; 
			} else {
				_currentIndex = _forEachIndex; 
				_nestedArray = _x;
				{
					if (_x isEqualTo _value) then {
						_i = _currentIndex; 
						breakTo '0'; 
					}; 
				} forEach _nestedArray;
			}; 
		} forEach _array;
		_i;
	";
	QS_fnc_repackMags = compileFinal "
		private [
			'_unit','_data1','_data2','_i','_magazineClass','_magazineAmmoCount','_magazineAmmoCapacity',
			'_totalAmmoCountForMagazine','_magazineCountArray','_index','_addMagazineArray','_magazineAmmoCountTotal',
			'_magazineAmmoCapacity_moving','_currentMagIndex','_magazineTypes','_currentMagazines','_currentWeapon',
			'_canSuspend'
		];
		_unit = _this;
		if (!(_unit isEqualType objNull)) exitWith {};
		if (isNull _unit) exitWith {};
		if (!(_unit isKindOf 'Man')) exitWith {};
		if (!local _unit) exitWith {};
		if (underwater _unit) exitWith {};
		if (captive _unit) exitWith {};
		if ((lifeState _unit) in ['DEAD','DEAD-RESPAWN','DEAD-SWITCHING','INCAPACITATED']) exitWith {};
		if (!isNil {_unit getVariable 'QS_unit_repackingMagazines'}) exitWith {};
		_unit setVariable ['QS_unit_repackingMagazines',TRUE,FALSE];
		_canSuspend = canSuspend;
		_currentWeapon = currentWeapon _unit;
		if (isNull (objectParent _unit)) then {
			if ((stance _unit) in ['STAND','CROUCH']) then {
				if (_currentWeapon isEqualTo '') then {
					_unit playMoveNow 'ainvpknlmstpslaywnondnon_medic';
				} else {
					if (_currentWeapon isEqualTo (primaryWeapon _unit)) then {
						_unit playMoveNow 'ainvpknlmstpslaywrfldnon_medic';
					} else {
						if (_currentWeapon isEqualTo (handgunWeapon _unit)) then {
							_unit playMoveNow 'ainvpknlmstpslaywpstdnon_medic';
						} else {
							if (_currentWeapon isEqualTo (secondaryWeapon _unit)) then {
								_unit playMoveNow 'ainvpknlmstpslaywnondnon_medic';
							};
						};
					}
				};
			} else {
				if ((stance _unit) isEqualTo 'PRONE') then {
					if (_currentWeapon isEqualTo '') then {
						_unit playMoveNow 'ainvppnemstpslaywnondnon_medic';
					} else {
						if (_currentWeapon isEqualTo (primaryWeapon _unit)) then {
							_unit playMoveNow 'ainvppnemstpslaywrfldnon_medic';
						} else {
							if (_currentWeapon isEqualTo (handgunWeapon _unit)) then {
								_unit playMoveNow 'ainvppnemstpslaywpstdnon_medic';
							};
						}
					};
				};
			};
		};
		_magazinesAmmoFull = magazinesAmmoFull _unit;
		_magazineTypes = [];
		_data1 = [];
		{
			if ((_x select 3) in [-1,1,2]) then {
				_data1 pushBack _x;
			};
		} forEach _magazinesAmmoFull;
		_data2 = [];
		if (_data1 isEqualTo []) exitWith {_unit setVariable ['QS_unit_repackingMagazines',nil,FALSE];};
		{
			_magazineClass = _x select 0;
			_magazineAmmoCount = _x select 1;
			_magazineAmmoCapacity = getNumber (configFile >> 'CfgMagazines' >> _magazineClass >> 'count');
			if (_magazineAmmoCapacity > 3) then {	
				comment 'Weeds out 3GL underbarrel magazines such as 3Rnd_UGL_FlareGreen_F';
				_magazineTypes pushBackUnique _magazineClass;
				if (!(_data2 isEqualTo [])) then {
					_i = [_data2,_magazineClass,0] call (missionNamespace getVariable 'QS_fnc_returnArrayIndex');
					if (_i isEqualTo -1) then {
						_data2 pushBack [_magazineClass,_magazineAmmoCapacity,[_magazineAmmoCount]];
					} else {
						((_data2 select _i) select 2) pushBack _magazineAmmoCount;
					};
				} else {
					_data2 pushBack [_magazineClass,_magazineAmmoCapacity,[_magazineAmmoCount]];
				};
			};
		} forEach _data1;
		if (_data2 isEqualTo []) exitWith {_unit setVariable ['QS_unit_repackingMagazines',nil,FALSE];};
		{
			_magazineClass = _x select 0;
			_magazineAmmoCapacity = _x select 1;
			_magazineCountArray = _x select 2;
			_totalAmmoCountForMagazine = 0;
			for '_index' from 0 to ((count _magazineCountArray) - 1) step 1 do {
				_totalAmmoCountForMagazine = _totalAmmoCountForMagazine + (_magazineCountArray select _index);
			};
			(_data2 select _forEachIndex) set [2,_totalAmmoCountForMagazine];
			(_data2 select _forEachIndex) pushBack (ceil(_totalAmmoCountForMagazine / _magazineAmmoCapacity));
		} forEach _data2;
		if (_data2 isEqualTo []) exitWith {_unit setVariable ['QS_unit_repackingMagazines',nil,FALSE];};
		_addMagazineArray = [];
		{
			_magazineClass = _x select 0;
			_magazineAmmoCapacity = _x select 1;
			_magazineAmmoCountTotal = _x select 2;
			_magazineAmmoCapacity_moving = 0;
			_currentMagIndex = _addMagazineArray pushBack [_magazineClass,_magazineAmmoCapacity_moving];
			for '_x' from 0 to (_magazineAmmoCountTotal - 1) step 1 do {
				_magazineAmmoCapacity_moving = _magazineAmmoCapacity_moving + 1;
				_addMagazineArray set [_currentMagIndex,[_magazineClass,_magazineAmmoCapacity_moving]];
				if (_magazineAmmoCapacity_moving isEqualTo _magazineAmmoCapacity) then {
					_magazineAmmoCapacity_moving = 0;
					_currentMagIndex = _addMagazineArray pushBack [_magazineClass,_magazineAmmoCapacity_moving];
				};
			};
		} forEach _data2;
		if (!((primaryWeapon _unit) isEqualTo '')) then {
			_unit removePrimaryWeaponItem ((primaryWeaponMagazine _unit) select 0);
		};
		if (!((handgunWeapon _unit) isEqualTo '')) then {
			_unit removeHandgunItem ((handgunMagazine _unit) select 0);
		};
		_currentMagazines = magazines _unit;
		if (!(_currentMagazines isEqualTo [])) then {
			{
				if (_x in _magazineTypes) then {
					_unit removeMagazine _x;
				};
			} count _currentMagazines;
		};
		if (_addMagazineArray isEqualTo []) exitWith {_unit setVariable ['QS_unit_repackingMagazines',nil,FALSE];};
		{
			if ((_x select 1) > 0) then {
				_unit addMagazine _x;
			};
			if (_canSuspend) then {
				sleep 0.1;
			};
		} count _addMagazineArray;
		if (_canSuspend) then {
			sleep 2;
			_unit setVariable ['QS_unit_repackingMagazines',nil,FALSE];
			if (!isPlayer _unit) then {
				reload _unit;
			};	
		} else {
			_unit spawn {
				sleep 2;
				_this setVariable ['QS_unit_repackingMagazines',nil,FALSE];
				if (!isPlayer _unit) then {
					reload _unit;
				};
			};
		};
	";
	QS_uiEvent_magRepack = (findDisplay 46) displayAddEventHandler [
		'KeyDown',
		{
			_k = _this select 1;
			private _c = FALSE;
			if (_k in (actionKeys 'ReloadMagazine')) then {
				if (_this select 3) then {
					player spawn (missionNamespace getVariable ['QS_fnc_repackMags',{}]);
					_c = TRUE;
				};
			};
			_c;
		}
	];
};