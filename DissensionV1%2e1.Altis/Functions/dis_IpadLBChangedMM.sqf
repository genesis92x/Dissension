_Line1 = _this select 0; //Dialog Control Number
_index = _this select 1; //Index number
_text = lbText [1500, _index];


if (_text isEqualTo "COMMANDER INFO") exitWith
{
	private ["_Side", "_FinalName", "_BirthDate", "_FinalFocus", "_MoodTrait", "_DI"];
	_Side = "WUT";
	if (side (group player) isEqualTo WEST) then
	{
		_Side = W_CommanderInfo;
	}
	else
	{
	
	};


	
	_DI = format 
	[
	"
	NAME: %1<br/>
	BORN: %2<br/>
	ARMY FOCUS: %3<br/>
	WAR STYLE: %4<br/>
	%5<br/>
	"
	,(W_CommanderInfo select 0),(W_CommanderInfo select 1),(W_CommanderInfo select 2),(W_CommanderInfo select 3 select 0),(W_CommanderInfo select 3 select 1)
	];
	
	
	
	
	((findDisplay (3014)) displayCtrl (1100)) ctrlSetPosition [0,0];
	((findDisplay (3014)) displayCtrl (1100)) ctrlCommit 0;
	((findDisplay (3014)) displayCtrl (1100)) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>%1</t></t></t>",_DI]);
	

};


if (_text isEqualTo "RECENT ORDERS") exitWith
{

	private ["_DI", "_Side", "_NewsArray", "_display", "_TemporaryArray", "_Counter", "_SmallerArray", "_Title", "_index", "_NewInformation", "_RealData", "_size"];
	lbclear 1500;
	_DI = "";
	((findDisplay (3014)) displayCtrl (1100)) ctrlSetPosition [0,0];
	((findDisplay (3014)) displayCtrl (1100)) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>%1</t></t></t>",_DI]);	
	((findDisplay (3014)) displayCtrl (1100)) ctrlCommit 0;
	
	((findDisplay (3014)) displayCtrl 1600) ctrlSetPosition [-0.051,0.5,0.1,0.1];
	((findDisplay (3014)) displayCtrl (1600)) ctrlCommit 0;	
	
	_Side = (side (group player));
	if (_Side isEqualTo WEST) then
	{
		_NewsArray = dis_WNewsArray;
	}
	else
	{
		_NewsArray = dis_ENewsArray;
	};
	
	
	_display = (findDisplay 3014) displayCtrl 1500;
	_display ctrlSetEventHandler ["LBSelChanged","[_this select 0,_this select 1] call dis_IpadLBChanged"];
	
	_TemporaryArray = _NewsArray;
	_Counter = (count _NewsArray) + 1;
	{
		_Counter = _Counter - 1;
		_SmallerArray = _x;
		
		_Title = _SmallerArray select 0;
		_index = lbAdd [1500,format ["%1: %2",_Counter,_Title]];
		_SmallerArray = _SmallerArray - [_Title];
		_NewInformation = [];
		
		{
			_NewInformation pushback _x;
		} foreach _SmallerArray;
		
		_RealData = lbSetData [1500,_index,format ["%1",_NewInformation]];
		
	
	
	} foreach _TemporaryArray;

	_size = lbSize 1500;
	lbSetCurSel [1500,_size];
};


if (_text isEqualTo "CURRENT MISSION") exitWith
{
	_DI = W_CurMission;
	if (isNil "W_CurMission") then {_DI = ["NO MISSION"];};
	((findDisplay (3014)) displayCtrl (1100)) ctrlSetPosition [0,0];
	((findDisplay (3014)) displayCtrl (1100)) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>%1</t></t></t>",_DI]);	
	((findDisplay (3014)) displayCtrl (1100)) ctrlCommit 0;		

};

