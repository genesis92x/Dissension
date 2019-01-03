//This function will compile a list of all the owned territory and return it for a faction

params ["_Side",["_MGridAct",true],["_TownAct",false]];
private _LArray = [];
if (_Side isEqualTo west) then
{
	
	private _SummedOwned = BluLandControlled + BluControlledArray;
	if !(_TownAct) then
	{
		{
			if ((_x select 2) in _SummedOwned) then
			{
				_LArray pushback (_x select 2);
			};	
		} foreach TownArray;
	};
	

	if (_MGridAct) then
	{
		{
			if ((_x select 2) in _SummedOwned) then
			{
				_LArray pushback (_x select 4);
			};
		} foreach CompleteRMArray;
	};
}
else
{
	private _SummedOwned = OpLandControlled + OpControlledArray;		
	if !(_TownAct) then
	{
		{
			if ((_x select 2) in _SummedOwned) then
			{
				_LArray pushback (_x select 2);
			};	
		} foreach TownArray;
	};
	
	if (_MGridAct) then
	{
		{
			if ((_x select 0) in _SummedOwned) then
			{
				_LArray pushback (_x select 4);
			};
		} foreach CompleteRMArray;	
	};
};



_LArray