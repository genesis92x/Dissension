//Function to display a 3D Marker on the construction crate for the player.
private _CargoBox = player getVariable ["DIS_CargoBox",nil];

//If the cargobox is nil then we need to create the player's cargo box.
if (!(isNil "_CargoBox") && {alive _CargoBox} && {DIS_Contmrk}) then
{
	DIS_Contmrk = false;
	
	private _m1 = createMarkerLocal ["Construction Crate",(getpos _CargoBox)];
	_m1 setMarkerShapeLocal "ICON";
	_m1 setMarkerTypeLocal "hd_flag";
	_m1 setmarkercolorLocal "ColorWhite";
	_m1 setmarkersizeLocal [0.5,0.5];
	_m1 setMarkerTextLocal "Construction Crate";
	[_m1,_Cargobox] spawn
	{
		params ["_m1","_Cargobox"];
		while {alive _Cargobox} do
		{
			_m1 setMarkerPosLocal (getpos _CargoBox);
			sleep 5;
		};
		deleteMarkerLocal _m1;
	};

	
	private _Img = MISSION_ROOT + "Pictures\iconCrateWpns_ca.paa";
	[str _CargoBox, "onEachFrame", 
	{
		params ["_Img","_CargoBox"];
		if (alive _CargoBox) then
		{
			_pos2 = visiblePositionASL _CargoBox;
			_pos2 set [2, ((_CargoBox modelToWorld [0,0,0]) select 2) + 0.25];
			_alphaText = round(linearConversion[50, 500, player distance2D _CargoBox, 1, 0, true]);
			call compile format 
			[
			'
			drawIcon3D
			[
				%1,
				[1,1,1,%3],
				%2,
				0.75,
				0.75,
				0,
				"Construction Crate",
				1,
				0.04,
				"RobotoCondensed",
				"center",
				false
			];
			'
			,str _Img,_pos2,_alphaText
			]
		}
		else
		{
			if !(alive _CargoBox) then
			{
				[str _CargoBox, "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
				DIS_Contmrk = true;
			};
		};
	},
	[_Img,_CargoBox]
	] call BIS_fnc_addStackedEventHandler;	
	
	
	
	
	
	
	
};