class DissensionFunctions {
	tag = "DIS";
	
	class DISInitialize 
	{
		file = "Functions";
		
		//[] call DIS_fnc_addoncheck
		class addoncheck {};
		//[] call DIS_fnc_cratespawn		
		class cratespawn {};
		//[] call DIS_fnc_cratemonitor
		class cratemonitor {};
		//[] call DIS_fnc_mrkersave
		class mrkersave {};	
		//[] call DIS_fnc_mrkersetup
		class mrkersetup {};	
		//[] call DIS_fnc_AIGroup
		class AIGroup {};	
		//[] call DIS_fnc_PlayerSquad
		class PlayerSquad {};
		//[] call DIS_fnc_PMCUniforms
		class PMCUniforms {};
		//[] call DIS_fnc_markerdisplay
		class markerdisplay {};
		// [] call Dis_fnc_Recruitment;
		class Recruitment {};
		// [] call Dis_fnc_recruitSel;
		class recruitSel;
		//[] call DIS_fnc_UnitSel;
		class UnitSel {};		
		//[] call DIS_fnc_RZone;
		class RZone {};	
		//[] call DIS_fnc_RZoneCheck;
		class RZoneCheck {};
		//[] call DIS_fnc_TownDefenceZone;
		class TownDefenceZone {};
		//[] spawn DIS_fnc_RoadPath
		class RoadPath {};
		//[] spawn DIS_fnc_DefenceSpawn
		class DefenceSpawn {};
		//[] spawn DIS_fnc_DSpwnUnit
		class DSpwnUnit {};		
		//[] spawn DIS_fnc_DefenceSpawnGrid
		class DefenceSpawnGrid {};
		//[] spawn DIS_fnc_VehicleLock
		class VehicleLock {};
		//[] spawn DIS_fnc_DeployFortification
		class DeployFortification {};
		//[] spawn DIS_fnc_CreateRope
		class CreateRope {};
		//[] spawn DIS_fnc_SendMoney
		class SendMoney {};		
		//[] call DIS_fnc_CounterAttack;
		class CounterAttack {};			
		//[] spawn DIS_fnc_GroundUnitStuck;
		class GroundUnitStuck {};
		//[] spawn DIS_fnc_Compositions;
		class Compositions {};
		//[] spawn DIS_fnc_SpawnPrefab;
		class SpawnPrefab {};		
		//[] call DIS_fnc_TownCheck;
		class TownCheck {};
		//[] call DIS_fnc_AIStruChk;
		class AIStruChk {};
		//[] call DIS_fnc_StrBomb;
		class StrBomb {};
		//[] call DIS_fnc_StSpwn;
		class StSpwn {};
		//[] call DIS_fnc_VehSpwn;
		class VehSpwn {};
		//[] call DIS_fnc_StkVeh
		class StkVeh {};
		//[] call DIS_fnc_EmyLst
		class EmyLst;
		//[] call DIS_fnc_AtkMrk
		class AtkMrk;		
		//[] call DIS_fnc_ClstET
		class ClstET;
		//[] call DIS_fnc_RearmRep
		class RearmRep;		
		//[] call DIS_fnc_REHndle;
		class REHndle;
		//[] call DIS_fnc_LoadoutCost;
		class LoadoutCost;		
		//[] call DIS_fnc_TownReset;
		class TownReset {};
		//[] call DIS_fnc_StcSpwnLoc;
		class StcSpwnLoc {};	
		//[] call DIS_fnc_NightObj;
		class NightObj {};
		//[] call DIS_fnc_DTowerSpawn;
		class DTowerSpawn {};	
		//[] call DIS_fnc_UniformHandle;
		class UniformHandle {};
		//[] call DIS_fnc_PlayerStrcLoad;
		class PlayerStrcLoad {};
		//[] call DIS_fnc_RspnCam;
		class RspnCam {};
		//[] call DIS_fnc_TObjs;
		class TObjs {};
		//[] call DIS_fnc_SquadRadar;
		class SquadRadar {};		
		//[] call DIS_fnc_DisplayActiveT;
		class DisplayActiveT {};
		//[] call DIS_fnc_HURSP;
		class HURSP {};		
		//[] spawn DIS_fnc_PAUSE;
		class PAUSE {};
		//[] spawn DIS_fnc_RequestRevive
		class RequestRevive {};
		//[] spawn DIS_fnc_CombineSounds
		class CombineSounds {};
		//[] call DIS_fnc_OrdnanceCheck;
		class OrdnanceCheck {};
		//[] call DIS_fnc_DisarmOrd
		class DisarmOrd {};
		//[] spawn DIS_fnc_StuLoop
		class StuLoop {};
		//[] call DIS_fnc_StuCheck
		class StuCheck {};
		//[] call DIS_fnc_ClaimDocument
		class ClaimDocument {};
		//[] call DIS_fnc_WinGame
		class WinGame {};
		//[] call DIS_fnc_TownCacheSpawns
		class TownCacheSpawns {};
		//[] spawn DIS_fnc_PlayerTownEnterCheck;
		class PlayerTownEnterCheck {};
		//[] call DIS_fnc_HalfPointReinforce;
		class HalfPointReinforce {};
		//[] call DIS_fnc_FragmentMove;
		class FragmentMove {};
		//[] call DIS_fnc_FlipVehicle;
		class FlipVehicle {};
		//[] call DIS_fnc_ParaCreate;
		class ParaCreate {};
		//[] call DIS_fnc_CommanderSpeak;
		class CommanderSpeak {};
		//[] call DIS_fnc_NearestRTown;
		class NearestRTown {};
		//[] call DIS_fnc_NearestETown;
		class NearestETown {};		
		//[] call DIS_fnc_ClosestFriendlyTown;
		class ClosestFriendlyTown {};
		//[] call DIS_fnc_CreateFOBs;
		class CreateFobs {};
		//[] call DIS_fnc_TownsSetupStage1;
		class TownsSetupStage1 {};
		//[] call DIS_fnc_TownsSetupStage2;
		class TownsSetupStage2 {};		
		//[] call Dis_fnc_RandomHouses;
		class RandomHouses {};		
		//[] call Dis_fnc_PrymSetup;
		class PrymSetup {};
		//[] call Dis_fnc_PlaySoundNear;
		class PlaySoundNear {};
	};

