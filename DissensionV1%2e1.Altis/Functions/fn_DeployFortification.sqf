
	if (isNil "DIS_DIGINACT") then {DIS_DIGINACT = false;};
	if ((count DIS_FortificationArray) isEqualTo 0) exitWith {SYSTEMCHAT "YOU HAVE NO OBJECTS!";};
	private _Vrt = player getVariable ["DIS_HQ",""];
	DIS_TempArray = [];
	{
		if !(_x in DIS_TempArray) then
		{
			DIS_TempArray pushback _x;
		};
	} foreach DIS_FortificationArray;
	
	if !(_Vrt isEqualTo "") then
	{
		{
			if (_x isEqualTo "Land_Research_HQ_F") then
			{
				DIS_TempArray = DIS_TempArray - [_x];
			};
		} foreach DIS_TempArray;
	};

	DIS_cam = "camconstruct" camCreate (getpos player);
	DIS_cam cameraEffect ["Internal", "Front"];
	if !(isNil "DIS_CAMCONTROLS") then
	{
		(finddisplay 46) displayremoveeventhandler ["KeyDown",DIS_CAMCONTROLS];		
		(finddisplay 46) displayremoveeventhandler ["MouseButtonDown",DIS_CAMCONTROLS2];		
	};
	
	
	
	DIS_Floatchk =
	{
		private _Pos = getposASL _this;
		private _H = (_this call BIS_fnc_objectHeight)*2.2;
		_Pos set [2,((_Pos select 2) - _H)];
		private _PosE = [(_Pos select 0),(_Pos select 1),((_Pos select 2) - 5)];
		private _Ints = lineIntersectsSurfaces [_Pos, _PosE, _this, _this, true, 1,"GEOM","NONE"];
		if (count _Ints isEqualTo 0) then
		{
			private _PosATL = getPosATL _this;
			_PosATL set [2,0];
			_this setposATL _PosATL;
			systemChat "BUILDING SYSTEM: BROUGHT OBJECT TO GROUND. OBJECT HAS NO SUPPORT.";
		};	
		
	};
	
	
	DIS_CONTROLFUN2=
	{
		if (count DIS_TempArray < 1) exitWith {};
		switch (_this select 1) do
		{
				case 0:  //Left Mouse
				{
					playsound "FD_Timer_F";
					DIS_ArraySel = DIS_ArraySel - 1;
					deleteVehicle DIS_vehicleSp;
					if (DIS_ArraySel isEqualTo -1) then {DIS_ArraySel = 0};
					private _ObjTest = (DIS_TempArray select DIS_ArraySel);
					if (isNil "_ObjTest") then {DIS_ArraySel = DIS_ArraySel + 1;};
					DIS_vehicleSp = (DIS_TempArray select DIS_ArraySel) createVehiclelocal [0,0,0];
					DIS_vehicleSp allowdamage false;
					DIS_vehicleSp setVehicleLock "LOCKED";
					DIS_vehicleSp enableSimulation false;
					DIS_vehicleSp disableCollisionWith player;
					for [{_i=0}, {_i<5}, {_i=_i+1}] do 
					{
						DIS_vehicleSp setObjectTextureGlobal [_i, '#(rgb,8,8,3)color(0,1,0,0.8)'];
					};				
				};
				case 1: //Right Mouse
				{
					playsound "FD_Timer_F";
					DIS_ArraySel = DIS_ArraySel + 1;
					deleteVehicle DIS_vehicleSp;					
					private _ObjTest = (DIS_TempArray select DIS_ArraySel);
					if (isNil "_ObjTest") then {DIS_ArraySel = DIS_ArraySel - 1;};
					DIS_vehicleSp = (DIS_TempArray select DIS_ArraySel) createVehiclelocal [0,0,0];
					DIS_vehicleSp allowdamage false;
					DIS_vehicleSp setVehicleLock "LOCKED";
					DIS_vehicleSp enableSimulation false;
					DIS_vehicleSp disableCollisionWith player;
					for [{_i=0}, {_i<5}, {_i=_i+1}] do 
					{
						DIS_vehicleSp setObjectTextureGlobal [_i, '#(rgb,8,8,3)color(0,1,0,0.8)'];
					};					
					
				};
		};
	};
	
	
	DIS_CONTROLFUN =
	{
		if (count DIS_TempArray < 1) exitWith 
		{
			if (_this select 1 isEqualTo 1) then
			{
					CamDestroy DIS_Cam;
					[] spawn
					{
						sleep 0.01;
						if !(isNull (findDisplay 49)) then
						{
							(findDisplay 49) closedisplay 2;			
						};
					};			
			};
		};
		switch (_this select 1) do
		{
				case 1: //ESC
				{
					CamDestroy DIS_Cam;
					[] spawn
					{
						sleep 0.01;
						if !(isNull (findDisplay 49)) then
						{
							(findDisplay 49) closedisplay 2;			
						};
					};
				};
				case 19:  //R
				{
						DIS_BaseRotation = DIS_BaseRotation - 5;
				};
				case 20:  //T
				{
						DIS_BaseRotation = DIS_BaseRotation + 5;
				};
				case 33:  //F
				{
						DIS_Height = DIS_Height - 0.2;
						if (DIS_Height < -0.75) then {DIS_Height = -0.75};
				};	
				case 34:  //G
				{
						DIS_Height = DIS_Height + 0.2;
				};
				case 45:  //Z
				{
						if (DIS_Flush) then {DIS_Flush = false;systemChat "BUILDING SYSTEM:  FLUSH DISABLED";playsound "FD_Timer_F";} else {DIS_Flush = true;systemChat "BUILDING SYSTEM:  FLUSH ENABLED";playsound "FD_Timer_F";};
				};
				case 57:  //SPACE
				{
						if (DIS_TooClose) then
						{
							if !(_Vrt isEqualTo "") then
							{
								if (_Vrt distance2D DIS_vehicleSp > 350 && {DIS_vehicleSp in CfgFortificationHQA} && {!(DIS_DIGINACT)}) exitWith
								{
									systemChat "TOO FAR FROM HQ";
								};
							};
							playsound "FD_Target_PopDown_Large_F";
							private _TypeOf = (Typeof DIS_vehicleSp);
							private _SP1 = getposATL DIS_vehicleSp;
							private _SD1 = getdir DIS_vehicleSp;
							deletevehicle DIS_vehicleSp;
							private _CV = _TypeOf createVehicle [0,0,0];
							
							//Global effect
							[
								[_CV],
								{
									if (hasInterface) then
									{
										params ["_Obj"];
										_Obj call DIS_fnc_ObjPlacedEff;
									};
								}
						
							] remoteExec ["bis_fnc_Spawn",0]; 							
							
							
							_CV allowdamage false;
							_CV setposATL [_SP1 select 0,_SP1 select 1,(_SP1 select 2)];
							_CV setdir _SD1;
							if (DIS_Flush) then {_CV setVectorUp surfaceNormal position _CV;};
							_CV call DIS_Floatchk;
							_CV enableSimulation false;
							DIS_FreezeObjects pushback _CV;
							
							{
								if (_x isEqualTo _TypeOf) exitWith
								{
									DIS_FortificationArray deleteAt _forEachIndex;
								};
							} foreach DIS_FortificationArray;
							[_TypeOf,player,_CV] call DIS_fnc_PlacedBuilding;
							private _Leftcnt = 0;
							{
								if (_x isEqualTo _TypeOf) then
								{
									_Leftcnt = _Leftcnt + 1;
								};
							} foreach DIS_FortificationArray;
							systemChat format ["FORTIFICATION TYPE COUNT LEFT: %1",_Leftcnt];
							if (_Leftcnt isEqualTo 0) then 
							{
								DIS_TempArray = DIS_TempArray - [_TypeOf];
								_TypeOf = (DIS_TempArray select 0);
								if !(isNil "_TypeOf") then
								{
									deleteVehicle DIS_vehicleSp;
									//Get loop ready!
									DIS_vehicleSp = _TypeOf createVehiclelocal [0,0,0];
									DIS_vehicleSp allowdamage false;
									DIS_vehicleSp setVehicleLock "LOCKED";
									DIS_vehicleSp enableSimulation false;
									DIS_vehicleSp disableCollisionWith player;
									player disableCollisionWith DIS_vehicleSp;
									for [{_i=0}, {_i<5}, {_i=_i+1}] do 
									{
										DIS_vehicleSp setObjectTextureGlobal [_i, '#(rgb,8,8,3)color(0,1,0,0.8)'];
									};
								};
							}
							else
							{
								DIS_vehicleSp = _TypeOf createVehiclelocal [0,0,0];
								DIS_vehicleSp allowdamage false;
								DIS_vehicleSp setVehicleLock "LOCKED";
								DIS_vehicleSp enableSimulation false;
								DIS_vehicleSp disableCollisionWith player;
								player disableCollisionWith DIS_vehicleSp;
								for [{_i=0}, {_i<5}, {_i=_i+1}] do 
								{
									DIS_vehicleSp setObjectTextureGlobal [_i, '#(rgb,8,8,3)color(0,1,0,0.8)'];
								};
							};
					}
					else
					{
						playsound "addItemFailed";
						systemChat "TOO CLOSE TO A ROAD, OR TO ANOTHER OBJECT, OR TOO FAR FROM HQ, TO PLACE THIS STRUCTURE";
					};						
				};	
				case 49: //N
				{
					if (isNil "DIS_CAMNVG") then {DIS_CAMNVG = false;};
					if !(DIS_CAMNVG) then
					{
						camUseNVG true;
						DIS_CAMNVG = true;
					}
					else
					{
						camUseNVG false;
						DIS_CAMNVG = false;
					};
				};
		};
		false
	};
	
	DIS_CAMCONTROLS = (findDisplay 46) displayAddEventHandler ["KeyDown","_this call DIS_CONTROLFUN;false"];	
	DIS_CAMCONTROLS2 = (findDisplay 46) displayAddEventHandler ["MouseButtonDown","_this call DIS_CONTROLFUN2;false"];	

	DIS_FreezeObjects = nearestObjects [(getpos player), ["All"], 250];
	{
		if (local _x) then
		{
			_x enableSimulation false;
		};
	} foreach DIS_FreezeObjects;

