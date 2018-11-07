//This function will spawn in a medical vehicle that will heal all AI units within 1 KM to full every 5 minutes.
params ["_CSide"];


private _Westrun = false;
private _Comm = objNull;
private _Target = ObjNull;
private _AddNewsArray = "";
private _Buildinglist = [];
private _BarrackU = [];
private _AirArray = [];
private _CommanderAct = nil;


if (_CSide isEqualTo West) then
{
	_Comm = Dis_WestCommander;
	_Westrun = true;
	_Buildinglist = W_BuildingList;
	_AirArray = W_MedU;
	_BarrackU = W_BarrackU;	
	_LFactU = W_LFactU;	
	_CommanderAct = DIS_WestCommander;
}
else
{
	_BarrackU = E_BarrackU;
	_LFactU = E_LFactU;
	_Comm = Dis_EastCommander;
	_Buildinglist = E_BuildingList;
	_AirArray = E_MedU;
	_CommanderAct = DIS_EastCommander;
};


//Lets separate all our buildings so we know where to spawn our units.
private _BarrackList = [];
private _AirFieldFactoryList =	[];
private _BarracksSwitch = false;
private _AFactorySwitch = false;
private _InfList = [];
private _HList = [];
private _AList = [];

{
	_Phy = _x select 0;
	_Name = _x select 1;
	if (_Name isEqualTo "Barracks") then {_BarrackList pushback (_x select 0);_BarracksSwitch = true;_InfList pushback _BarrackU;};
	if (_Name isEqualTo "Air Field") then {_AirFieldFactoryList pushback (_x select 0);_AFactorySwitch = true;_AList pushback _AirU;};
} forEach _Buildinglist;