	class DISInitializeMusic 
	{
		file = "DynamicMusic";

		//[] spawn DIS_fnc_DynamicMusic
		class DynamicMusic {};
	};	
	
	class DISInitializeCom 
	{
		file = "Commander";

		//[] call DIS_fnc_SpawnCommanders
		class SpawnCommanders {};
	};	
	
	
	class DISInitialize2 
	{
		file = "Commander\specialmission";

		//[] call DIS_fnc_SEMedic
		class SEMedic {};
		//[] call DIS_fnc_SECrate
		class SECrate {};
		//[] call DIS_fnc_PMCReinforce
		class PMCReinforce {};
		//[] call DIS_fnc_PMCParachute
		class PMCParachute {};
		//[] call DIS_fnc_DDefenceSpawn
		class DDefenceSpawn {};
		//[] call DIS_fnc_CloseCapture;
		class CloseCapture {};		
		//[] call DIS_fnc_Defensive;
		class Defensive {};
		//[] call DIS_fnc_Aggressive;
		class Aggressive {};
		//[] call DIS_fnc_ACapture;
		class ACapture {};
		//[] call DIS_fnc_AAirCapture;
		class AAirCapture {};		
		//[] call DIS_fnc_GBomb;
		class GBomb {};	
		//[] call DIS_fnc_GCamp;
		class GCamp {};
		//[] call DIS_fnc_GHarass;
		class GHarass {};
		//[] call DIS_fnc_SEArty;
		class SEArty {};
		//[] call DIS_fnc_SEDeploy;
		class SEDeploy {};
		//[] call DIS_fnc_PMMilitiaBuy;
		class PMMilitiaBuy {};		
	};	

