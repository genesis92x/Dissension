//This function will have the Guerrilla commander spawn and maintain a Guerrilla camp somewhere on the map.
//This camp will be capable of spawning SMALL amounts of infantry around the map for special missions or defensive purpsoes.
//_this = side.
private _CSide = _this;

//Lets determine some faction specific factors here. Things like units to use and etc.
private _BarrackU = [];
private _LFactU = [];
private _HFactU = [];
private _AirU = [];
private _MedU = [];
private _AdvU = [];
private _TeamLU = [];
private _SquadLU = [];
private _Comm = "No";
private _Structure = "B_UGV_01_F";
private _color = "colorblack";
private _MarkerName = "No";
private _WestRun = false;

{
	if (isNull (_x select 0)) then
	{
		W_GuerC = W_GuerC - [_forEachIndex];
	};

} foreach W_GuerC;

{
	if (isNull (_x select 0)) then
	{
		E_GuerC = E_GuerC - [_forEachIndex];
	};

} foreach E_GuerC;


if (_CSide isEqualTo West) then
{
	_BarrackU = W_BarrackU;
	_LFactU = W_LFactU;
	_HFactU = W_HFactU;
	_AirU = W_AirU;
	_MedU = W_MedU;
	_AdvU = W_AdvU;
	_TeamLU = W_TeamLU;
	_SquadLU = W_SquadLU;
	_Comm = Dis_EastCommander;
	W_RArray set [0,(W_RArray select 0) - 10];
	W_RArray set [1,(W_RArray select 1) - 10];
	W_RArray set [2,(W_RArray select 2) - 10];
	W_RArray set [3,(W_RArray select 3) - 10];	
	_Color = "ColorBlue";
	_MarkerName = format["respawn_west_%1",round (random 100000)];
	_WestRun = true;
}
else
{
	_BarrackU = E_BarrackU;
	_LFactU = E_LFactU;
	_HFactU = E_HFactU;
	_AirU = E_AirU;
	_MedU = E_MedU;
	_AdvU = E_AdvU;
	_TeamLU = E_TeamLU;
	_SquadLU = E_SquadLU;
	_Comm = Dis_WestCommander;	
	E_RArray set [0,(E_RArray select 0) - 10];
	E_RArray set [1,(E_RArray select 1) - 10];
	E_RArray set [2,(E_RArray select 2) - 10];
	E_RArray set [3,(E_RArray select 3) - 10];
	_Structure = "O_T_UGV_01_ghex_F";	
	_Color = "ColorRed";
	_MarkerName = format["respawn_east_%1",round (random 100000)];
	_WestRun = false;
};

if (isNil "W_GuerC") then {W_GuerC = []};
if (isNil "E_GuerC") then {E_GuerC = []};
if (_WestRun) then
{
	//If we have reached our limit...we need to destroy the oldest camp and recreate a new one.
	if (count W_GuerC >= 4) then
	{
		_DeleteStructure = (W_GuerC select 0) select 0;
		deleteVehicle _DeleteStructure;
	};
}
else
{
	//If we have reached our limit...we need to destroy the oldest camp and recreate a new one.
	if (count E_GuerC >= 4) then
	{
		_DeleteStructure = (E_GuerC select 0) select 0;
		deleteVehicle _DeleteStructure;		
	};
};


//Below is a modified version of createbuilding.sqf

private _ComPos = (getpos _Comm);
private _rnd = random 500;
private _dist = (_rnd + 300);
private _dir = random 360;
private _positions = [(_ComPos select 0) + (sin _dir) * _dist, (_ComPos select 1) + (cos _dir) * _dist, 0];

private _Locations = selectBestPlaces [_positions, 50, "trees + 2*forest", 1, 1];
private _Sel = _Locations select 0 select 0;
private _position = _Sel findEmptyPosition [25,300,_Structure];


if (_position isEqualTo []) then {_position = _positions};

private _b = _Structure createVehicle _position;
createVehicleCrew _b;
_b allowdamage false;_b spawn {sleep 30; _this allowdamage true;};
_b lock true;
_b disableAI "ALL";


_bPos = getpos _b;
if (isOnRoad _position) then
{
	_LoopyDoo = true;
	while {_LoopyDoo} do
	{
		_rnd = random 25;
		_dist = (_rnd + 25);
		_dir = random 360;
		_positions = [(_bPos select 0) + (sin _dir) * _dist, (_bPos select 1) + (cos _dir) * _dist, 0];
		if !(isOnRoad _positions) then {_LoopyDoo = false;};
	};


}; 

