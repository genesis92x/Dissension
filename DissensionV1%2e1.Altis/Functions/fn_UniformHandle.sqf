params ["_unit","_ActualSpawnInf"];

switch (_ActualSpawnInf) do 
{
    case "B_Soldier_F": 
		{
			removeAllWeapons _unit;
			removeAllItems _unit;
			removeAllAssignedItems _unit;
			removeUniform _unit;
			removeVest _unit;
			removeBackpack _unit;
			removeHeadgear _unit;
			removeGoggles _unit;
			
			_unit forceAddUniform "U_B_CombatUniform_mcam";
			_unit addItemToUniform "FirstAidKit";
			for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
			_unit addVest "V_PlateCarrier1_rgr_noflag_F";
			_unit addItemToVest "FirstAidKit";
			for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
			for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
			for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_556x45_Stanag_Tracer_Red";};
			_unit addBackpack "B_Kitbag_mcamo";
			_unit addItemToBackpack "FirstAidKit";
			_unit addHeadgear "H_HelmetB_camo";
			
			_unit addWeapon "arifle_SPAR_01_blk_F";
			_unit addPrimaryWeaponItem "acc_pointer_IR";
			_unit addPrimaryWeaponItem "optic_Holosight_blk_F";
			_unit addWeapon "hgun_Pistol_heavy_01_F";
			
			_unit linkItem "ItemMap";
			_unit linkItem "ItemCompass";
			_unit linkItem "ItemWatch";
			_unit linkItem "ItemRadio";
			_unit linkItem "NVGoggles_OPFOR";
		};			
    case "B_soldier_LAT_F": 
		{
			comment "Remove existing items";
			removeAllWeapons _unit;
			removeAllItems _unit;
			removeAllAssignedItems _unit;
			removeUniform _unit;
			removeVest _unit;
			removeBackpack _unit;
			removeHeadgear _unit;
			removeGoggles _unit;
			
			comment "Add containers";
			_unit forceAddUniform "U_B_CombatUniform_mcam";
			_unit addItemToUniform "FirstAidKit";
			for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
			_unit addVest "V_PlateCarrier1_rgr_noflag_F";
			_unit addItemToVest "FirstAidKit";
			for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
			for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_556x45_Stanag_Tracer_Red";};
			_unit addBackpack "B_Kitbag_mcamo";
			_unit addItemToBackpack "FirstAidKit";
			for "_i" from 1 to 2 do {_unit addItemToBackpack "MRAWS_HEAT_F";};
			for "_i" from 1 to 2 do {_unit addItemToBackpack "MRAWS_HE_F";};
			_unit addHeadgear "H_HelmetB_camo";
			
			comment "Add weapons";
			_unit addWeapon "arifle_SPAR_01_blk_F";
			_unit addPrimaryWeaponItem "acc_pointer_IR";
			_unit addPrimaryWeaponItem "optic_Holosight_blk_F";
			_unit addWeapon "launch_MRAWS_green_F";
			_unit addWeapon "hgun_Pistol_heavy_01_F";
			
			comment "Add items";
			_unit linkItem "ItemMap";
			_unit linkItem "ItemCompass";
			_unit linkItem "ItemWatch";
			_unit linkItem "ItemRadio";
			_unit linkItem "NVGoggles_OPFOR";	
		};
    case "B_Soldier_GL_F": 
		{
			comment "Remove existing items";
			removeAllWeapons _unit;
			removeAllItems _unit;
			removeAllAssignedItems _unit;
			removeUniform _unit;
			removeVest _unit;
			removeBackpack _unit;
			removeHeadgear _unit;
			removeGoggles _unit;
			
			comment "Add containers";
			_unit forceAddUniform "U_B_CombatUniform_mcam";
			_unit addItemToUniform "FirstAidKit";
			for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
			_unit addVest "V_PlateCarrier1_rgr_noflag_F";
			_unit addItemToVest "FirstAidKit";
			for "_i" from 1 to 6 do {_unit addItemToVest "1Rnd_HE_Grenade_shell";};
			_unit addItemToVest "1Rnd_Smoke_Grenade_shell";
			_unit addItemToVest "1Rnd_SmokeRed_Grenade_shell";
			_unit addItemToVest "UGL_FlareRed_F";
			_unit addItemToVest "UGL_FlareWhite_F";
			for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_556x45_Stanag_Tracer_Red";};
			_unit addBackpack "B_Kitbag_mcamo";
			_unit addItemToBackpack "FirstAidKit";
			_unit addItemToBackpack "UGL_FlareWhite_F";
			_unit addItemToBackpack "UGL_FlareRed_F";
			_unit addItemToBackpack "1Rnd_SmokeRed_Grenade_shell";
			_unit addItemToBackpack "1Rnd_Smoke_Grenade_shell";
			for "_i" from 1 to 10 do {_unit addItemToBackpack "1Rnd_HE_Grenade_shell";};
			_unit addHeadgear "H_HelmetB_camo";
			
			comment "Add weapons";
			_unit addWeapon "arifle_SPAR_01_GL_blk_F";
			_unit addPrimaryWeaponItem "optic_Holosight_blk_F";
			_unit addWeapon "hgun_Pistol_heavy_01_F";
			
			comment "Add items";
			_unit linkItem "ItemMap";
			_unit linkItem "ItemCompass";
			_unit linkItem "ItemWatch";
			_unit linkItem "ItemRadio";
			_unit linkItem "NVGoggles_OPFOR";

		};
    case "B_soldier_AR_F": 
		{
comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addVest "V_PlateCarrier1_rgr_noflag_F";
_unit addItemToVest "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToVest "200Rnd_556x45_Box_Tracer_Red_F";};
_unit addBackpack "B_Kitbag_mcamo";
_unit addItemToBackpack "FirstAidKit";
_unit addItemToBackpack "200Rnd_556x45_Box_Tracer_Red_F";
_unit addHeadgear "H_HelmetB_camo";

comment "Add weapons";
_unit addWeapon "LMG_03_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_ERCO_blk_F";
_unit addWeapon "hgun_Pistol_heavy_01_F";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemRadio";
_unit linkItem "NVGoggles_OPFOR";

		};
    case "B_medic_F": 
		{
comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addVest "V_PlateCarrier1_rgr_noflag_F";
_unit addItemToVest "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShellRed";};
for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_556x45_Stanag_Tracer_Red";};
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
_unit addBackpack "B_Kitbag_mcamo";
for "_i" from 1 to 10 do {_unit addItemToBackpack "FirstAidKit";};
_unit addItemToBackpack "Medikit";
_unit addHeadgear "H_HelmetB_camo";

comment "Add weapons";
_unit addWeapon "arifle_SPAR_01_blk_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Holosight_blk_F";
_unit addWeapon "hgun_Pistol_heavy_01_F";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "NVGoggles_OPFOR";

		};
    case "B_sniper_F": 
		{
comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_B_GhillieSuit";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addVest "V_PlateCarrier1_rgr_noflag_F";
_unit addItemToVest "FirstAidKit";
for "_i" from 1 to 7 do {_unit addItemToVest "10Rnd_338_Mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
_unit addBackpack "B_Kitbag_mcamo";
_unit addItemToBackpack "FirstAidKit";
_unit addItemToBackpack "optic_Nightstalker";
for "_i" from 1 to 4 do {_unit addItemToBackpack "APERSTripMine_Wire_Mag";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "10Rnd_338_Mag";};
_unit addHeadgear "H_Booniehat_mcamo";

comment "Add weapons";
_unit addWeapon "srifle_DMR_02_sniper_F";
_unit addPrimaryWeaponItem "muzzle_snds_338_sand";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_AMS_snd";
_unit addPrimaryWeaponItem "bipod_01_F_snd";
_unit addWeapon "hgun_Pistol_heavy_01_F";
_unit addWeapon "Laserdesignator";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
_unit linkItem "NVGoggles_INDEP";

		};
    case "B_soldier_AT_F": 
		{
comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addVest "V_PlateCarrier1_rgr_noflag_F";
_unit addItemToVest "FirstAidKit";
for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_556x45_Stanag_Tracer_Red";};
_unit addBackpack "B_Kitbag_mcamo";
_unit addItemToBackpack "FirstAidKit";
_unit addItemToBackpack "Titan_AT";
_unit addHeadgear "H_HelmetB_camo";

comment "Add weapons";
_unit addWeapon "arifle_SPAR_01_blk_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Holosight_blk_F";
_unit addWeapon "launch_I_Titan_short_F";
_unit addSecondaryWeaponItem "acc_pointer_IR";
_unit addWeapon "hgun_Pistol_heavy_01_F";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "NVGoggles_OPFOR";

		};
    case "B_HeavyGunner_F": 
		{
comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 3 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addVest "V_PlateCarrier1_rgr_noflag_F";
_unit addItemToVest "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToVest "130Rnd_338_Mag";};
_unit addBackpack "B_Kitbag_mcamo";
_unit addItemToBackpack "FirstAidKit";
_unit addItemToBackpack "130Rnd_338_Mag";
_unit addHeadgear "H_HelmetB_camo";

comment "Add weapons";
_unit addWeapon "MMG_02_black_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_ERCO_blk_F";
_unit addPrimaryWeaponItem "bipod_01_F_blk";
_unit addWeapon "hgun_Pistol_heavy_01_F";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "NVGoggles_OPFOR";

		};	
    case "B_Engineer_F": 
		{
comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addVest "V_PlateCarrier1_rgr_noflag_F";
_unit addItemToVest "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_556x45_Stanag_Tracer_Red";};
for "_i" from 1 to 2 do {_unit addItemToVest "DemoCharge_Remote_Mag";};
_unit addBackpack "B_Kitbag_mcamo_Eng";
_unit addItemToBackpack "MineDetector";
_unit addItemToBackpack "ToolKit";
_unit addItemToBackpack "SatchelCharge_Remote_Mag";
for "_i" from 1 to 5 do {_unit addItemToBackpack "DemoCharge_Remote_Mag";};
_unit addHeadgear "H_HelmetB_camo";

comment "Add weapons";
_unit addWeapon "arifle_SPAR_01_blk_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Holosight_blk_F";
_unit addWeapon "hgun_Pistol_heavy_01_F";
_unit addWeapon "Binocular";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
_unit linkItem "NVGoggles_OPFOR";

		};	
    case "B_soldier_M_F": 
		{
comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addVest "V_PlateCarrier1_rgr_noflag_F";
_unit addItemToVest "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 7 do {_unit addItemToVest "20Rnd_762x51_Mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
_unit addBackpack "B_Kitbag_mcamo";
_unit addItemToBackpack "FirstAidKit";
for "_i" from 1 to 4 do {_unit addItemToBackpack "20Rnd_762x51_Mag";};
_unit addHeadgear "H_HelmetB_camo";

comment "Add weapons";
_unit addWeapon "srifle_EBR_F";
_unit addPrimaryWeaponItem "optic_KHS_tan";
_unit addPrimaryWeaponItem "bipod_01_F_blk";
_unit addWeapon "hgun_Pistol_heavy_01_F";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "NVGoggles_OPFOR";

		};	
    case "B_soldier_exp_F": 
		{
comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addVest "V_PlateCarrierIAGL_oli";
for "_i" from 1 to 4 do {_unit addItemToVest "APERSMine_Range_Mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_556x45_Stanag_Tracer_Red";};
_unit addBackpack "B_Carryall_mcamo";
_unit addItemToBackpack "ToolKit";
_unit addItemToBackpack "MineDetector";
for "_i" from 1 to 4 do {_unit addItemToBackpack "APERSBoundingMine_Range_Mag";};
for "_i" from 1 to 3 do {_unit addItemToBackpack "ClaymoreDirectionalMine_Remote_Mag";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "SLAMDirectionalMine_Wire_Mag";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "DemoCharge_Remote_Mag";};
_unit addHeadgear "H_HelmetB_camo";

comment "Add weapons";
_unit addWeapon "arifle_SPAR_01_blk_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Holosight_blk_F";
_unit addWeapon "hgun_Pistol_heavy_01_F";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "NVGoggles_OPFOR";

		};	
    case "B_soldier_AA_F": 
		{
comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addVest "V_PlateCarrier1_rgr_noflag_F";
_unit addItemToVest "FirstAidKit";
for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_556x45_Stanag_Tracer_Red";};
_unit addBackpack "B_Kitbag_mcamo";
_unit addItemToBackpack "FirstAidKit";
_unit addItemToBackpack "Titan_AA";
_unit addHeadgear "H_HelmetB_camo";

comment "Add weapons";
_unit addWeapon "arifle_SPAR_01_blk_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Holosight_blk_F";
_unit addWeapon "launch_B_Titan_F";
_unit addSecondaryWeaponItem "acc_pointer_IR";
_unit addWeapon "hgun_Pistol_heavy_01_F";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "NVGoggles_OPFOR";

		};	
    case "B_soldier_UAV_F": 
		{
comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addVest "V_PlateCarrier1_rgr_noflag_F";
_unit addItemToVest "FirstAidKit";
for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_556x45_Stanag_Tracer_Red";};
_unit addBackpack "B_UAV_01_backpack_F";
_unit addHeadgear "H_HelmetB_camo";

comment "Add weapons";
_unit addWeapon "arifle_SPAR_01_blk_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Hamr";
_unit addWeapon "hgun_Pistol_heavy_01_F";
_unit addWeapon "Laserdesignator_03";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "B_UavTerminal";
_unit linkItem "NVGoggles_OPFOR";

		};				
    case "B_CTRG_Soldier_tna_F": 
		{
comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_B_CTRG_Soldier_F";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addVest "V_PlateCarrier1_rgr_noflag_F";
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_556x45_Stanag_red";};
_unit addBackpack "B_AssaultPack_rgr";
for "_i" from 1 to 8 do {_unit addItemToBackpack "DemoCharge_Remote_Mag";};
_unit addHeadgear "H_HelmetB_TI_tna_F";
_unit addGoggles "G_Balaclava_TI_G_tna_F";

comment "Add weapons";
_unit addWeapon "arifle_SPAR_01_khk_F";
_unit addPrimaryWeaponItem "muzzle_snds_m_khk_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Hamr_khk_F";
_unit addWeapon "hgun_Pistol_heavy_01_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "acc_flashlight_pistol";
_unit addHandgunItem "optic_MRD";
_unit addWeapon "Binocular";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
_unit linkItem "NVGogglesB_grn_F";

		};			
    case "B_Soldier_TL_F": 
		{
comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 3 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addItemToUniform "B_IR_Grenade";
_unit addVest "V_PlateCarrier1_rgr_noflag_F";
_unit addItemToVest "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_556x45_Stanag_Tracer_Red";};
_unit addBackpack "B_Kitbag_mcamo";
_unit addItemToBackpack "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToBackpack "SmokeShell";};
_unit addItemToBackpack "DemoCharge_Remote_Mag";
for "_i" from 1 to 6 do {_unit addItemToBackpack "30Rnd_556x45_Stanag_Tracer_Red";};
_unit addHeadgear "H_HelmetB_camo";

