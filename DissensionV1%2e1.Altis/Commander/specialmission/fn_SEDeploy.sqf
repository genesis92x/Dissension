private ["_CE", "_DefencePos", "_Pole", "_CashFlowRandom", "_PowerFlowRandom", "_OilFlowRandom", "_MaterialsFlowRandom", "_Loc", "_SummedOwned", "_MDefenceArray", "_Marker", "_FinalSelection", "_location", "_SpawnLocation", "_BestAreaArray", "_FinalSelect", "_BuildingArray", "_TransportUnit", "_grp", "_Unit", "_waypoint"];
params ["_CSide"];


private _Westrun = false;
private _SummedOwned = [];
private _TransportUnit = objNull;
private _Comm = objNull;
private _Side = East;
if (_CSide isEqualTo West) then
{
	_SummedOwned = BluLandControlled + BluControlledArray;
	_Westrun = true;
	_Comm = Dis_WestCommander;
	_Side = West;
	
	//Lets find out what kind of units we can use to deploy the statics
	//dis_ListOfBuildings = [[W_Barracks,[10,20,0,25],"Land_i_Barracks_V2_F"],[W_LightFactory,[20,40,0,50],"Land_MilOffices_V1_F"],[W_StaticBay,[15,25,0,20],"Land_Shed_Big_F"][W_HeavyFactory,[40,60,0,100],"Land_dp_smallFactory_F"],[W_Airfield,[80,120,0,200],"Land_Hangar_F"],[W_MedicalBay,[15,25,0,30],"Land_Research_house_V1_F"]];
	private _BuildingArray = [];
	{
		if (_x select 0) then
		{
			if ("Land_Cargo_House_V1_F" isEqualTo (_x select 2)) then {_BuildingArray pushback "Barracks";};
			if ("Land_Research_HQ_F" isEqualTo (_x select 2)) then {_BuildingArray pushback "LFactory";};
			if ("Land_BagBunker_Large_F" isEqualTo (_x select 2)) then {_BuildingArray pushback "HFactory";};
			if ("Land_Research_house_V1_F" isEqualTo (_x select 2)) then {_BuildingArray pushback "Airfield";};
		};
	} foreach dis_ListOfBuildings;
	
	_BuildingArray = selectRandom _BuildingArray;
	
	
	switch (_BuildingArray) do {
			case "Barracks": { 	_TransportUnit = "B_recon_TL_F"; };
			case "LFactory": { 	_TransportUnit = "B_T_APC_Wheeled_01_cannon_F"; };
			case "HFactory": { 	_TransportUnit = "B_T_APC_Tracked_01_rcws_F"; };
			case "Airfield": { 	_TransportUnit = "B_Heli_Transport_03_unarmed_F"; };
	};	
		
	
	
	
}
else
{
	_SummedOwned = OpLandControlled + OpControlledArray;
	_Comm = Dis_EastCommander;
	
	//Lets find out what kind of units we can use to deploy the statics
	//dis_ListOfBuildings = [[E_Barracks,[10,20,0,25],"Land_i_Barracks_V2_F"],[E_LightFactory,[20,40,0,50],"Land_MilOffices_V1_F"],[E_StaticBay,[15,25,0,20],"Land_Shed_Big_F"][E_HeavyFactory,[40,60,0,100],"Land_dp_smallFactory_F"],[E_Airfield,[80,120,0,200],"Land_Hangar_F"],[E_MedicalBay,[15,25,0,30],"Land_Research_house_V1_F"]];
	private _BuildingArray = [];
	{
		if (_x select 0) then
		{
			if ("Land_Cargo_House_V1_F" isEqualTo (_x select 2)) then {_BuildingArray pushback "Barracks";};
			if ("Land_Research_HQ_F" isEqualTo (_x select 2)) then {_BuildingArray pushback "LFactory";};
			if ("Land_BagBunker_Large_F" isEqualTo (_x select 2)) then {_BuildingArray pushback "HFactory";};
			if ("Land_Research_house_V1_F" isEqualTo (_x select 2)) then {_BuildingArray pushback "Airfield";};
		};
	} foreach dis_EListOfBuildings;
	
	_BuildingArray = selectRandom _BuildingArray;
	
	
	switch (_BuildingArray) do {
			case "Barracks": { 	_TransportUnit = "O_engineer_F"; };
			case "LFactory": { 	_TransportUnit = "O_APC_Wheeled_02_rcws_F"; };
			case "HFactory": { 	_TransportUnit = "O_APC_Tracked_02_cannon_F"; };
			case "Airfield": { 	_TransportUnit = "O_Heli_Transport_04_box_F"; };
	};	
	
	
	
};


_DefencePos = [0,0,0];

//CompleteTaskResourceArray pushback [_Pole,[_CashFlowRandom,_PowerFlowRandom,_OilFlowRandom,_MaterialsFlowRandom],_Loc,_Pos];	
_MDefenceArray = [];
{
	if (!((_x select 0) in _SummedOwned)) then
	{
		_MDefenceArray pushback (_x select 0);
	};	
} foreach CompleteTaskResourceArray;


