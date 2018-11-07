//Check running mods

//Param check
_Mod = "Mod" call BIS_fnc_getParamValue;


//MOD CHECK 
DIS_MODRUN = false;

//ACE CHECK
if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {ACEACTIVATED = true;DIS_MODRUN = true;} else {ACEACTIVATED = false;};

//RHS CHECK - THIS INCLUDES THE AFRF
if (isClass(configFile >> "CfgPatches" >> "rhs_main")) then {RHSACTIVATED = true;DIS_MODRUN = true;} else {RHSACTIVATED = false;};

//RHS GREF CHECK
if (isClass(configFile >> "CfgPatches" >> "rhsgref_main")) then {RHSGACTIVATED = true;DIS_MODRUN = true;} else {RHSGACTIVATED = false;};

//RHS SAF CHECK
if (isClass(configFile >> "CfgPatches" >> "rhssaf_main")) then {RHSSACTIVATED = true;DIS_MODRUN = true;} else {RHSSACTIVATED = false;};

//RHS USF CHECK
if (isClass(configFile >> "CfgPatches" >> "rhsusf_main")) then {RHSUACTIVATED = true;DIS_MODRUN = true;} else {RHSUACTIVATED = false;};

//LIBERATION LITE CHECK
if (isClass(configFile >> "CfgPatches" >> "LIB_core")) then {LIBACTIVATED = true;DIS_MODRUN = true;} else {LIBACTIVATED = false;};

//FOW CHECK
if (isClass(configFile >> "CfgPatches" >> "fow_main")) then {FOWACTIVATED = true;DIS_MODRUN = true;} else {FOWACTIVATED = false;};


//UNSUNG check
if (isClass(configFile >> "CfgPatches" >> "UNS_Patches")) then {UNSUNGACTIVATED = true;DIS_MODRUN = true;} else {UNSUNGACTIVATED = false;};


/*

_Oil = W_RArray select 0;
_Power = W_RArray select 1;
_Cash = W_RArray select 2;
_Materials = W_RArray select 3;

*/

W_HighProfile = ["B_Story_SF_Captain_F"];
E_HighProfile = ["O_A_soldier_TL_F"];
R_HighProfile = ["I_Story_Officer_01_F"];
//Land_SatelliteAntenna_01_F
//B_SAM_System_02_F
DIS_SAMTURRETS = ["B_SAM_System_01_F","B_AAA_System_01_F","B_SAM_System_02_F"];

DIS_MinesList = 
[
"SLAMDirectionalMine_Wire_Mag",
"ATMine_Range_Mag",
"APERSTripMine_Wire_Mag",
"APERSMineDispenser_Mag",
"APERSMine_Range_Mag",
"APERSBoundingMine_Range_Mag",
"ClaymoreDirectionalMine_Remote_Mag",
"SatchelCharge_Remote_Mag",
"DemoCharge_Remote_Mag"
];

