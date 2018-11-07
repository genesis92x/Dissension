CfgObjectsArray = ["B_CargoNet_01_ammo_F","B_Slingload_01_Repair_F","B_Slingload_01_Medevac_F","B_Slingload_01_Repair_F","B_Slingload_01_Fuel_F","B_Slingload_01_Cargo_F","B_Slingload_01_Ammo_F","Land_RepairDepot_01_green_F"];
//Cargo Container - Land_Cargo10_red_F  BloodSpray_01_New_F
CfgFortificationArray = ["B_SAM_System_01_F","B_SAM_System_02_F","B_AAA_System_01_F","Land_Bunker_F","Land_MobileLandingPlatform_01_F","Land_BagBunker_Large_F","Land_BagBunker_Small_F","Land_CanvasCover_01_F","Land_CanvasCover_02_F","Land_HelipadCircle_F","Land_PlasticCase_01_large_F","Land_BagFence_Long_F","Land_BagFence_Round_F","Land_BagFence_Short_F","Land_Cargo_Patrol_V1_F","Land_HBarrier_5_F","Land_HBarrier_Big_F","Land_HBarrierWall_corner_F","Land_HBarrierWall6_F","Land_HBarrierTower_F","Land_HBarrierWall_corridor_F","Land_Razorwire_F","Land_Shoot_House_Wall_Long_Stand_F","Land_CncWall4_F","Land_Mil_WiredFence_F","Land_Mil_WiredFence_Gate_F","Land_Pumpkin_01_F","Land_Research_house_V1_F","Land_Research_HQ_F","Land_Radar_Small_F","CamoNet_BLUFOR_big_F","Land_BagBunker_Tower_F","Land_ConcreteHedgehog_01_F","Land_Cargo_Tower_V3_F","Land_Cargo_Tower_V1_F","Land_IRMaskingCover_01_F","Land_IRMaskingCover_02_F","Land_TentHangar_V1_F"];
CfgFortificationHQA = ["B_SAM_System_01_F","B_SAM_System_02_F","B_AAA_System_01_F","Land_Research_house_V1_F","Land_Radar_Small_F","Land_BagBunker_Large_F","Land_BagBunker_Small_F","Land_Bunker_F","Land_BagBunker_Tower_F","Land_ConcreteHedgehog_01_F","Land_Cargo_Tower_V3_F","Land_Cargo_Tower_V1_F","Land_Cargo_Tower_V1_F","Land_IRMaskingCover_01_F","Land_IRMaskingCover_02_F","Land_TentHangar_V1_F"];


if (playerSide isEqualTo West) then
{
	{
		CfgFortificationArray pushback _x;
		CfgFortificationHQA pushback _x;
	} foreach ["B_HMG_01_F","B_HMG_01_high_F","B_GMG_01_F","B_GMG_01_high_F","B_Mortar_01_F","B_static_AA_F","B_static_AT_F","B_SAM_System_03_F","B_Radar_System_01_F"];
}
else
{
	{
		CfgFortificationArray pushback _x;
		CfgFortificationHQA pushback _x;
	} foreach ["O_HMG_01_F","O_HMG_01_high_F","O_GMG_01_F","O_GMG_01_high_F","O_Mortar_01_F","O_static_AA_F","O_static_AT_F","O_SAM_System_04_F","O_Radar_System_02_F"];
};

DIS_AbilityCoolDown = false;

dis_fnc_OpenOption =
{
	disableSerialization;
	closeDialog 2;
	private _html = findDisplay 46 createDisplay "RscCredits" ctrlCreate ["RscHTML", -1];
	_html ctrlSetBackgroundColor [0,0,0,0.8];
	_html ctrlSetPosition [(0.25 * safezoneW + safezoneX),(0.08 * safezoneH + safezoneY),(0.5 * safezoneW),(0.8 * safezoneH)];
	_html ctrlCommit 0;
	_html htmlLoad "briefing.html";						
};

dis_fnc_TabSwitchPlrInfo =
{
	{
		_ctrl = ((findDisplay 33000) displayCtrl (_x));
		if (ctrlShown _ctrl) then {_ctrl ctrlShow false;} else {_ctrl ctrlShow true;};
	} forEach [33100,33200];
};

