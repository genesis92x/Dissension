



_U1 = {
comment "Exported from Arsenal by Dominic";

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
_this forceAddUniform "U_BG_Guerilla1_1";
for "_i" from 1 to 3 do {_this addItemToUniform "FirstAidKit";};
_this addVest "V_TacChestrig_oli_F";
for "_i" from 1 to 8 do {_this addItemToVest "30Rnd_762x39_Mag_F";};
_this addBackpack "B_FieldPack_khk";
for "_i" from 1 to 4 do {_this addItemToBackpack "RPG7_F";};
_this addHeadgear "H_Bandanna_sand";
_this addGoggles "G_Aviator";

comment "Add weapons";
_this addWeapon "arifle_AKM_F";
_this addWeapon "launch_RPG7_F";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";

comment "Set identity";
//_this setFace "TanoanHead_A3_02";
//_this setSpeaker "Male01ENG";
};

_U2 = {
comment "Exported from Arsenal by Dominic";

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
_this forceAddUniform "U_BG_Guerilla3_1";
for "_i" from 1 to 2 do {_this addItemToUniform "FirstAidKit";};
for "_i" from 1 to 3 do {_this addItemToUniform "10Rnd_9x21_Mag";};
_this addVest "V_TacChestrig_grn_F";
for "_i" from 1 to 8 do {_this addItemToVest "30Rnd_545x39_Mag_F";};
for "_i" from 1 to 2 do {_this addItemToVest "HandGrenade";};
for "_i" from 1 to 2 do {_this addItemToVest "SmokeShell";};
_this addBackpack "B_TacticalPack_blk";
_this addItemToBackpack "Medikit";
_this addHeadgear "H_Cap_oli";

comment "Add weapons";
_this addWeapon "arifle_AKS_F";
_this addWeapon "hgun_Pistol_01_F";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";

comment "Set identity";
//_this setFace "TanoanHead_A3_02";
//_this setSpeaker "Male01ENG";
};

_U3 = {
comment "Exported from Arsenal by Dominic";

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
_this forceAddUniform "U_I_C_Soldier_Bandit_5_F";
_this addItemToUniform "FirstAidKit";
_this addItemToUniform "HandGrenade";
_this addItemToUniform "30Rnd_545x39_Mag_F";
_this addVest "V_BandollierB_cbr";
for "_i" from 1 to 10 do {_this addItemToVest "30Rnd_545x39_Mag_F";};

comment "Add weapons";
_this addWeapon "arifle_AKS_F";
_this addWeapon "hgun_P07_khk_F";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";

};


_U4 =
{
comment "Exported from Arsenal by Dominic";

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
_this forceAddUniform "U_I_C_Soldier_Bandit_3_F";
for "_i" from 1 to 2 do {_this addItemToUniform "30Rnd_545x39_Mag_F";};
for "_i" from 1 to 2 do {_this addItemToUniform "16Rnd_9x21_red_Mag";};
_this addVest "V_Chestrig_rgr";
for "_i" from 1 to 2 do {_this addItemToVest "FirstAidKit";};
for "_i" from 1 to 4 do {_this addItemToVest "HandGrenade";};
for "_i" from 1 to 9 do {_this addItemToVest "30Rnd_545x39_Mag_F";};
_this addHeadgear "H_Bandanna_camo";

comment "Add weapons";
_this addWeapon "arifle_AKS_F";
_this addWeapon "hgun_P07_khk_F";
_this addWeapon "Rangefinder";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";

};

