//This function will dictate how the Guerrilla commander responds to threats!
//_Rrtn = [[_Thr,[_Inf,_Car,_Tank,_Air]],West];
//The threat level is on a rough scale of 1-10. 1 meaning hardly any threat. And 10 meaning WOWOWOWWOWOW Crazy threat.

private _Lvl = (_this select 0) select 0;
private _Inf = (((_this select 0) select 1) select 0);
private _Car = (((_this select 0) select 1) select 1);
private _Tank = (((_this select 0) select 1) select 2);
private _Air = (((_this select 0) select 1) select 3);
private _CSide = _this select 1;

//Lets determine some faction specific factors here. Things like units to use and etc.
private _BarrackU = [];
private _LFactU = [];
private _HFactU = [];
private _AirU = [];
private _MedU = [];
private _AdvU = [];
private _TeamLU = [];
private _SquadLU = [];
private _MResponse = [];
private _ticketcost = 0;
private _Buildinglist = "no";
private _camps = "nO";
private _West = false;
private _Color = "nil";
private _mkr = "nil";
private _RArray = [];
private _EnemyArray = [];
private _WestRun = false;
private _grp = nil;
private _grp2 = nil;
private _grp3 = nil;
private _grpList = [];
private _CommanderAct = nil;

if (_CSide isEqualTo West) then
{
	_BarrackU = W_BarrackU;
	_LFactU = W_LFactU;
	_HFactU = W_HFactU;
	_AirU = W_AirU;
	_MedU = W_MedU;
	_AdvU = W_AdvU;
	_TeamLU = W_TeamLU;
	_SquadLU = W_SquadLU;
	_Buildinglist = W_BuildingList;
	_camps = W_GuerC;
	_West = true;
	_Color = "ColorBlue";
	_mkr = "b_inf";
	_RArray = W_RArray;
	_EnemyArray = W_DistArray;
	_WestRun = true;
	_CommanderAct = DIS_WestCommander;
	if (_EnemyArray isEqualTo []) then 
	{
		_EnemyArray = [[DIS_EastCommander,0,(getpos DIS_EastCommander)]];
	};	
}
else
{
	_BarrackU = E_BarrackU;
	_LFactU = E_LFactU;
	_HFactU = E_HFactU;
	_AirU = E_AirU;
	_MedU = E_MedU;
	_AdvU = E_AdvU;
	_TeamLU = E_TeamLU;
	_SquadLU = E_SquadLU;
	_Buildinglist = E_BuildingList;
	_camps = E_GuerC;
	_Color = "ColorRed";	
	_mkr = "o_inf";	
	_RArray = E_RArray;
	_EnemyArray = E_DistArray;	
	_WestRun = false;
	_CommanderAct = DIS_EastCommander;	
	if (_EnemyArray isEqualTo []) then 
	{
		_EnemyArray = [[DIS_WestCommander,0,(getpos DIS_WestCommander)]];
	};
};


//Exit if the commanders have too few resources.
if (_RArray select 3 < 30) exitWith {};


//Lets decide, depending on the threat level, the size of troops we should send and what exactly we should do.

//Very Low Threat
//Guerrilla Commander: Sniper team or recom team supported by a small fireteam. 2 snipers/recons with 5 inf. Give AI more mines? If AI have vehicles, find road closest to squad and setup ambush point on road.
//Each group will have a 'timer' that will add them into the "active" units group so they can be used for normal combat after completing a task.


//Lets separate all our buildings so we know where to spawn our units.
private _BarrackList = [];
private _LightFactoryList = [];
private _HeavyFactoryList = [];
private _AirFieldFactoryList =	[];
private _ShipFactoryList = [];
private _GroupList = [];
private _BarracksSwitch = false;
private _LFactorySwitch = false;
private _StaticSwitch = false;
private _HFactorySwitch = false;
private _AFactorySwitch = false;
private _MedBaySwitch = false;
private _AdvInfSwitch = false;
private _InfList = [];
private _HList = [];
private _LList = [];
private _AList = [];

{
	_Phy = _x select 0;
	_Name = _x select 1;
	if (_Name isEqualTo "Barracks") then {_BarrackList pushback (_x select 0);_BarracksSwitch = true;_InfList pushback _BarrackU;};
	if (_Name isEqualTo "Light Factory") then {_LightFactoryList pushback (_x select 0);_LFactorySwitch = true;_LList pushback _LFactU;};
	if (_Name isEqualTo "Static Bay") then {_StaticSwitch = true;};
	if (_Name isEqualTo "Heavy Factory") then {_HeavyFactoryList pushback (_x select 0);_HFactorySwitch = true;_HList pushback _HFactU;};
	if (_Name isEqualTo "Air Field") then {_AirFieldFactoryList pushback (_x select 0);_AFactorySwitch = true;_AList pushback _AirU;};
	if (_Name isEqualTo "Medical Bay") then {_MedBaySwitch = true;_InfList pushback _MedU;};
	if (_Name isEqualTo "Advanced Infantry Barracks") then {_AdvInfSwitch = true;_InfList pushback _AdvU;};
	true;
} count _Buildinglist;


{
	_BarrackList pushback _x;
	true;
} count _camps;







