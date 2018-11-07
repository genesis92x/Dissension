params ["_PolePos","_FactoryList","_SSide","_InfantryList","_Pole"];
private _positionVEHS = [0,0,0];
private _VehList = [];
//Spawn vehicles
{
	private _list = _PolePos nearRoads 500;
	private _positionR = [_PolePos,250,50] call dis_randompos;
	private _SelectRoad = [_list,_positionR,true] call dis_closestobj;
	if (!(isNil "_SelectRoad") && {!(_SelectRoad isEqualTo [])} && {!(_SelectRoad isEqualTo [0,0,0])}) then
	{
		_positionVEHS = (getpos _SelectRoad);
	}
	else
	{
		_positionVEHS = _positionR;
	};
	private _positionVEHS = [_positionVEHS, 1, 150, 5, 0, 20, 0,[],[_positionVEHS,_positionVEHS]] call BIS_fnc_findSafePos;
	private _veh = (selectRandom _FactoryList) createVehicle _positionVEHS;	
	_veh setpos _positionVEHS;
	_veh addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
	createVehicleCrew _veh;
	private _grpVeh = createGroup _SSide;
	_grpVeh setVariable ["DIS_IMPORTANT",true,true];
	{[_x] joinsilent _grpVeh;_x addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];} forEach crew _veh;
			
	private _VehSpwn = 0;	
	private _VehSeats = fullCrew [_veh,"",true];
	{
		if ((_x select 1) isEqualTo "cargo" && _VehSpwn < 6) then  
		{
			_VehSpwn = _VehSpwn + 1;
			private _unitDO = _grpVeh createUnit [(selectRandom _InfantryList),[0,0,0], [], 25, "CAN_COLLIDE"];
			_unitDO moveInAny _veh;
			_VehList pushback _unitDO;
			[_unitDO] joinsilent _grpVeh;_unitDO addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
			if (!(DIS_MODRUN) && (_SSide isEqualTo resistance)) then {_unitDO call dis_AIUniforms;};
		};
		true
	} count _VehSeats;		
	_VehList pushback _veh;
	true;
} count [1,2];

[_VehList,_pole] spawn
{
	params ["_VehList","_pole"];
	private _Eng = _Pole getVariable ["DIS_ENGAGED",false];
	while {_Eng} do
	{
		sleep 30;
		private _Eng = _Pole getVariable ["DIS_ENGAGED",false];
	};
	{_x setDamage 1;} foreach _VehList;
};