//Add units into the arrays!
//UNSUNG MOD
if (UNSUNGACTIVATED && (_Mod isEqualTo 4)) then
{
	//Other important variables to be set here.
	//Blufor units using UNSUNG

	
	
	W_BarrackU = [["uns_US_1ID_RF1",[0,0,0,5]],["uns_US_1ID_RF2",[0,0,0,5]],["uns_US_1ID_RF3",[0,0,0,5]],["uns_US_1ID_RF4",[0,0,0,5]],["uns_US_1ID_RF5",[0,0,0,5]],["uns_US_1ID_RF6",[0,0,0,5]],["uns_US_1ID_MED",[0,0,0,5]],["uns_US_1ID_CAS",[0,0,0,5]],["uns_US_1ID_AT",[0,0,0,5]],["uns_US_1ID_STY",[0,0,0,5]],["uns_US_1ID_STY3",[0,0,0,5]],["uns_US_1ID_STY2",[0,0,0,5]],["uns_US_1ID_SL",[0,0,0,5]]];

	W_LFactU = [["uns_willysmg50",[5,0,0,60]],["uns_willysm40",[10,0,0,40]],["uns_willysmg",[10,0,0,40]],["uns_willys_2_m60",[10,0,0,40]],["uns_willys_2_m1919",[10,0,0,40]],["uns_m37b1_m1919",[10,0,0,40]],["uns_xm706e1",[10,0,0,40]],["uns_xm706e2",[10,0,0,40]]];

	W_HFactU = [["uns_M113_30cal",[10,10,0,60]],["uns_M113_M134",[10,10,0,60]],["uns_M113_M2",[10,10,0,60]],["uns_M113_M60",[10,10,0,60]],["uns_M113_XM182",[10,10,0,60]],["uns_M113A1_M134",[10,10,0,60]],["uns_M113A1_M2",[10,10,0,60]],["uns_M113A1_M40",[10,10,0,60]],["uns_M113A1_M60",[10,10,0,60]],["uns_M113A1_XM182",[10,10,0,60]],["uns_M132",[10,10,0,60]],["uns_m48a3",[30,30,0,200]],["uns_m551",[30,30,0,200]],["uns_M67A",[30,30,0,200]]];
	

	W_AirU = [["uns_A1J_MR",[50,25,0,300]],["uns_A7_MR",[10,0,0,300]],["uns_AC47",[10,0,0,300]],["uns_F4E_CHICO",[10,0,0,300]],["uns_f100b_MR",[10,0,0,300]],["uns_f105F_MR",[10,0,0,300]],["UNS_F111_MR",[10,0,0,300]],["UNS_F111_D_MR",[10,0,0,300]],["uns_F4E_MR",[10,0,0,300]],["UNS_skymaster_MR",[10,0,0,300]],["uns_UH1F_M21_M158_Hornet",[10,0,0,300]],["uns_UH1F_M6_M158_Hornet",[10,0,0,300]]];

	W_AdvU = [["uns_US_1ID_ENG",[0,0,0,20]],["uns_US_1ID_GL",[0,0,0,20]],["uns_US_1ID_TRI",[0,0,0,20]],["uns_US_1ID_HMG",[0,0,0,20]],["uns_US_1ID_MRK3",[0,0,0,20]],["uns_US_1ID_MRK2",[0,0,0,20]],["uns_US_1ID_MRK",[0,0,0,20]],["uns_US_1ID_MGAASG",[0,0,0,20]],["uns_US_1ID_MTSG",[0,0,0,20]],["uns_US_1ID_SAP",[0,0,0,20]],["uns_US_1ID_RTO",[0,0,0,20]],["uns_US_1ID_SCT",[0,0,0,20]]];
	
	W_StaticWeap = [["uns_m163",[25,25,0,25]],["Uns_M55_Quad",[25,25,0,25]],["uns_M1_81mm_mortar",[25,25,0,25]],["uns_M1_81mm_mortar_arty",[25,25,0,25]],["Uns_M102_artillery",[25,25,0,25]],["uns_m107sp",[25,25,0,25]],["uns_m110sp",[25,25,0,25]],["Uns_M114_artillery",[25,25,0,25]],["uns_M2_60mm_mortar",[25,25,0,25]],["uns_M30_107mm_mortar",[25,25,0,25]],["uns_m2_high",[25,25,0,25]],["uns_M40_106mm_US",[25,25,0,25]],["uns_m60_high",[25,25,0,25]],["uns_m60_bunker_large",[25,25,0,25]],["uns_m60_bunker_small",[25,25,0,25]],["uns_US_MK18_low",[25,25,0,25]],["uns_US_SearchLight",[25,25,0,25]]];
	
	W_TeamLU = [["uns_US_1ID_SL",[0,0,0,5]]];
	
	W_SquadLU = [["uns_US_1ID_PL",[0,0,0,5]]];
	
	W_MedU = [["uns_US_1ID_MED",[0,0,0,10]]];	
	
	W_TransportUnit = ["uns_UH1F_M21_M158_Hornet"];
	
	//Opfor units using UNSUNG	
	E_BarrackU = [["uns_men_NVA_daccong_AT3",[0,0,0,5]],["uns_men_NVA_daccong_AS6",[0,0,0,10]],["uns_men_NVA_daccong_AS3",[0,0,0,10]],["uns_men_NVA_daccong_AS2",[0,0,0,10]],["uns_men_NVA_daccong_AS1",[0,0,0,10]],["uns_men_NVA_daccong_LMG",[0,0,0,10]],["uns_men_NVA_daccong_cov6",[0,0,0,10]],["uns_men_NVA_daccong_MED",[0,0,0,10]],["uns_men_NVA_daccong_AT2",[0,0,0,10]]];

	E_LFactU = [["uns_BTR152_ZPU",[5,0,0,40]],["uns_Type55_ZU",[10,0,0,40]],["uns_nvatruck_type65",[15,0,0,5]],["uns_nvatruck_zpu",[15,0,0,5]],["uns_nvatruck_zu23",[15,0,0,5]],["uns_BTR152_DSHK",[15,0,0,5]],["uns_Type55_RR57",[15,0,0,5]],["uns_Type55_RR73",[15,0,0,5]],["uns_Type55_MG",[15,0,0,5]],["uns_Type55_M40",[15,0,0,5]],["uns_Type55_patrol",[15,0,0,5]],["uns_Type55_LMG",[15,0,0,5]],["uns_Type55_twinMG",[15,0,0,5]]];
	
	E_HFactU = [["uns_ot34_85_nva",[20,20,0,200]],["uns_t34_85_nva",[20,20,0,200]],["uns_t54_nva",[20,20,0,200]],["uns_t55_nva",[20,20,0,200]],["uns_to55_nva",[20,20,0,200]],["uns_Type63_mg",[20,20,0,200]],["pook_ZSU_NVA",[20,20,0,200]],["pook_ZSU57_NVA",[20,20,0,200]]];	
	
	E_AirU = [["uns_an2_cas",[10,0,0,70]],["uns_mig21_MR",[10,0,0,70]],["uns_Mig21_AGM",[10,0,0,70]],["uns_Mig21_CAS",[10,0,0,70]]];   
	
	E_MedU = [["uns_men_NVA_daccong_MED",[0,0,0,10]]];
	
	E_AdvU = [["uns_men_NVA_daccong_AA1",[0,0,0,20]],["uns_men_NVA_daccong_AT",[0,0,0,20]],["uns_men_NVA_daccong_AS5",[0,0,0,20]],["uns_men_NVA_daccong_AS4",[0,0,0,10]],["uns_men_NVA_daccong_COM",[0,0,0,10]],["uns_men_NVA_daccong_cov2",[0,0,0,10]],["uns_men_NVA_daccong_cov3",[0,0,0,10]],["uns_men_NVA_daccong_cov1",[0,0,0,10]],["uns_men_NVA_daccong_cov5",[0,0,0,10]],["uns_men_NVA_daccong_cov7",[0,0,0,10]],["uns_men_NVA_daccong_cov4",[0,0,0,10]],["uns_men_NVA_daccong_MGS",[0,0,0,10]],["uns_men_NVA_daccong_HMG",[0,0,0,10]],["uns_men_NVA_daccong_MTS",[0,0,0,10]],["uns_men_NVA_daccong_nco",[0,0,0,10]],["uns_men_NVA_daccong_off",[0,0,0,10]],["uns_men_NVA_daccong_MRK",[0,0,0,10]],["uns_men_NVA_daccong_TRI",[0,0,0,10]]];
	
	E_TeamLU = [["uns_men_NVA_daccong_nco",[0,0,0,5]]];
	
	E_SquadLU = [["uns_men_NVA_daccong_off",[0,0,0,5]]];
	
	E_StaticWeap = [["Uns_D20_artillery",[25,25,0,25]],["Uns_D30_artillery",[25,25,0,25]],["uns_m1941_82mm_mortarNVA_arty",[25,25,0,25]],["uns_m1941_82mm_mortarNVA",[25,25,0,25]],["uns_Type55_mortar",[25,25,0,25]],["pook_KS12_NVA",[25,25,0,25]],["pook_KS19_NVA",[25,25,0,25]],["pook_S60_NVA",[25,25,0,25]],["uns_S60_NVA",[25,25,0,25]],["uns_Type74_NVA",[25,25,0,25]],["uns_ZPU4_NVA",[25,25,0,25]],["pook_ZU23_NVA",[25,25,0,25]],["uns_ZU23_NVA",[25,25,0,25]],["uns_dshk_armoured_NVA",[25,25,0,25]],["uns_dshk_high_NVA",[25,25,0,25]],["uns_dshk_twin_NVA",[25,25,0,25]],["uns_dshk_bunker_closed_NVA",[25,25,0,25]],["uns_dshk_bunker_open_NVA",[25,25,0,25]],["uns_M40_106mm_NVA",[25,25,0,25]],["uns_pk_high_NVA",[25,25,0,25]],["uns_pk_bunker_low_NVA",[25,25,0,25]],["uns_pk_bunker_open_NVA",[25,25,0,25]],["uns_NVA_SearchLight",[25,25,0,25]],["uns_SPG9_73mm_NVA",[25,25,0,25]],["uns_spiderhole_NVA",[25,25,0,25]],["uns_spiderhole_leanto_NVA",[25,25,0,25]],["uns_dshk_twin_bunker_closed_NVA",[25,25,0,25]],["uns_Type36_57mm_NVA",[25,25,0,25]]];
	
	E_TransportUnit = ["uns_Mi8TV_VPAF_MG"];
	
	//resistance side for UNSUNG
	R_BarrackLU = ["uns_men_CIDG_AS2","uns_men_CIDG_AS1","uns_men_CIDG_AS3","uns_men_CIDG_AT","uns_men_CIDG_S7","uns_men_CIDG_S8","uns_men_CIDG_S9","uns_men_CIDG_S12","uns_men_CIDG_HMG","uns_men_CIDG_MRK2","uns_men_CIDG_MRK3","uns_men_CIDG_MRK","uns_men_CIDG_S10","uns_men_CIDG_S3","uns_men_CIDG_S1"];

	R_LFactU = ["uns_willys_2_m60_arvn","uns_willys_2_m1919_arvn","uns_xm706"];
	
	R_StaticWeap = ["uns_dshk_armoured_NVA","uns_dshk_high_NVA","uns_dshk_twin_NVA","uns_dshk_bunker_closed_NVA","uns_dshk_bunker_open_NVA","uns_M40_106mm_NVA","uns_pk_high_NVA","uns_pk_bunker_low_NVA","uns_pk_bunker_open_NVA","uns_NVA_SearchLight","uns_SPG9_73mm_NVA","uns_spiderhole_leanto_NVA","uns_dshk_twin_bunker_closed_NVA","uns_Type36_57mm_NVA","uns_spiderhole_NVA"];	
	
	R_LFactDef = ["uns_willys_2_m60_arvn","uns_willys_2_m1919_arvn","uns_xm706"];
	
	R_HFactU = ["uns_t34_76_vc"];
	
	R_BarrackHU = ["uns_men_CIDG_AS2","uns_men_CIDG_AS1","uns_men_CIDG_AS3","uns_men_CIDG_AT","uns_men_CIDG_S7","uns_men_CIDG_S8","uns_men_CIDG_S9","uns_men_CIDG_S12","uns_men_CIDG_HMG","uns_men_CIDG_MRK2","uns_men_CIDG_MRK3","uns_men_CIDG_MRK","uns_men_CIDG_S10","uns_men_CIDG_S3","uns_men_CIDG_S1"];
	
	R_AirU = ["uns_A1H_MR"];

	R_TransportUnit = ["uns_ch34_VNAF"];
};

		
if (RHSACTIVATED && (_Mod isEqualTo 1)) then
{
	//Other important variables to be set here.
	//Blufor units using RHS
	W_BarrackU = [["rhsusf_army_ocp_rifleman",[0,0,0,5]],["rhsusf_army_ocp_riflemanat",[0,0,0,10]],["rhsusf_army_ocp_marksman",[0,0,0,10]]];
	W_LFactU = [["rhsusf_m1025_w_mk19",[5,0,0,60]],["rhsusf_m1025_w_m2",[10,0,0,40]],["rhsusf_m113_usarmy",[10,0,0,40]],["rhsusf_m113_usarmy_MK19",[10,0,0,40]],["rhsusf_m113_usarmy_M240",[10,0,0,40]]];
	W_HFactU = [["rhsusf_M1117_W",[10,10,0,60]],["rhsusf_m1a1aimwd_usarmy",[20,20,0,120]],["rhsusf_m1a1aim_tuski_wd",[20,20,0,140]],["rhsusf_m1a2sep1wd_usarmy",[20,20,0,160]],["rhsusf_m1a2sep1tuskiwd_usarmy",[20,25,0,180]],["rhsusf_m1a2sep1tuskiiwd_usarmy",[30,30,0,200]]];
	W_AirU = [["RHS_AH64D_wd",[50,25,0,300]],["RHS_AH64D_wd_GS",[10,0,0,300]],["RHS_AH64D_wd_CS",[10,0,0,300]],["RHS_AH64D_wd_AA",[10,0,0,300]],["RHS_A10",[10,0,0,300]],["rhsusf_f22",[10,0,0,300]],["RHS_AH64D_wd_AA",[10,0,0,300]]];
	W_MedU = [["rhsusf_army_ocp_medic",[0,0,0,10]]];
	W_AdvU = [["rhsusf_army_ucp_sniper_m107",[0,0,0,20]],["rhsusf_army_ucp_sniper",[0,0,0,20]],["rhsusf_army_ucp_sniper_m24sws",[0,0,0,20]],["rhsusf_army_ucp_machinegunner",[0,0,0,20]],["rhsusf_army_ucp_rifleman_m590",[0,0,0,20]],["rhsusf_army_ucp_grenadier",[0,0,0,20]],["rhsusf_army_ucp_explosives",[0,0,0,20]],["rhsusf_army_ucp_aa",[0,0,0,20]]];
	W_TeamLU = [["rhsusf_army_ucp_teamleader",[0,0,0,5]]];
	W_SquadLU = [["rhsusf_army_ucp_squadleader",[0,0,0,5]]];
	W_StaticWeap = [["RHS_Stinger_AA_pod_WD",[10,10,0,10]],["RHS_MK19_TriPod_WD",[10,10,0,10]],["RHS_TOW_TriPod_WD",[10,10,0,10]],["RHS_M2StaticMG_MiniTripod_WD",[10,10,0,10]],["B_SAM_System_01_F",[25,25,0,25]],["B_AAA_System_01_F",[25,25,0,25]],["B_SAM_System_02_F",[25,25,0,25]],["B_Radar_System_01_F",[25,25,0,25]],["B_SAM_System_03_F",[25,25,0,25]],["B_SAM_System_03_F",[25,25,0,25]]];
	W_InfATSpecial = ["rhsusf_army_ucp_javelin","","","",""];
	W_VehATSpecial = [];
	W_InfAASpecial = ["","","","","","","","","","",""];
	W_VehAASpecial = [];
	
	//Opfor units using RHS
	E_BarrackU = [["rhs_msv_emr_rifleman",[0,0,0,5]],["rhs_msv_emr_at",[0,0,0,10]],["rhs_msv_emr_marksman",[0,0,0,10]]];
	E_LFactU = [["rhsgref_BRDM2UM_msv",[5,0,0,40]],["rhsgref_BRDM2_HQ_msv",[10,0,0,40]],["RHS_Ural_Zu23_MSV_01",[15,0,0,5]],["rhs_gaz66_zu23_msv",[15,0,0,5]]];
	E_HFactU = [["rhs_t90a_tv",[20,20,0,200]],["rhs_t80um",[20,20,0,200]],["rhs_t72bd_tv",[20,20,0,200]],["rhs_2s3_tv",[20,20,0,250]],["rhs_sprut_vdv",[20,20,0,120]]];
	E_AirU = [["RHS_Mi8mt_vdv",[10,0,0,70]],["RHS_Mi8MTV3_UPK23_vdv",[25,25,0,200]],["RHS_Mi8MTV3_FAB",[25,25,0,200]],["RHS_Mi24P_AT_vdv",[50,50,0,300]],["RHS_Mi24V_vdv",[50,50,0,300]],["RHS_Mi24V_AT_vdv",[50,50,0,300]],["RHS_Mi24P_vdv",[50,50,0,300]],["RHS_Mi24P_CAS_vdv",[50,50,0,300]],["RHS_T50_vvs_blueonblue",[50,50,0,300]],["RHS_Su25SM_vvs",[50,50,0,300]],["rhs_mig29sm_vvs",[50,50,0,300]]];   
	E_MedU = [["rhs_msv_emr_medic",[0,0,0,10]],["RHS_Mi8mt_vvs",[20,20,0,100]]];
	E_AdvU = [["rhs_msv_emr_machinegunner",[0,0,0,20]],["rhs_msv_emr_grenadier_rpg",[0,0,0,20]],["rhs_msv_emr_arifleman",[0,0,0,20]],["rhs_msv_emr_efreitor",[0,0,0,10]],["rhs_msv_grenadier",[0,0,0,10]],["rhs_msv_LAT",[0,0,0,10]],["rhs_msv_RShG2",[0,0,0,10]]];
	E_TeamLU = [["rhs_msv_emr_sergeant",[0,0,0,5]]];
	E_SquadLU = [["rhs_msv_emr_officer_armored",[0,0,0,5]]];
	E_StaticWeap = [["rhs_Igla_AA_pos_msv",[10,10,0,10]],["rhs_Kornet_9M133_2_msv",[10,10,0,10]],["rhs_KORD_high_msv",[10,10,0,10]],["RHS_AGS30_TriPod_MSV",[10,10,0,10]],["B_SAM_System_01_F",[25,25,0,25]],["B_AAA_System_01_F",[25,25,0,25]],["B_SAM_System_02_F",[25,25,0,25]],["O_Radar_System_02_F",[25,25,0,25]],["O_SAM_System_04_F",[25,25,0,25]]];

	//R_BarrackLU = ["I_C_Soldier_Bandit_7_F","I_C_Soldier_Bandit_3_F","I_C_Soldier_Bandit_2_F","I_C_Soldier_Bandit_5_F","I_C_Soldier_Bandit_6_F","I_C_Soldier_Bandit_1_F","I_C_Soldier_Bandit_4_F","I_C_Soldier_Bandit_8_F"];
	
	R_BarrackLU = ["rhsgref_nat_saboteur","rhsgref_nat_rifleman_vz58","rhsgref_nat_rifleman","rhsgref_nat_rifleman_mp44","rhsgref_nat_grenadier","rhsgref_nat_rifleman_aks74","rhsgref_nat_rifleman_akms","rhsgref_nat_militiaman_kar98k","rhsgref_nat_medic","rhsgref_nat_machinegunner_mg42","rhsgref_nat_machinegunner","rhsgref_nat_hunter","rhsgref_nat_grenadier_rpg","rhsgref_nat_specialist_aa"];
	R_LFactU = ["rhsgref_nat_ural_Zu23","rhsgref_nat_uaz_ags","rhsgref_nat_uaz_spg9"];
	R_StaticWeap = ["rhsgref_cdf_Igla_AA_pod","rhsgref_cdf_AGS30_TriPod","rhsgref_cdf_DSHKM","rhsgref_cdf_NSV_TriPod","rhsgref_cdf_SPG9","rhsgref_cdf_SPG9M","RHSgref_cdf_ZU23","rhssaf_army_m252","rhssaf_army_d30"];	
	R_LFactDef = ["rhsgref_nat_ural_Zu23","rhsgref_nat_uaz_ags","rhsgref_nat_uaz_spg9","rhsgref_cdf_zsu234","rhsgref_cdf_btr70","rhsgref_cdf_btr60"];
	R_HFactU = ["rhsgref_cdf_btr70","rhsgref_cdf_btr60","rhsgref_BRDM2_ATGM","rhsgref_cdf_t80bv_tv","rhsgref_cdf_t80b_tv","rhsgref_cdf_t72bb_tv","rhsgref_cdf_t72ba_tv"];
	R_BarrackHU = ["rhsgref_cdf_ngd_grenadier_rpg","rhsgref_cdf_ngd_engineer","rhsgref_cdf_ngd_machinegunner","rhsgref_cdf_ngd_medic","rhsgref_cdf_ngd_squadleader","rhsgref_cdf_ngd_rifleman","rhsgref_cdf_ngd_grenadier","rhsgref_cdf_ngd_rifleman_m92"];
	R_AirU = ["I_Plane_Fighter_04_F","I_Plane_Fighter_03_dynamicLoadout_F","I_Heli_light_03_dynamicLoadout_F"];

	W_TransportUnit = ["B_Heli_Transport_01_F"];
	R_TransportUnit = ["I_Heli_light_03_unarmed_F"];
	E_TransportUnit = ["O_Heli_Light_02_unarmed_F"];	

};


