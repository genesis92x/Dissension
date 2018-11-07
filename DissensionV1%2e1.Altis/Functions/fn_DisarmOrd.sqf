fnc_mineDisarmMessage = {
private [ "_id", "_type", "_unit" ];
_id = _this select 0;
_type = _this select 1;
_unit = _this select 2;

hint "Mine Disarmed: Gained 50$ and 25XP.";

DIS_PCASHNUM = DIS_PCASHNUM + 50;
DIS_Experience = DIS_Experience + 25;
playsound "readoutClick";
[
	[player],
	{
			params ["_caller"];
			_caller addscore 10;
	}

] remoteExec ["bis_fnc_Spawn",2]; 

};



player addEventHandler [ "AnimChanged", {

_thread = _this spawn {
	_unit = _this select 0;
	_animState = _this select 1;

	if ( [ "putdown", _animState ] call BIS_fnc_inString ) then {
		_mines = ( _unit nearObjects [ "TimeBombCore", 3.5 ] ) + ( _unit nearObjects [ "MineBase", 3.5 ] );
		_mineInfo = [];
		{
			_gwh = nearestObjects [ _x, [ "GroundWeaponHolder" ], 1 ];
			_mineInfo pushBack [ typeOf _x, str _x, getPosATL _x, _gwh ];
		}forEach _mines;

		waitUntil { !( _animState isEqualTo ( animationState _unit ) ) };
		sleep 0.5;
		_Nmines = ( _unit nearObjects [ "TimeBombCore", 3.5 ] ) + ( _unit nearObjects [ "MineBase", 3.5 ] );
		
		private _FMines = _Nmines - _mines;
		{
			_x setVariable ["DIS_PMINE",player,true];
		} foreach _FMines;
		
		{
			if (_x getVariable ["DIS_PMINE",objNull] isEqualTo player) then
			{
				_mines deleteAt _forEachIndex;
			};		
		} foreach _mines;
		
		_found = false;
		{
			if ( isNull _x ) then {
				_mineType = ( _mineInfo select _forEachIndex ) select 0;
				_mineID = ( _mineInfo select _forEachIndex ) select 1;
				_minePos = ( _mineInfo select _forEachIndex ) select 2;
				_oldgwh = ( _mineInfo select _forEachIndex ) select 3;

				_magClass = getText ( configFile >> "CfgAmmo" >> _mineType >> "defaultMagazine" );
				_gwh = nearestObjects [ _minePos, [ "GroundWeaponHolder" ], 1 ];
				{
					if ( !( _x in _oldgwh ) && { _magClass in ( magazineCargo _x ) } ) exitWith {
						[ _mineID, _mineType, _unit ] call fnc_mineDisarmMessage;
						deleteVehicle _x;
						_found = true;
					};
				}forEach _gwh; 
			};
			if ( _found ) exitWith {};
		}forEach _mines;

	};		
};
}];