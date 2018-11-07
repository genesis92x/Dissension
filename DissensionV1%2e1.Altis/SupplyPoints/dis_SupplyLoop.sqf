params ["_Comm","_Building","_CSide"];

sleep (300 + (random 300));

while {alive _Comm} do
{
	[_CSide,_Building] call dis_SupplyCreate;
	sleep 1800;
};


//
//	[West,["Land_BagBunker_Tower_F","CamoNet_BLUFOR_big_F"]] call dis_SupplyCreate;
//