if (_text isEqualTo "EQUIPMENT PURCHASE") exitWith
{
[] spawn 
{
private ["_Building", "_Type", "_BarrackList", "_DI", "_NearestBuilding", "_PlayersLoadout", "_CashAmount", "_CameraActive"];

if (isNil "W_BuildingList") exitWith
{
		_DI = "NOT INITIALIZED YET...COME BACK SOON.";
		((findDisplay (3014)) displayCtrl (1100)) ctrlSetPosition [0,0];
		((findDisplay (3014)) displayCtrl (1100)) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>%1</t></t></t>",_DI]);	
		((findDisplay (3014)) displayCtrl (1100)) ctrlCommit 0;	
};

_BarrackList = [];	
	{
		_Building = _x select 0;
		if !(isNil "_Building") then
		{
			_Type = _x select 1;
			if (_Type isEqualTo "Barracks") then {_BarrackList pushback (_x select 0);};
		};
	} foreach W_BuildingList;
	
	if (_BarrackList isEqualTo []) exitWith 
	{
		_DI = "NO BARRACKS CREATED";
		((findDisplay (3014)) displayCtrl (1100)) ctrlSetPosition [0,0];
		((findDisplay (3014)) displayCtrl (1100)) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>%1</t></t></t>",_DI]);	
		((findDisplay (3014)) displayCtrl (1100)) ctrlCommit 0;	
	};
	
	_NearestBuilding = [_BarrackList,player,true] call dis_closestobj;
	if (_NearestBuilding distance player > 100) exitWith 
	{
		_DI = "TOO FAR FROM BARRACKS";
		((findDisplay (3014)) displayCtrl (1100)) ctrlSetPosition [0,0];
		((findDisplay (3014)) displayCtrl (1100)) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>%1</t></t></t>",_DI]);	
		((findDisplay (3014)) displayCtrl (1100)) ctrlCommit 0;	
	};
	closeDialog 3014;
	_PlayersLoadout = [player] call dis_PlayerLoadout;
	
	_CashAmount = 0;
	{
		if (_x in CfgWeaponsArray) then {_CashAmount = _CashAmount + 100;};
		if (_x in CfgHeavyArray) then {_CashAmount = _CashAmount + 200;};
		if (_x in CfgAttachmentsArray) then {_CashAmount = _CashAmount + 25;};
		if (_x in CfgEquipmentArray) then {_CashAmount = _CashAmount + 10;};
		if (_x in CfgVestsArray) then {_CashAmount = _CashAmount + 50;};
		if (_x in CfgHelmetsArray) then {_CashAmount = _CashAmount + 50;};
		if (_x in CfgPistolArray) then {_CashAmount = _CashAmount + 70;};
		if (_x in CfgLauncherArray) then {_CashAmount = _CashAmount + 200;};
		if (_x in CfgRucksArray) then {_CashAmount = _CashAmount + 100;};
		if (_x in CfgLightMagazine) then {_CashAmount = _CashAmount + 10;};
		if (_x in CfgPistolMagazine) then {_CashAmount = _CashAmount + 5;};
		if (_x in CfgHeavyMagazine) then {_CashAmount = _CashAmount + 15;};
		if (_x in CfgLauncherMagazine) then {_CashAmount = _CashAmount + 25;};
		if (_x in CfgFlareMagazine) then {_CashAmount = _CashAmount + 5;};
		if (_x in CfgGrenadeMagazine) then {_CashAmount = _CashAmount + 10;};
		if (_x in CfgUnknownMagazine) then {_CashAmount = _CashAmount + 5;};
	
	} foreach _PlayersLoadout;
	
	
	
	
	//Lets tell our function that arsenal is open
	KOZ_ARSENALOPEN = true;
	
	
	//Open arsenal and set the variable that ARSENAL is running.
	["Open",true] spawn BIS_fnc_arsenal;
	
	
	//Now lets monitor what the player is buying from the shop.
	[player,_CashAmount,_PlayersLoadout] spawn dis_ArsenalShop;
	
	
	//Lets create a way to know if Arsenal is open or not
	
	sleep 2;
	_CameraActive = true;
	while {_CameraActive} do 
	{
		
		if (isNull (uinamespace getvariable ["BIS_fnc_arsenal_cam",objnull])) then
		{
			KOZ_ARSENALOPEN = false;
			_CameraActive = false;
		};
		sleep 0.01;
	};
};
};

if (_text isEqualTo "VEHICLE PURCHASE") exitWith
{
[] spawn {
	KOZ_ARSENALOPEN = true;

	[] spawn dis_VehiclePurchase;

	sleep 2;
	_CameraActive = true;
	while {_CameraActive} do 
	{
		
		if (isNull (uinamespace getvariable ["BIS_fnc_arsenal_cam",objnull])) then
		{
			KOZ_ARSENALOPEN = false;
			_CameraActive = false;
		};
		sleep 0.01;
	};
};
};

