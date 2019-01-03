params ["_CSide"];

private _SupplyStructure = [];
private _Comm = objNull;

if (_CSide isEqualTo West) then
{
	_SupplyStructure = ["Land_BagBunker_Tower_F","CamoNet_BLUFOR_big_F"];
	_Comm = Dis_WestCommander;
	
	[_Comm,_SupplyStructure,_CSide] spawn dis_SupplyLoop;
	[_CSide,_SupplyStructure] spawn dis_SupplyManageLoop;
	//[West,"Land_BagBunker_Tower_F"] spawn dis_SupplyManageLoop;
	
}
else
{
	_SupplyStructure = ["Land_BagBunker_Tower_F","CamoNet_OPFOR_big_F"];
	_Comm = Dis_EastCommander;	
	
	[_Comm,_SupplyStructure,_CSide] spawn dis_SupplyLoop;
	[_CSide,_SupplyStructure] spawn dis_SupplyManageLoop;

};

//Run the function that will constantly put supply crates around the map for pick-up
[] spawn DIS_fnc_cratemonitor;