//If we have access to aircraft, spawn in an air medic >:D
if (_AFactorySwitch) exitWith
{
	private _Enemy = _CommanderAct call dis_ClosestEnemy;
	private _SpawnLoc = [_AirFieldFactoryList,_Enemy,true] call dis_closestobj;
	private _SpwnPos = getpos _SpawnLoc;
	private _EnemyPos = getpos _Enemy;

	//Spawn units to attack enemy units/territory

	private _ActualSpwn = ((_AirArray select 1) select 0);
	private _Cost = ((_AirArray select 1) select 1);
	private _veh = createVehicle [_ActualSpwn,_SpwnPos, [], 0, "FLY"];
	_grp = createGroup (side _Comm);_grp setVariable ["DIS_IMPORTANT",true];
	
	createVehicleCrew _veh;
	{[_x] joinsilent _grp} forEach crew _veh;
	
	
	if (_WestRun) then
	{
		W_RArray set [0,(W_RArray select 0) - (_Cost select 0)];
		W_RArray set [1,(W_RArray select 1) - (_Cost select 1)];
		W_RArray set [2,(W_RArray select 2) - (_Cost select 2)];
		W_RArray set [3,(W_RArray select 3) - (_Cost select 3)];		
		Dis_BluforTickets = Dis_BluforTickets - 1;
	}
	else
	{
		E_RArray set [0,(E_RArray select 0) - (_Cost select 0)];
		E_RArray set [1,(E_RArray select 1) - (_Cost select 1)];
		E_RArray set [2,(E_RArray select 2) - (_Cost select 2)];
		E_RArray set [3,(E_RArray select 3) - (_Cost select 3)];		
		Dis_OpforTickets = Dis_OpforTickets - 1;		
	};	
	
	_veh spawn
	{
	
		private _Side = Side _this;
		private _grp = group _this;
		while {alive _this} do
		{
			private _EN = _this call dis_ClosestEnemy;
			private _Friend = getpos ([(allunits select {side _x isEqualTo _Side}),_EN,true] call dis_closestobj);
			
			private _wp = _grp addwaypoint[_Friend,1];
			_wp setwaypointtype "MOVE";
			_wp setWaypointSpeed "NORMAL";
			private _wp2 = _grp addwaypoint[_Friend,1];
			_wp2 setwaypointtype "MOVE";
			_wp2 setWaypointSpeed "NORMAL";

			sleep 60;
			{
				if (_x distance _this < 1001) then
				{
					_x setDamage (damage - 0.5); 
				};
				true;
			} count (allunits select {side _x isEqualTo _Side});
			
			
		};

	};
	
	_AddNewsArray = ["Medic Deployed",format 
	[
	"
		We have deployed a unique combat medic engineer team. This team will heal and repair any units or vehicles close to them.<br/>
	"
	
	,"Hai"
	]
	];
	
	if (_WestRun) then
{
	dis_WNewsArray pushback _AddNewsArray;
	publicVariable "dis_WNewsArray";
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",West];		
	
	[
	[_grp,West],
	{
			private _Group = _this select 0;
			private _CSide = _this select 1;
			private _Marker = createMarkerLocal [format ["ID_%1",_Group],[0,0,0]];
			_Marker setMarkerColorLocal "ColorBlue";
			_Marker setMarkerSizeLocal [1,1];			
			_Marker setMarkerShapeLocal 'ICON';		
			_Marker setMarkerTypeLocal "b_inf";				
			_Marker setMarkerTextLocal "MEDIC";
			
			if (isServer) then {[_Cside,_Marker,_Group,"SEMedic"] call DIS_fnc_mrkersave; };
			if (playerSide isEqualTo _Cside) then
			{
				_Marker setMarkerAlphaLocal 1;
			}
			else
			{
				_Marker setMarkerAlphaLocal 0;
			};			
			
			while {({alive _x} count (units _Group)) > 0} do
			{
				_Marker setMarkerDirLocal (getdir (leader _Group));	
				_Marker setMarkerPosLocal (getposASL (leader _Group));
				sleep 1.25;
			};
			sleep 5;
			deleteMarker _Marker;			

	}
	
	] remoteExec ["bis_fnc_Spawn",0]; 		
	
	
}
else
{
	dis_ENewsArray pushback _AddNewsArray;
	publicVariable "dis_ENewsArray";
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",East];		
	
	[
	[_grp,East],
	{
			private _Group = _this select 0;
			private _Cside = _this select 1;
			private _Marker = createMarkerLocal [format ["ID_%1",_Group],[0,0,0]];
			_Marker setMarkerColorLocal "ColorRed";
			_Marker setMarkerSizeLocal [1,1];			
			_Marker setMarkerShapeLocal 'ICON';		
			_Marker setMarkerTypeLocal "o_inf";
			_Marker setMarkerTextLocal "MEDIC";
			
			if (isServer) then {[_Cside,_Marker,_Group,"SEMedic"] call DIS_fnc_mrkersave; };
			if (playerSide isEqualTo _Cside) then
			{
				_Marker setMarkerAlphaLocal 1;
			}
			else
			{
				_Marker setMarkerAlphaLocal 0;
			};				
			
			while {({alive _x} count (units _Group)) > 0} do
			{
				_Marker setMarkerDirLocal (getdir (leader _Group));	
				_Marker setMarkerPosLocal (getposASL (leader _Group));
				sleep 1.25;
			};
			sleep 5;
			deleteMarker _Marker;			

	}
	
	] remoteExec ["bis_fnc_Spawn",0]; 		
	
};	
	
};

