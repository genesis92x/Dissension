//Function for monitoring players and when we can plant a bomb!
//We want to constantly monitor every structure and check for the nearest one

sleep 30;

waitUntil
{
	
		
		//We are constantly updating this variable due to this loop being infinite and that the variable is expected to change frequently.
		private _List = [];
		private _ETerr = [];
		private _FTerr = [];
		private _CstSqr = [0,0,0];
		if (playerSide isEqualTo East) then
		{
			_List = W_BuildingList;
			_FTerr = East call dis_compiledTerritory;
			_CstSqr = [_FTerr,player,true] call dis_closestobj;
		}
		else
		{
			_List = E_BuildingList;
			_FTerr = West call dis_compiledTerritory;
			_CstSqr = [_FTerr,player,true] call dis_closestobj;		
		};
		
		private _CList = [];
		{
			_CList pushback (_x select 0);
		} foreach _List;		
		private _Cst = [_CList,player,true] call dis_closestobj;			
		
		if (_CstSqr distance2D player < 2001 || (_Cst getVariable ["DIS_CANBLOWUP",false])) then
		{
		
			
			{
				private _s = _x select 0;
				private _n = _x select 1;

				if (_Cst distance2D player < 15 && {_s isEqualTo _Cst} && {!(_Cst getVariable ["DIS_StrB",false])} && {!(_Cst getVariable ["DIS_ActOn",false])}) then
				{
					_s setVariable ["DIS_ActOn",true];
					#define TARGET player
					#define TITLE "Plant Bomb"
					#define    ICON  ""
					#define    PROG_ICON    ""
					#define COND_ACTION "true"
					#define COND_PROGRESS "true"
					#define    CODE_START {["Calling in bomb...",'#FFFFFF'] call Dis_MessageFramework}
					#define    CODE_TICK {}
					#define 	CODE_END {["Bomb called!",'#FFFFFF'] call Dis_MessageFramework;[(_this select 0),(_this select 3 select 0)] spawn DIS_fnc_StrBomb;[player,(_this select 3 select 1)] call BIS_fnc_holdActionRemove;}
					#define    CODE_INTERUPT {["Halted calling in of bomb",'#FFFFFF'] call Dis_MessageFramework;}
					#define    ARGUMENTS [_S]
					#define    DURATION 10
					#define    PRIORITY 1
					#define    REMOVE true
					#define SHOW_UNCON false
					
					_DIS_PBombAct = [TARGET,TITLE,ICON,PROG_ICON,COND_ACTION,COND_PROGRESS,CODE_START,CODE_TICK,CODE_END,CODE_INTERUPT,ARGUMENTS,DURATION,PRIORITY,REMOVE,SHOW_UNCON] call bis_fnc_holdActionAdd;
					[_DIS_PBombAct,_s] spawn 
					{
						params ["_Id","_S"];
						while {player distance2D _S < 16} do
						{
							sleep 1;
						};
						[player,_Id] call BIS_fnc_holdActionRemove;
					};
				}
				else
				{
					_s setVariable ["DIS_ActOn",false];
				};
			
			} foreach _List;
		};
		
		
		
		private _RCList = [];
		{
			_RCList pushback (_x select 0);
		} foreach DIS_RESISTANCEASSAULTSPAWN;		
		private _RCst = [_RCList,player,true] call dis_closestobj;			
		if (Dis_debug) then {diag_log format ["DISDEBUG: NEAREST RESISTANCE STRUCTURE: %1 - %2M",_RCst,(_RCst distance2D player)];};		
		{
				private _s = _x select 0;
				private _n = _x select 1;
				if (_RCst distance2D player < 15 && {_s isEqualTo _RCst} && {!(_RCst getVariable ["DIS_StrB",false])} && {!(_RCst getVariable ["DIS_ActOn",false])}) then
				{
					_s setVariable ["DIS_ActOn",true];
					_RCst setVariable ["DIS_ActOn",true];
					#define TARGET player
					#define TITLE "Plant Bomb"
					#define    ICON  ""
					#define    PROG_ICON    ""
					#define COND_ACTION "true"
					#define COND_PROGRESS "true"
					#define    CODE_START {["Calling in bomb...",'#FFFFFF'] call Dis_MessageFramework}
					#define    CODE_TICK {}
					#define 	CODE_END {["Bomb called!",'#FFFFFF'] call Dis_MessageFramework;[(_this select 0),(_this select 3 select 0)] spawn DIS_fnc_StrBomb;[player,(_this select 3 select 1)] call BIS_fnc_holdActionRemove;}
					#define    CODE_INTERUPT {["Halted calling in of bomb",'#FFFFFF'] call Dis_MessageFramework;}
					#define    ARGUMENTS [_S]
					#define    DURATION 10
					#define    PRIORITY 1
					#define    REMOVE true
					#define SHOW_UNCON false
					
					_DIS_PBombAct = [TARGET,TITLE,ICON,PROG_ICON,COND_ACTION,COND_PROGRESS,CODE_START,CODE_TICK,CODE_END,CODE_INTERUPT,ARGUMENTS,DURATION,PRIORITY,REMOVE,SHOW_UNCON] call bis_fnc_holdActionAdd;
					[_DIS_PBombAct,_s] spawn 
					{
						params ["_Id","_S"];
						while {player distance2D _S < 16} do
						{
							sleep 1;
						};
						[player,_Id] call BIS_fnc_holdActionRemove;
					};
				}
				else
				{
					_s setVariable ["DIS_ActOn",false];
				};				
			
		} foreach DIS_RESISTANCEASSAULTSPAWN;
		
	sleep 5;
	false
};
