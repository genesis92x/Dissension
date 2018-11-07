params ["_CSide"];

//This function will spawn a supply crate around enemy forces. Any enemy forces that activate the addaction will cause an explosion instead of being rewarded resources.
//There must be a way to tell if a box is trapped or not.
/*
	IDEA: Each box will have 2 addactions.
	1: Grab Supplies - This will grab the box, without checking if it is dangerous or not
	2: Check Supplies - This will check to see if the box is wired with explosives or not
*/

private _ESide = [];
private _Comm = [];

if (_CSide isEqualTo West) then
{
	_ESide = East;
	_Comm = Dis_WestCommander;
}
else
{
	_ESide = West;
	_Comm = Dis_EastCommander;
};
	
//Lets find a place to create the barrels
private _UnitList = [];
{
	_UnitList pushback _x;
	true;
} count (allunits select {side _x isEqualTo _ESide});


private _ClosestUnitPos = [_UnitList,_Comm,true] call dis_closestobj;

private _position = [_ClosestUnitPos,50,25] call dis_randompos;

private _Supply = "B_supplyCrate_F" createVehicle _position;

//Globally create addactions for the crates.
_Supply spawn {sleep 1200;deleteVehicle _this; };
_Supply setVariable ["DIS_PLAYERVEH",true];
	
[
[_Supply,_CSide],
{
		params ["_Supply","_CSide"];

		//New fancy addaction. USE THIS NEW ONE!
		#define TARGET _Supply
		#define TITLE "Check Supplies"
		#define    ICON  ""
		#define    PROG_ICON    ""
		#define COND_ACTION "true"
		#define COND_PROGRESS "true"
		#define    CODE_START {["Checking Supplies...",'#FFFFFF'] call Dis_MessageFramework;}
		#define    CODE_TICK {}
		#define CODE_END {["These supplies were rigged with explosives! You were able to collect some resources from it...",'#FFFFFF'] call Dis_MessageFramework;deleteVehicle (_this select 0);DIS_PCASHNUM = DIS_PCASHNUM + 250;}
		#define    CODE_INTERUPT {["Stopped checking supplies",'#FFFFFF'] call Dis_MessageFramework;}
		#define    ARGUMENTS []
		#define    DURATION 5
		#define    PRIORITY 1
		#define    REMOVE false
		#define SHOW_UNCON false
		
		[TARGET,TITLE,ICON,PROG_ICON,COND_ACTION,COND_PROGRESS,CODE_START,CODE_TICK,CODE_END,CODE_INTERUPT,ARGUMENTS,DURATION,PRIORITY,REMOVE,SHOW_UNCON] call bis_fnc_holdActionAdd;
		

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
			createVehicle ["HelicopterExploSmall", position (_this select 0), [], 0, "NONE"];
			createVehicle ["HelicopterExploSmall", position (_this select 1), [], 0, "NONE"];
			deleteVehicle (_this select 0);
		};
		#define    CODE_INTERUPT {["Stopped taking supplies",'#FFFFFF'] call Dis_MessageFramework;}
		#define    ARGUMENTS []
		#define    DURATION 2
		#define    PRIORITY 1
		#define    REMOVE false
		#define SHOW_UNCON false
		
		[TARGET,TITLE,ICON,PROG_ICON,COND_ACTION,COND_PROGRESS,CODE_START,CODE_TICK,_CodeEnd,CODE_INTERUPT,ARGUMENTS,DURATION,PRIORITY,REMOVE,SHOW_UNCON] call bis_fnc_holdActionAdd;		
									
		if (player distance2D _Supply < 6100) then
		{
			private _m1 = createMarkerlocal [format ["%1",_Supply],(getpos _Supply)];
			_m1 setMarkerShapeLocal "ICON";
			_m1 setMarkerTypeLocal "u_installation";
			_m1 setMarkerColorLocal "ColorWhite";
			_m1 setMarkerSizeLocal [1,1];
			waitUntil {!(alive _Supply)};
			deleteMarker _m1;
		};		
}

] remoteExec ["bis_fnc_Spawn",0]; 	
	