//If we have access to aircraft, spawn in a ground medic >:D
if (_BarracksSwitch) exitWith
{
	private _Enemy = _CommanderAct call dis_ClosestEnemy;
	private _SpawnLoc = [_BarrackList,_Enemy,true] call dis_closestobj;
	private _SpwnPos = getpos _SpawnLoc;
	private _EnemyPos = getpos _Enemy;

	//Spawn units to attack enemy units/territory
	private _grp = createGroup _CSide;_grp setVariable ["DIS_IMPORTANT",true];
	
	private _ActualSpwn = ((_AirArray select 0) select 0);
	private _Cost = ((_AirArray select 0) select 1);
	private _unit = _grp createUnit [_ActualSpwn,_SpwnPos, [], 25, "FORM"];
	[_unit] joinSilent _grp;	
	
	if (_WestRun) then
	{
		W_RArray set [0,(W_RArray select 0) - (_Cost select 0)];
		W_RArray set [1,(W_RArray select 1) - (_Cost select 1)];
		W_RArray set [2,(W_RArray select 2) - (_Cost select 2)];
		W_RArray set [3,(W_RArray select 3) - (_Cost select 3)];		
		Dis_BluforTickets = Dis_BluforTickets - 1;
	}
	else
	{
		E_RArray set [0,(E_RArray select 0) - (_Cost select 0)];
		E_RArray set [1,(E_RArray select 1) - (_Cost select 1)];
		E_RArray set [2,(E_RArray select 2) - (_Cost select 2)];
		E_RArray set [3,(E_RArray select 3) - (_Cost select 3)];		
		Dis_OpforTickets = Dis_OpforTickets - 1;		
	};	
	
	_unit spawn
	{
	
		private _Side = Side _this;
		private _grp = group _this;
		while {alive _this} do
		{
			private _EN = _this call dis_ClosestEnemy;
			private _Friend = getpos ([(allunits select {side _x isEqualTo _Side}),_EN,true] call dis_closestobj);
			
			private _wp = _grp addwaypoint[_Friend,1];
			_wp setwaypointtype "MOVE";
			_wp setWaypointSpeed "NORMAL";
			private _wp2 = _grp addwaypoint[_Friend,1];
			_wp2 setwaypointtype "MOVE";
			_wp2 setWaypointSpeed "NORMAL";

			sleep 60;
			{
				if (_x distance2D _this < 1001) then
				{
					(vehicle _x) setDamage ((getDammage _x) - 0.5); 
				};
			} forEach (allunits select {side _x isEqualTo _Side});
			
			
		};

	};
	
	_AddNewsArray = ["Medic Deployed",format 
	[
	"
		We have deployed a unique combat medic engineer team. This team will heal and repair any units or vehicles close to them.<br/>
	"
	
	,"Hai"
	]
	];
	
	if (_WestRun) then
{
	dis_WNewsArray pushback _AddNewsArray;
	publicVariable "dis_WNewsArray";
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",West];		
	
	[
	[_grp,West],
	{
			private _Group = _this select 0;
			private _CSide = _this select 1;
			private _Marker = createMarkerLocal [format ["ID_%1",_Group],[0,0,0]];
			_Marker setMarkerColorLocal "ColorBlue";
			_Marker setMarkerSizeLocal [1,1];			
			_Marker setMarkerShapeLocal 'ICON';		
			_Marker setMarkerTypeLocal "b_inf";				
			_Marker setMarkerTextLocal "MEDIC";
			
			if (isServer) then {[_Cside,_Marker,_Group,"SEMedic"] call DIS_fnc_mrkersave; };
			if (playerSide isEqualTo _Cside) then
			{
				_Marker setMarkerAlphaLocal 1;
			}
			else
			{
				_Marker setMarkerAlphaLocal 0;
			};				
			
			waitUntil
			{
				_Marker setMarkerDirLocal (getdir (leader _Group));	
				_Marker setMarkerPosLocal (getposASL (leader _Group));
				sleep 1.25;
				(({alive _x} count (units _Group)) < 1)
			};
			sleep 5;
			deleteMarker _Marker;			

	}
	
	] remoteExec ["bis_fnc_Spawn",0]; 		
	
	
}
else
{
	dis_ENewsArray pushback _AddNewsArray;
	publicVariable "dis_ENewsArray";
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",East];		
	
	[
	[_grp,East],
	{
			private _Group = _this select 0;
			private _CSide = _this select 1;
			private _Marker = createMarkerLocal [format ["ID_%1",_Group],[0,0,0]];
			_Marker setMarkerColorLocal "ColorRed";
			_Marker setMarkerSizeLocal [1,1];			
			_Marker setMarkerShapeLocal 'ICON';		
			_Marker setMarkerTypeLocal "o_inf";
			_Marker setMarkerTextLocal "MEDIC";
			
			if (isServer) then {[_Cside,_Marker,_Group,"SEMedic"] call DIS_fnc_mrkersave; };
			if (playerSide isEqualTo _Cside) then
			{
				_Marker setMarkerAlphaLocal 1;
			}
			else
			{
				_Marker setMarkerAlphaLocal 0;
			};				
			
			waitUntil
			{
				_Marker setMarkerDirLocal (getdir (leader _Group));	
				_Marker setMarkerPosLocal (getposASL (leader _Group));
				sleep 1.25;
				(({alive _x} count (units _Group)) < 1)
			};
			sleep 5;
			deleteMarker _Marker;			

	}
	
	] remoteExec ["bis_fnc_Spawn",0]; 		
	
};	
	
};