//very low threat
if (_Lvl <= 2) exitWith
{

	//Send message
	_AddNewsArray = ["Very Low Enemy Threat",format 
	[
	"
	A small group of enemy troops has been spotted. We will send troops to reinforce possible threatened areas.<br/>
	"
	
	,"Hai"
	]
	];
	if (_WestRun) then {dis_WNewsArray pushback _AddNewsArray;publicVariable "dis_WNewsArray";} else {dis_ENewsArray pushback _AddNewsArray;publicVariable "dis_ENewsArray";};
	
	
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",_CSide];	


	//First lets spawn the sniper team. We will collect all the important information for spawning here first.
		
	//Now lets spawn in the units.
	//First we have to find a good spawn location.
	private _Enemy = _CommanderAct call dis_ClosestEnemy;
	private _EnemyPos = getpos _Enemy;
	private _SpawnLoc = [_BarrackList,_Enemy,true] call dis_closestobj;
	private _SpwnPos = getpos _SpawnLoc;
	
	//Spawn units to pursue target
	private _grp = createGroup _CSide;
	_grpList pushback _grp;
	{
		private _rndU = selectRandom _InfList;	
		private _unit = _grp createUnit [((_rndU select 0) select 0),_SpwnPos, [], 25, "FORM"];
		[_unit] joinSilent _grp;			
		
		if (_CSide isEqualTo West) then
		{
			W_RArray set [0,(W_RArray select 0) - (((_rndU select 0) select 1) select 0)];
			W_RArray set [1,(W_RArray select 1) - (((_rndU select 0) select 1) select 1)];
			W_RArray set [2,(W_RArray select 2) - (((_rndU select 0) select 1) select 2)];
			W_RArray set [3,(W_RArray select 3) - (((_rndU select 0) select 1) select 3)];		
			Dis_BluforTickets = Dis_BluforTickets - 1;
		}
		else
		{
			E_RArray set [0,(E_RArray select 0) - (((_rndU select 0) select 1) select 0)];
			E_RArray set [1,(E_RArray select 1) - (((_rndU select 0) select 1) select 1)];
			E_RArray set [2,(E_RArray select 2) - (((_rndU select 0) select 1) select 2)];
			E_RArray set [3,(E_RArray select 3) - (((_rndU select 0) select 1) select 3)];		
			Dis_OpforTickets = Dis_OpforTickets - 1;		
		};
		true;
	} count [1,2];
	
	systemChat format ["POS: %1 ENEMY: %2",_EnemyPos,_Enemy];
	_wp = _grp addwaypoint[_EnemyPos,1];
	_wp setwaypointtype "MOVE";
	_wp setWaypointSpeed "NORMAL";
	_wp2 = _grp addwaypoint[_EnemyPos,1];
	_wp2 setwaypointtype "MOVE";
	_wp2 setWaypointSpeed "NORMAL";

	private _grp2 = createGroup _CSide;
	_grpList pushback _grp2;
	{
		private _rndU = selectRandom _InfList;
		private _unit = _grp2 createUnit [((_rndU select 0) select 0),_SpwnPos, [], 25, "FORM"];
		[_unit] joinSilent _grp2;	
		if (_CSide isEqualTo West) then
		{
			W_RArray set [0,(W_RArray select 0) - (((_rndU select 0) select 1) select 0)];
			W_RArray set [1,(W_RArray select 1) - (((_rndU select 0) select 1) select 1)];
			W_RArray set [2,(W_RArray select 2) - (((_rndU select 0) select 1) select 2)];
			W_RArray set [3,(W_RArray select 3) - (((_rndU select 0) select 1) select 3)];		
			Dis_BluforTickets = Dis_BluforTickets - 1;
		}
		else
		{
			E_RArray set [0,(E_RArray select 0) - (((_rndU select 0) select 1) select 0)];
			E_RArray set [1,(E_RArray select 1) - (((_rndU select 0) select 1) select 1)];
			E_RArray set [2,(E_RArray select 2) - (((_rndU select 0) select 1) select 2)];
			E_RArray set [3,(E_RArray select 3) - (((_rndU select 0) select 1) select 3)];		
			Dis_OpforTickets = Dis_OpforTickets - 1;		
		};
		true;
	} count [1,2,3,4];	

	{
if !(isNil "_x") then
{	

		[
		[_x,_Color,_mkr,_CSide],
		{
			_Group = _this select 0;
			_Color = _this select 1;
			_mkr = _this select 2;
			_CSide = _this select 3;
			_Marker = createMarkerLocal [format ["ID_%1",_Group],[0,0,0]];
			_Marker setMarkerShapeLocal 'ICON';
			_Marker setMarkerColorLocal _Color;
			_Marker setMarkerTypeLocal _mkr;
			_Marker setMarkerSizeLocal [1,1];			
			
			if (isServer) then {[_Cside,_Marker,_Group,"Guerrilla"] call DIS_fnc_mrkersave; };
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
				_Marker setMarkerTextLocal format ["INTERCEPT SQUAD: %1",({alive _x} count (units _Group))];
				_Marker setMarkerPosLocal (getposASL (leader _Group));
				sleep 1.25;
			};
			sleep 5;
			deleteMarker _Marker;
		}
		
		] remoteExec ["bis_fnc_Spawn",_Cside];
		};
	} foreach _grpList;
	
	sleep 45;
	systemChat format ["POS: %1 ENEMY: %2",_EnemyPos,_Enemy];
	_wp = _grp2 addwaypoint[_EnemyPos,1];
	_wp setwaypointtype "MOVE";
	_wp setWaypointSpeed "NORMAL";
	
	sleep 600;
	if (_West) then
	{
		{
			W_ActiveUnits pushback _x;
			true;
		} count units _grp;
		{
			W_ActiveUnits pushback _x;
			true;
		} count units _grp2;	
	}
	else
	{
		{
			E_ActiveUnits pushback _x;
			true;
		} count units _grp;
		{
			E_ActiveUnits pushback _x;
			true;
		} count units _grp2;		
	};
	
	

	
	
	
};

