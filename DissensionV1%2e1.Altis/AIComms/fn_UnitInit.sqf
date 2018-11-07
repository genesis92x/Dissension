_this addeventhandler ["Hit", {_this call DIS_fnc_HitEH;}];
_this addeventhandler ["Killed", {_this call DIS_fnc_ComKilled;}];
_this addeventhandler ["Reloaded", {_this call DIS_fnc_ComReload;}];
_this addeventhandler ["FiredMan", {_this call DIS_fnc_ComFired;}];
_this addeventhandler ["IncomingMissile", {_this call DIS_fnc_IncomingMissile;}];