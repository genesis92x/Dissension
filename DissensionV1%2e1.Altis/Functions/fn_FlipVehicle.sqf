//This function will allow a player ot unflip a flipped vehicle easily. It will not undo any damage and may even cause the vehicle to launch into space. How fun does that sound?
private _caller = _this select 1;
private _veh = nearestObjects [_caller, ["landVehicle"], 5] select 0;
_veh setVectorUp [0,0,1];
private _Pos = (getPosATL _veh);
_veh setPosATL [(_Pos select 0), (_Pos select 1), 0];