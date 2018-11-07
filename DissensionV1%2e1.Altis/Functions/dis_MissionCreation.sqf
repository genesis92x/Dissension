//This function will create and monitor mission status for west and east sides
private _CSide = _this select 0;
private _CPlaystyle = _this select 1;

private _MissionList = ["Bomb Defusal","Hostage Rescue","Destroy","Escort","Defence","Ambush"];
if !(CASEBOMB isEqualTo []) then
{
	if (alive CASEBOMB) then {_MissionList = _MissionList - ["Bomb Defusal"]};
};

/*
NEW::THIS WILL BE WHERE SPECIFIC MISSION COME INTO PLAY FOR PERSONALITIES ONCE THE ENEMY IS CLOSE ENOUGH. HAVE THE VARIABLE TO CHECK BE GLOBAL? SO THE FUNCTION DOES NOT HAVE TO RUN OVER AND OVER?
This is blocked out due to no unique missions yet
switch (_CPlaystyle) do {
    case "Guerrilla": { {0 = _MissionList pushback _x} count ["Harass Enemy"];};
    case "Support Enthusiast": {  {0 = _MissionList pushback _x} count ["Harass Enemy"];}; 
    case "Private Military Contractor": {  {0 = _MissionList pushback _x} count ["Harass Enemy"];}; 
    case "Cautious": {  {0 = _MissionList pushback _x} count ["Harass Enemy"];}; 
    case "Evasive": {  {0 = _MissionList pushback _x} count ["Harass Enemy"];}; 
    case "Defensive": {  {0 = _MissionList pushback _x} count ["Harass Enemy"];}; 
    case "Shock and Awe": {  {0 = _MissionList pushback _x} count ["Harass Enemy"];}; 		
};
*/

if (_CSide isEqualTo "West") then
{
	//W_CMissionList
	//Remove missions we already have done recently
	_MissionList = _MissionList - W_CMissionList;
	
	//If the mission list is empty, due to completing all the missions, then reset the mission list
	if (_MissionList isEqualTo []) then {_MissionList = ["Bomb Defusal","Hostage Rescue","Ambush","Destroy","Escort","Defence"];};
	
	if !(CASEBOMB isEqualType []) then
	{
		if ("Bomb Defusal" in _MissionList && alive CASEBOMB) then {_MissionList = _MissionList - ["Bomb Defusal"];};
	};
	_SelectedMission = selectRandom _MissionList;
	
	switch (_SelectedMission) do {
			case "Bomb Defusal": {_CSide spawn Dis_BombDefusal;};
			case "Hostage Rescue": {_CSide spawn Dis_HostageRescue;};
			case "Ambush": {_CSide spawn Dis_Ambush;};
			case "Destroy": {_CSide spawn Dis_Destroy;};
			case "Escort": {_CSide spawn Dis_Escort;};
			case "Defence": {_CSide spawn Dis_Defence;};
	};	
	

	
	
	
}
else
{
	//W_CMissionList
	//Remove missions we already have done recently
	_MissionList = _MissionList - E_CMissionList;
	
	//If the mission list is empty, due to completing all the missions, then reset the mission list
	if (_MissionList isEqualTo []) then {_MissionList = ["Bomb Defusal","Hostage Rescue","Ambush","Destroy","Escort","Defence"];};
	
	if !(CASEBOMB isEqualType []) then
	{
		if ("Bomb Defusal" in _MissionList && alive CASEBOMB) then {_MissionList = _MissionList - ["Bomb Defusal"];};	
	};
	
	_SelectedMission = selectRandom _MissionList;
	
	switch (_SelectedMission) do {
			case "Bomb Defusal": {_CSide spawn Dis_BombDefusal;};
			case "Hostage Rescue": {_CSide spawn Dis_HostageRescue;};
			case "Ambush": {_CSide spawn Dis_Ambush;};
			case "Destroy": {_CSide spawn Dis_Destroy;};
			case "Escort": {_CSide spawn Dis_Escort;};
			case "Defence": {_CSide spawn Dis_Defence;};
	};	
		
};