_Line1 = _this select 0; //Dialog Control Number
_index = _this select 1; //Index number
_data = lbData [1500,_index];

_RealData = call compile _data;

_Description = "";


{
	_Description = _Description + format
	[
		"
		%1<br/>
		"
	,_x
	];
	
} foreach _RealData;


((findDisplay (3014)) displayCtrl (1100)) ctrlSetPosition [0,0];
((findDisplay (3014)) displayCtrl (1100)) ctrlCommit 0;
((findDisplay (3014)) displayCtrl (1100)) ctrlSetStructuredText (parseText format ["<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>%1</t></t></t>",_Description]);