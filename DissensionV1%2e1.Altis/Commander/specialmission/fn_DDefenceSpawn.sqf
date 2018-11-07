//_this = side.
params ["_CSide"];

if (_CSide isEqualTo West) then
{
	private _Comm = Dis_EastCommander;
	private _NE = _Comm call dis_ClosestEnemy;
	_AdditionalMessage = "A defensive squad has been deployed to protect our structures for some time before moving out.";
	[West,12,0,0,0,0,(getpos _NE),_AdditionalMessage] spawn dis_recruitunits;
}
else
{
	_AdditionalMessage = "A defensive squad has been deployed to protect our structures for some time before moving out.";
	_Comm = Dis_WestCommander;
	private _NE = _Comm call dis_ClosestEnemy;	
	[East,12,0,0,0,0,(getpos _NE),_AdditionalMessage] spawn dis_recruitunits;	
};

