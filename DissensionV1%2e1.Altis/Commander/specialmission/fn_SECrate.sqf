//[] call DIS_fnc_SECrate;
//This function spawns a crate near friendly units. This enables the support commander to give players extra cash to speed up the fight!
//Lets make it cool by adding an awesome parachute effect.

Params ["_CSide"];

private _Comm = objNull;
private _Target = ObjNull;
private _AddNewsArray = "";
private _FriendA = [];
private _WestRun = false;

if (_CSide isEqualTo West) then
{
	
	{
		_FriendA pushback _x;
	} foreach (allplayers select {side _x isEqualTo West});
	_WestRun = true;

	
}
else
{

	{
		_FriendA pushback _x;
	} forEach (allplayers select {side _x isEqualTo East});
	

	
};

//Send the message!
["SUPPORT COMMANDER: RESOURCE CRATES ARE IN-BOUND",'#FFFFFF'] remoteExec ["MessageFramework",_CSide];	
_AddNewsArray = ["Resource Deployment",format 
[
"
	We have deployed resource crates for our special forces teams. Secure these resources and use them to destroy our enemies!<br/>
"

,"Hai"
]
];
if (_WestRun) then {dis_WNewsArray pushback _AddNewsArray;publicVariable "dis_WNewsArray";} else {dis_ENewsArray pushback _AddNewsArray;publicVariable "dis_ENewsArray";};
["Beep_Target"] remoteExec ["PlaySoundEverywhere",_CSide];

//Lets give everyone a supply crate! WEEE
{
	private _Supply = "B_supplyCrate_F" createVehicle [0,0,50];
	_Supply setVariable ["DIS_PLAYERVEH",true];
	private _para = createVehicle ["B_Parachute_02_F", [0,0,150], [], 0, ""];
	_Supply attachTo [_para,[0,0,0]]; 
	
	_Pos = getpos _x;
	_para setpos [_Pos select 0,_Pos select 1,(_Pos select 2) + 150];
	waitUntil {((getpos _Supply) select 2) < 10};
	detach _Supply;
	private _smoke = "SmokeShellOrange" createVehicle (getpos _Supply);
	_Supply setPos (getPos _Supply);	
		
	_Supply spawn {sleep 600;deleteVehicle _this;};
	
	[
	[_Supply],
	{
			params ["_Supply"];
	
			//New fancy addaction. USE THIS NEW ONE!
			#define TARGET _Supply
			#define TITLE "Claim Supplies"
			#define    ICON  ""
			#define    PROG_ICON    ""
			#define COND_ACTION "true"
			#define COND_PROGRESS "true"
			#define    CODE_START {["Taking Supplies...",'#FFFFFF'] call Dis_MessageFramework}
			#define    CODE_TICK {}
			private _CodeEnd =
			{
				if ((side player) isEqualTo East) then
					{
						E_RArray set [0,(E_RArray select 0) + 100];
						E_RArray set [1,(E_RArray select 1) + 100];
						E_RArray set [2,(E_RArray select 2) + 100];
						E_RArray set [3,(E_RArray select 3) + 100];
						DIS_PCASHNUM = DIS_PCASHNUM + 2000;
						["+2000 CASH AND +100 FOR EACH SUPPLY",'#FFFFFF'] call Dis_MessageFramework;
						deletevehicle (_this select 0);
					}
					else
					{
						W_RArray set [0,(W_RArray select 0) + 100];
						W_RArray set [1,(W_RArray select 1) + 100];
						W_RArray set [2,(W_RArray select 2) + 100];
						W_RArray set [3,(W_RArray select 3) + 100];	
						DIS_PCASHNUM = DIS_PCASHNUM + 2000;				
						["+2000 CASH AND +100 FOR EACH SUPPLY",'#FFFFFF'] call Dis_MessageFramework;
						deletevehicle (_this select 0);
					};
				};
			#define    CODE_INTERUPT {["Stopped taking supplies",'#FFFFFF'] call Dis_MessageFramework;}
			#define    ARGUMENTS []
			#define    DURATION 2
			#define    PRIORITY 1
			#define    REMOVE false
			#define SHOW_UNCON false
			
			[TARGET,TITLE,ICON,PROG_ICON,COND_ACTION,COND_PROGRESS,CODE_START,CODE_TICK,_CodeEnd,CODE_INTERUPT,ARGUMENTS,DURATION,PRIORITY,REMOVE,SHOW_UNCON] call bis_fnc_holdActionAdd;		
			
		if (player distance2D _Supply < 2100) then
		{
			private _m1 = createMarkerLocal [format ["%1",_Supply],(getpos _Supply)];
			_m1 setMarkerShapeLocal "ICON";
			_m1 setMarkerTypeLocal "u_installation";
			_m1 setmarkercolorLocal "ColorWhite";
			_m1 setmarkersizeLocal [1,1];
			waitUntil {!(alive _Supply)};
			deleteMarker _m1;
		};						
			
	}
	

	
	
	]	remoteExec ["bis_fnc_Spawn",0]; 		
	sleep 15;
} forEach _FriendA;

