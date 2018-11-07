//Woop woop woop. Let's help the player after respawn shall we?

_Unit = _this select 0;
_Corpse = _this select 1;
if !(isNil "_Corpse") then {_Corpse removeAllEventHandlers "animdone"};
 
waitUntil {alive player};
//[] spawn FNCcamSpawn;
playMusic "";
player setAnimSpeedCoef 1;
player setVariable ["DIS_INCAPACITATED",false,true];
player setVariable ["DIS_Drag",false,true];
//dis_Act = player addAction ["<t color='#18FF2B'> <t size='1'>Commander Interface</t></t>", {_null = [] call dis_fnc_TabletOpen},nil,0,false,true,"","true",2,false];



private _StaminaEnabled = "EnableA3Stamina" call BIS_fnc_getParamValue;

if (_StaminaEnabled isEqualTo 0) then 
{
	player enablefatigue false;
}
else
{
	private _StaminaAmount = "A3StaminaValue" call BIS_fnc_getParamValue;
	player enablefatigue true;
	player setUnitTrait ["loadCoef",_StaminaAmount];
};

player setVariable ["DIS_CurDamage",false];
player setUnitTrait ["Medic",true];
player setUnitTrait ["engineer",true];
player setUnitTrait ["explosiveSpecialist",true];
player setUnitTrait ["UAVHacker",true];
player setVariable ["ACE_GForceCoef", 0];
player additem "ItemMap";
player assignItem "ItemMap";
player linkItem "ItemMap";
player additem "ItemWatch";
player assignItem "ItemWatch";
player linkItem "ItemWatch";
player additem "ItemRadio";
player assignItem "ItemRadio";
player linkItem "ItemRadio";
player additem "ItemCompass";
player assignItem "ItemCompass";
player linkItem "ItemCompass";
player setposATL (getposATL player);

_unit spawn
{
	sleep 2.5;
	private _RespawnSnd = ["CGetThisPartyStarted","CKeepDayJob","CLetsDoThisThing","CLetsRoll","CSetThemUp","CThisWillBeFun","CWhatDoYouGotForMe","CWhereAreThey"];
	[_this,(selectRandom _RespawnSnd)] remoteExec ["PlaySoundEverywhereSay3D",0];
};

//[] spawn DIS_fnc_RZoneCheck;
private _SpwnPos = getpos player;
_position = [player, 1, 50, 5, 0, 20, 0,[],[_SpwnPos,_SpwnPos]] call BIS_fnc_findSafePos;
//_direction = [_position,_SpwnPos] call BIS_fnc_dirTo;
_direction = _position getdir _SpwnPos;
player setpos _position;
player setdir _direction;
_RndPhrase = selectRandom ["Get back into the fight!","Get back to it!","Let's go, let's go.","Rejoin a squad.","Maybe you should try working with the team this time...","Going off on your own wasn't a good idea, now was it?"];
_DeadPhrase = "Welcome to Dissension!";
if !(isNil "_corpse") then {_DeadPhrase = format ["You died at %1",(mapGridPosition (getpos _corpse))];};
_ClosestFriendly = [((units (group player)) - [player]),player,true] call dis_closestobj;
if (_ClosestFriendly isEqualTo [] || _ClosestFriendly isEqualTo [0,0,0]) then {_ClosestFriendly = player;};
_ClosestPhrase = format ["Your closest ally is %1 located at grid %2",(name _ClosestFriendly),(mapGridPosition (getpos _ClosestFriendly))];
if (_ClosestFriendly isEqualTo [] || _ClosestFriendly isEqualTo [0,0,0]) then
{
	_ClosestPhrase = "You are not in a group with other units. Get into a group! Don't let me down.";
};
[
	["COMMANDER",_DeadPhrase,0],
	["COMMANDER",_RndPhrase,5], 
	["COMMANDER",_ClosestPhrase,10]
] spawn BIS_fnc_EXP_camp_playSubtitles;

sleep 3;
[] call dis_fnc_OpenArsenal;


private _UnflipAction = player addAction [
	"Flip Vehicle", 
	{_this call DIS_fnc_FlipVehicle;}, 
	[], 
	0, 
	false, 
	true, 
	"", 
	"_this == (vehicle _target) && {(count nearestObjects [_target, ['landVehicle'], 5]) > 0 && {(vectorUp cursorTarget) select 2 < 0}}"
];
player setUserActionText [_UnflipAction , "<t color='#00ff00'>Flip Vehicle</t>", "<img size='2' image='\a3\ui_f\data\IGUI\Cfg\Actions\unloadAllVehicles_ca'/>"];



