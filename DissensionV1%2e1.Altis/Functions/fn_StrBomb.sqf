//Function for monitoring the bomb that destroys structures!

params ["_U","_S"];
if (_s getVariable ["DIS_StrB",false]) exitWith {};
_S setVariable ["DIS_StrB",true,true];

private _position = getpos _S;
private _Bmb = createVehicle ["Land_Device_slingloadable_F",(getpos _U), [], 0, "CAN_COLLIDE"];
_Bmb setVariable ["DIS_PLAYERVEH",true];
_Bmb setVelocity [0,0,0];
_Bmb allowdamage false;
_Bmb setpos (getpos _U);
[_Bmb,(vehicle _U)] remoteExecCall ["disableCollisionWith", 0, _Bmb];

//Monitor the bomb and allow AI to disarm the bomb.
private _FriendlySide = West;
private _Com = DIS_WestCommander;
if (side (group _U) isEqualTo West) then {_FriendlySide = East;_Com = DIS_EastCommander;};


[_U,_S,_Bmb,_FriendlySide,_Com] spawn
{
	params ["_U","_S","_Bmb","_FriendlySide","_Com"];
	private _BmbDefusal = 0;
	waitUntil
	{
		private _EArray = (allunits select {side (group _x) isEqualTo _FriendlySide});
		_Earray = _Earray - [_Com];
		_EArray = _EArray - allplayers;
		private _Cst = [_EArray,_Bmb,true] call dis_closestobj;
		if (_Cst distance2D _Bmb < 10) then 
		{
			_BmbDefusal = _BmbDefusal + 5;
		}
		else
		{
			_Cst doMove (getpos _Bmb);
		};
		if (_BmbDefusal > 15) then
		{
			deleteVehicle _bmb;
		};
		sleep 5;
		!(alive _Bmb)
	};

};

[
[_Bmb],
{
		private _Bmb = _this select 0;
		["A BOMB HAS BEEN PLANTED. CHECK YOUR MAP FOR INFORMATION!",'#FFFFFF'] call Dis_MessageFramework;
		//New fancy addaction. USE THIS NEW ONE!
		#define TARGET _Bmb
		#define TITLE "Defuse Bomb"
		#define    ICON  ""
		#define    PROG_ICON    ""
		#define COND_ACTION "true"
		#define COND_PROGRESS "true"
		#define    CODE_START {["Defusing bomb...",'#FFFFFF'] call Dis_MessageFramework}
		#define    CODE_TICK {}
		#define CODE_END {["Bomb defused!",'#FFFFFF'] call Dis_MessageFramework;deleteVehicle (_this select 0)}
		#define    CODE_INTERUPT {["Halted defusal of bomb",'#FFFFFF'] call Dis_MessageFramework;}
		#define    ARGUMENTS []
		#define    DURATION 10
		#define    PRIORITY 1
		#define    REMOVE false
		#define SHOW_UNCON false
		
		[TARGET,TITLE,ICON,PROG_ICON,COND_ACTION,COND_PROGRESS,CODE_START,CODE_TICK,CODE_END,CODE_INTERUPT,ARGUMENTS,DURATION,PRIORITY,REMOVE,SHOW_UNCON] call bis_fnc_holdActionAdd;

		private _m1 = createMarkerLocal [format ["%1",_Bmb],(getpos _Bmb)];
		_m1 setMarkerShapeLocal "ICON";
		_m1 setMarkerTypeLocal "Minefield";
		_m1 setmarkercolorLocal "ColorRed";
		_m1 setmarkersizeLocal [1.5,1.5];
		private _tmr = 300;
		waitUntil
		{
			_tmr = _tmr - 1;
			_m1 setMarkerTextLocal format ["Destruction: %1 Secs",_tmr];
			sleep 1;
			!(alive _Bmb)
		};
		deleteMarker _m1;
	
}

] remoteExec ["bis_fnc_Spawn",0];

private _tmr = time + 300;
waitUntil
{
	if (time > _tmr) then
	{
		_S setDamage 1;
		[_FriendlySide,3] call DIS_fnc_CommanderSpeak;
		{
			if !(_x isKindOf "MAN") then
			{
				deleteVehicle _x;	
			};
		} foreach (nearestObjects [_S, [], 25]);
		
		_bmb setDamage 1;
		{
			createVehicle ["HelicopterExploSmall", ([_Bmb,3,1] call dis_randompos), [], 0, "NONE"];
			true;
		} count [1,2,3,4];
		deleteVehicle _bmb;
	};
	!(alive _bmb);	
};
if !(isNil "_S") then
{
	_S setVariable ["DIS_StrB",false,true];
};