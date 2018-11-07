//This function will have the Guerrilla commander spawn a randomly sized squad to go harass the enemy teams, no matter the distance. WHAT A JERK.
//_this = side.
params ["_CSide"];

if (_CSide isEqualTo West) then
{

	_Comm = Dis_EastCommander;
	_AdditionalMessage = "A squad of 24 troops have been deployed to slow our enemies movements.";
	[West,24,0,0,0,0,(getpos _Comm),_AdditionalMessage] spawn dis_recruitunits;
}
else
{

	_AdditionalMessage = "A squad of 24 troops have been deployed to slow our enemies movements.";
	_Comm = Dis_WestCommander;
	[East,24,0,0,0,0,(getpos _Comm),_AdditionalMessage] spawn dis_recruitunits;	
	
};