	class DISInitialize3 
	{
		file = "PlayerMissions";

		//[] call DIS_fnc_AcceptMission
		class AcceptMission {};

	};	
	class DISInitialize6 
	{
		file = "SaveSystem";

		//[] call DIS_fnc_SaveSVR
		class SaveSVR {};
		//[] spawn DIS_fnc_SaveSVRLoop		
		class SaveSVRLoop {};
		//[] call DIS_fnc_SaveLoad
		class SaveLoad {};		

	};	
	class DISInitialize4 {
		file = "CustomHC";

		//[] call DIS_fnc_Init
		class Init {};

	};	
	class DISInitialize5 {
		file = "DIS_Stealth";

		//[] call DIS_fnc_StealthInit
		class StealthInit {};

	};
	class DISInitializePlayerBase 
	{
		file = "PlayerBase";

		//[] call DIS_fnc_PlacedBuilding
		class PlacedBuilding {};
		//[] call DIS_fnc_StructureMonitor
		class StructureMonitor {};
		//[] call DIS_fnc_3DMarker
		class 3DMarker {};
		//_Obj call DIS_fnc_ObjPlacedEff
		class ObjPlacedEff {};
	};
	class DISRANKFUNCTION 
	{
		file = "Functions\RankSystem";

		//[] call DIS_fnc_RankInit
		class RankInit {};
		//[] call DIS_fnc_SaveData
		class SaveData {};		
		//[] call DIS_fnc_LevelKilled
		class LevelKilled {};		
		//[] spawn DIS_fnc_RankLoop
		class RankLoop {};
		//[] call DIS_fnc_SaveLoop
		class SaveLoop {};		
	};	
	class DISPLAYERABILITY 
	{
		file = "Functions\RankSystem\PlayerAbilities";

		//[] call DIS_fnc_AmmoDrop
		class AmmoDrop {};
		//[] call DIS_fnc_SquadAD
		class SquadAD {};
		//[] call DIS_fnc_ATVD
		class ATVD {};
		//[] call DIS_fnc_LeafletD
		class LeafletD {};
		//[] call DIS_fnc_Halo
		class Halo {};
		//[] call DIS_fnc_FARP
		class FARP {};	
		//[] call DIS_fnc_FARPB
		class FARPB {};
		//[] call DIS_fnc_DIGIN
		class DIGIN {};
		//[] call DIS_fnc_transportD
		class transportD {};
		//[] call DIS_fnc_RequestPickup
		class RequestPickup {};	
		//[] call DIS_fnc_CommAssist;
		class CommAssist;
		//[] call DIS_fnc_AirAssist;
		class AirAssist;
		//[] call DIS_fnc_MissileBarrage;
		class MissileBarrage;
		//[] spawn DIS_fnc_RequestGunship;
		class RequestGunship;		
		//[] spawn DIS_fnc_HCAS;
		class HCAS;
		//[] spawn DIS_fnc_HHCAS;
		class HHCAS;		
		//[] call DIS_fnc_HFired;
		class HFired {};
		//[] call DIS_fnc_HInc;
		class HInc {};
		//[] call DIS_fnc_HGoingDown;
		class HGoingDown {};			
	};	
	class HC 
	{
		file = "HC";

		//[] call DIS_fnc_RecruitWaypoints
		class RecruitWaypoints {};
	};
	class AIComms 
	{
		file = "AIComms";
		//[] call DIS_fnc_UnitInit
		class UnitInit {};
		//[] call DIS_fnc_CommsInit
		class CommsInit {};			
		//[] call DIS_fnc_HitEH
		class HITEH {};	
		//[] call DIS_fnc_ComKilled
		class ComKilled {};	
		//[] call DIS_fnc_ComReload
		class ComReload {};
		//[] call DIS_fnc_ComFired
		class ComFired {};
		//[] call DIS_fnc_IncomingMissile
		class IncomingMissile {};
	};
};

