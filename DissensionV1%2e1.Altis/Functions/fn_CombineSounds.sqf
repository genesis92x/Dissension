//Function for players hearing Combine Sounds
//Most efficent way is to constantly scan for AI nearby and have them play appropriate sounds near players.
private _CV = "CombineVoice" call BIS_fnc_getParamValue;
DIS_COMBAT = ["affirmativewegothimnow","closing2","contactconfirmprosecuting","copythat","coverhurt","executingfullresponse","gosharpgosharp","isfieldpromoted","isfinalteamunitbackup","lostcontact","motioncheckallradials","movein","overwatchrequestreinforcement","overwatchtargetcontained","prosecuting","sectorisnotsecure","stabilizationteamhassector","stayalertreportsightlines","targetcompromisedmovein","targetmyradial","teamdeployedandscanning"];
DIS_SAFE = ["copythat","motioncheckallradials","prepforcontact","prison_soldier_activatecentral","prison_soldier_boomersinbound","prison_soldier_bunker1","prison_soldier_bunker2","prison_soldier_bunker3","prison_soldier_containD8","prison_soldier_fallback_b4","prison_soldier_freeman_antlions","prison_soldier_fullbioticoverrun","prison_soldier_leader9dead","prison_soldier_negativecontainment","stayalertreportsightlines","prison_soldier_prosecuteD7","prison_soldier_sundown3dead","prison_soldier_tohighpoints","prison_soldier_visceratorsA5","stabilizationteamhassector"];
if (_CV isEqualTo 0) exitWith {};
while {true} do
{
	if !(DIS_DISABLED) then
	{
		private _Players = (allPlayers - entities "HeadlessClient_F");
		{
			if !(isPlayer _x) then
			{
				private _NP = [_Players,_x,true,"CB1"] call dis_closestobj;
				private _Chnc = (round (random 100));
				if (_NP distance2D _x < 100 && {_Chnc < 25}) then
				{
					sleep 0.25;
					if (behaviour _x isEqualTo "COMBAT") then
					{
						[_x,(selectRandom DIS_COMBAT)] remoteExec ["PlaySoundEverywhereSay3D",0];
					}
					else
					{
						[_x,(selectRandom DIS_SAFE)] remoteExec ["PlaySoundEverywhereSay3D",0];
					};	
				};				
			};
		} foreach allunits;
	};
	sleep 10;
};


