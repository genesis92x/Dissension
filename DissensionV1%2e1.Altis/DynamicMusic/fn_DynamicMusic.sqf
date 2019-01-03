sleep 1;
private _MusicList = (configfile/"CfgMusic") call BIS_fnc_getCfgSubClasses;
DIS_MusicEnabled = true;

private _Calm = [];
private _Stealth = [];
private _Combat = [];
private _action = [];
private _Safe = [];

private _BlackList = ["C_EA_RadioMusic2","C_EA_RadioMusic1","C_EA_RadioBroadcast2","C_EA_RadioBroadcast1"];


_action pushBack "Track01_Proteus";
_action pushBack "Track02_SolarPower";
_action pushBack "Track04_Underwater1";
_action pushBack "Track04_Underwater2";
_action pushBack "LeadTrack01_F_Malden";
_action pushBack "LeadTrack02_F_Malden";
_action pushBack "Track13_StageC_negative";

_Combat pushBack "Track03_OnTheRoad";
_Combat pushBack "Track07_ActionDark";
_Combat pushBack "Track10_StageB_action";
_Combat pushBack "Track12_StageC_action";
_Combat pushBack "Track15_MainTheme";
_Combat pushBack "EventTrack01a_F_Tacops";
_Combat pushBack "EventTrack01b_F_Tacops";
_Combat pushBack "EventTrack02a_F_Tacops";
_Combat pushBack "EventTrack02b_F_Tacops";


_Stealth pushBack "Track09_Night_percussions";
_Stealth pushBack "Track11_StageB_stealth";
_Stealth pushBack "AmbientTrack01a_F_Tacops";
_Stealth pushBack "AmbientTrack01b_F_Tacops";

_Calm pushBack "Track14_MainMenu";
_Calm pushBack "Wasteland";
_Calm pushBack "SkyNet";
_Calm pushBack "MAD";
_Calm pushBack "Defcon";
_Calm pushBack "LeadTrack01_F_Curator";
_Calm pushBack "LeadTrack01_F_Curator";

_Safe pushback "AmbientTrack02a_F_Tacops";
_Safe pushback "AmbientTrack02b_F_Tacops";
_Safe pushback "AmbientTrack03a_F_Tacops";
_Safe pushback "AmbientTrack03b_F_Tacops";
_Safe pushback "AmbientTrack04a_F_Tacops";
_Safe pushback "AmbientTrack04b_F_Tacops";

{
	private _Theme = 	toLower (getText(configfile/"CfgMusic"/_x/"theme"));
	if !(_x in _BlackList) then
	{
		switch (_Theme) do 
		{
				case "safe": 
				{
					_Safe pushBack _x;
				};
				case "stealth": 
				{
					_Stealth pushBack _x;
				};
				case "calm": 
				{
					_Calm pushBack _x;	
				};
				case "combat": 
				{
					_Combat pushBack _x;
				};
				case "action": 
				{
					_action pushBack _x;
				};
				
		};		
	};
	true;
} count _MusicList;

private _CurrentTheme = "";
private _Dur = 0;
private _PlayedAt = 0;
private _CmbCooldwn = 0;
waitUntil
{
	if (alive player) then
	{
		private _CalmS = false;
		private _StealthS = false;
		private _CombatS = false;
		private _actionS = false;
		private _SafeS = false;
	
		private _CrtL = (position player) nearObjects ["#crater",15];	
		private _TCE = player call dis_ClosestEnemy;
		private _Dist2P = player distance2D _TCE;
		private _b = behaviour _TCE; 
		
		if ((count _CrtL > 0) && {_Dist2P < 1000} && {_b isEqualTo "COMBAT"}) then
		{
			_CombatS = true;
		};		
		
	
		if (_Dist2P < 400 && {(count _CrtL < 1)}) then
		{
			_StealthS = true;
		};
		
		private _DeadBody = [allDeadMen,player,true] call dis_closestobj;		
		if (_Dist2P > 1000) then
		{
			_SafeS = true;
		};
		
		if (_Dist2P < 1000 && {_Dist2P > 400} && {_DeadBody distance2D player < 500 }) then
		{
			_actionS = true;
		};
	
		
		if (_DeadBody distance2D player > 500 && {_Dist2P < 1000}) then
		{
			_CalmS = true;
		};
		
	
		switch (true) do 
		{
				case _CombatS: 
				{
					if ((!(_CurrentTheme isEqualTo "combat") && {_CmbCooldwn < 1}) || (_PlayedAt < time && {_CmbCooldwn < 1})) then {_CmbCooldwn = 120; private _Sng = (selectRandom _combat);_Dur = getNumber(configfile/"CfgMusic"/_Sng/"duration");5 fadeMusic 0;sleep 6;playMusic _Sng;_PlayedAt = ((_Dur + time) + 30);_CurrentTheme = "combat";5 fadeMusic 0.20;};
				};
				case _actionS: 
				{
					if ((!(_CurrentTheme isEqualTo "action") && {_CmbCooldwn < 1}) || (_PlayedAt < time && {_CmbCooldwn < 1})) then {private _Sng = (selectRandom _action);_Dur = getNumber(configfile/"CfgMusic"/_Sng/"duration");5 fadeMusic 0;sleep 6;playMusic _Sng;_PlayedAt = ((_Dur + time) + 30);_CurrentTheme = "action";5 fadeMusic 0.20;};
				};
				case _StealthS: 
				{
					if ((!(_CurrentTheme isEqualTo "stealth") && {_CmbCooldwn < 1}) || (_PlayedAt < time && {_CmbCooldwn < 1})) then {private _Sng = (selectRandom _stealth);_Dur = getNumber(configfile/"CfgMusic"/_Sng/"duration");5 fadeMusic 0;sleep 6;playMusic _Sng;_PlayedAt = ((_Dur + time) + 30);_CurrentTheme = "stealth";5 fadeMusic 0.20;}; 
				};
				case _CalmS: 
				{
					if ((!(_CurrentTheme isEqualTo "calm") && {_CmbCooldwn < 1}) || (_PlayedAt < time && {_CmbCooldwn < 1})) then {private _Sng = (selectRandom _calm);_Dur = getNumber(configfile/"CfgMusic"/_Sng/"duration");5 fadeMusic 0;sleep 6;playMusic _Sng;_PlayedAt = ((_Dur + time) + 30);_CurrentTheme = "calm";5 fadeMusic 0.20;};
				};	
				case _SafeS: 
				{
					if ((!(_CurrentTheme isEqualTo "safe") && {_CmbCooldwn < 1}) || (_PlayedAt < time && {_CmbCooldwn < 1})) then {private _Sng = (selectRandom _safe);_Dur = getNumber(configfile/"CfgMusic"/_Sng/"duration");5 fadeMusic 0;sleep 6;playMusic _Sng;_PlayedAt = ((_Dur + time) + 30);_CurrentTheme = "safe";5 fadeMusic 0.20;};
				};				
		};		
		
		if (_CmbCooldwn > 0) then {_CmbCooldwn = _CmbCooldwn - 5};
		if (Dis_debug) then
		{
			//systemChat format ["MUSIC DEBUG: %1 -- %2",_CurrentTheme,[_CombatS,_actionS,_StealthS,_CalmS,_SafeS]];
			//systemChat format ["MUSIC DEBUG DIST: %1 -- %2 -- %3 -- %4",_Dist2P,(count _CrtL),_CmbCooldwn,(time - _PlayedAt)];
		};
	};
	sleep 5;
	!(DIS_MusicEnabled)
	
};
