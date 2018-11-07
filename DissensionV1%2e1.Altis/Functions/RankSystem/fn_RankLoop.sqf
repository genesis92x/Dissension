//Function that will constantly monitor the players experience and levels.
private _CurLvlI = "";
private _NxtRnk = "";
{
	private _XP = _x select 1;
	if (DIS_Experience < _XP) exitWith
	{
		_CurLvlI = (_forEachIndex - 1);
		_NxtRnk = _forEachIndex;
	};
} foreach DIS_LevelRanks;

//[73,477796,[8,"AmmoD"]]
private _CurLvlA = DIS_LevelRanks select _CurLvlI;
private _NextLvlA = DIS_LevelRanks select _NxtRnk;
private _NLvl = _CurLvlA select 0;
if !(DIS_CurLevel isEqualTo _NLvl) then
{
	if !(DIS_CurLevel isEqualTo 0) then 
	{
	
	
		playsound "Promotion";
		private _MrMoney =  (_NLvl * 100);
		DIS_PCASHNUM = DIS_PCASHNUM + _MrMoney;
		//private _Message = format ["You gained %1$ for ranking up!",_MrMoney];
		//[_Message,'#FFFFFF'] call Dis_MessageFramework;
		["<img size='1' align='left' color='#ffffff' image='Pictures\help_ca.paa' /> RANK UP", format 
		["<t size='1'>RANK LEVELD TO %1<br/>Here is your bonus of %2$!
		</t>",_NLvl,_MrMoney]] spawn Haz_fnc_createNotification;			
		

		private _LvlE = _NLvl call BIS_fnc_numberDigits;
		private _FN = _LvlE select ((count _LvlE) - 1);
		private _NAB = "";
		if (_FN isEqualTo 0) then
		{
			private _AB = DIS_LvlA select 2;
			_NAB = _AB select ((count _AB) -1);
		};
		DIS_Abil = "";
		systemchat format ["_NAB: %1",_NAB];		
		switch (_NAB) do 
		{
			case "AmmoD": {DIS_Abil = "Personal Ammo Drop";};
			case "SquadAD": {DIS_Abil = "Squad Ammo Drop"};
			case "ATVD": {DIS_Abil = "Request ATV"};
			case "LeafletD": {DIS_Abil = "Leaflet Drop"};
			case "Halo": {DIS_Abil = "HALO Drop"};
			case "FARP": {DIS_Abil = "FARP"};
			case "DIGIN": {DIS_Abil = "DIG IN"};
			case "transportD": {DIS_Abil = "Request Vehicle"};
			case "RequestPickup": {DIS_Abil = "Request Pickup"};
			case "CommAssist": {DIS_Abil = "Commander AI Assist"};
			default {};
		};

		if !(DIS_Abil isEqualTo "") then
		{
			_Nil = [
				[
					["Rank Up","align = 'center' size = '0.7' font='PuristaBold'"],
					["","<br/>"],
					[(str (name player)),"align = 'center' size = '0.8'","#4FFC08"],
					["","<br/>"],
					["Current Rank: " + (str _NLvl),"align = 'center' size = '0.7'"],
					["","<br/>"],
					["New Ability: " + (str DIS_Abil),"align = 'center' size = '0.7'"]
				]
			]
			spawn BIS_fnc_typeText2;		
		}
		else
		{
			_Nil = 
			[
				[
					["Rank Up","align = 'center' size = '0.7' font='PuristaBold'"],
					["","<br/>"],
					[(str (name player)),"align = 'center' size = '0.8'","#4FFC08"],
					["","<br/>"],
					["Current Rank: " + (str _NLvl),"align = 'center' size = '0.7'"]
				]
			]
			spawn BIS_fnc_typeText2;
		};
	};
	
	DIS_CurLevel = _NLvl;
	DIS_NxtLevel = _NextLvlA;
	DIS_LvlA = _CurLvlA;
	[] call DIS_fnc_SaveData;
	player setVariable ["DIS_Level",DIS_CurLevel,true];
	
		
	
};
