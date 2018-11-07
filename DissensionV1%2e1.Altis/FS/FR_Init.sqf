private _FS = "TownFurniture" call BIS_fnc_getParamValue;
private _FN = "TownFurnitureNum" call BIS_fnc_getParamValue;
private _FD = "TownFurnitureDist" call BIS_fnc_getParamValue;
if (_FS isEqualTo 0) exitWith {};
//Let's define basic variables that we will use. Feel free to change these. This will impact performance.
FS_MB = _FN; //Maximum number of buildings that can be spawned in at once.
FS_DIST = _FD; //Distance from player for furniture to spawn in up to the maximum  number of buildings. The closest buildings always spawn in first.
FS_CA = true; //Always have the closest building to the player spawned in with furniture.
FS_ENABLED = true; //Is the furniture script enabled?
FS_SPWNEDLIST = [];
FS_CursorObjs = true;
//Land_i_House_Big_01_V3_F
//[] execVM "FS\FR_Init.sqf";

FS_DeadHouse =
{
	private _House = _this select 0;
	private _Lst = _House getVariable ["FS_SPWNOBJ",[]];
	{
		_x enableSimulation true;
		true;
	} count _Lst;
	
	_Lst spawn
	{
		sleep 15;
		{
			_x enableSimulation false;
			true;
		} count _this;
		sleep 30;
		{
			deleteVehicle _x;
			true;
		} count _this;
	};
};

FS_ACTSPWN = 
{
	private _houseN = (_this select 0);
	private _H1 = (_this select 1);
	private _housepos = getposASL _houseN;
	private _housedir = getdir _houseN;
	private _houseclass = typeof _houseN;
	//private _house = createvehiclelocal["Land_Camping_Light_off_F",_housepos,[],0,"CAN_COLLIDE"];
	private _house = "Land_Camping_Light_off_F" createVehicleLocal _housepos;
	_house enablesimulation false;
	_house setpos _housepos;
	_house setDir _housedir;
	private _FinalArray = [];
	{
		private _Type = _x select 0;
		private _Pos = _x select 1;
		private _PosZ = _x select 2;	
		private _Dir = _x select 3;	
		private _OrgDir = _x select 4;
		private _Vec = _x select 5;
		//private _Obj = createVehicle [_Type,[0,0,5],[],0,'CAN_COLLIDE'];
		private _Obj = _Type createVehicleLocal [0,0,5];
		_Obj enableSimulation false;
		_Obj attachto [_house,_Pos];
		detach _Obj;
		_Obj setDir ((_housedir - _OrgDir) + _Dir);
		_Obj setPosASL [getPosASL _Obj select 0, getPosASL _Obj select 1,_PosZ + (_housepos select 2)];	

		
		_FinalArray pushback _Obj;
	} foreach _H1;
	
	_FinalArray pushback _house;
	_house hideobject true;

	
	_FinalArray
};


/*
		if !((_Vec select 2) isEqualTo 1) then
		{
			_Obj setPosASL [getPosASL _Obj select 0, getPosASL _Obj select 1,((_PosZ + (_housepos select 2)) - ((_Obj call BIS_fnc_objectHeight)/2))];
			_Obj setDir ((_housedir - _OrgDir) + _Dir);			
			_Obj setVectorUp _Vec;			
		}
		else
		{
			_Obj setDir ((_housedir - _OrgDir) + _Dir);
			_Obj setPosASL [getPosASL _Obj select 0, getPosASL _Obj select 1,_PosZ + (_housepos select 2)];
		};	
*/



