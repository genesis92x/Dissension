//This function loads a saved game.
//_Array =  profileNameSpace setVariable[format["DIS_SG_%1",_CurrentMap],[[_WOwnedGrids,_WOwnedTowns,_WBuildingList,W_RArray,Dis_BluforTickets,_WComPos],[_EOwnedGrids,_EOwnedTowns,_EBuildingList,E_RArray,Dis_OpforTickets,_EComPos]]];	
params ["_Side","_Array"];

if (_Side isEqualTo West) then
{
	private _WOwnedGrids = _Array select 0;
	private _WOwnedTowns = _Array select 1;
	private _WBuildingList = _Array select 2;
	W_RArray = _Array select 3;
	Dis_BluforTickets = _Array select 4;
	private _WComPos = _Array select 5;
	
	//For grids
	//CompleteRMArray pushBackUnique [_Marker,_FinalSelection,_x,false,_location,_SafePosSpwn];
	{
		private _MrkPosA = (_x select 2);
		private _location = (_x select 4);
		private _Clst = [_WOwnedGrids,_MrkPosA,true] call dis_closestobj;
		
		//So if the closest position is less than 2, then we can assume that the position is owned by this side.
		if (_Clst distance2D (getMarkerPos _MrkPosA) < 2) then
		{
			[
			[_MrkPosA,West],
			{
					params ["_MrkPosA","_Side"];
					
					if (playerSide isEqualTo _Side) then
					{
						_MrkPosA setMarkerColorLocal "ColorBlue";
						_MrkPosA setMarkerAlphaLocal 0.3;
					}
					else
					{
						if (getMarkerColor _MrkPosA isEqualTo "ColorRed") then
						{
							_MrkPosA setMarkerColorLocal "ColorBlue";					
							_MrkPosA setMarkerAlphaLocal 0.3;
						};
					};
			}
			
			] remoteExec ["bis_fnc_Spawn",0];											
			
			if !(_MrkPosA in BluLandControlled) then {BluLandControlled pushBack _MrkPosA;};		
			if (_MrkPosA in IndLandControlled) then {IndLandControlled = IndLandControlled - [_MrkPosA];};
			_location setVariable ["DIS_Capture",[30,30,West],true];			
		};
	} forEach	CompleteRMArray;
	
	//For towns
	//_NewArray = [_marker1Names,_locationName,_FlagPole,_marker1,0,0,0,false,40,_FinalStrongholds];
	{
		private _PolePosA = (_x select 2);
		private _Mrker = (_x select 3);
		private _OriginalAmount = (_x select 8);
		private _Clst = [_WOwnedTowns,_PolePosA,true] call dis_closestobj;
		
		//So if the closest position is less than 2, then we can assume that the position is owned by this side.
		if (_Clst distance2D _PolePosA < 2) then
		{
			[
				[_Mrker],
				{
					if (playerSide isEqualTo West) then
					{				
					params ["_Mrker"];
					_Mrker setMarkerColorLocal "ColorBlue";
					_Mrker setMarkerAlphaLocal 1;
					};
				}
				
			] remoteExec ["bis_fnc_Spawn",0];									
			
			
			if !(_PolePosA in BluControlledArray) then {BluControlledArray pushback _PolePosA;};			
			if (_PolePosA in IndControlledArray) then {IndControlledArray = IndControlledArray - [_PolePosA];};								
			_PolePosA setVariable ["DIS_Capture",[(_OriginalAmount + 20),(_OriginalAmount + 20),west],true];		
		};
	} forEach TownArray;
	
	
	//For buildings
	//W_BuildingList pushback [_b,"Barracks"];
	//_WBuildingList pushback [_Pos,_Type,_PID];
	//_WBuildingList pushback [_Pos,_Type,_PID,_PhysicalObj,_Player];

	{
		private _Pos = _x select 0;
		private _Type = _x select 1;
		private _PID = _x select 2;
		if (_PID isEqualTo "") then
		{
			W_RArray set [0,((W_RArray select 0) + 400)];
			W_RArray set [1,((W_RArray select 1) + 400)];
			W_RArray set [2,((W_RArray select 2) + 400)];
			W_RArray set [3,((W_RArray select 3) + 400)];
			//[false,[10,20,0,25],"Land_Cargo_House_V1_F"]
			[[false,[0,0,0,0],_Type],West,_Pos] spawn dis_createbuilding;
		}
		else
		{
			private _PhysicalObj = _x select 3;
			private _Player = _x select 4;
			private _Dir = _x select 5;
			private _Vector = _x select 6;
			[_Pos,_PhysicalObj,_Type,_PID,_Player,West,_Dir,_Vector] call DIS_fnc_PlayerStrcLoad;
		};
	} forEach _WBuildingList;
	
	DIS_WestCommander setpos _WComPos;
	publicVariable "IndControlledArray";
	publicVariable "BluControlledArray";
	publicVariable "BluLandControlled";
	publicVariable "IndLandControlled";
}
else
{
	
	private _EOwnedGrids = _Array select 0;
	private _EOwnedTowns = _Array select 1;
	private _EBuildingList = _Array select 2;
	E_RArray = _Array select 3;
	Dis_OpforTickets = _Array select 4;
	private _EComPos = _Array select 5;
	
	//For grids
	//CompleteRMArray pushBackUnique [_Marker,_FinalSelection,_x,false,_location,_SafePosSpwn];
	{
		private _MrkPosA = (_x select 2);
		private _location = (_x select 4);
		private _Clst = [_EOwnedGrids,_MrkPosA,true] call dis_closestobj;
		
		//So if the closest position is less than 2, then we can assume that the position is owned by this side.
		if (_Clst distance2D (getMarkerPos _MrkPosA) < 2) then
		{
			[
			[_MrkPosA,East],
			{
					params ["_MrkPosA","_Side"];
					
					if (playerSide isEqualTo _Side) then
					{
						_MrkPosA setMarkerColorLocal "ColorRed";
						_MrkPosA setMarkerAlphaLocal 0.3;
					}
					else
					{
						if (getMarkerColor _MrkPosA isEqualTo "ColorBlue") then
						{
							_MrkPosA setMarkerColorLocal "ColorRed";					
							_MrkPosA setMarkerAlphaLocal 0.3;
						};
					};
			}
			
			] remoteExec ["bis_fnc_Spawn",0];											
			
			if !(_MrkPosA in OpLandControlled) then {OpLandControlled pushBack _MrkPosA;};		
			if (_MrkPosA in IndLandControlled) then {IndLandControlled = IndLandControlled - [_MrkPosA];};
			_location setVariable ["DIS_Capture",[30,30,East],true];			
		};
	} forEach CompleteRMArray;
	
	//For towns
	//_NewArray = [_marker1Names,_locationName,_FlagPole,_marker1,0,0,0,false,40,_FinalStrongholds];
	{
		private _PolePosA = (_x select 2);
		private _Mrker = (_x select 3);
		private _OriginalAmount = (_x select 8);
		private _Clst = [_EOwnedTowns,_PolePosA,true] call dis_closestobj;
		
		//So if the closest position is less than 2, then we can assume that the position is owned by this side.
		if (_Clst distance2D _PolePosA < 2) then
		{
			[
				[_Mrker],
				{
					if (playerSide isEqualTo East) then
					{							
					params ["_Mrker"];
					_Mrker setMarkerColorLocal "ColorRed";
					_Mrker setMarkerAlphaLocal 1;
					};
				}
				
			] remoteExec ["bis_fnc_Spawn",0];									
			
			
			if !(_PolePosA in OpControlledArray) then {OpControlledArray pushback _PolePosA;};			
			if (_PolePosA in IndControlledArray) then {IndControlledArray = IndControlledArray - [_PolePosA];};								
			_PolePosA setVariable ["DIS_Capture",[(_OriginalAmount + 20),(_OriginalAmount + 20),East],true];		
		};
	} forEach TownArray;
	
	
	//For buildings
	//W_BuildingList pushback [_b,"Barracks"];
	//_WBuildingList pushback [_Pos,_Type,_PID];
	//_WBuildingList pushback [_Pos,_Type,_PID,_PhysicalObj,_Player];

	{
		private _Pos = _x select 0;
		private _Type = _x select 1;
		private _PID = _x select 2;
		if (_PID isEqualTo "") then
		{
			//[false,[10,20,0,25],"Land_Cargo_House_V1_F"]
			E_RArray set [0,((E_RArray select 0) + 400)];
			E_RArray set [1,((E_RArray select 1) + 400)];
			E_RArray set [2,((E_RArray select 2) + 400)];
			E_RArray set [3,((E_RArray select 3) + 400)];			
			[[false,[0,0,0,0],_Type],East,_Pos] spawn dis_createbuilding;
		}
		else
		{
			private _PhysicalObj = _x select 3;
			private _Player = _x select 4;
			private _Dir = _x select 5;
			private _Vector = _x select 6;
			[_Pos,_PhysicalObj,_Type,_PID,_Player,East,_Dir,_Vector] call DIS_fnc_PlayerStrcLoad;
		};
	} forEach _EBuildingList;
	
	DIS_EastCommander setpos _EComPos;
	
	publicVariable "OpLandControlled";
	publicVariable "IndLandControlled";
	publicVariable "IndControlledArray";
	publicVariable "OpControlledArray";
	
	
	
	
};