dis_fnc_TabPlrOpen =
{

	if (isNull (findDisplay 33000)) then
	{
	
		//Destroy any active camera for the dialog
		private _I1 = uiNamespace getVariable ["DIS_CAM",objnull];
		private _I2 = uiNamespace getVariable ["DIS_Dummy",objnull];
		private _I3 = uiNamespace getVariable ["DIS_CamCtrl",objnull];;
		if !(isNull _I2) then {deleteVehicle _I2;};
		if !(isNull _I3) then {ctrlDelete _I3;};
		if !(isNull _I1) then {camDestroy _I1;};
	
		_display = findDisplay 46 createDisplay "RscDisTabPlayer";
		{(_display displayCtrl (_x)) ctrlShow false;} forEach [33100,39000];
		private _plrInfo = _display displayCtrl (33101);
		private _gameInfo = _display displayCtrl (33201);
		private _reqList = _display displayCtrl (34000);
		private _plrsList = _display displayCtrl (35000);
		private _plrView = _display displayCtrl (37000);
		private _Question = _display displayCtrl (33300);


		/*
		private _Currentlevel = DIS_CurLevel;
		private _PlayerExperience = DIS_Experience;
		private _NextRank = DIS_NxtLevel; //[75,578134,[8,"AmmoD"]],
		private _NextRankXP = _NextRank select 1;
		private _BGShotsFired = DIS_ShotsFired;
		private _BGPlayedDuration = DIS_PlayedDuration/60;
		private _BGPlayerKills = DIS_KillCount;
		private _BG_Deaths = DIS_Deaths;
		*/
		private _Currentlevel = DIS_CurLevel;
		private _PlayerExperience = DIS_Experience;
		private _NextRank = DIS_NxtLevel; //[75,578134,[8,"AmmoD"]],
		private _NextRankXP = _NextRank select 1;
		private _BGPlayedDuration = DIS_PlayedDuration/60;
		private _DI = format
		["<t align='left'>
		<t size='10'>
		</t></t>
		<br/>NAME: %1
		<br/>RANK: %2
		<br/>XP: %3
		<br/>NEXT RANK AT: %4 XP
		<br/>===============================================
		<br/>TIME PLAYED: %5 MINUTES",
		(name player),_Currentlevel,_PlayerExperience,_NextRankXP,_BGPlayedDuration];
		_plrInfo ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>%1</t></t></t>",_DI]);

		private _DI =
		"<t size='2'><t align='center'>Dissension Alpha V1.0</t></t>
		<br/><br/>Thank you for playing Dissension V1.0!
		<br/>Dissension is an ever-growing project.
		<br/><br/>DISSENSION'S YOUTUBE TUTORIAL LINKS
		<br/><a color='#00FF00' size='0.75' href='https://youtu.be/eazEL_y_LYQ'> Getting Gear</a>		
		<br/><a color='#00FF00' size='0.75' href='https://youtu.be/3PXzACmeGM0'> Purchasing Vehicles</a>		
		<br/><a color='#00FF00' size='0.75' href='https://youtu.be/mFIXKCjqeuA'> Recruiting AI</a>		
		<br/><a color='#00FF00' size='0.75' href='https://youtu.be/jBFud4NXSDQ'> Commanding High Command AI</a>		
		<br/><a color='#00FF00' size='0.75' href='https://youtu.be/3DQYFEjMEsQ'> Main Objectives</a>		
		<br/><a color='#00FF00' size='0.75' href='https://youtu.be/_m79jPDvtEw'> Side Objectives</a>		
		<br/><a color='#00FF00' size='0.75' href='https://youtu.be/tI3ZtwY6bHw'> Supply Crates</a>		
		<br/><a color='#00FF00' size='0.75' href='https://youtu.be/VkCxENik0X4'> Player Abilities</a>		
		<br/><a color='#00FF00' size='0.75' href='https://www.youtube.com/user/MikeSulo/videos'> Soolie's Youtube Channel. GUI Wizard and creator of Dissension's UI.</a>
		<br/><a color='#00FF00' size='0.75' href='https://www.youtube.com/user/lDominicl/videos'> Genesis's Youtube Channel for all things ArmA.</a>
		<br/><a color='#00FF00' size='0.75' href='https://www.paypal.me/SmithDominic'> Donate to continue development for Dissension and Vcom!</a>
		<br/><br/>
		<br/><br/>What is Dissension?
		<br/>Dissension is a grand CTI with a focus on resource collecting, leveling, and out maneuvering your opponent.  AI commanders are assigned random personalities and traits that heavily influence the course of battle.
		<br/>Players can follow the orders given by their commander, assault territory, do supply runs, fortify positions, destroy enemy supply lines, or anything else they desire. The ultimate goal is destruction of the enemy team.

		<br/><br/>UPDATE V1.0:
		<br/>DISSENSION IS RELEASED!

		<br/><br/><br/>TIPS:
		<br/>- You can purchase weapons via the tablet if you are near a barracks.
		<br/>- Players can purchase any vehicles as long as they are close to a friendly structure.
		<br/>- You get money and XP by killing enemies, completing objectives, or by doing supply runs.
		<br/>- To capture a town or grid, you must first deplete the town's/grid's troop reserve. Once the reserve is depleted the remaining forces will flee.
		<br/><br/>Thank you,<br/>Genesis92x";

		_gameInfo ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'>
		<t align='left'>%1</t></t></t>",_DI]);
		

		
		
		/*
						Add requests
			If you dont want all the abilities to show at all times you can still get the info from the cfgs if used like this
	
			private _Abilities = DIS_LvlA select 2;
			DIS_URc = _Abilities select 0;
			private _Abilities = ["AmmoD","SquadAD","ATVD","LeafletD","Halo","FARP","DIGIN","transportD","RequestPickup","CommAssist"];
			{_dispName = getText (missionConfigFile >> "CfgTablet" >> "CfgAbilities" >> _x >> "displayName");} foreach _Abilities;
	
			You can also just add the check needed when confiming purchase so the player can see possible ones and add whats
			needed in order to get the ability to the description ("You need to have heli factory to use this request")
			Can also add prequisites to the cfg instead of in rankInit.sqf
	
			[4,665,[1,"RequestPickup"]],
			prereq[] = {4,665};
			_prereq = getArray (_x >> "prereq");
			_prereq params ["_lvlNeeded","_xpNeeded"];
			if (_plrLvl => _lvlNeeded) then ....
	
		*/
		lbClear _reqList;
		private _abilityCfgs = "true" configClasses (missionConfigFile >> "CfgTablet" >> "CfgAbilities");
		{
			_class = configName _x; // eg "AmmoD"
			_dispName = getText (_x >> "displayName");
			_descr = getText (_x >> "description");
			_cost = getNumber (_x >> "cost");
			_lvlReq = getNumber (_x >> "LevelRequire");
			_index = _reqList lbAdd _dispName;
			_data = _reqList lbSetData[_index, _class];
			_value = _reqList lbSetValue[_index,  _cost];	
			if (DIS_CurLevel < _lvlReq) then
			{
				_reqList lbSetColor [_index,[0.99,0.03,0,1]];
			};					
		} forEach _abilityCfgs;
			// add players
			_plrs = allPlayers - entities "HeadlessClient_F";
		{
			// get players rank or role icon maybe?
			_picture = "\A3\ui_f\data\gui\cfg\ranks\sergeant_gs.paa";

			_index = _plrsList lbAdd (name _x);
			_plrsList lbSetPicture [_index,  _picture];
			_plrsList lbSetPictureColor [_index, [1, 1, 1, 1]];
			_text = format ["%1",_x];
			_data = _plrsList lbSetData[_index,(netId _x)];
		} forEach _plrs;

		/* change to however you have the other cam working
		I lost the one I had working and cant figure it out again

		_distance = 10;
		_plr = vehicle player;
		_dir = (getDir _plr) + 25;
		_height = 5;
		_camPos = [_plr, _distance, _dir] call BIS_fnc_relPos;
		_camPos set [2, _height];
		plrView ctrlSetText "#(argb,256,256,1)r2t(rendertar,1.0);";
		tabletCam = "camera" camCreate _camPos;
		tabletCam cameraEffect ["Internal", "Back", "rendertar"];
		tabletCam camPrepareFOV 0.700;
		tabletCam camPrepareTarget _plr;
		tabletCam camCommitPrepared 0;

		while {!(isNull _display)} do
		{
			_camTarget = camTarget tabletCam;
			_camPos = [_camTarget, _distance, _dir] call BIS_fnc_relPos;
			_camPos set [2, _height];
			tabletCam camPreparePos _camPos;
			tabletCam camCommitPrepared 0.025;
			waitUntil {camCommitted tabletCam};
			_dir = _dir - 0.5;
		};
		tabletCam cameraEffect ["terminate","back"];
		camDestroy tabletCam;
		*/
		//If the player is below level 20, have the ? button fade in and out quickly.
		if (DIS_CurLevel < 20) then
		{
			while {!(isNull _display)} do
			{
				_Question ctrlSetFade 0.9;
				_Question ctrlCommit 0.5;
				sleep 0.5;
				_Question ctrlSetFade 0;
				_Question ctrlCommit 0.5;
				sleep 0.5;
			};
		};
		
		};
};
dis_fnc_TabRequestSel =
{
	params ["_missionList","_index"];
	private _reqList = ((findDisplay 33000) displayCtrl (34000));
	private _reqInfo = ((findDisplay 33000) displayCtrl (36001));
	private _moneyEdit = ((findDisplay 33000) displayCtrl (39000));
	private _abClass = _reqList lbData _index;
	if (_abClass isEqualTo "MoneySend") then {_moneyEdit ctrlShow true;} else {_moneyEdit ctrlShow false};
	private _cost = _reqList lbValue _index;
	private _description = getText (missionConfigFile >> "CfgTablet" >> "CfgAbilities" >> _abClass >> "description");
	private _ReqLvl = getNumber (missionConfigFile >> "CfgTablet" >> "CfgAbilities" >> _abClass >> "LevelRequire");
	_reqInfo ctrlSetStructuredText parseText format ["<t align='left' shadow='true' shadowColor='#000000' size='0.8'>Cost: $%1<br/>Required Level: %3</t><br/><t align='left' shadow='true' shadowColor='#000000' size='0.8'>%2</t>",_cost,_description,_ReqLvl];

};
dis_fnc_TabMoneyConfirm =
{
	private _moneyEdit = ((findDisplay 33000) displayCtrl (39000));
	private _plrsList = ((findDisplay 33000) displayCtrl (35000));
	_index = lbCurSel _plrsList;
	systemChat str _index;
	if !(_index isEqualTo -1) then // something is selected
	{
		// data doesnt work
		_data = _plrsList lbData _index;
		private _GivePlayer = objectFromNetId _data;
		_editTxt = ctrlText _moneyEdit;
		_amount = parseNumber _editTxt;
		
		//Send that money!
		if !(alive _GivePlayer) exitWith {systemChat "Player is not alive!"};
		if ((DIS_PCASHNUM - _amount) < 0) exitWith {systemchat "You don't have enough money.";if (playerSide isEqualTo west) then {playsound "EVAInsufficentFunds"} else {playsound "LEGIONInsufficentFunds"};};
		systemChat format ["You sent $%2 to %1",(name _GivePlayer),_amount];
		DIS_PCASHNUM = DIS_PCASHNUM - _amount;
		if (playerSide isEqualTo west) then {playsound "EVAFundsTransferred"} else {playsound "LEGIONFundsTransferred"};
		[
			[_GivePlayer,player,_amount],
			{
				params ["_You","_SentPlayer","_amount"];
				systemChat format ["You recieved $%2 from %1",(name _SentPlayer),_amount];
				DIS_PCASHNUM = DIS_PCASHNUM + _amount;
			}
	
		] remoteExec ["bis_fnc_Spawn",_GivePlayer]; 
		
		

	}else {hint "Select a player to send money to"};


};
dis_fnc_TabReqConfirm =
{
	private _reqList = ((findDisplay 33000) displayCtrl (34000));
	private _reqInfo = ((findDisplay 33000) displayCtrl (36001));
	_index = lbCurSel _reqList;
	if !(_index isEqualTo -1) then // something is selected
	{
		_abClass = _reqList lbData _index;
		_LvlReq = getNumber (missionConfigFile >> "CfgTablet" >> "CfgAbilities" >> _abClass >> "LevelRequire");
		if (DIS_CurLevel < _LvlReq) exitWith
		{
			hint "YOU ARE TOO LOW OF A LEVEL.";
		};		
		_cost = _reqList lbValue _index;
		_codeString = getText (missionConfigFile >> "CfgTablet" >> "CfgAbilities" >> _abClass >> "confirmCode");
		_codeCompile = compile _codeString;
		call _codeCompile;
	}
	else 
	{
		hint "Select a request to make";
	};

};

