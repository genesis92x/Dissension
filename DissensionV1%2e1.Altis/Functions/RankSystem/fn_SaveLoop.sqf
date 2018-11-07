//Function for frequently saving the players levels/experience/stats
DIS_PlayedDuration = DIS_PlayedDuration + 300;
private _Vrt = player getVariable ["DIS_HQ",""];
private _BRK = player getVariable ["DIS_BRKS",""];
private _Radar = player getVariable ["DIS_RADAR",""];	
_SetVariables = profileNameSpace setVariable[format["DIS_INFO_%1",profileName],[DIS_PCASHNUM,DIS_Experience,DIS_PlayedDuration,DIS_KillCount,DIS_ShotsFired,DIS_Deaths,_Vrt,_BRK,_Radar]];
saveProfileNamespace;






/*
Run this code below to reset someone's character

_SetVariables = profileNameSpace setVariable[format["DIS_INFO_%1",profileName],[2000,1,0,0,0,0,"","",""]];
saveProfileNamespace;

*/