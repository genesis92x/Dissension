						
						
						
						
						
						
						
						
							{
								deleteVehicle _x;
								true;
							} count (_Building getVariable ["DIS_SupplyPhys",[]]);
							_Building setVariable ["DIS_SupplyPhys",[]];
							_Building setVariable ["DIS_TotalSP",0];

							
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