//Liberation Lite Units

if (LIBACTIVATED && (_Mod isEqualTo 2)) then
{
	//Opfor units using LIB
	E_BarrackU = [["SG_sturmtrooper_rifleman",[0,0,0,5]],["SG_sturmtrooper_AT_soldier",[0,0,0,10]],["SG_sturmtrooper_mgunner",[0,0,0,10]]];
	E_LFactU = [["LIB_SdKfz_7_AA",[5,0,0,20]],["LIB_opelblitz_tent_y_camo",[5,0,0,20]],["LIB_Kfz1_MG42",[10,0,0,20]],["LIB_SdKfz_7",[5,0,0,20]],["LIB_SdKfz251",[5,0,0,20]],["LIB_SdKfz251_FFV",[5,0,0,40]],["LIB_opelblitz_open_y_camo",[10,0,0,40]],["LIB_opelblitz_parm",[5,0,0,60]]];
	E_HFactU = [["LIB_PzKpfwIV_H",[20,20,0,200]],["LIB_PzKpfwV",[20,20,0,200]],["LIB_PzKpfwVI_B",[20,20,0,200]],["LIB_PzKpfwVI_E_2",[20,20,0,250]]];
	E_AirU = [["LIB_DAK_FW190F8",[10,0,0,70]],["LIB_DAK_FW190F8_Desert2",[25,25,0,200]],["LIB_DAK_FW190F8_Desert3",[25,25,0,200]],["LIB_DAK_FW190F8_Desert",[50,50,0,300]],["LIB_DAK_Ju87_2",[50,50,0,300]],["LIB_DAK_Ju87",[50,50,0,300]]];
	E_MedU = [["SG_sturmtrooper_medic",[0,0,0,10]],["LIB_opelblitz_ambulance",[20,20,0,100]]];
	E_AdvU = [["SG_sturmtrooper_AT_grenadier",[0,0,0,20]],["SG_sturmtrooper_smgunner",[0,0,0,20]],["SG_sturmtrooper_ober_rifleman",[0,0,0,20]],["SG_sturmtrooper_sapper",[0,0,0,10]],["SG_sturmtrooper_sapper_gefr",[0,0,0,10]],["SG_sturmtrooper_sniper",[0,0,0,10]],["SG_sturmtrooper_stggunner",[0,0,0,10]]];
	E_TeamLU = [["SG_sturmtrooper_lieutenant",[0,0,0,5]]];
	E_SquadLU = [["SG_sturmtrooper_unterofficer",[0,0,0,5]]];
	E_StaticWeap = [["LIB_Flakvierling_38",[10,10,0,10]],["LIB_GrWr34",[10,10,0,10]],["LIB_MG42_lafette",[10,10,0,10]],["LIB_FlaK_38",[10,10,0,10]]];

	
	//Bluefor units using LIB
	W_BarrackU = [["LIB_US_Rangers_rifleman",[0,0,0,5]],["LIB_US_Rangers_AT_soldier",[0,0,0,10]],["LIB_US_Rangers_smgunner",[0,0,0,10]]];
	W_LFactU = [["LIB_US_M3_Halftrack",[5,0,0,60]],["LIB_US_GMC_Tent",[5,0,0,60]],["LIB_US_GMC_Parm",[10,0,0,40]],["LIB_US_Scout_M3_FFV",[10,0,0,40]],["LIB_US_Willys_MB",[10,0,0,40]],["LIB_US_Scout_M3",[10,0,0,40]]];
	W_HFactU = [["LIB_M3A3_Stuart",[10,10,0,60]],["LIB_M4A4_FIREFLY",[20,20,0,120]],["LIB_M5A1_Stuart",[20,20,0,140]],["LIB_M4A3_76_HVSS",[20,20,0,160]],["LIB_M4A3_75",[20,25,0,180]]];
	W_AirU = [["LIB_US_NAC_P39_2",[10,0,0,70]],["LIB_US_NAC_P39_3",[50,25,0,300]],["LIB_US_NAC_P39",[10,0,0,300]]];
	W_MedU = [["LIB_US_Rangers_medic",[0,0,0,10]]];
	W_AdvU = [["LIB_US_Rangers_mgunner",[0,0,0,20]],["LIB_US_Rangers_grenadier",[0,0,0,20]],["LIB_US_Rangers_engineer",[0,0,0,20]],["LIB_US_Rangers_sniper",[0,0,0,20]],["LIB_US_Rangers_FC_rifleman",[0,0,0,20]]];
	W_TeamLU = [["LIB_US_Rangers_lieutenant",[0,0,0,5]]];
	W_SquadLU = [["LIB_US_Rangers_captain",[0,0,0,5]]];
	W_StaticWeap = [["LIB_Zis3",[10,10,0,10]],["LIB_BM37",[10,10,0,10]],["LIB_61k",[10,10,0,10]],["LIB_Maxim_M30_base",[10,10,0,10]]];
	
	R_BarrackLU = ["LIB_SOV_AT_soldier","LIB_SOV_captain_summer","LIB_SOV_gun_lieutenant","LIB_SOV_mgunner","LIB_SOV_medic","LIB_SOV_rifleman","rhsgref_nat_rifleman_m92","LIB_SOV_p_officer","LIB_SOV_sergeant","LIB_SOV_scout_sniper","LIB_SOV_smgunner_summer"];
	R_LFactU = ["LIB_Zis5v_61K","LIB_US6_BM13","LIB_Scout_M3","LIB_US6_Open","LIB_US6_Tent","LIB_SOV_M3_Halftrack","LIB_SdKfz251_captured","LIB_SdKfz251_captured_FFV"];
	R_HFactU = ["LIB_T34_85"];
	R_StaticWeap = ["LIB_Maxim_M30_base","LIB_BM37","LIB_Zis3","LIB_61K"];	
	R_LFactDef = ["LIB_US6_BM13","LIB_SOV_M3_Halftrack","LIB_SdKfz251_captured","LIB_SdKfz251_captured_FFV","LIB_Zis5v_61K"];
	R_BarrackHU = [];
	R_AirU = ["LIB_Li2","LIB_P39","LIB_RA_P39_3","LIB_RA_P39_2","LIB_Pe2"];	
	//LIB_JS2_43
	
	W_TransportUnit = ["B_Heli_Transport_01_F"];
	R_TransportUnit = ["I_Heli_light_03_unarmed_F"];
	E_TransportUnit = ["O_Heli_Light_02_unarmed_F"];		
	
};