//Low Threat
if (_Lvl <= 4) exitWith 
{

	_AddNewsArray = ["Low Enemy Threat",format 
	[
	"
	A small group of enemy troops has been spotted. We will send troops to reinforce possible threatened areas.<br/>
	"
	
	,"Hai"
	]
	];
	if (_WestRun) then {dis_WNewsArray pushback _AddNewsArray;publicVariable "dis_WNewsArray";} else {dis_ENewsArray pushback _AddNewsArray;publicVariable "dis_ENewsArray";};
	
	
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",_CSide];	


	//Much like before. The Guerilla commander will lean toward utilizing more infantry than heavy vehicles.
	//This threat level will see an increase in the amount of units spawned with the addition of light vehicles.
	//Now lets spawn in the units.
	//First we have to find a good spawn location.
	private _Enemy = _CommanderAct call dis_ClosestEnemy;
	private _EnemyPos = getpos _Enemy;
	private _SpawnLoc = [_BarrackList,_Enemy,true] call dis_closestobj;
	private _SpawnLocV = [_LightFactoryList,_Enemy,true] call dis_closestobj;
	private _SpwnPos = getpos _SpawnLoc;
	
	//Spawn units to pursue target
	_grp = createGroup _CSide;
	_grpList pushback _grp;
	{
		private _rndU = selectRandom _InfList;	
		private _unit = _grp createUnit [((_rndU select 0) select 0),_SpwnPos, [], 25, "FORM"];
		[_unit] joinSilent _grp;
		if (_CSide isEqualTo West) then
		{
			W_RArray set [0,(W_RArray select 0) - (((_rndU select 0) select 1) select 0)];
			W_RArray set [1,(W_RArray select 1) - (((_rndU select 0) select 1) select 1)];
			W_RArray set [2,(W_RArray select 2) - (((_rndU select 0) select 1) select 2)];
			W_RArray set [3,(W_RArray select 3) - (((_rndU select 0) select 1) select 3)];		
			Dis_BluforTickets = Dis_BluforTickets - 1;
		}
		else
		{
			E_RArray set [0,(E_RArray select 0) - (((_rndU select 0) select 1) select 0)];
			E_RArray set [1,(E_RArray select 1) - (((_rndU select 0) select 1) select 1)];
			E_RArray set [2,(E_RArray select 2) - (((_rndU select 0) select 1) select 2)];
			E_RArray set [3,(E_RArray select 3) - (((_rndU select 0) select 1) select 3)];		
			Dis_OpforTickets = Dis_OpforTickets - 1;		
		};
	} count [1,2,3,4,5,6];
	systemChat format ["POS: %1 ENEMY: %2",_EnemyPos,_Enemy];
	_wp = _grp addwaypoint[_EnemyPos,1];
	_wp setwaypointtype "MOVE";
	_wp setWaypointSpeed "NORMAL";
	_wp2 = _grp addwaypoint[_EnemyPos,1];
	_wp2 setwaypointtype "MOVE";
	_wp2 setWaypointSpeed "NORMAL";
	
	//Lets create a few assault light vehicles
	if (_LFactorySwitch) then
	{
		private _SpwnPosV = getpos _SpawnLocV;	
		private _grp2 = createGroup _CSide;
		_grpList pushback _grp2;
		private _rndLV = selectRandom _LList;
		
		//Random position while spawning on road
		private _CRoad = [0,0,0];			
		private _rnd = random 100;
		private _dist = (_rnd + 25);
		private _dir = random 360;
		private _position = [(_SpwnPosV select 0) + (sin _dir) * _dist, (_SpwnPosV select 1) + (cos _dir) * _dist, 0];
		
		private _list = _position nearRoads 1000;
		if !(_list isEqualTo []) then
		{
			_Road = [_list,_position,true] call dis_closestobj;
			_CRoad = getpos _Road;
		}
		else
		{
			_CRoad = _position;
		};
				
		private _positionFIN = _CRoad findEmptyPosition [0,150,(_ActualSpawnHeavy select 0)];	
		if (_positionFIN isEqualTo []) then {_positionFIN = _CRoad};			
		
		
		private _veh = ((_rndLV select 0) select 0) createVehicle _positionFIN;		
		_veh allowdamage false;
		_veh spawn {sleep 10;_this allowdamage true;};
		
		private _MaterialCost = (((_rndLV select 0) select 1) select 3);		
		
			_CrtCnt = 0;
		for "_i" from 1 to (round (_MaterialCost/5)) do 
		{
			if (_CrtCnt < 13) then
			{
			_CrtCnt = _CrtCnt + 1;
			private _rndU = selectRandom _InfList;	
		private _unit = _grp2 createUnit [((_rndU select 0) select 0),_SpwnPos, [], 25, "FORM"];
		[_unit] joinSilent _grp2;	
			_Unit moveInAny _veh;
			if (_CSide isEqualTo West) then {Dis_BluforTickets = Dis_BluforTickets - 1} else {Dis_OpforTickets = Dis_OpforTickets - 1;};
			};
		};

		[_grp2,((_rndU select 0) select 0)] spawn dis_VehicleManage;		
		[_veh,_grp2] spawn dis_VehicleDespawn;
		//_veh spawn dis_UnitStuck;		
		
	};

	
	
	
	
	
	
	
	
	{
if !(isNil "_x") then
{

		[
		[_x,_Color,_mkr,_CSide],
		{
			_Group = _this select 0;
			_Color = _this select 1;
			_mkr = _this select 2;
			_CSide = _this select 3;
			_Marker = createMarkerLocal [format ["ID_%1",_Group],[0,0,0]];
			_Marker setMarkerShapeLocal 'ICON';
			_Marker setMarkerColorLocal _Color;
			_Marker setMarkerSizeLocal [1,1];
			_Marker setMarkerTypeLocal _mkr;	

			if (isServer) then {[_Cside,_Marker,_Group,"Guerrilla"] call DIS_fnc_mrkersave; };
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
				_Marker setMarkerTextLocal format ["INTERCEPT SQUAD: %1",({alive _x} count (units _Group))];
				_Marker setMarkerPosLocal (getposASL (leader _Group));
				sleep 1.25;
			};
			sleep 5;
			deleteMarker _Marker;
		}
		
		] remoteExec ["bis_fnc_Spawn",_Cside];
		};
	} foreach _grpList;	
	
	sleep 45;
	if !(isNil "_grp2") then
	{
	systemChat format ["POS: %1 ENEMY: %2",_EnemyPos,_Enemy];
		_wp = _grp2 addwaypoint[_EnemyPos,1];
		_wp setwaypointtype "MOVE";
		_wp setWaypointSpeed "NORMAL";	
	};
	
	sleep 600;
	if (_West) then
	{
		{
			W_ActiveUnits pushback _x;
			true;
		} count units _grp;
		if !(isNil "_grp2") then
		{	
			{
				W_ActiveUnits pushback _x;
				true;
			} count units _grp2;	
		};
	}
	else
	{
		{
			E_ActiveUnits pushback _x;
			true;
		} count units _grp;
		if !(isNil "_grp2") then
		{		
			{
				E_ActiveUnits pushback _x;
				true;
			} count units _grp2;
		};
	};	
	
	
	
	
};

