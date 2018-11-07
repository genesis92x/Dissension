startLoadingScreen ["Loading My Mission, please wait..."];

VCOM_fnc_classVehicle = {
private ["_return", "_name"];
_name = _this select 0;

if ((typeName _name) isEqualTo "STRING") then
{
  _return = (configFile >> "cfgVehicles" >> _name);
}
else
{
  _return = (configFile >> "NonExistingClassDummy0005646526");
};
_return 
};
  
  
CfgWeaponSubClassesArray = (configfile/"CfgWeapons") call BIS_fnc_getCfgSubClasses;
CfgWeaponsArray = [];
CfgLauncherArray = [];
CfgAttachmentsArray = [];
CfgEquipmentArray = [];
CfgEquipmentArray2 = [];
CfgUniformsArray = [];
CfgVestsArray = [];
CfgHelmetsArray = [];
CfgPistolArray = [];
CfgHeavyArray = [];
ExtraLootArray = [];
CfgBManArray = [];
CfgOManArray = [];

CfgWeaponSubClassesArray = CfgWeaponSubClassesArray - ["hgun_Pistol_Signal_F"];
_compareCount = count CfgWeaponSubClassesArray;
_ccount = 0;
{
	_ccount = _ccount + 1;
	_classname = _x;
	//systemChat format ["%2: %1",_classname,_ccount];

	_scope = getNumber(configfile/"CfgWeapons"/_classname/"scope");
	_LinkedArray = (configfile/"CfgWeapons"/_classname/"LinkedItems") call BIS_fnc_getCfgSubClasses;
	_LinkedArrayCheck = count _LinkedArray;
	if (isNil "_LinkedArrayCheck") then {_LinkedArrayCheck = 0;};
	_isOptic = (configfile/"CfgWeapons"/_classname/"ItemInfo"/"OpticsModes") call BIS_fnc_getCfgIsClass;
	_isFlashlight = (configfile/"CfgWeapons"/_classname/"ItemInfo"/"Flashlight") call BIS_fnc_getCfgIsClass;
	_ModeArray = getArray(configfile/"CfgWeapons"/_classname/"ItemInfo"/"modes");
	_ModeArrayCheck = count _ModeArray;
	_typemain = getNumber(configfile/"CfgWeapons"/_classname/"type");
	_typeiinfo = getNumber(configfile/"CfgWeapons"/_classname/"ItemInfo"/"type");
	_class = [_classname] call BIS_fnc_classWeapon;
	_parents = [_class,true] call BIS_fnc_returnParents;
	_ItemInfoClass = (configfile/"CfgWeapons"/_classname/"ItemInfo");
	_ItemInfoParents = [_ItemInfoClass,true] call BIS_fnc_returnParents;
	_getSimulationType = getText(configfile/"CfgWeapons"/_classname/"simulation");
	if (("Rifle_Base_F" in _parents) && (_scope isEqualTo 2) && ((_LinkedArrayCheck isEqualTo 0) || (_LinkedArrayCheck isEqualTo 1))) then {CfgWeaponsArray pushback _classname;};
	if (("Rifle_Long_Base_F" in _parents) && (_scope isEqualTo 2) && ((_LinkedArrayCheck isEqualTo 0) || (_LinkedArrayCheck isEqualTo 1))) then {CfgHeavyArray pushback _classname;};
	if (("Pistol_Base_F" in _parents) && (_scope isEqualTo 2) && ((_LinkedArrayCheck isEqualTo 0) || (_LinkedArrayCheck isEqualTo 1))) then {CfgPistolArray pushback _classname;};
	if (("Launcher_Base_F" in _parents) && (_scope isEqualTo 2) && ((_LinkedArrayCheck isEqualTo 0) || (_LinkedArrayCheck isEqualTo 1))) then {CfgLauncherArray pushback _classname;};
	if (("ItemCore" in _parents) && (_scope isEqualTo 2) && (_isOptic)) then {CfgAttachmentsArray pushback _classname;};
	if (("ItemCore" in _parents) && (_scope isEqualTo 2) && (_isFlashlight)) then {CfgAttachmentsArray pushback _classname;};
	if (("InventoryMuzzleItem_Base_F" in _ItemInfoParents) && (_scope isEqualTo 2)) then {CfgAttachmentsArray pushback _classname;};
	if (("ItemCore" in _parents) && (_scope isEqualTo 2) && ("InventoryFirstAidKitItem_Base_F" in _ItemInfoParents)) then {CfgEquipmentArray pushback _classname;};
	if (("ItemCore" in _parents) && (_scope isEqualTo 2) && ("MedikitItem" in _ItemInfoParents)) then {CfgEquipmentArray pushback _classname;};
	if (("ItemCore" in _parents) && (_scope isEqualTo 2) && ("ToolKitItem" in _ItemInfoParents)) then {CfgEquipmentArray pushback _classname;};
	if (("ItemCore" in _parents) && (_scope isEqualTo 2) && (_getSimulationType isEqualTo "ItemCompass")) then {CfgEquipmentArray pushback _classname;};
	if (("ItemCore" in _parents) && (_scope isEqualTo 2) && (_getSimulationType isEqualTo "ItemGPS")) then {CfgEquipmentArray pushback _classname;};
	if (("ItemCore" in _parents) && (_scope isEqualTo 2) && (_getSimulationType isEqualTo "ItemMap")) then {CfgEquipmentArray pushback _classname;};
	if (("ItemCore" in _parents) && (_scope isEqualTo 2) && (_getSimulationType isEqualTo "ItemRadio")) then {CfgEquipmentArray pushback _classname;};
	if (("ItemCore" in _parents) && (_scope isEqualTo 2) && (_getSimulationType isEqualTo "ItemWatch")) then {CfgEquipmentArray pushback _classname;};
	if (("DetectorCore" in _parents) && (_scope isEqualTo 2) && (_getSimulationType isEqualTo "ItemMineDetector")) then {CfgEquipmentArray pushback _classname;};
	if (("UavTerminal_base" in _parents) && (_scope isEqualTo 2)) then {CfgEquipmentArray pushback _classname;};
	if (("Binocular" in _parents) && (_scope isEqualTo 2) && (_typeiinfo isEqualTo 616)) then {CfgEquipmentArray pushback _classname;};
	if (("Binocular" in _parents) && (_scope isEqualTo 2) && (_typemain isEqualTo 4096)) then {CfgEquipmentArray2 pushback _classname;};
	if (("Uniform_Base" in _parents) && (_scope isEqualTo 2)) then {CfgUniformsArray pushback _classname;};
	if (("Vest_Camo_Base" in _parents) ) then {CfgVestsArray pushback _classname;};
	if (("Vest_NoCamo_Base" in _parents) ) then {CfgVestsArray pushback _classname;};
	if (("H_HelmetB" in _parents) && (_scope isEqualTo 2)) then {CfgHelmetsArray pushback _classname;};
	//LIB_DAK_PzKpfwIV_H
	
} forEach CfgWeaponSubClassesArray;
CfgWeaponSubClassesArray = nil;