if (LIBACTIVATED && FOWACTIVATED && (_Mod isEqualTo 3)) then
{
	//Opfor units using LIB
	E_BarrackU = [["fow_s_ger_heer_rifleman_mp40_pzf",[0,0,0,5]],["fow_s_ger_heer_rifleman_mp40_pzf",[0,0,0,5]],["fow_s_ger_heer_rifleman",[0,0,0,5]],["fow_s_ger_heer_rifleman",[0,0,0,5]],["fow_s_ger_heer_radio_operator",[0,0,0,5]],["fow_s_ger_heer_rifleman",[0,0,0,5]],["fow_s_ger_heer_rifleman_g43",[0,0,0,5]]];
	E_LFactU = [["fow_v_sdkfz_234_1",[5,0,0,20]],["fow_v_sdkfz_222_foliage_ger_heer",[5,0,0,20]],["fow_v_sdkfz_250_camo_foliage_ger_heer",[5,0,0,20]],["fow_v_sdkfz_250_9_camo_foliage_ger_heer",[5,0,0,20]],["LIB_SdKfz_7_AA",[5,0,0,20]],["LIB_opelblitz_tent_y_camo",[5,0,0,20]],["LIB_Kfz1_MG42",[10,0,0,20]],["LIB_SdKfz_7",[5,0,0,20]],["LIB_SdKfz251",[5,0,0,20]],["LIB_SdKfz251_FFV",[5,0,0,40]],["LIB_opelblitz_open_y_camo",[10,0,0,40]],["LIB_opelblitz_parm",[5,0,0,60]]];
	E_HFactU = [["fow_v_panther_camo_foilage_ger_heer",[5,0,0,20]],["LIB_PzKpfwIV_H",[20,20,0,200]],["LIB_PzKpfwV",[20,20,0,200]],["LIB_PzKpfwVI_B",[20,20,0,200]],["LIB_PzKpfwVI_E_2",[20,20,0,250]]];
	E_AirU = [["LIB_DAK_FW190F8",[10,0,0,70]],["LIB_DAK_FW190F8_Desert2",[25,25,0,200]],["LIB_DAK_FW190F8_Desert3",[25,25,0,200]],["LIB_DAK_FW190F8_Desert",[50,50,0,300]],["LIB_DAK_Ju87_2",[50,50,0,300]],["LIB_DAK_Ju87",[50,50,0,300]]];
	E_MedU = [["SG_sturmtrooper_medic",[0,0,0,10]],["LIB_opelblitz_ambulance",[20,20,0,100]]];
	E_AdvU = [["fow_s_ger_heer_mg42_gunner",[0,0,0,20]],["fow_s_ger_heer_mg34_gunner",[0,0,0,20]],["fow_s_ger_heer_medic",[0,0,0,20]],["fow_s_ger_heer_rifleman_mp40",[0,0,0,10]],["fow_s_ger_heer_nco_mp40",[0,0,0,10]],["fow_s_ger_heer_tl_stg",[0,0,0,10]]];
	E_TeamLU = [["fow_s_ger_heer_nco_mp40",[0,0,0,5]]];
	E_SquadLU = [["fow_s_ger_heer_nco_mp40",[0,0,0,5]]];
	E_StaticWeap = [["fow_w_flak36_gray_ger_heer",[10,10,0,10]],["fow_w_mg42_deployed_s_ger_heer",[10,10,0,10]],["LIB_Flakvierling_38",[10,10,0,10]],["LIB_GrWr34",[10,10,0,10]],["LIB_MG42_lafette",[10,10,0,10]],["LIB_FlaK_38",[10,10,0,10]]];

	
	//Blufor units using LIB
	W_BarrackU = [["fow_s_us_m37_rifleman",[0,0,0,5]],["fow_s_us_m37_rifleman_gl",[0,0,0,10]],["fow_s_us_m37_rifleman_ithaca37",[0,0,0,10]],["fow_s_us_m37_rifleman_m1903",[0,0,0,10]],["fow_s_us_m37_rifleman_m1912",[0,0,0,10]],["fow_s_us_m37_at",[0,0,0,10]],["fow_s_us_m37_at",[0,0,0,10]]];
	W_LFactU = [["LIB_US_M3_Halftrack",[5,0,0,60]],["LIB_US_GMC_Tent",[5,0,0,60]],["LIB_US_GMC_Parm",[10,0,0,40]],["LIB_US_Scout_M3_FFV",[10,0,0,40]],["LIB_US_Willys_MB",[10,0,0,40]],["LIB_US_Scout_M3",[10,0,0,40]]];
	W_HFactU = [["fow_v_m4a2_usa",[10,10,0,60]],["fow_v_m5a1_usa",[10,10,0,60]],["LIB_M3A3_Stuart",[10,10,0,60]],["LIB_M4A4_FIREFLY",[20,20,0,120]],["LIB_M5A1_Stuart",[20,20,0,140]],["LIB_M4A3_76_HVSS",[20,20,0,160]],["LIB_M4A3_75",[20,25,0,180]]];
	W_AirU = [["LIB_US_NAC_P39_2",[10,0,0,70]],["LIB_US_NAC_P39_3",[50,25,0,300]],["LIB_US_NAC_P39",[10,0,0,300]]];
	W_MedU = [["LIB_US_Rangers_medic",[0,0,0,10]]];
	W_AdvU = [["fow_s_us_m37_sniper_m1903a1",[0,0,0,20]],["fow_s_us_m37_smg_m1a1",[0,0,0,20]],["fow_s_us_m37_engineer",[0,0,0,20]],["fow_s_us_m37_bar_gunner",[0,0,0,20]],["fow_s_us_m37_smg_m3",[0,0,0,20]],["fow_s_us_m37_m1919a6_gunner",[0,0,0,20]]];
	W_TeamLU = [["fow_s_us_m37_teamleader",[0,0,0,5]]];
	W_SquadLU = [["fow_s_us_m37_teamleader",[0,0,0,5]]];
	W_StaticWeap = [["fow_w_6Pounder_usa",[10,10,0,10]],["LIB_Zis3",[10,10,0,10]],["LIB_BM37",[10,10,0,10]],["LIB_61k",[10,10,0,10]],["LIB_Maxim_M30_base",[10,10,0,10]],["fow_w_m1919_tripod_usa_m41",[10,10,0,10]]];
	
	R_BarrackLU = ["LIB_SOV_AT_soldier","LIB_SOV_captain_summer","LIB_SOV_gun_lieutenant","LIB_SOV_mgunner","LIB_SOV_medic","LIB_SOV_rifleman","rhsgref_nat_rifleman_m92","LIB_SOV_p_officer","LIB_SOV_sergeant","LIB_SOV_scout_sniper","LIB_SOV_smgunner_summer"];
	R_LFactU = ["LIB_Zis5v_61K","LIB_US6_BM13","LIB_Scout_M3","LIB_US6_Open","LIB_US6_Tent","LIB_SOV_M3_Halftrack","LIB_SdKfz251_captured","LIB_SdKfz251_captured_FFV"];
	R_HFactU = ["LIB_T34_85"];
	R_StaticWeap = ["LIB_Maxim_M30_base","LIB_BM37","LIB_Zis3","LIB_61K"];	
	R_LFactDef = ["LIB_US6_BM13","LIB_SOV_M3_Halftrack","LIB_SdKfz251_captured","LIB_SdKfz251_captured_FFV","LIB_Zis5v_61K"];
	R_BarrackHU = [];
	R_AirU = ["LIB_Li2","LIB_P39","LIB_RA_P39_3","LIB_RA_P39_2","LIB_Pe2"];	
	
	W_TransportUnit = ["B_Heli_Transport_01_F"];
	R_TransportUnit = ["I_Heli_light_03_unarmed_F"];
	E_TransportUnit = ["O_Heli_Light_02_unarmed_F"];		
	//LIB_JS2_43
};




