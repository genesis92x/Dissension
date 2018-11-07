//This function will save the current status of the server
//Saved variables, per side:
//
//[[CURRENT GRIDS, CURRENT TOWNS, CURRENT STRUCTURES, CURRENT RESOURCES, CURRENT TICKETS,COMMANDER POS]]
//
//This system is experimental, Due to the nature of auto generated markers/territory we have to go off a coordinates based system to save the data. Markers/towns are NOT consistently named.
//As a result, we will have to pull the closest town/grid marker from these current coordinates and then convert them to the appropriate side.


private _CurrentMap = worldName;

//West side first 
private _WOwnedGrids = [];
{
	_WOwnedGrids pushBack (getMarkerPos _x);
} foreach BluLandControlled;

private _WOwnedTowns = [];
{
	_WOwnedTowns pushBack (getPosASL _x);
} forEach BluControlledArray;
	

//The most complicated aspect of a save function is going to be the building system
//We have to consider all AI built structures...and more importantly... all player built structures
//W_BuildingList pushback [_b,format ["%1",_StructureName]];
private _WBuildingList = [];
{
	private _PhysicalObj = _x select 0;
	private _Pos = getPosATL _PhysicalObj;
	private _PreType = _x select 1;
	private _PID = _x select 2;
	private _Player = "";
	if (isNil "_PID") then 
	{
		_PID = "";
		_Player = "";		
	}
	else
	{
		_Player = _x select 3;
	};
	
	private _Type = "";
	
	if (_PID isEqualTo "") then 
	{
		switch (_PreType) do 
		{
				case "Barracks": 
				{
					_Type = "Land_Cargo_House_V1_F";
				};
				case "Light Factory": 
				{
					_Type = "Land_Research_HQ_F";		
				};
				case "Static Bay": 
				{
					_Type = "Land_Cargo_House_V3_F";		
				};
				case "Heavy Factory": 
				{
					_Type = "Land_BagBunker_Large_F";	
				};
				case "Air Field": 
				{
					_Type = "Land_Research_house_V1_F";
				};
				case "Medical Bay": 
				{
					_Type = "Land_Medevac_house_V1_F";		
				};	
				case "Advanced Infantry Barracks": 
				{
					_Type = "Land_Bunker_F";		
				};			
		};	
		if !(_PreType isEqualTo "COMMANDER") then
		{		
			_WBuildingList pushback [_Pos,_Type,_PID,(typeOf _PhysicalObj),_Player];
		};
	}
	else
	{
		_Type = _PreType;
		_WBuildingList pushback [_Pos,_Type,_PID,(typeOf _PhysicalObj),_Player,(getDir _PhysicalObj),(vectorUp _PhysicalObj)];
	};

} foreach W_BuildingList;	

//W_RArray
//Dis_BluforTickets
	
private _WComPos = getPosATL DIS_WestCommander;	



//East side first 
private _EOwnedGrids = [];
{
	_EOwnedGrids pushBack (getMarkerPos _x);
} forEach OpLandControlled;

private _EOwnedTowns = [];
{
	_EOwnedTowns pushBack (getPosASL _x);
} forEach OpControlledArray;
	

//The most complicated aspect of a save function is going to be the building system
//We have to consider all AI built structures...and more importantly... all player built structures
//W_BuildingList pushback [_b,format ["%1",_StructureName]];
//W_BuildingList pushback [_Object,"PHQ",_PID,_PName];
//W_BuildingList pushback [_Object,"FORTIFICATION",_PID,_PName];
private _EBuildingList = [];
{
	private _PhysicalObj = _x select 0;
	private _Pos = getPosATL _PhysicalObj;
	private _PreType = _x select 1;
	private _PID = _x select 2;
	private _Player = "";
	if (isNil "_PID") then 
	{
		_PID = "";
		_Player = "";		
	}
	else
	{
		_Player = _x select 3;
	};
	private _Type = "";
	
	if (_PID isEqualTo "") then 
	{
		switch (_PreType) do 
		{
				case "Barracks": 
				{
					_Type = "Land_Cargo_House_V1_F";
				};
				case "Light Factory": 
				{
					_Type = "Land_Research_HQ_F";		
				};
				case "Static Bay": 
				{
					_Type = "Land_Cargo_House_V3_F";		
				};
				case "Heavy Factory": 
				{
					_Type = "Land_BagBunker_Large_F";	
				};
				case "Air Field": 
				{
					_Type = "Land_Research_house_V1_F";
				};
				case "Medical Bay": 
				{
					_Type = "Land_Medevac_house_V1_F";		
				};	
				case "Advanced Infantry Barracks": 
				{
					_Type = "Land_Bunker_F";		
				};			
		};	
		
		if !(_PreType isEqualTo "COMMANDER") then
		{
			_EBuildingList pushback [_Pos,_Type,_PID,(typeOf _PhysicalObj),_Player];
		};
	}
	else
	{
		_Type = _PreType;
		_EBuildingList pushback [_Pos,_Type,_PID,(typeOf _PhysicalObj),_Player,(getDir _PhysicalObj),(vectorUp _PhysicalObj)];
	};


} forEach E_BuildingList;	

//E_RArray
//Dis_OpforTickets
	
private _EComPos = getPosATL DIS_EastCommander;	
	
	
//private _SetVariables = profileNameSpace setVariable[format["DIS_SG_%1",_CurrentMap],[DIS_PCASHNUM,DIS_Experience,DIS_PlayedDuration,DIS_KillCount,DIS_ShotsFired,DIS_Deaths,_Vrt,_BRK,_Radar]];
private _SV = profileNameSpace setVariable[format["DIS_SG_%1",_CurrentMap],[[_WOwnedGrids,_WOwnedTowns,_WBuildingList,W_RArray,Dis_BluforTickets,_WComPos],[_EOwnedGrids,_EOwnedTowns,_EBuildingList,E_RArray,Dis_OpforTickets,_EComPos]]];
saveProfileNamespace;


