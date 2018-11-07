//0.0063 - 10000
_result = diag_codePerformance 
[
{

_MissionList = [];
{0 = _MissionList pushback _x;} count ["Deploy Mines","Harass Enemy"];
systemchat format ["%1",_MissionList];
}
, 
0, 
10000

];

systemchat format ["%1",_result];








//0.0099 - 10000
//With systemChat format -> 0.0139 - 10000
//Without hintsilent "YAY"; -> 0.0078 - 10000
_result = diag_codePerformance 
[
{
_CPlaystyle = "Guerrilla";

_MissionList = ["Bomb Defusal","Hostage Rescue","Ambush","Destroy","Escort","Defence","Recon"];

switch (_CPlaystyle) do {
    case "Guerrilla": { {0 = _MissionList pushback _x} count ["Deploy Mines","Harass Enemy"];};
    case "Support Enthusiast": {  hintsilent "YAY";}; 
    case "Private Military Contractor": {  hintsilent "YAY";}; 
    case "Cautious": {  hintsilent "YAY";}; 
    case "Evasive": {  hintsilent "YAY";}; 
    case "Defensive": {  hintsilent "YAY";}; 
    case "Shock and Awe": {  hintsilent "YAY";}; 		
};
}
, 
0, 
10000

];

systemchat format ["%1",_result];


//0.0029 - 10000
//With 	W_CMissionList = ["Bomb Defusal","Hostage Rescue"]; -> 0.0036 - 10000
//	{if (_x in _MissionList) then {_MissionList = _MissionList - [_x]}} count W_CMissionList; -> 0.0089 - 10000
_result = diag_codePerformance 
[
{
	W_CMissionList = ["Bomb Defusal","Hostage Rescue"];
	_MissionList = ["Bomb Defusal","Hostage Rescue","Ambush","Destroy","Escort","Defence","Recon"];
	{if (_x in _MissionList) then {_MissionList = _MissionList - [_x]}} count W_CMissionList;
}
, 
0, 
10000

];
systemchat format ["%1",_result];