//This function will manage creating markers for all groups to see.
//fn_markerdisplay
sleep 1;
while {true} do
{
	sleep 25;
	{
		private _leader = (leader _x);
		private _NearestEnemy = _leader findNearestEnemy _leader;	
			if !(isNull _NearestEnemy) then 
			{
				private _PassVariable = (group _leader) getVariable ["DIS_MARKERSHOWN",false];		
				if !(_PassVariable) then
				{
				private _ka = _leader knowsAbout _NearestEnemy;			
				if (_ka > 3) then
				{
					(group _leader) setVariable ["DIS_MARKERSHOWN",true];
					(group _leader) spawn {sleep 180;_this setVariable ["DIS_MARKERSHOWN",false];};							
					[
					[_leader,_NearestEnemy],
					{
						private _leader = _this select 0;
						private _NearestEnemy = _this select 1;						
						_groupID = groupID (group _leader);
						_groupID2 = groupID (group _NearestEnemy);						
						if (player in (units (group _leader))) then
						{
							Color_For_Icon3d = [0,0,0,0];
							private _LPos = getPosASL _NearestEnemy;		
							if (side _NearestEnemy isEqualTo West) then {Color_For_Icon3d = [0.14,0.41,0.96,0.7];};
							if (side _NearestEnemy isEqualTo East) then {Color_For_Icon3d = [0.93,0.14,0,0.7];};
							if (side _NearestEnemy isEqualTo Resistance) then {Color_For_Icon3d = [0.02,1,0.1,0.7];};


							Texture_For_Icon3d="\a3\ui_f\data\GUI\Cfg\CommunicationMenu\instructor_ca";
							Width_For_Icon3d=0.5;
							Height_For_Icon3d=0.5;
							Size_For_Icon3d_Text=0.0315;
							Font_For_Icon3d="TahomaB";
							DIS_SquadEngage1 = _groupID;
							DIS_SquadEngage2 = _groupID2;
							["DIS_ID", "onEachFrame", 
							{
								
							
								
									
								if !(hasInterface) exitwith {};	
								_wPos = screenToWorld [0.5,0.75];
								drawIcon3D [Texture_For_Icon3d, Color_For_Icon3d, _wPos, Width_For_Icon3d, Height_For_Icon3d, 0,format ["%1 VS %2",DIS_SquadEngage1,DIS_SquadEngage2], 1, Size_For_Icon3d_Text, Font_For_Icon3d];
								
								
									
							}] call BIS_fnc_addStackedEventHandler;
							sleep 12;
							["DIS_ID", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
							

						};
						if (player distance _leader < 800) then
						{
							systemchat format ["%1 is engaging %2!!!",_groupID,_groupID2];
						};
					}
					
					] remoteExec ["bis_fnc_Spawn",0]; 				
				};
			};
		};
	
	} foreach allgroups;

};