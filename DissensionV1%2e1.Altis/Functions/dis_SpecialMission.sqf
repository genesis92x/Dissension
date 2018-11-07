//This function will create and monitor special missions created by commanders
params ["_CSide","_CPlaystyle"];

switch (_CPlaystyle) do 
{
    case "Guerrilla": {_CSide spawn (selectrandom [dis_GCamp,dis_GHarass,dis_GBomb,dis_GScout]);};														//Finished. Needs play testing.
    case "Support Enthusiast": {_CSide spawn (selectrandom [dis_SEDeploy,dis_SEArtySpawn,DIS_fnc_SEMedic,DIS_fnc_SECrate]);}; 	//Finished. Needs play testing.
    case "Private Military Contractor": {_CSide spawn (selectrandom [DIS_fnc_PMCReinforce,DIS_fnc_PMMilitiaBuy,DIS_fnc_PMCSupport,DIS_fnc_PMCParachute])};  //Finished. Needs play testing. 																																									
    case "Defensive": {_CSide spawn (selectrandom [dis_SEDeploy,DIS_fnc_DefenceSpawn,DIS_fnc_CloseCapture])}; //Finished. Needs play testing.
    case "Agressive": {_CSide spawn (selectrandom [DIS_fnc_ACapture,DIS_fnc_AAirCapture])}; 	//Finished. Needs play testing.
};

//West spawn dis_SEArtySpawn;