FS_FRNSPWN =
{
	params ["_H","_T"];
	switch (_T) do
	{
		case "Land_i_House_Big_01_V3_F" : 
		{
			private _H1 = [["Land_PCSet_01_case_F",[0.799805,0.00878906,77.9092],0.442459,216.593,306.054,[0,0,1]],["Land_ChairWood_F",[1.04004,0.385254,77.8585],0.400879,16.5364,306.054,[0,0,1]],["OfficeTable_01_old_F",[0.74707,0.495605,77.9132],0.445595,215.175,306.054,[0,0,1]],["Land_PCSet_01_keyboard_F",[0.676758,0.391113,78.7347],1.26449,344.161,306.054,[0,0,1]],["Land_PCSet_01_mousepad_F",[0.788086,0,78.7409],1.27367,13.426,306.054,[0,0,1]],["Land_PCSet_01_mouse_F",[0.788086,-0.0297852,78.7595],1.2923,194.892,306.054,[0,0,1]],["Land_PCSet_01_screen_F",[0.607422,0.918945,78.7454],1.27396,251.291,306.054,[0,0,1]],["Land_MapBoard_01_Wall_F",[-1.69531,-2.02393,79.0412],1.48341,216.382,306.054,[0,0,1]],["Land_WaterCooler_01_old_F",[0.385742,3.37109,77.9218],0.448013,127.52,306.054,[0,0,1]],["Land_PortableLongRangeRadio_F",[1.62305,3.3374,77.949],0.517982,119.286,306.054,[0,0,1]],["Fridge_01_closed_F",[0.854492,3.52881,77.9097],0.452431,126.32,306.054,[0,0,1]],["Land_PortableLongRangeRadio_F",[1.5127,3.4248,77.9486],0.51403,312.114,306.054,[0,0,1]],["Land_PortableLongRangeRadio_F",[0.443359,3.92041,77.436],-0.034668,0,306.054,[0.000976388,0,1]],["Land_PortableLongRangeRadio_F",[1.70215,3.52686,77.9369],0.509056,199.714,306.054,[0,0,1]],["Land_Can_Dented_F",[-3.44922,1.91162,78.045],0.508003,0,306.054,[0.000976388,0,1]],["Land_PortableLongRangeRadio_F",[1.55957,3.6792,77.9507],0.518257,0,306.054,[0.000976388,0,1]],["Land_ShotTimer_01_F",[2.07129,3.43701,77.9408],0.539307,50.5202,306.054,[0,0,1]],["Land_Metal_wooden_rack_F",[1.76563,3.52295,77.8633],0.438896,125.958,306.054,[0,0,1]],["Land_Tablet_02_F",[1.83398,3.49854,78.9437],1.52433,0,306.054,[0.000976388,0,1]],["Land_PCSet_01_screen_F",[1.71387,-3.729,78.7535],1.27888,214.086,306.054,[0,0,1]],["Land_PaperBox_01_small_closed_brown_F",[1.78613,0.0639648,81.3053],3.87286,129.077,306.054,[0,0,1]],["Land_PCSet_01_mousepad_F",[2.3291,-3.77002,77.9178],0.459198,5.04245,306.054,[0,0,1]],["Land_Tablet_01_F",[2.67773,3.42627,78.3736],1.02341,307.371,306.054,[0,0,1]],["Land_FirstAidKit_01_closed_F",[1.9834,-0.398926,81.271],3.84447,0,306.054,[0.000976388,0,1]],["Land_PaperBox_01_small_closed_brown_F",[1.88672,0.618652,81.301],3.87326,129.077,306.054,[0,0,1]],["Land_Matches_F",[1.48828,-0.0219727,81.7302],4.28728,0,306.054,[0.000976388,0,1]],["Land_OfficeCabinet_02_F",[-4.13574,1.47998,78.0007],0.460831,215.181,306.054,[0,0,1]],["Land_SurvivalRadio_F",[2.91699,3.4668,77.8505],0.522316,0,306.054,[0.000976388,0,1]],["OfficeTable_01_new_F",[1.87207,-4.12744,77.9323],0.456764,215.885,306.054,[0.000976388,0,1]],["Land_RattanChair_01_F",[-1.03711,-0.552246,81.4463],3.91459,27.6478,306.054,[0,0,1]],["Land_Tablet_01_F",[2.96387,3.45068,78.3474],1.02251,0,306.054,[0.000976388,0,1]],["Land_Can_V2_F",[-3.8418,2.40771,78.8144],1.28149,118.217,306.054,[0,0,1]],["Land_PCSet_01_case_F",[1.62109,3.53467,79.8777],2.44704,0,306.054,[0.000976388,0,1]],["Land_Tableware_01_stackOfNapkins_F",[-4.00488,2.15625,78.8213],1.28661,0,306.054,[0.000976388,0,1]],["Land_OfficeCabinet_02_F",[-3.91895,2.36182,77.9948],0.461624,242.829,306.054,[0,0,1]],["Land_Metal_wooden_rack_F",[2.87109,3.51709,77.7687],0.438599,125.958,306.054,[0,0,1]],["Land_PaperBox_01_small_destroyed_brown_IDAP_F",[2.5166,-0.483887,81.2684],3.85736,0,306.054,[0.000976388,0,1]],["Land_PaperBox_01_small_closed_brown_F",[2.55371,0.48584,81.2806],3.87576,218.175,306.054,[0,0,1]],["Land_TableBig_01_F",[-1.97363,-0.999512,81.4247],3.86411,217.867,306.054,[0,0,1]],["Land_PCSet_01_case_F",[1.81836,-4.44482,77.9275],0.446434,305.192,306.054,[0,0,1]],["Land_GamingSet_01_controller_F",[-3.16211,3.6167,78.3599],0.835922,189.183,306.054,[0,0,1]],["Land_PCSet_01_keyboard_F",[1.9834,-4.27393,78.7535],1.27908,221.544,306.054,[0.000976388,0,1]],["Land_PCSet_01_screen_F",[1.62695,-4.35693,78.767],1.28196,214.122,306.054,[0.000976388,0,1]],["Land_PaperBox_01_small_closed_brown_F",[1.91699,0.405273,81.7121],4.28493,64.0825,306.054,[0,0,1]],["Land_PCSet_01_mouse_F",[2.7793,-4.10693,77.9361],0.485176,115.312,306.054,[0.42073,-0.199047,-0.88508]],["Land_CampingChair_V2_F",[2.51465,-4.25098,78.1987],0.738823,90.0568,306.054,[0.000978772,0.999925,-0.0121795]],["Land_GamingSet_01_console_F",[-3.47754,3.48975,78.3615],0.836754,197.571,306.054,[0,0,1]],["Land_FMradio_F",[2.59668,3.46387,79.795],2.43925,0,306.054,[0.000976388,0,1]],["Land_GamingSet_01_camera_F",[-3.25781,3.81982,78.3617],0.839394,193.106,306.054,[0,0,1]],["Land_Rug_01_Traditional_F",[-3.25977,4.15674,77.9461],0.426361,92.561,306.054,[0,0,1]],["Land_HDMICable_01_F",[-4.13965,3.28467,78.0317],0.505844,0,306.054,[0.000976388,0,1]],["OfficeTable_01_old_F",[-3.65137,3.92383,77.5416],0.0203323,3.8907,306.054,[0,0,1]],["Land_PCSet_01_mousepad_IDAP_F",[4.09082,3.48389,77.7445],0.517204,0,306.054,[0.000976388,0,1]],["Land_PortableSpeakers_01_F",[-3.48145,4.08057,78.3669],0.846748,95.0083,306.054,[0,0,1]],["Land_Projector_01_F",[3.97559,3.39697,78.7411],1.5006,0,306.054,[0.000976388,0,1]],["Land_FlatTV_01_F",[-3.58008,3.99854,78.3559],0.835213,180.433,306.054,[0,0,1]],["Land_Metal_wooden_rack_F",[3.97754,3.51953,77.6739],0.438278,125.958,306.054,[0,0,1]],["Land_PCSet_01_case_F",[4.17285,-3.5293,77.7794],0.453171,39.536,306.054,[0.000976388,0,1]],["Land_ChairWood_F",[3.88477,-3.91992,77.8059],0.449646,199.479,306.054,[0.000976388,0,1]],["Land_GamingSet_01_powerSupply_F",[-4.19824,3.59131,78.0317],0.508194,97.3344,306.054,[0,0,1]],["Land_VRGoggles_01_F",[-3.6416,4.34717,78.3516],0.833633,0,306.054,[0.000976388,0,1]],["Land_PCSet_01_keyboard_F",[4.11719,-3.87451,78.5984],1.26618,43.7778,306.054,[0,0,1]],["OfficeTable_01_old_F",[4.2002,-4.01807,77.7735],0.449677,38.118,306.054,[0.000977341,0,1]],["Land_Printer_01_F",[3.93359,3.5166,79.6874],2.44777,0,306.054,[0.000976388,0,1]],["Land_OfficeCabinet_01_F",[1.27246,-3.4292,81.3351],3.85256,306.896,306.054,[0,0,1]],["Land_VRGoggles_01_F",[-3.74121,4.50537,78.3597],0.842896,188.613,306.054,[0,0,1]],["Land_PaperBox_01_small_destroyed_brown_F",[4.04004,-1.61523,81.1633],3.82518,0,306.054,[0.000976388,0,1]],["Land_Tablet_01_F",[0.856445,-5.73193,79.0295],1.50594,203.208,306.054,[0,0,1]],["Land_PCSet_01_mousepad_F",[4.06055,-4.28955,78.6138],1.27536,196.369,306.054,[0.000976388,0,1]],["Land_PCSet_01_mouse_F",[4.04883,-4.2915,78.6337],1.294,17.8347,306.054,[0.000976388,0,1]],["Land_PCSet_01_screen_F",[4.44824,-3.93506,78.5738],1.27568,36.3557,306.054,[0.000976388,0,1]],["Land_MetalCase_01_small_F",[2.87598,3.67822,81.2967],3.97317,218.031,306.054,[0,0,1]],["Land_PaperBox_01_small_destroyed_brown_F",[4.0459,-2.46289,81.1837],3.84534,35.8101,306.054,[0,0,1]],["Land_CashDesk_F",[0.759766,-6.27734,78.0271],0.493874,36.9239,306.054,[0,0,1]],["Land_OfficeChair_01_F",[1.69727,-6.01221,77.9986],0.493919,52.739,306.054,[0.000976388,0,1]],["Land_ArmChair_01_F",[-0.0322266,6.35156,77.9729],0.505409,179.485,306.054,[0,0,1]],["Land_Metal_rack_F",[-3.74902,2.56689,81.4007],3.86897,305.319,306.054,[0,0,1]],["Land_Metal_wooden_rack_F",[2.92969,3.62061,81.2078],3.88667,309.094,306.054,[0,0,1]],["Land_PCSet_01_case_F",[3.97754,3.69336,81.388],4.15923,305.192,306.054,[-0.57631,-0.817223,-0.00356756]],["Land_MetalWire_F",[2.9248,3.70264,82.2918],4.9735,0,306.054,[0.000976388,0,1]],["Land_SatellitePhone_F",[0.920898,-6.74023,78.5742],1.03937,168.093,306.054,[0,0,1]],["Land_Metal_wooden_rack_F",[-3.64355,3.85303,81.3962],3.8744,0,306.054,[0.000976388,0,1]],["Land_PCSet_01_case_F",[3.00781,3.57178,82.8746],5.5582,305.192,306.054,[-0.57631,-0.817223,-0.00356756]],["Land_Metal_wooden_rack_F",[4.09473,3.53662,81.072],3.84702,304.569,306.054,[0,0,1]],["Land_CampingChair_V2_F",[3.97559,-6.0835,77.8463],0.497467,323.297,306.054,[0.000976388,0,1]],["Land_MetalCase_01_small_F",[4.0957,3.62549,82.1555],4.93407,220.465,306.054,[0,0,1]],["Land_PCSet_01_mouse_F",[3.47754,-6.52979,78.7382],1.33746,107.831,306.054,[0.000976388,0,1]],["Land_PCSet_01_mousepad_F",[3.52637,-6.58984,78.6765],1.28069,308.29,306.054,[0,0,1]],["Land_PCSet_01_screen_F",[2.86621,3.73584,83.2187],5.89674,214.122,306.054,[0.000976388,0,1]],["Land_PCSet_01_keyboard_F",[4.03613,-6.61377,78.62],1.27686,133.774,306.054,[0,0,1]],["OfficeTable_01_new_F",[3.95703,-6.73682,77.8128],0.461349,128.114,306.054,[0.000977341,0,1]],["Land_PCSet_01_screen_F",[3.38965,3.64502,83.1738],5.89276,214.122,306.054,[0.000976388,0,1]],["Land_PCSet_01_screen_F",[3.74707,3.49219,83.1088],5.85242,214.122,306.054,[0.000976388,0,1]],["Land_PCSet_01_screen_F",[3.67578,-6.91895,78.6661],1.28532,159.078,306.054,[0.000976388,0,1]],["Land_TableDesk_F",[0.333008,-6.76318,81.4289],3.87785,126.805,306.054,[0,0,1]],["Land_PCSet_01_case_F",[4.44727,-6.75342,77.751],0.450081,129.532,306.054,[0.000976388,0,1]],["Land_MobilePhone_old_F",[4.48535,-6.69678,78.5869],1.28996,276.71,306.054,[0,0,1]],["Land_PCSet_01_screen_F",[4.20215,3.52686,83.0803],5.8641,214.122,306.054,[0.000976388,0,1]],["Land_PCSet_01_screen_F",[4.26758,-6.86377,78.6073],1.2879,126.352,306.054,[0.000976388,0,1]]];
			private _Lst = [_H,_H1] call FS_ACTSPWN;
			FS_SPWNEDLIST pushBack [_H,_Lst];
			[_Lst,(getPosASL _H),_H] spawn
			{
				params ["_Lst","_Pos","_H"];
				_H setVariable ["FS_SPWNOBJ",_Lst];	
				waitUntil
				{
					if (player distance2D _Pos > FS_DIST && {!(_H getVariable ["FS_FAR",false])}) then
					{
						{deleteVehicle _x;true;} count _Lst;
						_H setVariable ["FS_SPWN",false];
						_H setVariable ["FS_FAR",false];
						{
							private _HO = _x select 0;
							if (_HO isEqualTo _H) exitWith
							{
								FS_SPWNEDLIST deleteAt _forEachIndex;
							};
						} foreach FS_SPWNEDLIST;
					};
					sleep 5;
					!(_H getVariable ["FS_SPWN",true])
				};
			};
		};
		case "Land_i_House_Small_03_V1_F" : 
		{
			private _H1 = [["Land_Rope_01_F",[0.136719,1.22217,76.6821],0.308334,0,125.45,[0,0,1]],["Land_FlowerPot_01_F",[-0.69043,1.09229,76.7204],0.293076,0,125.45,[0,0,1]],["Land_TableDesk_F",[0.421875,1.25049,76.6511],0.296211,124.417,125.45,[0,0,1]],["Land_Screwdriver_V2_F",[0.0888672,1.00928,77.5033],1.13271,260.682,125.45,[-0.109091,0,0.994032]],["Land_MultiMeter_F",[0.238281,1.021,77.4915],1.13094,0,125.45,[0,0,1]],["Land_Photos_V5_F",[-1.51855,-0.306152,76.7482],0.306496,0,125.45,[0,0,1]],["Land_ChairWood_F",[0.47168,1.56641,76.4772],0.115944,129.354,125.45,[0,0,1]],["Land_Money_F",[-0.196289,1.15967,77.5155],1.12052,0,125.45,[0,0,1]],["Land_Photos_V5_F",[-1.62891,-0.265137,76.7542],0.303589,299.263,125.45,[0,0,1]],["Land_Bucket_clean_F",[1.50098,1.05713,76.6064],0.296219,0,125.45,[0,0,1]],["Land_File2_F",[1.03125,1.12451,77.4201],1.11141,0,125.45,[0.00575665,-0.00384449,0.999976]],["Land_Magazine_rifle_F",[0.999023,1.47607,77.4514],1.12958,0,125.45,[0.00653245,0.00953681,0.999933]],["Land_ChairPlastic_F",[-0.880859,-1.979,76.6261],0.280228,33.0159,125.45,[0,0,1]],["Land_ChairWood_F",[2.4834,0.609863,76.5844],0.245995,36.46,125.45,[0,0,1]],["Land_ChairWood_F",[2.45605,1.89307,76.6521],0.297684,36.46,125.45,[0,0,1]],["Item_ItemGPS",[2.43262,1.91846,77.1726],0.818649,298.331,125.45,[0,0,1]],["Land_Can_Dented_F",[-3.99902,1.18799,76.8937],0.29586,258.166,125.45,[0,0,1]],["Land_FirstAidKit_01_open_F",[2.41113,-3.58545,76.5325],0.282074,49.2142,125.45,[0,0,1]],["Land_Can_Dented_F",[-4.13574,1.2876,76.9006],0.296753,0,125.45,[0,0,1]],["Land_Camping_Light_F",[-3.75098,2.17822,76.9715],0.298447,0,125.45,[0,0,1]],["Land_CampingChair_V1_folded_F",[1.11621,4.35938,76.7177],0.315193,349.417,125.45,[0,0,1]],["BloodSplatter_01_Small_New_F",[3.11816,-3.29443,76.5931],0.32,0,125.45,[0,0,1]],["Land_VitaminBottle_F",[2.65039,-3.75537,76.5496],0.302368,0,125.45,[0,0,1]],["Land_Tableware_01_cup_F",[-4.28613,2.16309,77.3917],0.760635,0,125.45,[0,0,1]],["Land_TacticalBacon_F",[-3.83203,2.896,77.4456],0.762482,0,125.45,[-0.00467067,0.00320184,0.999984]],["Land_Tableware_01_tray_F",[-3.89551,2.89404,77.4433],0.757019,0,125.45,[0,0,1]],["Land_Ketchup_01_F",[-4.34473,2.22217,77.3818],0.762756,0,125.45,[0,0,1]],["Land_Tableware_01_spoon_F",[-4.01563,2.81885,77.4135],0.738594,0,125.45,[0,0,1]],["Land_TableSmall_01_F",[-4.47168,2.15186,76.9115],0.329826,214.03,125.45,[0,0,1]],["Land_HeatPack_F",[2.80664,-4.12842,76.5413],0.306808,0,125.45,[0,0,1]],["Land_Tableware_01_stackOfNapkins_F",[-4.4541,2.14502,77.3502],0.76371,148.535,125.45,[0,0,1]],["Land_FlowerPot_01_Flower_F",[2.30176,4.45459,76.6963],0.313286,0,125.45,[0,0,1]],["Land_Mustard_01_F",[-4.58301,2.24512,77.3187],0.760712,0,125.45,[0,0,1]],["Land_EmergencyBlanket_02_stack_F",[5.08887,0.921387,76.7327],0.299667,42.3483,125.45,[0,0,1]],["Land_Canteen_F",[-4.74512,2.28271,77.2232],0.705223,238.446,125.45,[0,0,1]],["Land_PaperBox_01_small_closed_brown_food_F",[5.15137,1.61475,76.7471],0.302689,34.501,125.45,[0,0,1]],["Land_EmergencyBlanket_01_F",[5.14941,1.60693,77.1468],0.702606,214.092,125.45,[0,0,1]],["Land_FoodSack_01_full_brown_F",[5.06738,2.31689,76.6863],0.224403,0,125.45,[0,0,1]],["Land_Can_Rusty_F",[-5.29102,2.14307,76.6718],0.303818,0,125.45,[0,0,1]],["Land_WoodenBed_01_F",[-4.5127,3.67432,76.8688],0.291206,124.402,125.45,[0,0,1]],["Banner_01_CSAT_F",[-5.53613,-0.822754,77.5714],1.44588,35.5523,125.45,[0,0,1]],["Land_WaterBottle_01_compressed_F",[5.23242,2.80518,76.8946],0.294167,0,125.45,[0,0,1]],["BloodPool_01_Medium_New_F",[4.85059,-3.77295,76.6175],0.337036,0,125.45,[0,0,1]],["Land_Photoframe_01_F",[5.44141,-2.45605,78.3225],1.9798,305.037,125.45,[0,0,1]],["Land_Sack_F",[2.68945,-5.75049,76.4604],0.293259,0,125.45,[0,0,1]],["Land_FlowerPot_01_Flower_F",[2.22266,-6.01611,76.4798],0.330605,0,125.45,[0,0,1]],["Land_Stretcher_01_folded_olive_F",[4.80957,-5.7876,76.4812],0.282936,0,125.45,[0,0,1]]];
			private _Lst = [_H,_H1] call FS_ACTSPWN;
			FS_SPWNEDLIST pushBack [_H,_Lst];
			[_Lst,(getPosASL _H),_H] spawn
			{
				params ["_Lst","_Pos","_H"];
				_H setVariable ["FS_SPWNOBJ",_Lst];
				waitUntil
				{
					if (player distance2D _Pos > FS_DIST && {!(_H getVariable ["FS_FAR",false])}) then
					{
						{deleteVehicle _x;true;} count _Lst;
						_H setVariable ["FS_SPWN",false];
						_H setVariable ["FS_FAR",false];
						{
							private _HO = _x select 0;
							if (_HO isEqualTo _H) exitWith
							{
								FS_SPWNEDLIST deleteAt _forEachIndex;
							};
						} foreach FS_SPWNEDLIST;
					};
					sleep 5;
					!(_H getVariable ["FS_SPWN",true])
				};
			};
		};
		case "Land_u_House_Big_01_V1_F" : 
		{
			private _H1 = [["Land_GarbageHeap_04_F",[1.62207,0.0644531,78.569],0.444107,215.451,186.309,[0,0,1]],["Land_JunkPile_F",[1.29785,-3.69336,78.3626],0.398422,313.637,186.309,[0,0,1]],["Land_Garbage_square5_F",[-1.89746,-0.550781,81.9253],3.8708,0,186.309,[0.000845734,0,1]],["Land_GarbagePallet_F",[1.54736,-0.236328,81.9725],3.86233,0,186.309,[0.000838105,0,1]],["Land_Graffiti_02_F",[4.67627,-3.02539,79.6665],1.61938,276.317,186.309,[0,0,1]],["Land_Sleeping_bag_brown_F",[0.646973,4.8125,82.1804],3.8418,275.784,186.309,[0,0,1]],["Land_Garbage_square5_F",[2.43652,-5.16992,81.8183],3.86823,191.868,186.309,[0,0,1]],["Land_Sleeping_bag_F",[3.6499,4.52734,82.26],3.87204,0,186.309,[0.000845734,0,1]],["Land_Graffiti_05_F",[0.904785,-7.07617,79.5783],1.68763,5.81989,186.309,[0,0,1]],["Land_GarbageHeap_03_F",[-3.25977,-5.2168,81.6532],3.77718,76.203,186.309,[0,0,1]],["Land_Garbage_line_F",[1.78271,6.43555,82.3488],3.853,97.256,186.309,[0,0,1]]];
			private _Lst = [_H,_H1] call FS_ACTSPWN;
			FS_SPWNEDLIST pushBack [_H,_Lst];
			[_Lst,(getPosASL _H),_H] spawn
			{
				params ["_Lst","_Pos","_H"];
				_H setVariable ["FS_SPWNOBJ",_Lst];
				waitUntil
				{
					if (player distance2D _Pos > FS_DIST && {!(_H getVariable ["FS_FAR",false])}) then
					{
						{deleteVehicle _x;true;} count _Lst;
						_H setVariable ["FS_SPWN",false];
						_H setVariable ["FS_FAR",false];
						{
							private _HO = _x select 0;
							if (_HO isEqualTo _H) exitWith
							{
								FS_SPWNEDLIST deleteAt _forEachIndex;
							};
						} foreach FS_SPWNEDLIST;
					};
					sleep 5;
					!(_H getVariable ["FS_SPWN",true])
				};
			};
		};				
		case "Land_Offices_01_V1_F" : 
		{
			private _H1 = [["Land_AirConditioner_01_F",[3.4082,-1.01563,19.9393],0.874138,199.248,134.205,[0,0,1]],["Land_Workbench_01_F",[-1.04688,-3.96289,19.9894],0.924219,45.0405,134.205,[0,0,1]],["Land_CampingChair_V2_F",[2.33203,-4.59082,19.9678],0.913227,224.724,134.205,[0,0,1]],["Land_Garbage_square3_F",[5.30859,1.26465,19.9492],0.888206,0,134.205,[0,0,1]],["Land_CampingChair_V2_F",[3.65234,-4.29492,19.9448],0.900284,224.724,134.205,[0,0,1]],["Land_CampingChair_V2_F",[2.33984,-5.49609,19.9453],0.897745,224.724,134.205,[0,0,1]],["MapBoard_seismic_F",[-0.5,-6.27832,19.9454],0.906984,21.0393,134.205,[0,0,1]],["Land_CampingChair_V2_F",[3.77734,-5.21387,19.9356],0.899319,224.724,134.205,[0,0,1]],["Land_Garbage_square5_F",[3.98047,5.33887,19.9263],0.877913,0,134.205,[0,0,1]],["Land_Garbage_square3_F",[-2.77344,6.31152,19.9589],0.894634,0,134.205,[0,0,1]],["Land_CampingChair_V2_F",[2.25,-6.48145,19.9383],0.898939,224.724,134.205,[0,0,1]],["Land_CampingChair_V2_F",[3.66406,-6.25684,19.8733],0.843908,224.724,134.205,[0,0,1]],["Land_LuggageHeap_02_F",[7.07422,3.22266,23.8056],4.77951,91.0571,134.205,[0,0,1]],["Land_LuggageHeap_03_F",[-0.695313,3.29102,27.7437],8.67863,0.140001,134.205,[0,0,1]],["Land_Garbage_square5_F",[8.97656,-3.79199,19.9768],0.918648,290.401,134.205,[0,0,1]],["Land_Portable_generator_F",[-10.7949,5.1582,19.9985],0.90378,157.711,134.205,[0,0,1]],["Land_FMradio_F",[-12.0469,4.95605,20.9277],1.82941,140.864,134.205,[0,0,1]],["Land_Tablet_01_F",[-12.2148,5.03418,20.1748],1.07607,218.863,134.205,[0,0,1]],["Land_Microwave_01_F",[4.33008,-0.900391,31.7021],12.638,93.2223,134.205,[0,0,1]],["Land_Can_V2_F",[-12.4805,5.08594,20.1756],1.07617,135,134.205,[0,0,1]],["Land_HDMICable_01_F",[-12.5625,5.05078,20.9219],1.82221,0,134.205,[0,0,1]],["Land_WoodenCounter_01_F",[-12.918,5.03027,19.9918],0.89109,134.362,134.205,[0,0,1]],["Land_GarbageHeap_04_F",[3.82031,-2.74512,31.6546],12.5997,48.006,134.205,[0,0,1]],["Land_Laptop_F",[-13.3457,5.04199,20.9288],1.82686,217.11,134.205,[0,0,1]],["Land_Can_V3_F",[-13.6758,5.06836,20.1854],1.0826,131.121,134.205,[0,0,1]],["Land_FlowerPot_01_F",[8.28906,-0.46582,31.6061],12.5585,0,134.205,[0,0,1]],["Land_Canteen_F",[-14.5977,4.96777,20.2354],1.12984,180,134.205,[0,0.9997,-0.0244958]],["Land_Map_Tanoa_F",[-14.8164,5.07031,20.9536],1.84747,45.0516,134.205,[0,0,1]],["Land_FlowerPot_01_Flower_F",[8.53125,-0.342773,31.6694],12.6262,321.962,134.205,[0,0,1]],["Land_WoodenCounter_01_F",[-15.3809,5.04004,20.0137],0.906034,134.362,134.205,[0,0,1]],["Land_OfficeCabinet_01_F",[9.5,-0.329102,31.6247],12.5928,132.776,134.205,[0,0,1]],["Intel_File1_F",[-15.4453,5.31738,20.946],1.83833,0,134.205,[0,0,1]],["Land_PensAndPencils_F",[9.60938,-0.342773,32.5033],13.4725,0,134.205,[0,0,1]],["Leaflet_05_Stack_F",[-15.6484,5.11523,20.9403],1.83189,0,134.205,[0,0,1]],["Leaflet_05_New_F",[-15.8125,4.87207,20.9465],1.83738,119.055,134.205,[0,0,1]],["Land_PenBlack_F",[10.0566,-0.283203,32.4427],13.4178,0,134.205,[0,0,1]],["Land_OfficeCabinet_01_F",[10.3047,-0.302734,31.6132],12.5909,133.488,134.205,[0,0,1]],["Leaflet_05_Old_F",[-15.9922,5.29785,20.9605],1.85131,157.148,134.205,[0,0,1]],["Leaflet_05_Stack_F",[-16.123,4.99512,20.9485],1.83868,62.6918,134.205,[0,0,1]],["Land_Notepad_F",[10.8711,-0.333984,32.4359],13.4197,0,134.205,[0,0,1]],["Leaflet_05_Stack_F",[-16.3672,5.23145,20.9461],1.83579,285.883,134.205,[0,0,1]],["Land_OfficeCabinet_01_F",[11.1055,-0.307617,31.6102],12.5971,133.488,134.205,[0,0,1]],["Land_OfficeChair_01_F",[11.3398,-2.125,31.6201],12.5894,155.203,134.205,[0,0,1]],["Land_Battery_F",[10.6465,-4.83496,32.4876],13.4212,0,134.205,[0,0,1]],["Land_ChairWood_F",[11.2813,-5.77344,31.5856],12.5416,228.508,134.205,[0,0,1]],["Land_TableDesk_F",[10.918,-5.66699,31.6468],12.6001,225.635,134.205,[0,0,1]],["Land_Camera_01_F",[10.7813,-4.83203,32.4897],13.422,0,134.205,[0,0,1]],["Land_FlowerPot_01_Flower_F",[12.0039,-0.270508,31.5977],12.6109,319.003,134.205,[0,0,1]],["Land_Photoframe_01_F",[10.4141,0.165039,34.0224],15.0074,223.214,134.205,[0,0,1]],["Land_Laptop_device_F",[10.9805,-5.71094,32.4734],13.4289,223.847,134.205,[0,0,1]],["Land_MobilePhone_smart_F",[11.0332,-6.29785,32.4505],13.4244,224.53,134.205,[0,0,1]],["Land_HandyCam_F",[10.2734,-7.625,32.7317],13.7362,0,134.205,[0,0,1]],["Land_AirConditioner_03_F",[3.33984,-2.44043,36.9051],17.8434,42.9442,134.205,[0,0,1]],["Land_AirConditioner_04_F",[-3.00391,4.70313,36.767],17.701,181.43,134.205,[0,0,1]],["Land_PortableGenerator_01_F",[12.0039,7.14746,36.6928],17.7875,0,134.205,[0,0,1]]];
			private _Lst = [_H,_H1] call FS_ACTSPWN;
			FS_SPWNEDLIST pushBack [_H,_Lst];
			[_Lst,(getPosASL _H),_H] spawn
			{
				params ["_Lst","_Pos","_H"];
				_H setVariable ["FS_SPWNOBJ",_Lst];
				waitUntil
				{
					if (player distance2D _Pos > FS_DIST && {!(_H getVariable ["FS_FAR",false])}) then
					{
						{deleteVehicle _x;true;} count _Lst;
						_H setVariable ["FS_SPWN",false];
						_H setVariable ["FS_FAR",false];
						{
							private _HO = _x select 0;
							if (_HO isEqualTo _H) exitWith
							{
								FS_SPWNEDLIST deleteAt _forEachIndex;
							};
						} foreach FS_SPWNEDLIST;
					};
					sleep 5;
					!(_H getVariable ["FS_SPWN",true])
				};
			};
		};
		case "Land_u_Shop_02_V2_F" : 
		{
			private _H1 = [["Land_ButaneTorch_F",[-0.527344,-2.89063,19.6099],0.622412,0,312.642,[0,0,1]],["Land_ToolTrolley_01_F",[-0.527344,-2.99316,19.4652],0.477833,285.967,312.642,[0,0,1]],["Land_CanisterOil_F",[-0.386719,-3.14844,20.3128],1.32599,0,312.642,[0,0,1]],["Land_EmergencyBlanket_02_discarded_F",[-1.49219,1.91992,23.3588],4.3783,212.043,312.642,[0,0,1]],["Land_Ground_sheet_OPFOR_F",[-1.03906,-2.4873,23.3584],4.36963,0,312.642,[0,0,1]],["Land_Bodybag_01_black_F",[1.90625,-2.86426,23.2642],4.28349,0,312.642,[0,0,1]],["Land_Axe_F",[-3.41016,-3.0127,23.3576],4.36401,344.53,312.642,[0,0,1]],["Land_Sleeping_bag_blue_F",[-3.98828,-3.85254,23.3706],4.37596,44.7832,312.642,[0,0,1]],["Land_BagFence_End_F",[3.75,2.83887,24.2298],5.26255,215.424,312.642,[0,0,1]],["Land_FirePlace_F",[-5.03516,4.11719,23.33],4.34327,0,312.642,[0,0,1]],["Land_Pillow_grey_F",[-5.32813,-4.29785,23.3719],4.37483,0,312.642,[0,0,1]]];
			private _Lst = [_H,_H1] call FS_ACTSPWN;
			FS_SPWNEDLIST pushBack [_H,_Lst];
			[_Lst,(getPosASL _H),_H] spawn
			{
				params ["_Lst","_Pos","_H"];
				_H setVariable ["FS_SPWNOBJ",_Lst];
				waitUntil
				{
					if (player distance2D _Pos > FS_DIST && {!(_H getVariable ["FS_FAR",false])}) then
					{
						{deleteVehicle _x;true;} count _Lst;
						_H setVariable ["FS_SPWN",false];
						_H setVariable ["FS_FAR",false];
						{
							private _HO = _x select 0;
							if (_HO isEqualTo _H) exitWith
							{
								FS_SPWNEDLIST deleteAt _forEachIndex;
							};
						} foreach FS_SPWNEDLIST;
					};
					sleep 5;
					!(_H getVariable ["FS_SPWN",true])
				};
			};
		};			
		case "Land_u_Shop_02_V3_F" : 
		{
			private _H1 = [["Land_ButaneTorch_F",[-0.527344,-2.89063,19.6099],0.622412,0,312.642,[0,0,1]],["Land_ToolTrolley_01_F",[-0.527344,-2.99316,19.4652],0.477833,285.967,312.642,[0,0,1]],["Land_CanisterOil_F",[-0.386719,-3.14844,20.3128],1.32599,0,312.642,[0,0,1]],["Land_EmergencyBlanket_02_discarded_F",[-1.49219,1.91992,23.3588],4.3783,212.043,312.642,[0,0,1]],["Land_Ground_sheet_OPFOR_F",[-1.03906,-2.4873,23.3584],4.36963,0,312.642,[0,0,1]],["Land_Bodybag_01_black_F",[1.90625,-2.86426,23.2642],4.28349,0,312.642,[0,0,1]],["Land_Axe_F",[-3.41016,-3.0127,23.3576],4.36401,344.53,312.642,[0,0,1]],["Land_Sleeping_bag_blue_F",[-3.98828,-3.85254,23.3706],4.37596,44.7832,312.642,[0,0,1]],["Land_BagFence_End_F",[3.75,2.83887,24.2298],5.26255,215.424,312.642,[0,0,1]],["Land_FirePlace_F",[-5.03516,4.11719,23.33],4.34327,0,312.642,[0,0,1]],["Land_Pillow_grey_F",[-5.32813,-4.29785,23.3719],4.37483,0,312.642,[0,0,1]]];
			private _Lst = [_H,_H1] call FS_ACTSPWN;	
			FS_SPWNEDLIST pushBack [_H,_Lst];
			[_Lst,(getPosASL _H),_H] spawn
			{
				params ["_Lst","_Pos","_H"];
				_H setVariable ["FS_SPWNOBJ",_Lst];
				waitUntil
				{
					if (player distance2D _Pos > FS_DIST && {!(_H getVariable ["FS_FAR",false])}) then
					{
						{deleteVehicle _x;true;} count _Lst;
						_H setVariable ["FS_SPWN",false];
						_H setVariable ["FS_FAR",false];
						{
							private _HO = _x select 0;
							if (_HO isEqualTo _H) exitWith
							{
								FS_SPWNEDLIST deleteAt _forEachIndex;
							};
						} foreach FS_SPWNEDLIST;
					};
					sleep 5;
					!(_H getVariable ["FS_SPWN",true])
				};
			};
		};			
		case "Land_u_Shop_02_V1_F" : 
		{
			private _H1 = [["Land_ButaneTorch_F",[-0.527344,-2.89063,19.6099],0.622412,0,312.642,[0,0,1]],["Land_ToolTrolley_01_F",[-0.527344,-2.99316,19.4652],0.477833,285.967,312.642,[0,0,1]],["Land_CanisterOil_F",[-0.386719,-3.14844,20.3128],1.32599,0,312.642,[0,0,1]],["Land_EmergencyBlanket_02_discarded_F",[-1.49219,1.91992,23.3588],4.3783,212.043,312.642,[0,0,1]],["Land_Ground_sheet_OPFOR_F",[-1.03906,-2.4873,23.3584],4.36963,0,312.642,[0,0,1]],["Land_Bodybag_01_black_F",[1.90625,-2.86426,23.2642],4.28349,0,312.642,[0,0,1]],["Land_Axe_F",[-3.41016,-3.0127,23.3576],4.36401,344.53,312.642,[0,0,1]],["Land_Sleeping_bag_blue_F",[-3.98828,-3.85254,23.3706],4.37596,44.7832,312.642,[0,0,1]],["Land_BagFence_End_F",[3.75,2.83887,24.2298],5.26255,215.424,312.642,[0,0,1]],["Land_FirePlace_F",[-5.03516,4.11719,23.33],4.34327,0,312.642,[0,0,1]],["Land_Pillow_grey_F",[-5.32813,-4.29785,23.3719],4.37483,0,312.642,[0,0,1]]];
			private _Lst = [_H,_H1] call FS_ACTSPWN;
			FS_SPWNEDLIST pushBack [_H,_Lst];
			[_Lst,(getPosASL _H),_H] spawn
			{
				params ["_Lst","_Pos","_H"];
				_H setVariable ["FS_SPWNOBJ",_Lst];
				waitUntil
				{
					if (player distance2D _Pos > FS_DIST && {!(_H getVariable ["FS_FAR",false])}) then
					{
						{deleteVehicle _x;true;} count _Lst;
						_H setVariable ["FS_SPWN",false];
						_H setVariable ["FS_FAR",false];
						{
							private _HO = _x select 0;
							if (_HO isEqualTo _H) exitWith
							{
								FS_SPWNEDLIST deleteAt _forEachIndex;
							};
						} foreach FS_SPWNEDLIST;
					};
					sleep 5;
					!(_H getVariable ["FS_SPWN",true])
				};
			};
		};		
		case "Land_i_House_Big_01_V2_F" :
		{
			private _H1 = [["Land_Antibiotic_F",[1.15039,0.689453,18.9945],0.498333,0,227.58,[0,0,1]],["Land_Bandage_F",[1.22949,0.603516,18.9538],0.458181,305.344,227.58,[0,0,1]],["Land_BloodBag_F",[1.30859,0.804688,18.9406],0.445446,0,227.58,[0,0,1]],["Land_DisinfectantSpray_F",[1.61426,0.300781,18.9941],0.501291,116.854,227.58,[0,0,1]],["Land_CratesPlastic_F",[1.5166,0.621094,18.9397],0.446066,84.2284,227.58,[0,0,1]],["Land_FirstAidKit_01_closed_F",[1.61426,0.560547,19.1801],0.687059,48.3324,227.58,[0,0,1]],["BloodTrail_01_New_F",[0.771484,-1.88086,18.9469],0.454336,0,227.58,[0,0,1]],["Fridge_01_closed_F",[2.63184,0.304688,18.9097],0.426716,316.254,227.58,[0,0,1]],["Land_Printer_01_F",[2.62109,0.310547,19.924],1.44074,226.45,227.58,[0,0,1]],["Land_HumanSkull_F",[0.435547,-0.769531,22.3312],3.83125,0,227.58,[0,0,1]],["Land_TableSmall_01_F",[0.541016,-0.75,22.3592],3.85992,187.362,227.58,[0,0,1]],["Land_TinContainer_F",[0.484375,-0.716797,22.8008],4.30117,180,227.58,[0,0.999949,-0.0101504]],["Land_ArmChair_01_F",[1.84766,0.148438,22.3767],3.88546,98.6955,227.58,[0,0,1]],["Land_Projector_01_F",[-3.0332,3.57227,19.8264],1.28767,0,227.58,[0,0,1]],["Land_MobilePhone_old_F",[-2.92578,3.94922,19.8439],1.30356,43.8147,227.58,[0,0,1]],["Land_WoodenTable_small_F",[-3.45703,3.87891,18.9908],0.447239,318.163,227.58,[0,0,1]],["Land_CarBattery_02_F",[-2.99902,4.25781,19.8412],1.29836,0,227.58,[0,0,1]],["Land_ExtensionCord_F",[-3.74414,3.66602,19.8236],1.27939,0,227.58,[0,0,1]],["Land_WheelieBin_01_F",[3.98926,3.78516,18.9159],0.447968,0,227.58,[0,0,1]],["Land_MobilePhone_old_F",[-3.68555,4.17773,19.8447],1.29768,71.565,227.58,[0,0,1]],["MedicalGarbage_01_FirstAidKit_F",[-0.254883,-6.17578,18.9403],0.459339,226.051,227.58,[0,0,1]],["Land_PainKillers_F",[0.52832,-6.46289,19.3701],0.89567,36.3136,227.58,[0,0,1]],["Land_Sofa_01_F",[0.939453,-6.42383,18.9154],0.442345,227.497,227.58,[0,0,1]],["MedicalGarbage_01_Packaging_F",[1.55859,-6.39844,19.409],0.943834,237.951,227.58,[0,0,1]],["Land_Rug_01_F",[0.735352,6.07031,22.7884],4.27754,48.2161,227.58,[0,0,1]],["Land_MapBoard_01_Wall_Stratis_F",[4.66211,1.30469,23.6049],5.15454,317.726,227.58,[0,0,1]],["Land_WoodenBed_01_F",[0.720703,6.13281,22.3455],3.83455,226.945,227.58,[0,0,1]],["Land_Basket_F",[3.88574,6.70313,18.9073],0.445219,0,227.58,[0,0,1]],["Land_TacticalBacon_F",[-2.35156,-6.29883,23.2331],4.74451,263.758,227.58,[0,0,1]],["Land_Can_Dented_F",[-3.81738,-6.24609,22.3848],3.89028,328.643,227.58,[0,0,1]],["Land_TableBig_01_F",[-3.1377,-6.37305,22.3543],3.86318,226.852,227.58,[0,0,1]],["Land_BottlePlastic_V2_F",[-2.35449,-6.42773,23.2338],4.74664,251.917,227.58,[0,0,1]],["Land_BakedBeans_F",[-2.5166,-6.45508,23.2358],4.74829,174.046,227.58,[0,0,1]],["Land_ChairWood_F",[3.73145,6.62891,22.3283],3.86375,50.0921,227.58,[0,0,1]],["Land_Pumpkin_01_F",[-3.19824,-6.4082,23.2334],4.74245,0,227.58,[0,0,1]],["Land_Tableware_01_napkin_F",[-3.88184,-6.47656,23.2402],4.7471,0,227.58,[0,0,1]],["OfficeTable_01_old_F",[3.96191,6.90625,22.3242],3.86382,226.622,227.58,[0,0,1]],["Land_Laptop_F",[3.77539,6.7793,23.1546],4.69107,86.3218,227.58,[0,0,1]],["Banner_01_AAF_F",[2.68359,-7.12891,23.7016],5.25319,227.148,227.58,[0,0,1]]];
			private _Lst = [_H,_H1] call FS_ACTSPWN;
			FS_SPWNEDLIST pushBack [_H,_Lst];
			[_Lst,(getPosASL _H),_H] spawn
			{
				params ["_Lst","_Pos","_H"];
				_H setVariable ["FS_SPWNOBJ",_Lst];
				waitUntil
				{
					if (player distance2D _Pos > FS_DIST && {!(_H getVariable ["FS_FAR",false])}) then
					{
						{deleteVehicle _x;true;} count _Lst;
						_H setVariable ["FS_SPWN",false];
						_H setVariable ["FS_FAR",false];
						{
							private _HO = _x select 0;
							if (_HO isEqualTo _H) exitWith
							{
								FS_SPWNEDLIST deleteAt _forEachIndex;
							};
						} foreach FS_SPWNEDLIST;
					};
					sleep 5;
					!(_H getVariable ["FS_SPWN",true])
				};
			};		
		};
		case "Land_cargo_house_slum_F" :
		{
			private _H1 = [["Land_Pillow_camouflage_F",[0.748047,-0.767578,18.7383],0.199631,225.42,320.853,[-0.0144935,0.0141902,0.999794]],["Land_Plank_01_4m_F",[-0.894531,-0.865234,18.6225],0.0913582,55.3818,320.853,[0,0,1]],["Land_Pillow_F",[0.753906,-1.13281,18.7401],0.194689,359.956,320.853,[0.0191889,-0.0257598,0.999484]],["Land_Compass_F",[-1.87695,-0.577148,18.719],0.190683,0.0143457,320.853,[-0.00196288,-0.00245751,0.999995]],["Land_PowderedMilk_F",[-4.21484,0.695313,18.6813],0.164761,118.523,320.853,[9.23111e-008,-8.89684e-007,1]],["Land_Tableware_01_cup_F",[-4.28516,0.505859,18.6853],0.164761,359.986,320.853,[-0.000122552,0.000162668,1]],["Land_TacticalBacon_F",[-4.33984,0.400391,18.6877],0.16477,81.6074,320.853,[0.000257682,0.000272091,1]],["Land_WoodenLog_F",[-4.2832,-0.960938,18.714],0.164768,0.0124394,320.853,[3.91004e-005,3.16642e-005,1]],["Land_RiceBox_F",[-4.47656,0.355469,18.6894],0.164762,184.709,320.853,[4.05048e-005,4.36119e-005,1]],["Land_FoodContainer_01_F",[-4.51953,0.624023,18.6844],0.16477,18.1482,320.853,[-9.13731e-005,-1.27487e-005,1]]];
			private _Lst = [_H,_H1] call FS_ACTSPWN;
			FS_SPWNEDLIST pushBack [_H,_Lst];
			[_Lst,(getPosASL _H),_H] spawn
			{
				params ["_Lst","_Pos","_H"];
				_H setVariable ["FS_SPWNOBJ",_Lst];
				waitUntil
				{
					if (player distance2D _Pos > FS_DIST && {!(_H getVariable ["FS_FAR",false])}) then
					{
						{deleteVehicle _x;true;} count _Lst;
						_H setVariable ["FS_SPWN",false];
						_H setVariable ["FS_FAR",false];
						{
							private _HO = _x select 0;
							if (_HO isEqualTo _H) exitWith
							{
								FS_SPWNEDLIST deleteAt _forEachIndex;
							};
						} foreach FS_SPWNEDLIST;
					};
					sleep 5;
					!(_H getVariable ["FS_SPWN",true])
				};
			};		
		};
		case "Land_Slum_House01_F" :
		{
			private _H1 = [["Land_Sleeping_bag_F",[-0.266602,-0.130859,17.8061],-0.0214844,264.412,0,[-0.0266571,0,0.999645]],["Land_Sleeping_bag_blue_F",[-0.224609,1.2666,17.8083],-0.0204487,266.829,0,[-0.0266571,0,0.999645]],["Land_Sleeping_bag_blue_folded_F",[-1.30371,-0.743164,17.7652],-0.0347443,359.998,0,[-0.0266581,-1.24785e-005,0.999645]]];
			private _Lst = [_H,_H1] call FS_ACTSPWN;
			FS_SPWNEDLIST pushBack [_H,_Lst];
			[_Lst,(getPosASL _H),_H] spawn
			{
				params ["_Lst","_Pos","_H"];
				_H setVariable ["FS_SPWNOBJ",_Lst];
				waitUntil
				{
					if (player distance2D _Pos > FS_DIST && {!(_H getVariable ["FS_FAR",false])}) then
					{
						{deleteVehicle _x;true;} count _Lst;
						_H setVariable ["FS_SPWN",false];
						_H setVariable ["FS_FAR",false];
						{
							private _HO = _x select 0;
							if (_HO isEqualTo _H) exitWith
							{
								FS_SPWNEDLIST deleteAt _forEachIndex;
							};
						} foreach FS_SPWNEDLIST;
					};
					sleep 5;
					!(_H getVariable ["FS_SPWN",true])
				};
			};		
		};
		case "Land_Slum_House03_F" :
		{
			private _H1 = [["Land_EmergencyBlanket_01_stack_F",[1.10645,-0.0429688,18.6999],0.216722,225.103,0,[-0.32465,0.945461,-0.0265821]],["Land_PaperBox_01_small_ransacked_brown_IDAP_F",[1.06934,-0.466797,18.4863],-0.00118256,0,0,[0.00532655,0.00265201,0.0999663]],["Land_PaperBox_01_small_stacked_F",[0.920898,2.2002,18.4359],-0.0243034,0.0409587,0,[0.0053524,0.00199143,0.999984]],["Land_EmergencyBlanket_01_F",[0.951172,2.02051,19.8664],1.40444,234.89,0,[0.00511718,0.00129034,0.999986]],["Land_FoodSack_01_empty_brown_F",[2.18457,1.72363,18.434],-0.0265675,76.4999,0,[0.00117355,0.00362468,0.999993]],["Land_FoodSack_01_empty_brown_F",[1.99805,2.49902,18.4264],-0.031641,172.918,0,[-0.00266467,0.00266917,0.999993]],["Land_WaterBottle_01_compressed_F",[2.80273,1.77637,18.4355],-0.0265789,359.999,0,[-0.00276511,0.00292145,0.999992]],["Land_WaterBottle_01_compressed_F",[2.9541,1.65234,18.437],-0.0258484,219.288,0,[-0.00383898,0.00315815,0.999988]],["Land_WaterBottle_01_cap_F",[2.94434,1.76074,18.4357],-0.0267811,359.915,0,[0.0107613,-0.0214619,0.999712]],["Land_WaterBottle_01_compressed_F",[2.66309,2.24219,18.4323],-0.0281944,141.437,0,[-0.00245115,0.00252672,0.999994]],["Land_WaterBottle_01_compressed_F",[2.84863,2.05078,18.4343],-0.0271893,55.1496,0,[-0.00251521,0.00288879,0.999993]],["Land_WaterBottle_01_compressed_F",[3.1709,1.58594,18.4385],-0.0250854,110.621,0,[-0.0024608,0.00229603,0.999994]],["Land_WaterBottle_01_compressed_F",[3.08105,1.86816,18.4365],-0.026083,77.0744,0,[-0.00244353,0.00281844,0.999993]],["Land_WaterBottle_01_cap_F",[3.27246,1.91309,18.4367],-0.0263138,44.0881,0,[-0.00979793,-0.0240356,0.999663]],["Land_WaterBottle_01_compressed_F",[3.34766,1.79297,18.4383],-0.0251713,77.0744,0,[-0.00244312,0.00281832,0.999993]],["Land_WaterBottle_01_compressed_F",[3.42871,1.64648,18.4395],-0.0245647,50.0237,0,[-0.00253579,0.0029015,0.999993]],["Land_WaterBottle_01_compressed_F",[3.2041,2.06543,18.4361],-0.0262814,204.516,0,[-0.00269391,0.00241074,0.999993]],["Land_WaterBottle_01_compressed_F",[3.43359,1.99414,18.4377],-0.0254784,103.813,0,[-0.00239977,0.00270387,0.999993]],["Land_PaperBox_01_small_destroyed_brown_F",[3.20117,2.55078,18.4338],-0.0273132,0.00147827,0,[-0.00266675,0.00266915,0.999993]]];
			private _Lst = [_H,_H1] call FS_ACTSPWN;
			FS_SPWNEDLIST pushBack [_H,_Lst];
			[_Lst,(getPosASL _H),_H] spawn
			{
				params ["_Lst","_Pos","_H"];
				_H setVariable ["FS_SPWNOBJ",_Lst];
				waitUntil
				{
					if (player distance2D _Pos > FS_DIST && {!(_H getVariable ["FS_FAR",false])}) then
					{
						{deleteVehicle _x;true;} count _Lst;
						_H setVariable ["FS_SPWN",false];
						_H setVariable ["FS_FAR",false];
						{
							private _HO = _x select 0;
							if (_HO isEqualTo _H) exitWith
							{
								FS_SPWNEDLIST deleteAt _forEachIndex;
							};
						} foreach FS_SPWNEDLIST;
					};
					sleep 5;
					!(_H getVariable ["FS_SPWN",true])
				};
			};		
		};
		case "Land_i_Stone_HouseBig_V2_F" :
		{
			private _H1 = [["Land_WoodenCounter_01_F",[-0.319336,-0.323242,18.8745],0.563501,175.453,0,[-0.552622,-0.833415,-0.00534593]],["Land_Garbage_line_F",[1.41504,1.91309,18.4414],0.143324,269.833,0,[-0.00258374,0,0.999997]],["Land_Sleeping_bag_F",[-0.341797,0.582031,21.3028],3.00912,268.409,0,[0,0,1]],["Land_Map_blank_F",[0.9375,2.90527,19.5186],1.2572,276.392,0,[0,0,1]],["Land_Compass_F",[-1.30859,-0.327148,21.3506],3.05804,46.3261,0,[0,0,1]],["ShootingMat_01_folded_Khaki_F",[-1.42383,-0.359375,21.288],2.99694,46.5694,0,[0,0,1]],["Land_WoodenLog_F",[0.286133,3.05859,19.4872],1.24225,0,0,[0,0,1]],["Land_Sleeping_bag_blue_F",[-0.282227,1.7832,21.2898],3.01977,267.949,0,[0,0,1]],["Land_WoodenLog_F",[0.453125,3.57031,19.2829],1.04915,0,0,[0,0,1]],["FirePlace_burning_F",[1.97852,3.19922,19.4283],1.15255,0,0,[0,0,1]],["Land_WoodenLog_F",[0.992188,3.625,19.501],1.25877,239.31,0,[-0.00482005,-0.0601408,0.998178]],["Land_WoodPile_F",[4.61133,0.00390625,18.5249],0.149176,186.072,0,[-0.00258374,0,0.999997]],["Land_ShotTimer_01_F",[-0.949219,3.25977,21.5648],3.34858,160.656,0,[0,0,1]],["Headgear_H_Cap_usblack",[1.65918,3.58691,21.2267],2.9673,24.9048,0,[0,0,1]],["Land_Sink_F",[-1.12402,3.27344,21.2178],3.00518,0,0,[0,0,1]],["Land_WoodPile_F",[4.69629,2.0918,18.516],0.168203,357.147,0,[-0.00258374,0,0.999997]],["Headgear_H_Booniehat_dgtl",[2.30273,3.71777,21.3025],3.02952,0,0,[0,0,1]],["Land_Tyre_01_F",[-2.09766,0.850586,22.7319],4.47607,182.822,0,[0,0,1]],["Headgear_H_StrawHat",[2.51953,3.50586,21.6053],3.32235,116.959,0,[0,0,1]],["Land_VRGoggles_01_F",[2.98828,3.58984,21.2962],3.0032,228.664,0,[0,0,1]],["Land_GarbageBarrel_01_english_F",[4.55762,-0.958984,21.4318],3.03838,161.882,0,[0,0,1]]];
			private _Lst = [_H,_H1] call FS_ACTSPWN;
			FS_SPWNEDLIST pushBack [_H,_Lst];
			[_Lst,(getPosASL _H),_H] spawn
			{
				params ["_Lst","_Pos","_H"];
				_H setVariable ["FS_SPWNOBJ",_Lst];
				waitUntil
				{
					if (player distance2D _Pos > FS_DIST && {!(_H getVariable ["FS_FAR",false])}) then
					{
						{deleteVehicle _x;true;} count _Lst;
						_H setVariable ["FS_SPWN",false];
						_H setVariable ["FS_FAR",false];
						{
							private _HO = _x select 0;
							if (_HO isEqualTo _H) exitWith
							{
								FS_SPWNEDLIST deleteAt _forEachIndex;
							};
						} foreach FS_SPWNEDLIST;
					};
					sleep 5;
					!(_H getVariable ["FS_SPWN",true])
				};
			};		
		};			
		case "Land_i_Stone_HouseBig_V3_F" :
		{
			private _H1 = [["Land_WoodenCounter_01_F",[-0.319336,-0.323242,17.8745],0.563501,175.453,0,[-0.552622,-0.833415,-0.00534593]],["Land_Garbage_line_F",[1.41504,1.91309,18.4414],0.143324,269.833,0,[-0.00258374,0,0.999997]],["Land_Sleeping_bag_F",[-0.341797,0.582031,21.3028],3.00912,268.409,0,[0,0,1]],["Land_Map_blank_F",[0.9375,2.90527,19.5186],1.2572,276.392,0,[0,0,1]],["Land_Compass_F",[-1.30859,-0.327148,21.3506],3.05804,46.3261,0,[0,0,1]],["ShootingMat_01_folded_Khaki_F",[-1.42383,-0.359375,21.288],2.99694,46.5694,0,[0,0,1]],["Land_WoodenLog_F",[0.286133,3.05859,19.4872],1.24225,0,0,[0,0,1]],["Land_Sleeping_bag_blue_F",[-0.282227,1.7832,21.2898],3.01977,267.949,0,[0,0,1]],["Land_WoodenLog_F",[0.453125,3.57031,19.2829],1.04915,0,0,[0,0,1]],["FirePlace_burning_F",[1.97852,3.19922,19.4283],1.15255,0,0,[0,0,1]],["Land_WoodenLog_F",[0.992188,3.625,19.501],1.25877,239.31,0,[-0.00482005,-0.0601408,0.998178]],["Land_WoodPile_F",[4.61133,0.00390625,18.5249],0.149176,186.072,0,[-0.00258374,0,0.999997]],["Land_ShotTimer_01_F",[-0.949219,3.25977,21.5648],3.34858,160.656,0,[0,0,1]],["Headgear_H_Cap_usblack",[1.65918,3.58691,21.2267],2.9673,24.9048,0,[0,0,1]],["Land_Sink_F",[-1.12402,3.27344,21.2178],3.00518,0,0,[0,0,1]],["Land_WoodPile_F",[4.69629,2.0918,18.516],0.168203,357.147,0,[-0.00258374,0,0.999997]],["Headgear_H_Booniehat_dgtl",[2.30273,3.71777,21.3025],3.02952,0,0,[0,0,1]],["Land_Tyre_01_F",[-2.09766,0.850586,22.7319],4.47607,182.822,0,[0,0,1]],["Headgear_H_StrawHat",[2.51953,3.50586,21.6053],3.32235,116.959,0,[0,0,1]],["Land_VRGoggles_01_F",[2.98828,3.58984,21.2962],3.0032,228.664,0,[0,0,1]],["Land_GarbageBarrel_01_english_F",[4.55762,-0.958984,21.4318],3.03838,161.882,0,[0,0,1]]];
			private _Lst = [_H,_H1] call FS_ACTSPWN;
			FS_SPWNEDLIST pushBack [_H,_Lst];
			[_Lst,(getPosASL _H),_H] spawn
			{
				params ["_Lst","_Pos","_H"];
				_H setVariable ["FS_SPWNOBJ",_Lst];
				waitUntil
				{
					if (player distance2D _Pos > FS_DIST && {!(_H getVariable ["FS_FAR",false])}) then
					{
						{deleteVehicle _x;true;} count _Lst;
						_H setVariable ["FS_SPWN",false];
						_H setVariable ["FS_FAR",false];
						{
							private _HO = _x select 0;
							if (_HO isEqualTo _H) exitWith
							{
								FS_SPWNEDLIST deleteAt _forEachIndex;
							};
						} foreach FS_SPWNEDLIST;
					};
					sleep 5;
					!(_H getVariable ["FS_SPWN",true])
				};
			};		
		};	
		case "Land_Slum_House02_F" :
		{
			private _H1 = [["Land_PlasticNetFence_01_roll_F",[2.79004,-1.28027,17.7913],0,145.141,0,[0,0,1]],["Leaflet_05_F",[3.12207,0.379883,18.223],0.43173,272.834,0,[0,0,1]],["Land_Tableware_01_cup_F",[3.0918,0.805664,17.8873],0.0960503,0,0,[0,0,1]],["Land_BottlePlastic_V2_F",[3.11719,0.803711,18.2151],0.423769,0,0,[0,0,1]],["Land_Rack_F",[3.18066,0.332031,17.7913],0,180,0,[0,0,1]],["Leaflet_05_Old_F",[3.21289,-0.0488281,18.5754],0.784081,277.454,0,[0,0,1]],["Tire_Van_02_Spare_F",[1.29785,0.192383,20.7124],2.92113,0,0,[0,0,1]],["Land_Tableware_01_cup_F",[3.24902,0.682617,17.8763],0.0849705,0,0,[0,0,1]],["Land_BakedBeans_F",[3.12109,-0.164063,18.8897],1.09837,136.755,0,[0,0,1]],["Land_BakedBeans_F",[3.14648,0.380859,18.8897],1.09837,345.48,0,[0,0,1]],["Land_Wallet_01_F",[3.22754,0.665039,18.5733],0.782015,334.601,0,[0,0,1]],["Land_BakedBeans_F",[3.19043,0.0976563,18.8896],1.09836,82.5751,0,[0,0,1]],["Land_BakedBeans_F",[3.09668,0.924805,18.8897],1.09838,311.186,0,[0,0,1]],["Intel_File1_F",[3.25293,0.829102,18.573],0.781691,256.691,0,[0,0,1]],["Land_BakedBeans_F",[3.20605,0.548828,18.8897],1.09837,280.008,0,[0,0,1]],["Land_BakedBeans_F",[3.17578,0.717773,18.8897],1.09838,0,0,[0,0,1]],["Land_PlasticNetFence_01_roll_F",[3.11133,-1.49805,18.3987],0.607443,90,0,[0,0.926992,0.375081]],["Land_TacticalBacon_F",[3.19727,0.50293,19.2653],1.47399,0,0,[0,0,1]],["Land_BakedBeans_F",[3.28711,0.892578,18.8897],1.09836,0,0,[0,0,1]],["Tire_Van_02_Spare_F",[1.14746,2.11621,20.6777],2.88642,0,0,[0,0,1]],["Land_ChairWood_F",[2.78613,2.90137,17.8463],0.0549717,131.893,0,[0,0,1]],["Land_ChairWood_F",[2.8623,3.43652,17.8472],0.055872,88.9974,0,[0,0,1]],["Tire_Van_02_Spare_F",[2.81348,2.09863,20.6627],2.87145,0,0,[0,0,1]]];
			private _Lst = [_H,_H1] call FS_ACTSPWN;
			FS_SPWNEDLIST pushBack [_H,_Lst];
			[_Lst,(getPosASL _H),_H] spawn
			{
				params ["_Lst","_Pos","_H"];
				_H setVariable ["FS_SPWNOBJ",_Lst];
				waitUntil
				{
					if (player distance2D _Pos > FS_DIST && {!(_H getVariable ["FS_FAR",false])}) then
					{
						{deleteVehicle _x;true;} count _Lst;
						_H setVariable ["FS_SPWN",false];
						_H setVariable ["FS_FAR",false];
						{
							private _HO = _x select 0;
							if (_HO isEqualTo _H) exitWith
							{
								FS_SPWNEDLIST deleteAt _forEachIndex;
							};
						} foreach FS_SPWNEDLIST;
					};
					sleep 5;
					!(_H getVariable ["FS_SPWN",true])
				};
			};		
		};
		case "Land_i_Stone_HouseSmall_V2_F" :
		{
			private _H1 = [["Fridge_01_closed_F",[1.5293,-0.50293,19.0163],1.21583,180.506,0,[-0.00444844,0,0.99999]],["Land_TableSmall_01_F",[0.129883,2.8252,18.9727],1.18145,91.3303,0,[-0.000488281,-0.0115133,0.999934]],["Item_Binocular",[0.428711,2.9834,19.393],1.60173,82.9021,0,[-0.000488281,-0.0115133,0.999934]],["Item_FirstAidKit",[-0.0615234,2.85352,19.393],1.6017,0,0,[-0.000488281,-0.0115133,0.999934]],["Item_ItemGPS",[0.142578,2.86523,19.4001],1.60879,322.262,0,[-0.000488281,-0.0115133,0.999934]],["Land_Rugbyball_01_F",[0.416992,3.61621,19.4596],1.66832,84.1007,0,[0,0,1]],["Land_Trophy_01_gold_F",[0.397461,3.72461,19.9307],2.13939,83.0874,0,[-0.000488281,-0.0115133,0.999934]],["Land_WoodenBed_01_F",[-0.584961,4.05078,19.0192],1.22793,90.09,0,[-0.000488281,-0.0115133,0.999934]],["Land_EmergencyBlanket_01_discarded_F",[-0.666016,4.12109,19.4543],1.66301,190.095,0,[-0.00614727,-0.0115026,0.999915]],["Land_EmergencyBlanket_01_discarded_F",[-1.2793,4.04492,19.4625],1.67119,0,0,[-0.00614727,-0.0115026,0.999915]],["Land_KartSteertingWheel_01_F",[0.365234,4.50781,19.4827],1.69141,278.479,0,[0,0,1]],["Item_ItemWatch",[0.441406,4.15137,19.7065],1.91517,0,0,[-0.000488281,-0.0115133,0.999934]],["Land_Ketchup_01_F",[2.31738,4.49121,18.979],1.18767,0,0,[-0.000488281,-0.0115133,0.999934]],["Land_FMradio_F",[0.433594,4.71777,19.9345],2.14324,261.693,0,[-0.000488281,-0.0115133,0.999934]],["Land_Tableware_01_stackOfNapkins_F",[2.44727,4.53906,18.9796],1.18834,0,0,[0,0,1]],["Land_Tableware_01_napkin_F",[2.4502,4.50586,19.2079],1.41664,0,0,[0,0,1]],["Land_Mustard_01_F",[2.59277,4.46875,18.9838],1.19249,0,0,[-0.000488281,-0.0115133,0.999934]],["Land_Orange_01_F",[2.3457,4.55762,19.2045],1.41325,61.1153,0,[-0.000488281,-0.0115133,0.999934]],["Land_SurvivalRadio_F",[3.86133,2.98242,19.8423],2.05099,99.2275,0,[-0.00444844,0,0.99999]],["Land_ChairWood_F",[4.4873,2.61816,19.053],1.26168,198.193,0,[-0.00444844,0,0.99999]],["Land_Orange_01_F",[2.28027,4.62891,19.2068],1.41552,0,0,[-0.000488281,-0.0115133,0.999934]],["Land_Orange_01_F",[2.35938,4.64551,19.198],1.40669,166.149,0,[0,0,1]],["Land_Can_Dented_F",[2.49805,4.57813,19.2027],1.4114,0,0,[-0.000488281,-0.0115133,0.999934]],["Land_RiceBox_F",[2.80371,4.49219,18.9677],1.17645,275.534,0,[-0.000488281,-0.0115133,0.999934]],["Land_Can_Dented_F",[2.46777,4.64355,19.2027],1.4114,212.473,0,[-0.000488281,-0.0115133,0.999934]],["Land_Can_Dented_F",[2.56055,4.6416,19.2027],1.41141,138.714,0,[-0.000488281,-0.0115133,0.999934]],["Land_Tableware_01_cup_F",[4.29004,2.73926,19.847],2.05574,0,0,[-0.00444844,0,0.99999]],["Land_Can_Dented_F",[2.44922,4.72266,19.2027],1.41141,287.744,0,[-0.000488281,-0.0115133,0.999934]],["Land_Can_Dented_F",[2.51172,4.69238,19.2027],1.4114,78.888,0,[-0.000488281,-0.0115133,0.999934]],["Land_Basketball_01_F",[-1.9043,5.05762,18.9662],1.17487,334.245,0,[0,0,1]],["Land_CratesPlastic_F",[2.63574,4.68164,18.9633],1.17205,0,0,[-0.000488281,-0.0115133,0.999934]],["Land_Can_Dented_F",[2.57813,4.70996,19.2027],1.4114,168.111,0,[-0.000488281,-0.0115133,0.999934]],["Land_Can_Dented_F",[2.49512,4.76855,19.2027],1.41141,249.003,0,[-0.000488281,-0.0115133,0.999934]],["Land_RiceBox_F",[2.83887,4.64746,18.9734],1.18213,165.565,0,[-0.000488281,-0.0115133,0.999934]],["Land_CerealsBox_F",[3.98438,3.25391,19.8483],2.05703,337.847,0,[0,0,1]],["Land_Can_Dented_F",[2.55664,4.77441,19.2027],1.4114,31.8292,0,[-0.000488281,-0.0115133,0.999934]],["Intel_File1_F",[4.26563,3.09668,19.8539],2.06264,149.932,0,[-0.00444844,0,0.99999]],["Land_Garbage_square3_F",[4.59375,3.16113,19.0457],1.25439,251.09,0,[0,0,1]],["Land_RiceBox_F",[2.96191,4.74316,18.9655],1.17421,84.782,0,[0,0,1]],["Land_RiceBox_F",[2.81055,4.83301,18.9776],1.18627,134.243,0,[0,0,1]],["Land_Canteen_F",[2.65918,4.85742,19.1809],1.38965,43.5628,0,[-0.000488281,-0.0115133,0.999934]],["Land_WoodenTable_small_F",[4.50879,3.2207,18.9979],1.20658,271.053,0,[-0.00444844,0,0.99999]],["Land_TacticalBacon_F",[4.59668,2.84961,19.8468],2.05556,267.857,0,[-0.00444844,0,0.99999]],["Land_TacticalBacon_F",[4.7373,2.86426,19.8496],2.05828,35.4696,0,[-0.00444844,0,0.99999]],["Land_Tyre_01_F",[2.51563,5.13281,19.0582],1.26692,91.2278,0,[-0.000488281,-0.0115133,0.999934]],["Land_Tableware_01_napkin_F",[4.93359,2.79004,19.8526],2.06129,183.215,0,[0,0,1]],["Land_FoodSack_01_empty_brown_F",[4.60547,3.32813,19.8494],2.05809,331.716,0,[0,0,1]],["Land_ChairWood_F",[4.72363,3.84375,19.0571],1.26584,33.9379,0,[-0.000488281,-0.0115133,0.999934]],["Land_ChairWood_F",[5.30762,3.09277,19.0592],1.26794,116.244,0,[-0.00444844,0,0.99999]],["Land_Tableware_01_cup_F",[5.07227,3.05664,19.8486],2.05731,0,0,[-0.00444844,0,0.99999]],["Land_BakedBeans_F",[5.00195,3.27734,19.8587],2.06743,187.705,0,[-0.00444844,0,0.99999]],["Land_Tableware_01_cup_F",[4.82813,3.68164,19.8546],2.06329,0,0,[-0.00444844,0,0.99999]],["Land_FoodContainer_01_F",[8.99707,-0.709961,19.0622],1.25211,26.7915,0,[0,0,1]],["Land_FoodContainer_01_White_F",[9.04785,-0.295898,19.0649],1.25635,2.87952,0,[0,0,1]],["Land_FoodContainer_01_F",[9.06152,-0.518555,19.5137],1.70415,0,0,[0,0,1]],["Land_MobilePhone_old_F",[-9.08203,0.294922,19.9424],2.15113,95.8446,0,[0,0,1]],["Land_PCSet_01_mousepad_F",[-9.21484,0.275391,19.2945],1.50317,48.5323,0,[0,0,1]],["Land_PCSet_01_mousepad_IDAP_F",[-9.21777,0.503906,19.2915],1.50019,65.7907,0,[0,0,1]],["Land_ExtensionCord_F",[-9.25488,0.578125,19.008],1.21669,0,0,[-0.000488281,-0.0115133,0.999934]],["Land_ShelvesWooden_F",[-9.20605,0.554688,18.9827],1.19137,0.928599,0,[-0.000488281,-0.0115133,0.999934]],["Land_Laptop_F",[-9.18359,0.541016,19.5925],1.80118,100.342,0,[0,0,1]],["Box_I_UAV_06_F",[-8.5459,4.86035,18.9937],1.20241,0,0,[-0.000488281,-0.0115133,0.999934]],["Box_I_UAV_06_F",[-8.53418,4.86328,19.1954],1.4041,144.019,0,[0,0,1]],["Land_EmergencyBlanket_01_F",[8.76074,4.65918,19.0689],1.27225,62.5208,0,[-0.00444844,0,0.99999]],["Land_PaperBox_01_small_ransacked_brown_F",[8.7666,4.62402,19.0265],1.22981,247.705,0,[-0.00444844,0,0.99999]],["Land_Suitcase_F",[-8.8418,4.79688,18.9981],1.20682,80.3276,0,[-0.000488281,-0.0115133,0.999934]],["Land_BarrelEmpty_F",[-9.27832,4.83691,18.9442],1.15291,0,0,[-0.000488281,-0.0115133,0.999934]]];
			private _Lst = [_H,_H1] call FS_ACTSPWN;
			FS_SPWNEDLIST pushBack [_H,_Lst];
			[_Lst,(getPosASL _H),_H] spawn
			{
				params ["_Lst","_Pos","_H"];
				_H setVariable ["FS_SPWNOBJ",_Lst];
				waitUntil
				{
					if (player distance2D _Pos > FS_DIST && {!(_H getVariable ["FS_FAR",false])}) then
					{
						{deleteVehicle _x;true;} count _Lst;
						_H setVariable ["FS_SPWN",false];
						_H setVariable ["FS_FAR",false];
						{
							private _HO = _x select 0;
							if (_HO isEqualTo _H) exitWith
							{
								FS_SPWNEDLIST deleteAt _forEachIndex;
							};
						} foreach FS_SPWNEDLIST;
					};
					sleep 5;
					!(_H getVariable ["FS_SPWN",true])
				};
			};		
		};
		case "Land_i_Stone_HouseSmall_V1_F" :
		{
			private _H1 = [["Fridge_01_closed_F",[1.5293,-0.50293,19.0163],1.21583,180.506,0,[-0.00444844,0,0.99999]],["Land_TableSmall_01_F",[0.129883,2.8252,18.9727],1.18145,91.3303,0,[-0.000488281,-0.0115133,0.999934]],["Item_Binocular",[0.428711,2.9834,19.393],1.60173,82.9021,0,[-0.000488281,-0.0115133,0.999934]],["Item_FirstAidKit",[-0.0615234,2.85352,19.393],1.6017,0,0,[-0.000488281,-0.0115133,0.999934]],["Item_ItemGPS",[0.142578,2.86523,19.4001],1.60879,322.262,0,[-0.000488281,-0.0115133,0.999934]],["Land_Rugbyball_01_F",[0.416992,3.61621,19.4596],1.66832,84.1007,0,[0,0,1]],["Land_Trophy_01_gold_F",[0.397461,3.72461,19.9307],2.13939,83.0874,0,[-0.000488281,-0.0115133,0.999934]],["Land_WoodenBed_01_F",[-0.584961,4.05078,19.0192],1.22793,90.09,0,[-0.000488281,-0.0115133,0.999934]],["Land_EmergencyBlanket_01_discarded_F",[-0.666016,4.12109,19.4543],1.66301,190.095,0,[-0.00614727,-0.0115026,0.999915]],["Land_EmergencyBlanket_01_discarded_F",[-1.2793,4.04492,19.4625],1.67119,0,0,[-0.00614727,-0.0115026,0.999915]],["Land_KartSteertingWheel_01_F",[0.365234,4.50781,19.4827],1.69141,278.479,0,[0,0,1]],["Item_ItemWatch",[0.441406,4.15137,19.7065],1.91517,0,0,[-0.000488281,-0.0115133,0.999934]],["Land_Ketchup_01_F",[2.31738,4.49121,18.979],1.18767,0,0,[-0.000488281,-0.0115133,0.999934]],["Land_FMradio_F",[0.433594,4.71777,19.9345],2.14324,261.693,0,[-0.000488281,-0.0115133,0.999934]],["Land_Tableware_01_stackOfNapkins_F",[2.44727,4.53906,18.9796],1.18834,0,0,[0,0,1]],["Land_Tableware_01_napkin_F",[2.4502,4.50586,19.2079],1.41664,0,0,[0,0,1]],["Land_Mustard_01_F",[2.59277,4.46875,18.9838],1.19249,0,0,[-0.000488281,-0.0115133,0.999934]],["Land_Orange_01_F",[2.3457,4.55762,19.2045],1.41325,61.1153,0,[-0.000488281,-0.0115133,0.999934]],["Land_SurvivalRadio_F",[3.86133,2.98242,19.8423],2.05099,99.2275,0,[-0.00444844,0,0.99999]],["Land_ChairWood_F",[4.4873,2.61816,19.053],1.26168,198.193,0,[-0.00444844,0,0.99999]],["Land_Orange_01_F",[2.28027,4.62891,19.2068],1.41552,0,0,[-0.000488281,-0.0115133,0.999934]],["Land_Orange_01_F",[2.35938,4.64551,19.198],1.40669,166.149,0,[0,0,1]],["Land_Can_Dented_F",[2.49805,4.57813,19.2027],1.4114,0,0,[-0.000488281,-0.0115133,0.999934]],["Land_RiceBox_F",[2.80371,4.49219,18.9677],1.17645,275.534,0,[-0.000488281,-0.0115133,0.999934]],["Land_Can_Dented_F",[2.46777,4.64355,19.2027],1.4114,212.473,0,[-0.000488281,-0.0115133,0.999934]],["Land_Can_Dented_F",[2.56055,4.6416,19.2027],1.41141,138.714,0,[-0.000488281,-0.0115133,0.999934]],["Land_Tableware_01_cup_F",[4.29004,2.73926,19.847],2.05574,0,0,[-0.00444844,0,0.99999]],["Land_Can_Dented_F",[2.44922,4.72266,19.2027],1.41141,287.744,0,[-0.000488281,-0.0115133,0.999934]],["Land_Can_Dented_F",[2.51172,4.69238,19.2027],1.4114,78.888,0,[-0.000488281,-0.0115133,0.999934]],["Land_Basketball_01_F",[-1.9043,5.05762,18.9662],1.17487,334.245,0,[0,0,1]],["Land_CratesPlastic_F",[2.63574,4.68164,18.9633],1.17205,0,0,[-0.000488281,-0.0115133,0.999934]],["Land_Can_Dented_F",[2.57813,4.70996,19.2027],1.4114,168.111,0,[-0.000488281,-0.0115133,0.999934]],["Land_Can_Dented_F",[2.49512,4.76855,19.2027],1.41141,249.003,0,[-0.000488281,-0.0115133,0.999934]],["Land_RiceBox_F",[2.83887,4.64746,18.9734],1.18213,165.565,0,[-0.000488281,-0.0115133,0.999934]],["Land_CerealsBox_F",[3.98438,3.25391,19.8483],2.05703,337.847,0,[0,0,1]],["Land_Can_Dented_F",[2.55664,4.77441,19.2027],1.4114,31.8292,0,[-0.000488281,-0.0115133,0.999934]],["Intel_File1_F",[4.26563,3.09668,19.8539],2.06264,149.932,0,[-0.00444844,0,0.99999]],["Land_Garbage_square3_F",[4.59375,3.16113,19.0457],1.25439,251.09,0,[0,0,1]],["Land_RiceBox_F",[2.96191,4.74316,18.9655],1.17421,84.782,0,[0,0,1]],["Land_RiceBox_F",[2.81055,4.83301,18.9776],1.18627,134.243,0,[0,0,1]],["Land_Canteen_F",[2.65918,4.85742,19.1809],1.38965,43.5628,0,[-0.000488281,-0.0115133,0.999934]],["Land_WoodenTable_small_F",[4.50879,3.2207,18.9979],1.20658,271.053,0,[-0.00444844,0,0.99999]],["Land_TacticalBacon_F",[4.59668,2.84961,19.8468],2.05556,267.857,0,[-0.00444844,0,0.99999]],["Land_TacticalBacon_F",[4.7373,2.86426,19.8496],2.05828,35.4696,0,[-0.00444844,0,0.99999]],["Land_Tyre_01_F",[2.51563,5.13281,19.0582],1.26692,91.2278,0,[-0.000488281,-0.0115133,0.999934]],["Land_Tableware_01_napkin_F",[4.93359,2.79004,19.8526],2.06129,183.215,0,[0,0,1]],["Land_FoodSack_01_empty_brown_F",[4.60547,3.32813,19.8494],2.05809,331.716,0,[0,0,1]],["Land_ChairWood_F",[4.72363,3.84375,19.0571],1.26584,33.9379,0,[-0.000488281,-0.0115133,0.999934]],["Land_ChairWood_F",[5.30762,3.09277,19.0592],1.26794,116.244,0,[-0.00444844,0,0.99999]],["Land_Tableware_01_cup_F",[5.07227,3.05664,19.8486],2.05731,0,0,[-0.00444844,0,0.99999]],["Land_BakedBeans_F",[5.00195,3.27734,19.8587],2.06743,187.705,0,[-0.00444844,0,0.99999]],["Land_Tableware_01_cup_F",[4.82813,3.68164,19.8546],2.06329,0,0,[-0.00444844,0,0.99999]],["Land_FoodContainer_01_F",[8.99707,-0.709961,19.0622],1.25211,26.7915,0,[0,0,1]],["Land_FoodContainer_01_White_F",[9.04785,-0.295898,19.0649],1.25635,2.87952,0,[0,0,1]],["Land_FoodContainer_01_F",[9.06152,-0.518555,19.5137],1.70415,0,0,[0,0,1]],["Land_MobilePhone_old_F",[-9.08203,0.294922,19.9424],2.15113,95.8446,0,[0,0,1]],["Land_PCSet_01_mousepad_F",[-9.21484,0.275391,19.2945],1.50317,48.5323,0,[0,0,1]],["Land_PCSet_01_mousepad_IDAP_F",[-9.21777,0.503906,19.2915],1.50019,65.7907,0,[0,0,1]],["Land_ExtensionCord_F",[-9.25488,0.578125,19.008],1.21669,0,0,[-0.000488281,-0.0115133,0.999934]],["Land_ShelvesWooden_F",[-9.20605,0.554688,18.9827],1.19137,0.928599,0,[-0.000488281,-0.0115133,0.999934]],["Land_Laptop_F",[-9.18359,0.541016,19.5925],1.80118,100.342,0,[0,0,1]],["Box_I_UAV_06_F",[-8.5459,4.86035,18.9937],1.20241,0,0,[-0.000488281,-0.0115133,0.999934]],["Box_I_UAV_06_F",[-8.53418,4.86328,19.1954],1.4041,144.019,0,[0,0,1]],["Land_EmergencyBlanket_01_F",[8.76074,4.65918,19.0689],1.27225,62.5208,0,[-0.00444844,0,0.99999]],["Land_PaperBox_01_small_ransacked_brown_F",[8.7666,4.62402,19.0265],1.22981,247.705,0,[-0.00444844,0,0.99999]],["Land_Suitcase_F",[-8.8418,4.79688,18.9981],1.20682,80.3276,0,[-0.000488281,-0.0115133,0.999934]],["Land_BarrelEmpty_F",[-9.27832,4.83691,18.9442],1.15291,0,0,[-0.000488281,-0.0115133,0.999934]]];
			private _Lst = [_H,_H1] call FS_ACTSPWN;
			FS_SPWNEDLIST pushBack [_H,_Lst];
			[_Lst,(getPosASL _H),_H] spawn
			{
				params ["_Lst","_Pos","_H"];
				_H setVariable ["FS_SPWNOBJ",_Lst];
				waitUntil
				{
					if (player distance2D _Pos > FS_DIST && {!(_H getVariable ["FS_FAR",false])}) then
					{
						{deleteVehicle _x;true;} count _Lst;
						_H setVariable ["FS_SPWN",false];
						_H setVariable ["FS_FAR",false];
						{
							private _HO = _x select 0;
							if (_HO isEqualTo _H) exitWith
							{
								FS_SPWNEDLIST deleteAt _forEachIndex;
							};
						} foreach FS_SPWNEDLIST;
					};
					sleep 5;
					!(_H getVariable ["FS_SPWN",true])
				};
			};		
		};			
		case "Land_i_Stone_HouseSmall_V3_F" :
		{
			private _H1 = [["Fridge_01_closed_F",[1.5293,-0.50293,19.0163],1.21583,180.506,0,[-0.00444844,0,0.99999]],["Land_TableSmall_01_F",[0.129883,2.8252,18.9727],1.18145,91.3303,0,[-0.000488281,-0.0115133,0.999934]],["Item_Binocular",[0.428711,2.9834,19.393],1.60173,82.9021,0,[-0.000488281,-0.0115133,0.999934]],["Item_FirstAidKit",[-0.0615234,2.85352,19.393],1.6017,0,0,[-0.000488281,-0.0115133,0.999934]],["Item_ItemGPS",[0.142578,2.86523,19.4001],1.60879,322.262,0,[-0.000488281,-0.0115133,0.999934]],["Land_Rugbyball_01_F",[0.416992,3.61621,19.4596],1.66832,84.1007,0,[0,0,1]],["Land_Trophy_01_gold_F",[0.397461,3.72461,19.9307],2.13939,83.0874,0,[-0.000488281,-0.0115133,0.999934]],["Land_WoodenBed_01_F",[-0.584961,4.05078,19.0192],1.22793,90.09,0,[-0.000488281,-0.0115133,0.999934]],["Land_EmergencyBlanket_01_discarded_F",[-0.666016,4.12109,19.4543],1.66301,190.095,0,[-0.00614727,-0.0115026,0.999915]],["Land_EmergencyBlanket_01_discarded_F",[-1.2793,4.04492,19.4625],1.67119,0,0,[-0.00614727,-0.0115026,0.999915]],["Land_KartSteertingWheel_01_F",[0.365234,4.50781,19.4827],1.69141,278.479,0,[0,0,1]],["Item_ItemWatch",[0.441406,4.15137,19.7065],1.91517,0,0,[-0.000488281,-0.0115133,0.999934]],["Land_Ketchup_01_F",[2.31738,4.49121,18.979],1.18767,0,0,[-0.000488281,-0.0115133,0.999934]],["Land_FMradio_F",[0.433594,4.71777,19.9345],2.14324,261.693,0,[-0.000488281,-0.0115133,0.999934]],["Land_Tableware_01_stackOfNapkins_F",[2.44727,4.53906,18.9796],1.18834,0,0,[0,0,1]],["Land_Tableware_01_napkin_F",[2.4502,4.50586,19.2079],1.41664,0,0,[0,0,1]],["Land_Mustard_01_F",[2.59277,4.46875,18.9838],1.19249,0,0,[-0.000488281,-0.0115133,0.999934]],["Land_Orange_01_F",[2.3457,4.55762,19.2045],1.41325,61.1153,0,[-0.000488281,-0.0115133,0.999934]],["Land_SurvivalRadio_F",[3.86133,2.98242,19.8423],2.05099,99.2275,0,[-0.00444844,0,0.99999]],["Land_ChairWood_F",[4.4873,2.61816,19.053],1.26168,198.193,0,[-0.00444844,0,0.99999]],["Land_Orange_01_F",[2.28027,4.62891,19.2068],1.41552,0,0,[-0.000488281,-0.0115133,0.999934]],["Land_Orange_01_F",[2.35938,4.64551,19.198],1.40669,166.149,0,[0,0,1]],["Land_Can_Dented_F",[2.49805,4.57813,19.2027],1.4114,0,0,[-0.000488281,-0.0115133,0.999934]],["Land_RiceBox_F",[2.80371,4.49219,18.9677],1.17645,275.534,0,[-0.000488281,-0.0115133,0.999934]],["Land_Can_Dented_F",[2.46777,4.64355,19.2027],1.4114,212.473,0,[-0.000488281,-0.0115133,0.999934]],["Land_Can_Dented_F",[2.56055,4.6416,19.2027],1.41141,138.714,0,[-0.000488281,-0.0115133,0.999934]],["Land_Tableware_01_cup_F",[4.29004,2.73926,19.847],2.05574,0,0,[-0.00444844,0,0.99999]],["Land_Can_Dented_F",[2.44922,4.72266,19.2027],1.41141,287.744,0,[-0.000488281,-0.0115133,0.999934]],["Land_Can_Dented_F",[2.51172,4.69238,19.2027],1.4114,78.888,0,[-0.000488281,-0.0115133,0.999934]],["Land_Basketball_01_F",[-1.9043,5.05762,18.9662],1.17487,334.245,0,[0,0,1]],["Land_CratesPlastic_F",[2.63574,4.68164,18.9633],1.17205,0,0,[-0.000488281,-0.0115133,0.999934]],["Land_Can_Dented_F",[2.57813,4.70996,19.2027],1.4114,168.111,0,[-0.000488281,-0.0115133,0.999934]],["Land_Can_Dented_F",[2.49512,4.76855,19.2027],1.41141,249.003,0,[-0.000488281,-0.0115133,0.999934]],["Land_RiceBox_F",[2.83887,4.64746,18.9734],1.18213,165.565,0,[-0.000488281,-0.0115133,0.999934]],["Land_CerealsBox_F",[3.98438,3.25391,19.8483],2.05703,337.847,0,[0,0,1]],["Land_Can_Dented_F",[2.55664,4.77441,19.2027],1.4114,31.8292,0,[-0.000488281,-0.0115133,0.999934]],["Intel_File1_F",[4.26563,3.09668,19.8539],2.06264,149.932,0,[-0.00444844,0,0.99999]],["Land_Garbage_square3_F",[4.59375,3.16113,19.0457],1.25439,251.09,0,[0,0,1]],["Land_RiceBox_F",[2.96191,4.74316,18.9655],1.17421,84.782,0,[0,0,1]],["Land_RiceBox_F",[2.81055,4.83301,18.9776],1.18627,134.243,0,[0,0,1]],["Land_Canteen_F",[2.65918,4.85742,19.1809],1.38965,43.5628,0,[-0.000488281,-0.0115133,0.999934]],["Land_WoodenTable_small_F",[4.50879,3.2207,18.9979],1.20658,271.053,0,[-0.00444844,0,0.99999]],["Land_TacticalBacon_F",[4.59668,2.84961,19.8468],2.05556,267.857,0,[-0.00444844,0,0.99999]],["Land_TacticalBacon_F",[4.7373,2.86426,19.8496],2.05828,35.4696,0,[-0.00444844,0,0.99999]],["Land_Tyre_01_F",[2.51563,5.13281,19.0582],1.26692,91.2278,0,[-0.000488281,-0.0115133,0.999934]],["Land_Tableware_01_napkin_F",[4.93359,2.79004,19.8526],2.06129,183.215,0,[0,0,1]],["Land_FoodSack_01_empty_brown_F",[4.60547,3.32813,19.8494],2.05809,331.716,0,[0,0,1]],["Land_ChairWood_F",[4.72363,3.84375,19.0571],1.26584,33.9379,0,[-0.000488281,-0.0115133,0.999934]],["Land_ChairWood_F",[5.30762,3.09277,19.0592],1.26794,116.244,0,[-0.00444844,0,0.99999]],["Land_Tableware_01_cup_F",[5.07227,3.05664,19.8486],2.05731,0,0,[-0.00444844,0,0.99999]],["Land_BakedBeans_F",[5.00195,3.27734,19.8587],2.06743,187.705,0,[-0.00444844,0,0.99999]],["Land_Tableware_01_cup_F",[4.82813,3.68164,19.8546],2.06329,0,0,[-0.00444844,0,0.99999]],["Land_FoodContainer_01_F",[8.99707,-0.709961,19.0622],1.25211,26.7915,0,[0,0,1]],["Land_FoodContainer_01_White_F",[9.04785,-0.295898,19.0649],1.25635,2.87952,0,[0,0,1]],["Land_FoodContainer_01_F",[9.06152,-0.518555,19.5137],1.70415,0,0,[0,0,1]],["Land_MobilePhone_old_F",[-9.08203,0.294922,19.9424],2.15113,95.8446,0,[0,0,1]],["Land_PCSet_01_mousepad_F",[-9.21484,0.275391,19.2945],1.50317,48.5323,0,[0,0,1]],["Land_PCSet_01_mousepad_IDAP_F",[-9.21777,0.503906,19.2915],1.50019,65.7907,0,[0,0,1]],["Land_ExtensionCord_F",[-9.25488,0.578125,19.008],1.21669,0,0,[-0.000488281,-0.0115133,0.999934]],["Land_ShelvesWooden_F",[-9.20605,0.554688,18.9827],1.19137,0.928599,0,[-0.000488281,-0.0115133,0.999934]],["Land_Laptop_F",[-9.18359,0.541016,19.5925],1.80118,100.342,0,[0,0,1]],["Box_I_UAV_06_F",[-8.5459,4.86035,18.9937],1.20241,0,0,[-0.000488281,-0.0115133,0.999934]],["Box_I_UAV_06_F",[-8.53418,4.86328,19.1954],1.4041,144.019,0,[0,0,1]],["Land_EmergencyBlanket_01_F",[8.76074,4.65918,19.0689],1.27225,62.5208,0,[-0.00444844,0,0.99999]],["Land_PaperBox_01_small_ransacked_brown_F",[8.7666,4.62402,19.0265],1.22981,247.705,0,[-0.00444844,0,0.99999]],["Land_Suitcase_F",[-8.8418,4.79688,18.9981],1.20682,80.3276,0,[-0.000488281,-0.0115133,0.999934]],["Land_BarrelEmpty_F",[-9.27832,4.83691,18.9442],1.15291,0,0,[-0.000488281,-0.0115133,0.999934]]];
			private _Lst = [_H,_H1] call FS_ACTSPWN;
			FS_SPWNEDLIST pushBack [_H,_Lst];
			[_Lst,(getPosASL _H),_H] spawn
			{
				params ["_Lst","_Pos","_H"];
				_H setVariable ["FS_SPWNOBJ",_Lst];
				waitUntil
				{
					if (player distance2D _Pos > FS_DIST && {!(_H getVariable ["FS_FAR",false])}) then
					{
						{deleteVehicle _x;true;} count _Lst;
						_H setVariable ["FS_SPWN",false];
						_H setVariable ["FS_FAR",false];
						{
							private _HO = _x select 0;
							if (_HO isEqualTo _H) exitWith
							{
								FS_SPWNEDLIST deleteAt _forEachIndex;
							};
						} foreach FS_SPWNEDLIST;
					};
					sleep 5;
					!(_H getVariable ["FS_SPWN",true])
				};
			};		
		};
		case "Land_i_Stone_HouseSmall_V1_F" :
		{
			private _H1 = [["Fridge_01_closed_F",[1.5293,-0.50293,19.0163],1.21583,180.506,0,[-0.00444844,0,0.99999]],["Land_TableSmall_01_F",[0.129883,2.8252,18.9727],1.18145,91.3303,0,[-0.000488281,-0.0115133,0.999934]],["Item_Binocular",[0.428711,2.9834,19.393],1.60173,82.9021,0,[-0.000488281,-0.0115133,0.999934]],["Item_FirstAidKit",[-0.0615234,2.85352,19.393],1.6017,0,0,[-0.000488281,-0.0115133,0.999934]],["Item_ItemGPS",[0.142578,2.86523,19.4001],1.60879,322.262,0,[-0.000488281,-0.0115133,0.999934]],["Land_Rugbyball_01_F",[0.416992,3.61621,19.4596],1.66832,84.1007,0,[0,0,1]],["Land_Trophy_01_gold_F",[0.397461,3.72461,19.9307],2.13939,83.0874,0,[-0.000488281,-0.0115133,0.999934]],["Land_WoodenBed_01_F",[-0.584961,4.05078,19.0192],1.22793,90.09,0,[-0.000488281,-0.0115133,0.999934]],["Land_EmergencyBlanket_01_discarded_F",[-0.666016,4.12109,19.4543],1.66301,190.095,0,[-0.00614727,-0.0115026,0.999915]],["Land_EmergencyBlanket_01_discarded_F",[-1.2793,4.04492,19.4625],1.67119,0,0,[-0.00614727,-0.0115026,0.999915]],["Land_KartSteertingWheel_01_F",[0.365234,4.50781,19.4827],1.69141,278.479,0,[0,0,1]],["Item_ItemWatch",[0.441406,4.15137,19.7065],1.91517,0,0,[-0.000488281,-0.0115133,0.999934]],["Land_Ketchup_01_F",[2.31738,4.49121,18.979],1.18767,0,0,[-0.000488281,-0.0115133,0.999934]],["Land_FMradio_F",[0.433594,4.71777,19.9345],2.14324,261.693,0,[-0.000488281,-0.0115133,0.999934]],["Land_Tableware_01_stackOfNapkins_F",[2.44727,4.53906,18.9796],1.18834,0,0,[0,0,1]],["Land_Tableware_01_napkin_F",[2.4502,4.50586,19.2079],1.41664,0,0,[0,0,1]],["Land_Mustard_01_F",[2.59277,4.46875,18.9838],1.19249,0,0,[-0.000488281,-0.0115133,0.999934]],["Land_Orange_01_F",[2.3457,4.55762,19.2045],1.41325,61.1153,0,[-0.000488281,-0.0115133,0.999934]],["Land_SurvivalRadio_F",[3.86133,2.98242,19.8423],2.05099,99.2275,0,[-0.00444844,0,0.99999]],["Land_ChairWood_F",[4.4873,2.61816,19.053],1.26168,198.193,0,[-0.00444844,0,0.99999]],["Land_Orange_01_F",[2.28027,4.62891,19.2068],1.41552,0,0,[-0.000488281,-0.0115133,0.999934]],["Land_Orange_01_F",[2.35938,4.64551,19.198],1.40669,166.149,0,[0,0,1]],["Land_Can_Dented_F",[2.49805,4.57813,19.2027],1.4114,0,0,[-0.000488281,-0.0115133,0.999934]],["Land_RiceBox_F",[2.80371,4.49219,18.9677],1.17645,275.534,0,[-0.000488281,-0.0115133,0.999934]],["Land_Can_Dented_F",[2.46777,4.64355,19.2027],1.4114,212.473,0,[-0.000488281,-0.0115133,0.999934]],["Land_Can_Dented_F",[2.56055,4.6416,19.2027],1.41141,138.714,0,[-0.000488281,-0.0115133,0.999934]],["Land_Tableware_01_cup_F",[4.29004,2.73926,19.847],2.05574,0,0,[-0.00444844,0,0.99999]],["Land_Can_Dented_F",[2.44922,4.72266,19.2027],1.41141,287.744,0,[-0.000488281,-0.0115133,0.999934]],["Land_Can_Dented_F",[2.51172,4.69238,19.2027],1.4114,78.888,0,[-0.000488281,-0.0115133,0.999934]],["Land_Basketball_01_F",[-1.9043,5.05762,18.9662],1.17487,334.245,0,[0,0,1]],["Land_CratesPlastic_F",[2.63574,4.68164,18.9633],1.17205,0,0,[-0.000488281,-0.0115133,0.999934]],["Land_Can_Dented_F",[2.57813,4.70996,19.2027],1.4114,168.111,0,[-0.000488281,-0.0115133,0.999934]],["Land_Can_Dented_F",[2.49512,4.76855,19.2027],1.41141,249.003,0,[-0.000488281,-0.0115133,0.999934]],["Land_RiceBox_F",[2.83887,4.64746,18.9734],1.18213,165.565,0,[-0.000488281,-0.0115133,0.999934]],["Land_CerealsBox_F",[3.98438,3.25391,19.8483],2.05703,337.847,0,[0,0,1]],["Land_Can_Dented_F",[2.55664,4.77441,19.2027],1.4114,31.8292,0,[-0.000488281,-0.0115133,0.999934]],["Intel_File1_F",[4.26563,3.09668,19.8539],2.06264,149.932,0,[-0.00444844,0,0.99999]],["Land_Garbage_square3_F",[4.59375,3.16113,19.0457],1.25439,251.09,0,[0,0,1]],["Land_RiceBox_F",[2.96191,4.74316,18.9655],1.17421,84.782,0,[0,0,1]],["Land_RiceBox_F",[2.81055,4.83301,18.9776],1.18627,134.243,0,[0,0,1]],["Land_Canteen_F",[2.65918,4.85742,19.1809],1.38965,43.5628,0,[-0.000488281,-0.0115133,0.999934]],["Land_WoodenTable_small_F",[4.50879,3.2207,18.9979],1.20658,271.053,0,[-0.00444844,0,0.99999]],["Land_TacticalBacon_F",[4.59668,2.84961,19.8468],2.05556,267.857,0,[-0.00444844,0,0.99999]],["Land_TacticalBacon_F",[4.7373,2.86426,19.8496],2.05828,35.4696,0,[-0.00444844,0,0.99999]],["Land_Tyre_01_F",[2.51563,5.13281,19.0582],1.26692,91.2278,0,[-0.000488281,-0.0115133,0.999934]],["Land_Tableware_01_napkin_F",[4.93359,2.79004,19.8526],2.06129,183.215,0,[0,0,1]],["Land_FoodSack_01_empty_brown_F",[4.60547,3.32813,19.8494],2.05809,331.716,0,[0,0,1]],["Land_ChairWood_F",[4.72363,3.84375,19.0571],1.26584,33.9379,0,[-0.000488281,-0.0115133,0.999934]],["Land_ChairWood_F",[5.30762,3.09277,19.0592],1.26794,116.244,0,[-0.00444844,0,0.99999]],["Land_Tableware_01_cup_F",[5.07227,3.05664,19.8486],2.05731,0,0,[-0.00444844,0,0.99999]],["Land_BakedBeans_F",[5.00195,3.27734,19.8587],2.06743,187.705,0,[-0.00444844,0,0.99999]],["Land_Tableware_01_cup_F",[4.82813,3.68164,19.8546],2.06329,0,0,[-0.00444844,0,0.99999]],["Land_FoodContainer_01_F",[8.99707,-0.709961,19.0622],1.25211,26.7915,0,[0,0,1]],["Land_FoodContainer_01_White_F",[9.04785,-0.295898,19.0649],1.25635,2.87952,0,[0,0,1]],["Land_FoodContainer_01_F",[9.06152,-0.518555,19.5137],1.70415,0,0,[0,0,1]],["Land_MobilePhone_old_F",[-9.08203,0.294922,19.9424],2.15113,95.8446,0,[0,0,1]],["Land_PCSet_01_mousepad_F",[-9.21484,0.275391,19.2945],1.50317,48.5323,0,[0,0,1]],["Land_PCSet_01_mousepad_IDAP_F",[-9.21777,0.503906,19.2915],1.50019,65.7907,0,[0,0,1]],["Land_ExtensionCord_F",[-9.25488,0.578125,19.008],1.21669,0,0,[-0.000488281,-0.0115133,0.999934]],["Land_ShelvesWooden_F",[-9.20605,0.554688,18.9827],1.19137,0.928599,0,[-0.000488281,-0.0115133,0.999934]],["Land_Laptop_F",[-9.18359,0.541016,19.5925],1.80118,100.342,0,[0,0,1]],["Box_I_UAV_06_F",[-8.5459,4.86035,18.9937],1.20241,0,0,[-0.000488281,-0.0115133,0.999934]],["Box_I_UAV_06_F",[-8.53418,4.86328,19.1954],1.4041,144.019,0,[0,0,1]],["Land_EmergencyBlanket_01_F",[8.76074,4.65918,19.0689],1.27225,62.5208,0,[-0.00444844,0,0.99999]],["Land_PaperBox_01_small_ransacked_brown_F",[8.7666,4.62402,19.0265],1.22981,247.705,0,[-0.00444844,0,0.99999]],["Land_Suitcase_F",[-8.8418,4.79688,18.9981],1.20682,80.3276,0,[-0.000488281,-0.0115133,0.999934]],["Land_BarrelEmpty_F",[-9.27832,4.83691,18.9442],1.15291,0,0,[-0.000488281,-0.0115133,0.999934]]];
			private _Lst = [_H,_H1] call FS_ACTSPWN;
			FS_SPWNEDLIST pushBack [_H,_Lst];
			[_Lst,(getPosASL _H),_H] spawn
			{
				params ["_Lst","_Pos","_H"];
				_H setVariable ["FS_SPWNOBJ",_Lst];
				waitUntil
				{
					if (player distance2D _Pos > FS_DIST && {!(_H getVariable ["FS_FAR",false])}) then
					{
						{deleteVehicle _x;true;} count _Lst;
						_H setVariable ["FS_SPWN",false];
						_H setVariable ["FS_FAR",false];
						{
							private _HO = _x select 0;
							if (_HO isEqualTo _H) exitWith
							{
								FS_SPWNEDLIST deleteAt _forEachIndex;
							};
						} foreach FS_SPWNEDLIST;
					};
					sleep 5;
					!(_H getVariable ["FS_SPWN",true])
				};
			};		
		};			
		case "Land_i_Stone_HouseBig_V1_F" :
		{
			private _H1 = [["Land_WoodenTable_large_F",[-0.342773,-0.673828,18.1413],0.188334,317.894,228.262,[0.00173704,-0.00194855,0.999997]],["Land_WaterPurificationTablets_F",[0.208008,-0.699219,19.0105],1.05236,15.9259,228.262,[0.00170256,-0.00203766,0.999996]],["Land_PortableSpeakers_01_F",[-0.194336,-0.791016,19.0047],1.05131,330.455,228.262,[0.00184716,-0.00182401,0.999997]],["babe_helper",[1.49219,1.44727,18.1192],0.129999,0,228.262,[0,-0,1]],["Land_Tableware_01_knife_F",[0.222656,2.73633,19.2288],1.243,318.866,228.262,[-1.20219e-005,1.56426e-005,1]],["Land_Tableware_01_fork_F",[0.291016,2.73047,19.2294],1.243,318.858,228.262,[8.75511e-006,-6.07298e-006,1]],["Land_Tableware_01_spoon_F",[0.164063,2.74805,19.2283],1.243,318.86,228.262,[-5.60612e-006,2.91051e-006,1]],["Land_Can_Rusty_F",[0.679688,2.91992,19.2346],1.243,93.8026,228.262,[0.000194187,8.95885e-005,1]],["Land_Can_V1_F",[0.578125,2.97852,19.2341],1.243,175.951,228.262,[0.000216992,-8.27588e-005,1]],["Land_CampingChair_V1_folded_F",[0.506836,-1.09961,20.9631],3.00562,49.1147,228.262,[0,0,1]],["Land_Can_V2_F",[0.644531,3.04883,19.2352],1.243,272.968,228.262,[6.02988e-005,-0.000203098,1]],["Land_Can_V3_F",[0.513672,3.07422,19.2341],1.243,195.288,228.262,[0.000229999,-2.89771e-005,1]],["Land_PowderedMilk_F",[1.22461,2.89453,19.2399],1.243,0.000233172,228.262,[2.08153e-006,-1.35033e-006,1]],["Land_Can_V2_F",[0.743164,3.05664,19.2363],1.243,63.1237,228.262,[-0.000246329,7.37841e-006,1]],["Land_BakedBeans_F",[0.245117,3.19336,19.2323],1.243,0.00369988,228.262,[1.39955e-005,5.32085e-005,1]],["Land_Can_V2_F",[0.594727,3.17773,19.2357],1.243,12.7455,228.262,[-0.000201146,6.7953e-005,1]],["Land_Can_V3_F",[0.722656,3.1875,19.237],1.243,341.898,228.262,[0.00022237,3.11773e-005,1]],["Land_TinContainer_F",[1.22949,3.18945,19.2392],1.24017,127.067,228.262,[0.130846,-0.113772,0.984853]],["Land_ChairPlastic_F",[-1.32422,0.0976563,21.0093],3.059,245.824,228.262,[-2.05759e-005,-1.12322e-005,1]],["Land_FoodContainer_01_F",[0.216797,3.50586,19.2342],1.243,332.75,228.262,[9.38407e-006,-3.8443e-006,1]],["Land_BottlePlastic_V1_F",[1.22754,3.38867,19.2435],1.24303,77.0978,228.262,[0.000508671,-0.00176672,0.999998]],["Land_CampingChair_V2_white_F",[-1.35352,-0.957031,21.0014],3.06094,113.889,228.262,[0.00271845,0.00625682,0.999977]],["Land_CerealsBox_F",[0.591797,3.64648,19.239],1.243,228.996,228.262,[7.62111e-005,2.53147e-005,1]],["Land_RiceBox_F",[1.17285,3.54883,19.2441],1.24301,172.49,228.262,[-0.000210984,-0.000288946,1]],["Land_RiceBox_F",[1.04297,3.59961,19.2432],1.24302,164.681,228.262,[-0.000177572,-0.000319055,1]],["Land_CerealsBox_F",[0.827148,3.67773,19.2416],1.24302,229.012,228.262,[-0.000386723,-0.00039659,1]],["Land_Canteen_F",[1.26465,3.7793,19.2467],1.24302,242.032,228.262,[-0.000700862,-0.000390223,1]],["Land_RattanTable_01_F",[1.36719,3.18945,21.0598],3.05934,50.1419,228.262,[-0.000865742,-0.000799262,0.999999]],["Land_PortableLight_single_F",[-1.56055,3.23633,21.0172],3.04562,182.668,228.262,[0,0,1]]];
			private _Lst = [_H,_H1] call FS_ACTSPWN;
			FS_SPWNEDLIST pushBack [_H,_Lst];
			[_Lst,(getPosASL _H),_H] spawn
			{
				params ["_Lst","_Pos","_H"];
				_H setVariable ["FS_SPWNOBJ",_Lst];
				waitUntil
				{
					if (player distance2D _Pos > FS_DIST && {!(_H getVariable ["FS_FAR",false])}) then
					{
						{deleteVehicle _x;true;} count _Lst;
						_H setVariable ["FS_SPWN",false];
						_H setVariable ["FS_FAR",false];
						{
							private _HO = _x select 0;
							if (_HO isEqualTo _H) exitWith
							{
								FS_SPWNEDLIST deleteAt _forEachIndex;
							};
						} foreach FS_SPWNEDLIST;
					};
					sleep 5;
					!(_H getVariable ["FS_SPWN",true])
				};
			};		
		};
		case "Land_i_House_Big_01_V1_F" :
		{
			private _H1 = [["Land_Garbage_square3_F",[1.23242,-1.01172,18.2468],0.455561,0,226.104,[0,0,1]],["Land_CampingChair_V2_white_F",[1.95801,0.289063,18.2294],0.43961,43.6178,226.104,[0,0,1]],["Land_CampingTable_small_white_F",[1.97168,0.748047,18.2435],0.454165,46.1727,226.104,[0,0,1]],["Land_Garbage_square3_F",[-0.978516,2.16211,18.2189],0.428234,258.718,226.104,[0,0,1]],["Land_Laptop_F",[1.92676,0.722656,19.0573],1.26787,40.1009,226.104,[0,0,1]],["Land_Rug_01_F",[-0.814453,-2.25391,18.239],0.44771,225.28,226.104,[0,0,1]],["Land_Bench_F",[-1.33203,-2.26563,18.2651],0.473848,46.4463,226.104,[0,0,1]],["Land_Sack_F",[-2.70703,1.36523,18.2913],0.5,0,226.104,[0,0,1]],["Land_Camping_Light_F",[-1.30957,-3.07813,18.773],0.98172,33.9765,226.104,[0,0,1]],["Land_CratesShabby_F",[-3.5752,1.57031,18.2339],0.442635,316.445,226.104,[0,0,1]],["Land_Magazine_rifle_F",[0.569336,-1.49219,21.6735],3.88226,133.452,226.104,[0,0,1]],["Land_Garbage_line_F",[-0.625977,-4.13281,18.2654],0.474127,225.37,226.104,[0,0,1]],["Land_Magazine_rifle_F",[0.739258,-1.51367,21.6701],3.87877,0,226.104,[0,0,1]],["Land_Garbage_line_F",[1.46289,-0.804688,21.673],3.88172,0,226.104,[0,0,1]],["Land_Magazine_rifle_F",[0.604492,-1.66797,21.6707],3.87936,95.0796,226.104,[0,0,1]],["Land_Magazine_rifle_F",[0.71875,-1.66602,21.672],3.88067,236.592,226.104,[0,0,1]],["Land_DataTerminal_01_F",[-0.129883,-2.11328,21.7113],3.92,0,226.104,[0,0,1]],["Land_Basket_F",[-3.7666,2.34375,18.2129],0.421576,274.942,226.104,[0,0,1]],["Land_Garbage_square5_F",[-2.13477,-0.445313,21.6914],3.90008,45.8613,226.104,[0,0,1]],["Land_Ammobox_rounds_F",[0.805664,-1.91211,21.7113],3.92,319.475,226.104,[0,0,1]],["Land_Ammobox_rounds_F",[1.05371,-1.95117,21.7113],3.92,145.83,226.104,[0,0,1]],["Land_MetalWire_F",[-2.68652,3.80469,18.2285],0.437185,0,226.104,[0,0,1]],["Land_Axe_F",[3.00195,3.77344,18.2119],0.424772,0,226.104,[0,0,1]],["Land_BarrelTrash_F",[0.290039,-2.52734,21.6145],3.82325,248.356,226.104,[0,0,1]],["Land_Laptop_02_F",[-0.145508,-2.13281,22.1971],4.40583,356.718,226.104,[0,0,1]],["Land_CanisterFuel_Blue_F",[3.6416,3.4375,18.2324],0.446262,84.5206,226.104,[0,0,1]],["Land_BarrelTrash_F",[1.05176,-2.57813,21.638],3.8467,0,226.104,[0,0,1]],["Land_Garbage_square5_F",[2.49805,-4.62891,18.2383],0.448538,224.361,226.104,[0,0,1]],["Land_Garbage_square5_F",[-1.02539,5.17578,18.1847],0.393427,131.015,226.104,[0,0,1]],["Land_Sacks_heap_F",[-3.47266,4.21875,18.2782],0.486958,0,226.104,[0,0,1]],["Land_Basket_F",[4.21875,3.66211,18.2036],0.417828,0,226.104,[0,0,1]],["Land_Garbage_line_F",[-3.49316,-2.47656,21.69],3.89873,224.023,226.104,[0,0,1]],["Land_CampingChair_V2_white_F",[0.725586,-5.91211,18.23],0.439734,228.141,226.104,[0,0,1]],["Land_Bucket_F",[4.36621,4.14648,18.2284],0.442247,276.009,226.104,[0,0,1]],["Land_Garbage_square3_F",[2.91211,5.33984,18.2359],0.447285,142.965,226.104,[0,0,1]],["Land_File_F",[-3.84863,4.80273,18.2211],0.429808,268.914,226.104,[0,0,1]],["Land_Garbage_square5_F",[1.83008,-5.01172,21.655],3.86489,317.326,226.104,[0,0,1]],["Land_Garbage_square5_F",[1.96289,5.21094,21.6563],3.86689,136.646,226.104,[0,0,1]],["Land_CampingTable_white_F",[1.14941,-6.67969,18.2528],0.463573,45.4645,226.104,[0,0,1]],["MedicalGarbage_01_5x5_v1_F",[-2.08789,5.28516,21.6596],3.86831,318.948,226.104,[0,0,1]],["Land_Tablet_01_F",[1.34277,-6.68945,19.0667],1.27771,55.8809,226.104,[0,0,1]],["Land_Can_V3_F",[0.521484,-6.9375,19.0687],1.27917,302.856,226.104,[0,0,1]],["Land_PowderedMilk_F",[1.81152,-6.73828,19.0677],1.27917,0,226.104,[0,0,1]],["Land_Can_V1_F",[0.589844,-6.94922,19.0687],1.27917,287.808,226.104,[0,0,1]],["Land_Can_V2_F",[0.666016,-6.94531,19.0686],1.2792,271.79,226.104,[0,0,1]],["Land_Garbage_square3_F",[-2.65723,-5.38672,21.6589],3.86758,326.938,226.104,[0,0,1]],["Land_WoodenBed_01_F",[3.49023,5.35742,21.6609],3.87282,316.366,226.104,[0,0,1]],["Land_CanisterPlastic_F",[-3.89453,6.83789,18.2355],0.444191,4.32719,226.104,[0,0,1]]];
			private _Lst = [_H,_H1] call FS_ACTSPWN;
			FS_SPWNEDLIST pushBack [_H,_Lst];
			[_Lst,(getPosASL _H),_H] spawn
			{
				params ["_Lst","_Pos","_H"];
				_H setVariable ["FS_SPWNOBJ",_Lst];
				waitUntil
				{
					if (player distance2D _Pos > FS_DIST && {!(_H getVariable ["FS_FAR",false])}) then
					{
						{deleteVehicle _x;true;} count _Lst;
						_H setVariable ["FS_SPWN",false];
						_H setVariable ["FS_FAR",false];
						{
							private _HO = _x select 0;
							if (_HO isEqualTo _H) exitWith
							{
								FS_SPWNEDLIST deleteAt _forEachIndex;
							};
						} foreach FS_SPWNEDLIST;
					};
					sleep 5;
					!(_H getVariable ["FS_SPWN",true])
				};
			};		
		};
		case "Land_i_House_Big_02_V3_F" :
		{
			private _H1 = [["Banner_01_CSAT_F",[0.819336,-0.341797,19.0563],1.265,270.503,90,[0,0,1]],["Land_Axe_F",[1.39551,-1.92383,18.0328],0.241518,325.389,90,[0,0,1]],["Land_WoodPile_F",[2.19336,-1.58008,18.0505],0.259256,270.238,90,[0,0,1]],["Land_ChairWood_F",[3.24414,0.25,18.0249],0.233625,330.346,90,[0,0,1]],["Land_WeldingTrolley_01_F",[-3.70801,0.602539,18.031],0.239737,133.372,90,[0,0,1]],["Land_PortableSpeakers_01_F",[3.89844,0.533203,18.8201],1.02878,129.738,90,[0,0,1]],["Land_RattanTable_01_F",[4.12109,0.289063,18.0293],0.238031,0,90,[0,0,1]],["Land_GasTank_02_F",[-3.78809,1.59277,17.9944],0.203077,0,90,[0,0,1]],["Land_Rug_01_F",[1.41406,2.77539,21.4],3.60873,0,90,[0,0,1]],["Land_WoodenBox_F",[4.04883,2.80176,18.0312],0.239939,0,90,[0,0,1]],["Land_Map_unfolded_Altis_F",[-3.38184,-1.11328,21.4167],3.62545,212.55,90,[0,0,1]],["Land_Bench_F",[2.20117,2.75781,21.4362],3.64487,269.875,90,[0,0,1]],["Land_CanisterFuel_F",[-3.94824,-3.78223,18.2149],0.423635,0,90,[0,0,1]],["Land_Pillow_F",[2.66797,2.62109,21.8573],4.06603,288.986,90,[0,0,1]],["Land_ChairWood_F",[-3.55762,2.60254,21.3667],3.57536,199.479,90,[0,0,1]],["Land_Ground_sheet_folded_khaki_F",[-4.0332,-1.58301,21.3936],3.60235,232.738,90,[0,0,1]],["Land_CanisterFuel_White_F",[-4.26563,-3.78809,18.2191],0.427824,0,90,[0,0,1]],["Land_Sleeping_bag_blue_folded_F",[-4.0459,1.72559,21.3894],3.59809,125.83,90,[0,0,1]],["Land_WoodenLog_F",[4.34863,-3.28125,19.8023],2.01098,0,90,[0,0,1]],["Land_MapBoard_F",[-3.44824,-1.40723,21.417],3.62567,32.1981,90,[0,0,1]],["Land_PCSet_01_case_F",[-3.97266,2.2041,21.4002],3.60895,358.144,90,[0,0,1]],["Land_WoodenBed_01_F",[3.57129,2.78418,21.4027],3.61144,179.96,90,[0,0,1]],["Land_WoodenLog_F",[4.29004,-3.80078,19.8005],2.00921,0,90,[0,0,1]],["Land_Compass_F",[-3.82422,2.15332,22.2327],4.44145,131.455,90,[0,0,1]],["OfficeTable_01_old_F",[-4.07227,2.64746,21.3991],3.60784,358.96,90,[0,0,1]],["Land_WoodenLog_F",[4.29004,-3.81348,20.3239],2.53264,210.571,90,[0,0,1]],["Land_PCSet_01_keyboard_F",[-3.85938,2.59375,22.2204],4.42908,356.963,90,[0,0,1]],["Land_WoodenLog_F",[4.31055,-3.81934,20.8529],3.06159,73.1853,90,[0,0,1]],["Land_PCSet_01_mouse_F",[-3.91406,3.10938,22.2262],4.43486,17.8347,90,[0,0,1]],["Land_PCSet_01_mousepad_F",[-3.96973,3.12598,22.2216],4.43026,196.369,90,[0,0,1]],["Land_PCSet_01_screen_F",[-4.18164,2.50488,22.2174],4.42612,36.3558,90,[0,0,1]]];
			private _Lst = [_H,_H1] call FS_ACTSPWN;
			FS_SPWNEDLIST pushBack [_H,_Lst];
			[_Lst,(getPosASL _H),_H] spawn
			{
				params ["_Lst","_Pos","_H"];
				_H setVariable ["FS_SPWNOBJ",_Lst];
				waitUntil
				{
					if (player distance2D _Pos > FS_DIST && {!(_H getVariable ["FS_FAR",false])}) then
					{
						{deleteVehicle _x;true;} count _Lst;
						_H setVariable ["FS_SPWN",false];
						_H setVariable ["FS_FAR",false];
						{
							private _HO = _x select 0;
							if (_HO isEqualTo _H) exitWith
							{
								FS_SPWNEDLIST deleteAt _forEachIndex;
							};
						} foreach FS_SPWNEDLIST;
					};
					sleep 5;
					!(_H getVariable ["FS_SPWN",true])
				};
			};
		};
		case "Land_i_House_Big_02_V2_F" :
		{
			private _H1 = [["Banner_01_CSAT_F",[0.819336,-0.341797,19.0563],1.265,270.503,90,[0,0,1]],["Land_Axe_F",[1.39551,-1.92383,18.0328],0.241518,325.389,90,[0,0,1]],["Land_WoodPile_F",[2.19336,-1.58008,18.0505],0.259256,270.238,90,[0,0,1]],["Land_ChairWood_F",[3.24414,0.25,18.0249],0.233625,330.346,90,[0,0,1]],["Land_WeldingTrolley_01_F",[-3.70801,0.602539,18.031],0.239737,133.372,90,[0,0,1]],["Land_PortableSpeakers_01_F",[3.89844,0.533203,18.8201],1.02878,129.738,90,[0,0,1]],["Land_RattanTable_01_F",[4.12109,0.289063,18.0293],0.238031,0,90,[0,0,1]],["Land_GasTank_02_F",[-3.78809,1.59277,17.9944],0.203077,0,90,[0,0,1]],["Land_Rug_01_F",[1.41406,2.77539,21.4],3.60873,0,90,[0,0,1]],["Land_WoodenBox_F",[4.04883,2.80176,18.0312],0.239939,0,90,[0,0,1]],["Land_Map_unfolded_Altis_F",[-3.38184,-1.11328,21.4167],3.62545,212.55,90,[0,0,1]],["Land_Bench_F",[2.20117,2.75781,21.4362],3.64487,269.875,90,[0,0,1]],["Land_CanisterFuel_F",[-3.94824,-3.78223,18.2149],0.423635,0,90,[0,0,1]],["Land_Pillow_F",[2.66797,2.62109,21.8573],4.06603,288.986,90,[0,0,1]],["Land_ChairWood_F",[-3.55762,2.60254,21.3667],3.57536,199.479,90,[0,0,1]],["Land_Ground_sheet_folded_khaki_F",[-4.0332,-1.58301,21.3936],3.60235,232.738,90,[0,0,1]],["Land_CanisterFuel_White_F",[-4.26563,-3.78809,18.2191],0.427824,0,90,[0,0,1]],["Land_Sleeping_bag_blue_folded_F",[-4.0459,1.72559,21.3894],3.59809,125.83,90,[0,0,1]],["Land_WoodenLog_F",[4.34863,-3.28125,19.8023],2.01098,0,90,[0,0,1]],["Land_MapBoard_F",[-3.44824,-1.40723,21.417],3.62567,32.1981,90,[0,0,1]],["Land_PCSet_01_case_F",[-3.97266,2.2041,21.4002],3.60895,358.144,90,[0,0,1]],["Land_WoodenBed_01_F",[3.57129,2.78418,21.4027],3.61144,179.96,90,[0,0,1]],["Land_WoodenLog_F",[4.29004,-3.80078,19.8005],2.00921,0,90,[0,0,1]],["Land_Compass_F",[-3.82422,2.15332,22.2327],4.44145,131.455,90,[0,0,1]],["OfficeTable_01_old_F",[-4.07227,2.64746,21.3991],3.60784,358.96,90,[0,0,1]],["Land_WoodenLog_F",[4.29004,-3.81348,20.3239],2.53264,210.571,90,[0,0,1]],["Land_PCSet_01_keyboard_F",[-3.85938,2.59375,22.2204],4.42908,356.963,90,[0,0,1]],["Land_WoodenLog_F",[4.31055,-3.81934,20.8529],3.06159,73.1853,90,[0,0,1]],["Land_PCSet_01_mouse_F",[-3.91406,3.10938,22.2262],4.43486,17.8347,90,[0,0,1]],["Land_PCSet_01_mousepad_F",[-3.96973,3.12598,22.2216],4.43026,196.369,90,[0,0,1]],["Land_PCSet_01_screen_F",[-4.18164,2.50488,22.2174],4.42612,36.3558,90,[0,0,1]]];
			private _Lst = [_H,_H1] call FS_ACTSPWN;
			FS_SPWNEDLIST pushBack [_H,_Lst];
			[_Lst,(getPosASL _H),_H] spawn
			{
				params ["_Lst","_Pos","_H"];
				_H setVariable ["FS_SPWNOBJ",_Lst];
				waitUntil
				{
					if (player distance2D _Pos > FS_DIST && {!(_H getVariable ["FS_FAR",false])}) then
					{
						{deleteVehicle _x;true;} count _Lst;
						_H setVariable ["FS_SPWN",false];
						_H setVariable ["FS_FAR",false];
						{
							private _HO = _x select 0;
							if (_HO isEqualTo _H) exitWith
							{
								FS_SPWNEDLIST deleteAt _forEachIndex;
							};
						} foreach FS_SPWNEDLIST;
					};
					sleep 5;
					!(_H getVariable ["FS_SPWN",true])
				};
			};
		};		
		case "Land_i_Stone_Shed_V2_F" :
		{
			private _H1 = [["Land_Garbage_square5_F",[0.157227,1.69531,18.0186],0.238289,0,0,[0,0,1]],["Land_Garbage_square3_F",[-2.34961,1.75488,18.0246],0.240799,0,0,[0,0,1]],["Land_Canteen_F",[-3.62598,-0.576172,18.0355],0.253363,235.893,0,[0.00696541,-0.00179364,0.999974]],["Land_BottlePlastic_V2_F",[-3.55957,0.892578,18.1234],0.339233,0,0,[0.00696541,-0.00179364,0.999974]],["Land_Plank_01_4m_F",[-3.4834,1.38184,18.0356],0.250856,0,0,[0,0,1]],["Land_SurvivalRadio_F",[-3.72949,-0.171875,18.1178],0.335295,83.892,0,[0.00696541,-0.00179364,0.999974]],["Land_Battery_F",[3.28223,2.16992,19.1196],1.33908,0,0,[0,0,1]],["Land_Camera_01_F",[3.37891,2.12891,19.1713],1.3909,0,0,[0,0,1]],["Land_BarrelTrash_F",[1.86621,3.99805,17.9639],0.178528,0,0,[0,0,1]],["Land_BarrelTrash_grey_F",[2.8457,3.36914,18.0038],0.220097,0,0,[0,0,1]],["Land_Ground_sheet_OPFOR_F",[-2.72266,3.69238,18.0274],0.240591,271.122,0,[0,0,1]],["Land_Map_F",[-3.48828,3.16211,18.0393],0.252111,73.258,0,[0,0,1]],["Land_FMradio_F",[-1.19141,4.37891,19.1411],1.3547,181.242,0,[0,0,1]],["Land_BarrelTrash_grey_F",[2.62891,3.95508,17.9903],0.204985,248.572,0,[0,0,1]],["Banner_01_AAF_F",[-3.86816,2.21191,19.1805],1.39496,89.8629,0,[0,0,1]],["Land_BakedBeans_F",[-2.71094,4.03613,18.0205],0.233246,114.775,0,[0,0,1]],["Land_BakedBeans_F",[-2.63867,4.16211,18.0248],0.237461,114.775,0,[0,0,1]],["Land_Tableware_01_knife_F",[-3.60645,3.38867,18.0472],0.259794,330.63,0,[0,0,1]],["Land_Orange_01_F",[-3.60742,3.46484,18.0155],0.227974,0,0,[0,0,1]],["Land_BakedBeans_F",[-2.74609,4.19238,18.0286],0.241085,268.247,0,[0,0,1]],["Land_Tableware_01_tray_F",[-3.66113,3.48535,18.0433],0.255835,241.668,0,[0,0,1]],["Land_HandyCam_F",[-1.70313,4.5957,19.18],1.39298,188.792,0,[0,0,1]],["Land_Ground_sheet_folded_OPFOR_F",[-3.18652,4.16797,18.0209],0.232788,172.919,0,[0,0,1]],["Land_Tableware_01_napkin_F",[-3.65723,3.94824,18.042],0.25387,46.1691,0,[0,0,1]],["Land_Ground_sheet_folded_OPFOR_F",[-3.71484,4.16992,18.0213],0.233006,116.059,0,[0,0,1]],["Land_runway_edgelight",[1.36035,13.8584,17.8243],0.0229931,227.734,0,[0.00189111,0,1]]];
			private _Lst = [_H,_H1] call FS_ACTSPWN;
			FS_SPWNEDLIST pushBack [_H,_Lst];
			[_Lst,(getPosASL _H),_H] spawn
			{
				params ["_Lst","_Pos","_H"];
				_H setVariable ["FS_SPWNOBJ",_Lst];
				waitUntil
				{
					if (player distance2D _Pos > FS_DIST && {!(_H getVariable ["FS_FAR",false])}) then
					{
						{deleteVehicle _x;true;} count _Lst;
						_H setVariable ["FS_SPWN",false];
						_H setVariable ["FS_FAR",false];
						{
							private _HO = _x select 0;
							if (_HO isEqualTo _H) exitWith
							{
								FS_SPWNEDLIST deleteAt _forEachIndex;
							};
						} foreach FS_SPWNEDLIST;
					};
					sleep 5;
					!(_H getVariable ["FS_SPWN",true])
				};
			};
		};
		case "Land_i_Shop_02_V1_F" :
		{
			private _H1 = [["Land_Wrench_F",[0.460938,0.395508,18.9577],1.12637,240.642,90,[0,0,1]],["Land_ShelvesWooden_khaki_F",[0.664063,0.5,18.328],0.496708,0,90,[0.00154382,-0.00265199,0.999995]],["Land_Saw_F",[0.689453,0.587891,18.9534],1.12208,0,90,[0,0,1]],["Land_Meter3m_F",[0.900391,0.354492,18.9546],1.12332,0,90,[0,0,1]],["Leaflet_05_Stack_F",[0.615234,0.960938,18.8331],1.00177,90,90,[0,0,1]],["Land_CashDesk_F",[0.667969,1.58594,18.3241],0.492796,0,90,[0.00154382,-0.00265199,0.999995]],["Leaflet_05_F",[0.642578,1.50391,18.8408],1.00953,0,90,[0,0,1]],["Land_Metal_rack_Tall_F",[0.0214844,-4.36816,18.3113],0.48,270,90,[0,0,1]],["Land_Football_01_F",[0.00390625,-4.37109,18.3897],0.558434,0,90,[0,0,1]],["Land_Rugbyball_01_F",[0.234375,-4.40137,18.3771],0.545856,119.56,90,[0,0,1]],["Land_Metal_rack_Tall_F",[-0.771484,-4.36816,18.3113],0.48,270,90,[0,0,1]],["Land_Basketball_01_F",[-0.666016,-4.36621,18.3906],0.559278,0,90,[0,0,1]],["Land_WheelieBin_01_F",[-2.08398,3.83789,18.2737],0.442383,359.009,90,[0,0,1]],["Land_Metal_rack_Tall_F",[0.820313,-4.37305,18.3113],0.48,270,90,[0,0,1]],["Land_ButaneTorch_F",[0.625,-4.37695,18.4107],0.579439,97.4716,90,[0,0,1]],["Land_CanOpener_F",[0.814453,-4.375,18.4155],0.58424,70.2011,90,[0,0,1]],["BloodSpray_01_Old_F",[-0.738281,-0.391602,22.248],4.41668,0,90,[0,0,1]],["Land_Basketball_01_F",[-0.888672,-4.37891,18.3817],0.550438,184.764,90,[0,0,1]],["Land_AirHorn_01_F",[-1.31055,-4.26953,18.4096],0.578281,356.955,90,[0,0,1]],["Land_Volleyball_01_F",[-0.222656,-4.41211,18.7642],0.932894,0,90,[0,0,1]],["Land_CanisterOil_F",[0.0742188,-4.4043,18.7788],0.947533,96.2419,90,[0,0,1]],["Land_ButaneCanister_F",[1.07031,-4.35449,18.414],0.582722,0,90,[0,0,1]],["Land_Baseball_01_F",[-0.787109,-4.34863,18.827],0.995697,0,90,[0,0,1]],["Land_BaseballMitt_01_F",[-0.615234,-4.3877,18.7737],0.942408,0,90,[0,0,1]],["Land_File_F",[0.0820313,-4.33301,19.1716],1.34034,194.545,90,[0,0,1]],["Land_BaseballMitt_01_F",[-0.759766,-4.36328,18.7842],0.952879,231.671,90,[0,0,1]],["Land_Matches_F",[1.35742,-4.30078,18.4105],0.579237,145.125,90,[0,0,1]],["Land_Crowbar_01_F",[0.806641,-4.37793,18.7761],0.944801,0,90,[0,0,1]],["Land_Rope_01_F",[-0.607422,-4.31152,19.1765],1.34525,101.162,90,[0,0,1]],["Land_AirHorn_01_F",[-1.54492,-4.27637,18.4044],0.573088,104.621,90,[0,0,1]],["Land_File_F",[-0.0234375,-4.39648,19.1735],1.34216,0,90,[0,0,1]],["Land_Matches_F",[1.55859,-4.31055,18.4105],0.579237,108.435,90,[0,0,1]],["Land_DuctTape_F",[0.582031,-4.38672,19.1697],1.33842,67.6199,90,[0,0,1]],["Land_AirHorn_01_F",[-1.44141,-4.35352,18.4086],0.577299,278.915,90,[0,0,1]],["Land_AirHorn_01_F",[-1.75781,-4.24219,18.4096],0.578281,278.915,90,[0,0,1]],["Land_DustMask_F",[1.4043,-4.31738,18.7947],0.963449,84.1933,90,[0,0,1]],["Land_Matches_F",[1.44336,-4.37305,18.4105],0.579237,40.6013,90,[0,0,1]],["Land_Metal_rack_Tall_F",[-1.57227,-4.34277,18.3113],0.48,270,90,[0,0,1]],["Land_KartSteertingWheel_01_F",[-1.39258,-4.32227,18.7833],0.951971,106.621,90,[0,0,1]],["Land_DuctTape_F",[0.740234,-4.38184,19.1643],1.33303,153.696,90,[0,0,1]],["Land_Matches_F",[1.30469,-4.42871,18.4105],0.579237,83.4802,90,[0,0,1]],["Land_Metal_rack_Tall_F",[1.61328,-4.37305,18.3113],0.479982,270,90,[0,0,1]],["Land_Pliers_F",[-0.935547,-4.39648,19.171],1.33966,236.396,90,[0,0,1]],["Land_Matches_F",[1.62891,-4.36426,18.4136],0.582335,145.125,90,[0,0,1]],["Land_DustMask_F",[1.31055,-4.4082,18.7947],0.963449,0,90,[0,0,1]],["Land_Trophy_01_bronze_F",[0.900391,-4.37305,19.1709],1.33961,244.411,90,[0,0,1]],["Land_DustMask_F",[1.53906,-4.3457,18.7947],0.963449,57.8043,90,[0,0,1]],["Land_Gloves_F",[0.232422,-4.37793,19.5571],1.72584,265.113,90,[0,0,1]],["Land_Gloves_F",[0.0566406,-4.3916,19.5558],1.7245,262.091,90,[0,0,1]],["Land_DuctTape_F",[1.06836,-4.38867,19.1719],1.34057,118.421,90,[0,0,1]],["Land_Gloves_F",[-0.111328,-4.39453,19.5557],1.72437,79.1436,90,[0,0,1]],["Land_Matches_F",[1.39648,-4.47363,18.4105],0.579237,238.109,90,[0,0,1]],["Land_Gloves_F",[-0.236328,-4.39453,19.5561],1.72476,79.1436,90,[0,0,1]],["Land_AirHorn_01_F",[-1.6582,-4.38867,18.4047],0.57342,312.089,90,[0,0,1]],["Land_DustMask_F",[1.67773,-4.33691,18.7947],0.963449,84.2894,90,[0,0,1]],["Land_KartTyre_01_F",[-1.72266,-4.31152,18.7647],0.933418,0,90,[0,0,1]],["Land_Trophy_01_gold_F",[-0.71875,-4.45996,19.173],1.34169,276.624,90,[0,0,1]],["Land_Grinder_F",[-0.783203,-4.33789,19.5469],1.7156,0,90,[0,0,1]],["Land_Matches_F",[1.54102,-4.47754,18.4105],0.579237,175.03,90,[0,0,1]],["Land_GasCanister_F",[0.623047,-4.38477,19.5529],1.72164,0,90,[0,0,1]],["Land_DrillAku_F",[1.75,-4.38574,18.4102],0.578867,0,90,[0.00154382,-0.00265199,0.999995]],["Land_CanisterFuel_F",[2.36523,-4.09082,18.3243],0.493023,277.125,90,[0,0,1]],["Land_DustMask_F",[1.50195,-4.44629,18.7947],0.963449,176.269,90,[0,0,1]],["Land_AirHorn_01_F",[-1.86914,-4.3623,18.4096],0.578281,278.915,90,[0,0,1]],["Land_GasCanister_F",[0.919922,-4.3584,19.5529],1.72164,0,90,[0,0,1]],["Land_DustMask_F",[1.61914,-4.4248,18.7947],0.963449,0,90,[0,0,1]],["Land_DuctTape_F",[1.375,-4.40625,19.176],1.34469,0,90,[0,0,1]],["Land_DustMask_F",[1.88477,-4.33984,18.7934],0.962139,350.311,90,[0,0,1]],["Land_Matches_F",[1.36719,-4.61621,18.4105],0.579237,145.125,90,[0,0,1]],["Land_DuctTape_F",[1.45898,-4.41406,19.2243],1.39305,0,90,[0,0,1]],["Land_GasCooker_F",[-1.46875,-4.4043,19.1752],1.34389,0,90,[0,0,1]],["Land_DuctTape_F",[1.55664,-4.40137,19.176],1.34469,0,90,[0,0,1]],["Land_GasCanister_F",[1.37891,-4.33594,19.5529],1.72164,0,90,[0,0,1]],["Land_DuctTape_F",[1.70313,-4.37012,19.176],1.34469,0,90,[0,0,1]],["Land_DustMask_F",[1.79492,-4.44434,18.7947],0.963449,59.9314,90,[0,0,1]],["Land_DuctTape_F",[1.63281,-4.38867,19.2235],1.39219,0,90,[0,0,1]],["Land_MultiMeter_F",[-1.45508,-4.38965,19.5552],1.72393,0,90,[0,0,1]],["Land_Bucket_painted_F",[2.76758,-4.04688,18.3256],0.494335,0,90,[0,0,1]],["Land_FireExtinguisher_F",[-2.16211,-4.36621,18.3111],0.479773,118.631,90,[0,0,1]],["Land_DuctTape_F",[1.89258,-4.37598,19.176],1.34469,0,90,[0,0,1]],["Land_Trophy_01_silver_F",[-1.82617,-4.40137,19.1674],1.33612,282.596,90,[0,0,1]],["Land_MetalWire_F",[-1.74219,-4.3457,19.555],1.72367,0,90,[0,0,1]],["Land_GasCanister_F",[1.58984,-4.40625,19.5509],1.71959,0,90,[0,0,1]],["Land_GasCanister_F",[1.79297,-4.35059,19.5529],1.72164,0,90,[0,0,1]],["Land_CanisterPlastic_F",[-2.96289,-4.16797,18.3468],0.515522,85.869,90,[0,0,1]],["Land_RattanTable_01_F",[-0.730469,2.07227,22.1977],4.36645,0,90,[0,0,1]],["Box_B_UAV_06_F",[3.10938,-4.19043,18.3275],0.496233,0,90,[0,0,1]],["Box_B_UAV_06_F",[3.10938,-4.21484,18.5268],0.695499,0,90,[0,0,1]],["Land_RattanChair_01_F",[0.0390625,2.08008,22.2042],4.37286,182.691,90,[0,0,1]],["Land_RattanChair_01_F",[-1.53711,2.03613,22.1979],4.36662,353.835,90,[0,0,1]],["Land_Bodybag_01_empty_black_F",[2.76367,3.08008,22.2142],4.38288,273.421,90,[0,0,1]],["BloodPool_01_Medium_New_F",[-2.26367,-3.24707,22.63],4.79875,0,90,[0,0,1]],["Land_WoodenBed_01_F",[-2.29883,-3.42969,22.1977],4.36637,270.142,90,[0,0,1]],["Land_runway_edgelight",[-8.54492,-8.1709,17.8295],-0.000823975,227.734,90,[0.00189111,0,1]]];
			private _Lst = [_H,_H1] call FS_ACTSPWN;
			FS_SPWNEDLIST pushBack [_H,_Lst];
			[_Lst,(getPosASL _H),_H] spawn
			{
				params ["_Lst","_Pos","_H"];
				_H setVariable ["FS_SPWNOBJ",_Lst];
				waitUntil
				{
					if (player distance2D _Pos > FS_DIST && {!(_H getVariable ["FS_FAR",false])}) then
					{
						{deleteVehicle _x;true;} count _Lst;
						_H setVariable ["FS_SPWN",false];
						_H setVariable ["FS_FAR",false];
						{
							private _HO = _x select 0;
							if (_HO isEqualTo _H) exitWith
							{
								FS_SPWNEDLIST deleteAt _forEachIndex;
							};
						} foreach FS_SPWNEDLIST;
					};
					sleep 5;
					!(_H getVariable ["FS_SPWN",true])
				};
			};
		};
		case "Land_i_Shop_02_V2_F" :
		{
			private _H1 = [["Land_Wrench_F",[0.460938,0.395508,18.9577],1.12637,240.642,90,[0,0,1]],["Land_ShelvesWooden_khaki_F",[0.664063,0.5,18.328],0.496708,0,90,[0.00154382,-0.00265199,0.999995]],["Land_Saw_F",[0.689453,0.587891,18.9534],1.12208,0,90,[0,0,1]],["Land_Meter3m_F",[0.900391,0.354492,18.9546],1.12332,0,90,[0,0,1]],["Leaflet_05_Stack_F",[0.615234,0.960938,18.8331],1.00177,90,90,[0,0,1]],["Land_CashDesk_F",[0.667969,1.58594,18.3241],0.492796,0,90,[0.00154382,-0.00265199,0.999995]],["Leaflet_05_F",[0.642578,1.50391,18.8408],1.00953,0,90,[0,0,1]],["Land_Metal_rack_Tall_F",[0.0214844,-4.36816,18.3113],0.48,270,90,[0,0,1]],["Land_Football_01_F",[0.00390625,-4.37109,18.3897],0.558434,0,90,[0,0,1]],["Land_Rugbyball_01_F",[0.234375,-4.40137,18.3771],0.545856,119.56,90,[0,0,1]],["Land_Metal_rack_Tall_F",[-0.771484,-4.36816,18.3113],0.48,270,90,[0,0,1]],["Land_Basketball_01_F",[-0.666016,-4.36621,18.3906],0.559278,0,90,[0,0,1]],["Land_WheelieBin_01_F",[-2.08398,3.83789,18.2737],0.442383,359.009,90,[0,0,1]],["Land_Metal_rack_Tall_F",[0.820313,-4.37305,18.3113],0.48,270,90,[0,0,1]],["Land_ButaneTorch_F",[0.625,-4.37695,18.4107],0.579439,97.4716,90,[0,0,1]],["Land_CanOpener_F",[0.814453,-4.375,18.4155],0.58424,70.2011,90,[0,0,1]],["BloodSpray_01_Old_F",[-0.738281,-0.391602,22.248],4.41668,0,90,[0,0,1]],["Land_Basketball_01_F",[-0.888672,-4.37891,18.3817],0.550438,184.764,90,[0,0,1]],["Land_AirHorn_01_F",[-1.31055,-4.26953,18.4096],0.578281,356.955,90,[0,0,1]],["Land_Volleyball_01_F",[-0.222656,-4.41211,18.7642],0.932894,0,90,[0,0,1]],["Land_CanisterOil_F",[0.0742188,-4.4043,18.7788],0.947533,96.2419,90,[0,0,1]],["Land_ButaneCanister_F",[1.07031,-4.35449,18.414],0.582722,0,90,[0,0,1]],["Land_Baseball_01_F",[-0.787109,-4.34863,18.827],0.995697,0,90,[0,0,1]],["Land_BaseballMitt_01_F",[-0.615234,-4.3877,18.7737],0.942408,0,90,[0,0,1]],["Land_File_F",[0.0820313,-4.33301,19.1716],1.34034,194.545,90,[0,0,1]],["Land_BaseballMitt_01_F",[-0.759766,-4.36328,18.7842],0.952879,231.671,90,[0,0,1]],["Land_Matches_F",[1.35742,-4.30078,18.4105],0.579237,145.125,90,[0,0,1]],["Land_Crowbar_01_F",[0.806641,-4.37793,18.7761],0.944801,0,90,[0,0,1]],["Land_Rope_01_F",[-0.607422,-4.31152,19.1765],1.34525,101.162,90,[0,0,1]],["Land_AirHorn_01_F",[-1.54492,-4.27637,18.4044],0.573088,104.621,90,[0,0,1]],["Land_File_F",[-0.0234375,-4.39648,19.1735],1.34216,0,90,[0,0,1]],["Land_Matches_F",[1.55859,-4.31055,18.4105],0.579237,108.435,90,[0,0,1]],["Land_DuctTape_F",[0.582031,-4.38672,19.1697],1.33842,67.6199,90,[0,0,1]],["Land_AirHorn_01_F",[-1.44141,-4.35352,18.4086],0.577299,278.915,90,[0,0,1]],["Land_AirHorn_01_F",[-1.75781,-4.24219,18.4096],0.578281,278.915,90,[0,0,1]],["Land_DustMask_F",[1.4043,-4.31738,18.7947],0.963449,84.1933,90,[0,0,1]],["Land_Matches_F",[1.44336,-4.37305,18.4105],0.579237,40.6013,90,[0,0,1]],["Land_Metal_rack_Tall_F",[-1.57227,-4.34277,18.3113],0.48,270,90,[0,0,1]],["Land_KartSteertingWheel_01_F",[-1.39258,-4.32227,18.7833],0.951971,106.621,90,[0,0,1]],["Land_DuctTape_F",[0.740234,-4.38184,19.1643],1.33303,153.696,90,[0,0,1]],["Land_Matches_F",[1.30469,-4.42871,18.4105],0.579237,83.4802,90,[0,0,1]],["Land_Metal_rack_Tall_F",[1.61328,-4.37305,18.3113],0.479982,270,90,[0,0,1]],["Land_Pliers_F",[-0.935547,-4.39648,19.171],1.33966,236.396,90,[0,0,1]],["Land_Matches_F",[1.62891,-4.36426,18.4136],0.582335,145.125,90,[0,0,1]],["Land_DustMask_F",[1.31055,-4.4082,18.7947],0.963449,0,90,[0,0,1]],["Land_Trophy_01_bronze_F",[0.900391,-4.37305,19.1709],1.33961,244.411,90,[0,0,1]],["Land_DustMask_F",[1.53906,-4.3457,18.7947],0.963449,57.8043,90,[0,0,1]],["Land_Gloves_F",[0.232422,-4.37793,19.5571],1.72584,265.113,90,[0,0,1]],["Land_Gloves_F",[0.0566406,-4.3916,19.5558],1.7245,262.091,90,[0,0,1]],["Land_DuctTape_F",[1.06836,-4.38867,19.1719],1.34057,118.421,90,[0,0,1]],["Land_Gloves_F",[-0.111328,-4.39453,19.5557],1.72437,79.1436,90,[0,0,1]],["Land_Matches_F",[1.39648,-4.47363,18.4105],0.579237,238.109,90,[0,0,1]],["Land_Gloves_F",[-0.236328,-4.39453,19.5561],1.72476,79.1436,90,[0,0,1]],["Land_AirHorn_01_F",[-1.6582,-4.38867,18.4047],0.57342,312.089,90,[0,0,1]],["Land_DustMask_F",[1.67773,-4.33691,18.7947],0.963449,84.2894,90,[0,0,1]],["Land_KartTyre_01_F",[-1.72266,-4.31152,18.7647],0.933418,0,90,[0,0,1]],["Land_Trophy_01_gold_F",[-0.71875,-4.45996,19.173],1.34169,276.624,90,[0,0,1]],["Land_Grinder_F",[-0.783203,-4.33789,19.5469],1.7156,0,90,[0,0,1]],["Land_Matches_F",[1.54102,-4.47754,18.4105],0.579237,175.03,90,[0,0,1]],["Land_GasCanister_F",[0.623047,-4.38477,19.5529],1.72164,0,90,[0,0,1]],["Land_DrillAku_F",[1.75,-4.38574,18.4102],0.578867,0,90,[0.00154382,-0.00265199,0.999995]],["Land_CanisterFuel_F",[2.36523,-4.09082,18.3243],0.493023,277.125,90,[0,0,1]],["Land_DustMask_F",[1.50195,-4.44629,18.7947],0.963449,176.269,90,[0,0,1]],["Land_AirHorn_01_F",[-1.86914,-4.3623,18.4096],0.578281,278.915,90,[0,0,1]],["Land_GasCanister_F",[0.919922,-4.3584,19.5529],1.72164,0,90,[0,0,1]],["Land_DustMask_F",[1.61914,-4.4248,18.7947],0.963449,0,90,[0,0,1]],["Land_DuctTape_F",[1.375,-4.40625,19.176],1.34469,0,90,[0,0,1]],["Land_DustMask_F",[1.88477,-4.33984,18.7934],0.962139,350.311,90,[0,0,1]],["Land_Matches_F",[1.36719,-4.61621,18.4105],0.579237,145.125,90,[0,0,1]],["Land_DuctTape_F",[1.45898,-4.41406,19.2243],1.39305,0,90,[0,0,1]],["Land_GasCooker_F",[-1.46875,-4.4043,19.1752],1.34389,0,90,[0,0,1]],["Land_DuctTape_F",[1.55664,-4.40137,19.176],1.34469,0,90,[0,0,1]],["Land_GasCanister_F",[1.37891,-4.33594,19.5529],1.72164,0,90,[0,0,1]],["Land_DuctTape_F",[1.70313,-4.37012,19.176],1.34469,0,90,[0,0,1]],["Land_DustMask_F",[1.79492,-4.44434,18.7947],0.963449,59.9314,90,[0,0,1]],["Land_DuctTape_F",[1.63281,-4.38867,19.2235],1.39219,0,90,[0,0,1]],["Land_MultiMeter_F",[-1.45508,-4.38965,19.5552],1.72393,0,90,[0,0,1]],["Land_Bucket_painted_F",[2.76758,-4.04688,18.3256],0.494335,0,90,[0,0,1]],["Land_FireExtinguisher_F",[-2.16211,-4.36621,18.3111],0.479773,118.631,90,[0,0,1]],["Land_DuctTape_F",[1.89258,-4.37598,19.176],1.34469,0,90,[0,0,1]],["Land_Trophy_01_silver_F",[-1.82617,-4.40137,19.1674],1.33612,282.596,90,[0,0,1]],["Land_MetalWire_F",[-1.74219,-4.3457,19.555],1.72367,0,90,[0,0,1]],["Land_GasCanister_F",[1.58984,-4.40625,19.5509],1.71959,0,90,[0,0,1]],["Land_GasCanister_F",[1.79297,-4.35059,19.5529],1.72164,0,90,[0,0,1]],["Land_CanisterPlastic_F",[-2.96289,-4.16797,18.3468],0.515522,85.869,90,[0,0,1]],["Land_RattanTable_01_F",[-0.730469,2.07227,22.1977],4.36645,0,90,[0,0,1]],["Box_B_UAV_06_F",[3.10938,-4.19043,18.3275],0.496233,0,90,[0,0,1]],["Box_B_UAV_06_F",[3.10938,-4.21484,18.5268],0.695499,0,90,[0,0,1]],["Land_RattanChair_01_F",[0.0390625,2.08008,22.2042],4.37286,182.691,90,[0,0,1]],["Land_RattanChair_01_F",[-1.53711,2.03613,22.1979],4.36662,353.835,90,[0,0,1]],["Land_Bodybag_01_empty_black_F",[2.76367,3.08008,22.2142],4.38288,273.421,90,[0,0,1]],["BloodPool_01_Medium_New_F",[-2.26367,-3.24707,22.63],4.79875,0,90,[0,0,1]],["Land_WoodenBed_01_F",[-2.29883,-3.42969,22.1977],4.36637,270.142,90,[0,0,1]],["Land_runway_edgelight",[-8.54492,-8.1709,17.8295],-0.000823975,227.734,90,[0.00189111,0,1]]];
			private _Lst = [_H,_H1] call FS_ACTSPWN;
			FS_SPWNEDLIST pushBack [_H,_Lst];
			[_Lst,(getPosASL _H),_H] spawn
			{
				params ["_Lst","_Pos","_H"];
				_H setVariable ["FS_SPWNOBJ",_Lst];
				waitUntil
				{
					if (player distance2D _Pos > FS_DIST && {!(_H getVariable ["FS_FAR",false])}) then
					{
						{deleteVehicle _x;true;} count _Lst;
						_H setVariable ["FS_SPWN",false];
						_H setVariable ["FS_FAR",false];
						{
							private _HO = _x select 0;
							if (_HO isEqualTo _H) exitWith
							{
								FS_SPWNEDLIST deleteAt _forEachIndex;
							};
						} foreach FS_SPWNEDLIST;
					};
					sleep 5;
					!(_H getVariable ["FS_SPWN",true])
				};
			};
		};
		case "Land_i_Shop_02_V3_F" :
		{
			private _H1 = [["Land_Wrench_F",[0.460938,0.395508,18.9577],1.12637,240.642,90,[0,0,1]],["Land_ShelvesWooden_khaki_F",[0.664063,0.5,18.328],0.496708,0,90,[0.00154382,-0.00265199,0.999995]],["Land_Saw_F",[0.689453,0.587891,18.9534],1.12208,0,90,[0,0,1]],["Land_Meter3m_F",[0.900391,0.354492,18.9546],1.12332,0,90,[0,0,1]],["Leaflet_05_Stack_F",[0.615234,0.960938,18.8331],1.00177,90,90,[0,0,1]],["Land_CashDesk_F",[0.667969,1.58594,18.3241],0.492796,0,90,[0.00154382,-0.00265199,0.999995]],["Leaflet_05_F",[0.642578,1.50391,18.8408],1.00953,0,90,[0,0,1]],["Land_Metal_rack_Tall_F",[0.0214844,-4.36816,18.3113],0.48,270,90,[0,0,1]],["Land_Football_01_F",[0.00390625,-4.37109,18.3897],0.558434,0,90,[0,0,1]],["Land_Rugbyball_01_F",[0.234375,-4.40137,18.3771],0.545856,119.56,90,[0,0,1]],["Land_Metal_rack_Tall_F",[-0.771484,-4.36816,18.3113],0.48,270,90,[0,0,1]],["Land_Basketball_01_F",[-0.666016,-4.36621,18.3906],0.559278,0,90,[0,0,1]],["Land_WheelieBin_01_F",[-2.08398,3.83789,18.2737],0.442383,359.009,90,[0,0,1]],["Land_Metal_rack_Tall_F",[0.820313,-4.37305,18.3113],0.48,270,90,[0,0,1]],["Land_ButaneTorch_F",[0.625,-4.37695,18.4107],0.579439,97.4716,90,[0,0,1]],["Land_CanOpener_F",[0.814453,-4.375,18.4155],0.58424,70.2011,90,[0,0,1]],["BloodSpray_01_Old_F",[-0.738281,-0.391602,22.248],4.41668,0,90,[0,0,1]],["Land_Basketball_01_F",[-0.888672,-4.37891,18.3817],0.550438,184.764,90,[0,0,1]],["Land_AirHorn_01_F",[-1.31055,-4.26953,18.4096],0.578281,356.955,90,[0,0,1]],["Land_Volleyball_01_F",[-0.222656,-4.41211,18.7642],0.932894,0,90,[0,0,1]],["Land_CanisterOil_F",[0.0742188,-4.4043,18.7788],0.947533,96.2419,90,[0,0,1]],["Land_ButaneCanister_F",[1.07031,-4.35449,18.414],0.582722,0,90,[0,0,1]],["Land_Baseball_01_F",[-0.787109,-4.34863,18.827],0.995697,0,90,[0,0,1]],["Land_BaseballMitt_01_F",[-0.615234,-4.3877,18.7737],0.942408,0,90,[0,0,1]],["Land_File_F",[0.0820313,-4.33301,19.1716],1.34034,194.545,90,[0,0,1]],["Land_BaseballMitt_01_F",[-0.759766,-4.36328,18.7842],0.952879,231.671,90,[0,0,1]],["Land_Matches_F",[1.35742,-4.30078,18.4105],0.579237,145.125,90,[0,0,1]],["Land_Crowbar_01_F",[0.806641,-4.37793,18.7761],0.944801,0,90,[0,0,1]],["Land_Rope_01_F",[-0.607422,-4.31152,19.1765],1.34525,101.162,90,[0,0,1]],["Land_AirHorn_01_F",[-1.54492,-4.27637,18.4044],0.573088,104.621,90,[0,0,1]],["Land_File_F",[-0.0234375,-4.39648,19.1735],1.34216,0,90,[0,0,1]],["Land_Matches_F",[1.55859,-4.31055,18.4105],0.579237,108.435,90,[0,0,1]],["Land_DuctTape_F",[0.582031,-4.38672,19.1697],1.33842,67.6199,90,[0,0,1]],["Land_AirHorn_01_F",[-1.44141,-4.35352,18.4086],0.577299,278.915,90,[0,0,1]],["Land_AirHorn_01_F",[-1.75781,-4.24219,18.4096],0.578281,278.915,90,[0,0,1]],["Land_DustMask_F",[1.4043,-4.31738,18.7947],0.963449,84.1933,90,[0,0,1]],["Land_Matches_F",[1.44336,-4.37305,18.4105],0.579237,40.6013,90,[0,0,1]],["Land_Metal_rack_Tall_F",[-1.57227,-4.34277,18.3113],0.48,270,90,[0,0,1]],["Land_KartSteertingWheel_01_F",[-1.39258,-4.32227,18.7833],0.951971,106.621,90,[0,0,1]],["Land_DuctTape_F",[0.740234,-4.38184,19.1643],1.33303,153.696,90,[0,0,1]],["Land_Matches_F",[1.30469,-4.42871,18.4105],0.579237,83.4802,90,[0,0,1]],["Land_Metal_rack_Tall_F",[1.61328,-4.37305,18.3113],0.479982,270,90,[0,0,1]],["Land_Pliers_F",[-0.935547,-4.39648,19.171],1.33966,236.396,90,[0,0,1]],["Land_Matches_F",[1.62891,-4.36426,18.4136],0.582335,145.125,90,[0,0,1]],["Land_DustMask_F",[1.31055,-4.4082,18.7947],0.963449,0,90,[0,0,1]],["Land_Trophy_01_bronze_F",[0.900391,-4.37305,19.1709],1.33961,244.411,90,[0,0,1]],["Land_DustMask_F",[1.53906,-4.3457,18.7947],0.963449,57.8043,90,[0,0,1]],["Land_Gloves_F",[0.232422,-4.37793,19.5571],1.72584,265.113,90,[0,0,1]],["Land_Gloves_F",[0.0566406,-4.3916,19.5558],1.7245,262.091,90,[0,0,1]],["Land_DuctTape_F",[1.06836,-4.38867,19.1719],1.34057,118.421,90,[0,0,1]],["Land_Gloves_F",[-0.111328,-4.39453,19.5557],1.72437,79.1436,90,[0,0,1]],["Land_Matches_F",[1.39648,-4.47363,18.4105],0.579237,238.109,90,[0,0,1]],["Land_Gloves_F",[-0.236328,-4.39453,19.5561],1.72476,79.1436,90,[0,0,1]],["Land_AirHorn_01_F",[-1.6582,-4.38867,18.4047],0.57342,312.089,90,[0,0,1]],["Land_DustMask_F",[1.67773,-4.33691,18.7947],0.963449,84.2894,90,[0,0,1]],["Land_KartTyre_01_F",[-1.72266,-4.31152,18.7647],0.933418,0,90,[0,0,1]],["Land_Trophy_01_gold_F",[-0.71875,-4.45996,19.173],1.34169,276.624,90,[0,0,1]],["Land_Grinder_F",[-0.783203,-4.33789,19.5469],1.7156,0,90,[0,0,1]],["Land_Matches_F",[1.54102,-4.47754,18.4105],0.579237,175.03,90,[0,0,1]],["Land_GasCanister_F",[0.623047,-4.38477,19.5529],1.72164,0,90,[0,0,1]],["Land_DrillAku_F",[1.75,-4.38574,18.4102],0.578867,0,90,[0.00154382,-0.00265199,0.999995]],["Land_CanisterFuel_F",[2.36523,-4.09082,18.3243],0.493023,277.125,90,[0,0,1]],["Land_DustMask_F",[1.50195,-4.44629,18.7947],0.963449,176.269,90,[0,0,1]],["Land_AirHorn_01_F",[-1.86914,-4.3623,18.4096],0.578281,278.915,90,[0,0,1]],["Land_GasCanister_F",[0.919922,-4.3584,19.5529],1.72164,0,90,[0,0,1]],["Land_DustMask_F",[1.61914,-4.4248,18.7947],0.963449,0,90,[0,0,1]],["Land_DuctTape_F",[1.375,-4.40625,19.176],1.34469,0,90,[0,0,1]],["Land_DustMask_F",[1.88477,-4.33984,18.7934],0.962139,350.311,90,[0,0,1]],["Land_Matches_F",[1.36719,-4.61621,18.4105],0.579237,145.125,90,[0,0,1]],["Land_DuctTape_F",[1.45898,-4.41406,19.2243],1.39305,0,90,[0,0,1]],["Land_GasCooker_F",[-1.46875,-4.4043,19.1752],1.34389,0,90,[0,0,1]],["Land_DuctTape_F",[1.55664,-4.40137,19.176],1.34469,0,90,[0,0,1]],["Land_GasCanister_F",[1.37891,-4.33594,19.5529],1.72164,0,90,[0,0,1]],["Land_DuctTape_F",[1.70313,-4.37012,19.176],1.34469,0,90,[0,0,1]],["Land_DustMask_F",[1.79492,-4.44434,18.7947],0.963449,59.9314,90,[0,0,1]],["Land_DuctTape_F",[1.63281,-4.38867,19.2235],1.39219,0,90,[0,0,1]],["Land_MultiMeter_F",[-1.45508,-4.38965,19.5552],1.72393,0,90,[0,0,1]],["Land_Bucket_painted_F",[2.76758,-4.04688,18.3256],0.494335,0,90,[0,0,1]],["Land_FireExtinguisher_F",[-2.16211,-4.36621,18.3111],0.479773,118.631,90,[0,0,1]],["Land_DuctTape_F",[1.89258,-4.37598,19.176],1.34469,0,90,[0,0,1]],["Land_Trophy_01_silver_F",[-1.82617,-4.40137,19.1674],1.33612,282.596,90,[0,0,1]],["Land_MetalWire_F",[-1.74219,-4.3457,19.555],1.72367,0,90,[0,0,1]],["Land_GasCanister_F",[1.58984,-4.40625,19.5509],1.71959,0,90,[0,0,1]],["Land_GasCanister_F",[1.79297,-4.35059,19.5529],1.72164,0,90,[0,0,1]],["Land_CanisterPlastic_F",[-2.96289,-4.16797,18.3468],0.515522,85.869,90,[0,0,1]],["Land_RattanTable_01_F",[-0.730469,2.07227,22.1977],4.36645,0,90,[0,0,1]],["Box_B_UAV_06_F",[3.10938,-4.19043,18.3275],0.496233,0,90,[0,0,1]],["Box_B_UAV_06_F",[3.10938,-4.21484,18.5268],0.695499,0,90,[0,0,1]],["Land_RattanChair_01_F",[0.0390625,2.08008,22.2042],4.37286,182.691,90,[0,0,1]],["Land_RattanChair_01_F",[-1.53711,2.03613,22.1979],4.36662,353.835,90,[0,0,1]],["Land_Bodybag_01_empty_black_F",[2.76367,3.08008,22.2142],4.38288,273.421,90,[0,0,1]],["BloodPool_01_Medium_New_F",[-2.26367,-3.24707,22.63],4.79875,0,90,[0,0,1]],["Land_WoodenBed_01_F",[-2.29883,-3.42969,22.1977],4.36637,270.142,90,[0,0,1]],["Land_runway_edgelight",[-8.54492,-8.1709,17.8295],-0.000823975,227.734,90,[0.00189111,0,1]]];
			private _Lst = [_H,_H1] call FS_ACTSPWN;
			FS_SPWNEDLIST pushBack [_H,_Lst];
			[_Lst,(getPosASL _H),_H] spawn
			{
				params ["_Lst","_Pos","_H"];
				_H setVariable ["FS_SPWNOBJ",_Lst];
				waitUntil
				{
					if (player distance2D _Pos > FS_DIST && {!(_H getVariable ["FS_FAR",false])}) then
					{
						{deleteVehicle _x;true;} count _Lst;
						_H setVariable ["FS_SPWN",false];
						_H setVariable ["FS_FAR",false];
						{
							private _HO = _x select 0;
							if (_HO isEqualTo _H) exitWith
							{
								FS_SPWNEDLIST deleteAt _forEachIndex;
							};
						} foreach FS_SPWNEDLIST;
					};
					sleep 5;
					!(_H getVariable ["FS_SPWN",true])
				};
			};
		};			
		case default
		{
		
		};
	};
};

