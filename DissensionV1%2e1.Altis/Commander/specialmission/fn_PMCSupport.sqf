//This function will have the Guerrilla commander spawn a randomly sized squad to go harass the enemy teams, no matter the distance. WHAT A JERK.
//_this = side.
params ["_CSide"];

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
private _color = "colorblack";
private _MarkerName = "No";
private _Buildinglist = "no";
private _EnemyArray = [];
private _WestRun = false;
private _CommanderAct = nil;

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
	_Comm = Dis_WestCommander;
	_Buildinglist = W_BuildingList;
	_Color = "ColorBlue";
	_EnemyArray = W_DistArray;
	_WestRun = true;
	_CommanderAct = DIS_WestCommander;
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
	_Comm = Dis_EastCommander;	
	_Buildinglist = E_BuildingList;
	_Color = "ColorRed";
	_EnemyArray = E_DistArray;
	_WestRun = false;
	_CommanderAct = DIS_EastCommander;	
};

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

private _Enemy = _CommanderAct call dis_ClosestEnemy;
private _SpawnLoc = [_BarrackList,_Enemy,true] call dis_closestobj;
private _SpwnPos = getpos _SpawnLoc;
private _EnemyPos = getpos _Enemy;

//Spawn units to attack enemy units/territory
private _grp = createGroup _CSide;_grp setVariable ["DIS_IMPORTANT",true];
{
	private _rndU = selectRandom _InfList;	
	private _unit = _grp createUnit [((_rndU select 0) select 0) ,_SpwnPos, [], 25, "FORM"];
	_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
	[_unit] joinSilent _grp;	
	if !(LIBACTIVATED) then {_unit call DIS_fnc_PMCUniforms};
	
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
	
	sleep 2.5;
	true;
} count [1,2,3,4,5,6,7,8,9,10,11,12];


_wp = _grp addwaypoint[_EnemyPos,1];
_wp setwaypointtype "MOVE";
_wp setWaypointSpeed "NORMAL";
_wp = _grp addwaypoint[_EnemyPos,1];
_wp setwaypointtype "MOVE";
_wp setWaypointSpeed "NORMAL";




//Deploy the news!
_AddNewsArray = ["Hiring Extra Troops",format 
[
"
A militia of 12 troops have been deployed to assist the capture of towns. They have been marked on the map as MILITIA.<br/>
"

,"Hai"
]
];

if (_WestRun) then
{
	dis_WNewsArray pushback _AddNewsArray;
	publicVariable "dis_WNewsArray";
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",West];		
	
	[
	[_grp,West],
	{
			private _Group = _this select 0;
			private _Cside = _this select 1;
			private _Marker = createMarkerLocal [format ["ID_%1",_Group],[0,0,0]];
			_Marker setMarkerColorLocal "ColorBlue";
			_Marker setMarkerSizeLocal [1,1];			
			_Marker setMarkerShapeLocal 'ICON';		
			_Marker setMarkerTypeLocal "b_inf";

			if (isServer) then {[_Cside,_Marker,_Group,"PMCSupport"] call DIS_fnc_mrkersave; };
			if (playerSide isEqualTo _Cside) then
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
				_Marker setMarkerTextLocal format ["MILITIA: %1",({alive _x} count (units _Group))];
				_Marker setMarkerPosLocal (getposASL (leader _Group));
				sleep 1.25;
			};
			sleep 5;
			deleteMarker _Marker;			

	}
	
	] remoteExec ["bis_fnc_Spawn",0]; 		
	
	
}
else
{
	dis_ENewsArray pushback _AddNewsArray;
	publicVariable "dis_ENewsArray";
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",East];		
	
	
	[
	[_grp,East],
	{
			private _Group = _this select 0;
			private _CSide = _this select 1;
			private _Marker = createMarkerLocal [format ["ID_%1",_Group],[0,0,0]];
			_Marker setMarkerColorLocal "ColorRed";
			_Marker setMarkerSizeLocal [1,1];			
			_Marker setMarkerShapeLocal 'ICON';		
			_Marker setMarkerTypeLocal "o_inf";

			if (isServer) then {[_Cside,_Marker,_Group,"PMCSupport"] call DIS_fnc_mrkersave; };
			if (playerSide isEqualTo _Cside) then
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
				_Marker setMarkerTextLocal format ["MILITIA %1",({alive _x} count (units _Group))];
				_Marker setMarkerPosLocal (getposASL (leader _Group));
				sleep 1.25;
			};
			sleep 5;
			deleteMarker _Marker;			

	}
	
	] remoteExec ["bis_fnc_Spawn",0]; 		
	
};












