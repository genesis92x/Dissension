private ["_Physical","_HeavyFactory", "_LightFactory", "_Aircraft", "_PlayerSide", "_BuildingList", "_Playerside", "_BuildingA", "_StructureName", "_Structure", "_ClosestStructure", "_ClosestStructureP", "_rnd", "_dist", "_dir", "_position", "_list", "_Road", "_CRoad", "_positionFIN", "_VehType", "_Textures", "_veh_list", "_OldVeh", "_textures", "_crew", "_CashAmount", "_CanPurchase", "_Defined", "_vehType", "_PreviewCost", "_xPosition", "_yPosition", "_NewXPosition", "_NewYPosition", "_RandomNumber", "_ui", "_TextColor2", "_TextColor", "_vehDir", "_count"];
disableSerialization;


//Lets create a marker near the closest structure. For now it doesn't matter what the structure is - as long as the necessary buildings are available.
_HeavyFactory = false;
_LightFactory = false;
_Aircraft = false;
_PlayerSide = "I FIGHT FOR NO MAN";
_BuildingList = "NO BUILDINGS FOR CHU";

if (side (group player) isEqualTo WEST) then
{
	_Playerside = "West";
	_BuildingList = W_BuildingList;
}
else
{
	_Playerside = "East";
	_BuildingList = E_BuildingList;
};

if (isNil "_BuildingList") exitWith
{
		_DI = "Initialization not complete. Come back later.";
		((findDisplay (3014)) displayCtrl (1100)) ctrlSetPosition [0,0];
		((findDisplay (3014)) displayCtrl (1100)) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>%1</t></t></t>",_DI]);	
		((findDisplay (3014)) displayCtrl (1100)) ctrlCommit 0;		
};

_BuildingA = [];
{
	_StructureName = _x select 1;
	_Structure = _x select 0;
	_BuildingA pushback _Structure;
	if (_StructureName isEqualTo "Light Factory") then {_LightFactory = true;};
	if (_StructureName isEqualTo "Heavy Factory") then {_HeavyFactory = true;};

} foreach _BuildingList;

_ClosestStructure = [_BuildingA,(getpos player),true] call dis_closestobj;

if (_ClosestStructure distance player > 150) exitWith {


		_DI = "TOO FAR FROM FRIENDLY STRUCTURE.";
		((findDisplay (3014)) displayCtrl (1100)) ctrlSetPosition [0,0];
		((findDisplay (3014)) displayCtrl (1100)) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>%1</t></t></t>",_DI]);	
		((findDisplay (3014)) displayCtrl (1100)) ctrlCommit 0;	



};


closeDialog 3014;

private _CfgCarsArray = [];
private _CfgLightArmorsArray = [];
private _CfgHeavyArmorsArray = [];
private _CfgHelicoptersArray = [];
private _CfgPlanesArray = [];
private _CfgUAVArray = [];

_PSide = side player call BIS_fnc_sideID;
{
	{
		if (_PSide isEqualTo getNumber(configfile/"CfgVehicles"/_x/"side")) then 
		{
			if (_x in CfgCarsArray) then {_CfgCarsArray pushback _x;};
			if (_x in CfgLightArmorsArray) then {_CfgLightArmorsArray pushback _x;};
			if (_x in CfgHeavyArmorsArray) then {_CfgHeavyArmorsArray pushback _x;};
			if (_x in CfgHelicoptersArray) then {_CfgHelicoptersArray pushback _x;};
			if (_x in CfgPlanesArray) then {_CfgPlanesArray pushback _x;};
			if (_x in CfgUAVArray) then {_CfgUAVArray pushback _x;};
		true;		
		};
	} count _x;
	true;
} count [CfgCarsArray,CfgLightArmorsArray,CfgHeavyArmorsArray,CfgHelicoptersArray,CfgPlanesArray,CfgUAVArray];






