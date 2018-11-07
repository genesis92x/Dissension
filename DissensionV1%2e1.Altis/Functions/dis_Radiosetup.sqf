
if (isServer) then
{
	West_Radio = "WEST HQ";
	W_channelID = radioChannelCreate [[0.96, 0.34, 0.13, 0.8], West_Radio, "%UNIT_NAME", []];
	if (W_channelID isEqualTo 0) exitWith {diag_log format ["Custom channel '%1' creation failed!", West_Radio]};
	publicVariable "W_channelID";
	
	East_Radio = "EAST HQ";
	E_channelID = radioChannelCreate [[0.96, 0.34, 0.13, 0.8], East_Radio, "%UNIT_NAME", []];
	if (E_channelID isEqualTo 0) exitWith {diag_log format ["Custom channel '%1' creation failed!", East_Radio]};
	publicVariable "E_channelID";	
	
	All_Radio = "OCN RADIO";
	All_channelID = radioChannelCreate [[0.64,0.64,0.64,1], All_Radio, "%UNIT_NAME", []];
	if (All_channelID isEqualTo 0) exitWith {diag_log format ["Custom channel '%1' creation failed!", All_Radio]};
	publicVariable "All_channelID";		
	
	W_channelID radioChannelAdd [(leader DIS_WestCommander)];	
	E_channelID radioChannelAdd [(leader DIS_EastCommander)];	
	All_channelID radioChannelAdd [(leader DIS_EastCommander)];	
	All_channelID radioChannelAdd [(leader DIS_WestCommander)];	

};

waitUntil {!(isNil "All_channelID")};

if ((side _this) isEqualTo WEST) then
{

	[[W_channelID,player], {(_this select 0) radioChannelAdd [(_this select 1)]}] remoteExec ["call",2];
	[[All_channelID,player], {(_this select 0) radioChannelAdd [(_this select 1)]}] remoteExec ["call",2];

}
else
{

	[[E_channelID,player], {(_this select 0) radioChannelAdd [(_this select 1)]}] remoteExec ["call",2];
	[[All_channelID,player], {(_this select 0) radioChannelAdd [(_this select 1)]}] remoteExec ["call",2];

};

sleep 35;
//(leader DIS_WestCommander) customChat [All_channelID, "Hi, I am a custom chat message"];
if (isServer) then
{
	_RandomConversation = 
	selectRandom
	[
	["They don't stand a chance. Let's kick some ass.","You wish pretty boy. I am going to shove your own rifle right up your ass."],
	["I can't believe I got deployed to this shit-hole...Let's do this thing.","What's wrong? Feeling a little scared? I am sure we can accept your surrender...if you beg."],
	["Alright team - let's do this thing. No wasting time! Let's go!","Hah. Look at this guy. Trying to order troops around, as if they listen!"],
	["Okay - time to roll out. Everyone stick to the plan.","Hmm. I think a few spies will quickly let us know of any foolish plans you may have..."]
	];
	
	if (random 100 > 50) then
	{
		(leader DIS_WestCommander) customChat [All_channelID, ("Blufor commander reporting in! " + (_RandomConversation select 0))];
		sleep (2 + random 5);	
		(leader DIS_EastCommander) customChat [All_channelID, ("Opfor commander reporting in! " + (_RandomConversation select 1))];
		sleep 10;
		(leader DIS_WestCommander) customChat [All_channelID, "GL HF"];
		(leader DIS_EastCommander) customChat [All_channelID, "GL HF"];		
	}
	else
	{
		(leader DIS_EastCommander) customChat [All_channelID, ("Opfor commander reporting in! " + (_RandomConversation select 0))];
		sleep (2 + random 5);
		(leader DIS_WestCommander) customChat [All_channelID, ("Blufor commander reporting in! " + (_RandomConversation select 1))];
		sleep 10;
		(leader DIS_EastCommander) customChat [All_channelID,  "GL HF"];
		(leader DIS_WestCommander) customChat [All_channelID,  "GL HF"];	
	};
	
};