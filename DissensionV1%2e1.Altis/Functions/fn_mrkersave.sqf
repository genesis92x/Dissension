//[West,_Marker] call DIS_fnc_mrkersave;
params ["_Side"];


if (_Side isEqualTo West) then
{
	W_Markers pushback _this;
	publicVariable "W_Markers";	
		
}
else
{
	E_Markers pushback _this;
	publicVariable "E_Markers";
	
};

