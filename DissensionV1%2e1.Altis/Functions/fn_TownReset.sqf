{
	private _T = _x getVariable ["DIS_BuildingSpwn",0];
	if !(isNil "_T") then
	{
		_x setVariable ["DIS_BuildingSpwn",5];
	};
} foreach _this;