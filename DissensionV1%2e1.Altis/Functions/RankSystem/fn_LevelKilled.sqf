//Function that handles ONKILLED event handler for the leveling system.

private _KilledUnit = _this select 0;
private _Killer = _this select 1;
private _instigator = _this select 2;
if (ACEACTIVATED) then
{
	_Killer = _KilledUnit getVariable ["ace_medical_lastDamageSource", objNull];
	if (player isEqualTo _KilledUnit && {!(_Killer isEqualTo player)}) then 
	{
			disableSerialization;
 			_RandomNumber = random 10000;
			_TextColor = '#E31F00';		
			_xPosition = 0.15375 * safezoneW + safezoneX;
			_yPosition = 0.201 * safezoneH + safezoneY;     
				
			_randomvariableX = random 0.05;	
			_randomvariableY = random 0.05;
			
			_NewXPosition = _xPosition - _randomvariableX;
			_NewYPosition = _yPosition - _randomvariableY;
			
			_RandomNumber cutRsc ["KOZHUD_3","PLAIN"];
			_ui = uiNamespace getVariable "KOZHUD_3";
			(_ui displayCtrl 1100) ctrlSetPosition [_NewXPosition,_NewYPosition];
			(_ui displayCtrl 1100) ctrlCommit 0; 
			(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>You were killed by: <t color='%2'>%1</t> </t></t></t>",name _Killer,_TextColor]);
			_RandomNumber cutFadeOut 30;		
	};
	
}
else
{
	if (player isEqualTo _KilledUnit && {!(_Killer isEqualTo player)}) then 
	{
			disableSerialization;
 			_RandomNumber = random 10000;
			_TextColor = '#E31F00';			
			_xPosition = 0.15375 * safezoneW + safezoneX;
			_yPosition = 0.201 * safezoneH + safezoneY;     
				
			_randomvariableX = random 0.05;
			_randomvariableY = random 0.05;
			
			_NewXPosition = _xPosition - _randomvariableX;
			_NewYPosition = _yPosition - _randomvariableY;
			
			_RandomNumber cutRsc ["KOZHUD_3","PLAIN"];
			_ui = uiNamespace getVariable "KOZHUD_3";
			(_ui displayCtrl 1100) ctrlSetPosition [_NewXPosition,_NewYPosition];
			(_ui displayCtrl 1100) ctrlCommit 0; 
			(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>You were killed by: <t color='%2'>%1</t> </t></t></t>",name _Killer,_TextColor]);
			_RandomNumber cutFadeOut 30;		
	};
};

//If the killed unit is a player, add one to his death counter.
if (isPlayer _KilledUnit) then {DIS_Deaths = DIS_Deaths + 1;};
if (!(isPlayer _Killer) || ((typeName _Killer) isEqualTo "STRING")) exitWith {};
if (_Killer isEqualTo _KilledUnit) exitWith {};


//Add a death to the killed player


if (!(isNil "_Killer") && {!(isNull _Killer)}) then
{
  private _KilledSide = side (group _KilledUnit);
	private _KillerSide = side (group _Killer);
	private _InVeh = _KilledUnit isEqualTo (vehicle _KilledUnit);
	
	//Change the text color depending on the side of the unit
	private _TextColor = '#FDEE05';
	switch (_KilledSide) do 
	{
		case East: {_TextColor = '#E31F00'};
		case West: {_TextColor = '#0A52F7'};
		case Resistance: {_TextColor = '#02FF09'};
		default {_TextColor = '#FDEE05'};
	};	
	
	//If this is a friendly fire, we should subtract money.
   if (_KilledSide isEqualTo _KillerSide) exitWith 
	{
			[
			[_Killer],
			{
				private _Killer = _this select 0;
				private _XPGained = 0;
				disableSerialization;
				private _RandomNumber = random 10000;
				private _TextColor = '#E31F00';			
				private _xPosition = 0.15375 * safezoneW + safezoneX;
				private _yPosition = 0.201 * safezoneH + safezoneY;     
					
				private _randomvariableX = random 0.05;
				private _randomvariableY = random 0.10;
				
				private _NewXPosition = _xPosition - _randomvariableX;
				private _NewYPosition = _yPosition - _randomvariableY;				
				private _ui = uiNamespace getVariable "KOZHUD_4";
				_RandomNumber cutRsc ["KOZHUD_4","PLAIN"];
				(_ui displayCtrl 1100) ctrlSetPosition [_NewXPosition,_NewYPosition];
				(_ui displayCtrl 1100) ctrlCommit 0;     
				(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'><t color='%2'>-%3 CASH</t> </t></t></t>",_XPGained,_TextColor,_CashGain]);
				_RandomNumber cutFadeOut 10;
				DIS_PCASHNUM = DIS_PCASHNUM - 250;				
			}] remoteExec ["BIS_fnc_call",_Killer];	

	};
	
			private _justPlayers = allPlayers - entities "HeadlessClient_F";
			private _Nearby = _justPlayers select {(side _x isEqualTo side _Killer)};
			if (_Killer in _Nearby) then {_Nearby = _Nearby - [_Killer]};
			{
				if !(isNil "_x") then
				{
					[
					[_Killer],
					{
						_OriginalPlayer = _this select 0;
						if (player distance _OriginalPlayer < 35 && {alive player}) then
						{
							disableSerialization;
							_XPGained = 5;
							if !(_OriginalPlayer isEqualTo (vehicle _OriginalPlayer)) then {_XPGained = 2;};
							private _RandomNumber = random 10000;
							private _TextColor = '#F1E100';
							
							private _xPosition = 0.15375 * safezoneW + safezoneX;
							private _yPosition = 0.201 * safezoneH + safezoneY;     
								
							private _randomvariableX = random 0.05;
							private _randomvariableY = random 0.05;
							
							private _NewXPosition = _xPosition - _randomvariableX;
							private _NewYPosition = _yPosition - _randomvariableY;
							
							_RandomNumber cutRsc ["KOZHUD_3","PLAIN"];
							private _ui = uiNamespace getVariable "KOZHUD_3";
							(_ui displayCtrl 1100) ctrlSetPosition [_NewXPosition,_NewYPosition];
							(_ui displayCtrl 1100) ctrlCommit 0; 
							(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>+25$ and %3 XP From:<t color='%2'>%1</t> </t></t></t>",name _OriginalPlayer,_TextColor,_XPGained]);
							_RandomNumber cutFadeOut 10;
							DIS_PCASHNUM = DIS_PCASHNUM + 25;
							DIS_Experience = DIS_Experience + _XPGained;
							playsound "readoutClick";
						};
					}
					
					] remoteExec ["BIS_fnc_call",_x];
				};
			} foreach _Nearby;	
	
		
			[
			[_Killer,_KilledUnit,_TextColor],
			{
					params ["_Killer","_KilledUnit","_TextColor"];
					//Give the killer money for making the kill
					disableSerialization;
					_RandomNumber = random 10000;
					
					_xPosition = 0.15375 * safezoneW + safezoneX;
					_yPosition = 0.201 * safezoneH + safezoneY;     
						
					_randomvariableX = random 0.05;
					_randomvariableY = random 0.05;
					
					_NewXPosition = _xPosition - _randomvariableX;
					_NewYPosition = _yPosition - _randomvariableY;
					
					_RandomNumber cutRsc ["KOZHUD_3","PLAIN"];
					_ui = uiNamespace getVariable "KOZHUD_3";
					(_ui displayCtrl 1100) ctrlSetPosition [_NewXPosition,_NewYPosition];
					(_ui displayCtrl 1100) ctrlCommit 0; 
					(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>You killed: <t color='%2'>%1</t> </t></t></t>",name _KilledUnit,_TextColor]);
					_RandomNumber cutFadeOut 10;		
					
					[(_ui displayCtrl 1100),_NewYPosition,_NewXPosition] spawn
					{
						sleep 2;
						disableSerialization;
						params ["_Control","_OrgYPos","_OrgXPos"];
						_control ctrlsetposition [_OrgXPos,-1];
						_control ctrlCommit 5;
					};					
					
					//Distance Bonus
					private _DstB = false;
					private _DstC = 0;
					private _FDist = 0;
					
					_XPGained = 10;
					if !(_Killer isEqualTo (vehicle _Killer)) then {_XPGained = 2;} 
					else 
					{
						_FDist = round (_Killer distance _KilledUnit);
						if (_FDist > 200) then
						{
							_DstC = _DstC + (round (_FDist / 10));
							_DstB = true;							
						};
					};
					_CashGain = (50 + _DstC);
					_xPosition = 0.15375 * safezoneW + safezoneX;
					_yPosition = 0.180 * safezoneH + safezoneY;     
					
					_NewXPosition = _xPosition - _randomvariableX;
					_NewYPosition = _yPosition - _randomvariableY;				
					(_RandomNumber + 1) cutRsc ["KOZHUD_4","PLAIN"];
					_ui2 = uiNamespace getVariable "KOZHUD_4";					
					(_ui2 displayCtrl 1100) ctrlSetPosition [_NewXPosition,_NewYPosition];
					(_ui2 displayCtrl 1100) ctrlCommit 0;     
					(_ui2 displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'><t color='%2'>+%1 XP +%3 CASH <t color='#FDEE05'>%4 METERS</t></t></t></t></t>",_XPGained,_TextColor,_CashGain,_FDist]);
					(_RandomNumber + 1) cutFadeOut 10;
					DIS_PCASHNUM = DIS_PCASHNUM + _CashGain;
					DIS_Experience = DIS_Experience + _XPGained;
					DIS_KillCount = DIS_KillCount + 1;
					playsound "readoutClick";
					
					[(_ui2 displayCtrl 1100),_NewYPosition,_NewXPosition] spawn
					{
						sleep 2;					
						disableSerialization;
						params ["_Control","_OrgYPos","_OrgXPos"];
						_control ctrlsetposition [_OrgXPos,-1];
						_control ctrlCommit 5;
					};

					
					
			}] remoteExec ["BIS_fnc_call",_Killer];
		
};

/*

*/

