	
	private _WestActive = [];
	private _EastActive = [];
	private _ResistanceActive = [];
	private _OpBlu = [];
	{
		if ((side (group _x)) isEqualTo WEST) then {_WestActive pushback _x;_OpBlu pushback _x;};
		if ((side (group _x)) isEqualTo EAST) then {_EastActive pushback _x;_OpBlu pushback _x;};
		if ((side (group _x)) isEqualTo RESISTANCE) then {_ResistanceActive pushback _x;};
	} foreach allunits;	
	
	private _rtnarray = [_WestActive,_EastActive,_ResistanceActive,_OpBlu];
	_rtnarray