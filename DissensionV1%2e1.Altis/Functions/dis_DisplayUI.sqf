//This script will function as a way to display important information to the players.


//Get players side.
private _Side = (side (group player));
waitUntil {!isNil "W_RArray"};

//2005 cutRsc ["dis_Info", "PLAIN", 0];
disableSerialization;		

//_display = uiNamespace getVariable "dis_Info_display";
//_infoLine  = _display displayCtrl 9701;
//_ticketsdisplay  = _display displayCtrl 9702;
//_Capturepercent  = _display displayCtrl 1000;
waitUntil {!(isNil "DIS_WPEINFO")};
waitUntil {!(isNil "DIS_EPEINFO")};

private _AttackedInfo = "";
waitUntil
{
	if (alive player) then
	{
			if (playerSide isEqualTo west) then {_AttackedInfo = DIS_WPEINFO;} else {_AttackedInfo = DIS_EPEINFO;};
			private _CaptureArray = [];
			{
				_CaptureArray pushback (_x select 0);
			} foreach CompleteTaskResourceArray;
			//private _NO = [_CaptureArray,player,true] call dis_closestobj;
			private _NO = _AttackedInfo;
			
			private _Ratio = _NO getVariable ["DIS_Capture",[1,1,resistance]];
			private _AttackerArray = _NO getVariable ["DIS_Captureattacker",[-1000,-1000,resistance]];
			private _AttackerTickets = _AttackerArray select 1;

			
			if !(_AttackerTickets isEqualTo -1000) then
			{
				20055 cutRsc ["Dis_TownProgress", "PLAIN", 0];
				_control = (uiNamespace getVariable "Dis_TownProgress_Bar") displayCtrl 11;
				_SideText  = (uiNamespace getVariable "Dis_TownProgress_Bar") displayCtrl 1100;			
				private _Original = _Ratio select 0;
				private _Current = _Ratio select 1;	
				private _Side = _Ratio select 2;			
				if (_Current < 0) then {_Current = 0};
				private _FinalMarkerTG = "";
				private _LocName = "";				
				{
					private _T = _x select 0;
					if (_NO isEqualTo _T) exitWith 
					{
						_FinalMarkerTG = (_x select 4);
						_LocName = (_x select 2);
					};					
				} foreach CompleteTaskResourceArray;
				
				_control progressSetPosition (_Current/_Original);
				private _DefendingSide = _LocName;
				private _color = '';
				if (_Side isEqualTo Resistance) then {_control ctrlSetTextColor [0.09,1,0.16,1];_DefendingSide = _LocName;_color = '#1DAB00';};
				if (_Side isEqualTo East) then {_control ctrlSetTextColor [1,0.18,0.03,1];_DefendingSide = _LocName;_color = '#FE1C07';if (side (group player) isEqualTo West) then {_FinalMarkerTG setMarkerColor "ColorRed";};};
				if (_Side isEqualTo West) then {_control ctrlSetTextColor [0,0.23,0.66,1];_DefendingSide = _LocName;_color = '#003DAA';if (side (group player) isEqualTo East) then {_FinalMarkerTG setMarkerColor "ColorBlue";};};				
				
				_SideText	ctrlSetStructuredText parseText format 
				[
					"
						<t size='1.0'><t align='left'></t></t><t color=%2><t size='1.0'><t align='left'>%1: DEFENCE: %3 ---- ASSAULT: %4 </t></t></t> 
					",_DefendingSide,_color,_Current,_AttackerTickets
				];				
				
			}
			else
			{
				20055 cutFadeOut 0;
				
			};

			
			
	};
	sleep 10;
	false
};
