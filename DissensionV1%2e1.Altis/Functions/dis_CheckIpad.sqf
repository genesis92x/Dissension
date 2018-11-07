private ["_display", "_TemporaryArray", "_SmallerArray", "_Title", "_index", "_NewInformation", "_RealData","_NewsArray"];
#define dis_IpadMenu	(3014)
createDialog "dis_IPAD";
disableSerialization;
((findDisplay (3014)) displayCtrl 1200) ctrlSetText "Pictures\IPad.paa";  
((findDisplay (3014)) displayCtrl (1100)) ctrlSetPosition [0,0];
((findDisplay (3014)) displayCtrl (1100)) ctrlCommit 0;
((findDisplay (3014)) displayCtrl (1500)) ctrlSetEventHandler ["KeyDown","_this call DIS_IMPressed"];

((findDisplay (3014)) displayCtrl 1600) ctrlSetPosition [-0.051,0.5,0.1,0.1];
((findDisplay (3014)) displayCtrl (1600)) ctrlCommit 0;



_Side = (side (group player));
if (_Side isEqualTo West) then
{
	_NewsArray = dis_WNewsArray;
}
else
{
	_NewsArray = dis_ENewsArray;
};


_display = (findDisplay 3014) displayCtrl 1500;
_display ctrlSetEventHandler ["LBSelChanged","[_this select 0,_this select 1] call dis_IpadLBChanged"];

_TemporaryArray = _NewsArray;
_Counter = (count _NewsArray) + 1;
{
	_Counter = _Counter - 1;
	_SmallerArray = _x;
	
	_Title = _SmallerArray select 0;
	_index = lbAdd [1500,format ["%1: %2",_Counter,_Title]];
	_SmallerArray = _SmallerArray - [_Title];
	_NewInformation = [];
	
	{
		_NewInformation pushback _x;
	} foreach _SmallerArray;
	
	_RealData = lbSetData [1500,_index,format ["%1",_NewInformation]];
	


} foreach _TemporaryArray;

	_size = lbSize 1500;
	lbSetCurSel [1500,_size];
//lbSortByValue ((findDisplay (3014)) displayCtrl (1500));