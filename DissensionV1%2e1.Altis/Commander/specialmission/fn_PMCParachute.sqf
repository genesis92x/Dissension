//[] call DIS_fnc_PMCParachute;
//Lets purchase some militia and have them parachute ontop of the enemy! Yay!!
//Lets make it cool by adding an awesome parachute effect.

Params ["_CSide"];

private _Comm = objNull;
private _Target = ObjNull;
private _AddNewsArray = "";
private _EnemyA = [];
private _WestRun = false;
private _troops = [];
private _Locs = [];

private _HC = false;
if (("HC" call BIS_fnc_getParamValue) isEqualTo 1) then 
{
	if !(isNil "HC") then
	{
		if !(isNull HC) then
		{
			_HC = true;
		};
	};
};


if (_CSide isEqualTo West) then
{
	_troops = W_BarrackU;
	{
		_EnemyA pushback _x;
	} forEach (allgroups select {!(side _x isEqualTo West)});
	_WestRun = true;
	_Locs = DIS_WENGAGED;
}
else
{
	_troops = E_BarrackU;
	{
		_EnemyA pushback _x;
	} forEach (allgroups select {!(side _x isEqualTo East)});
	_Locs = DIS_EENGAGED;
	
};

private _FSSPWN = [];
if (_Locs isEqualTo []) then
{
	_FSSPWN = (leader (selectRandom _EnemyA));
}
else
{
	_FSSPWN = (selectRandom _Locs) select 0;
};



//Send the message!
["PMC COMMANDER: UNIT PARA-DROP",'#FFFFFF'] remoteExec ["MessageFramework",_CSide];	
_AddNewsArray = ["Hired Unit Para-drop",format 
[
"
	We have hired units to parachute onto a nearby town.<br/>
"

,"Hai"
]
];
if (_WestRun) then {dis_WNewsArray pushback _AddNewsArray;publicVariable "dis_WNewsArray";} else {dis_ENewsArray pushback _AddNewsArray;publicVariable "dis_ENewsArray";};
["Beep_Target"] remoteExec ["PlaySoundEverywhere",_CSide];

//Lets spawn units on these doods!
private _Spawn = 10;
private _grp = createGroup _CSide;
_grp setVariable ["DIS_IMPORTANT",true];



while {_Spawn > 0} do
{
	private _unit = _grp createUnit [(selectRandom _troops) select 0,[0,0,0], [], 25, "CAN_COLLIDE"];
	_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled;}];
	[_unit] joinSilent _grp;		
	if !(LIBACTIVATED) then {_unit call DIS_fnc_PMCUniforms};
	_unit allowdamage false;
	_Spawn = _Spawn - 1;
};


_Pos = getpos _FSSPWN;
{
	private _rndp = [_Pos,100,5] call dis_randompos;
	[_x,_Cside,[(_rndp select 0),(_rndp select 1),250]] call Dis_fnc_ParaCreate;
	sleep 1.5;
} foreach (units _grp);


[
	[_Pos],
	{
		Params ["_Pos"];
		
		if (player distance2D _Pos < 500) then
		{
			playsound "FlyBy";
		};
	}
	
] remoteExec ["bis_fnc_Spawn",0];			
	
		

if (_HC) then
{
	_grp setGroupOwner (owner HC);
	_grp setVariable ["DIS_TRANSFERED",true];
};