//We need to create a loop for the players that constantly check for nearby buildings.
waitUntil
{
	private _Hs = (nearestObjects [getpos player, ["House"], FS_DIST]);
	{
		
		if (!(_x getVariable ["FS_SPWN",false]) && {count FS_SPWNEDLIST < FS_MB} && {getDammage _x < 1} && {!(isObjectHidden _x)}) then
		{
			_x setVariable ["FS_SPWN",true];
			private _T = typeof _x;
			[_x,_T] call FS_FRNSPWN;
			if (_x getVariable ["FS_DEVNT",true]) then
			{
				_x setVariable ["FS_DEVNT",false];
				_x addEventHandler ["killed", {_this call FS_DeadHouse;}]
			};			
		};
	} foreach _Hs;
	
	if (FS_CA) then
	{
		private _NB = (_Hs select 0);
		if !(isNil "_NB") then
		{
			if (!(isObjectHidden _NB) && {getDammage _NB < 1}) then
			{
				if (!(_NB getVariable ["FS_SPWN",false]) && {getDammage _NB < 1}) then
				{
					_NB setVariable ["FS_SPWN",true];
					private _T = typeof _NB;
					[_NB,_T] call FS_FRNSPWN;
					if (_NB getVariable ["FS_DEVNT",true]) then
					{
						_NB setVariable ["FS_DEVNT",false];
						_NB addEventHandler ["killed", {_this call FS_DeadHouse;}]
					};
				};
			};
		};
	};
	
	if (FS_CursorObjs) then
	{
		private _Tar = cursorObject;
		if (_Tar isKindOf "Building" && {_Tar distance2D player > FS_DIST}) then
		{
			if (!(_Tar getVariable ["FS_SPWN",false]) && {getDammage _Tar < 1} && {!(isObjectHidden _Tar)}) then
			{
				_Tar setVariable ["FS_SPWN",true];
				_Tar setVariable ["FS_FAR",true];
				_Tar spawn {sleep 300;_this setVariable ["FS_FAR",false];};
				private _T = typeof _Tar;
				[_Tar,_T] call FS_FRNSPWN;
				if (_Tar getVariable ["FS_DEVNT",true]) then
				{
					_Tar setVariable ["FS_DEVNT",false];
					_Tar addEventHandler ["killed", {_this call FS_DeadHouse;}]
				};
			};				
		};
	};	
	
	//Lets check to see if too many stuctures are getting spawned. And if so, lets delete the older ones.
	if (count FS_SPWNEDLIST > FS_MB) then
	{
		waitUntil
		{
			{
				private _HO = _x select 0;
				if (_HO distance2D player > 25) then
				{
					private _Lst = _x select 1;					
					_HO setVariable ["FS_SPWN",false];
					_HO setVariable ["FS_FAR",false];
					{deleteVehicle _x;true;} count _Lst;
					FS_SPWNEDLIST deleteAt _forEachIndex;
				};
			} foreach FS_SPWNEDLIST;
			(count FS_SPWNEDLIST < FS_MB)
		};
	};
	sleep 2;
	!(FS_ENABLED)
};