//Moderate Threat
if (_Lvl <=6) exitWith 
{

	_AddNewsArray = ["Moderate Enemy Threat",format 
	[
	"
	We have deployed troops to meet this threat.<br/>
	"
	
	,"Hai"
	]
	];
	if (_WestRun) then {dis_WNewsArray pushback _AddNewsArray;publicVariable "dis_WNewsArray";} else {dis_ENewsArray pushback _AddNewsArray;publicVariable "dis_ENewsArray";};
	
	
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",_CSide];		

	//Much like before. The Guerilla commander will lean toward utilizing more infantry than heavy vehicles.
	//This threat level will see an increase in the amount of units spawned with the addition of light vehicles mixed with 1 heavy vehicle - if possible.
	//The commander will move troops to protect the targeted town, and then move out if not used later.
	//Now lets spawn in the units.
	//First we have to find a good spawn location.
	private _Enemy = _CommanderAct call dis_ClosestEnemy;
	private _EnemyPos = getpos _Enemy;
	private _SpawnLoc = [_BarrackList,_Enemy,true] call dis_closestobj;
	private _SpawnLocV = [_LightFactoryList,_Enemy,true] call dis_closestobj;
	private _SpawnLocH = [_HeavyFactoryList,_Enemy,true] call dis_closestobj;
	private _SpwnPos = getpos _SpawnLoc;
	private _TA = (_this select 1) call dis_compiledTerritory;
	private _TALoc = [_TA,_Enemy,true] call dis_closestobj;	
	private _TAPos = getpos _TALoc;
	private _grp = grpNull;
	private _grp2 = grpNull;
	private _grp3 = grpNull;
	
	//Spawn units to pursue target
	private _grp = createGroup _CSide;
	_grpList pushback _grp2;
	{
		private _rndU = selectRandom _InfList;	
		private _unit = _grp createUnit [((_rndU select 0) select 0),_SpwnPos, [], 25, "FORM"];
		[_unit] joinSilent _grp;	
		if (_CSide isEqualTo West) then
		{
			W_RArray set [0,(W_RArray select 0) - (((_rndU select 0) select 1) select 0)];
			W_RArray set [1,(W_RArray select 1) - (((_rndU select 0) select 1) select 1)];
			W_RArray set [2,(W_RArray select 2) - (((_rndU select 0) select 1) select 2)];
			W_RArray set [3,(W_RArray select 3) - (((_rndU select 0) select 1) select 3)];		
			Dis_BluforTickets = Dis_BluforTickets - 1;
		}
		else
		{
			E_RArray set [0,(E_RArray select 0) - (((_rndU select 0) select 1) select 0)];
			E_RArray set [1,(E_RArray select 1) - (((_rndU select 0) select 1) select 1)];
			E_RArray set [2,(E_RArray select 2) - (((_rndU select 0) select 1) select 2)];
			E_RArray set [3,(E_RArray select 3) - (((_rndU select 0) select 1) select 3)];		
			Dis_OpforTickets = Dis_OpforTickets - 1;		
		};
		true;
	} count [1,2,3,4,5,6,7,8,9,10];
systemChat format ["TAPOS: %1 _TALoc: %2",_TAPos,_TALoc];	
	private _wp = _grp addwaypoint[_TAPos,1];
	_wp setwaypointtype "MOVE";
	_wp setWaypointSpeed "NORMAL";
	private _wp2 = _grp addwaypoint[_TAPos,1];
	_wp2 setwaypointtype "MOVE";
	_wp2 setWaypointSpeed "NORMAL";
	
	//Lets create a few assault light vehicles
	if (_LFactorySwitch) then
	{
			private _SpwnPosV = getpos _SpawnLocV;	
			_grp2 = createGroup _CSide;
			_grpList pushback _grp2;			
		{
			private _rndLV = selectRandom _LList;
			
			//Random position while spawning on road
			private _CRoad = [0,0,0];			
			private _rnd = random 100;
			private _dist = (_rnd + 25);
			private _dir = random 360;
			private _position = [(_SpwnPosV select 0) + (sin _dir) * _dist, (_SpwnPosV select 1) + (cos _dir) * _dist, 0];
			
			private _list = _position nearRoads 1000;
			if !(_list isEqualTo []) then
			{
				_Road = [_list,_position,true] call dis_closestobj;
				_CRoad = getpos _Road;
			}
			else
			{
				_CRoad = _position;
			};
					
			private _positionFIN = _CRoad findEmptyPosition [0,150,(_ActualSpawnHeavy select 0)];	
			if (_positionFIN isEqualTo []) then {_positionFIN = _CRoad};					
			
			private _veh = ((_rndLV select 0) select 0) createVehicle _positionFIN;		
			_veh allowdamage false;
			_veh spawn {sleep 10;_this allowdamage true;};
			
			private _MaterialCost = (((_rndLV select 0) select 1) select 3);		
			
			_CrtCnt = 0;
			for "_i" from 1 to (round (_MaterialCost/5)) do 
			{
				if (_CrtCnt < 13) then
				{
					_CrtCnt = _CrtCnt + 1;
					private _rndU = selectRandom _InfList;	
					private _unit = _grp2 createUnit [((_rndU select 0) select 0),_SpwnPos, [], 25, "FORM"];
					[_unit] joinSilent _grp2;	
					_Unit moveInAny _veh;
					if (_CSide isEqualTo West) then {Dis_BluforTickets = Dis_BluforTickets - 1} else {Dis_OpforTickets = Dis_OpforTickets - 1;};
				};
			};
	
			[_grp2,((_rndU select 0) select 0)] spawn dis_VehicleManage;		
			[_veh,_grp2] spawn dis_VehicleDespawn;
			//_veh spawn dis_UnitStuck;
	systemChat format ["TAPOS: %1 _TALoc: %2",_TAPos,_TALoc];			
			private _wp = _grp2 addwaypoint[_TAPos,1];
			_wp setwaypointtype "MOVE";
			_wp setWaypointSpeed "NORMAL";
			true;
		} count [1,2];
		
	};

	//Lets create a few heavy assault vehicles
	if (_HFactorySwitch) then
	{
			private _SpwnPosV = getpos _SpawnLocH;	
			_grp3 = createGroup _CSide;	
			_grpList pushback _grp3;	
			private _rndLV = selectRandom _HList;
			
			//Random position while spawning on road
			private _CRoad = [0,0,0];			
			private _rnd = random 100;
			private _dist = (_rnd + 25);
			private _dir = random 360;
			private _position = [(_SpwnPosV select 0) + (sin _dir) * _dist, (_SpwnPosV select 1) + (cos _dir) * _dist, 0];
			
			private _list = _position nearRoads 1000;
			if !(_list isEqualTo []) then
			{
				_Road = [_list,_position,true] call dis_closestobj;
				_CRoad = getpos _Road;
			}
			else
			{
				_CRoad = _position;
			};
					
			private _positionFIN = _CRoad findEmptyPosition [0,150,(_ActualSpawnHeavy select 0)];	
			if (_positionFIN isEqualTo []) then {_positionFIN = _CRoad};				
			
			private _veh = ((_rndLV select 0) select 0) createVehicle _positionFIN;		
			_veh allowdamage false;
			_veh spawn {sleep 10;_this allowdamage true;};
			
			private _MaterialCost = (((_rndLV select 0) select 1) select 3);		
			
			_CrtCnt = 0;
			for "_i" from 1 to (round (_MaterialCost/5)) do 
			{
				if (_CrtCnt < 13) then
				{
					_CrtCnt = _CrtCnt + 1;
				private _rndU = selectRandom _InfList;	
				private _unit = _grp3 createUnit [((_rndU select 0) select 0),_SpwnPos, [], 25, "FORM"];
				[_unit] joinSilent _grp3;	
				_Unit moveInAny _veh;
				if (_CSide isEqualTo West) then {Dis_BluforTickets = Dis_BluforTickets - 1} else {Dis_OpforTickets = Dis_OpforTickets - 1;};
				};
			};
	
			[_grp3,((_rndU select 0) select 0)] spawn dis_VehicleManage;		
			[_veh,_grp3] spawn dis_VehicleDespawn;
			//_veh spawn dis_UnitStuck;
	systemChat format ["TAPOS: %1 _TALoc: %2",_TAPos,_TALoc];			
			private _wp = _grp3 addwaypoint[_TAPos,1];
			_wp setwaypointtype "MOVE";
			_wp setWaypointSpeed "NORMAL";				
		
	};
	

	
	
	
	
	
	
	{
if !(isNil "_x") then
{	
	
		[
		[_x,_Color,_mkr,_CSide],
		{
			_Group = _this select 0;
			_Color = _this select 1;
			_mkr = _this select 2;
			_CSide = _this select 3;
			_Marker = createMarkerLocal [format ["ID_%1",_Group],[0,0,0]];
			_Marker setMarkerShapeLocal 'ICON';
			_Marker setMarkerColorLocal _Color;
			_Marker setMarkerSizeLocal [1,1];
			_Marker setMarkerTypeLocal _mkr;			

			if (isServer) then {[_Cside,_Marker,_Group,"Guerrilla"] call DIS_fnc_mrkersave; };
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
				_Marker setMarkerTextLocal format ["DEFENCE SQUAD: %1",({alive _x} count (units _Group))];
				_Marker setMarkerPosLocal (getposASL (leader _Group));
				sleep 1.25;
			};
			sleep 5;
			deleteMarker _Marker;
		}
		
		] remoteExec ["bis_fnc_Spawn",_Cside];
		};
		true;
	} count _grpList;
	
	
	sleep 600;
	if (_West) then
	{
		{
			W_ActiveUnits pushback _x;
			true;
		} count units _grp;
		{
			W_ActiveUnits pushback _x;
			true;
		} count units _grp2;
		{
			W_ActiveUnits pushback _x;
			true;
		} count units _grp3;		
	}
	else
	{
		{
			E_ActiveUnits pushback _x;
			true;
		} count units _grp;
		{
			E_ActiveUnits pushback _x;
			true;
		} count units _grp2;
		{
			E_ActiveUnits pushback _x;
			true;
		} count units _grp3;				
	};	
		
	
	
	
};