sleep 1;
DIS_vehicleSp = (DIS_TempArray select 0) createVehiclelocal [0,0,0];
DIS_vehicleSp allowdamage false;
DIS_vehicleSp setVehicleLock "LOCKED";
DIS_vehicleSp enableSimulation false;
DIS_vehicleSp disableCollisionWith player;
player disableCollisionWith DIS_vehicleSp;
for [{_i=0}, {_i<5}, {_i=_i+1}] do 
{
	DIS_vehicleSp setObjectTextureGlobal [_i, '#(rgb,8,8,3)color(0,1,0,0.8)'];
};	
	

DIS_Height = 0;
DIS_BaseRotation = 0;
DIS_Flush = true;	
DIS_ArraySel = 0;

//LETS HIDE ALL ENEMY UNITS
private _HideObj = [];
{
	if !(playerSide isEqualTo (side _x)) then
	{
		_x hideObject true;
		_HideObj pushback _x;
		if !(isNull objectParent _x) then
		{
			(vehicle _x) hideObject true;
			_HideObj pushback (vehicle _x);
		};
	};
} foreach allunits;

[] spawn {sleep 2;[["Dissension","CameraControls"],15,"",35,"",true,true,false,true] call BIS_fnc_advHint;};

while {alive DIS_Cam && {alive player}} do
{
			if !(isNil "DIS_vehicleSp") then
			{
				_ClosestEn = [_HideObj,DIS_vehicleSp,true,"CE1"] call dis_closestobj;			
				_RD = (sizeof typeof (DIS_vehicleSp));
				_nl = screenToWorld [0.5,0.5];
				_no = nearestObjects [_nl, ["All"], 100];
				_no = _no - [player];
				_no = _no - [DIS_vehicleSp];
				_pos = getposATL (_no select 0);
				
				
				private _Rlist = _nl nearRoads 5;
				if ((_no select 0) distance _nl > (_RD/5) && {(count _Rlist < 1)} && {_ClosestEn distance2D DIS_vehicleSp > 100}) then
				{
					DIS_vehicleSp setposATL [_nl select 0,_nl select 1,(_nl select 2) + DIS_Height];
					DIS_vehicleSp setdir ((getdir player) + DIS_BaseRotation);
					if (DIS_Flush) then {DIS_vehicleSp setVectorUp surfaceNormal position DIS_vehicleSp;};
					DIS_TooClose = true;
				}
				else
				{
					hintSilent "UNABLE TO PREVIEW OBJECT HERE.";
					//DIS_vehicleSp setposATL [_nl select 0,_nl select 1,(_nl select 2) + DIS_Height];
					//DIS_vehicleSp setdir ((getdir player) + DIS_BaseRotation);
					//if (DIS_Flush) then {DIS_vehicleSp setVectorUp surfaceNormal position DIS_vehicleSp;};				
					DIS_TooClose = false;
				};
				
				if !(_Vrt isEqualTo "") then
				{
					if (DIS_vehicleSp distance2D _Vrt > 200 && {!(DIS_DIGINACT)}) then
					{
						DIS_TooClose = false;
					};
				}
				else
				{
					if (DIS_vehicleSp distance2D player > 200 && {!(DIS_DIGINACT)}) then
					{
						DIS_TooClose = false;
					};					
				};				
				
			};
};

	{
		if (local _x) then
		{
			_x enableSimulation true;
		};
	} foreach DIS_FreezeObjects;


if !(isNil "DIS_vehicleSp") then
{
	deleteVehicle DIS_vehicleSp;
};

if (alive DIS_CAM) then
{
	camDestroy DIS_CAM;
};

if !(isNil "DIS_CAMCONTROLS") then
{
	(finddisplay 46) displayremoveeventhandler ["KeyDown",DIS_CAMCONTROLS];		
	(finddisplay 46) displayremoveeventhandler ["MouseButtonDown",DIS_CAMCONTROLS2];		
};

{
	_x hideObject false;
} foreach _HideObj;