//This function will let the players purchase vehicles! Yay!
createDialog "Dis_VehiclePurchase";
disableSerialization;
((findDisplay (3016)) displayCtrl 1201) ctrlSetText "Pictures\Background.paa";  
((findDisplay (3016)) displayCtrl 1002) ctrlSetText (format ["Current Cash: %1",DIS_PCASHNUM]);

_display = (findDisplay 3016) displayCtrl 1500;
_display ctrlSetEventHandler ["LBSelChanged","[_this select 0,_this select 1] call dis_VehicleChanged"];

//((findDisplay (3016)) displayCtrl 1200) ctrlSetText "Pictures\Background.paa";  

//First we need to populate the listbox with all the vehicles the player has access to.

//Cars first 
{
	_SmallerArray = _x;
	_DisplayName = getText(configfile/"CfgVehicles"/_x/"displayName");
	_index = lbAdd [1500,format ["Light: %1",_DisplayName]];
	_picture = getText(configfile/"CfgVehicles"/_x/"Picture");	
	lbSetPicture [1500, _index, _picture];
	lbSetPictureColor [1500, _index, [0.78, 0.78, 0.78, 1]];	
	_RealData = lbSetData [1500,_index, format ["%1",_x]];
	true;
} count _CfgCarsArray;

//Medium 
{
	_SmallerArray = _x;
	_DisplayName = getText(configfile/"CfgVehicles"/_x/"displayName");
	_index = lbAdd [1500,format ["Medium: %1",_DisplayName]];
	_picture = getText(configfile/"CfgVehicles"/_x/"Picture");	
	lbSetPicture [1500, _index, _picture];
	lbSetPictureColor [1500, _index, [0.78, 0.78, 0.78, 1]];	
	_RealData = lbSetData [1500,_index, format ["%1",_x]];
	true;
} count _CfgLightArmorsArray;

//Heavy 
{
	_SmallerArray = _x;
	_DisplayName = getText(configfile/"CfgVehicles"/_x/"displayName");
	_index = lbAdd [1500,format ["Heavy: %1",_DisplayName]];
	_picture = getText(configfile/"CfgVehicles"/_x/"Picture");	
	lbSetPicture [1500, _index, _picture];
	lbSetPictureColor [1500, _index, [0.78, 0.78, 0.78, 1]];	
	_RealData = lbSetData [1500,_index, format ["%1",_x]];
	true;
} count _CfgHeavyArmorsArray;

//Helicopter 
{
	_SmallerArray = _x;
	_DisplayName = getText(configfile/"CfgVehicles"/_x/"displayName");
	_index = lbAdd [1500,format ["Helicopter: %1",_DisplayName]];
	_picture = getText(configfile/"CfgVehicles"/_x/"Picture");	
	lbSetPicture [1500, _index, _picture];
	lbSetPictureColor [1500, _index, [0.78, 0.78, 0.78, 1]];	
	_RealData = lbSetData [1500,_index, format ["%1",_x]];
	true;
} count _CfgHelicoptersArray;

//Planes 
{
	_SmallerArray = _x;
	_DisplayName = getText(configfile/"CfgVehicles"/_x/"displayName");
	_index = lbAdd [1500,format ["Plane: %1",_DisplayName]];
	_picture = getText(configfile/"CfgVehicles"/_x/"Picture");	
	lbSetPicture [1500, _index, _picture];
	lbSetPictureColor [1500, _index, [0.78, 0.78, 0.78, 1]];	
	_RealData = lbSetData [1500,_index, format ["%1",_x]];
	true;
} count _CfgPlanesArray;

//UAV 
{
	_SmallerArray = _x;
	_DisplayName = getText(configfile/"CfgVehicles"/_x/"displayName");
	_index = lbAdd [1500,format ["UAV: %1",_DisplayName]];
	_picture = getText(configfile/"CfgVehicles"/_x/"Picture");	
	lbSetPicture [1500, _index, _picture];
	lbSetPictureColor [1500, _index, [0.78, 0.78, 0.78, 1]];	
	_RealData = lbSetData [1500,_index, format ["%1",_x]];
	true;
} count _CfgUAVArray;