_U5 =
{
comment "Exported from Arsenal by Dominic";

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
_this forceAddUniform "U_C_Poor_1";
for "_i" from 1 to 3 do {_this addItemToUniform "30Rnd_556x45_Stanag";};
_this addVest "V_TacVest_blk";
for "_i" from 1 to 8 do {_this addItemToVest "30Rnd_556x45_Stanag_red";};
for "_i" from 1 to 3 do {_this addItemToVest "HandGrenade";};
_this addBackpack "B_FieldPack_oli";
for "_i" from 1 to 7 do {_this addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 2 do {_this addItemToBackpack "30Rnd_556x45_Stanag_red";};
for "_i" from 1 to 4 do {_this addItemToBackpack "HandGrenade";};
for "_i" from 1 to 8 do {_this addItemToBackpack "SmokeShell";};
for "_i" from 1 to 3 do {_this addItemToBackpack "30Rnd_556x45_Stanag";};
_this addHeadgear "H_Bandanna_camo";

comment "Add weapons";
_this addWeapon "arifle_Mk20_plain_F";
_this addWeapon "hgun_P07_khk_F";
_this addWeapon "Rangefinder";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";

};



_U6 =
{
comment "Exported from Arsenal by Dominic";

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
_this forceAddUniform "U_BG_Guerilla3_1";
for "_i" from 1 to 3 do {_this addItemToUniform "30Rnd_9x21_Mag_SMG_02";};
_this addBackpack "B_Carryall_oli";
for "_i" from 1 to 2 do {_this addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 10 do {_this addItemToBackpack "30Rnd_9x21_Mag_SMG_02_Tracer_Green";};
for "_i" from 1 to 5 do {_this addItemToBackpack "HandGrenade";};
_this addHeadgear "H_Bandanna_surfer";

comment "Add weapons";
_this addWeapon "SMG_05_F";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";



};


_U7 =
{
comment "Exported from Arsenal by Genesis";

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
_this forceAddUniform "U_C_Mechanic_01_F";
for "_i" from 1 to 2 do {_this addItemToUniform "30Rnd_556x45_Stanag";};
_this addVest "V_Pocketed_coyote_F";
for "_i" from 1 to 4 do {_this addItemToVest "30Rnd_556x45_Stanag";};
_this addBackpack "B_LegStrapBag_coyote_F";
for "_i" from 1 to 8 do {_this addItemToBackpack "30Rnd_556x45_Stanag";};
for "_i" from 1 to 2 do {_this addItemToBackpack "MiniGrenade";};
_this addHeadgear "H_WirelessEarpiece_F";
_this addGoggles "G_Bandanna_khk";

comment "Add weapons";
_this addWeapon "arifle_TRG21_F";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";
};

_U8 =
{
comment "Exported from Arsenal by Genesis";

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
_this forceAddUniform "U_C_Mechanic_01_F";
for "_i" from 1 to 2 do {_this addItemToUniform "30Rnd_762x39_Mag_F";};
_this addVest "V_LegStrapBag_black_F";
for "_i" from 1 to 5 do {_this addItemToVest "30Rnd_762x39_Mag_F";};
_this addBackpack "B_Messenger_Gray_F";
for "_i" from 1 to 2 do {_this addItemToBackpack "MiniGrenade";};
for "_i" from 1 to 7 do {_this addItemToBackpack "30Rnd_762x39_Mag_F";};
_this addHeadgear "H_Bandanna_khk_hs";
_this addGoggles "G_Bandanna_khk";

comment "Add weapons";
_this addWeapon "arifle_AKM_F";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";

};

_U9 =
{
comment "Exported from Arsenal by Genesis";

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
_this forceAddUniform "U_I_C_Soldier_Bandit_2_F";
_this addVest "V_Pocketed_olive_F";
for "_i" from 1 to 5 do {_this addItemToVest "30Rnd_762x39_Mag_F";};
if (random 100 < 20) then
{
	_this addBackpack "I_HMG_01_high_weapon_F";
}
else
{
	_this addBackpack "B_AssaultPack_khk";	
};

_this addHeadgear "H_HeadBandage_bloody_F";
_this addGoggles "G_Bandanna_khk";

comment "Add weapons";
_this addWeapon "arifle_AKM_F";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";

};

_U10 =
{
comment "Exported from Arsenal by Genesis";

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
_this forceAddUniform "U_C_Man_casual_6_F";
for "_i" from 1 to 3 do {_this addItemToUniform "30Rnd_545x39_Mag_F";};
_this addVest "V_Safety_orange_F";
_this addBackpack "B_AssaultPack_khk";
for "_i" from 1 to 7 do {_this addItemToBackpack "30Rnd_545x39_Mag_F";};
_this addItemToBackpack "SatchelCharge_Remote_Mag";
_this addItemToBackpack "DemoCharge_Remote_Mag";
_this addHeadgear "H_HeadBandage_bloody_F";
_this addGoggles "G_Bandanna_khk";

comment "Add weapons";
_this addWeapon "arifle_AKS_F";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";

};

_U11 =
{
comment "Exported from Arsenal by Genesis";

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
_this forceAddUniform "U_C_WorkerCoveralls";
for "_i" from 1 to 3 do {_this addItemToUniform "30Rnd_9x21_Mag_SMG_02";};
_this addBackpack "B_LegStrapBag_black_F";
for "_i" from 1 to 8 do {_this addItemToBackpack "30Rnd_9x21_Mag_SMG_02";};
_this addHeadgear "H_ShemagOpen_khk";
_this addGoggles "G_Bandanna_khk";

comment "Add weapons";
_this addWeapon "SMG_02_F";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";

};

_U12 =
{
comment "Exported from Arsenal by Genesis";

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
_this forceAddUniform "U_I_C_Soldier_Bandit_5_F";
_this addBackpack "B_TacticalPack_blk";
for "_i" from 1 to 2 do {_this addItemToBackpack "200Rnd_65x39_cased_Box";};
_this addItemToBackpack "IEDLandBig_Remote_Mag";
_this addHeadgear "H_ShemagOpen_khk";
_this addGoggles "G_Bandanna_khk";

comment "Add weapons";
_this addWeapon "LMG_Mk200_F";
_this addWeapon "hgun_Pistol_heavy_02_F";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";

};

_UniformArray = [_U1,_U2,_U3,_U4,_U5,_U6,_U7,_U8,_U9,_U10,_U11,_U12];
_this call selectrandom _UniformArray;





