//Function that will execute when players pickup a document.
//This will provide any friendly players a boost to XP and money
//_this = document



//First we need to find out who is close to the player, and if they are friendly.
private _FriendL = allplayers select {(side _x) isEqualTo playerSide && {_x distance2D player < 200}};

[
	[],
	{
		["DOCUMENT RECOVERED. +500$ and 200XP",'#FFFFFF'] call Dis_MessageFramework;
		DIS_PCASHNUM = DIS_PCASHNUM + 500;
		DIS_Experience = DIS_Experience + 200;
		playsound "readoutClick";
		hint "";
		
	}
] remoteExec ["bis_fnc_Spawn",_FriendL]; 	




/*
		_FriendL findIf {_x isEqualTo player};
		if !(_FriendL isEqualTo -1) then
		{
			
		};