//CompleteRMArray pushback [_Marker,_FinalSelection,_x,false,_location];	
{
	if (!((_x select 2) in _SummedOwned)) then
	{
		_MDefenceArray pushback (_x select 4);
	};	
} foreach CompleteRMArray;
	

//Finally we arrive at the location we want to defend..._DefencePos		

private _CE = _Comm call dis_ClosestEnemy;
_SpawnLocation = ([_MDefenceArray,_CE,true] call dis_closestobj);
_BestAreaArray = selectBestPlaces [_SpawnLocation, 500, "meadow + 2*hills", 1, 5];

//Lets pick a random area to have a squad move to. They will 'deploy' the defences if they make it alive.


_FinalSelect = (selectRandom _BestAreaArray) select 0;


_grp = createGroup _Side;_grp setVariable ["DIS_IMPORTANT",true];
if (_TransportUnit isKindOf "MAN") then
{
	_unit = _grp createUnit [_TransportUnit,(getpos _Comm), [], 0, "FORM"];
	_unit addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled;}];
	[_unit] joinSilent _grp;
}
else
{
	_Unit = _TransportUnit createVehicle (getpos _Comm);
	createVehicleCrew _Unit;
	{[_x] joinsilent _grp} forEach crew _Unit;
};

_unit domove _FinalSelect;
_waypoint = _grp addwaypoint[_FinalSelect,50,1];
_waypoint setwaypointtype "MOVE";
_waypoint setWaypointBehaviour "SAFE";
_waypoint = _grp addwaypoint[_FinalSelect,50,1];
_waypoint setwaypointtype "MOVE";
_waypoint setWaypointBehaviour "SAFE";	

if (_WestRun) then
{
	[
	[_Unit],
	{
		_Unit = _this select 0;
		_Marker = createMarkerLocal [format ["ID_%1",_Unit],[0,0,0]];
		_Marker setMarkerTextLocal format ["%1","Static Deployment Unit"];	
		_Marker setMarkerTypeLocal "b_installation";
		_Marker setMarkerShapeLocal 'ICON';
		_Marker setMarkerColorLocal "ColorBlue";
		_Marker setMarkerSizeLocal [0.25,0.25];
		
		if (isServer) then {[West,_Marker,_Unit,"StaticDeploy"] call DIS_fnc_mrkersave; };
		if (hasInterface) then
		{
			waitUntil {alive player};
			if (playerSide isEqualTo West) then
			{
				_Marker setMarkerAlphaLocal 1;
			}
			else
			{
				_Marker setMarkerAlphaLocal 0;
			};
			
			while {(alive _Unit) && {!(isNull _Unit)}} do
			{
				_Marker setMarkerPosLocal (getposASL _Unit);
				_Marker setMarkerDirLocal (getdir _Unit);	
				sleep 10;
			};
			sleep 5;
			deleteMarker _Marker;
		};
	}
	
	] remoteExec ["bis_fnc_Spawn",0];


	_AddNewsArray = ["Static Defence Deployment",format 
	[
	"
	We are deploying troops to fortify strategic positions now. Make sure the transport stays alive until they can reach their position.<br/>
	"
	
	,"Hai"
	]
	];
	dis_WNewsArray pushback _AddNewsArray;
	publicVariable "dis_WNewsArray";
	
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",West];	

 	
}
else
{
	[
	[_Unit],
	{
		_Unit = _this select 0;
		_Marker = createMarkerLocal [format ["ID_%1",_Unit],[0,0,0]];
		_Marker setMarkerTextLocal format ["%1","Static Deployment Unit"];	
		_Marker setMarkerTypeLocal "o_installation";
		_Marker setMarkerShapeLocal 'ICON';
		_Marker setMarkerColorLocal "ColorRed";
		_Marker setMarkerSizeLocal [0.25,0.25];
		
		if (isServer) then {[East,_Marker,_Unit,"StaticDeploy"] call DIS_fnc_mrkersave; };
		if (hasInterface) then
		{
			waitUntil {alive player};
			if (playerSide isEqualTo East) then
			{
				_Marker setMarkerAlphaLocal 1;
			}
			else
			{
				_Marker setMarkerAlphaLocal 0;
			};				
			
			while {(alive _Unit) && {!(isNull _Unit)}} do
			{
				_Marker setMarkerPosLocal (getposASL _Unit);
				_Marker setMarkerDirLocal (getdir _Unit);	
				sleep 10;
			};
			sleep 5;
			deleteMarker _Marker;
		};
	}
	
	] remoteExec ["bis_fnc_Spawn",0]; 

	_AddNewsArray = ["Static Defence Deployment",format 
	[
	"
	We are deploying troops to fortify strategic positions now. Make sure the transport stays alive until they can reach their position.<br/>
	"
	
	,"Hai"
	]
	];
	dis_ENewsArray pushback _AddNewsArray;
	publicVariable "dis_ENewsArray";
	
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",East];	
	
	
};



[_grp,_waypoint,_Unit] spawn dis_StaticBuild;