if (_text isEqualTo "RANK") exitWith
{

	_BG_ImageDirectory = "NOPE";
	if ((side player) isEqualTo WEST) then {_BG_ImageDirectory = "BLU"};
	
	//[33,		"Juggernaut", 			"JGRNT",		"$STR_Rank_33_Desc",		25000,			"Rank_33.paa"]
	//Lets grab the players current rank information
	_Currentlevel = player getVariable "BG_CurrentLevel";
	
	//Lets define the picture to use here
	_RankPicture = _Currentlevel select 5;
	_RankPictureFinal = format ["Images\Ranks\%1\%2",_BG_ImageDirectory,_RankPicture];
	
	//Lets pull the rank name here
	_RankName = _Currentlevel select 1;
	
	//Lets pull the rank abbreviation here
	_RankAbv = _Currentlevel select 2;
	
	//Lets pull the players current XP
	_PlayerExperience = player getVariable "BG_Experience";
	
	//Lets find the next rank needed XP
	_NextRank = player getVariable "BG_NextLevel";
	_NextRankXP = _NextRank select 4;
	//systemChat format ["%1",_NextRank];
	//systemChat format ["%1",_NextRankXP];
	
	//Display the appropriate stats to the page here
	_Accuracy = "SHOOT SOMETHING.";
	
	//Lets pull the amount of shots a player has fired
	_BGShotsFired = BG_ShotsFired;
	
	//Lets pull the amount of shots a player has actually hit someone with. Direct or indirect.
	_BGShotsHit = player getVariable "BG_ShotsHit";
	
	//Lets grab headshots
	_BGHeadShots = player getVariable "BG_headshots";
	
	//Lets grab time played
	_BGPlayedDuration = (player getVariable "BG_PlayedDuration")/60;
	
	//Lets track the damage recieved
	_BGDamageRecieved = player getVariable "BG_DamageRecieved";
	
	//Lets track the damage the player dealt
	_BGDamageDealt = player getVariable "BG_DamageDealt";
	
	//Lets track player kills
	_BGPlayerKills = player getVariable "BG_KillCount";
	
	//Lets grab the players deaths
	_BG_Deaths = player getVariable "BG_Deaths";
	
	//Assists
	_BG_Assisted = player getVariable "BG_Assisted";
	
	//Lets grab vehicle kills
	_BG_VehicleKills = player getVariable "BG_VehicleKills";
	
	//Lets calculate the number of missed shots now
	_BGMissedShots = _BGShotsFired - _BGShotsHit;
	
	//Calculate Accuracy
	if (_BGShotsFired > 0) then
	{
		_Accuracy = _BGShotsHit/_BGShotsFired;
	};
		
	//systemChat format ["INFO: %1 %2 %3 %4 %5 %6 %7 %8 %9 %10 %11 %12 %13 %14 %15",(name player),_RankName,_RankAbv,_PlayerExperience,_NextRankXP,_RankPictureFinal,_Accuracy,_BGShotsFired,_BGShotsHit,_BGHeadShots,_BGPlayedDuration,_BGDamageRecieved,_BGDamageDealt,_BGPlayerKills,_BG_Deaths,_BG_Assisted,_BG_VehicleKills];

	_DI = format 
	[
	"
	<t align='left'>
	<t size='10'>
	<img image='%6' />
	</t></t><br/>
	NAME: %1 - %3<br/>
	RANK: %2<br/>
	XP: %4<br/>
	NEXT RANK AT: %5 XP<br/>
	====================================<br/>
	STATISTICS:<br/>
	SHOTS FIRED: %8<br/>
	SHOTS MISSED: %17<br/>
	SHOTS HIT: %9<br/>
	HEAD SHOTS: %10<br/>
	ACCURACY: %7<br/>
	DAMAGE DEALT: %13<br/>
	ASSISTS: %15<br/>
	UNITS KILLED: %14<br/>
	VEHICLES KILLED: %18<br/>
	DAMAGE RECIEVED: %12<br/>
	DEATHS: %15<br/>
	TIME PLAYED: %11 MINUTES<br/>
	"
	,(name player),_RankName,_RankAbv,_PlayerExperience,_NextRankXP,_RankPictureFinal,_Accuracy,_BGShotsFired,_BGShotsHit,_BGHeadShots,_BGPlayedDuration,_BGDamageRecieved,_BGDamageDealt,_BGPlayerKills,_BG_Deaths,_BG_Assisted,_BGMissedShots,_BG_VehicleKills
	];

((findDisplay (3014)) displayCtrl (1100)) ctrlSetPosition [0,0];
((findDisplay (3014)) displayCtrl (1100)) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>%1</t></t></t>",_DI]);	
((findDisplay (3014)) displayCtrl (1100)) ctrlCommit 0;

};

if (_text isEqualTo "GAME INFO") exitWith
{
_DI = 
"
<t size='2'><t align='center'>Dissension Alpha V0.1</t></t><br /><br />
Thank you for playing Dissension V0.1!<br />
This is a continuous work in progress<br /><br />
What is Dissension?<br />
Dissension is a grand CTI with a focus on resource collecting, leveling, and out maneuvering your opponent. AI commanders are assigned random personalities and traits that heavily influence the course of battle. <br />
Players can follow the orders given by their commander, assault territory, do supply runs, fortify positions, destroy enemy supply lines, or anything else they desire. The ultimate goal is destruction of the enemy team.<br />
<br /><br />
TIPS:<br />
- You can purchase weapons via the Ipad if you are near a barracks.<br />
- Players can purchase any vehicles as long as they are close to a friendly structure.<br />
- You get money and XP by killing enemies, completing objectives, or by doing supply runs.<br />
- To capture a town or grid, you must first deplete the town's/grid's troop reserve. Once the reserve is depleted the remaining forces will flee.

<br /><br />
Thank you,
Genesis92x
";

((findDisplay (3014)) displayCtrl (1100)) ctrlSetPosition [0,0];
((findDisplay (3014)) displayCtrl (1100)) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>%1</t></t></t>",_DI]);	
((findDisplay (3014)) displayCtrl (1100)) ctrlCommit 0;	
	
	
	
	
	
	//Please leave a post <t color='#ff0000'><a href='http://forums.bistudio.com/showthread.php?191620-60-TvT-Battle-Grid'>here</a></t> to let me know!
	
	
	
	
	
	
	
	
	
	
	
};