comment "Add weapons";
_unit addWeapon "arifle_SPAR_01_blk_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Hamr";
_unit addWeapon "hgun_Pistol_heavy_01_F";
_unit addWeapon "Binocular";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
_unit linkItem "NVGoggles_OPFOR";

		};	
    case "B_Soldier_SL_F": 
		{
comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addItemToUniform "FirstAidKit";
_unit addItemToUniform "B_IR_Grenade";
for "_i" from 1 to 3 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
_unit addVest "V_PlateCarrier1_rgr_noflag_F";
_unit addItemToVest "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
_unit addItemToVest "SmokeShell";
for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_556x45_Stanag_Tracer_Red";};
_unit addBackpack "B_Kitbag_mcamo";
_unit addItemToBackpack "FirstAidKit";
_unit addItemToBackpack "SmokeShell";
_unit addItemToBackpack "SmokeShellGreen";
_unit addItemToBackpack "SmokeShellRed";
_unit addItemToBackpack "DemoCharge_Remote_Mag";
for "_i" from 1 to 6 do {_unit addItemToBackpack "30Rnd_556x45_Stanag_Tracer_Red";};
_unit addHeadgear "H_HelmetB_camo";

comment "Add weapons";
_unit addWeapon "arifle_SPAR_01_blk_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Hamr";
_unit addWeapon "hgun_Pistol_heavy_01_F";
_unit addWeapon "Binocular";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
_unit linkItem "NVGoggles_OPFOR";


		};	
    case "O_Soldier_F": 
		{
comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_O_officer_noInsignia_hex_F";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "16Rnd_9x21_Mag";};
_unit addVest "V_TacVest_khk";
_unit addItemToVest "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_580x42_Mag_Tracer_F";};
_unit addBackpack "B_FieldPack_ocamo";
for "_i" from 1 to 2 do {_unit addItemToBackpack "FirstAidKit";};
_unit addHeadgear "H_HelmetO_ocamo";