////////////////////////////////////////////////////////////////
//////////////////////////// Master Array Sorter (Vehicles)/////
////////////////////////////////////////////////////////////////

CfgVehiclesSubClassesArray = (configfile/"CfgVehicles") call BIS_fnc_getCfgSubClasses;
CfgCarsArray = [];
CfgLightArmorsArray = [];
CfgHeavyArmorsArray = [];
CfgHelicoptersArray = [];
CfgPlanesArray = [];
CfgBoatsArray = [];
CfgRucksArray = [];
CfgUGVArray = [];
CfgUAVArray = [];
BuyCarArray = [];
BuyLArmorArray = [];
BuyHArmorArray = [];
BuyHeliArray = [];
BuyPlaneArray = [];
BuyBoatArray = [];
BuyRuckArray = [];
BuyUGVBLUFORArray = [];
BuyUGVOPFORArray = [];
BuyUGVINDEPENDENTArray = [];
BuyUAVBLUFORArray = [];
BuyUAVOPFORArray = [];
BuyUAVINDEPENDENTArray = [];

{
_classname = _x;
_class = [_classname] call VCOM_fnc_classVehicle;
_parents = [_class,true] call BIS_fnc_returnParents;
_scope = getNumber(configfile/"CfgVehicles"/_classname/"scope");
_side = getNumber(configfile/"CfgVehicles"/_classname/"side");
_vehicleclass = getText(configfile/"CfgVehicles"/_classname/"vehicleclass");
_picture = getText(configfile/"CfgVehicles"/_classname/"editorPreview");

	_Mod = "Mod" call BIS_fnc_getParamValue;
	if (!(_Mod isEqualTo 2) && {!(_Mod isEqualTo 3)}) then
	{

	//Regular and Support Vehicle Filters
	if (("Car_F" in _parents) && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Car") || !(_vehicleclass isEqualTo ""))) then {CfgCarsArray pushback _classname;};
	if (("Wheeled_APC_F" in _parents) && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Armored") || !(_vehicleclass isEqualTo ""))) then {CfgLightArmorsArray pushback _classname;};
	if (("APC_Tracked_01_base_F" in _parents) && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Armored") || !(_vehicleclass isEqualTo ""))) then {CfgLightArmorsArray pushback _classname;};
	if (("APC_Tracked_02_base_F" in _parents) && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Armored") || !(_vehicleclass isEqualTo ""))) then {CfgLightArmorsArray pushback _classname;};
	if (("APC_Tracked_03_base_F" in _parents) && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Armored") || !(_vehicleclass isEqualTo ""))) then {CfgLightArmorsArray pushback _classname;};
	if (("MBT_04_base_F" in _parents) && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Armored") || !(_vehicleclass isEqualTo ""))) then {CfgLightArmorsArray pushback _classname;};
	if (("MBT_01_base_F" in _parents) && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Armored") || !(_vehicleclass isEqualTo ""))) then {CfgHeavyArmorsArray pushback _classname;};
	if (("MBT_01_mlrs_base_F" in _parents) && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Armored") || !(_vehicleclass isEqualTo ""))) then {CfgHeavyArmorsArray pushback _classname;};
	if (("MBT_02_base_F" in _parents) && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Armored") || !(_vehicleclass isEqualTo ""))) then {CfgHeavyArmorsArray pushback _classname;};
	if (("MBT_02_arty_base_F" in _parents) && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Armored") || !(_vehicleclass isEqualTo ""))) then {CfgHeavyArmorsArray pushback _classname;};
	if (("MBT_03_base_F" in _parents) && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Armored") || !(_vehicleclass isEqualTo ""))) then {CfgHeavyArmorsArray pushback _classname;};
	if (("Tank_F" in _parents) && (_scope isEqualTo 2) && (("rhs_a3t72tank_base" in _parents) || ("rhsusf_m1a1tank_base" in _parents) || !(_vehicleclass isEqualTo ""))) then {CfgHeavyArmorsArray pushback _classname;};
	if (("Helicopter_Base_F" in _parents) && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Air") || !(_vehicleclass isEqualTo ""))) then {CfgHelicoptersArray pushback _classname;};
	if (("Plane" in _parents) && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Air") || !(_vehicleclass isEqualTo ""))) then {CfgPlanesArray pushback _classname;};
	if (("Boat_F" in _parents) && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Ship") || !(_vehicleclass isEqualTo ""))) then {CfgBoatsArray pushback _classname;};
	if (("Man" in _parents) && {(_side isEqualTo 1)} && {!(_picture isEqualTo "")} && {!(_picture isEqualTo "\A3\EditorPreviews_F\Data\CfgVehicles\Default\Man.jpg")}) then {private _Cost = getNumber(configfile/"CfgVehicles"/_classname/"cost"); CfgBManArray pushback [_classname,_Cost];};
	if (("Man" in _parents) && {(_side isEqualTo 0)} && {!(_picture isEqualTo "")} && {!(_picture isEqualTo "\A3\EditorPreviews_F\Data\CfgVehicles\Default\Man.jpg")}) then {private _Cost = getNumber(configfile/"CfgVehicles"/_classname/"cost"); CfgOManArray pushback [_classname,_Cost];};	
	//UGV & UAV Filters
	if (("LandVehicle" in _parents) && (_scope isEqualTo 2) && (_vehicleclass isEqualTo "Autonomous")) then {CfgUGVArray pushback _classname;};
	if (("Air" in _parents) && (_scope isEqualTo 2) && (_vehicleclass isEqualTo "Autonomous")) then {CfgUAVArray pushback _classname;};
	
	if (("Bag_Base" in _parents) && (_scope isEqualTo 2)) then {CfgRucksArray pushback _classname;};
	}
	else
	{
	
//"LIB_US_NAC_M4A3_75"
		_author = getText(configfile/"CfgVehicles"/_classname/"author");
		if (_author isEqualTo "AWAR" || _author isEqualTo "I44" || _author isEqualTo "AWAR & Lennard") then
		{
			if ("Tank" in _parents && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Armored") || !(_vehicleclass isEqualTo ""))) then {CfgHeavyArmorsArray pushback _classname;};
			if ("Tank" in _parents && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Car") || !(_vehicleclass isEqualTo ""))) then {CfgLightArmorsArray pushback _classname;};
			if ("Car" in _parents && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Support") || !(_vehicleclass isEqualTo ""))) then {CfgCarsArray pushback _classname;};
			if ("Car" in _parents && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Car") || !(_vehicleclass isEqualTo ""))) then {CfgCarsArray pushback _classname;};
			if ("Plane" in _parents && (_scope isEqualTo 2) && ((_vehicleclass isEqualTo "Air") || !(_vehicleclass isEqualTo ""))) then {CfgPlanesArray pushback _classname;};
			if (("Bag_Base" in _parents) && (_scope isEqualTo 2)) then {CfgRucksArray pushback _classname;};			
			if (("Man" in _parents) && {(_side isEqualTo 1)} && {!(_picture isEqualTo "")} && {!(_picture isEqualTo "\A3\EditorPreviews_F\Data\CfgVehicles\Default\Man.jpg")}) then {private _Cost = getNumber(configfile/"CfgVehicles"/_classname/"cost"); CfgBManArray pushback [_classname,_Cost];};
			if (("Man" in _parents) && {(_side isEqualTo 0)} && {!(_picture isEqualTo "")} && {!(_picture isEqualTo "\A3\EditorPreviews_F\Data\CfgVehicles\Default\Man.jpg")}) then {private _Cost = getNumber(configfile/"CfgVehicles"/_classname/"cost"); CfgOManArray pushback [_classname,_Cost];};			
			{
				if (_x in CfgHeavyArmorsArray) then {CfgLightArmorsArray = CfgLightArmorsArray - [_x];};
			} foreach CfgLightArmorsArray;
		};
	};

} forEach CfgVehiclesSubClassesArray;
CfgVehiclesSubClassesArray = nil;

//Remove RHS scud 
CfgCarsArray = CfgCarsArray - ["rhs_9k79_B"];
CfgCarsArray = CfgCarsArray - ["rhs_9k79_K"];
CfgCarsArray = CfgCarsArray - ["rhs_9k79"];

////////////////////////////////////////////////////////////////
//////////////////////////// Master Array Sorter (Magazines)/////
////////////////////////////////////////////////////////////////

CfgMagazinesSubClassesArray = (configfile/"CfgMagazines") call BIS_fnc_getCfgSubClasses;
CfgLightMagazine = [];
CfgPistolMagazine = [];
CfgHeavyMagazine = [];
CfgLauncherMagazine = [];
CfgFlareMagazine = [];
CfgGrenadeMagazine = [];
CfgUnknownMagazine = [];
CfgCompletePistol = [];

{
	private _ccount = _ccount + 1;
	private _classname = _x;
	

	private _scope = getNumber(configfile/"CfgMagazines"/_classname/"scope");
	private _ammotype = getText(configfile/"CfgMagazines"/_classname/"ammo");
	private _class = [_classname] call BIS_fnc_classMagazine;
	private _parents = [_class,true] call BIS_fnc_returnParents;
	if (_ammotype isEqualTo "B_556x45_Ball" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgLightMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_556x45_Ball_Tracer_Green" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgLightMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_556x45_Ball_Tracer_Red" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgLightMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_556x45_Ball_Tracer_Yellow" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgLightMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_556x45_Ball_Tracer_Red" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgLightMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_545x39_Ball_F" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgLightMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_545x39_Green_F" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgLightMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_545x39_Ball_Green_F" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgLightMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_65x39_Caseless" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgLightMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_65x39_Caseless_yellow" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgLightMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_65x39_Case_green" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgLightMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_65x39_Caseless_green" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgLightMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_65x39_Case_yellow" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgLightMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_580x42_Ball_F" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_127x54_Ball" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_762x39_Ball_F" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_762x39_Ball_Green_F" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_338_Ball" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_50BW_Ball_F" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_762x51_Tracer_Green" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_762x54_Tracer_Green" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_762x51_Ball" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_93x64_Ball" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_9x21_Ball_Tracer_Green" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgPistolMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_9x21_Ball_Tracer_Red" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgPistolMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_9x21_Ball_Tracer_Yellow" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgPistolMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_9x21_Ball" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgPistolMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_45ACP_Ball" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgPistolMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_45ACP_Ball_Green" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgPistolMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_45ACP_Ball_Yellow" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgPistolMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_338_NM_Ball" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "G_40mm_HE" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "G_40mm_HEDP" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "G_40mm_Smoke" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "G_40mm_SmokeBlue" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "G_40mm_SmokeGreen" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "G_40mm_SmokeOrange" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "G_40mm_SmokePurple" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "G_40mm_SmokeRed" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "G_40mm_SmokeYellow" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "F_40mm_CIR" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_127_x108_APDS" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "B_127x108_Ball" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "F_40mm_Green" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "F_40mm_Red" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "F_40mm_White" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "F_40mm_Yellow" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "F_20mm_Green" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "F_20mm_Red" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "F_20mm_White" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "F_20mm_Yellow" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "SmokeShell" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "SmokeShellBlue" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "SmokeShellGreen" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "SmokeShellOrange" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "SmokeShellPurple" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "SmokeShellRed" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "SmokeShellYellow" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "APERSBoundingMine_Range_Ammo" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "APERSMine_Range_Ammo" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "APERSMineDispenser_Ammo" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "APERSTripMine_Wire_Ammo" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "Chemlight_blue" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgPistolMagazine pushback _classname;};
	if (_ammotype isEqualTo "Chemlight_green" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgPistolMagazine pushback _classname;};
	if (_ammotype isEqualTo "Chemlight_red" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgPistolMagazine pushback _classname;};
	if (_ammotype isEqualTo "Chemlight_yellow" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgPistolMagazine pushback _classname;};
	if (_ammotype isEqualTo "GrenadeHand_stone" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgPistolMagazine pushback _classname;};
	if (_ammotype isEqualTo "HandGrenade" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgPistolMagazine pushback _classname;};
	if (_ammotype isEqualTo "MiniGrenade" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgPistolMagazine pushback _classname;};
	if (_ammotype isEqualTo "Laserbeam" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgPistolMagazine pushback _classname;};
	if (_ammotype isEqualTo "R_MRAAWS_HE_F" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "R_MRAAWS_HEAT_F" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "R_PG32V_F" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "R_TBG32V_F" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "R_PG7_F" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "M_NLAW_AT_F" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "M_Titan_AP" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};
	if (_ammotype isEqualTo "M_Vorona_HE" && (_scope isEqualTo 2) && !("VehicleMagazine" in _parents)) then {CfgHeavyMagazine pushback _classname;};

	CfgCompletePistol pushback _classname;
	
} forEach CfgMagazinesSubClassesArray;
CfgMagazinesSubClassesArray = nil;

{
	if (_x in CfgCarsArray) then
	{
		private _Veh = _x;
		private _Index = CfgCarsArray findIf {_x isEqualTo _Veh};
		CfgCarsArray deleteAt _Index;
	};
} foreach CfgLightArmorsArray;


{
	if (_x in CfgLightArmorsArray) then
	{
		private _Veh = _x;
		private _Index = CfgLightArmorsArray findIf {_x isEqualTo _Veh};
		CfgLightArmorsArray deleteAt _Index;
	};
} foreach CfgHeavyArmorsArray;


endLoadingScreen;
/*
publicVariable "CfgWeaponsArray";
publicVariable "CfgLauncherArray";
publicVariable "CfgAttachmentsArray";
publicVariable "CfgEquipmentArray";
publicVariable "CfgEquipmentArray2";
publicVariable "CfgUniformsArray";
publicVariable "CfgVestsArray";
publicVariable "CfgHelmetsArray";
publicVariable "CfgPistolArray";
publicVariable "CfgHeavyArray";
publicVariable "ExtraLootArray";
publicVariable "CfgLightMagazine";
publicVariable "CfgHeavyMagazine";
publicVariable "CfgLauncherMagazine";
publicVariable "CfgFlareMagazine";
publicVariable "CfgGrenadeMagazine";
publicVariable "CfgPistolMagazine";
publicVariable "CfgUnknownMagazine";
publicVariable "CfgCarsArray";
publicVariable "CfgLightArmorsArray";
publicVariable "CfgHeavyArmorsArray";
publicVariable "CfgHelicoptersArray";
publicVariable "CfgPlanesArray";
publicVariable "CfgBoatsArray";
publicVariable "CfgRucksArray";
publicVariable "CfgUGVArray";
publicVariable "CfgUAVArray";
publicVariable "CfgUGVArray";
publicVariable "CfgUGVArray";
*/



//systemChat "Gearsetup.sqf has completed!";