if (!(DIS_MODRUN) || (_Mod isEqualTo 0)) then
{
	//Other important variables to be set here.																					
	//Blufor units using VANILLA
	W_BarrackU = [["B_Soldier_F",[0,0,0,5]],["B_soldier_LAT_F",[0,0,0,10]],["B_soldier_GL_F",[0,0,0,10]],["B_soldier_AR_F",[0,0,0,10]]];
	W_LFactU = [["B_MRAP_01_hmg_F",[10,0,0,20]],["B_MRAP_01_gmg_F",[10,0,0,20]],["B_LSV_01_armed_F",[10,0,0,20]],["B_APC_Wheeled_01_cannon_F",[10,10,0,60]],["B_AFV_Wheeled_01_up_cannon_F",[10,10,0,60]]];
	W_HFactU = [["B_MBT_01_cannon_F",[20,20,0,200]],["B_MBT_01_TUSK_F",[20,20,0,200]],["B_APC_Tracked_01_AA_F",[20,20,0,200]]];
	W_AirU = [["B_Heli_Light_01_dynamicLoadout_F",[20,20,0,300]],["B_Heli_Attack_01_dynamicLoadout_F",[10,10,0,150]],["B_Plane_CAS_01_dynamicLoadout_F",[10,10,0,150]],["B_Plane_Fighter_01_F",[10,10,0,150]]];
	W_MedU = [["B_medic_F",[0,0,0,10]]];	
	W_AdvU = [["B_sniper_F",[0,0,0,20]],["B_soldier_AT_F",[0,0,0,20]],["B_HeavyGunner_F",[0,0,0,20]],["B_engineer_F",[0,0,0,20]],["B_Soldier_M_F",[0,0,0,20]],["B_soldier_exp_F",[0,0,0,20]],["B_soldier_AA_F",[0,0,0,20]],["B_CTRG_Soldier_tna_F",[0,0,0,20]]]; //["B_soldier_UAV_F",[0,0,0,20]], - removed until UAV's are fixed for AI
	W_TeamLU = [["B_Soldier_TL_F",[0,0,0,5]]];
	W_SquadLU = [["B_Soldier_SL_F",[0,0,0,5]]];
	W_StaticWeap = [["B_SAM_System_01_F",[25,25,0,25]],["B_AAA_System_01_F",[25,25,0,25]],["B_SAM_System_02_F",[25,25,0,25]],["B_Radar_System_01_F",[25,25,0,25]],["B_SAM_System_03_F",[25,25,0,25]],["B_SAM_System_03_F",[25,25,0,25]]];

	
	//Opfor units using VANILLA
	E_BarrackU = [["O_Soldier_F",[0,0,0,5]],["O_Soldier_LAT_F",[0,0,0,10]],["O_Soldier_GL_F",[0,0,0,10]],["O_Soldier_AR_F",[0,0,0,10]]];
	E_LFactU = [["O_MRAP_02_gmg_F",[10,0,0,20]],["O_MRAP_02_hmg_F",[10,0,0,20]],["O_LSV_armed_F",[10,0,0,20]],["O_APC_Wheeled_02_rcws_F",[10,10,0,60]]];
	E_HFactU = [["O_MBT_02_cannon_F",[20,20,0,200]],["O_APC_Tracked_02_cannon_F",[20,20,0,200]],["O_APC_Tracked_02_AA_F",[20,20,0,200]]];
	E_AirU = [["O_Heli_Attack_02_black_F",[15,15,0,300]],["O_Heli_Light_02_v2_F",[10,10,0,150]],["O_Plane_CAS_02_dynamicLoadout_F",[10,10,0,150]],["O_Plane_Fighter_02_Stealth_F",[10,10,0,150]]];
	E_MedU = [["O_medic_F",[0,0,0,10]]];	
	E_AdvU = [["O_sniper_F",[0,0,0,20]],["O_Soldier_AT_F",[0,0,0,10]],["O_HeavyGunner_F",[0,0,0,20]],["O_engineer_F",[0,0,0,20]],["O_soldier_M_F",[0,0,0,20]],["O_soldier_exp_F",[0,0,0,20]],["O_Soldier_AA_F",[0,0,0,20]],["O_V_Soldier_hex_F",[0,0,0,20]]]; //["O_soldier_UAV_F",[0,0,0,20]] -removed until UAV's are fixed for AI
	E_TeamLU = [["O_Soldier_TL_F",[0,0,0,5]]];
	E_SquadLU = [["O_Soldier_SL_F",[0,0,0,5]]];
	E_StaticWeap = [["B_SAM_System_01_F",[25,25,0,25]],["B_AAA_System_01_F",[25,25,0,25]],["B_SAM_System_02_F",[25,25,0,25]],["O_Radar_System_02_F",[25,25,0,25]],["O_SAM_System_04_F",[25,25,0,25]]];	
	
	//resistance units operate differently. Because it's not a full-blown commander we do not need resources.
	R_LFactDef = ["I_G_Offroad_01_armed_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","I_Truck_02_covered_F","I_LT_01_AT_F","I_LT_01_cannon_F","I_LT_01_AA_F","I_C_Offroad_02_LMG_F","I_C_Offroad_02_AT_F","I_G_Offroad_01_AT_F"];
	R_BarrackLU = ["I_G_Soldier_F","I_G_Soldier_AR_F","I_G_medic_F","I_G_engineer_F","I_G_Soldier_exp_F","I_G_Soldier_GL_F","I_G_Soldier_LAT_F","I_G_Soldier_A_F"];
	R_BarrackHU = ["I_soldier_F","I_Soldier_A_F","I_Soldier_GL_F","I_Soldier_AR_F","I_Soldier_SL_F","I_Soldier_TL_F","I_Soldier_M_F","I_Soldier_LAT_F","I_Soldier_AT_F","I_Soldier_AA_F","I_medic_F","I_support_MG_F","I_support_Mort_F"];	
	R_LFactU = ["I_G_Offroad_01_armed_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","I_Truck_02_covered_F","I_LT_01_AT_F","I_LT_01_cannon_F","I_LT_01_AA_F","I_C_Offroad_02_LMG_F","I_C_Offroad_02_AT_F","I_G_Offroad_01_AT_F"];
	R_HFactU = ["I_APC_tracked_03_cannon_F","I_MBT_03_cannon_F","I_APC_Wheeled_03_cannon_F"];
	R_AirU = ["I_Plane_Fighter_04_F","I_Plane_Fighter_03_dynamicLoadout_F","I_Heli_light_03_dynamicLoadout_F"];
	R_TeamLLU = ["I_G_Soldier_TL_F"];
	R_TeamHLU = ["I_support_GMG_F"];
	R_SquadLLU = ["I_G_Soldier_SL_F"];
	R_SquadHLU = ["I_officer_F"];
	R_StaticWeap = ["I_static_AT_F","I_GMG_01_F","I_HMG_01_F","I_static_AA_F"];
	
	W_TransportUnit = ["B_Heli_Transport_01_F"];
	R_TransportUnit = ["I_Heli_light_03_unarmed_F"];
	E_TransportUnit = ["O_Heli_Light_02_unarmed_F"];		
	
};

