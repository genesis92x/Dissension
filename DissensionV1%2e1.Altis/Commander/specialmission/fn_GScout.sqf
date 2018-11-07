//This function will spawn a single scout unit for the Guerrilla commander to go scout.
params ["_CSide"];

//Initalize important variables heres
private _WestRun = false;
private _ScoutClass = ObjNull;
private _Buildinglist = "no";	
private _camps = "no";
private _CommanderAct = nil;


//Change side specific variables here
if (_CSide isEqualTo West) then
{

	_ScoutClass = "B_recon_LAT_F";
	_Buildinglist = W_BuildingList;	
	_camps = W_GuerC;	
	_WestRun = true;
	_CommanderAct = DIS_WestCommander;
}
else
{
	_ScoutClass = "O_T_Recon_LAT_F";
	_Buildinglist = e_BuildingList;	
	_camps = E_GuerC;		
	_CommanderAct = DIS_EastCommander;
};

//First we need to find the closest barracks to spawn the scout from.
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
	if (_Name isEqualTo "Barracks") then {_BarrackList pushback (_x select 0);_BarracksSwitch = true;};
	true;
} count _Buildinglist;

{
	_BarrackList pushback _x;
	true;
} count _camps;

private _Enemy = _CommanderAct call dis_ClosestEnemy;
private _SpawnLoc = [_BarrackList,_Enemy,true] call dis_closestobj;
private _SpwnPos = getpos _SpawnLoc;
private _EnemyPos = getpos _Enemy;

//Now lets create the scouting unit
private _grp = createGroup _CSide;

private _unit = _grp createUnit [_ScoutClass,_SpwnPos, [], 0, "FORM"];
[_unit] joinSilent _grp;

if (_WestRun) then
{
	W_RArray set [0,(W_RArray select 0) - 10];
	W_RArray set [1,(W_RArray select 1) - 10];
	W_RArray set [2,(W_RArray select 2) - 10];
	W_RArray set [3,(W_RArray select 3) - 10];		
	Dis_BluforTickets = Dis_BluforTickets - 1;
}
else
{
	E_RArray set [0,(E_RArray select 0) - 10];
	E_RArray set [1,(E_RArray select 1) - 10];
	E_RArray set [2,(E_RArray select 2) - 10];
	E_RArray set [3,(E_RArray select 3) - 10];		
	Dis_OpforTickets = Dis_OpforTickets - 1;		
};


//Give the scout a waypoint to the nearest enemy
systemChat format ["POS: %1 ENEMY: %2",_EnemyPos,_Enemy];
_wp = _grp addwaypoint[_EnemyPos,1];
_wp setwaypointtype "MOVE";
_wp setWaypointSpeed "NORMAL";
_wp = _grp addwaypoint[_EnemyPos,1];
_wp setwaypointtype "MOVE";
_wp setWaypointSpeed "NORMAL";

//Deploy the news!
_AddNewsArray = ["Deploying Scout",format 
[
"
	A scout has been created and will find a good location to report enemy movement on the map in a 1 KM radius. He is marked as SCOUT on the map!<br/>
"

,"Hai"
]
];

//Create the marker and run the code to have the unit spot d00ds.

if (_WestRun) then
{
	dis_WNewsArray pushback _AddNewsArray;
	publicVariable "dis_WNewsArray";
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",West];		
	
	[
	[_grp],
	{
			private _Group = _this select 0;
			private _Marker = createMarkerLocal [format ["ID_%1",_Group],[0,0,0]];
			private _leader = leader _Group;
			_Marker setMarkerColorLocal "ColorBlue";
			_Marker setMarkerSizeLocal [1,1];			
			_Marker setMarkerShapeLocal 'ICON';		
			_Marker setMarkerTypeLocal "b_inf";		
			_Marker setMarkerTextLocal "SCOUT";
			
			if (isServer) then {[West,_Marker,_Group,"Scout"] call DIS_fnc_mrkersave; };
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
				_Marker setMarkerPosLocal (getposASL (leader _Group));
				
				private _MarkerArray = [];
				{
					if (_x distance _leader < 1001) then
					{
						private _NewMarker = createMarkerLocal [format ["ID_%1",_Group],[0,0,0]];
						_NewMarker setMarkerColorLocal "ColorRed";
						_NewMarker setMarkerSizeLocal [1,1];							
						_NewMarker setMarkerShapeLocal 'ICON';		
						_NewMarker setMarkerTypeLocal "o_inf";		
						_NewMarker setMarkerTextLocal "ENEMY";
						true;
					};
				} count (allunits select {side _x isEqualTo East});
				
				
				sleep 3;
				{
					deleteMarker _x;
					true;
				} count _MarkerArray;
			
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
	[_grp],
	{
			private _Group = _this select 0;
			private _leader = leader _Group;
			private _Marker = createMarkerLocal [format ["ID_%1",_Group],[0,0,0]];
			_Marker setMarkerColorLocal "ColorRed";
			_Marker setMarkerSizeLocal [1,1];			
			_Marker setMarkerShapeLocal 'ICON';		
			_Marker setMarkerTypeLocal "o_inf";		
			_Marker setMarkerTextLocal "Scout";
			
			if (isServer) then {[East,_Marker,_Group,"Scout"] call DIS_fnc_mrkersave; };
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
				_Marker setMarkerPosLocal (getposASL (leader _Group));
				
				private _MarkerArray = [];
				{
					if (_x distance _leader < 1001) then
					{
						private _NewMarker = createMarkerLocal [format ["ID_%1",_Group],[0,0,0]];
						_NewMarker setMarkerColorLocal "ColorBlue";
						_NewMarker setMarkerSizeLocal [1,1];							
						_NewMarker setMarkerShapeLocal 'ICON';		
						_NewMarker setMarkerTypeLocal "b_inf";		
						_NewMarker setMarkerTextLocal "ENEMY";
						true;
					};
				} count (allunits select {side _x isEqualTo West});
				
				
				sleep 3;
				{
					deleteMarker _x;
					true;
				} count _MarkerArray;
			};
			sleep 5;
			deleteMarker _Marker;			

	}
	
	] remoteExec ["bis_fnc_Spawn",0]; 		
	
};





