//This is how people will purchase gear and what-not.

dis_PlayerLoadout =
{
	
	_Unit = _this select 0;
	
	//Grab old information incase player goes over on certs.
	
	
	_primaryWeaponMagazine = "";
	_secondaryWeaponMagazine = "";
	_handgunMagazine = "";
	{
		if (count _x > 4) then {
			private ["_weapon","_magazine"];
			_weapon = (_x select 0);
			_magazine = _x select 4;
			switch _weapon do {
				case (primaryweapon _Unit): {_primaryWeaponMagazine = _magazine;};
				case (secondaryweapon _Unit): {_secondaryWeaponMagazine = _magazine;};
				case (handgunweapon _Unit): {_handgunMagazine = _magazine;};
			};
		};
	} foreach weaponsitems _Unit;
	
	_InventoryExporting2 = [
			uniform _Unit,uniformitems _Unit,
			vest _Unit,vestitems _Unit,
			backpack _Unit,backpackitems _Unit,
			headgear _Unit,
			goggles _Unit,
			binocular _Unit,
			primaryweapon _Unit,_Unit weaponaccessories primaryweapon _Unit,_primaryWeaponMagazine,
			secondaryweapon _Unit,_Unit weaponaccessories secondaryweapon _Unit,_secondaryWeaponMagazine,
			handgunweapon _Unit,_Unit weaponaccessories handgunweapon _Unit,_handgunMagazine,
			(assigneditems _Unit - [binocular _Unit])
	];
	
	
	{
	if ((typeName _x) isEqualTo "ARRAY") then { {_InventoryExporting2 pushback _x}foreach _x; _InventoryExporting2 = _InventoryExporting2 - [_x]; };
	} foreach _InventoryExporting2;
	
_InventoryExporting2	
	
};

dis_ArsenalShop =
{
private ["_TextColor2","_CfgWeaponsArray","_OriginalCost", "_Unit", "_TextColor", "_PlayersLoadout", "_CashAmount", "_NewCost", "_PreviewCost", "_xPosition", "_yPosition", "_NewXPosition", "_NewYPosition", "_RandomNumber", "_ui"];
	_OriginalCost = _this select 1;
	_Unit = _this select 0;
	_OriginalLoadout = _this select 2;
	_TextColor = '#FDEE05';
	_CanPurchase = true;
 	_ExportedInventory = [] call Dis_ExportInventory;
	
	while {KOZ_ARSENALOPEN} do
	{
		_PlayersLoadout = [_Unit] call dis_PlayerLoadout;
		private _RtrnCashAmount = _PlayersLoadout call dis_fnc_LoadoutCost;
		private _CashAmount = _RtrnCashAmount select 0;
		private _Violation = _RtrnCashAmount select 1;
		_CfgWeaponsArray = [];
		_CfgHeavyArray = [];
		_CfgAttachmentsArray = [];
		_CfgEquipmentArray = [];
		_CfgVestsArray = [];
		_CfgHelmetsArray = [];
		_CfgPistolArray = [];
		_CfgLauncherArray = [];
		_CfgRucksArray  = [];
		_CfgLightMagazine = [];
		_CfgPistolMagazine = [];
		_CfgHeavyMagazine = [];
		_CfgLauncherMagazine = [];
		_CfgFlareMagazine = [];
		_CfgGrenadeMagazine  = [];
		_CfgUnknownMagazine = [];	

		_NewCost = _CashAmount - _OriginalCost;
		_PreviewCost = DIS_PCASHNUM - _NewCost;
		  

			
			_xPosition = 0.29375 * safezoneW + safezoneX;
			_yPosition = 0.401 * safezoneH + safezoneY;     

			
			_NewXPosition = _xPosition;
			_NewYPosition = _yPosition;
			
			disableSerialization;	
			_RandomNumber = random 10000;
			_RandomNumber cutRsc ["KOZHUD_3","PLAIN",0,true];
			_ui = uiNamespace getVariable "KOZHUD_3";
			(_ui displayCtrl 1100) ctrlSetPosition [_NewXPosition,_NewYPosition];
			(_ui displayCtrl 1100) ctrlCommit 0;			
			
			_TextColor2 = '#FDEE05';
			if (_PreviewCost < 0 || _Violation) then
			{
				_TextColor2 = '#FC2E12';
				_CanPurchase = false;
			}
			else
			{
				_CanPurchase = true;
			};
			if (_NewCost < 0) then
			{
				_TextColor2 = '#00EF01';					
			};
			
			
			
			(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format 
			[
			"<t shadow='true' shadowColor='000000'><t size='0.8'><t align='left'>Current Cash: <t color='%2'>%1</t> </t></t></t><br/>
			<t shadow='true' shadowColor='000000'><t size='0.8'><t align='left'>Cost: <t color='%2'>%3</t> </t></t></t><br/>
			<t shadow='true' shadowColor='000000'><t size='0.8'><t align='left'>SubTotal: <t color='%5'>%4</t> </t></t></t><br/>
			
			
			",DIS_PCASHNUM,_TextColor,_NewCost,_PreviewCost,_TextColor2
			]);
			
			_RandomNumber cutFadeOut 0.05;
		
		
		
		
		
	};
	
	if (_CanPurchase) then
	{
		DIS_PCASHNUM = DIS_PCASHNUM - _NewCost;
		if (_NewCost < 0) then
		{
			playsound "Sell";
		}
		else
		{
			playsound "Purchase";
		};
	}
	else
	{
		    [] spawn compile _ExportedInventory;	
			 if (playerSide isEqualTo west) then {playsound "EVAInsufficentFunds"} else {playsound "LEGIONInsufficentFunds"};
	};
	
};



