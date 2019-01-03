//[] call DIS_fnc_DIS_RankInit
//This will setup all the ranks for players and needed information for running the leveling system.

//Levels
//[							0							 ,					1																			]
//Abilities
//[Number of max AI recruitment,			Ammo Drop																				]

private _PlayerJInfo = (profileNamespace getVariable format["DIS_INFO_%1_SIDEID",profileName]);
if !(isNil "_PlayerJInfo") then
{
	private _SID = _PlayerJInfo select 0;
	private _PSide = _PlayerJInfo select 1;
	private _STIME = _PlayerJInfo select 2;
	
	if (_SID isEqualTo DIS_SessionID) then
	{
		if !(_PSide isEqualTo playerSide) then
		{
			if ((serverTime + 1800) > _STIME) then
			{
				systemChat "YOU CANNOT SWITCH TEAMS FOR 30 MINUTES! GO BACK TO YOUR OTHER SIDE.";
				endMission "END1";
			};
		};
		
	};
};

//W_BuildingList pushback [_Object,"Barracks",_PID,_PName];
private _SideB = W_BuildingList;
if (playerSide isEqualTo East) then {_SideB = E_BuildingList;};

DIS_LevelRanks =
[
		//Level,XPNeeded,abilities
		[0,0,[0,"RequestPickup"]],
		[1,500,[1,"RequestPickup"]],
		[2,550,[1,"RequestPickup"]],
		[3,605,[1,"RequestPickup"]],
		[4,665,[1,"RequestPickup"]],
		[5,732,[1,"AmmoD","RequestPickup"]],
		[6,805,[1,"AmmoD","RequestPickup"]],
		[7,885,[1,"AmmoD","RequestPickup"]],
		[8,974,[1,"AmmoD","RequestPickup"]],
		[9,1071,[1,"AmmoD","RequestPickup"]],
		[10,1178,[3,"AmmoD","ATVD","RequestPickup"]],
		[11,1296,[3,"AmmoD","ATVD","RequestPickup"]],
		[12,1426,[3,"AmmoD","ATVD","RequestPickup"]],		
		[13,1569,[3,"AmmoD","ATVD","RequestPickup"]],
		[14,1726,[3,"AmmoD","ATVD","RequestPickup"]],		
		[15,1898,[3,"AmmoD","ATVD","RequestPickup"]],		
		[16,2088,[3,"AmmoD","ATVD","RequestPickup"]],
		[17,2297,[3,"AmmoD","ATVD","RequestPickup"]],	
		[18,2527,[3,"AmmoD","ATVD","RequestPickup"]],		
		[19,2779,[3,"AmmoD","ATVD","RequestPickup"]],
		[20,3057,[3,"AmmoD","SquadAD","ATVD","RequestPickup"]],		
		[21,3363,[4,"AmmoD","SquadAD","ATVD","RequestPickup"]],	
		[22,3700,[4,"AmmoD","SquadAD","ATVD","RequestPickup"]],		
		[23,4070,[4,"AmmoD","SquadAD","ATVD","RequestPickup"]],	
		[24,4477,[4,"AmmoD","SquadAD","ATVD","RequestPickup"]],		
		[25,4925,[4,"AmmoD","SquadAD","ATVD","RequestPickup"]],		
		[26,5417,[4,"AmmoD","SquadAD","ATVD","RequestPickup"]],		
		[27,5959,[4,"AmmoD","SquadAD","ATVD","RequestPickup"]],		
		[28,6554,[4,"AmmoD","SquadAD","ATVD","RequestPickup"]],		
		[29,7210,[4,"AmmoD","SquadAD","ATVD","RequestPickup"]],		
		[30,7931,[4,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup"]],		
		[31,8724,[5,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup"]],		
		[32,9597,[5,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup"]],		
		[33,10556,[5,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup"]],		
		[34,11612,[5,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup"]],		
		[35,12773,[5,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup"]],		
		[36,14051,[5,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup"]],		
		[37,15456,[5,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup"]],		
		[38,17001,[5,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup"]],		
		[39,18702,[5,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup"]],		
		[40,20572,[5,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP"]],		
		[41,22629,[6,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP"]],		
		[42,24892,[6,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP"]],		
		[43,27381,[6,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP"]],		
		[44,30120,[6,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP"]],		
		[45,33132,[6,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP"]],		
		[46,36445,[6,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP"]],		
		[47,40089,[6,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP"]],		
		[48,44098,[6,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP"]],		
		[49,48508,[6,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP"]],		
		[50,53359,[6,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","Halo"]],		
		[51,58695,[7,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","Halo"]],		
		[52,64564,[7,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","Halo"]],		
		[53,71021,[7,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","Halo"]],		
		[54,78123,[7,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","Halo"]],		
		[55,85935,[7,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","Halo"]],		
		[56,94529,[7,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","Halo"]],		
		[57,103982,[7,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","Halo"]],		
		[58,144380,[7,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","Halo"]],		
		[59,125818,[7,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","Halo"]],		
		[60,138400,[7,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","Halo"]],		
		[61,152240,[8,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","Halo"]],		
		[62,167464,[8,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","Halo"]],		
		[63,184211,[8,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","Halo"]],		
		[64,202632,[8,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","Halo"]],		
		[65,222895,[8,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","Halo","RequestGunShip"]],		
		[66,245185,[8,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","Halo","RequestGunShip"]],		
		[67,269703,[8,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","Halo","RequestGunShip"]],		
		[68,269674,[8,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","Halo","RequestGunShip"]],		
		[69,326341,[8,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","Halo","RequestGunShip"]],		
		[70,358975,[8,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","RequestGunShip"]],		
		[71,394873,[9,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","RequestGunShip"]],		
		[72,434360,[9,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","RequestGunShip"]],		
		[73,477796,[9,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","RequestGunShip"]],		
		[74,525576,[9,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","RequestGunShip"]],		
		[75,578134,[9,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","RequestGunShip"]],		
		[76,635947,[9,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","RequestGunShip"]],		
		[77,699542,[9,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","RequestGunShip"]],		
		[78,769496,[9,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","RequestGunShip"]],		
		[79,846446,[9,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","RequestGunShip"]],		
		[80,931091,[9,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","CommAssist","RequestGunShip"]],		
		[81,1024200,[9,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","CommAssist","RequestGunShip"]],		
		[82,1126620,[9,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","CommAssist","RequestGunShip"]],		
		[83,1239282,[9,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","CommAssist","RequestGunShip"]],		
		[84,1363210,[9,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","CommAssist","RequestGunShip"]],		
		[85,1499531,[9,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","CommAssist","RequestGunShip"]],		
		[86,1649484,[9,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","CommAssist","RequestGunShip"]],		
		[87,1814432,[9,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","CommAssist","RequestGunShip"]],		
		[88,1995876,[9,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","CommAssist","RequestGunShip"]],		
		[89,2195463,[9,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","CommAssist","RequestGunShip"]],		
		[90,2415010,[9,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","CommAssist","AirAssist","RequestGunShip"]],		
		[91,2656511,[9,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","CommAssist","AirAssist","RequestGunShip"]],	
		[92,2922162,[9,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","CommAssist","AirAssist","RequestGunShip"]],	
		[93,3214378,[9,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","CommAssist","AirAssist","RequestGunShip"]],		
		[94,3535816,[9,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","CommAssist","AirAssist","RequestGunShip"]],		
		[95,3889398,[9,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","CommAssist","AirAssist","RequestGunShip"]],		
		[96,4278338,[9,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","CommAssist","AirAssist","RequestGunShip"]],		
		[97,4706171,[9,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","CommAssist","AirAssist","RequestGunShip"]],
		[98,5176789,[9,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","CommAssist","AirAssist","RequestGunShip"]],		
		[99,5694467,[9,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","CommAssist","AirAssist","RequestGunShip"]],		
		[100,6263914,[9,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","CommAssist","AirAssist","MissileBarrage","RequestGunShip"]],
		[101,10000000,[9,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","CommAssist","AirAssist","MissileBarrage","RequestGunShip"]],
		[1000,9999999999999999999999999999999999999,[10,"AmmoD","SquadAD","ATVD","LeafletD","RequestPickup","FARP","DIGIN","transportD","Halo","CommAssist","AirAssist","MissileBarrage","RequestGunShip"]]
];

//First we need to load the players level and other tracked variables.
//Check to see if a profile is already created or not
private _PlayerProf = (profileNamespace getVariable format["DIS_INFO_%1",profileName]);

private _Check2 = "";
if !(isNil "_PlayerProf") then {_Check2 = _PlayerProf select 0;};
//If the profile is not found - create one before continuing

//Current session variables - these are just for a SINGLE session. These are not saved game to game.
player setVariable ["BG_ShotParts",[],true];
player setVariable ["BG_PlayersAssisted",[]];
player setVariable ["BG_LastKilled",[],true];

if (isNil "_PlayerProf" || {_Check2 isEqualTo ""}) then 
{
	DIS_PCASHNUM = 3000;
	DIS_Experience = 470;
	DIS_PlayedDuration = 0;
	DIS_KillCount = 0;
	DIS_ShotsFired = 0;
	DIS_Deaths = 0;
  [] call DIS_fnc_SaveData;
	//_SetVariables = profileNameSpace setVariable[format["DIS_INFO_%1",profileName],[DIS_PCASHNUM,DIS_Experience,DIS_PlayedDuration,DIS_KillCount,DIS_ShotsFired,DIS_Deaths]];
  _PlayerProf = (profileNamespace getVariable format["DIS_INFO_%1",profileName]);
};

//systemChat format ["_PlayerProf: %1",_PlayerProf];

//Pull the saved variables here
DIS_PCASHNUM = _PlayerProf select 0;
DIS_Experience = _PlayerProf select 1;
DIS_PlayedDuration = _PlayerProf select 2;
DIS_KillCount = _PlayerProf select 3;
DIS_ShotsFired = _PlayerProf select 4;
DIS_Deaths = _PlayerProf select 5;




//Give the player access back to his structures
private _PID = getPlayerUID player;
private _clientID = owner player;
//W_BuildingList pushback [_Object,"Barracks",_PID,_PName];
_Rdrfnc =
{
	params ["_RADAR"];
	if (alive _RADAR) then
	{
		[_RADAR,(side (group player))] spawn
		{
			params ["_Object","_Side"];
			waitUntil
			{
				private _Units = allUnits select {!((side _x) isEqualTo _Side)};
				private _CU = [_Units,_Object,true,"171"] call dis_closestobj;
				if (!((stance _CU) isEqualTo "PRONE") && {_CU distance2D _Object < 301}) then
				{
					systemChat "BASE RADAR: There are enemy units close to your base.";
				};
				sleep 15;
				!(alive _Object)
			};
		};			
	};
};

{
	private _OPID = _x select 2;
	if !(isNil "_OPID") then
	{
		if (_PID isEqualTo _OPID) then
		{
			private _Obj = _x select 0;
			private _Name = _x select 1;	
			private _PName = _x select 3;		
			systemChat format ["COMMANDER: Giving you back control of a %1",_Name];

			//Set ownership back to the client.
			[
				[_Obj,_clientID],
				{
						params ["_Obj","_clientID"];
						_Obj setOwner _clientID;
				}
			] remoteExec ["bis_fnc_call",2];
	
			switch (_Name) do
			{
				case "PHQ": {player setVariable ["DIS_HQ",_Obj];_Obj addEventHandler ["killed",{player setVariable ["DIS_HQ",""];}];_Obj addEventHandler ["deleted",{player setVariable ["DIS_HQ",""];}];_ObjectClass = typeof _Obj;_Obj addAction ["<t color='#18FF2B'> <t size='1.25'>Disassemble</t></t>",{deleteVehicle (_this select 0);if (alive (_this select 0)) then {DIS_FortificationArray pushback (_this select 3 select 0);};},[_ObjectClass],-200,false,false,"","true",15,false];_Obj addAction ["<t color='#18FF2B'> <t size='1.0'>Respawn Build Crate</t></t>",{private _CargoBox = player getVariable ["DIS_CargoBox",nil];if !(isNil "_CargoBox") then{_Cargobox setpos (getpos player);};},[_ObjectClass],-200,false,false,"","true",15,false];};
				case "Barracks":	{player setVariable ["DIS_RDR",_Obj];_Obj addEventHandler ["killed",{player setVariable ["DIS_RDR",""];}];_Obj addEventHandler ["deleted",{player setVariable ["DIS_RDR",""];}];_ObjectClass = typeof _Obj;_Obj addAction ["<t color='#18FF2B'> <t size='1.25'>Disassemble</t></t>",{deleteVehicle (_this select 0);if (alive (_this select 0)) then {DIS_FortificationArray pushback (_this select 3 select 0);};},[_ObjectClass],-200,false,false,"","true",15,false];};
				case "CommsTower":	{[_Obj] spawn _Rdrfnc;player setVariable ["DIS_Radar",_Obj];_Obj addEventHandler ["killed",{player setVariable ["DIS_Radar",""];}];_Obj addEventHandler ["deleted",{player setVariable ["DIS_Radar",""];}];_ObjectClass = typeof _Obj;_Obj addAction ["<t color='#18FF2B'> <t size='1.25'>Disassemble</t></t>",{deleteVehicle (_this select 0);if (alive (_this select 0)) then {DIS_FortificationArray pushback (_this select 3 select 0);};},[_ObjectClass],-200,false,false,"","true",15,false];};
				case "FORTIFICATION":	{_ObjectClass = typeof _Obj;_Obj addAction ["<t color='#18FF2B'> <t size='1.25'>Disassemble</t></t>",{deleteVehicle (_this select 0);if (alive (_this select 0)) then {DIS_FortificationArray pushback (_this select 3 select 0);};},[_ObjectClass],-200,false,false,"","true",15,false];};
				case default {_ObjectClass = typeof _Obj;_Obj addAction ["<t color='#18FF2B'> <t size='1.25'>Disassemble</t></t>",{deleteVehicle (_this select 0);if (alive (_this select 0)) then {DIS_FortificationArray pushback (_this select 3 select 0);};},[_ObjectClass],-200,false,false,"","true",15,false];};
			};			
			
		};
		
	};
} foreach _SideB;


if (isNil "DIS_PCASHNUM") then {DIS_PCASHNUM = 3000;};
if (isNil "DIS_Experience") then {DIS_Experience = 0;};
if (isNil "DIS_PlayedDuration") then {DIS_PlayedDuration = 0;};
if (isNil "DIS_KillCount") then {DIS_KillCount = 0;};
if (isNil "DIS_ShotsFired") then {DIS_ShotsFired = 0;};
if (isNil "DIS_Deaths") then {DIS_Deaths = 0;};
DIS_CurLevel = 0;
DIS_LvlA = [0,0,[0]];


//We need to setup important hit event handlers here.
player addEventHandler ["Killed", {_this call DIS_fnc_LevelKilled}];
player addEventHandler ["FiredMan", {BG_ShotsFired = BG_ShotsFired + 1;}];




//Now we must constantly monitor the players level.
[] spawn
{
	waitUntil
	{
		_nil = [] call DIS_fnc_RankLoop;
		sleep 30;
		false
	};
};


[] spawn
{
	waitUntil
	{
		sleep 300;
		_nil = [] call DIS_fnc_SaveLoop;
		false
	};
};



