//For displaying the correct information when selecing troops
private _Line1 = _this select 0; //Dialog Control Number
private _index = _this select 1; //Index number
private _data = lbData [1500,_index];

//_NewInformation = [_DisplayName,_Classname,_Cost,_Weapons];	
private _RealData = call compile _data;
private _DisplayName = _RealData select 0;
private _Cost = (_RealData select 2) * 2.5;
private _Weapons = _RealData select 3;

private _infoText = ((findDisplay 3017) displayCtrl (1100));
_infoText ctrlSetStructuredText (parseText format 
[
"
<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>%1 -- %3 Cash</t></t></t>
<br/>
<t shadow='true' shadowColor='#000000'><t size='0.8'><t align='left'>WEAPONS: <t underline='true'>%2</t></t></t></t>
"
,_DisplayName,_Weapons,_Cost
]);