/*
_Test = nearestObjects [player, ["Building"], 14000];
{
	if (!(_x in DIS_BuildingListVanilla) && {(count ([_x] call BIS_fnc_buildingPositions)) > 1}) then
	{
		DIS_BuildingListVanilla pushBackUnique (typeOf _x);
	};
	
} foreach _Test;
copyToClipboard str DIS_BuildingListVanilla;

*/
DIS_BuildingListVanilla = ["Land_Bunker_01_HQ_F","Land_i_Stone_Shed_V3_F","Land_Stone_HouseBig_V1_ruins_F","Land_Slum_House01_F","Land_cargo_house_slum_F","Land_u_House_Small_01_V1_F","Land_i_Garage_V1_dam_F","Land_u_Addon_02_V1_F","Land_i_Stone_Shed_V2_F","Land_Metal_Shed_F","Land_Slum_House03_F","Land_Slum_House02_F","Land_Stone_Shed_V1_ruins_F","Land_d_House_Small_01_V1_F","Land_i_House_Small_02_V3_F","Land_d_Addon_02_V1_F","Land_u_Shed_Ind_F","Land_i_Garage_V1_F","Land_i_Stone_Shed_V1_F","Land_i_Shed_Ind_F","Land_i_Stone_HouseSmall_V3_F","Land_i_Stone_HouseSmall_V1_F","Land_u_House_Small_02_V1_F","Land_i_Garage_V2_F","Land_i_House_Big_01_V2_F","Land_d_House_Small_02_V1_F","Land_i_House_Big_02_V1_F","Land_d_House_Big_02_V1_F","Land_u_House_Big_02_V1_F","Land_i_Addon_03_V1_F","Land_i_House_Small_01_V2_F","Land_d_Shop_01_V1_F","Land_u_Shop_02_V1_F","Land_u_House_Big_01_V1_F","Land_i_House_Small_01_V3_F","Land_i_House_Big_02_V2_F","Land_u_Shop_01_V1_F","Land_d_Stone_HouseSmall_V1_F","Land_i_Addon_02_V1_F","Land_i_House_Small_02_V2_F","Land_i_Shop_01_V2_F","Land_i_Addon_04_V1_F","Land_Chapel_V1_F","Land_Chapel_Small_V1_F","Land_Addon_04_V1_ruins_F","Land_i_Stone_HouseBig_V1_F","Land_i_House_Small_02_V1_F","Land_d_Stone_HouseBig_V1_F","Land_i_Stone_HouseBig_V3_F","Land_i_House_Small_01_V1_F","Land_i_House_Small_03_V1_F","Land_Cargo_Patrol_V3_F","Land_i_Garage_V2_dam_F","Land_i_Shop_02_V3_F","Land_i_Stone_HouseBig_V2_F","Land_Cargo_Patrol_V2_F","Land_House_Small_02_V1_ruins_F","Land_i_Stone_HouseSmall_V2_F","Land_Cargo_Tower_V3_F","Land_Cargo_HQ_V3_F","Land_Unfinished_Building_01_F","Land_Cargo_Patrol_V1_F","Land_Cargo_Tower_V1_F","Land_i_House_Big_01_V3_F","Land_i_House_Big_01_V1_F","Land_i_Barracks_V2_F","Land_i_House_Big_02_V3_F","Land_i_Shop_01_V3_F","Land_i_Addon_03mid_V1_F","Land_MilOffices_V1_F","Land_i_Shop_02_V1_F","Land_House_Small_01_V1_ruins_F","Land_i_Shop_02_V2_F","Land_Unfinished_Building_02_F","Land_CarService_F","Land_Unfinished_Building_01_ruins_F","Land_House_Big_02_V1_ruins_F","Land_Bridge_Asphalt_PathLod_F","Land_u_Barracks_V2_F","Land_Unfinished_Building_02_ruins_F","Land_Factory_Main_F","Land_i_Shop_01_V1_F","Land_Bridge_HighWay_PathLod_F","Land_Cargo_HQ_V1_F","Land_Airport_Tower_F","Land_Airport_right_F","Land_Airport_left_F","Land_Hangar_F","Land_Chapel_V2_F","Land_Shop_02_V1_ruins_F","Land_Shop_01_V1_ruins_F","Land_dp_mainFactory_F","Land_Crane_F","Land_spp_Tower_F","Land_WIP_F","Land_dp_bigTank_F","Land_Pier_F","Land_Pier_small_F","Land_nav_pier_m_F","Land_Research_HQ_F","Land_d_Windmill01_F","Land_Chapel_Small_V2_F","Land_Garage_V1_ruins_F","Land_Bridge_Concrete_PathLod_F","Land_House_Big_01_V1_ruins_F","Land_Stadium_p5_F","Land_Stadium_p9_F","Land_Stadium_p4_F","Land_Offices_01_V1_F","Land_Lighthouse_small_F","Land_Bridge_01_PathLod_F","Land_Hospital_side1_F","Land_Hospital_main_F","Land_Hospital_side2_F","Land_GH_House_2_F","Land_GH_House_1_F","Land_GH_Gazebo_F","Land_GH_MainBuilding_left_F","Land_GH_MainBuilding_middle_F","Land_GH_MainBuilding_right_F","Land_LightHouse_F","Land_Radar_F","Land_House_K_1_EP1","Land_House_K_7_EP1","Land_House_K_8_EP1","Land_House_K_3_EP1","Land_House_K_6_EP1","Land_House_K_5_EP1","Land_A_Mosque_small_1_EP1","Land_A_Mosque_small_2_EP1","Land_House_L_1_EP1","Land_House_L_3_EP1","Land_House_L_4_EP1","Land_House_L_8_EP1","Land_House_L_6_EP1","Land_House_L_7_EP1","Land_House_C_1_EP1","Land_A_Minaret_Porto_EP1","Land_House_C_2_EP1","Land_House_C_5_EP1","Land_House_C_1_v2_EP1","Land_House_C_5_V1_EP1","Land_Ind_FuelStation_Build_EP1","Land_House_C_3_EP1","Land_House_C_12_ruins_EP1","Land_House_C_12_EP1","Land_House_C_5_V3_EP1","Land_House_C_5_V2_EP1","Land_Vez","Land_Mil_Guardhouse_EP1","Land_Mil_House_EP1","Land_Mil_Repair_center_EP1","Land_Barrack2","Land_Shed_Ind02","Land_Ind_Coltan_Main_EP1","Land_Misc_Cargo1Ao_EP1","Land_Mil_Barracks_EP1","Land_Mil_Barracks_i_EP1","Land_House_L_8_ruins_EP1","Land_House_L_3_ruins_EP1","Land_House_L_7_ruins_EP1","Land_fortified_nest_small_EP1","Land_Ind_Oil_Tower_EP1","Land_House_L_9_EP1","Land_fortified_nest_big_EP1","Land_A_Mosque_big_wall_EP1","Land_A_Mosque_big_wall_corner_EP1","Land_A_Mosque_big_minaret_1_EP1","Land_A_Mosque_big_addon_EP1","Land_A_Mosque_big_hq_EP1","Land_A_Mosque_big_wall_gate_EP1","Land_House_C_4_EP1","Land_A_Mosque_big_minaret_2_EP1","Land_House_C_11_EP1","Land_House_C_10_EP1","Land_House_C_9_EP1","Land_Ind_FuelStation_Shed_EP1","Land_Misc_Cargo1Bo_EP1","Land_Ind_TankBig","Land_A_Minaret_EP1","Land_Ind_Garage01_EP1","Land_Mil_hangar_EP1","Land_Mil_ControlTower_EP1","Land_Ind_PowerStation_EP1","Land_House_C_2_ruins_EP1","Land_Shed_05_F","Land_House_Small_02_F","Land_House_Native_01_F","Land_Shed_03_F","Land_House_Native_02_F","Land_Slum_03_F","Land_Slum_01_F","Land_Shed_02_F","Land_Warehouse_03_F","Land_House_Small_05_F","Land_House_Small_06_F","Land_House_Small_03_F","Land_House_Small_01_F","Land_House_Big_04_F","Land_Shop_Town_05_F","Land_FuelStation_02_workshop_F","Land_House_Big_02_F","Land_Shop_Town_03_F","Land_House_Big_01_F","Land_PillboxBunker_01_rectangle_F","Land_PillboxBunker_01_hex_F","Land_PillboxBunker_01_big_F","Land_GuardHouse_01_F","Land_Shop_Town_02_F","Land_House_Small_04_F","Land_Temple_Native_01_F","Land_School_01_F","Land_House_Big_03_F","Land_Slum_02_F","Land_Shop_City_07_F","Land_GarageShelter_01_F","Land_Shop_Town_01_F","Land_Hotel_01_F","Land_FuelStation_01_workshop_F","Land_FuelStation_01_shop_F","Land_PierWooden_01_10m_noRails_F","Land_Addon_04_F","Land_PierWooden_01_16m_F","Land_Hotel_02_F","Land_PierWooden_01_dock_F","Land_PierWooden_01_hut_F","Land_PierWooden_01_platform_F","Land_SCF_01_storageBin_small_F","Land_Shop_City_06_F","Land_FireEscape_01_short_F","Land_Shop_City_04_F","Land_Supermarket_01_F","Land_Shop_City_02_F","Land_Shop_City_01_F","Land_FireEscape_01_tall_F","Land_SCF_01_storageBin_medium_F","Land_MobileCrane_01_F","Land_Shop_City_05_F","Land_MobileCrane_01_hook_F","Land_SCF_01_heap_bagasse_F","Land_SCF_01_storageBin_big_F","Land_SCF_01_condenser_F","Land_SCF_01_generalBuilding_F","Land_SCF_01_chimney_F","Land_SCF_01_crystallizerTowers_F","Land_SCF_01_clarifier_F","Land_SCF_01_crystallizer_F","Land_SCF_01_diffuser_F","Land_SCF_01_boilerBuilding_F","Land_SCF_01_washer_F","Land_SCF_01_feeder_F","Land_Barracks_01_grey_F","Land_Track_01_bridge_F","Land_PierWooden_02_16m_F","Land_PierWooden_02_ladder_F","Land_PierWooden_02_hut_F","Land_Mausoleum_01_F","Land_MultistoryBuilding_01_F","Land_MultistoryBuilding_03_F","Land_MultistoryBuilding_04_F","Land_Cathedral_01_F","Land_ContainerLine_03_F","Land_ContainerLine_02_F","Land_StorageTank_01_small_F","Land_ContainerLine_01_F","Land_Airport_02_terminal_F","Land_DPP_01_mainFactory_F","Land_Airport_01_controlTower_F","Land_Airport_01_hangar_F","Land_Barracks_01_camo_F","Land_PierWooden_02_barrel_F","Land_HaulTruck_01_abandoned_F","Land_MiningShovel_01_abandoned_F","Land_SM_01_shed_unfinished_F","Land_Airport_02_controlTower_F","Land_SY_01_conveyor_end_F","Land_Warehouse_02_F","Land_SY_01_shiploader_F","Land_SY_01_shiploader_arm_F","Land_Airport_02_hangar_left_F","Land_Airport_02_hangar_right_F","Land_Warehouse_01_F","Land_SY_01_reclaimer_F","Land_ContainerCrane_01_F","Land_SY_01_crusher_F","Land_DryDock_01_end_F","Land_DryDock_01_middle_F","Land_SM_01_shed_F","Land_StorageTank_01_large_F","Land_Airport_01_terminal_F","Land_Dum_olez_istan1","Land_Dum_istan2","Land_Zastavka_jih","Land_Dum_olez_istan2","Land_Dum_istan3_pumpa","Land_Dum_istan4","Land_Leseni4x","Land_Garaz","Land_Kostel_mexico","Land_Dum_istan3_hromada","Land_Hut03","Land_Leseni2x","Land_Budova5","Land_Strazni_vez","Land_Tovarna2","Land_Watertower1","Land_Benzina_schnell","Land_Hlidac_budka","Land_Repair_center","Land_ZalChata","Land_Dulni_bs","Land_water_tank","Land_Hut_old02","Land_Bouda2_vnitrek","Land_Dum_olez_istan2_maly","Land_Dum_istan3","Land_Dum_istan3_hromada2","Land_Dum_istan4_inverse","Land_Dum_istan4_detaily1","Land_Hotel","Land_Majak_podesta","Land_House_y","Land_Hut01","Land_Dum_istan2_02","Land_Dum_istan4_big","land_statek_brana_open","Land_Dum_istan4_big_inverse","Land_Hotel_riviera2","Land_Podesta_1_mid_cornp","Land_Podesta_1_stairs2","Land_Podesta_1_stairs","Land_Majak","Land_Hlaska","Land_Army_hut3_long_int","Land_Army_hut2_int","Land_Vysilac_FM2","Land_Nasypka","Land_Afbarabizna","Land_Hut02","Land_Sara_stodola2","Land_Molo_drevo_bs","Land_Hut04","Land_Hotel_riviera1","Land_Trafostanica_velka","Land_Hut06","Land_Majak2","Land_Molo_drevo_end","Land_Army_hut_storrage","Land_Kostel","Land_Garaz_bez_tanku","Land_Telek1","Land_Dum_zboreny_total","Land_Hangar_2","Land_Komin","Land_Dum_zboreny","Land_Podesta_1_stairs3","Land_Dum_istan2b","Land_prebehlavka","Land_Army_hut_int","Land_Vysilac_FM","Land_Stodola_open","Land_Posed","Land_Garaz_s_tankem","Land_Ammostore2","Land_Army_hut3_long","Land_Army_hut2","Land_Ss_hangard","Land_Letistni_hala","Land_Trafostanica_mala","Land_Molo_beton","Land_AfDum_mesto3","Land_Sara_stodola","Land_Cihlovej_Dum_mini","Land_Dum_olezlina","Land_Zastavka_sever","Land_Dum_mesto3","Land_Hospoda_mesto","Land_Dum_mesto2l","Land_Dum_mesto2","Land_Sara_domek_hospoda","Land_Sara_hasic_zbroj","Land_Hruzdum","Land_Deutshe_mini","Land_Panelak","Land_Sara_domek_podhradi_1","Land_Sara_Domek_sedy","Land_Sara_zluty_statek_in","Land_Stodola_old_open","Land_Sara_domek_zluty","Land_Budova4_in","Land_Dum_rasovna","Land_Garaz_mala","Land_Helfenburk_cimburi","Land_Helfenburk","Land_Helfenburk_budova2","Land_Budova3","Land_Budova4","Land_Kostel_trosky","Land_Kasarna_prujezd","Land_Dum_mesto_in","Land_Vysilac_vez","Land_Vysilac_budova","Land_Helfenburk_brana","Land_vodni_vez","Land_pristresek_camo","Land_Majak_v_celku","Land_pila","Land_Kamenolom_budova","Land_Ss_hangar","Land_WW2_Countryside_House_2","Land_WW2_Dom_Pl_Big","Land_WW2_Dom_Pol","Land_WW2_Hata_2","Land_WW2_Dom_Pl_Sml","Land_WW2_Dom_Pl_Big2","Land_WW2_Kladovka2","Land_WW2_Dom_Pol2","Land_WW2_Countryside_House_1","Land_Wall_CGry_5_D","Land_WW2_Admin","Land_WW2_Admin2","Land_Misc_deerstand","Land_WW2_Dom_Pl_Big2_Destroyed","Land_WW2_Dom_Pl_Big_Damage","Land_WW2_Kladovka2_Ruins","Land_WW2_Countryside_House_2_Destroyed","Land_WW2_Dom_Pl_Big2_Damage","Land_WW2_Dom_Pol_Destroyed","Land_WW2_Hata_2_Ruins","Land_WW2_Countryside_House_2_Damaged","Land_WW2_Dom_Pol_Damage","Land_WW2_House_2e_1","Land_WW2_House_City1e_1","Land_WW2_Hata_2_Dam","Land_WW2_Dom_Pl_Sml_Destroyed","Land_WW2_Kostel_2","Land_WW2_Dom_Pl_Avrg","Land_A_Castle_Wall1_20","Land_A_Castle_Wall1_20_Turn","Land_A_Castle_Gate","Land_WW2_Countryside_House_1_Destroyed","Land_WW2_Town_House_1","Land_A_Castle_Bergfrit","Land_WW2_House_City1e_2_Destroyed","Land_WW2_Cr_Mid","Land_WW2_House_City1e_1_Damaged","Land_WW2_Countryside_House_1_Damaged","Land_WW2_City_House_2e_Lone","Land_WW2_House_1floor_Pol","Land_WW2_House_City1e_2_Damaged","Land_A_Castle_Stairs_A","Land_WW2_House_City1e_1_Destroyed","Land_WW2_House_Small_1","Land_WW2_Dom_Pl_Sml_Damage","Land_Wall_CBrk_5_D","Land_WW2_House_City1e_2","Land_WW2_City_Shop_1e","Land_WW2_Corner_House_1","Land_WW2_Corner_House_3","Land_WW2_Posed","Land_WW2_City_House_2e_Lone_2","Land_WW2_City_Shop_1e_Destroyed","Land_WW2_City_Shop_1e_Damaged","Land_WW2_House_2e_1_Destroyed","Land_WW2_City_House_2e_Shops","Land_WW2_House_2e_1_Ruins","Land_WW2_Corner_House_2e_5_Damaged","Land_WW2_City_House_2e_Shops_Damaged","Land_WW2_City_House_2e_Lone_3","Land_WW2_Corner_House_2e_5_Destroyed","Land_WW2_House_2e_Arc1","Land_HouseV2_03B_dam","Land_WW2_House_2e_1_Damaged","Land_WW2_Corner_House_2e_3","Land_WW2_Dom_Pl_Avrg_Destroyed","Land_WW2_City_House_2e_Shops_Ruins","Land_WW2_City_House_2e_Shops_Destroyed","Land_WW2_Corner_House_2e_4","Land_WW2_Corner_House_2e_5","Land_WW2_Corner_House_2e_2_Damaged","Land_WW2_Central_3e_1","Land_WW2_Corner_House_2e_5_Ruins","Land_WW2_Corner_House_2e_2","Land_WW2_Corner_House_1b","Land_WW2_Corner_House_1c","Land_WW2_House_2e_Arc2","Land_WW2_City_House_2e_Lone_3_Ruins","Land_WW2_City_House_2e_Lone_2_Ruins"];