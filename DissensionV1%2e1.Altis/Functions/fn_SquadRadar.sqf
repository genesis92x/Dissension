disableSerialization;
#define ST_KEEP_ASPECT_RATIO 0x800
#define ST_PICTURE 48
style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
DIS_RADARGO = false;
sleep 2;
_Mod = "SquadRadar" call BIS_fnc_getParamValue;
if (_Mod isEqualTo 0) exitWith {};
DIS_RADARGO = true;
DIS_SHOWRAD = true;
#define DELTA_x(V1, V2) ((V1 select(0)) - (V2 select(0)))
#define DELTA_y(V1, V2) ((V1 select(1)) - (V2 select(1)))
#define ANGLE_xy(V1, V2) DELTA_x(V1, V2) atan2 DELTA_y(V1, V2)	
MISSION_ROOT = str missionConfigFile select [0, count str missionConfigFile - 15];

DIS_BCKSPC = 
{
		private _Stp = false;
		switch (_this) do
		{
				case 14:  //ESC
				{
						//0 = ICONS 1=NAMES 2=PRIMARY WEAPON 3=SECONDARY WEAPON 4=MEDKIT/TOOLKIT
						DIS_LSTNAME = DIS_LSTNAME + 1;
						if (DIS_LSTNAME > 5) then {DIS_LSTNAME = 0};
						if (DIS_LSTNAME isEqualTo 0) then {hint "JUST ICONS";DIS_SHOWRAD = true;};
						if (DIS_LSTNAME isEqualTo 1) then {hint "NAMES";};
						if (DIS_LSTNAME isEqualTo 2) then {hint "PRIMARY WEAPONS";};
						if (DIS_LSTNAME isEqualTo 3) then {hint "SECONDARY WEAPONS";};
						if (DIS_LSTNAME isEqualTo 4) then {hint "MEDKIT/TOOLKIT";};
						if (DIS_LSTNAME isEqualTo 5) then {hint "DISABLED";DIS_SHOWRAD = false;};
						_Stp = true;
				};
		};
	_Stp
};

DGN_BUTTONPRESS = (findDisplay 46) displayAddEventHandler ["KeyDown","(_this select 1) call DIS_BCKSPC"];
DIS_LSTNAME = 0;

16000 cutRsc ['DIS_MAPRSC','PLAIN'];
_ui2 = (uiNamespace getVariable 'DIS_MAPRSC') displayctrl 1001;
_DIS_Bck = (uiNamespace getVariable 'DIS_MAPRSC') displayctrl 1002;
_DIS_Bck2 = (uiNamespace getVariable 'DIS_MAPRSC') displayctrl 1003;

private _lc2 = [65,65];
_ui2 ctrlMapAnimAdd [0,0.00001,_lc2];
ctrlMapAnimCommit _ui2;
sleep 1;
_DIS_Bck ctrlSetActiveColor [0,0,0,0.05];
_DIS_Bck2 ctrlSetActiveColor [0,0,0,0.05];
_DIS_Bck ctrlSetBackgroundColor [0,0,0,0.05];
_DIS_Bck2 ctrlSetBackgroundColor [0,0,0,0.05];
_DIS_Bck ctrlSetTextColor [0.5,0.5,0.5,0.5]; //Background
_DIS_Bck2 ctrlSetTextColor [0.35,1,0.04,0.85]; //Compass

DIS_RDRImg = MISSION_ROOT + "Pictures\iconMan_ca.paa";
_ui2 ctrlSetBackgroundColor [0,0,0,0];
_ui2 ctrlSetActiveColor [0,0,0,0];
_ui2 ctrlCommit 0;

uiNamespace setVariable ["DIS_BCK1",_DIS_Bck];
uiNamespace setVariable ["DIS_BCK2",_DIS_Bck2];

