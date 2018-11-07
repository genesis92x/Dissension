//This function will setup and handle AI groups and their experience.

W_AliveGroups = [];
E_AliveGroups = [];
R_AliveGroups = [];

W_Groups =
[
//	name	  timealive, last 'death',current multiplyer,active
	["DEVIL",time,time,0,false],
	["DEADEYE",time,time,0,false],
	["DECOY",time,time,0,false],
	["DARK CLOUD",time,time,0,false],
	["CYCLONE",time,time,0,false],
	["CONVICT",time,time,0,false],
	["CORVETTE",time,time,0,false],
	["COBALT",time,time,0,false],
	["CLAW",time,time,0,false],
	["BOBCAT",time,time,0,false],
	["BOAR",time,time,0,false],
	["BOMBER",time,time,0,false],
	["DAGRAT",time,time,0,false],
	["DEATH",time,time,0,false],
	["DESTROYER",time,time,0,false],
	["DEVIL II",time,time,0,false],
	["DEADEYE II",time,time,0,false],
	["DECOY II",time,time,0,false],
	["DARK CLOUD II",time,time,0,false],
	["CYCLONE II",time,time,0,false],
	["CONVICT II",time,time,0,false],
	["CORVETTE II",time,time,0,false],
	["COBALT II",time,time,0,false],
	["CLAW II",time,time,0,false],
	["BOBCAT II",time,time,0,false],
	["BOAR II",time,time,0,false],
	["BOMBER II",time,time,0,false],
	["DAGRAT II",time,time,0,false],
	["DEATH II",time,time,0,false],
	["DESTROYER II",time,time,0,false]	
];

E_Groups =
[
	//	name	  timealive, last 'death',current multiplyer,active
	["GUNDOG",time,time,0,false],
	["HAVOC",time,time,0,false],
	["HAWK",time,time,0,false],
	["HARASS",time,time,0,false],
	["IRON CLAW",time,time,0,false],
	["JUST",time,time,0,false],
	["JOKER",time,time,0,false],
	["ZERG RUSH",time,time,0,false],
	["CLAW",time,time,0,false],
	["LUCKY",time,time,0,false],
	["MADRAS",time,time,0,false],
	["LYNX",time,time,0,false],
	["MIG",time,time,0,false],
	["MEGA",time,time,0,false],
	["MONSTER II",time,time,0,false],
	["GUNDOG II",time,time,0,false],
	["HAVOC II",time,time,0,false],
	["HAWK II",time,time,0,false],
	["HARASS II",time,time,0,false],
	["IRON CLAW II",time,time,0,false],
	["JUST II",time,time,0,false],
	["JOKER II",time,time,0,false],
	["ZERG RUSH II",time,time,0,false],
	["CLAW II",time,time,0,false],
	["LUCKY II",time,time,0,false],
	["MADRAS II",time,time,0,false],
	["LYNX II",time,time,0,false],
	["MIG II",time,time,0,false],
	["MEGA II",time,time,0,false],
	["MONSTER II",time,time,0,false]
];

R_Groups =
[
//	name	  timealive, last 'death',current multiplyer,active
	["NOMAD",time,time,0,false,grpNull],
	["DEFENDERS",time,time,0,false,grpNull],
	["OVERLORD",time,time,0,false,grpNull],
	["GENESIS",time,time,0,false,grpNull],
	["AK'S DEFENCE",time,time,0,false,grpNull],
	["JACA",time,time,0,false,grpNull],
	["QUAKE",time,time,0,false,grpNull],
	["LIGHTNING",time,time,0,false,grpNull],
	["RAID OPS",time,time,0,false,grpNull],
	["HOMELAND",time,time,0,false,grpNull],
	["RAIL",time,time,0,false,grpNull],
	["RAIN",time,time,0,false,grpNull],
	["RAVEN",time,time,0,false,grpNull],
	["DAVID",time,time,0,false,grpNull],
	["GOLIATH II",time,time,0,false,grpNull],
	["NOMAD II",time,time,0,false,grpNull],
	["DEFENDERS II",time,time,0,false,grpNull],
	["OVERLORD II",time,time,0,false,grpNull],
	["GENESIS II",time,time,0,false,grpNull],
	["AK'S DEFENCE II",time,time,0,false,grpNull],
	["JACA II",time,time,0,false,grpNull],
	["QUAKE II",time,time,0,false,grpNull],
	["LIGHTNING II",time,time,0,false,grpNull],
	["RAID OPS II",time,time,0,false,grpNull],
	["HOMELAND II",time,time,0,false,grpNull],
	["RAIL II",time,time,0,false,grpNull],
	["RAIN II",time,time,0,false,grpNull],
	["RAVEN II",time,time,0,false,grpNull],
	["DAVID II",time,time,0,false,grpNull],
	["GOLIATH II",time,time,0,false,grpNull]	
];

[] spawn
{
	sleep 60;
	while {true} do 
	{
	
	
		{
			//["DEVIL",time,time,0,false,grpNull],
			_InUse = _x select 4;
			_Group = _x select 5;
			if !(isNil "_Group") then
			{
				if !(isNull _Group) then
				{
				if (_InUse) then 
				{
					_Count = {alive _x} count (units _Group);
					if (_Count < 1) then
					{
						//_newMult = ((_x select 3) + ((_x select 2) - (_x select 1)))/100000;
						private _newMult = 0;
						W_Groups set [_foreachIndex,[(_x select 0),(_x select 1),time,_newMult,false,grpNull]];	
					};
				};
			};
			};
		} foreach W_Groups;
		
		{
			//["DEVIL",time,time,0,false,grpNull],
			_InUse = _x select 4;
			_Group = _x select 5;
			if !(isNil "_Group") then
			{
				if !(isNull _Group) then
				{			
				if (_InUse) then 
				{
					_Count = {alive _x} count (units _Group);
					if (_Count < 1) then
					{
						//_newMult = ((_x select 3) + ((_x select 2) - (_x select 1)))/100000;
						private _newMult = 0;
						R_Groups set [_foreachIndex,[(_x select 0),(_x select 1),time,_newMult,false,grpNull]];	
					};
				};
				};
			};
		} foreach R_Groups;
	
	
		{
			//["DEVIL",time,time,0,false,grpNull],
			_InUse = _x select 4;
			_Group = _x select 5;
			if !(isNil "_Group") then
			{
				if !(isNull _Group) then
				{
				if (_InUse) then 
				{
					_Count = {alive _x} count (units _Group);
					if (_Count < 1) then
					{
						//_newMult = ((_x select 3) + ((_x select 2) - (_x select 1)))/100000;
						private _newMult = 0;
						E_Groups set [_foreachIndex,[(_x select 0),(_x select 1),time,_newMult,false,grpNull]];	
					};
				};
				};
			};
		} foreach E_Groups;
	
	
		sleep 30;
	};
};