dis_fnc_OpenArsenal =
{
	closeDialog 2;
	[] spawn
	{
		private ["_Building", "_Type", "_BarrackList", "_DI", "_NearestBuilding", "_PlayersLoadout", "_CashAmount", "_CameraActive","_Structures"];
		private _Structures = "";
		if ((side player) isEqualTo West) then
		{
			_Structures = W_BuildingList;
		}
		else
		{
			_Structures = E_BuildingList;
		};

		if (isNil "_Structures") exitWith
		{
			_DI = "NOT INITIALIZED YET...COME BACK SOON.";
			hint format ["%1", _DI];
		};

		_BarrackList = [];
		{
			_Building = _x select 0;
			if !(isNil "_Building") then
			{
				_Type = _x select 1;
				if (_Type isEqualTo "Barracks" || _Type isEqualTo "PHQ") then {_BarrackList pushback (_x select 0);};
			};
		} foreach _Structures;

		if (_BarrackList isEqualTo []) exitWith
		{
			_DI = "NO BARRACKS CREATED";
			hint format ["%1", _DI];
		};

		_NearestBuilding = [_BarrackList,player,true] call dis_closestobj;
		if (_NearestBuilding distance player > 100) exitWith
		{
			_DI = "TOO FAR FROM BARRACKS";
			hint format ["%1", _DI];
		};

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
			if (_x in CfgRucksArray) then {_CashAmount = _CashAmount + (getNumber(configfile >> "CfgVehicles" >> _x >> "maximumLoad"));};
			if (_x in CfgLightMagazine) then {_CashAmount = _CashAmount + 10;};
			if (_x in CfgPistolMagazine) then {_CashAmount = _CashAmount + 5;};
			if (_x in CfgHeavyMagazine) then {_CashAmount = _CashAmount + 15;};
			if (_x in CfgLauncherMagazine) then {_CashAmount = _CashAmount + 25;};
			if (_x in CfgFlareMagazine) then {_CashAmount = _CashAmount + 5;};
			if (_x in CfgGrenadeMagazine) then {_CashAmount = _CashAmount + 10;};
			if (_x in CfgUnknownMagazine) then {_CashAmount = _CashAmount + 5;};

		} foreach _PlayersLoadout;

		KOZ_ARSENALOPEN = true;

		["Open",true] spawn BIS_fnc_arsenal;

		[player,_CashAmount,_PlayersLoadout] spawn dis_ArsenalShop;

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

dis_fnc_TabletOpen =
{
	disableSerialization;
	if (isNull (findDisplay 27000)) then {createDialog "RscDisTablet";};
	private _playerInfo = ((findDisplay 27000) displayCtrl (27400));
	private _tabletTitleText = ((findDisplay 27000) displayCtrl (27500));
	// Define Mission Name
	private _missionName = "DISSENSION V1.0";
	_tabletTitleText ctrlSetStructuredText (parseText format ["<t align='center'>%1</t>", _missionName]);
	_tabletTitleText ctrlSetTextColor [1,1,1,0.5];
	_playerInfo ctrlEnable false;
	null = [] spawn dis_fnc_TabPlrOpen;
	
	while {!(isNull (findDisplay 27000))} do
	{
		// Get players cash and update
		private _plrInfoText = DIS_PCASHNUM;
		_playerInfo ctrlSetStructuredText (parseText format ["<t align='right'>%1 %2</t>", name player, _plrInfoText]);
		sleep 1;
	};
};
dis_fnc_TabClose =
{
	{
		if !(isNull (findDisplay _x)) then
		{
			(findDisplay _x) closeDisplay 0;
		};
	} forEach [30000,32000,33000];

};
dis_fnc_TabCommanderOpen =
{

	if (isNull (findDisplay 32000)) then
	{
		_display = findDisplay 46 createDisplay "RscDisTabCommander";
		private _map = ((findDisplay 32000) displayCtrl (32100));
	};

	_infoText = ((findDisplay 32000) displayCtrl (32201));
	_ordersTitle = ((findDisplay 32000) displayCtrl (32300));
	_ordersList = ((findDisplay 32000) displayCtrl (32301));
	_missionsTitle = ((findDisplay 32000) displayCtrl (32400));
	_missionsList = ((findDisplay 32000) displayCtrl (32401));
	private _Tutorials = ((findDisplay 27000) displayCtrl (27303));
	_Tutorials ctrlShow false;	
	
	lbClear _ordersList;
	lbClear _missionsList;
	_ordersText = "Orders";
	private _plrSide = side player call BIS_fnc_sideID;
	
	_missionsText = "Missions";
	_ordersTitle ctrlSetStructuredText (parseText format ["<t align='center' shadow='true' shadowColor='#000000' size='0.8'>%1</t>", _ordersText]);
	_missionsTitle ctrlSetStructuredText (parseText format ["<t align='center' shadow='true' shadowColor='#000000' size='0.8'>%1</t>", _missionsText]);

	// Add Commander Info
	private _Side = "WUT";
	private _Comm = objNull;
	private _Resources = W_RArray; //W_RArray = [W_Oil,W_Power,W_Cash,W_Materials];
	private _Tickets = Dis_BluforTickets;
	if (side (group player) isEqualTo WEST) then {_Side = W_CommanderInfo;_Comm = Dis_WestCommander} else {_Side = E_CommanderInfo;_Comm = Dis_EastCommander;_Resources = E_RArray;_Tickets = Dis_OpforTickets;};
	
	
	_commName = format ["NAME: %1",(_Side select 0)];
	_commDOB = format ["BORN: %1",(_Side select 1)];
	_commFocus= format ["FOCUS: %1",(_Side select 2)];
	_commCash = format ["CASH: %1",(_Resources select 2)];
	_commUnits = format ["UNIT RESERVES: %1",_Tickets];
	_commInfl = format ["POWER: %1",(_Resources select 1)];
	_commMats = format ["MATERIALS: %1",(_Resources select 3)];
	_commOil = format ["OIL: %1",(_Resources select 0)];
	_commStyle = format ["STYLE: %1 - %2", (_Side select 3 select 0),(_Side select 3 select 1)]; 

	_DI = format ["<br/>UNIT RESERVES:%10<br/>SIDE MATERIALS:%6<br/>SIDE CASH:%7<br/>SIDE OIL:%8<br/>SIDE INFLUENCE:%9<br/>NAME: %1<br/>BORN: %2<br/>ARMY FOCUS: %3<br/>WAR STYLE: %4<br/>%5<br/>",
	(_Side select 0),(_Side select 1),(_Side select 2),
	(_Side select 3 select 0),(_Side select 3 select 1),(_Resources select 0),(_Resources select 1),(_Resources select 2),(_Resources select 3),_Tickets];

	_infoText ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'>
	<t align='left'>%1</t></t></t>",_DI]);

	_infoText ctrlSetStructuredText parseText format ["<t align='left' shadow='true' shadowColor='#000000' size='0.8'>%1</t> <t align='right' shadow='true' shadowColor='#000000' size='0.8'>%2</t><br/><t align='left' shadow='true' shadowColor='#000000' size='0.8'>%3</t> <t align='right' shadow='true' shadowColor='#000000' size='0.8'>%4</t><br/><t align='left' shadow='true' shadowColor='#000000' size='0.8'>%5</t> <t align='right' shadow='true' shadowColor='#000000' size='0.8'>%6</t><br/><t align='left' shadow='true' shadowColor='#000000' size='0.8'>%7</t> <t align='right' shadow='true' shadowColor='#000000' size='0.8'>%8</t><br/><br/><t align='justify'shadow='true' shadowColor='#000000' size='0.8'>%9</t>",_commName, _commDOB,_commFocus,_commCash,_commUnits,_commInfl,_commMats,_commOil,_commStyle];

	// Add orders
	private _orders = [];
	private _newsArray = [];
	switch (_plrSide) do
	{
		case 0: {_orders = dis_ENewsArray;}; // opfor
		case 1:	{_orders = dis_WNewsArray;}; // blufor
	};

	
	{
		_indexOrder = _ordersList lbAdd (_x select 0);
		_orderData = _ordersList lbSetData[(lbSize _ordersList)-1, (str([(_x select 1),(getpos player)]))];
	} forEach _orders;

	// Add missions
	private _MissionArray = [];
	private _missions = [];
	switch (_plrSide) do
	{
		case 0: {_MissionArray = E_PlayerMissions;}; // opfor
		case 1:	{_MissionArray = W_PlayerMissions;}; // blufor
	};

	{
		_indexOrder = _missionsList lbAdd (_x select 0);
		_missionData = _missionsList lbSetData[(lbSize _missionsList)-1, (str _x)];
	} forEach _MissionArray;

};

// the following 2 functions can possibly be combined they fire when selecting someting in the orders or missions list
dis_fnc_TabOrderSel =
{

	disableSerialization;
	params ["_ordersList","_index"];
	private _infoText = ((findDisplay 32000) displayCtrl (32201));
	private _ctrlMap = ((findDisplay 32000) displayCtrl (32100));
	private _PREdata = _ordersList lbData _index;
	private _data = call compile _PREdata;
	//_data = "order details go here";
	_infoText ctrlSetStructuredText parseText format ["<t align='left' shadow='true' shadowColor='#000000' size='0.8'>%1</t>",(_data select 0)];
	// position needed for map
	ctrlMapAnimClear _ctrlMap;
	private _xMid = 0.618625 * safezoneW + safezoneX;
	private _yMid = 0.47 * safezoneH + safezoneY;
	_currentMapFocus = _ctrlMap ctrlMapScreenToWorld [_xMid,_yMid];
	if ((_data select 1) distance2D player > 2) then
	{
		_ctrlMap ctrlMapAnimAdd [0.5, 0.9, _currentMapFocus];
		_ctrlMap ctrlMapAnimAdd [0.25, 0.9, (_data select 1)];
		_ctrlMap ctrlMapAnimAdd [0.25, 0.1, (_data select 1)];
		ctrlMapAnimCommit _ctrlMap;
	};
};

dis_fnc_TabMissionSel =
{

	disableSerialization;
	params ["_missionList","_index"];
	_infoText = ((findDisplay 32000) displayCtrl (32201));
	_ctrlMap = ((findDisplay 32000) displayCtrl (32100));
	private _data = _missionList lbData _index;
	private _DataCompile = call compile _data;
	private _MissionTitle = _DataCompile select 0;
	private _MissionDescription = _DataCompile select 1;
	private _MissionData = _DataCompile select 2;
	private _MissionObj = objnull;
	private _MissionPos = (getposWorld player);
	private _AssignedGroup = (groupFromNetId (_DataCompile select 3 select 0));
	if (_AssignedGroup isEqualTo []) then {_AssignedGroup = "NONE";};
	
	
	//		DIS_MissionID = DIS_MissionID + 1;
	//		E_PlayerMissions pushback ['SUPPLY POINT',format ['The supply point, located at %1, is full and needs transport to the nearest structure.',(mapGridPosition _Building)],[(netId _Building),_ReturnLocPos],[],DIS_MissionID];	
	switch (_MissionTitle) do 
	{
		case "SUPPLY POINT":
		{
			_MissionObj = objectFromNetId (_MissionData select 0);
			_MissionPos = getPosWorld _MissionObj;
		};	
	};
	
	

	//_data = "mission details go here";
	_infoText ctrlSetStructuredText parseText format ["<t align='left' shadow='true' shadowColor='#000000' size='0.8'>ASSIGNED GROUP: %2 <br/> %1</t>",_MissionDescription,(groupId _AssignedGroup)];
	// position needed for map
	ctrlMapAnimClear _ctrlMap;
	_xMid = 0.618625 * safezoneW + safezoneX;
	_yMid = 0.47 * safezoneH + safezoneY;
	_currentMapFocus = _ctrlMap ctrlMapScreenToWorld [_xMid,_yMid];
	_ctrlMap ctrlMapAnimAdd [0.5, 0.9, _currentMapFocus];
	_ctrlMap ctrlMapAnimAdd [1, 0.9, _missionPos];
	_ctrlMap ctrlMapAnimAdd [1, 0.05, _missionPos];
	ctrlMapAnimCommit _ctrlMap;
};
dis_fnc_TabAcceptMission =
{
	//THIS FUNCTION IS CURRENTLY NOT USED. LOOK AT _this call DIS_fnc_AcceptMission
	_missionsList = ((findDisplay 32000) displayCtrl (32401));
	_index = lbCurSel _missionsList;
	if !(_index isEqualTo -1) then
	{
		_data = _missionsList lbData _index;
	};
};


dis_fnc_TabPurchVeh =
{
	private _vehTree = ((findDisplay 30000) displayCtrl (30201));
	private _index = tvCurSel _vehTree;
	private _CashAmount = _vehTree tvValue _index;
	private _Tutorials = ((findDisplay 27000) displayCtrl (27303));
	private _VehicleInfoObj = DIS_CurVehSel;
	private _GTextures = "NoTex";
	private _CompAnims = [];
	if !(isNil "_VehicleInfoObj") then
	{
		_GTextures = getObjectTextures _VehicleInfoObj;
		private _GAnims = getArray(configFile >> "CfgVehicles" >> (typeof _VehicleInfoObj) >> "animationList");
		{
			if (_x isEqualType "") then
			{
				private _phase = _VehicleInfoObj animationSourcePhase _x;
				_CompAnims pushback [_x,_phase];
			};
			
		} foreach _GAnims;
	};
	
	_Tutorials ctrlShow false;	
	if ((count _index) isEqualTo 2) then // vehicle and not vehicle group is selected
	{

		private _classname = _vehTree tvData _index;
		if (isNil "_classname") exitWith {};
		//Lets create a marker near the closest structure. For now it doesn't matter what the structure is - as long as the necessary buildings are available.
		private _HeavyFactory = false;
		private _LightFactory = false;
		private _AirField = false;
		private _Aircraft = false;
		private _PlayerSide = "I FIGHT FOR NO MAN";
		private _BuildingList = "NO BUILDINGS FOR CHU";
	
		if (side (group player) isEqualTo WEST) then
		{
			_Playerside = "West";
			_BuildingList = W_BuildingList;
		}
		else
		{
			_Playerside = "East";
			_BuildingList = E_BuildingList;
		};
	
		
		private _BuildingA = [];
		{
			private _StructureName = _x select 1;
			private _Structure = _x select 0;
			_BuildingA pushback _Structure;
			if (_StructureName isEqualTo "Light Factory") then {_LightFactory = true;};
			if (_StructureName isEqualTo "Heavy Factory") then {_HeavyFactory = true;};
			if (_StructureName isEqualTo "Air Field") then {_AirField = true;};
	
		} foreach _BuildingList;
		
		if (_classname in CfgLightArmorsArray && !(_LightFactory)) exitWith {systemChat "There is no light factory!";};
		if (_classname in CfgHeavyArmorsArray && !(_HeavyFactory)) exitWith {systemChat "There is no heavy factory!";};
		if ((_classname in CfgHelicoptersArray || _classname in CfgPlanesArray) && !(_AirField)) exitWith {systemChat "There is no air field!";};
	
		
		private _ClosestStructure = [_BuildingA,(getpos player),true] call dis_closestobj;
		private _ClosestStructureP = getpos _ClosestStructure;
		if (_ClosestStructureP distance (getpos player) > 300) exitWith {systemChat "YOU ARE TOO FAR FROM A STRUCTURE TO SPAWN IN A VEHICLE.";};
		private _rnd = random 100;
		private _dist = (_rnd + 25);
		private _dir = random 360;
		private _position = [(_ClosestStructureP select 0) + (sin _dir) * _dist, (_ClosestStructureP select 1) + (cos _dir) * _dist, 0];
		private _list = _position nearRoads 1000;
		private _CRoad = [];
	
		if !(_list isEqualTo []) then
		{
			_CRoad = getpos ([_list,_position,true] call dis_closestobj);
		}
		else
		{
			_CRoad = _position;
		};
	
		private _positionFIN = _CRoad findEmptyPosition [0,150,"B_Heli_Transport_03_F"];
		if (_positionFIN isEqualTo []) then {_positionFIN = _CRoad};
		private _PreviewCost = DIS_PCASHNUM - _CashAmount;
		if (_PreviewCost < 0) exitWith {};
	
	
		private _dis_new_veh = objNull;
		
		private _UAV = getNumber(configfile >> "CfgVehicles" >> _classname >> "isUav");
		if (_UAV isEqualTo 1) then
		{
			if (_classname isKindOf "Air") then
			{
				_dis_new_veh = createVehicle [_classname, _positionFIN, [], 0, "FLY" ];
				createVehicleCrew _dis_new_veh;
				{(group _x) setVariable ["DIS_IMPORTANT",true,true];} foreach (crew _dis_new_veh);
				_dis_new_veh call dis_fnc_RearmRep;
				player connectTerminalToUAV _dis_new_veh;
				closeDialog 2;			
			}
			else
			{
				_dis_new_veh = createVehicle [ _classname,_positionFIN, [], 0, "CAN_COLLIDE" ];
				createVehicleCrew _dis_new_veh;
				{(group _x) setVariable ["DIS_IMPORTANT",true,true];} foreach (crew _dis_new_veh);		
				_dis_new_veh call dis_fnc_RearmRep;
				player connectTerminalToUAV _dis_new_veh;			
				closeDialog 2;			
			};
		}
		else
		{
			if (_classname isKindOf "Air") then
			{
				_dis_new_veh = createVehicle [_classname, _positionFIN, [], 0, "FLY" ];
				_dis_new_veh call dis_fnc_RearmRep;
				if (_classname isKindOf "Plane") then
				{
					_vel = velocity _dis_new_veh;
					_dir = direction _dis_new_veh;
					_speed = 1000;
					_dis_new_veh setVelocity [
						(_vel select 0) + (sin _dir * _speed),
						(_vel select 1) + (cos _dir * _speed),
						(_vel select 2)
					];
					_dis_new_veh setPosATL [ ( position _dis_new_veh select 0 ), ( position _dis_new_veh select 1 ),800];
				};
				closeDialog 2;
			}
			else
			{
			
				if (_classname isKindOf "Ship") then
				{
					_positionFIN = [_positionFIN, 5, 2000, 2, 2, 1, 0,[],[_positionFIN,_positionFIN]] call BIS_fnc_findSafePos;
					hint "BOAT";
				};
			
				_dis_new_veh = createVehicle [_classname,_positionFIN, [], 0, "CAN_COLLIDE" ];
				_dis_new_veh setpos _positionFIN;
				_dis_new_veh call dis_fnc_RearmRep;
				closeDialog 2;
			};
		};
		if !(_GTextures isEqualTo "NoTex") then
		{
			_count = 0;
			{
				_dis_new_veh setObjectTextureGlobal [ _count, _x ];
				_count = _count + 1;
			} forEach _GTextures;
			
			
			{
				_dis_new_veh animateSource [(_x select 0),(_x select 1)]; 
			} foreach _CompAnims;
			
			
		};
		
		_dis_new_veh allowdamage false;
		_dis_new_veh spawn {sleep 30; _this allowdamage true;};
		_dis_new_veh setVariable ["DIS_PLAYERVEH",true,true];
		clearWeaponCargoGlobal _dis_new_veh;
		clearMagazineCargoGlobal _dis_new_veh;
		clearItemCargoGlobal _dis_new_veh;
		clearBackpackCargoGlobal _dis_new_veh;
		
		player allowdamage false;
		DIS_PCASHNUM = DIS_PCASHNUM - _CashAmount;
		player moveinAny _dis_new_veh;
		[player,_dis_new_veh] call DIS_fnc_VehicleLock;
		playsound "Purchase";
		[] spawn {sleep 10;player allowdamage true;};		
		};

};
dis_fnc_TabPurchStruc =
{
	_strucTree = ((findDisplay 30000) displayCtrl (30700));
	_index = tvCurSel _strucTree;
	if ((count _index) isEqualTo 2) then // vehicle and not vehicle group is selected
	{
		private _data = _strucTree tvData _index;
		private _cost = _strucTree tvValue _index;
		private _PreviewCost = DIS_PCASHNUM - _cost;
		if (_PreviewCost < 0) exitWith {};


		private _dis_new_veh = objNull;
		if (_data in CfgFortificationArray || _data in CfgObjectsArray) exitWith
		{
			private _CargoBox = player getVariable ["DIS_CargoBox",nil];
			
			//If the cargobox is nil then we need to create the player's cargo box.
			if (isNil "_CargoBox") then
			{
				_CargoBox = createvehicle ["Land_Cargo10_red_F",(getposATL player),[],15,"None"];
				player setvariable ["DIS_CargoBox",_CargoBox];
				_CargoBox setvariable ["DIS_PLAYERVEH",true,true];
	
				[
					[_CargoBox],
					{
						if !(hasInterface) exitWith {};
						params ["_CargoBox"];
						_DeployAction = _CargoBox addAction ["Deploy Fortifications", {[] spawn DIS_fnc_DeployFortification}];
					}	
				] remoteExecCall ["BIS_fnc_call",0,_CargoBox];	
				
				clearWeaponCargoGlobal _CargoBox;
				clearMagazineCargoGlobal _CargoBox;
				clearItemCargoGlobal _CargoBox;
				clearBackpackCargoGlobal _CargoBox;
				_CargoBox allowdamage false;
				_CargoBox setmass 10;
				[] call DIS_fnc_3DMarker;
				if (isNil "DIS_FortificationArray") then
				{
					DIS_FortificationArray = [];
				};		
			};
			if (!(alive _CargoBox)) then
			{
				_CargoBox = createvehicle ["Land_Cargo10_red_F",(getposATL player),[],15,"None"];
				player setvariable ["DIS_CargoBox",_CargoBox];
				_CargoBox setvariable ["DIS_PLAYERVEH",true,true];
				
				[
					[_CargoBox],
					{
						if !(hasInterface) exitWith {};
						params ["_CargoBox"];
						_DeployAction = _CargoBox addAction ["Deploy Fortifications", {[] spawn DIS_fnc_DeployFortification}];
					}	
				] remoteExecCall ["BIS_fnc_call",0,_CargoBox];
				
				clearWeaponCargoGlobal _CargoBox;
				clearMagazineCargoGlobal _CargoBox;
				clearItemCargoGlobal _CargoBox;
				clearBackpackCargoGlobal _CargoBox;
				_CargoBox allowdamage false;
				_CargoBox setmass 10;
				[] call DIS_fnc_3DMarker;
				if (isNil "DIS_FortificationArray") then
				{
					DIS_FortificationArray = [];
				};				
			};
			if (_CargoBox distance2D player > 1000) then
			{
				private _PPos = getpos player;
				private _positionFIN = [_PPos, 5, 50, 2, 0, 0, 0,[],[_PPos,_PPos]] call BIS_fnc_findSafePos;	
				_CargoBox setpos _positionFIN;
			};
			DIS_FortificationArray pushback _data;
			DIS_PCASHNUM = DIS_PCASHNUM - _cost;
			playsound "Purchase";		
		};
		if (_data isKindOf "Thing") exitWith 
		{

		};
	};
};
dis_fnc_TabPurchOpen =
{

	if (isNull (findDisplay 30000)) then
	{
		_display = findDisplay 46 createDisplay "RscDisTabPurchase";
		private _vehTree = _display displayCtrl (30201);
		{(_display displayCtrl (_x)) ctrlShow false;} forEach [30201,30202,30500,30600,30601,30602,30603,30700,30701];

		private _Arsenal = (uiNamespace getVariable "DIS_TABPURC");
		if !(isNil "_Arsenal") then {(_Arsenal displayCtrl (30100)) ctrlRemoveAllEventHandlers "ButtonClick";(_Arsenal displayCtrl (30100)) ctrlAddEventHandler ["ButtonClick","_this call dis_fnc_OpenArsenal"];};		
		// for testing need to merge with dissension

		// load vehs need to get groups(cars, planes), display name, class, and maybe cost
	private _Mod = "Mod" call BIS_fnc_getParamValue;
	private _Vrt = player getVariable ["DIS_HQ",""];	
	{
		private _AddedA = [];
		private _trunk = _vehTree tvAdd [[],(_x select 1)];
		private _arr = _x select 0;
		{
			
			private _displayName = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
			//if (_x isEqualTo "Land_Research_HQ_F") then {_displayName = "Player Base HQ"};
			private _picture = (getText(configFile >> "cfgVehicles" >> _x >> "icon"));
			private _HasIconCheck = [".paa",_picture] call BIS_fnc_inString;
			if !(_HasIconCheck) then
			{
				_PictureCompiled = call compile _picture;
				if !(isNil "_PictureCompiled") then
				{
					_picture = _PictureCompiled;
				};
			};			
			
			//Blufor Side = 1
			//Opfor Side = 0
			private _plrSide = side player call BIS_fnc_sideID;
			private _EnmySide = 0;
			if (LIBACTIVATED) then
			{
				if (_plrSide isEqualTo 1) then {_plrSide = 2;_EnmySide = 1;} else {_plrSide = 1;_EnmySide = 2;};
			}
			else
			{
				if (_plrSide isEqualTo 1) then {_EnmySide = 0;} else {_EnmySide = 1;};
			};
			
			
			if (!(_EnmySide isEqualTo getNumber(configfile >> "CfgVehicles" >> _x >> "side")) && {!(_displayName in _AddedA)}) then
			{
				if ((!(_x isEqualTo "B_SAM_System_01_F") && {!(_x isEqualTo "B_SAM_System_02_F")} && {!(_x isEqualTo "B_AAA_System_01_F")}) || {!(_Vrt isEqualTo "")}) then
				{
					//UNSUNG MOD
					if (_Mod isEqualTo 4) then
					{
						if (["uns", _x] call BIS_fnc_inString) then
						{
							_AddedA pushback _displayName;
							_branch = _vehTree tvAdd [[_trunk],_displayName];		
							_vehTree tvSetData [ [_trunk,_branch], _x];
							_vehTree tvSetValue [ [_trunk,_branch], 1000];						
						};
					}
					else
					{
						//VANILLA
						_AddedA pushback _displayName;
						_branch = _vehTree tvAdd [[_trunk],_displayName];		
						_vehTree tvSetData [ [_trunk,_branch], _x];
						_vehTree tvSetValue [ [_trunk,_branch], 1000];						
					};
				};
			};

		 } foreach _arr;
		} foreach [[CfgCarsArray,"Cars"],[CfgLightArmorsArray,"Light Armored"],[CfgHeavyArmorsArray,"Heavy Armored"],[CfgHelicoptersArray,"Helicopters"],[CfgPlanesArray,"Planes"],[CfgBoatsArray,"Boats"]];

		// add units
	_cfgRoles = "((configName (_x)) != 'Default') && ((configName (_x)) != 'Unarmed')"  configClasses (configFile >> "cfgRoles");
	private _WestRun = false;
	private _unitTree = _display displayCtrl (30600);
	private _UnitList = CfgOManArray;
	if (PlayerSide isEqualTo West) then
	{
		_WestRun = true;
		_UnitList = CfgBManArray;
	};
	_UBlacklist = ["Rifleman 4","Rifleman 5","AI"];
 	{
 		_role = configName _x;
 		_dispName = getText (_x >> "displayName");
		_trunk = _unitTree tvAdd [[], _dispName];

		{
			private _class = _x select 0;
			_unitRole = getText (configfile >> "CfgVehicles" >> _class >> "Role");
			if (_role isEqualTo _unitRole) then
			{
				private _cost = (_x select 1)/500;
				_dispName = getText (configfile >> "CfgVehicles" >> _class >> "displayName");
				if !(_dispName in _UBlacklist) then
				{
					_branch = _unitTree tvAdd [[_trunk],_dispName];
					_unitTree tvSetData [[_trunk,_branch], _class];
					_index params ["_vehGrpIndex","_vehIndex"];	
					_unitTree tvSetValue [[_trunk,_branch], _cost];
					_dlc = getText (configfile >> "CfgVehicles" >> _class >> "DLC");
						switch (_dlc) do
						{
							case "Mark":
							{
								_picture = "\A3\data_f_mark\logos\arma3_mark_logo_small_ca.paa";
								_unitTree tvSetPicture [[7,_trunk,_branch], _picture];
							};
	
							default
							{
								/* STATEMENT */
							};
						};
					//_tree tvSetPicture [[_trunk,_branch], _picture];
				};
			};
		} forEach _UnitList;
	} forEach _cfgRoles;

		// add structures
		private _structTree = _display displayCtrl (30700);
		private _Vrt = player getVariable ["DIS_HQ",""];	
		{
		private _trunk = _structTree tvAdd [[],(_x select 1)];
	
		private _arr = _x select 0;
		{
			_displayName = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
			if (_x isEqualTo "Land_Research_HQ_F") then {_displayName = "Player Base HQ"};
			
			
			if (_plrSide isEqualTo getNumber(configfile >> "CfgVehicles" >> _x >> "side")) then
			{
				if ((!(_x isEqualTo "B_SAM_System_01_F") && {!(_x isEqualTo "B_SAM_System_02_F")} && {!(_x isEqualTo "B_AAA_System_01_F")}) || {!(_Vrt isEqualTo "")}) then
				{
					_branch = _structTree tvAdd [[_trunk],_displayName];
					_structTree tvSetData [ [_trunk,_branch], _x];
					private _cost = getNumber(configfile >> "CfgVehicles" >> _x >> "cost");
					_structTree tvSetValue [ [_trunk,_branch],(_cost/10)];
				};
			};

			if (_displayName isEqualTo "Player Base HQ" && {_Vrt isEqualTo ""}) then
			{
					_branch = _structTree tvAdd [[_trunk],_displayName];
					_structTree tvSetData [ [_trunk,_branch], _x];
					private _cost = getNumber(configfile >> "CfgVehicles" >> _x >> "cost");
					_structTree tvSetValue [ [_trunk,_branch],_cost];					
			}
			else
			{
					if !(_Vrt isEqualTo "") then
					{
						if (_x isEqualTo "Land_Research_house_V1_F") then {_displayName = "Player Respawn Point"};
						if (_x isEqualTo "Land_Radar_Small_F") then {_displayName = "Comms Tower"};					
						if ("thingX" isEqualTo getText(configfile >> "CfgVehicles" >> _x >> "simulation")) then
						{
							_branch = _structTree tvAdd [[_trunk],_displayName];
							_structTree tvSetData [ [_trunk,_branch], _x];
							private _cost = getNumber(configfile >> "CfgVehicles" >> _x >> "cost");
							_structTree tvSetValue [ [_trunk,_branch],(_cost/10)];								
						};
						private _GetText = getText(configfile >> "CfgVehicles" >> _x >> "simulation");
						if (("house" isEqualTo _GetText || "tankX" isEqualTo _GetText) && {_x in CfgFortificationArray}) then
						{
							_branch = _structTree tvAdd [[_trunk],_displayName];
							_structTree tvSetData [ [_trunk,_branch], _x];
							private _cost = getNumber(configfile >> "CfgVehicles" >> _x >> "cost");
							_structTree tvSetValue [ [_trunk,_branch],(_cost/10)];								
						};
					};
			};
		 } foreach _arr;
		} foreach [[CfgObjectsArray,"Objects"],[CfgFortificationArray,"Player Construction"]];		
		
		
		
	};
};
dis_fnc_TabSwitchPurchTab =
{
		//private _Tutorials = ((findDisplay 27000) displayCtrl (27303));
		//_Tutorials ctrlShow false;
		//Destroy any active camera for the dialog
		private _I1 = uiNamespace getVariable ["DIS_CAM",objnull];
		private _I2 = uiNamespace getVariable ["DIS_Dummy",objnull];
		private _I3 = uiNamespace getVariable ["DIS_CamCtrl",objnull];;
		if !(isNull _I2) then {deleteVehicle _I2;};
		if !(isNull _I3) then {ctrlDelete _I3;};
		if !(isNull _I1) then {camDestroy _I1};		
	{
		_ctrl = ((findDisplay 30000) displayCtrl (_x));
		if (_x in _this) then {_ctrl ctrlShow true;} else {_ctrl ctrlShow false;};
	} forEach [30201,30202,30500,30600,30601,30602,30603,30700,30701];
	
	{((findDisplay 30000) displayCtrl (_x)) ctrlSetText "";} forEach [30302,30402,30601];
	{((findDisplay 30000) displayCtrl (_x)) tvSetCurSel [-1];} forEach [30201,30600,30700];
};
dis_fnc_TabVehSel =
{
	disableSerialization;
	params ["_vehTree","_index"];
	_index params ["_vehGrpIndex","_vehIndex"];
	if ((count _index) isEqualTo 2) then // vehicle and not vehicle group is selected
	{
		private _modelCtrl = ((findDisplay 30000) displayCtrl (30202));
		private _infoTextL = ((findDisplay 30000) displayCtrl (30302));
		private _infoTextR = ((findDisplay 30000) displayCtrl (30402));
		_modelCtrl ctrlShow false;

		// get class and set model
		_class = _vehTree tvData _index;	
		_dummy = _class createVehicleLocal [0,0,0];
		_modelSize = sizeOf (typeOf _dummy);
		deleteVehicle _dummy;
		_modelPos = ctrlPosition _modelCtrl;
		_model = getText(configFile >> "cfgVehicles" >> _class >> "model");
		_modelPos set [1,(_modelSize * 1.5)];
		_modelCtrl ctrlSetPosition _modelPos;
		_modelCtrl ctrlSetModel _model;
		_modelCtrl ctrlShow false;

		// get vehicle weapons info
		private _CashAmount = 0;
		switch (_vehGrpIndex) do
		{
			case 0: {_CashAmount = 500;};	//cars
			case 1: {_CashAmount = 2000;};	//light
			case 2: {_CashAmount = 3000;};	//heavy
			case 3:	{_CashAmount = 4000;};	//helis
			case 4: {_CashAmount = 5000;};	//planes
			case 5: {_CashAmount = 325;};	//uav
			case 6: {_CashAmount = 25;}; //Objects
			default {_CashAmount = 0;};
		};		
				
		private _picture = (getText(configFile >> "cfgVehicles" >> _class >> "picture"));
		private _armor = getNumber(configfile >> "CfgVehicles" >> _class >> "armor");
		private _armorStructural = getNumber(configfile >> "CfgVehicles" >> _class >> "armorStructural");
		private _transport = [_class,true] call BIS_fnc_crewCount;
		private _weapons = [];
		private _weapArray = [];		
		if !(isNil "_armor") then {_CashAmount = _CashAmount + (_armor);}; //m113 = 200
		if (_armor < 1) then {_CashAmount = (_CashAmount)/50};
		if !(isNil "_armorStructural") then {_CashAmount = _CashAmount + (_armorStructural);}; //m113 = 350
		if !(isNil "_transport") then {_CashAmount = _CashAmount + (_transport * 50);}; //m113 = 9	


		
		_weaponsClass = getArray(configFile >> "cfgVehicles" >> _class >> "weapons");
		{
			_name = getText (configFile >> "cfgWeapons" >> _x >> "displayName");
			_weapons = _weapons + [_name];
		}forEach _weaponsClass;
		if (isClass (configFile >> "cfgVehicles" >> _class >> "Turrets" >> "M2_Turret")) then
			{
				_weapArray = getArray(configFile >> "cfgVehicles" >> _class >> "Turrets" >> "M2_Turret" >> "weapons");

			} else
			{
				_weapArray = getArray(configFile >> "cfgVehicles" >> _class >> "Turrets" >> "MainTurret" >> "weapons");
				_weapArray = _weapArray + (getArray(configFile >> "cfgVehicles" >> _class >> "Turrets" >> "FrontTurret" >> "weapons"));
				_weapArray = _weapArray + (getArray(configFile >> "cfgVehicles" >> _class >> "Turrets" >> "RearTurret" >> "weapons"));

			};
			{
				_name = getText (configFile >> "cfgWeapons" >> _x >> "displayName");
				_weapons = _weapons + [_name];
			}forEach _weapArray;
		    {
		        _cfgTurret = _x;
		        {
		        	_weapons pushBack (getText(configFile >> "cfgWeapons" >> _x >> "displayName"));
		           // _vehWeap pushBack [(getText(configFile >> "cfgWeapons" >> _x>> "displayName")),_x];
		        } forEach (getArray (_cfgTurret >> "weapons"));
		    } forEach ([_class] call BIS_fnc_getTurrets);
		    if ("Horn" in _weapons) then
		    {
					_weapons = _weapons - ["Horn"];
		    	//_index = _weapons find "Horn";
		    	//_weapons deleteAt (_weapons find "Horn");
		    };
		    if ((count _weapons) isEqualTo 0) then
		    {
		    	_weapons = "None";
		    }else
		    {
				_weapons = _weapons arrayIntersect _weapons;
				//_weapons = _weapons joinString ", ";
				_CashAmount = _CashAmount + (400 * (count _weapons));
			};
		_rounded = round (_CashAmount/100);
		_CashAmount = _rounded * 100;
		_vehTree tvSetValue [_index, _CashAmount];
		
		_infoTextL ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000' size='0.8'
		align='left'>
		<br/>Cost: %1
		<br/>Armor: %2
		<br/>Structural Armor: %3
		<br/>Seats: %4
		<br/>Weapons: %5
		<br/><img shadow='0.5'shadowColor='#000000' size='2.5' align='center' image = '%6'/>
		</t>",_CashAmount,_armor,_armorStructural,_transport,_weapons,_picture]);		
		
		// get vehicle description
		_description = getText (configFile >> "CfgVehicles" >> _class>> "Library" >> "libTextDesc");
		_infoTextR ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000' size='0.8'
		align='left'>%1
		</t>",_description]);

			
		/*
		sleep 2;
		private _dir = 1;
		private _angle = -1;
		while {alive _DIS_cam} do {
			_coords = [_DIS_Dummy,(_modelSize/2),_angle] call BIS_fnc_relPos;
			_coords set [2,1000];
		
			private _worldPos = positionCameraToWorld [0,-0.2,4];  
			_DIS_cam camPreparePos _worldPos;    
			_DIS_cam camCommitPrepared 0.001;  
		
			waitUntil {camCommitted _DIS_cam || !(alive _DIS_cam)};
		
			if (_dir == 0) then {_angle = _angle - 90} else {_angle = _angle + 90};
			if (_angle < -359) then {_angle = 0};
			if (_angle > 360) then {_angle = 0};
		
			}; 
			*/
			
			
		private _DIS_Dummy = objNull;
		if (true) then
		{
			private _I1 = uiNamespace getVariable ["DIS_CAM",objnull];
			private _I2 = uiNamespace getVariable ["DIS_Dummy",objnull];
			private _I3 = uiNamespace getVariable ["DIS_CamCtrl",objnull];;
			if !(isNull _I2) then {deleteVehicle _I2;};
			if !(isNull _I3) then {ctrlDelete _I3;};
			_DIS_Dummy = _class createVehicleLocal [0,0,1000];
			private _modelSize = _DIS_Dummy call BIS_fnc_boundingCircle;
			uiNamespace setVariable ["DIS_Dummy",_DIS_Dummy];
			_DIS_Dummy setpos [0,0,1000];
			_DIS_Dummy enableSimulation false;
			_DIS_Dummy allowDamage false;
			_DIS_CamCtrl = (findDisplay 27000) ctrlCreate ["RscPicture", -1];
			uiNamespace setVariable ["DIS_CamCtrl",_DIS_CamCtrl];
			//_DIS_CamCtrl ctrlSetPosition [(0.40 * safezoneW + safezoneX),(0.62 * safezoneH + safezoneY),(0.08 * safezoneW),(0.08 * safezoneH)];
			_DIS_CamCtrl ctrlSetPosition [(0.44 * safezoneW + safezoneX),(0.25 * safezoneH + safezoneY),(0.25 * safezoneW),(0.22 * safezoneH)];
			_DIS_CamCtrl ctrlSetText "#(argb,256,256,1)r2t(uavrtt,1.0);";	
			_DIS_CamCtrl ctrlShow true;
			_DIS_CamCtrl ctrlCommit 0;
			private _DIS_cam = "";
			if !(isNull _I1) then {_DIS_cam = _I1} else {_DIS_cam = "camera" camCreate [0,0,1000];_DIS_cam cameraEffect ["Internal", "Back", "uavrtt"];};
			uiNamespace setVariable ["DIS_CAM",_DIS_cam];				
			_DIS_cam camSetTarget _DIS_Dummy;	
			_DIS_cam camSetRelPos [(_modelSize/2),-1,0];
			_DIS_cam camCommit 1;					
			[_DIS_CamCtrl,_DIS_Dummy,_DIS_cam] spawn
			{
				params ["_DIS_Bck","_dummy","_DIS_cam"];
				while {!(isNull (findDisplay 27000))} do
				{
					sleep 0.001;
				};
				deleteVehicle _dummy;
				ctrlDelete _DIS_Bck;
				_DIS_cam cameraEffect ["terminate","back"];
				camDestroy _DIS_cam;
			};		
				private _light = "#lightpoint" createVehiclelocal [0,0,1000];
				_light setpos [0,0,1000];
				_light setLightFlareSize 1000;
				_light setLightBrightness 1000; 
				_light setLightIntensity 1000;
				_light setLightFlareMaxDistance 10000;
				_light setLightColor [1,1,1]; 
				_light setLightAmbient [1,1,1]; 
				_light attachTo [_DIS_Dummy, [0, 0, 10]]; 			
							
			
		};			
			
		//If not created, create a tree that allows players to change the textures of the vehicle
		if !(isNil "DIS_Vehtv") then {ctrlDelete DIS_Vehtv;};
		if !(isNil "DIS_CurVehSel") then {deleteVehicle DIS_CurVehSel;DIS_CurVehSel = objNull;};
		DIS_Vehtv = (findDisplay 27000) ctrlCreate ["RscTree", -1];
		DIS_Vehtv ctrlSetFont "EtelkaMonospacePro"; 
		DIS_Vehtv ctrlSetFontHeight 0.025;
		DIS_Vehtv ctrlSetPosition [(0.7* safezoneW + safezoneX),(0.22 * safezoneH + safezoneY),(0.001* safezoneW),(0.001 * safezoneH)];
		DIS_Vehtv ctrlCommit 0;
		DIS_Vehtv ctrlSetPosition [(0.7* safezoneW + safezoneX),(0.22 * safezoneH + safezoneY),(0.15* safezoneW),(0.26 * safezoneH)];
		DIS_Vehtv ctrlCommit 0.25;
		DIS_Vehtv ctrlSetBackgroundColor [0,0,0,0.85];
		DIS_Vehtv tvAdd [[],"CAMO"];
		DIS_Vehtv tvAdd [[],"ADDITIONS"];
		DIS_Vehtv tvSetTooltip [[0],"SELECT WHICH CAMO WILL SPAWN WITH THE VEHICLE."];
		DIS_Vehtv tvSetTooltip [[1],"ADD OR REMOVE ITEMS FROM THE VEHICLE"];
		private _TexturesList  = (configFile/"CfgVehicles"/_class/"TextureSources") call BIS_fnc_getCfgSubClasses; //_DIS_Dummy
		private _AnimList =  getArray(configFile >> "CfgVehicles" >> _class >> "animationList");
		{
			private _Disp = getText(configfile >> "CfgVehicles" >> _class >> "TextureSources" >> _x >> "displayName");
			private _Textures = getArray(configfile >> "CfgVehicles" >> _class >> "TextureSources" >> _x >> "textures");
			private _New = DIS_Vehtv tvAdd [[0],_Disp];
			DIS_Vehtv tvSetData [[0,_New],(str _Textures)];
		} foreach _TexturesList;	

		{
			if (_x isEqualType "") then
			{
				private _New = DIS_Vehtv tvAdd [[1],_x];
				DIS_Vehtv tvSetColor [[1,_New], [0.96,0.09,0,1]];
			};
		} foreach _AnimList;
		
		DIS_Vehtv tvSetData [[1],(str _AnimList)];
		
		DIS_Vehtv tvExpand [0];
		DIS_Vehtv tvExpand [1];
		DIS_CurVehSel = _DIS_Dummy;
		
		DIS_TVCHNG = 
		{
			private _Category =  DIS_Vehtv tvtext [((_this select 1) select 0)];
			
			if (_Category isEqualTo "CAMO") then
			{
				private _Data =  call compile (DIS_Vehtv tvData (_this select 1));
				_count = 0;
				{
					DIS_CurVehSel setObjectTextureGlobal [ _count, _x ];
					_count = _count + 1;
				} forEach _Data;		
				DIS_Vehtv tvExpand [0];					
			}
			else
			{
				private _Addition =  DIS_Vehtv tvtext (_this select 1);
				private _Data = call compile (DIS_Vehtv tvData [1]);
				{
					if (_x isEqualTo _Addition) exitWith
					{
						private _phase = DIS_CurVehSel animationSourcePhase _Addition;
						private _NewM = 0;
						systemChat format ["PHASE: %1",_phase];
						if (_phase isEqualTo 0) then {_NewM = 1; DIS_Vehtv tvSetColor [(_this select 1), [0,0.81,0.01,1]];playsound "repair";}; 
						if (_phase isEqualTo 1) then {_NewM = 0; DIS_Vehtv tvSetColor [(_this select 1), [0.96,0.09,0,1]];playsound "repair";};
						DIS_CurVehSel enableSimulation true;
						DIS_CurVehSel animateSource [_Addition,_NewM];
						[] spawn {sleep 0.1;DIS_CurVehSel enableSimulation false;DIS_CurVehSel setpos [0,0,1000];};
					};				
				} foreach _Data;
				DIS_Vehtv tvExpand [1];
				//DIS_CurVehSel animateSource [_Data,0,true];  0.96,0.09,0,1
			};
		};
		
		DIS_Vehtv ctrlAddEventHandler ["TreeSelChanged","_this call DIS_TVCHNG"];
			
			
	/*
		while {ctrlShown _modelCtrl} do
		{
			_vectorDirAndUp = ctrlModelDirAndUp _modelCtrl;
			_vectorDir = _vectorDirAndUp select 0;
			_newVector = [_vectorDir,0.5] call BIS_fnc_rotateVector2D;
			_modelCtrl ctrlSetModelDirAndUp [_newVector,(_vectorDirAndUp select 1)];
			sleep 0.02;
		};
	*/
	};
};
dis_fnc_TabUnitSel =
{
	disableSerialization;
	params ["_unitsTree","_index"];
	_index params ["_unitRoleIndex","_unitIndex"];	
	if ((count _index) isEqualTo 2) then // Unit and not role selected
	{
		private _infoTextL = ((findDisplay 30000) displayCtrl (30302));
		private _infoTextR = ((findDisplay 30000) displayCtrl (30402));
		private _unitPic = ((findDisplay 30000) displayCtrl (30601));
		_class = _unitsTree tvData _index;
		_cost = _unitsTree tvValue _index;
		_weapons = getArray (configFile >> "cfgVehicles" >> _class >> "weapons");
		_weapNames = [];
		{
			if !(_x in ["Throw","Put"]) then
			{
				_weapNames pushBack (getText(configFile >> "cfgWeapons" >> _x>> "displayName"));
			};
		} forEach _weapons;
		_weapNames = _weapNames joinString ", ";
		_magazines = getArray (configFile >> "cfgVehicles" >> _class >> "magazines");
		_magNames = [];
		{
			_magNames pushBack (getText(configFile >> "cfgMagazines" >> _x>> "displayName"));
		} forEach _magazines;
		_magNames = _magNames arrayIntersect _magNames;
		_magNames = _magNames joinString ", ";
		_picture = getText (configFile >> "cfgVehicles" >> _class >> "editorPreview");
		_backpack = getText (configFile >> "cfgVehicles" >> _class >> "backpack");
		_backpackName = getText (configFile >> "cfgVehicles" >> _backpack >> "displayName");
		_infoTextL ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000' size='0.8'
		align='left'>Cost:<br/>%1<br/><br/>Weapons:<br/>%2
		</t>",_cost,_weapNames]);
		_infoTextR ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000' size='0.8'
		align='left'>Backpack:<br/>%1<br/><br/>Magazines:<br/>%2
		</t>",_backpackName,_magNames]);
		_unitPic ctrlSetText _picture;
	};
};
dis_fnc_TabStructSel =
{
	disableSerialization;
	params ["_strucTree","_index"];
	_index params ["_strucGrpIndex","_strucIndex"];
	if ((count _index) isEqualTo 2) then // vehicle and not vehicle group is selected
	{

		private _cost = _strucTree tvValue _index;	
		private _modelCtrl = ((findDisplay 30000) displayCtrl (30202));
		private _infoTextL = ((findDisplay 30000) displayCtrl (30302));
		private _infoTextR = ((findDisplay 30000) displayCtrl (30402));
		_modelCtrl ctrlShow false;

	
		// get class and set model
		_class = _strucTree tvData _index;
		_dummy = _class createVehicleLocal [0,0,0];
		_modelSize = sizeOf (typeOf _dummy);
		deleteVehicle _dummy;
		_modelPos = ctrlPosition _modelCtrl;
		_model = getText(configFile >> "cfgVehicles" >> _class >> "model");
		_modelPos set [1,(_modelSize * 5)];
		_modelCtrl ctrlSetPosition _modelPos;
		_modelCtrl ctrlSetModel _model;
		_modelCtrl ctrlShow true;
		hint str _class;
		private _description = "";
		private _CashAmount = 0;
			switch (_class) do 
			{
				case "Land_Research_HQ_F":
				{
					_description = "An HQ where you can spawn vehicles, get gear, and begin to create a fully functioning base. Beware, AI will attack it.";
					_CashAmount = 1000;
				};
				case "Land_Research_house_V1_F": 
				{
					_description = "A respawn point for all players. The commander can also use this as a barracks to spawn troops on - however, the commander will not actively seek to defend these locations. That's your duty.";
					_CashAmount = 600;
				};
				case "Land_Radar_Small_F": 
				{
					_description = "This small radar tower will alert you of any enemy presence within 300 meters of it's placement. However, this technology is only good if the enemy units are crouched or standing. Prone enemies will not alert this tower.";
					_CashAmount = 800;
				};
				case "Land_BagBunker_Large_F": 
				{
					_description = "A large bunker to shoot from.";
					_CashAmount = 200;
				};		
				case "Land_BagBunker_Small_F": 
				{
					_description = "A small bunker to shoot from.";
					_CashAmount = 100;
				};		
				case "Land_MobileLandingPlatform_01_F": 
				{
					_description = "A platform to land small helicraft on.";
					_CashAmount = 100;
				};		
				case "Land_Bunker_F": 
				{
					_description = "A hanger which can used to sell vehicles. This can also be used to empty vehicles of their cargo into a nearby container.";
					_CashAmount = 800;
				};
				case "Land_BagBunker_Tower_F":
				{
					_description = "A bigger bunker to shoot from.";
					_CashAmount = 400;					
				};
				case "Land_ConcreteHedgehog_01_F":
				{
					_description = "A hedgehod to limit the movement of vehicles.";
					_CashAmount = 50;							
				};
				case "Land_Cargo_Tower_V3_F":
				{
					_description = "A very large tower for a great view of the area. Very expensive.";
					_CashAmount = 2000;							
				};
				case "Land_Cargo_Tower_V1_F":
				{
					_description = "A very large tower for a great view of the area. Very expensive.";
					_CashAmount = 2000;							
				};
				case "B_SAM_System_03_F":
				{
					_description = "The MIM-145 Defender Surface-Air-Missile system was designed to protect NATO airspace against hostile intrusion. Typically found near high-value assets such as airfields and military bases to protect against long-range aerial threats. Armed with long-range Defender missiles, and connected to AN/MPQ-105 radar via data-link, this system is a serious threat to any opponent.";					
					_CashAmount = 5000;				
				};
				case "B_Radar_System_01_F":
				{
					_description = "The AN/MPQ-105 site is the primary component of the Defender system, and provides the launcher with the ability to lock onto targets. It has a maximum detection range of 16 km against aerial targets and 12 km against ground targets. It has a horizontal and vertical sweep angle of 120 degrees, but is dependent on where the radar dome is currently facing. All targets can be identified once they are within 12 km range of the radar site. It is able to track targets moving at speeds of up to 5,000 km/h.";				
					_CashAmount = 2000;				
				};				
				case "O_Radar_System_02_F":
				{
					_description = "The R-750 forms the main component of the S-750 AA system and is what enables the launcher to track and attack targets. Detection against aircraft is limited to 16 km and only 12 km against ground targets. Horizontal/vertical coverage extends out to an angle of 120 degrees in both directions, but is restricted to where the radar dome is facing. Targets can be recognised once they are within 12 km range of the R-750. It can only track targets that are moving at speeds of 5,000 km/h or less.";				
					_CashAmount = 2000;				
				};				
				case "O_SAM_System_04_F":
				{
					_description = "The S-750 Rhea Surface-Air-Missile system was designed by Russia to defend its airspace against hostile intrusion. The asset was adapted by CSAT based on a joint CSAT/Russian arms syndicate deal. Typically found near high-value assets such as airfields and military bases to protect against long-range aerial threats. Armed with long-range Rhea missiles, and connected to R-750 Cronus radar via data-link, this system is a serious threat to any opponent.";				
					_CashAmount = 5000;				
				};
				case "B_SAM_System_02_F":
				{
					_description = "The Centurion surface to air missile system was designed to protect NATO naval vessels from any possible aerial threats in medium to long range. Armed with radar-guided medium-range anti-air missiles. This asset is normally deployed in tandem with Spartan surface to air missile system to deny air superiority to the enemy.";				
					_CashAmount = 1500;				
				};				
				case "B_AAA_System_01_F":
				{
					_description = "The Praetorian anti-aircraft-artillery system was designed to protect NATO naval vessels from any possible aerial threats in close range. Armed with 20mm Minigun rounds, it’s a threat to respect for any opponent.";				
					_CashAmount = 1000;				
				};					
				case "B_SAM_System_01_F":
				{
					_description = "The Spartan surface to air missile system was designed to protect NATO naval vessels from any possible aerial threats in close range. Armed with infra-red guided short-range anti-air missiles. This asset is normally deployed in tandem with Centurion surface to air missile system to deny air superiority to the enemy.";				
					_CashAmount = 2000;				
				};			
				case "Land_IRMaskingCover_01_F":
				{
					_description = "A large tent that blocks even IR from peering inside.";				
					_CashAmount = 1000;				
				};
				case "Land_IRMaskingCover_02_F":
				{
					_description = "A small tent that blocks even IR from peering inside.";				
					_CashAmount = 1000;				
				};
				case "Land_TentHangar_V1_F":
				{
					_description = "A large hanger to leave vehicles.";				
					_CashAmount = 2000;				
				};				
				default 
				{
					private _Fullclass = [_class] call VCOM_fnc_classVehicle;
					private _parents = [_Fullclass,true] call BIS_fnc_returnParents;				
					if ("StaticWeapon" in _parents) then
					{
						_description = "Static Weapon. Does not include a body to man it.";
						_CashAmount = 150;
					}
					else
					{
						_description = "NO DESCRIPTION";
						_CashAmount = 50;					
					};
				};
			};

		
		_strucTree tvSetValue [ [_strucGrpIndex,_strucIndex],_CashAmount];
		// get vehicle weapons info
		_infoTextL ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000' size='0.8'
		align='left'>Cost: %1
		</t>",_CashAmount]);

		// get vehicle description
		_infoTextR ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000' size='0.8'
		align='left'>%1
		</t>",_description]);

		while {ctrlShown _modelCtrl} do
		{
			_vectorDirAndUp = ctrlModelDirAndUp _modelCtrl;
			_vectorDir = _vectorDirAndUp select 0;
			_newVector = [_vectorDir,0.5] call BIS_fnc_rotateVector2D;
			_modelCtrl ctrlSetModelDirAndUp [_newVector,(_vectorDirAndUp select 1)];
			sleep 0.02;
		};
	};
};
