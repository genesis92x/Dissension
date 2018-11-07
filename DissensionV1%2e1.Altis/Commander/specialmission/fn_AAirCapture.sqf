//[] call DIS_fnc_AAirCapture;
//This function will unleash paratroopers ontop of the enemy! YAY
Params ["_Cside"];

private _Comm = objNull;
private _Buildinglist = [];
private _BarrackU = [];
private _LFactU = [];
private _HFactU = [];
private _AirU = [];
private _MedU = [];
private _AdvU = [];
private _TeamLU = [];
private _SquadLU = [];
private _CommF = objNull;
private _CommE = objNull;
private _Target = ObjNull;
private _AddNewsArray = "";
private _EnemyArray = [];
private _WestRun = false;
private _SummedOwned = [];
private _TAF = [];
private _TAE = [];
private _AttackPos = [0,0,0];
private _DefenceTerritory = [];
private _ESummedOwned = [];

if (_CSide isEqualTo West) then
{
	_BarrackU = W_BarrackU;
	_LFactU = W_LFactU;
	_HFactU = W_HFactU;
	_AirU = W_AirU;
	_MedU = W_MedU;
	_AdvU = W_AdvU;
	_TeamLU = W_TeamLU;
	_CommF = Dis_WestCommander;
	_CommE = Dis_EastCommander;
	_SquadLU = W_SquadLU;
	_TAF = West call dis_compiledTerritory;
	_TAE = East call dis_compiledTerritory;
	_WestRun = true;
	_Buildinglist = W_BuildingList;	
	_SummedOwned = BluLandControlled + BluControlledArray;	
	_ESummedOwned = OpLandControlled + OpControlledArray;
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
	_CommE = Dis_WestCommander;
	_CommF = Dis_EastCommander;
	_SquadLU = E_SquadLU;
	_TAF = East call dis_compiledTerritory;
	_TAE = West call dis_compiledTerritory;
	_Buildinglist = E_BuildingList;
	_SummedOwned = OpLandControlled + OpControlledArray;
	_ESummedOwned = BluLandControlled + BluControlledArray;
};

// The first thing we need to do is locate what area we want to capture.
//CompleteRMArray pushback [_Marker,_FinalSelection,_x,false,_location];
//CompleteTaskResourceArray pushback [_Pole,[_CashFlowRandom,_PowerFlowRandom,_OilFlowRandom,_MaterialsFlowRandom],_Loc,_Pos];


//Lets compile all the capturable territories that are within a certain distance of each commander.
private _AttackArray = [];
private _EAttackArray = [];
{
	if (!((_x select 0) in _SummedOwned) && _CommF distance (_x select 0) < 3000) then
	{
		_AttackArray pushback (_x select 0);
	};	
	
	/*
	if (!((_x select 0) in _ESummedOwned) && _CommE distance (_x select 0) < 3000) then
	{
		_EAttackArray pushback (_x select 0);
	};		
	*/
	
} foreach CompleteTaskResourceArray;
	
	
{
	if (!((_x select 2) in _SummedOwned) && {_CommF distance (getMarkerPos (_x select 2)) < 3000}) then
	{
		_AttackArray pushback (_x select 4);
	};
	
	/*
	if (!((_x select 2) in _ESummedOwned) && {_CommE distance (getMarkerPos (_x select 2)) < 3000}) then
	{
		_EAttackArray pushback (_x select 4);
	};
	*/
	
	
} foreach CompleteRMArray;

//We need a location that is close to the defensive commander, but a good distance away from the enemy.
{
	private _Loc = _x;
	private _LocD = _x distance _CommF;

	if (_LocD > (_Loc distance _CommE)) then
	{
		_AttackArray = _AttackArray - [_Loc];
	};
	
} foreach _AttackArray;


private _ClosestTerrFriend = [_TAE,_AttackArray,true] call dis_ADistC;
private _ClosestFinal = getpos (_ClosestTerrFriend select 0 select 2);

//Lets separate all our buildings so we know where to spawn our units.
private _BarrackList = [];
private _LightFactoryList = [];
private _HeavyFactoryList = [];
private _AirFieldFactoryList =	[];
private _ShipFactoryList = [];
private _GroupList = [];
private _BarracksSwitch = false;
private _LFactorySwitch = false;
private _StaticSwitch = false;
private _HFactorySwitch = false;
private _AFactorySwitch = false;
private _MedBaySwitch = false;
private _AdvInfSwitch = false;
private _InfList = [];
private _HList = [];
private _LList = [];
private _AList = [];

{
	_Phy = _x select 0;
	_Name = _x select 1;
	if (_Name isEqualTo "Barracks") then {_BarrackList pushback (_x select 0);_BarracksSwitch = true;_InfList pushback _BarrackU;};
	if (_Name isEqualTo "Light Factory") then {_LightFactoryList pushback (_x select 0);_LFactorySwitch = true;_LList pushback _LFactU;};
	if (_Name isEqualTo "Static Bay") then {_StaticSwitch = true;};
	if (_Name isEqualTo "Heavy Factory") then {_HeavyFactoryList pushback (_x select 0);_HFactorySwitch = true;_HList pushback _HFactU;};
	if (_Name isEqualTo "Air Field") then {_AirFieldFactoryList pushback (_x select 0);_AFactorySwitch = true;_AList pushback _AirU;};
	if (_Name isEqualTo "Medical Bay") then {_MedBaySwitch = true;_InfList pushback _MedU;};
	if (_Name isEqualTo "Advanced Infantry Barracks") then {_AdvInfSwitch = true;_InfList pushback _AdvU;};
	true;
} count _Buildinglist;

private _SpawnLoc = [_BarrackList,_ClosestFinal,true] call dis_closestobj;
private _SpwnPos = getpos _SpawnLoc;


