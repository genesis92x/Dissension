if (RHSACTIVATED) exitwith
{
	_U1 = {
	comment "Exported from Arsenal by PRYMSUSPEC";
	
	comment "Remove existing items";
	removeAllWeapons _this;
	removeAllItems _this;
	removeAllAssignedItems _this;
	removeUniform _this;
	removeVest _this;
	removeBackpack _this;
	removeHeadgear _this;
	removeGoggles _this;
	
	comment "Add containers";
	_this forceAddUniform "U_BG_Guerilla2_3";
	_this addItemToUniform "FirstAidKit";
	_this addVest "V_PlateCarrier2_rgr_noflag_F";
	for "_i" from 1 to 2 do {_this addItemToVest "FirstAidKit";};
	for "_i" from 1 to 2 do {_this addItemToVest "SmokeShell";};
	for "_i" from 1 to 7 do {_this addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Green";};
	for "_i" from 1 to 2 do {_this addItemToVest "rhsusf_mag_17Rnd_9x19_JHP";};
	for "_i" from 1 to 2 do {_this addItemToVest "SmokeShellGreen";};
	_this addBackpack "B_AssaultPack_rgr";
	for "_i" from 1 to 2 do {_this addItemToBackpack "FirstAidKit";};
	for "_i" from 1 to 2 do {_this addItemToBackpack "SmokeShellGreen";};
	for "_i" from 1 to 7 do {_this addItemToBackpack "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Green";};
	_this addHeadgear "rhsusf_opscore_fg_pelt";
	
	comment "Add weapons";
	_this addWeapon "rhs_weap_m4_mstock";
	_this addPrimaryWeaponItem "rhsusf_acc_anpeq15_bk_top";
	_this addPrimaryWeaponItem "rhsusf_acc_ACOG";
	_this addWeapon "rhsusf_weap_glock17g4";
	
	comment "Add items";
	_this linkItem "ItemMap";
	_this linkItem "ItemRadio";
	_this linkItem "rhsusf_ANPVS_14";
	comment "Set identity";
	};
	
	_U2 = {
	comment "Exported from Arsenal by PRYMSUSPEC";
	
	comment "Remove existing items";
	removeAllWeapons _this;
	removeAllItems _this;
	removeAllAssignedItems _this;
	removeUniform _this;
	removeVest _this;
	removeBackpack _this;
	removeHeadgear _this;
	removeGoggles _this;
	
	comment "Add containers";
	_this forceAddUniform "U_BG_Guerilla2_3";
	_this addItemToUniform "FirstAidKit";
	_this addVest "V_PlateCarrier1_rgr_noflag_F";
	for "_i" from 1 to 2 do {_this addItemToVest "FirstAidKit";};
	for "_i" from 1 to 2 do {_this addItemToVest "rhsusf_mag_17Rnd_9x19_JHP";};
	for "_i" from 1 to 2 do {_this addItemToVest "SmokeShell";};
	for "_i" from 1 to 7 do {_this addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Green";};
	for "_i" from 1 to 2 do {_this addItemToVest "SmokeShellGreen";};
	_this addBackpack "B_AssaultPack_rgr";
	_this addItemToBackpack "rhsusf_ANPVS_14";
	for "_i" from 1 to 2 do {_this addItemToBackpack "FirstAidKit";};
	for "_i" from 1 to 2 do {_this addItemToBackpack "SmokeShellGreen";};
	for "_i" from 1 to 7 do {_this addItemToBackpack "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Green";};
	_this addHeadgear "H_Watchcap_khk";
	
	comment "Add weapons";
	_this addWeapon "rhs_weap_m4_mstock";
	_this addPrimaryWeaponItem "rhsusf_acc_eotech_xps3";
	_this addWeapon "rhsusf_weap_glock17g4";
	
	comment "Add items";
	_this linkItem "ItemMap";
	_this linkItem "ItemRadio";
	
	comment "Set identity"
	};
	
	_U3 = {
	comment "Exported from Arsenal by PRYMSUSPEC";
	
	comment "Remove existing items";
	removeAllWeapons _this;
	removeAllItems _this;
	removeAllAssignedItems _this;
	removeUniform _this;
	removeVest _this;
	removeBackpack _this;
	removeHeadgear _this;
	removeGoggles _this;
	
	comment "Add containers";
	_this forceAddUniform "U_BG_Guerilla2_3";
	_this addItemToUniform "FirstAidKit";
	_this addVest "V_PlateCarrier2_rgr_noflag_F";
	for "_i" from 1 to 2 do {_this addItemToVest "FirstAidKit";};
	for "_i" from 1 to 2 do {_this addItemToVest "rhsusf_mag_17Rnd_9x19_JHP";};
	for "_i" from 1 to 2 do {_this addItemToVest "SmokeShell";};
	for "_i" from 1 to 7 do {_this addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Green";};
	for "_i" from 1 to 2 do {_this addItemToVest "SmokeShellGreen";};
	_this addBackpack "B_AssaultPack_rgr";
	for "_i" from 1 to 2 do {_this addItemToBackpack "FirstAidKit";};
	for "_i" from 1 to 7 do {_this addItemToBackpack "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Green";};
	for "_i" from 1 to 2 do {_this addItemToBackpack "SmokeShellGreen";};
	_this addHeadgear "rhsusf_opscore_fg_pelt";
	
	comment "Add weapons";
	_this addWeapon "rhs_weap_m4_carryhandle_pmag";
	_this addPrimaryWeaponItem "rhsusf_acc_anpeq15side_bk";
	_this addPrimaryWeaponItem "rhsusf_acc_eotech_552";
	_this addWeapon "rhsusf_weap_glock17g4";
	
	comment "Add items";
	_this linkItem "ItemMap";
	_this linkItem "ItemCompass";
	_this linkItem "ItemWatch";
	_this linkItem "ItemRadio";
	_this linkItem "ItemGPS";
	_this linkItem "rhsusf_ANPVS_14";
	
	comment "Set identity";
	};
	
	
	_U4 =
	{
	comment "Exported from Arsenal by PRYMSUSPEC";
	
	comment "Remove existing items";
	removeAllWeapons _this;
	removeAllItems _this;
	removeAllAssignedItems _this;
	removeUniform _this;
	removeVest _this;
	removeBackpack _this;
	removeHeadgear _this;
	removeGoggles _this;
	
	comment "Add containers";
	_this forceAddUniform "U_BG_Guerilla2_3";
	_this addItemToUniform "FirstAidKit";
	_this addVest "V_PlateCarrier1_rgr_noflag_F";
	for "_i" from 1 to 2 do {_this addItemToVest "FirstAidKit";};
	for "_i" from 1 to 2 do {_this addItemToVest "SmokeShell";};
	for "_i" from 1 to 2 do {_this addItemToVest "SmokeShellGreen";};
	for "_i" from 1 to 2 do {_this addItemToVest "rhsusf_mag_17Rnd_9x19_JHP";};
	for "_i" from 1 to 5 do {_this addItemToVest "rhsusf_20Rnd_762x51_m118_special_Mag";};
	_this addBackpack "B_AssaultPack_rgr";
	_this addItemToBackpack "rhsusf_ANPVS_14";
	_this addItemToBackpack "rhsusf_acc_premier_anpvs27";
	for "_i" from 1 to 2 do {_this addItemToBackpack "FirstAidKit";};
	for "_i" from 1 to 6 do {_this addItemToBackpack "rhsusf_20Rnd_762x51_m118_special_Mag";};
	for "_i" from 1 to 2 do {_this addItemToBackpack "SmokeShellGreen";};
	_this addHeadgear "H_Cap_headphones";
	
	comment "Add weapons";
	_this addWeapon "rhs_weap_sr25";
	_this addPrimaryWeaponItem "rhsusf_acc_anpeq15side_bk";
	_this addPrimaryWeaponItem "rhsusf_acc_premier_low";
	_this addPrimaryWeaponItem "bipod_01_F_blk";
	_this addWeapon "rhsusf_weap_glock17g4";
	_this addWeapon "Laserdesignator_01_khk_F";
	
	comment "Add items";
	_this linkItem "ItemMap";
	_this linkItem "ItemRadio";
	
	comment "Set identity";
	
	};
	
	_U5 =
	{
	comment "Exported from Arsenal by PRYMSUSPEC";
	
	comment "Remove existing items";
	removeAllWeapons _this;
	removeAllItems _this;
	removeAllAssignedItems _this;
	removeUniform _this;
	removeVest _this;
	removeBackpack _this;
	removeHeadgear _this;
	removeGoggles _this;
	
	comment "Add containers";
	_this forceAddUniform "U_BG_Guerilla2_3";
	for "_i" from 1 to 3 do {_this addItemToUniform "FirstAidKit";};
	_this addVest "V_PlateCarrier1_rgr_noflag_F";
	for "_i" from 1 to 4 do {_this addItemToVest "FirstAidKit";};
	for "_i" from 1 to 2 do {_this addItemToVest "SmokeShell";};
	for "_i" from 1 to 7 do {_this addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Green";};
	for "_i" from 1 to 2 do {_this addItemToVest "rhsusf_mag_17Rnd_9x19_JHP";};
	for "_i" from 1 to 2 do {_this addItemToVest "SmokeShellGreen";};
	_this addBackpack "B_Kitbag_rgr";
	for "_i" from 1 to 12 do {_this addItemToBackpack "FirstAidKit";};
	_this addItemToBackpack "Medikit";
	_this addItemToBackpack "rhsusf_ANPVS_14";
	for "_i" from 1 to 7 do {_this addItemToBackpack "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Green";};
	for "_i" from 1 to 2 do {_this addItemToBackpack "SmokeShellGreen";};
	_this addHeadgear "H_Cap_oli_hs";
	
	comment "Add weapons";
	_this addWeapon "rhs_weap_m4";
	_this addPrimaryWeaponItem "rhsusf_acc_anpeq15_bk_top";
	_this addPrimaryWeaponItem "rhsusf_acc_eotech_552";
	_this addPrimaryWeaponItem "rhsusf_acc_grip2";
	_this addWeapon "rhsusf_weap_glock17g4";
	
	comment "Add items";
	_this linkItem "ItemMap";
	_this linkItem "ItemCompass";
	_this linkItem "ItemWatch";
	_this linkItem "ItemRadio";
	_this linkItem "ItemGPS";
	
	comment "Set identity";
	
	};
	
	
	
	_U6 =
	{
	comment "Exported from Arsenal by PRYMSUSPEC";
	
	comment "Remove existing items";
	removeAllWeapons _this;
	removeAllItems _this;
	removeAllAssignedItems _this;
	removeUniform _this;
	removeVest _this;
	removeBackpack _this;
	removeHeadgear _this;
	removeGoggles _this;
	
	comment "Add containers";
	_this forceAddUniform "U_BG_Guerilla2_3";
	_this addItemToUniform "FirstAidKit";
	_this addVest "V_PlateCarrier1_rgr_noflag_F";
	for "_i" from 1 to 2 do {_this addItemToVest "FirstAidKit";};
	for "_i" from 1 to 2 do {_this addItemToVest "rhsusf_mag_17Rnd_9x19_JHP";};
	for "_i" from 1 to 2 do {_this addItemToVest "SmokeShell";};
	for "_i" from 1 to 2 do {_this addItemToVest "SmokeShellGreen";};
	for "_i" from 1 to 2 do {_this addItemToVest "rhs_200rnd_556x45_M_SAW";};
	_this addBackpack "B_AssaultPack_rgr";
	for "_i" from 1 to 2 do {_this addItemToBackpack "FirstAidKit";};
	for "_i" from 1 to 3 do {_this addItemToBackpack "rhs_200rnd_556x45_M_SAW";};
	_this addHeadgear "rhsusf_opscore_fg_pelt";
	
	comment "Add weapons";
	_this addWeapon "rhs_weap_m249_pip_S";
	_this addPrimaryWeaponItem "rhsusf_acc_anpeq15side_bk";
	_this addPrimaryWeaponItem "rhsusf_acc_eotech_xps3";
	_this addWeapon "rhsusf_weap_glock17g4";
	
	comment "Add items";
	_this linkItem "ItemMap";
	_this linkItem "ItemRadio";
	_this linkItem "rhsusf_ANPVS_14";
	
	comment "Set identity";
	
	
	
	};
	
	
	
	
	
	
	_UniformArray = [_U1,_U2,_U3,_U4,_U5,_U6];
	_this call selectrandom _UniformArray;
};


_U1 = {
comment "Exported from Arsenal by PRYMSUSPEC";

comment "Remove existing items";
removeAllWeapons _this;
removeAllItems _this;
removeAllAssignedItems _this;
removeUniform _this;
removeVest _this;
removeBackpack _this;
removeHeadgear _this;
removeGoggles _this;

comment "Add containers";
_this forceAddUniform "U_BG_Guerilla2_3";
_this addItemToUniform "FirstAidKit";
_this addVest "V_PlateCarrier2_rgr";
for "_i" from 1 to 2 do {_this addItemToVest "FirstAidKit";};
for "_i" from 1 to 2 do {_this addItemToVest "SmokeShellGreen";};
for "_i" from 1 to 2 do {_this addItemToVest "16Rnd_9x21_Mag";};
for "_i" from 1 to 7 do {_this addItemToVest "30Rnd_65x39_caseless_mag_Tracer";};
_this addBackpack "B_AssaultPack_rgr";
for "_i" from 1 to 2 do {_this addItemToBackpack "FirstAidKit";};
_this addItemToBackpack "NVGoggles_OPFOR";
for "_i" from 1 to 2 do {_this addItemToBackpack "SmokeShellGreen";};
for "_i" from 1 to 7 do {_this addItemToBackpack "30Rnd_65x39_caseless_mag_Tracer";};
_this addHeadgear "H_Bandanna_khk_hs";

comment "Add weapons";
_this addWeapon "arifle_MX_Black_F";
_this addPrimaryWeaponItem "acc_pointer_IR";
_this addPrimaryWeaponItem "optic_Holosight_blk_F";
_this addWeapon "hgun_P07_F";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";

comment "Set identity";
};


_U2 = {
comment "Exported from Arsenal by PRYMSUSPEC";

comment "Remove existing items";
removeAllWeapons _this;
removeAllItems _this;
removeAllAssignedItems _this;
removeUniform _this;
removeVest _this;
removeBackpack _this;
removeHeadgear _this;
removeGoggles _this;

comment "Add containers";
_this forceAddUniform "U_BG_Guerilla2_3";
_this addItemToUniform "FirstAidKit";
_this addItemToUniform "30Rnd_65x39_caseless_mag";
_this addVest "V_PlateCarrier1_rgr";
for "_i" from 1 to 2 do {_this addItemToVest "FirstAidKit";};
for "_i" from 1 to 2 do {_this addItemToVest "SmokeShellGreen";};
for "_i" from 1 to 2 do {_this addItemToVest "16Rnd_9x21_Mag";};
for "_i" from 1 to 7 do {_this addItemToVest "30Rnd_65x39_caseless_mag_Tracer";};
_this addBackpack "B_AssaultPack_rgr";
for "_i" from 1 to 2 do {_this addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 2 do {_this addItemToBackpack "SmokeShellGreen";};
for "_i" from 1 to 7 do {_this addItemToBackpack "30Rnd_65x39_caseless_mag_Tracer";};
_this addHeadgear "H_HelmetB";

comment "Add weapons";
_this addWeapon "arifle_MXC_Black_F";
_this addPrimaryWeaponItem "acc_pointer_IR";
_this addPrimaryWeaponItem "optic_ACO_grn_smg";
_this addWeapon "hgun_P07_F";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";
_this linkItem "NVGoggles_OPFOR";

comment "Set identity";
};

_U3 = {
comment "Exported from Arsenal by PRYMSUSPEC";

comment "Remove existing items";
removeAllWeapons _this;
removeAllItems _this;
removeAllAssignedItems _this;
removeUniform _this;
removeVest _this;
removeBackpack _this;
removeHeadgear _this;
removeGoggles _this;

comment "Add containers";
_this forceAddUniform "U_BG_Guerilla2_3";
_this addItemToUniform "FirstAidKit";
_this addVest "V_PlateCarrier2_rgr";
for "_i" from 1 to 2 do {_this addItemToVest "FirstAidKit";};
for "_i" from 1 to 2 do {_this addItemToVest "SmokeShellGreen";};
for "_i" from 1 to 2 do {_this addItemToVest "16Rnd_9x21_Mag";};
for "_i" from 1 to 7 do {_this addItemToVest "30Rnd_65x39_caseless_mag_Tracer";};
_this addBackpack "B_AssaultPack_rgr";
for "_i" from 1 to 2 do {_this addItemToBackpack "FirstAidKit";};
_this addItemToBackpack "NVGoggles_OPFOR";
for "_i" from 1 to 2 do {_this addItemToBackpack "SmokeShellGreen";};
for "_i" from 1 to 7 do {_this addItemToBackpack "30Rnd_65x39_caseless_mag_Tracer";};
_this addHeadgear "H_Watchcap_khk";

comment "Add weapons";
_this addWeapon "arifle_MX_Black_F";
_this addPrimaryWeaponItem "acc_pointer_IR";
_this addPrimaryWeaponItem "optic_Arco_blk_F";
_this addWeapon "hgun_P07_F";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";

comment "Set identity";
};


_U4 = {
comment "Exported from Arsenal by PRYMSUSPEC";

comment "Remove existing items";
removeAllWeapons _this;
removeAllItems _this;
removeAllAssignedItems _this;
removeUniform _this;
removeVest _this;
removeBackpack _this;
removeHeadgear _this;
removeGoggles _this;

comment "Add containers";
_this forceAddUniform "U_BG_Guerilla2_3";
_this addItemToUniform "FirstAidKit";
_this addVest "V_PlateCarrier1_rgr";
for "_i" from 1 to 2 do {_this addItemToVest "FirstAidKit";};
for "_i" from 1 to 2 do {_this addItemToVest "SmokeShellGreen";};
for "_i" from 1 to 2 do {_this addItemToVest "16Rnd_9x21_Mag";};
for "_i" from 1 to 8 do {_this addItemToVest "20Rnd_762x51_Mag";};
_this addBackpack "B_AssaultPack_rgr";
for "_i" from 1 to 2 do {_this addItemToBackpack "FirstAidKit";};
_this addItemToBackpack "NVGoggles_OPFOR";
for "_i" from 1 to 2 do {_this addItemToBackpack "SmokeShellGreen";};
for "_i" from 1 to 9 do {_this addItemToBackpack "20Rnd_762x51_Mag";};
_this addHeadgear "H_Cap_headphones";

comment "Add weapons";
_this addWeapon "srifle_EBR_F";
_this addPrimaryWeaponItem "acc_pointer_IR";
_this addPrimaryWeaponItem "optic_DMS";
_this addPrimaryWeaponItem "bipod_01_F_blk";
_this addWeapon "hgun_P07_F";
_this addWeapon "Laserdesignator";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";

comment "Set identity";
};


_U5 = {
comment "Exported from Arsenal by PRYMSUSPEC";

comment "Remove existing items";
removeAllWeapons _this;
removeAllItems _this;
removeAllAssignedItems _this;
removeUniform _this;
removeVest _this;
removeBackpack _this;
removeHeadgear _this;
removeGoggles _this;

comment "Add containers";
_this forceAddUniform "U_BG_Guerilla2_3";
for "_i" from 1 to 2 do {_this addItemToUniform "FirstAidKit";};
_this addVest "V_PlateCarrier2_rgr";
for "_i" from 1 to 2 do {_this addItemToVest "FirstAidKit";};
for "_i" from 1 to 2 do {_this addItemToVest "SmokeShellGreen";};
for "_i" from 1 to 2 do {_this addItemToVest "16Rnd_9x21_Mag";};
for "_i" from 1 to 7 do {_this addItemToVest "30Rnd_65x39_caseless_mag_Tracer";};
_this addBackpack "B_Kitbag_rgr";
for "_i" from 1 to 8 do {_this addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 2 do {_this addItemToBackpack "Medikit";};
for "_i" from 1 to 2 do {_this addItemToBackpack "SmokeShellGreen";};
for "_i" from 1 to 4 do {_this addItemToBackpack "30Rnd_65x39_caseless_mag_Tracer";};
_this addHeadgear "H_HelmetB";

comment "Add weapons";
_this addWeapon "arifle_MXC_Black_F";
_this addPrimaryWeaponItem "acc_pointer_IR";
_this addPrimaryWeaponItem "optic_ERCO_blk_F";
_this addWeapon "hgun_P07_F";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";
_this linkItem "NVGoggles_OPFOR";

comment "Set identity";
};

_U6 = {
comment "Exported from Arsenal by PRYMSUSPEC";

comment "Remove existing items";
removeAllWeapons _this;
removeAllItems _this;
removeAllAssignedItems _this;
removeUniform _this;
removeVest _this;
removeBackpack _this;
removeHeadgear _this;
removeGoggles _this;

comment "Add containers";
_this forceAddUniform "U_BG_Guerilla2_3";
_this addItemToUniform "FirstAidKit";
_this addVest "V_PlateCarrier2_rgr";
for "_i" from 1 to 2 do {_this addItemToVest "FirstAidKit";};
for "_i" from 1 to 2 do {_this addItemToVest "SmokeShellGreen";};
for "_i" from 1 to 2 do {_this addItemToVest "16Rnd_9x21_Mag";};
for "_i" from 1 to 2 do {_this addItemToVest "200Rnd_65x39_cased_Box_Tracer";};
_this addBackpack "B_AssaultPack_rgr";
for "_i" from 1 to 2 do {_this addItemToBackpack "FirstAidKit";};
_this addItemToBackpack "NVGoggles_OPFOR";
for "_i" from 1 to 2 do {_this addItemToBackpack "SmokeShellGreen";};
for "_i" from 1 to 2 do {_this addItemToBackpack "200Rnd_65x39_cased_Box_Tracer";};
_this addHeadgear "H_Booniehat_oli";

comment "Add weapons";
_this addWeapon "LMG_Mk200_F";
_this addPrimaryWeaponItem "acc_pointer_IR";
_this addPrimaryWeaponItem "optic_Hamr";
_this addPrimaryWeaponItem "bipod_01_F_blk";
_this addWeapon "hgun_P07_F";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";

comment "Set identity";

};







_UniformArray = [_U1,_U2,_U3,_U4,_U5,_U6];
_this call selectrandom _UniformArray;








