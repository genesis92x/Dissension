//This function will call in artillery for the east/west side. The number of rounds will depend on the amount of cash the commander is willing to spend.
//The rounds should be fairly inaccurate, but cheap, for scary bombardment.
params ["_CSide"];


private _Westrun = false;
private _Comm = objNull;
private _Target = ObjNull;
private _AddNewsArray = "";

if (_CSide isEqualTo West) then
{

	_Comm = Dis_WestCommander;
	_Westrun = true;
	
	private _FriendA = [];
	{
		_FriendA pushback _x;
		true;
	} count (allunits select {side _x isEqualTo West});
	
	{
		_CF = [_FriendA,_x,true] call dis_closestobj;
		if (_CF distance _x > 800) exitWith {_Target = getpos _x;};
		true;
	} count (allunits select {side _x isEqualTo East});
	
}
else
{
	_Comm = Dis_EastCommander;
	private _FriendA = [];
	{
		_FriendA pushback _x;
		true;
	} count (allunits select {side _x isEqualTo East});
	
	{
		_CF = [_FriendA,_x,true] call dis_closestobj;
		if (_CF distance _x > 800) exitWith {_Target = getpos _x;};
		true;
	} count (allunits select {side _x isEqualTo West});
	
};


	_AddNewsArray = ["Artillery Barrage",format 
	[
	"
		We have found a safe location to deploy artillery against our enemies... Let's hope for no survivors.<br/>
	"
	
	,"Hai"
	]
	];
	if (_WestRun) then {dis_WNewsArray pushback _AddNewsArray;publicVariable "dis_WNewsArray";} else {dis_ENewsArray pushback _AddNewsArray;publicVariable "dis_ENewsArray";};
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",_CSide];
	
{
	sleep (random 5);
	_rnd = random 800;
	_dist = (_rnd + 25);
	_dir = random 360;
	_positions = [(_Target select 0) + (sin _dir) * _dist, (_Target select 1) + (cos _dir) * _dist,0];
	_shell = "Sh_82mm_AMOS" createVehicle _positions;
	_shell setPos [_positions select 0,_positions select 1,(_positions select 2) + 500];
	_shell setVelocity [0,0,-200];
	
	[_positions,(selectrandom ["Mortar1","Mortar2"])] remoteExec ["PlaySoundEverywhereDist",0];	
	true;
} count [1,2,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];