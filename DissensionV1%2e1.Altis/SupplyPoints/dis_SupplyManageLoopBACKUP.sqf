params ["_CSide","_Buildings"];
waitUntil {!(isNil "W_BuildingList")};
waitUntil {!(isNil "W_DistArray")};
waitUntil {!(isNil "E_DistArray")};

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
private _EnemyArray = [];
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
	_EnemyArray = W_DistArray;
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
	_EnemyArray = E_DistArray;
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
					_Building setVariable ["DIS_TotalSP",_TotalSpwn];
					private _BoxArray = _Building getVariable ["DIS_SupplyPhys",[]];
					private _Supply = "CargoNet_01_barrels_F" createVehicle (getpos _Building);
					
					//Globally create addactions for the crates.
					[
					[_Supply,_CSide],
					{
							private _Supply = _this select 0;
							private _CSide = _this select 1;

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
					_Building setVariable ["DIS_SupplyPhys",_BoxArray];
				} 
				else
				{
					//LETS HAVE A VEHICLE GO PICK UP THIS SHIIIT
					systemChat "PICKUP";
					if !(_Building getVariable ["DIS_Transporting",false]) then
					{
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
						systemChat format ["%1",_LightFactoryList];
						if (_LightFactoryList isEqualTo []) exitWith {};
						private _SpawnLoc = [_LightFactoryList,_Building,true] call dis_closestobj;
						private _SpawnPosition = getpos _SpawnLoc;
						
						
						
						
						_rnd = random 50;
						_dist = (_rnd + 25);
						_dir = random 360;
						_position = [(_SpawnPosition select 0) + (sin _dir) * _dist, (_SpawnPosition select 1) + (cos _dir) * _dist, 0];
						
						
						_list = _position nearRoads 1000;
						private _Croad = [0,0,0];
						
						if !(_list isEqualTo []) then
						{
							private _Road = [_list,_position,true] call dis_closestobj;
							_CRoad = getpos _Road;
						}
						else
						{
							_CRoad = _position;
						};
								
						private _positionFIN = _CRoad findEmptyPosition [0,150,_Vehicle];	
						if (_positionFIN isEqualTo []) then {_positionFIN = _CRoad};						
											
						_SupplyRun = createVehicle [_Vehicle,_positionFIN, [], 50, "FLY"];
						_SupplyRun lock true;
						_grp = creategroup _CSide;
						createVehicleCrew _SupplyRun;			
						{[_x] joinsilent _grp} forEach crew _SupplyRun;
						
						{
							_x setVariable ["NOAI",true];			
							_x disableAI "TARGET";
							_x disableAI "AUTOTARGET";
							_x disableAI "AIMINGERROR";
							_x disableAI "SUPPRESSION";
							_x disableAI "CHECKVISIBLE";
							_x disableAI "COVER";
							_x disableAI "AUTOCOMBAT";
						} foreach (crew _SupplyRun);
						
						(driver _SupplyRun) doMove (getpos _Building);
						(driver _SupplyRun) flyInHeight 50;
						[_SupplyRun,_SpawnPosition,(getpos _Building)] spawn 
						{
							params ["_Veh","_Pos","_WPos"];
							while {alive _Veh && _Veh distance _WPos > 125} do
							{
								sleep 5;
							};
							(driver _Veh) doMove _Pos;
						};
						private _wp = _grp addwaypoint [(getpos _Building),0];
						_wp setwaypointtype "MOVE";
						_wp setWaypointSpeed "NORMAL";
						_wp setWaypointBehaviour "SAFE";								
						private _wp2 = _grp addwaypoint[_SpawnPosition,0];
						_wp2 setwaypointtype "MOVE";
						_wp2 setWaypointSpeed "NORMAL";
						_wp2 setWaypointBehaviour "SAFE";
						_wp setWaypointCompletionRadius 125;						
						_wp2 setWaypointCompletionRadius 125;						
						
						
						[_SupplyRun,_SpawnPosition,_Building] spawn
						{
							private _Veh = _this select 0;
							private _SpawnPos = _this select 1;						
							private _Building = _this select 2;						
							private _BuildingPos = getpos _Building;						
							waitUntil {_Veh distance _BuildingPos < 125 || !(alive _Veh)};
							
							{
								deleteVehicle _x;
								true;
							} count (_Building getVariable ["DIS_SupplyPhys",[]]);
							_Building setVariable ["DIS_SupplyPhys",[]];
							_Building setVariable ["DIS_TotalSP",0];
							
							sleep 10;
							waitUntil {_Veh distance _SpawnPos < 125 || !(alive _Veh)};
							
							if (alive _Veh) then
							{
								if (Side _Veh isEqualTo West) then
								{
									W_RArray set [0,(W_RArray select 0) + 75];
									W_RArray set [1,(W_RArray select 1) + 75];
									W_RArray set [2,(W_RArray select 2) + 75];
									W_RArray set [3,(W_RArray select 3) + 75];							
								}
								else
								{
									E_RArray set [0,(E_RArray select 0) + 75];
									E_RArray set [1,(E_RArray select 1) + 75];
									E_RArray set [2,(E_RArray select 2) + 75];
									E_RArray set [3,(E_RArray select 3) + 75];							
								};
								{deletevehicle _x; true;} count crew _Veh;								
								deleteVehicle _Veh;
							};
							_Building setVariable ["DIS_Transporting",false];
						};				
						
						
						//Create a marker for friendlies on the appropriate side
						[
						[_SupplyRun,_color],
						{
								private _SupplyRun = _this select 0;
								private _color = _this select 1;
								private _Marker = createMarkerLocal [format ["ID_%1",_SupplyRun],[0,0,0]];
								_Marker setMarkerColorLocal _color;
								_Marker setMarkerAlphaLocal 1;
								_Marker setMarkerSizeLocal [0.5,0.5];			
								_Marker setMarkerShapeLocal 'ICON';		
								_Marker setMarkerTypeLocal "c_car";
								_Marker setMarkerTextLocal "Supply Vehicle";				
								while {alive _SupplyRun} do
								{
									_Marker setMarkerPosLocal (getposASL (_SupplyRun));
									_Marker setMarkerDirLocal (getdir (_SupplyRun));										
									sleep 2;
								};
								sleep 5;
								deleteMarker _Marker;			
					
						}
						
						] remoteExec ["bis_fnc_Spawn",_CSide]; 						
						
						
						
						
						
						
					};
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
				};
				
				
				
				true;
			} count _SPArray;
			
		};
		
		sleep 300;		
	};