Dis_ExportInventory = {

/*
	Author: Karel Moricky - Modified by Genesis92x to save loadout to variable. THANKS KAREL!!!

	Description:
	Export unit's loadout

	Parameter(s):
		0: OBJECT - unit of which loadout will be export
		1: STRING - export type
			"script" - scripting commands, target is referred to as _unit
			"init" - scripting commands, target is referred to as this
			"config" - CfgVehicles attributes
		2: BOOL - true to export identity (face, voice and insignia)

	Returns:
	STRING - SQF code
*/


_center = [_this,0,player,[objnull]] call bis_fnc_param;
_type = [_this,1,"script",[""]] call bis_fnc_param;
_identity = [_this,2,true,[true]] call bis_fnc_param;

_br = tostring [13,10];
_export = "";
switch _type do {

	case "script";
	case "init": {
		_fnc_addMultiple = {
			_items = _this select 0;
			_expression = _this select 1;
			_itemsUsed = [];
			{
				_item = _x;
				_itemLower = tolower _x;
				if !(_itemLower in _itemsUsed) then {
					_itemsUsed set [count _itemsUsed,_itemLower];
					_itemCount = {_item == _x} count _items;
					_expressionLocal = _expression;
					if (_itemCount > 1) then {
						_expressionLocal = format ["for ""_i"" from 1 to %1 do {%2};",_itemCount,_expression];
					};
					_export = _export + format [_expressionLocal,_var,_x] + _br;
				};
			} foreach _items;
		};
		_fnc_addComment = {
			_export = _export + _br;
			if (_type == "script") then {_export = _export + format ["// %1",_this]} else {_export = _export + format ["comment ""%1"";",_this]};
			_export = _export + _br;
		};

		//--- Arsenal label
		if !(isnil {uinamespace getvariable "BIS_fnc_arsenal_display"}) then {
			if (true) then {
				private "_br";
				_br = "";
				//(format ["Exported from Arsenal by %1",profilename]) call _fnc_addComment;
			};
			_export = _export + _br;
		};

		_var = if (_type == "script") then {
			_export = _export + "_unit = player;" + _br;
			"_unit";
		} else {
			"this"
		};
		//"Remove existing items" call _fnc_addComment;
		_export = _export + format ["removeAllWeapons %1;",_var] + _br;
		_export = _export + format ["removeAllItems %1;",_var] + _br;
		_export = _export + format ["removeAllAssignedItems %1;",_var] + _br;
		_export = _export + format ["removeUniform %1;",_var] + _br;
		_export = _export + format ["removeVest %1;",_var] + _br;
		_export = _export + format ["removeBackpack %1;",_var] + _br;
		_export = _export + format ["removeHeadgear %1;",_var] + _br;
		_export = _export + format ["removeGoggles %1;",_var] + _br;

		//"Add containers" call _fnc_addComment;
		if (uniform _center != "") then {
			_export = _export + format ["%1 forceAddUniform ""%2"";",_var,uniform _center] + _br;
			[uniformitems _center,"%1 addItemToUniform ""%2"";"] call _fnc_addMultiple;
		};

		if (vest _center != "") then {
			_export = _export + format ["%1 addVest ""%2"";",_var,vest _center] + _br;
			[vestitems _center,"%1 addItemToVest ""%2"";"] call _fnc_addMultiple;
		};

		if (!isnull unitbackpack _center) then {
			_export = _export + format ["%1 addBackpack ""%2"";",_var,typeof unitbackpack _center] + _br;
			[backpackitems _center,"%1 addItemToBackpack ""%2"";"] call _fnc_addMultiple;
		};

		if (headgear _center != "") then {_export = _export + format ["%1 addHeadgear ""%2"";",_var,headgear _center] + _br;};
		if (goggles _center != "") then {_export = _export + format ["%1 addGoggles ""%2"";",_var,goggles _center] + _br;};

		//--- Weapons
		//"Add weapons" call _fnc_addComment;
		{		
			_weapon = _x select 0;
			_weaponAccessories = _x select 1;
			_weaponCommand = _x select 2;
			if (_weapon != "") then {
				_export = _export + format ["%1 addWeapon ""%2"";",_var,_weapon] + _br;
				{
					if (_x != "") then {_export = _export + format ["%1 %3 ""%2"";",_var,_x,_weaponCommand] + _br;};
				} foreach _weaponAccessories;
			};
		} foreach [
			[primaryweapon _center,_center weaponaccessories primaryweapon _center,"addPrimaryWeaponItem"],
			[secondaryweapon _center,_center weaponaccessories secondaryweapon _center,"addSecondaryWeaponItem"],
			[handgunweapon _center,_center weaponaccessories handgunweapon _center,"addHandgunItem"],
			[binocular _center,[],""]
		];

		//--- Items
		//"Add items" call _fnc_addComment;
		[assigneditems _center - [binocular _center],"%1 linkItem ""%2"";"] call _fnc_addMultiple;

		if (_identity) then {
			//"Set identity" call _fnc_addComment;
			_export = _export + format ["%1 setFace ""%2"";",_var,_center getvariable ["BIS_fnc_arsenal_face",face _center]] + _br;
			_export = _export + format ["%1 setSpeaker ""%2"";",_var,speaker _center] + _br;

			_insignia = _center call bis_fnc_getUnitInsignia;
			if (_insignia != "") then {_export = _export + format ["[%1,""%2""] call bis_fnc_setUnitInsignia;",_var,_insignia] + _br;};
		};
	};
	case "config": {
		_fnc_addArray = {
			_name = _this select 0;
			_array = _this select 1;

			_export = _export + format ["%1[] = {",_name];
			{
				if (_foreachindex > 0) then {_export = _export + ",";};
				_export = _export + format ["""%1""",_x];
			} foreach _array;
			_export = _export + "};" + _br;
		};

		//--- Arsenal label
		if !(isnil {uinamespace getvariable "BIS_fnc_arsenal_display"}) then {
			_export = _export + format ["// Exported from Arsenal by %1",profilename] + _br;
		};

		_export = _export + format ["uniform = ""%1"";",uniform _center] + _br;
		_export = _export + format ["backpack = ""%1"";",backpack _center] + _br;

		["weapons",weapons _center + ["Throw","Put"]] call _fnc_addArray;
		["magazines",magazines _center] call _fnc_addArray;
		["items",items _center] call _fnc_addArray;
		["linkedItems",[vest _center,headgear _center,goggles _center] + assigneditems _center - weapons _center] call _fnc_addArray;

	};
};

_export



};