//High Threat
if (_Lvl <=8) exitWith
{


	_AddNewsArray = ["High Enemy Threat",format 
	[
	"
	We have deployed troops to meet this threat.<br/>
	"
	
	,"Hai"
	]
	];
	if (_WestRun) then {dis_WNewsArray pushback _AddNewsArray;publicVariable "dis_WNewsArray";} else {dis_ENewsArray pushback _AddNewsArray;publicVariable "dis_ENewsArray";};
	
	
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",_CSide];		
	
	
	//Much like before. The Guerilla commander will lean toward utilizing more infantry than heavy vehicles.
	//This threat level will see an increase in the amount of units spawned with the addition of light vehicles mixed with 1 heavy vehicle - if possible.
	//The commander will move troops to protect the targeted town, and then move out if not used later.
	//Now lets spawn in the units.
	//First we have to find a good spawn location.
	private _Enemy = _CommanderAct call dis_ClosestEnemy;
	private _EnemyPos = getpos _Enemy;
	private _SpawnLoc = [_BarrackList,_Enemy,true] call dis_closestobj;
	private _SpawnLocV = [_LightFactoryList,_Enemy,true] call dis_closestobj;
	private _SpawnLocH = [_HeavyFactoryList,_Enemy,true] call dis_closestobj;
	private _SpwnPos = getpos _SpawnLoc;
	private _TA = (_this select 1) call dis_compiledTerritory;
	private _TALoc = [_TA,_Enemy,true] call dis_closestobj;	
	private _TAPos = getpos _TALoc;
	private _grp = grpNull;
	private _grp2 = grpNull;
	private _grp3 = grpNull;
	
	//Spawn units to pursue target
	private _grp = createGroup _CSide;
	_grpList pushback _grp;	
	{
		private _rndU = selectRandom _InfList;	
		private _unit = _grp createUnit [((_rndU select 0) select 0),_SpwnPos, [], 25, "FORM"];
		[_unit] joinSilent _grp;	
		if (_CSide isEqualTo West) then
		{
			W_RArray set [0,(W_RArray select 0) - (((_rndU select 0) select 1) select 0)];
			W_RArray set [1,(W_RArray select 1) - (((_rndU select 0) select 1) select 1)];
			W_RArray set [2,(W_RArray select 2) - (((_rndU select 0) select 1) select 2)];
			W_RArray set [3,(W_RArray select 3) - (((_rndU select 0) select 1) select 3)];		
			Dis_BluforTickets = Dis_BluforTickets - 1;
		}
		else
		{
			E_RArray set [0,(E_RArray select 0) - (((_rndU select 0) select 1) select 0)];
			E_RArray set [1,(E_RArray select 1) - (((_rndU select 0) select 1) select 1)];
			E_RArray set [2,(E_RArray select 2) - (((_rndU select 0) select 1) select 2)];
			E_RArray set [3,(E_RArray select 3) - (((_rndU select 0) select 1) select 3)];		
			Dis_OpforTickets = Dis_OpforTickets - 1;		
		};	
	} count [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16];
	
	private _wp = _grp addwaypoint[_TAPos,1];
	_wp setwaypointtype "MOVE";
	_wp setWaypointSpeed "NORMAL";
	private _wp2 = _grp addwaypoint[_TAPos,1];
	_wp2 setwaypointtype "MOVE";
	_wp2 setWaypointSpeed "NORMAL";
	
	//Lets create a few assault light vehicles
	if (_LFactorySwitch) then
	{
			private _SpwnPosV = getpos _SpawnLocV;	
			_grp2 = createGroup _CSide;	
			_grpList pushback _grp2;
		{
			private _rndLV = selectRandom _LList;			
			private _veh = ((_rndLV select 0) select 0) createVehicle _SpwnPosV;		
			_veh allowdamage false;
			_veh spawn {sleep 10;_this allowdamage true;};
			
			private _MaterialCost = (((_rndLV select 0) select 1) select 3);		
			
			_CrtCnt = 0;
			for "_i" from 1 to (round (_MaterialCost/5)) do 
			{
				if (_CrtCnt < 13) then
				{
					_CrtCnt = _CrtCnt + 1;
				private _rndU = selectRandom _InfList;	
				private _unit = _grp2 createUnit [((_rndU select 0) select 0),_SpwnPos, [], 25, "FORM"];
				[_unit] joinSilent _grp2;	
				_Unit moveInAny _veh;
				if (_CSide isEqualTo West) then {Dis_BluforTickets = Dis_BluforTickets - 1} else {Dis_OpforTickets = Dis_OpforTickets - 1;};
				};
			};
	
			[_grp2,((_rndU select 0) select 0)] spawn dis_VehicleManage;		
			[_veh,_grp2] spawn dis_VehicleDespawn;
			//_veh spawn dis_UnitStuck;
	systemChat format ["TAPOS: %1 _TALoc: %2",_TAPos,_TALoc];			
			private _wp = _grp2 addwaypoint[_TAPos,1];
			_wp setwaypointtype "MOVE";
			_wp setWaypointSpeed "NORMAL";				
		} count [1,2,3];
		
	};

	//Lets create a few heavy assault vehicles
	if (_HFactorySwitch) then
	{
		{
			private _SpwnPosV = getpos _SpawnLocH;	
			_grp3 = createGroup _CSide;	
			_grpList pushback _grp3;			
			private _rndLV = selectRandom _HList;			
			private _veh = ((_rndLV select 0) select 0) createVehicle _SpwnPosV;		
			_veh allowdamage false;
			_veh spawn {sleep 10;_this allowdamage true;};
			
			private _MaterialCost = (((_rndLV select 0) select 1) select 3);		
			
			_CrtCnt = 0;
			for "_i" from 1 to (round (_MaterialCost/5)) do 
			{
				if (_CrtCnt < 13) then
				{
					_CrtCnt = _CrtCnt + 1;
				private _rndU = selectRandom _InfList;	
		private _unit = _grp3 createUnit [((_rndU select 0) select 0),_SpwnPos, [], 25, "FORM"];
		[_unit] joinSilent _grp3;	
				_Unit moveInAny _veh;
				if (_CSide isEqualTo West) then {Dis_BluforTickets = Dis_BluforTickets - 1} else {Dis_OpforTickets = Dis_OpforTickets - 1;};
				};
			};
	
			[_grp3,((_rndU select 0) select 0)] spawn dis_VehicleManage;		
			[_veh,_grp3] spawn dis_VehicleDespawn;
			//_veh spawn dis_UnitStuck;
	systemChat format ["TAPOS: %1 _TALoc: %2",_TAPos,_TALoc];			
			private _wp = _grp3 addwaypoint[_TAPos,1];
			_wp setwaypointtype "MOVE";
			_wp setWaypointSpeed "NORMAL";
		} count [1,2];			
		
	};
	

	
	
	
	
	
	
	{
if !(isNil "_x") then
{	

		[
		[_x,_Color,_mkr,_Cside],
		{
			_Group = _this select 0;
			_Color = _this select 1;
			_mkr = _this select 2;
			_CSide = _this select 3;
			_Marker = createMarkerLocal [format ["ID_%1",_Group],[0,0,0]];
			_Marker setMarkerShapeLocal 'ICON';
			_Marker setMarkerColorLocal _Color;
			_Marker setMarkerSizeLocal [1,1];
			_Marker setMarkerTypeLocal _mkr;

			if (isServer) then {[_Cside,_Marker,_Group,"Guerrilla"] call DIS_fnc_mrkersave; };
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
				_Marker setMarkerTextLocal format ["DEFENCE SQUAD: %1",({alive _x} count (units _Group))];
				_Marker setMarkerPosLocal (getposASL (leader _Group));
				sleep 1.25;
			};
			sleep 5;
			deleteMarker _Marker;
		}
		
		] remoteExec ["bis_fnc_Spawn",_Cside];

		};
	} count _grpList;
	
	
	sleep 600;
	if (_West) then
	{
		{
			W_ActiveUnits pushback _x;
			true;
		} count units _grp;
		{
			W_ActiveUnits pushback _x;
			true;
		} count units _grp2;
		{
			W_ActiveUnits pushback _x;
			true;
		} count units _grp3;		
	}
	else
	{
		{
			E_ActiveUnits pushback _x;
			true;
		} count units _grp;
		{
			E_ActiveUnits pushback _x;
			true;
		} count units _grp2;
		{
			E_ActiveUnits pushback _x;
			true;
		} count units _grp3;				
	};	
		
	
	
	
};


