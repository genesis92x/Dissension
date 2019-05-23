

//Defence side task!
private _ObjN = (str _PolePos)+(str _SSide);
[_SSide,_ObjN, ["DEFEND TOWN","This town is under assault! Push back the assault! Protect the radio tower and any secondary objectives.",_Marker], _PolePos, "AUTOASSIGNED", 100, true, "", true] call BIS_fnc_taskCreate;
_pole setVariable ["DIS_DefenceTID",_ObjN];


//Attack task!
private _ObjN = (str _PolePos)+(str _SSide);
[_SSide,_ObjN, ["ASSAULT TOWN","Assault this town! Destroy the radio tower, take the side objectives.",_Marker], _PolePos, "AUTOASSIGNED", 100, true, "", true] call BIS_fnc_taskCreate;
_pole setVariable ["DIS_AttackTID",_ObjN];





DIS_marker1 = createMarker ["DISMARKERTEST",(getpos _RndmPlayer)];
DIS_marker1 setMarkerShape "ELLIPSE";
DIS_marker1 setMarkerColor "ColorBlue";
DIS_marker1 setMarkerBrush "FDiagonal";
DIS_marker1 setMarkerSize [50,50];


private _RndmPlayer = selectRandom playableUnits;
[west,"WestMainObjective", ["Testing","Main Title",DIS_marker1], (getpos _RndmPlayer), "AUTOASSIGNED", 100, true, "", true] call BIS_fnc_taskCreate;



private _RndmPlayer = selectRandom playableUnits;
DIS_marker2 = createMarker ["DISMARKERTEST2",(getpos _RndmPlayer)];
DIS_marker2 setMarkerShape "ELLIPSE";
DIS_marker2 setMarkerColor "ColorBlue";
DIS_marker2 setMarkerBrush "FDiagonal";
DIS_marker2 setMarkerSize [50,50];

[west,["SideObjective2","WestMainObjective"], ["Side Objective! Get it!","Side Objective1",DIS_marker2], (getpos _RndmPlayer), "AUTOASSIGNED", 100, true, "", true] call BIS_fnc_taskCreate;


["WestMainObjective","FAILED"] call BIS_fnc_taskSetState;

["WestMainObjective",west] call BIS_fnc_deleteTask;


//Defend task!
private _ObjN = format ["%1-%2",_PolePos,_SSide];
[_SSide,_ObjN, [format ["Defend %1! Prevent the enemy from taking the town! Defend the radio tower and take the side objectives.",_NameLocation],format ["Defend %1",_NameLocation]], _PolePos, "AUTOASSIGNED", 100, true, "", true] call BIS_fnc_taskCreate;
_pole setVariable ["DIS_AttackTID",_ObjN];







//Attack task!
private _ObjN = format ["%1-%2",_PolePos,_AtkSide];
[_AtkSide,_ObjN, [format ["Assault %1! Take this location from our enemies! Destroy the radio tower and take the side objectives.",_NameLocation],format ["Assault %1",_NameLocation]], _PolePos, "AUTOASSIGNED", 100, true, "", true] call BIS_fnc_taskCreate;
_pole setVariable ["DIS_AttackTID",_ObjN];


