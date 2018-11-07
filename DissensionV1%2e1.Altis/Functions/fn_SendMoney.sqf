//Send that money!

_tree = ((findDisplay 27000) displayCtrl (27100));
_sel = tvCurSel _tree;
_Classname = _tree tvData _sel;
_sel = tvCurSel _tree;
if ((DIS_PCASHNUM - 500) < 0) exitWith {systemchat "You don't have enough money.";if (playerSide isEqualTo west) then {playsound "EVAInsufficentFunds"} else {playsound "LEGIONInsufficentFunds"};};
systemChat format ["You sent $500 to %1",_Classname];
DIS_PCASHNUM = DIS_PCASHNUM - 500;
if (playerSide isEqualTo west) then {playsound "EVAFundsTransferred"} else {playsound "LEGIONFundsTransferred"};
[
[_Classname,player],
{
	params ["_You","_SentPlayer"];
	systemChat format ["You recieved $500 from %1",(name _SentPlayer)];
	DIS_PCASHNUM = DIS_PCASHNUM + 500;
}

] remoteExec ["bis_fnc_Spawn",_Classname]; 
