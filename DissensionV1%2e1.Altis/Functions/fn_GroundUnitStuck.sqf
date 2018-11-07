//This function will monitor all ground AI and help them out when stuck :D This only focuses on infantry.
sleep 15;
DIS_GroundUnitStuckLoop = false;

while {DIS_GroundUnitStuckLoop} do
{
	private _Array1 = allunits;
	_Array1 = _Array1 - [DIS_WestCommander]; 
	_Array1 = _Array1 - [DIS_EastCommander]; 
	{
		if (!(isPlayer _x) && {_x isEqualTo (vehicle _x)} && {!((group _x) getVariable ["DIS_BoatN",false])}) then 
		{
			private _PrevCol = _x getVariable ["DIS_InfStuck",[[0,0,0],0]];
			private _LastPos = _PrevCol select 0;
			private _StuckCnt = _PrevCol select 1;
			private _UnitPos = getPos _x;
			if (_LastPos distance2D (_UnitPos) < 5) then
			{
				private _CE = _x call dis_ClosestEnemy;
				if (_CE distance2D _UnitPos > 200) then
				{	
					_StuckCnt = _StuckCnt + 1;				
					_x setVariable ["DIS_InfStuck",[_UnitPos,_StuckCnt]];
					if (_StuckCnt > 10) then 
					{
						_x setDamage 1;
					};
				};
			}
			else
			{
				_x setVariable ["DIS_InfStuck",[_UnitPos,_StuckCnt]];			
			};
		};
	} foreach _Array1;
	sleep 10;
}; 