/*
FS_GrabOjects =  
{ 
 private _OrgH = cursorObject; 
 systemChat str _OrgH; 
 systemChat str (typeOf _OrgH); 
 player setpos (getpos _OrgH); 
 systemChat format ["%1",_OrgH]; 
 private _housepos = (getPosATL _OrgH); 
 private _house = createvehicle["Land_Camping_Light_off_F",_housepos,[],0,"CAN_COLLIDE"]; 
 private _Objs = nearestObjects [(getPos _house), [], 15]; 
 _house setposATL _housepos; 
 _house setdir (getDir _OrgH); 
 _house enablesimulation false;  
 _Objs = _Objs - [player]; 
 _Objs = _Objs - [_OrgH]; 
 _Objs = _Objs - [_house]; 
  
 private _OrgDir = getDir _OrgH; 
 private _houseRP = getPosASL _OrgH; 
 private _FinalArray = []; 
 private _BlackList = ["","#mark"]; 
 { 
  if !((typeof _x) in _BlackList) then 
  { 
   private _ObjRP =  getPosASL _x; 
   _FinalArray pushback [(typeof _x),(_house worldtomodel (getPosASL _x)),((_ObjRP select 2) - (_houseRP select 2)),(getDir _x),_OrgDir,(vectorUp _x)]; 
  }; 
 } foreach _Objs; 
 copyToClipboard str ([(TYPEOf _OrgH),_FinalArray]); 
 deleteVehicle _house; 
   
};   
[] spawn FS_GrabOjects;
*/