//Spawn units to attack enemy units/territory
private _grp = createGroup _CSide;
_grp setVariable ["DIS_IMPORTANT",true];
{
	private _rndU = selectRandom _InfList;	
	_unit = _grp createUnit [((_rndU select 0) select 0) ,[0,0,0], [], 0, "CAN_COLLIDE"];
	[_unit] joinSilent _grp;
	_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];	
	_unit enableSimulationGlobal false;
	
	if (_WestRun) then
	{
		W_RArray set [0,(W_RArray select 0) - (((_rndU select 0) select 1) select 0)];
		W_RArray set [1,(W_RArray select 1) - (((_rndU select 0) select 1) select 1)];
		W_RArray set [2,(W_RArray select 2) - (((_rndU select 0) select 1) select 2)];
		W_RArray set [3,(W_RArray select 3) - (((_rndU select 0) select 1) select 3)];		
		Dis_BluforTickets = Dis_BluforTickets - 1;
	}
	else
	{
		E_RArray set [0,(E_RArray select 0) - (((_rndU select 0) select 1) select 0)];
		E_RArray set [1,(E_RArray select 1) - (((_rndU select 0) select 1) select 1)];
		E_RArray set [2,(E_RArray select 2) - (((_rndU select 0) select 1) select 2)];
		E_RArray set [3,(E_RArray select 3) - (((_rndU select 0) select 1) select 3)];		
		Dis_OpforTickets = Dis_OpforTickets - 1;		
	};
	true;
	sleep 2;
} count [1,2,3,4,5,6,7,8,9,10,11,12];


{
	private _SpwnPos = [_ClosestFinal, random 350, random 360] call BIS_fnc_relPos;
	[_x,_Cside,[(_SpwnPos select 0),(_SpwnPos select 1),((_SpwnPos select 2) + 300)]] call Dis_fnc_ParaCreate;
	sleep 1.5;
} foreach (units _grp);


_wp = _grp addwaypoint[_ClosestFinal,1];
_wp setwaypointtype "MOVE";
_wp setWaypointSpeed "NORMAL";
_wp = _grp addwaypoint[_ClosestFinal,1];
_wp setwaypointtype "MOVE";
_wp setWaypointSpeed "NORMAL";


//After X amount of idle time - add the units into the array to be controlled. Also spawn a marker on them.

//Send the message!
["ASSAULT COMMANDER: AIRDROP TARGET AQUIRED",'#FFFFFF'] remoteExec ["MessageFramework",_CSide];
_AddNewsArray = ["Assault Target",format 
[
"
	The location at, %1 will be assaulted by our para-dropped units. This will disrupt the enemies movement and strategy.<br/>
"

,(mapGridPosition _ClosestFinal)
]
];
if (_WestRun) then {dis_WNewsArray pushback _AddNewsArray;publicVariable "dis_WNewsArray";} else {dis_ENewsArray pushback _AddNewsArray;publicVariable "dis_ENewsArray";};
["Beep_Target"] remoteExec ["PlaySoundEverywhere",_CSide];



if (_WestRun) then 
{

	[
	[_grp],
	{
			private _Group = _this select 0;
			private _Marker = createMarkerLocal [format ["ID_%1",_Group],[0,0,0]];
			_Marker setMarkerColorLocal "ColorBlue";
			_Marker setMarkerSizeLocal [1,1];			
			_Marker setMarkerShapeLocal 'ICON';		
			_Marker setMarkerTypeLocal "b_inf";
			
			if (isServer) then {[West,_Marker,_Group,"AAirCapture"] call DIS_fnc_mrkersave; };
			if (playerSide isEqualTo West) then
			{
				_Marker setMarkerAlphaLocal 1;
			}
			else
			{
				_Marker setMarkerAlphaLocal 0;
			};				
			
			while {({alive _x} count (units _Group)) > 0} do
			{
				_Marker setMarkerDirLocal (getdir (leader _Group));	
				_Marker setMarkerTextLocal format ["ASSAULT SQUAD %1",({alive _x} count (units _Group))];
				_Marker setMarkerPosLocal (getposASL (leader _Group));
				sleep 1.25;
			};
			sleep 5;
			deleteMarker _Marker;			

	}
	
	] remoteExec ["bis_fnc_Spawn",0]; 		

	sleep 1200;
	{W_ActiveUnits pushBack _x} foreach (units _grp);
} 
else 
{

	[
	[_grp],
	{
			private _Group = _this select 0;
			private _Marker = createMarkerLocal [format ["ID_%1",_Group],[0,0,0]];
			_Marker setMarkerColorLocal "ColorRed";
			_Marker setMarkerSizeLocal [1,1];			
			_Marker setMarkerShapeLocal 'ICON';		
			_Marker setMarkerTypeLocal "o_inf";
			
			if (isServer) then {[East,_Marker,_Group,"AAirCapture"] call DIS_fnc_mrkersave; };
			if (playerSide isEqualTo East) then
			{
				_Marker setMarkerAlphaLocal 1;
			}
			else
			{
				_Marker setMarkerAlphaLocal 0;
			};			
			
			while {({alive _x} count (units _Group)) > 0} do
			{
				_Marker setMarkerDirLocal (getdir (leader _Group));	
				_Marker setMarkerTextLocal format ["ASSAULT SQUAD %1",({alive _x} count (units _Group))];
				_Marker setMarkerPosLocal (getposASL (leader _Group));
				sleep 1.25;
			};
			sleep 5;
			deleteMarker _Marker;			

	}
	
	] remoteExec ["bis_fnc_Spawn",0]; 		

	sleep 1200;
	{E_ActiveUnits pushBack _x} foreach (units _grp);
};