DIS_SquadRadar =
{
	disableSerialization;
	_DIS_Bck2 = uiNamespace getVariable "DIS_BCK1";
	_DIS_Bck = uiNamespace getVariable "DIS_BCK2";
	if (DIS_SHOWRAD && {!(visibleCompass)} && {!(visibleMap)} && {(alive player)} && {!(captive player)} && {isNull (findDisplay 27000)}) then 
	{
		_DIS_Bck2 ctrlSetFade 0;
		_DIS_Bck ctrlSetFade 0;
		_DIS_Bck2 ctrlCommit 0;
		_DIS_Bck ctrlCommit 0;
		private _Rdr = _this select 0;
		private _player = player;
		private _000 = positionCameraToWorld [0,0,0];
		private _001 = positionCameraToWorld [0,0,1];
		private _viewVector = ((_001 select 0) - (_000 select 0)) atan2 ((_001 select 1) - (_000 select 1));
		private _viewVector2 = -_viewVector;
		_DIS_Bck ctrlSetAngle [_viewVector2, 0.5, 0.5];
		_DIS_Bck2 ctrlSetAngle [_viewVector2, 0.5, 0.5];	
		private _Side = side _player;
			
		{
			if (_x distance2D player < 51 && {(side _x) isEqualTo _Side}) then
			{
				private _veh = (vehicle _x);
				private _pos = [65,65] getPos [((_player distance2D _veh) / 15),((_player getDir _veh) - _viewVector)];
				private _Color = [1,1,1,1];
				private _SU = side _x;			
				switch (_SU) do 
				{
						case west: 
						{
							_Color = [0,0.5,1,1];
						};
						case east: 
						{
							_Color = [1,0,0,1];
						};		
						case resistance: 
						{
							_Color = [0,1,0.5,1];
						};
						case default
						{
							_Color = [1,1,1,1];
						};							
				};	
				if ((lifeState _x) isEqualTo 'INCAPACITATED') then {
					_color = [1,0.41,0,1];
				};
				if (_x in (units (group player))) then
				{
					_color = [0.31,0.96,0.91,1];
				};
				private _Txt = '';
		
				switch (DIS_LSTNAME) do 
				{
						case 1: 
						{
							_Txt = name _x;
						};
						case 2: 
						{
							_Txt = getText(configfile >> "CfgWeapons" >> (primaryWeapon _x) >> "displayName");
						};
						case 3: 
						{
							_Txt = getText(configfile >> "CfgWeapons" >> (secondaryWeapon _x) >> "displayName");
						};					
						case 4: 
						{
							private _items = items _x;
							{
								if (_x isEqualTo "Medikit") then {_Txt = "Medic";};
							} foreach _items;
							{
								if (_x isEqualTo "Toolkit") then {_Txt = "Engineer";};
							} foreach _items;					
						};						
				};		
	
				if !(_x isEqualTo player) then {_Rdr drawIcon [DIS_RDRImg,_Color,_pos,20,20,((getDirVisual _x) - _viewVector),_Txt,2,0.03,'RobotoCondensed','center']}
				else
				{
					_Rdr drawIcon [DIS_RDRImg,_Color,_pos,20,20,((getDirVisual _x) - _viewVector),(str (round (getDir player))),2,0.03,'RobotoCondensed','center'];
				};
			
			};
		} forEach (units (group player));	
		
	}
	else
	{
		disableSerialization;
		_DIS_Bck2 ctrlSetFade 1;
		_DIS_Bck ctrlSetFade 1;
		_DIS_Bck2 ctrlCommit 0;
		_DIS_Bck ctrlCommit 0;
	};
};

private _ID = _ui2 ctrlAddEventHandler ["Draw",{_this call DIS_SquadRadar;}];

_ID spawn 
{
	waitUntil {!(DIS_RADARGO)};
	disableSerialization;
	_ui2 = uiNamespace getVariable "DIS_MAPRSC";
	_ui2 ctrlRemoveEventHandler ["Draw", _this];
	16000 cutText ["", "PLAIN"]; 
};