//Pressing that recuit button!


//Are we close enough to recruit? And lets pull that recruit locationNull
private _Structures = "";
if ((side player) isEqualTo West) then
{
	_Structures = W_BuildingList;
}
else
{
	_Structures = E_BuildingList;
};

if (isNil "_Structures") exitWith
{
	_DI = "NOT INITIALIZED YET...COME BACK SOON.";
	hint format ["%1", _DI];
};

private _BarrackList = [];
{
	_Building = _x select 0;
	if !(isNil "_Building") then
	{
		_Type = _x select 1;
		if (_Type isEqualTo "Barracks") then {_BarrackList pushback (_x select 0);};
	};
} foreach _Structures;

if (_BarrackList isEqualTo []) exitWith
{
	_DI = "NO BARRACKS CREATED";
	hint format ["%1", _DI];
};

_NearestBuilding = [_BarrackList,player,true] call dis_closestobj;
if (_NearestBuilding distance player > 100) exitWith
{
	_DI = "TOO FAR FROM BARRACKS";
	hint format ["%1", _DI];
};



//We need to figure out what we need to do...does the unit spawn into the player group, or it's own group?
_control = (uiNamespace getVariable "RecruitUnits") displayCtrl 2800;
_controlLB = (uiNamespace getVariable "RecruitUnits") displayCtrl 1500;
_checked = ctrlChecked _control;

private _index = lbCurSel 1500;

if (_index isEqualTo -1) exitWith {};

private _PreData = _controlLB lbData _index;
private _Data = call compile _PreData;
systemChat format ["DATA: %1",_Data];

//	_Data = [_DisplayName,_Classname,_Cost,_Weapons];	
private _DisplayName = _Data select 0;
private _Classname = _Data select 1;
private _Cost = _Data select 2;
private _Weapons = _Data select 3;

private _PlayGroupLimit = "AIMaxInPlayerGroup" call BIS_fnc_getParamValue;
private _HighCommandLimit = "AIMaxInHighCommand" call BIS_fnc_getParamValue;

if (_checked) then
{
	if !((leader (group player)) isEqualTo player) exitWith {hint "You are not the squad leader!";};
	private _CountA = 0;
	{
		if !(isplayer _x) then
		{
			_CountA = _CountA + 1;
		};
	} foreach (units (group player));
	
	if (_PlayGroupLimit < (_CountA + 1)) exitWith {hint "Maxed AI reached!"};
	
	private _AI = (group player) createUnit [_Classname,(getpos _NearestBuilding), [], 0, "FORM"];

}
else
{

	private _PlayerHighCommand = player getVariable ["HighCommander",nil];
	private _PlayerHighCommandSub = player getVariable ["HighCommanderSub",nil];
	
	//Create the high commander :D
	if (isNil "_PlayerHighCommand") then
	{

		private _NewGroup = createGroup sideLogic;		
		private _PlayerHighCommand = _NewGroup createUnit ["HighCommand",[0,0,0],[],0,"NONE"];		
		private _PlayerHighCommandSub = _NewGroup createUnit ["HighCommanderSub",[0,0,0],[],0,"NONE"];		
		_PlayerHighCommand synchronizeObjectsAdd [player];	
		_PlayerHighCommand synchronizeObjectsAdd [_PlayerHighCommandSub];		
		player setvariable ["HighCommand",_PlayerHighCommand];
		player setvariable ["HighCommandSub",_PlayerHighCommandSub];
		hcRemoveAllGroups player;		
		Dis_PSpwnedCnt = [];
	};

	
	if (Dis_PSpwnedCnt > _HighCommandLimit) exitWith {hint "Maxed AI reached!"};

	private _AI = Dis_PlayerAIGroup createUnit [_Classname,(getpos _NearestBuilding), [], 0, "FORM"];
	_AI addEventHandler ["killed", {Dis_PSpwnedCnt = Dis_PSpwnedCnt - [(_this select 0)];}];
	Dis_PSpwnedCnt pushback _AI;



	
	_PlayerHighCommandSub synchronizeObjectsAdd [leader (group _AI)];
	


};