//Extremely Dangerous Threat
if (_LvL <= 11) exitWith
{

	_AddNewsArray = ["Extreme Enemy Threat",format 
	[
	"
	We have deployed troops to meet this threat.<br/>
	"
	
	,"Hai"
	]
	];
	if (_WestRun) then {dis_WNewsArray pushback _AddNewsArray;publicVariable "dis_WNewsArray";} else {dis_ENewsArray pushback _AddNewsArray;publicVariable "dis_ENewsArray";};
	
	
	["Beep_Target"] remoteExec ["PlaySoundEverywhere",_CSide];		


	//Much like before. The Guerilla commander will lean toward utilizing more infantry than heavy vehicles.
	//This threat level will see an increase in the amount of units spawned with the addition of light vehicles mixed with 1 heavy vehicle - if possible.
	//The commander will move troops to protect the targeted town, and then move out if not used later.
	//Now lets spawn in the units.
	//First we have to find a good spawn location.
	private _Enemy = _CommanderAct call dis_ClosestEnemy;
	private _EnemyPos = getpos _Enemy;
	private _SpawnLoc = [_BarrackList,_Enemy,true] call dis_closestobj;
	private _SpawnLocV = [_LightFactoryList,_Enemy,true] call dis_closestobj;
	private _SpawnLocH = [_HeavyFactoryList,_Enemy,true] call dis_closestobj;
	private _SpwnPos = getpos _SpawnLoc;
	private _TA = (_this select 1) call dis_compiledTerritory;
	private _TALoc = [_TA,_Enemy,true] call dis_closestobj;	
	private _TAPos = getpos _TALoc;
	private _grp = grpNull;
	private _grp2 = grpNull;
	private _grp3 = grpNull;
	
	//Spawn units to pursue target
	private _grp = createGroup _CSide;
	_grpList pushback _grp;
	{
		private _rndU = selectRandom _InfList;	
		private _unit = _grp createUnit [((_rndU select 0) select 0),_SpwnPos, [], 25, "FORM"];
		[_unit] joinSilent _grp;	
		if (_CSide isEqualTo West) then
		{
			W_RArray set [0,(W_RArray select 0) - (((_rndU select 0) select 1) select 0)];
			W_RArray set [1,(W_RArray select 1) - (((_rndU select 0) select 1) select 1)];
			W_RArray set [2,(W_RArray select 2) - (((_rndU select 0) select 1) select 2)];
			W_RArray set [3,(W_RArray select 3) - (((_rndU select 0) select 1) select 3)];		
			Dis_BluforTickets = Dis_BluforTickets - 1;
		}
		else
		{
			E_RArray set [0,(E_RArray select 0) - (((_rndU select 0) select 1) select 0)];
			E_RArray set [1,(E_RArray select 1) - (((_rndU select 0) select 1) select 1)];
			E_RArray set [2,(E_RArray select 2) - (((_rndU select 0) select 1) select 2)];
			E_RArray set [3,(E_RArray select 3) - (((_rndU select 0) select 1) select 3)];		
			Dis_OpforTickets = Dis_OpforTickets - 1;		
		};	

	} count [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21];
	systemChat format ["TAPOS: %1 _TALoc: %2",_TAPos,_TALoc];	
	private _wp = _grp addwaypoint[_TAPos,1];
	_wp setwaypointtype "MOVE";
	_wp setWaypointSpeed "NORMAL";
	private _wp2 = _grp addwaypoint[_TAPos,1];
	_wp2 setwaypointtype "MOVE";
	_wp2 setWaypointSpeed "NORMAL";
	
	//Lets create a few assault light vehicles
	if (_LFactorySwitch) then
	{
			private _SpwnPosV = getpos _SpawnLocV;	
			_grp2 = createGroup _CSide;	
			_grpList pushback _grp2;
		{
			private _rndLV = selectRandom _LList;			
			private _veh = ((_rndLV select 0) select 0) createVehicle _SpwnPosV;		
			_veh allowdamage false;
			_veh spawn {sleep 10;_this allowdamage true;};
			
			private _MaterialCost = (((_rndLV select 0) select 1) select 3);		
			
			_CrtCnt = 0;
			for "_i" from 1 to (round (_MaterialCost/5)) do 
			{
				if (_CrtCnt < 13) then
				{
					_CrtCnt = _CrtCnt + 1;
				private _rndU = selectRandom _InfList;	
		private _unit = _grp2 createUnit [((_rndU select 0) select 0),_SpwnPos, [], 25, "FORM"];
		[_unit] joinSilent _grp2;	
				_Unit moveInAny _veh;
				if (_CSide isEqualTo West) then {Dis_BluforTickets = Dis_BluforTickets - 1} else {Dis_OpforTickets = Dis_OpforTickets - 1;};
				};
			};
	
			[_grp2,((_rndU select 0) select 0)] spawn dis_VehicleManage;		
			[_veh,_grp2] spawn dis_VehicleDespawn;
			//_veh spawn dis_UnitStuck;
	systemChat format ["TAPOS: %1 _TALoc: %2",_TAPos,_TALoc];			
			private _wp = _grp2 addwaypoint[_TAPos,1];
			_wp setwaypointtype "MOVE";
			_wp setWaypointSpeed "NORMAL";				
		} count [1,2,3];
		
	};

	//Lets create a few heavy assault vehicles
	if (_HFactorySwitch) then
	{
		{
			private _SpwnPosV = getpos _SpawnLocH;	
			_grp3 = createGroup _CSide;	
			_grpList pushback _grp3;
			private _rndLV = selectRandom _HList;			
			private _veh = ((_rndLV select 0) select 0) createVehicle _SpwnPosV;		
			_veh allowdamage false;
			_veh spawn {sleep 10;_this allowdamage true;};
			
			private _MaterialCost = (((_rndLV select 0) select 1) select 3);		
			
			_CrtCnt = 0;
			for "_i" from 1 to (round (_MaterialCost/5)) do 
			{
				if (_CrtCnt < 13) then
				{
					_CrtCnt = _CrtCnt + 1;
				private _rndU = selectRandom _InfList;	
		private _unit = _grp3 createUnit [((_rndU select 0) select 0),_SpwnPos, [], 25, "FORM"];
		[_unit] joinSilent _grp3;	
				_Unit moveInAny _veh;
				if (_CSide isEqualTo West) then {Dis_BluforTickets = Dis_BluforTickets - 1} else {Dis_OpforTickets = Dis_OpforTickets - 1;};
				};
			};
	
			[_grp3,((_rndU select 0) select 0)] spawn dis_VehicleManage;		
			[_veh,_grp3] spawn dis_VehicleDespawn;
			//_veh spawn dis_UnitStuck;
	systemChat format ["TAPOS: %1 _TALoc: %2",_TAPos,_TALoc];			
			private _wp = _grp3 addwaypoint[_TAPos,1];
			_wp setwaypointtype "MOVE";
			_wp setWaypointSpeed "NORMAL";
		} count [1,2];			
		
	};
	

	
	
	
	
	
	
	{
if !(isNil "_x") then
{	

		[
		[_x,_Color,_mkr,_CSide],
		{
			_Group = _this select 0;
			_Color = _this select 1;
			_mkr = _this select 2;
			_CSide = _this select 3;
			_Marker = createMarkerLocal [format ["ID_%1",_Group],[0,0,0]];
			_Marker setMarkerShapeLocal 'ICON';
			_Marker setMarkerColorLocal _Color;
			_Marker setMarkerSizeLocal [1,1];
			_Marker setMarkerTypeLocal _mkr;	

			if (isServer) then {[_Cside,_Marker,_Group,"Guerrilla"] call DIS_fnc_mrkersave; };
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
				_Marker setMarkerTextLocal format ["DEFENCE SQUAD: %1",({alive _x} count (units _Group))];
				_Marker setMarkerPosLocal (getposASL (leader _Group));
				sleep 1.25;
			};
			sleep 5;
			deleteMarker _Marker;
		}
		
		] remoteExec ["bis_fnc_Spawn",_Cside]; 	
		};
	} count _grpList;
	
	
	sleep 600;
	if (_West) then
	{
		{
			W_ActiveUnits pushback _x;
			true;
		} count units _grp;
		{
			W_ActiveUnits pushback _x;
			true;
		} count units _grp2;
		{
			W_ActiveUnits pushback _x;
			true;
		} count units _grp3;		
	}
	else
	{
		{
			E_ActiveUnits pushback _x;
			true;
		} count units _grp;
		{
			E_ActiveUnits pushback _x;
			true;
		} count units _grp2;
		{
			E_ActiveUnits pushback _x;
			true;
		} count units _grp3;				
	};	
		

	
	
};