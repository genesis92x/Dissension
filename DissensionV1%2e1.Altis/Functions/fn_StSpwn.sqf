params ["_staticlist","_PolePos","_SSide","_InfantryList","_Pole"];
private _grpStatic = createGroup _SSide;
_grpStatic setVariable ["Vcm_Disable",true];
_grpStatic setVariable ["DIS_IMPORTANT",true,true];
private _StList = [];
//Spawn Statics

{
	private _positionR = [_PolePos,250,50] call dis_randompos;
	private _SafeSpwn = [_positionR, 15, 250, 5, 0, 0.1, 0,[],[_positionR,_positionR]] call BIS_fnc_findSafePos;
	private _veh = (selectRandom _StaticList) createVehicle _SafeSpwn;
	_veh setpos _SafeSpwn;
	_veh addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
	createVehicleCrew _veh;
	{[_x] joinSilent _grpStatic;_x addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];true} count (crew _veh);
	
	_veh spawn 
	{
		sleep 15;
		while {alive _this} do
		{
			private _CE = (selectRandom (crew _this)) call dis_ClosestEnemy;
			if !(isNil "_CE") then
			{
				if (_CE distance _this > 50) then {_this setDir (_this getdir _CE);_this setpos (getpos _this);};
				if (_CE distance _this > 1200) then {{deleteVehicle _x;true} count (crew _this);deleteVehicle _this;};
			};
			sleep 10;
		};	
	};
	_StList pushback _veh;
	_StList pushback (gunner _veh);
	true
} count [1,2,3,4];



[_StList,_pole] spawn
{
	params ["_StList","_pole"];
	private _Eng = _Pole getVariable ["DIS_ENGAGED",false];
	while {_Eng} do
	{
		sleep 30;
		private _Eng = _Pole getVariable ["DIS_ENGAGED",false];
	};
	{if (alive _x) then {_x setDamage 1;};} foreach _StList;
};