//This function will handle creation of cameras, providing XP, and resources for the players.
private _WinningSide = _this;

private _Commander = Dis_EastCommander;
private _CamLocation = getpos Dis_EastCommander;
private _Message = "East Commander has been eliminated!";
private _Victory = "WEST VICTORY";


if (_WinningSide isEqualTo East) then
{
	_Commander = Dis_WestCommander;
	_CamLocation = getpos Dis_WestCommander;
	_Message = "West Commander has been eliminated!";
	_Victory = "EAST VICTORY";
};




//Let's spawn in our custom scene here
private _cam = "camera" camCreate _CamLocation;
_cam cameraEffect ["internal", "BACK"];
_cam camSetTarget _CamLocation;
_cam camSetRelPos [0, 0, 50];
_cam camCommit 0.05;
showCinemaBorder true;

["DISTASK",[format ["%1",_Message],(MISSION_ROOT + "Pictures\types\meet_ca.paa"),_Victory,""]] call BIS_fnc_showNotification;
[
	[
		[_Victory,"align = 'center' shadow = '1' size = '0.5' font='RobotoCondensed'"],
		["","<br/>"],
		[_Message,"align = 'center' shadow = '1' size = '0.5' font='RobotoCondensed'"]
	]
] spawn BIS_fnc_typeText2;

sleep 30;
if (playerSide isEqualTo _WinningSide) then
{
	DIS_EXPERIENCE = DIS_EXPERIENCE + 4000;
	DIS_PCASHNUM = DIS_PCASHNUM + 30000;
	[] call DIS_fnc_SaveData;
	["commanderDead",true,true,true] call BIS_fnc_endMission;
	private _CurrentMap = worldName;
	private _SV = profileNameSpace setVariable[format["DIS_SG_%1",_CurrentMap],nil];
	saveProfileNamespace;	
}
else
{
	DIS_EXPERIENCE = DIS_EXPERIENCE + 2000;
	DIS_PCASHNUM = DIS_PCASHNUM + 15000;
	[] call DIS_fnc_SaveData;
	["commanderDead",false,true,true] call BIS_fnc_endMission;
	private _CurrentMap = worldName;
	private _SV = profileNameSpace setVariable[format["DIS_SG_%1",_CurrentMap],nil];
	saveProfileNamespace;								
};













/*

						if (playerSide isEqualTo West) then
						{
							
							["commanderDead",false,true,true] call BIS_fnc_endMission;
							private _CurrentMap = worldName;
							private _SV = profileNameSpace setVariable[format["DIS_SG_%1",_CurrentMap],nil];
							saveProfileNamespace;						
						}
						else
						{
							east call DIS_fnc_WinGame;
							["commanderDead",true,true,true] call BIS_fnc_endMission;
							private _SV = profileNameSpace setVariable[format["DIS_SG_%1",_CurrentMap],nil];
							saveProfileNamespace;								
						};