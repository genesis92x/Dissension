//This function is for the commanders voice! A single function to hold all the voice outcomes and etc.
//[West,1] call DIS_fnc_CommanderSpeak;
params ["_Side","_Num"];
private _CL = "CommanderLanguage" call BIS_fnc_getParamValue;
if (_CL isEqualTo 0) exitWith {};
switch (_Side) do {
   case West: 
	{
		switch (_Num) do 
		{
			//New Mission Assigned.
			case 1:
			{
				["EVANewMissionObj"] remoteExec ["PlaySoundEverywhere",West];
			};
			//Construction Complete
			case 2:
			{
				["EVABuildingOnline"] remoteExec ["PlaySoundEverywhere",West];
			};
			//BuildingLost
			case 3:
			{
				["EVABuildingLost"] remoteExec ["PlaySoundEverywhere",West];
			};		
			//Control Point Captured
			case 4:
			{
				["EVAControlPointCaptured"] remoteExec ["PlaySoundEverywhere",West];
			};
			//Control Point Lost
			case 5:
			{
				["EVAControlPointLost"] remoteExec ["PlaySoundEverywhere",West];
			};
			//Critical Structure Under Attack
			case 6:
			{
				["EVACriticalStructureAttacked"] remoteExec ["PlaySoundEverywhere",West];
			};
			//Enemy Base Sighted
			case 7:
			{
				["EVAEnemyBaseSighted"] remoteExec ["PlaySoundEverywhere",West];
			};
			//Enemy Defeated
			case 8:
			{
				["EVAEnemyDefeated"] remoteExec ["PlaySoundEverywhere",West];
			};
			//Enemy Player
			case 9:
			{
				["EVAEnemyPlayer"] remoteExec ["PlaySoundEverywhere",West];
			};
			//Enemy Units
			case 10:
			{
				["EVAEnemyUnits"] remoteExec ["PlaySoundEverywhere",West];
			};
			//Reinforcements Arrived
			case 11:
			{
				["EVAReinforcements"] remoteExec ["PlaySoundEverywhere",West];
			};				
		};
	};
   case East: 
	{
		switch (_Num) do 
		{
			//New Mission Assigned.	 
			case 1:
			{
				["LEGIONNewMissionObj"] remoteExec ["PlaySoundEverywhere",East];
			};		
			//Construction Complete
			case 2:
			{
				["LEGIONBuildingOnline"] remoteExec ["PlaySoundEverywhere",East];
			};
			//BuildingLost
			case 3:
			{
				["LEGIONBuildingLost"] remoteExec ["PlaySoundEverywhere",East];
			};
			//Control Point Captured
			case 4:
			{
				["LEGIONControlPointCaptured"] remoteExec ["PlaySoundEverywhere",East];
			};
			//Control Point Lost
			case 5:
			{
				["LEGIONControlPointLost"] remoteExec ["PlaySoundEverywhere",East];
			};
			//Critical Structure Under Attack
			case 6:
			{
				["LEGIONCriticalStructureAttacked"] remoteExec ["PlaySoundEverywhere",East];
			};
			//Enemy Base Sighted
			case 7:
			{
				["LEGIONEnemyBaseSighted"] remoteExec ["PlaySoundEverywhere",East];
			};	
			//Enemy Defeated
			case 8:
			{
				["LEGIONEnemyDefeated"] remoteExec ["PlaySoundEverywhere",East];
			};
			//Enemy Player
			case 9:
			{
				["LEGIONEnemyPlayer"] remoteExec ["PlaySoundEverywhere",East];
			};
			//Enemy Units
			case 10:
			{
				["LEGIONEnemyUnits"] remoteExec ["PlaySoundEverywhere",East];
			};
			//Reinforcements Arrived
			case 11:
			{
				["LEGIONReinforcements"] remoteExec ["PlaySoundEverywhere",East];
			};
		};
	};
    case resistance:
	 {
		
	 };
	 default {};
};

