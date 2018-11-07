/*
_this select 0 = Center position
_this select 1 = Radius
x = cx + r * cos(a)
y = cy + r * sin(a)

*/
Params ["_PosCenter","_r"];

DIS_DrawCenter = [_PosCenter select 0,_PosCenter select 1,100];
DIS_RadiusT = _r;

["DIS_ID2", "onEachFrame", 
{
	
	if !(hasInterface) exitwith {};	
	private _dist = player distance2D DIS_DrawCenter;
	private _Equ = round (Dis_RadiusT - _dist);
	drawIcon3D ["targetIcon.paa", [0,0,0,0.7], _dist, 0.5, 0.5, 0,format ["%1",_Equ], 2, 0.0250, "TahomaB"];
	
	
		
}] call BIS_fnc_addStackedEventHandler;



while {DIS_ZoneSpawn} do
{
	if (player distance2D _PosCenter > (_r + 550)) then
	{
		DIS_ZoneSpawn = false;
		["DIS_ID2", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
	};
	sleep 5;
};










/*
Params ["_PosCenter","_r"];
DIS_ZoneSpawn = true;

private _PointArray = [];
private _cx = _PosCenter select 0;
private _cy = _PosCenter select 1;

_Radius = 0;

while {_Radius < 360} do
{
	private _NewX = _cx + _r * cos(_Radius);
	private _NewY = _cy + _r * sin(_Radius);
	//private _Obj1 = createSimpleObject ["a3\structures_f_heli\vr\helpers\sign_sphere100cm_f.p3d",[0,0,0]];
	_Height = 4;
	for "_i" from 0 to 15 do
	{
		_Obj1 = "Sign_Arrow_Direction_Yellow_F" createVehicleLocal [0,0,0];
		private _NewPos = [_NewX,_NewY,_Height];
		_Obj1 setpos _NewPos;
		_PointArray pushback _Obj1;
		_Obj1 setdir ([_Obj1, _PosCenter] call BIS_fnc_dirTo);
		_Height = _Height + 10;
	};

	
	_Radius = _Radius + 5;
};

while {DIS_ZoneSpawn} do
{
	if (player distance2D _PosCenter > (_r + 550)) then
	{
		DIS_ZoneSpawn = false;
	};
	sleep 5;
};

{
	deleteVehicle _x;
} foreach _PointArray;