if (surfaceIsWater _positions) then
{

	_AttemptCounter = 0;
	_water = true;
	while {_water} do 
	{
		_AttemptCounter = _AttemptCounter + 1;
		_rnd = random 275;
		_dist = (_rnd + 25);
		_dir = random 360;
	
		_positions = [(_bPos select 0) + (sin _dir) * _dist, (_bPos select 1) + (cos _dir) * _dist, 0];	
		if (!(surfaceIsWater _positions) || _AttemptCounter > 50) then {_water = false;_position = _positions;};
		sleep 0.25;
	};
};

_b setpos _position;

_Loc = _position;
if (_WestRun) then {W_GuerC pushback [_b,"Camp"];} else {E_GuerC pushback [_b,"Camp"];};



_b setpos [(getpos _b select 0), (getpos _b select 1), 0];

private _p1 = [_b,15,10] call dis_randompos;
private _p2 = [_b,15,10] call dis_randompos;
private _p3 = [_b,15,10] call dis_randompos;

private _H1 = "Land_Cargo_house_slum_F" createVehicle _p1;
private _H2 = "Land_Slum_House03_F" createVehicle _p2;
private _H3 = "Land_Slum_House02_F" createVehicle _p3;
private _SA = [_H1,_H2,_H3];
_H1 setdir (random 360);
_H2 setdir (random 360);
_H3 setdir (random 360);
_b setVariable ["DIS_PLAYERVEH",true];
_H1 setVariable ["DIS_PLAYERVEH",true];
_H2 setVariable ["DIS_PLAYERVEH",true];
_H3 setVariable ["DIS_PLAYERVEH",true];



_Marker = createMarkerLocal [_MarkerName,_Loc];


[
[_Marker,_CSide,_color],
{
		params ["_Marker","_CSide","_color"];
		
		if (playerSide isEqualTo _CSide) then
		{
			_Marker setMarkerShapeLocal 'ICON';
			_Marker setMarkerColorLocal _Color;
			_Marker setMarkerAlphaLocal 1;
			_Marker setMarkerSizeLocal [1,1];
			_Marker setMarkerDirLocal 0;	
			_Marker setMarkerTypeLocal 'loc_Bunker';
			_Marker setMarkerTextLocal format ["%1","Camp"];	
		};
}

] remoteExec ["bis_fnc_Spawn",0]; 


_b setVariable ["dis_Marker",[_Marker,"Camp",_SA]];


_Clear = nearestTerrainObjects [_b, ["Tree","Bush"], 25];
{
	_x hideObjectGlobal true;
} foreach _Clear;


(group (driver _b)) setVariable ["DIS_IMPORTANT",true];

if (_CSide isEqualTo West) then 
{
	_b addEventHandler ["killed",
	{
	_Variable = (_this select 0) getVariable "dis_Marker";
	_Marker = _Variable select 0;
	_StructureName = _Variable select 1;
	_OBA = _Variable select 2;
	deleteMarker _Marker;
	W_GuerC = W_GuerC - [(_this select 0),_StructureName];
	deleteVehicle (_this select 0);
	{deletevehicle _x;} foreach _OBA;
	}];
	
	
	
	_AddNewsArray = ["Camp Created",format ["We have created a new camp! This camp will allow you to respawn there as well as provide a good location to spawn response teams.","Camp"] ];
	dis_WNewsArray pushback _AddNewsArray;
	publicVariable "dis_WNewsArray";
	
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",West];
	["CONSTRUCTION COMPLETE",'#FFFFFF'] remoteExec ["MessageFramework",West];	
	
	publicVariable "W_GuerC";
	systemChat format ["_ComPos: %1",_ComPos];
	_ComPos spawn {sleep 5;_AdditionalMessage = "Recruiting units at our camps to assault the enemy!";[West,24,0,0,0,0,_this,_AdditionalMessage] spawn dis_recruitunits;};
}
else
{
	_b addEventHandler ["killed",
	{
	_Variable = (_this select 0) getVariable "dis_Marker";
	_Marker = _Variable select 0;
	_StructureName = _Variable select 1;
	_OBA = _Variable select 2;	
	deleteMarker _Marker;
	E_GuerC = E_GuerC - [(_this select 0),_StructureName];
	{deletevehicle _x;} foreach _OBA;
	deleteVehicle (_this select 0);
	}];
	
	
	
	_AddNewsArray = ["Camp Created",format ["We have created a new camp! This camp will allow you to respawn there as well as providing a good location to spawn response teams.","Camp"] ];
	dis_ENewsArray pushback _AddNewsArray;
	publicVariable "dis_ENewsArray";
	
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",West];
	["CONSTRUCTION COMPLETE",'#FFFFFF'] remoteExec ["MessageFramework",West];	
	
	publicVariable "E_GuerC";
	_ComPos spawn {sleep 5;_AdditionalMessage = "Recruiting units at our camps to assault the enemy!";[East,24,0,0,0,0,_this,_AdditionalMessage] spawn dis_recruitunits;};
};