comment "Add weapons";
_unit addWeapon "arifle_CTAR_blk_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_ACO_grn";
_unit addWeapon "hgun_Rook40_F";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "NVGoggles_OPFOR";

		};	
    case "O_Soldier_LAT_F": 
		{
comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_O_officer_noInsignia_hex_F";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "16Rnd_9x21_Mag";};
_unit addVest "V_TacVest_khk";
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_580x42_Mag_Tracer_F";};
_unit addBackpack "B_FieldPack_cbr_LAT";
for "_i" from 1 to 2 do {_unit addItemToBackpack "FirstAidKit";};
_unit addItemToBackpack "RPG32_F";
for "_i" from 1 to 2 do {_unit addItemToBackpack "RPG32_HE_F";};
_unit addHeadgear "H_HelmetO_ocamo";

comment "Add weapons";
_unit addWeapon "arifle_CTAR_blk_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_ACO_grn";
_unit addWeapon "launch_RPG32_F";
_unit addWeapon "hgun_Rook40_F";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "NVGoggles_OPFOR";

		};	
    case "O_Soldier_GL_F": 
		{
comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_O_officer_noInsignia_hex_F";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "16Rnd_9x21_Mag";};
_unit addVest "V_TacVest_khk";
_unit addItemToVest "FirstAidKit";
for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_580x42_Mag_Tracer_F";};
_unit addBackpack "B_FieldPack_ocamo";
_unit addItemToBackpack "FirstAidKit";
for "_i" from 1 to 14 do {_unit addItemToBackpack "1Rnd_HE_Grenade_shell";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "1Rnd_Smoke_Grenade_shell";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "1Rnd_SmokeRed_Grenade_shell";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "UGL_FlareWhite_F";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "UGL_FlareRed_F";};
_unit addHeadgear "H_HelmetLeaderO_ocamo";

comment "Add weapons";
_unit addWeapon "arifle_CTAR_GL_blk_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_ACO_grn";
_unit addWeapon "hgun_Rook40_F";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "NVGoggles_OPFOR";

		};	
    case "O_Soldier_AR_F": 
		{
comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_O_officer_noInsignia_hex_F";
_unit addItemToUniform "FirstAidKit";
_unit addVest "V_TacVest_khk";
for "_i" from 1 to 2 do {_unit addItemToVest "150Rnd_762x54_Box_Tracer";};
_unit addBackpack "B_FieldPack_ocamo";
for "_i" from 1 to 2 do {_unit addItemToBackpack "FirstAidKit";};
_unit addItemToBackpack "150Rnd_762x54_Box_Tracer";
for "_i" from 1 to 2 do {_unit addItemToBackpack "HandGrenade";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "SmokeShell";};
_unit addHeadgear "H_HelmetO_ocamo";

comment "Add weapons";
_unit addWeapon "LMG_Zafir_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_ERCO_blk_F";
_unit addWeapon "hgun_Rook40_F";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "NVGoggles_OPFOR";

		};	
    case "O_medic_F": 
		{
comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_O_officer_noInsignia_hex_F";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "16Rnd_9x21_Mag";};
_unit addVest "V_TacVest_khk";
_unit addItemToVest "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShellRed";};
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_580x42_Mag_Tracer_F";};
_unit addBackpack "B_FieldPack_ocamo_Medic";
_unit addItemToBackpack "Medikit";
for "_i" from 1 to 10 do {_unit addItemToBackpack "FirstAidKit";};
_unit addHeadgear "H_HelmetO_ocamo";

