//This function will keep on adding resources for each commander and the such
		
		//W_RArray = [W_Oil,W_Power,W_Cash,W_Materials];
	//	W_RArray = 	[		100,			100,			100,				100];
	//ResourceIncomeRate
private _ResourceTimer = "ResourceIncomeRate" call BIS_fnc_getParamValue;
	
dis_KeepCounting = true;
waitUntil
{
	sleep _ResourceTimer;
	{
		if !(DIS_DISABLED) then
		{
			if (_x isEqualTo West) then
			{
			
				//		_NewArray = [_marker1Names,_locationName,_FlagPole,_marker1,0,0,0,false,20];
				_AdditionalTickets = 5;
				_PoleArray = [];
				_NewCash = 15;
				_NewPower = 15;
				_NewOil = 15;
				_NewMaterials = 250;
				private _PTake = 0;
				{
					if ((_x select 2) in BluControlledArray) then
					{
						_AdditionalTickets = _AdditionalTickets + 5;
						_PoleArray pushback (_x select 2);
					};
				} foreach TownArray;
				
	
				{
					_Pole = _x;
					{
						if (_Pole isEqualTo (_x select 0)) then
						{
						//[_Pole,[_CashFlowRandom,_PowerFlowRandom,_OilFlowRandom,_MaterialsFlowRandom],_Loc,_Pos];
							_NewCash = _NewCash + ((_x select 1) select 0);
							_NewPower = _NewPower + ((_x select 1) select 1);
							_NewOil = _NewOil + ((_x select 1) select 2);
							_NewMaterials = _NewMaterials + ((_x select 1) select 3);
							_PTake = _PTake + 50;
						};
					} foreach CompleteTaskResourceArray;
				} foreach _PoleArray;
				
				{
					if ((_x select 2) in BluLandControlled) then
					{
						if ((_x select 1 select 0) isEqualTo "Materials") then {_NewMaterials = _NewMaterials + (_x select 1 select 1)};
						if ((_x select 1 select 0) isEqualTo "Cash") then {_NewCash = _NewCash + (_x select 1 select 1)};
						if ((_x select 1 select 0) isEqualTo "Oil") then {_NewOil = _NewOil +(_x select 1 select 1)};
						if ((_x select 1 select 0) isEqualTo "Power") then {_NewPower = _NewPower + (_x select 1 select 1)};
						_PTake = _PTake + 25;
					};
				} foreach CompleteRMArray;
	
				
				Dis_BluforTickets = Dis_BluforTickets + _AdditionalTickets;
				W_RArray set [0,((W_RArray select 0) + _NewOil)];
				W_RArray set [1,((W_RArray select 1) + _NewPower)];
				W_RArray set [2,((W_RArray select 2) + _NewCash)];
				W_RArray set [3,((W_RArray select 3) + _NewMaterials)];
				publicVariable "W_RArray";
				publicVariable "Dis_BluforTickets";
				/*
				_AddNewsArray = ["Income Report",
				format
				[
				"
				We have just recieved a new shipment of supplies. Read below for details.<br/>
				INCOME REPORT<br/>
				Oil: %1<br/>
				Power: %2<br/>
				Cash: %3<br/>
				Materials: %4<br/>
				Tickets: %5<br/>
				END OF REPORT<br/>
				"
				,_NewOil,_NewPower,_NewCash,_NewMaterials,_AdditionalTickets
				]
				];
				dis_WNewsArray pushback _AddNewsArray;
				publicVariable "dis_WNewsArray";
				*/
			[
				[(count BluLandControlled),(count BluControlledArray),_NewOil,_NewPower,_NewCash,_NewMaterials,_AdditionalTickets,_PTake,W_RArray],
				{
					if !(hasInterface) exitWith {};
					params ["_Grid","_Towns","_Oil","_Power","_Cash","_NewMaterials","_Tickets","_PTake","_W_RArray"];			
					private _title  = "<t color='#FFFFFF' size='1.4' shadow='1' shadowColor='#000000' align='center'>RESOURCE SHIPMENT</t><br />";
					private _image = "<img image='\A3\Ui_f\data\GUI\Cfg\Hints\Detaching_ca.paa' size='5' align='center'/><br />";
					private _Message = format
					[
					"
					YOUR SIDE HAS <t color='#00D506'>%2</t> TOWNS WITH <t color='#00D506'>%1</t> GRIDS<br /> 
					YOUR SIDE HAS EARNED:<br /> 
					+<t color='#00D506'>%3</t> OIL<br /> 
					+<t color='#00D506'>%4</t> POWER<br /> 
					+<t color='#00D506'>%5</t> CASH<br /> 
					+<t color='#00D506'>%6</t> MATERIALS<br /> 
					+<t color='#00D506'>%7</t> TICKETS<br /> 
					FOR A TOTAL OF:<br /> 
					<t color='#00D506'>%8</t> OIL --	<t color='#00D506'>%9</t> POWER<br /> 
					<t color='#00D506'>%10</t> CASH -- <t color='#00D506'>%11</t> MATERIALS<br /> 
					<t color='#00D506'>%12</t> TICKETS<br /><br />
					<t color='#FCF712'>FOR EXISTING YOU GET:</t> <t color='#00D506'>%13$</t> 
					"
					,_Grid,_Towns,_Oil,_Power,_Cash,_NewMaterials,_Tickets,(_W_RArray select 0),(_W_RArray select 1),(_W_RArray select 2),(_W_RArray select 3),Dis_BluforTickets,_PTake
					];
					hint parseText (_title + _image + _Message);
					DIS_PCASHNUM = DIS_PCASHNUM + _PTake;
					sleep 5;
					hintSilent "";				
				}
			] remoteExec ["bis_fnc_Spawn",West];				
	
			}
			else
			{
			
				//		_NewArray = [_marker1Names,_locationName,_FlagPole,_marker1,0,0,0,false,20];
				_AdditionalTickets = 5;
				_PoleArray = [];
				_NewCash = 15;
				_NewPower = 15;
				_NewOil = 15;
				_NewMaterials = 250;
				private _PTake = 0;
				{
					if ((_x select 2) in OpControlledArray) then
					{
						_AdditionalTickets = _AdditionalTickets + 5;
						_PoleArray pushback (_x select 2);
					};
				} foreach TownArray;
				
	
				{
					_Pole = _x;
					{
						if (_Pole isEqualTo (_x select 0)) then
						{
						//[_Pole,[_CashFlowRandom,_PowerFlowRandom,_OilFlowRandom,_MaterialsFlowRandom],_Loc,_Pos];
							_NewCash = _NewCash + ((_x select 1) select 0);
							_NewPower = _NewPower + ((_x select 1) select 1);
							_NewOil = _NewOil + ((_x select 1) select 2);
							_NewMaterials = _NewMaterials + ((_x select 1) select 3);	
							_PTake = _PTake + 50;
						};
					} foreach CompleteTaskResourceArray;
				} foreach _PoleArray;
				
				//	CompleteRMArray pushback [_Marker,_FinalSelection,_x,false,_location];
				{
					if ((_x select 2) in OpLandControlled) then
					{
						if ((_x select 1 select 0) isEqualTo "Materials") then {_NewMaterials = _NewMaterials + (_x select 1 select 1)};
						if ((_x select 1 select 0) isEqualTo "Cash") then {_NewCash = _NewCash + (_x select 1 select 1)};
						if ((_x select 1 select 0) isEqualTo "Oil") then {_NewOil = _NewOil +(_x select 1 select 1)};
						if ((_x select 1 select 0) isEqualTo "Power") then {_NewPower = _NewPower + (_x select 1 select 1)};
						_PTake = _PTake + 25;
					};
				} foreach CompleteRMArray;
	
				
				Dis_OpforTickets = Dis_OpforTickets + _AdditionalTickets;
				E_RArray set [0,((E_RArray select 0) + _NewOil)];
				E_RArray set [1,((E_RArray select 1) + _NewPower)];
				E_RArray set [2,((E_RArray select 2) + _NewCash)];
				E_RArray set [3,((E_RArray select 3) + _NewMaterials)];
				publicVariable "E_RArray";
				publicVariable "Dis_OpforTickets";
				[
					[(count OpLandControlled),(count OpControlledArray),_NewOil,_NewPower,_NewCash,_NewMaterials,_AdditionalTickets,_PTake,E_RARRAY],
					{
						if !(hasInterface) exitWith {};
						params ["_Grid","_Towns","_Oil","_Power","_Cash","_NewMaterials","_Tickets","_PTake","_E_RARRAY"];			
						private _title  = "<t color='#FFFFFF' size='1.4' shadow='1' shadowColor='#000000' align='center'>RESOURCE SHIPMENT</t><br />";
						private _image = "<img image='\A3\Ui_f\data\GUI\Cfg\Hints\Detaching_ca.paa' size='5' align='center'/><br />";
						private _Message = format
						[
						"
						YOUR SIDE HAS <t color='#00D506'>%2</t> TOWNS WITH <t color='#00D506'>%1</t> GRIDS<br /> 
						YOUR SIDE HAS EARNED:<br /> 
						+<t color='#00D506'>%3</t> OIL<br /> 
						+<t color='#00D506'>%4</t> POWER<br /> 
						+<t color='#00D506'>%5</t> CASH<br /> 
						+<t color='#00D506'>%6</t> MATERIALS<br /> 
						+<t color='#00D506'>%7</t> TICKETS<br /> 
						FOR A TOTAL OF:<br /> 
						<t color='#00D506'>%8</t> OIL --	<t color='#00D506'>%9</t> POWER<br /> 
						<t color='#00D506'>%10</t> CASH -- <t color='#00D506'>%11</t> MATERIALS<br /> 
						<t color='#00D506'>%12</t> TICKETS<br /><br />
						<t color='#FCF712'>FOR EXISTING YOU GET:</t> <t color='#00D506'>%13$</t> 
						"
						,_Grid,_Towns,_Oil,_Power,_Cash,_NewMaterials,_Tickets,(_E_RARRAY select 0),(_E_RARRAY select 1),(_E_RARRAY select 2),(_E_RARRAY select 3),Dis_OpforTickets,_PTake
						];
						hint parseText (_title + _image + _Message);
						DIS_PCASHNUM = DIS_PCASHNUM + _PTake;
						sleep 10;
						hintSilent "";
					}
				] remoteExec ["bis_fnc_Spawn",East];			
				/*
				_AddNewsArray = ["Income Report",
				format
				[
				"
				We have just recieved a new shipment of supplies. Read below for details.<br/>
				INCOME REPORT<br/>
				Oil: %1<br/>
				Power: %2<br/>
				Cash: %3<br/>
				Materials: %4<br/>
				Tickets: %5<br/>
				END OF REPORT<br/>
				"
				,_NewOil,_NewPower,_NewCash,_NewMaterials,_AdditionalTickets
				]
				];
				dis_ENewsArray pushback _AddNewsArray;
				publicVariable "dis_ENewsArray";		
				*/
			
			
			
			};
		};
	
	
	} foreach [West,East];
	!(dis_KeepCounting)


};


