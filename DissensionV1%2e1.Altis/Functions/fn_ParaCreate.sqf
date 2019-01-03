//Function for creating non-desyncing parachutes. And attaching objects to them.
//Yay.
params ["_Obj","_Side","_Pos"];

private _Parachute = ObjNull;

switch (_Side) do {
    case West: {_Parachute = "B_Parachute_02_F";};
    case East: {_Parachute = "O_Parachute_02_F";};
    case resistance: {_Parachute = "I_Parachute_02_F";};
	 default {};
};



private _para = createVehicle ["B_Parachute_02_F", _Pos, [], 0, "CAN_COLLIDE"];

//Delete Para if alive for too long.
_Para spawn
{
	sleep 240;
	if (alive _this) then
	{
		deleteVehicle _this;
	};
};

_Obj attachTo [_para,[0,0,0]]; 



if (_Obj isKindOf "Man") then
{
	[_Obj,"Para_Pilot"] remoteExec ["DIS_switchMoveEverywhere",0];
	[_Obj,_Para] spawn
	{
		params ["_Obj","_Para"];
		waitUntil {((getpos _Obj) select 2) < 1.5};
		[_Obj,"AparPercMstpSnonWnonDnon_AmovPpneMstpSnonWnonDnon"] remoteExec ["DIS_switchMoveEverywhere",0];
		detach _Obj;
	};
}
else
{

	[_Obj,_Para] spawn
	{
		params ["_Obj","_Para"];
		waitUntil {((getpos _Obj) select 2) < 6};
		detach _Obj;
	};

};
