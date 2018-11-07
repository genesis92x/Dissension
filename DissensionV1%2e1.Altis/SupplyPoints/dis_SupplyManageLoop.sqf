params ["_CSide","_SupplyStructure"];

waitUntil {!(isNil "W_BuildingList")};
waitUntil {!(isNil "E_BuildingList")};

//W_SupplyP = [];
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
private _camps = [];
private _WestRun = false;
private _Vehicle = ObjNull;
private _ESide = [];
private _Building = [];

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
	_camps = W_GuerC;	
	_Color = "ColorBlue";
	_WestRun = true;
	_Vehicle = "B_Heli_Transport_03_unarmed_F";
	_ESide = East;	

}
else
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
	_camps = E_GuerC;	
	_Color = "ColorRed";
	_WestRun = false;
	_Vehicle = "O_Heli_Transport_04_F";	
	_ESide = West;	

};
	
	private _SPArray = [];

	while {true} do
	{
		//Make sure we are using the right supply point list.
		if (_WestRun) then {_SPArray = W_SupplyP;_Buildinglist = W_BuildingList;} else {_SPArray = E_SupplyP;_Buildinglist = E_BuildingList;};
		
		//Lets go through the array and provide 1 barrel. 1 barrel equals 15 of each resource.
		if !(_SPArray isEqualTo []) then 
		{
			{
				//Pull the building tied to the location
				private _Building = _x getVariable ["DIS_SP",objNull];
				//Pull the total supplies from the building.
				private _TotalSpwn = _Building getVariable ["DIS_TotalSP",0];
				
				//If the total supply barrels is under 5, then spawn another barrel. Else, it's time to take the barrels home!
				if (_TotalSpwn < 5) then
				{
					_TotalSpwn = _TotalSpwn + 1;
					_Building setVariable ["DIS_TotalSP",_TotalSpwn,true];
					private _BoxArray = _Building getVariable ["DIS_SupplyPhys",[]];
					private _Supply = "B_supplyCrate_F" createVehicle (getpos _Building);
					
					//Globally create addactions for the crates.
					[
					[_Supply,_CSide,_Building],
					{
							private _Supply = _this select 0;
							private _CSide = _this select 1;
							private _Building = _this select 2;
							
							private _SupplyPhys = _Building getVariable ["DIS_SupplyPhys",[]];
							private _TotalSpwn = _Building getVariable ["DIS_TotalSP",0];
							
							_SupplyPhys = _SupplyPhys - [_Supply];
							_Building setVariable ["DIS_SupplyPhys",_SupplyPhys,true];
							_Building setVariable ["DIS_TotalSP",(_TotalSpwn - 1),true];
							
							
							_Supply addAction ["<t color='#20FF27'>Claim Supplies</t>",
							{
								if (_this select 3 isEqualTo West) then
								{
									E_RArray set [0,(W_RArray select 0) + 15];
									E_RArray set [1,(W_RArray select 1) + 15];
									E_RArray set [2,(W_RArray select 2) + 15];
									E_RArray set [3,(W_RArray select 3) + 15];
									DIS_PCASHNUM = DIS_PCASHNUM + 350;
									deletevehicle (_this select 0);
								}
								else
								{
									W_RArray set [0,(W_RArray select 0) + 15];
									W_RArray set [1,(W_RArray select 1) + 15];
									W_RArray set [2,(W_RArray select 2) + 15];
									W_RArray set [3,(W_RArray select 3) + 15];	
									DIS_PCASHNUM = DIS_PCASHNUM + 350;
									deletevehicle (_this select 0);		
								};
							}
							,_CSide
							];
							
							_Supply addAction ["<t color='#EEF916'>Check Supplies</t>",
							{
								player playMoveNow "AmovPercMstpSnonWnonDnon_Scared2";
								sleep 10;
								systemChat "These supplies are safe. Take them to further your cause!";
							}];								
							
					}
					
					] remoteExec ["bis_fnc_Spawn",_ESide]; 					
					
					
					_Supply enableSimulationGlobal false;
					_BoxArray pushback _Supply;
					_Building setVariable ["DIS_SupplyPhys",_BoxArray,true];
				} 
				else
				{
					//LETS HAVE A VEHICLE GO PICK UP THIS SHIIIT
					if !(_Building getVariable ["DIS_Transporting",false]) then
					{
						//The Supply Point is now full and needs transportation back to the nearest structure. We want to make it not request transport multiple times.
						_Building setVariable ["DIS_Transporting",true,true];
						
						
						//Lets separate all our buildings so we know where to spawn our units.
						private _LightFactoryList = [];
						private _LFactorySwitch = false;
						private _LList = [];
						
						{
							_Phy = _x select 0;
							_Name = _x select 1;
							if (_Name isEqualTo "Light Factory") then {_LightFactoryList pushback (_x select 0);_LFactorySwitch = true;_LList pushback _LFactU;};
							if (_Name isEqualTo "Barracks") then {_LightFactoryList pushback (_x select 0);_LFactorySwitch = true;_LList pushback _LFactU;};
							true;
						} count _Buildinglist;					
						
						if (_LightFactoryList isEqualTo []) exitWith {};
						systemchat format ["FACTORY LIST: %1",_LightFactoryList];
						private _ReturnLoc = [_LightFactoryList,_Building,true] call dis_closestobj;
						private _ReturnLocPos = getpos _ReturnLoc;					
						systemchat format ["FACTORY LIST _ReturnLocPos: %1",_ReturnLocPos];
						//Create a marker for friendlies on the appropriate side
						[
						[_Building,_color,_Cside],
						{
								params ["_Building","_color","_Cside"];
								private _Marker = createMarkerLocal [format ["ID_%1-%2",_Building,(random 1000)],[0,0,0]];
								_Marker setMarkerColorLocal "ColorYellow";
								_Marker setMarkerSizeLocal [1,1];			
								_Marker setMarkerShapeLocal 'ICON';		
								_Marker setMarkerTypeLocal "c_car";
								_Marker setMarkerTextLocal "SUPPLY POINT FULL";
								_MPos = (getposASL (_Building));
								_Marker setMarkerPosLocal [_MPos select 0,(_MPos select 1) + 1];
								_Marker setMarkerDirLocal (getdir (_Building));
								_Building setVariable ["DIS_SupplyM",_Marker];
								
								if (playerSide isEqualTo _Cside) then
								{
									_Marker setMarkerAlphaLocal 1;
								}
								else
								{
									_Marker setMarkerAlphaLocal 0;
								};	

								
								if (isServer) then {[_Cside,_Marker,_Building,"Supply Point"] call DIS_fnc_mrkersave; };
								
						
								while {alive _Building && {(_Building getVariable ["DIS_Transporting",false])}} do
								{							
									sleep 10;
								};
								sleep 5;
								deleteMarker _Marker;			
					
						}
						
						] remoteExec ["bis_fnc_Spawn",0];							
	
						
						
						
						
						
						
						
						
						if (_WestRun) then 
						{
							_cnt = {(side _x) isEqualTo West} count allPlayers;
							if (_cnt > 0) then
							{
								//[TITLE,DESCRIPTION,CURRENTLY ASSIGNED GROUP,[VAR1,VAR2,VAR3]];
								DIS_MissionID = DIS_MissionID + 1;
								W_PlayerMissions pushback ['SUPPLY POINT',format ['The supply point, located at %1, is full and needs transport to the nearest structure.',(mapGridPosition _Building)],[(netId _Building),_ReturnLocPos],[],DIS_MissionID];
								publicVariable "W_PlayerMissions";
							}
							else
							{
								sleep 1800;
								_Resources = _Building getVariable ["DIS_SupplyPhys",[]];
								if (count _Resources > 0) then
								{
									{
										deleteVehicle _x;
										true;
									} count _Resources;
									_Building setVariable ["DIS_SupplyPhys",[],true];
									_Building setVariable ["DIS_TotalSP",0,true];
									W_RArray set [0,(W_RArray select 0) + 200];
									W_RArray set [1,(W_RArray select 1) + 200];
									W_RArray set [2,(W_RArray select 2) + 200];
									W_RArray set [3,(W_RArray select 3) + 200];	
									_Building setVariable ["DIS_Transporting",false,true];
									publicvariable "W_RArray";										
								};
							
							};
						}
						else
						{
							_cnt = {(side _x) isEqualTo East} count allPlayers;
							if (_cnt > 0) then
							{						
								DIS_MissionID = DIS_MissionID + 1;
								E_PlayerMissions pushback ['SUPPLY POINT',format ['The supply point, located at %1, is full and needs transport to the nearest structure.',(mapGridPosition _Building)],[(netId _Building),_ReturnLocPos],[],DIS_MissionID];				
								publicVariable "E_PlayerMissions";
							}
							else
							{
								sleep 1800;
								_Resources = _Building getVariable ["DIS_SupplyPhys",[]];
								if (count _Resources > 0) then
								{
									{
										deleteVehicle _x;
										true;
									} count _Resources;
									_Building setVariable ["DIS_SupplyPhys",[],true];
									_Building setVariable ["DIS_TotalSP",0,true];
									E_RArray set [0,(E_RArray select 0) + 200];
									E_RArray set [1,(E_RArray select 1) + 200];
									E_RArray set [2,(E_RArray select 2) + 200];
									E_RArray set [3,(E_RArray select 3) + 200];	
									_Building setVariable ["DIS_Transporting",false,true];
									publicvariable "E_RArray";										
								};
							
							};							
							
							
							
						};
		


						
					};
					
					
					
				
					
					
					
					
					
					
					
					
					
					
					
					
					
					
				};
				
				
				
				true;
			} count _SPArray;
			
		};
		//The supply point becomes full within 1hour 30 minutes
		sleep 1080;
	};

