//Function for saving the players level data.

//Lets save this information!
private _SetVariables = profileNameSpace setVariable[format["DIS_INFO_%1",profileName],[DIS_PCASHNUM,DIS_Experience,DIS_PlayedDuration,DIS_KillCount,DIS_ShotsFired,DIS_Deaths]];
private _SAVESIDE = profileNameSpace setVariable[format["DIS_INFO_%1_SIDEID",profileName],[DIS_SessionID,playerSide,serverTime]];
saveProfileNamespace;