comment "Add weapons";
_unit addWeapon "arifle_CTAR_blk_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_ACO_grn";
_unit addWeapon "hgun_Rook40_F";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "NVGoggles_OPFOR";

		};	
    case "O_sniper_F": 
		{
comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_O_GhillieSuit";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "16Rnd_9x21_Mag";};
_unit addVest "V_Chestrig_khk";
_unit addItemToVest "FirstAidKit";
for "_i" from 1 to 6 do {_unit addItemToVest "10Rnd_93x64_DMR_05_Mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
_unit addBackpack "B_FieldPack_ocamo";
for "_i" from 1 to 2 do {_unit addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "APERSTripMine_Wire_Mag";};
for "_i" from 1 to 5 do {_unit addItemToBackpack "10Rnd_93x64_DMR_05_Mag";};

comment "Add weapons";
_unit addWeapon "srifle_DMR_05_hex_F";
_unit addPrimaryWeaponItem "muzzle_snds_93mmg_tan";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_LRPS";
_unit addPrimaryWeaponItem "bipod_02_F_hex";
_unit addWeapon "hgun_Rook40_F";
_unit addHandgunItem "muzzle_snds_L";
_unit addWeapon "Rangefinder";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
_unit linkItem "NVGoggles_OPFOR";

		};	
    case "O_Soldier_AT_F": 
		{
comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_O_officer_noInsignia_hex_F";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "16Rnd_9x21_Mag";};
_unit addVest "V_TacVest_khk";
_unit addItemToVest "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_580x42_Mag_Tracer_F";};
_unit addBackpack "B_FieldPack_ocamo";
_unit addItemToBackpack "Titan_AT";
_unit addHeadgear "H_HelmetO_ocamo";

comment "Add weapons";
_unit addWeapon "arifle_CTAR_blk_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_ACO_grn";
_unit addWeapon "launch_O_Titan_short_F";
_unit addSecondaryWeaponItem "acc_pointer_IR";
_unit addWeapon "hgun_Rook40_F";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "NVGoggles_OPFOR";

		};	
    case "O_HeavyGunner_F": 
		{
comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_O_officer_noInsignia_hex_F";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "16Rnd_9x21_Mag";};
_unit addItemToUniform "SmokeShell";
_unit addItemToUniform "SmokeShellRed";
for "_i" from 1 to 2 do {_unit addItemToUniform "Chemlight_red";};
_unit addVest "V_TacVest_khk";
_unit addItemToVest "150Rnd_93x64_Mag";
_unit addBackpack "B_FieldPack_ocamo";
_unit addHeadgear "H_HelmetO_ocamo";

comment "Add weapons";
_unit addWeapon "MMG_01_hex_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Arco";
_unit addPrimaryWeaponItem "bipod_02_F_hex";
_unit addWeapon "hgun_Rook40_F";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "NVGoggles_OPFOR";
		};	
    case "O_engineer_F": 
		{
comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_O_officer_noInsignia_hex_F";
_unit addItemToUniform "FirstAidKit";
_unit addVest "V_TacVest_khk";
for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_580x42_Mag_Tracer_F";};
for "_i" from 1 to 2 do {_unit addItemToVest "16Rnd_9x21_Mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
_unit addBackpack "B_Carryall_ocamo_Eng";
_unit addItemToBackpack "ToolKit";
_unit addItemToBackpack "MineDetector";
_unit addItemToBackpack "SatchelCharge_Remote_Mag";
for "_i" from 1 to 5 do {_unit addItemToBackpack "DemoCharge_Remote_Mag";};
_unit addHeadgear "H_HelmetO_ocamo";

comment "Add weapons";
_unit addWeapon "arifle_CTAR_blk_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_ACO_grn";
_unit addWeapon "hgun_Rook40_F";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "NVGoggles_OPFOR";

		};	
    case "O_soldier_M_F": 
		{
comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_O_officer_noInsignia_hex_F";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 3 do {_unit addItemToUniform "10Rnd_762x54_Mag";};
_unit addVest "V_TacVest_khk";
for "_i" from 1 to 7 do {_unit addItemToVest "10Rnd_762x54_Mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "16Rnd_9x21_Mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
_unit addBackpack "B_FieldPack_ocamo";
for "_i" from 1 to 2 do {_unit addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 15 do {_unit addItemToBackpack "10Rnd_762x54_Mag";};
_unit addHeadgear "H_HelmetO_ocamo";

comment "Add weapons";
_unit addWeapon "srifle_DMR_01_F";
_unit addPrimaryWeaponItem "optic_DMS";
_unit addPrimaryWeaponItem "bipod_02_F_hex";
_unit addWeapon "hgun_Rook40_F";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "NVGoggles_OPFOR";

		};
    case "O_soldier_exp_F": 
		{
comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_O_officer_noInsignia_hex_F";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "16Rnd_9x21_Mag";};
_unit addVest "V_TacVest_khk";
for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_580x42_Mag_Tracer_F";};
for "_i" from 1 to 2 do {_unit addItemToVest "APERSMine_Range_Mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
_unit addBackpack "B_Carryall_ocamo_Exp";
_unit addItemToBackpack "ToolKit";
_unit addItemToBackpack "MineDetector";
for "_i" from 1 to 4 do {_unit addItemToBackpack "APERSBoundingMine_Range_Mag";};
for "_i" from 1 to 3 do {_unit addItemToBackpack "ClaymoreDirectionalMine_Remote_Mag";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "SLAMDirectionalMine_Wire_Mag";};
_unit addItemToBackpack "DemoCharge_Remote_Mag";
_unit addItemToBackpack "APERSMine_Range_Mag";
_unit addHeadgear "H_HelmetO_ocamo";

comment "Add weapons";
_unit addWeapon "arifle_CTAR_blk_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_ACO_grn";
_unit addWeapon "hgun_Rook40_F";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "NVGoggles_OPFOR";
		};
    case "O_Soldier_AA_F": 
		{
comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_O_officer_noInsignia_hex_F";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "16Rnd_9x21_Mag";};
_unit addVest "V_TacVest_khk";
_unit addItemToVest "FirstAidKit";
for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_580x42_Mag_Tracer_F";};
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
_unit addBackpack "B_FieldPack_ocamo_AA";
_unit addItemToBackpack "FirstAidKit";
_unit addItemToBackpack "Titan_AA";
_unit addHeadgear "H_HelmetO_ocamo";

comment "Add weapons";
_unit addWeapon "arifle_CTAR_blk_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_ACO_grn";
_unit addWeapon "launch_O_Titan_F";
_unit addSecondaryWeaponItem "acc_pointer_IR";
_unit addWeapon "hgun_Rook40_F";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "NVGoggles_OPFOR";

		};
    case "O_soldier_UAV_F": 
		{
comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_O_officer_noInsignia_hex_F";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "16Rnd_9x21_Mag";};
_unit addVest "V_TacVest_khk";
_unit addItemToVest "FirstAidKit";
for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_580x42_Mag_Tracer_F";};
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
_unit addBackpack "O_UAV_01_backpack_F";
_unit addHeadgear "H_HelmetO_ocamo";

comment "Add weapons";
_unit addWeapon "arifle_CTAR_blk_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_ACO_grn";
_unit addWeapon "hgun_Rook40_F";
_unit addWeapon "Laserdesignator";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "O_UavTerminal";
_unit linkItem "NVGoggles_OPFOR";

		};
    case "O_V_Soldier_hex_F": 
		{
comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_O_V_Soldier_Viper_hex_F";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "16Rnd_9x21_Mag";};
_unit addBackpack "B_ViperHarness_hex_M_F";
for "_i" from 1 to 3 do {_unit addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "SmokeShell";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "HandGrenade";};
for "_i" from 1 to 8 do {_unit addItemToBackpack "DemoCharge_Remote_Mag";};
for "_i" from 1 to 6 do {_unit addItemToBackpack "30Rnd_65x39_caseless_green";};
_unit addHeadgear "H_HelmetO_ViperSP_hex_F";
_unit addGoggles "G_Shades_Red";

comment "Add weapons";
_unit addWeapon "arifle_ARX_hex_F";
_unit addPrimaryWeaponItem "muzzle_snds_65_TI_hex_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Arco";
_unit addWeapon "hgun_Rook40_F";
_unit addHandgunItem "muzzle_snds_L";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";

		};
    case "O_Soldier_TL_F": 
		{
comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_O_officer_noInsignia_hex_F";
_unit addItemToUniform "FirstAidKit";
_unit addVest "V_TacVest_khk";
_unit addItemToVest "FirstAidKit";
for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_580x42_Mag_Tracer_F";};
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
_unit addBackpack "B_FieldPack_ocamo";
_unit addItemToBackpack "FirstAidKit";
for "_i" from 1 to 20 do {_unit addItemToBackpack "1Rnd_HE_Grenade_shell";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "UGL_FlareWhite_F";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "UGL_FlareRed_F";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "1Rnd_SmokeRed_Grenade_shell";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "1Rnd_Smoke_Grenade_shell";};
_unit addHeadgear "H_HelmetLeaderO_ocamo";

comment "Add weapons";
_unit addWeapon "arifle_CTAR_blk_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Arco_blk_F";
_unit addWeapon "hgun_Rook40_F";
_unit addWeapon "Binocular";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
_unit linkItem "NVGoggles_OPFOR";

		};
    case "O_Soldier_SL_F": 
		{
comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "U_O_officer_noInsignia_hex_F";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "30Rnd_580x42_Mag_Tracer_F";};
for "_i" from 1 to 2 do {_unit addItemToUniform "Chemlight_red";};
_unit addVest "V_TacVest_khk";
for "_i" from 1 to 3 do {_unit addItemToVest "30Rnd_580x42_Mag_Tracer_F";};
for "_i" from 1 to 2 do {_unit addItemToVest "16Rnd_9x21_Mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 2 do {_unit addItemToVest "O_IR_Grenade";};
_unit addItemToVest "SmokeShell";
_unit addItemToVest "SmokeShellRed";
_unit addItemToVest "SmokeShellOrange";
_unit addItemToVest "SmokeShellYellow";
_unit addBackpack "B_FieldPack_ocamo";
_unit addHeadgear "H_HelmetLeaderO_ocamo";

comment "Add weapons";
_unit addWeapon "arifle_CTAR_blk_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Arco_blk_F";
_unit addWeapon "hgun_Rook40_F";
_unit addWeapon "Binocular";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
_unit linkItem "NVGoggles_OPFOR";

		};	
};

