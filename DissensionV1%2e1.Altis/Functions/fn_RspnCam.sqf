//RspnCam
//

FNCTextSpawn = 
{
		private _hour = floor daytime;
		private _minute = floor ((daytime - _hour) * 60);
		private _second = floor (((((daytime) - (_hour))*60) - _minute)*60);
		private _time24 = text format ["%1:%2:%3",_hour,_minute,_second];
		[parseText format ["<t font='PuristaBold' size='1.5'>Dissension: Open War - Dissension between parties</t><br />%1: %2",(side (group player)),_time24], [-0.425,-0.185,2,2], nil, 5, [1,1], 0] spawn BIS_fnc_textTiles;  
		sleep 8; 
		[parseText format["<t font='PuristaBold' size='1.5'>%1: Re-deployed at Grid %2 </t>",name player,(mapGridPosition (getpos player))], [-0.425,-0.185,2,2], nil, 5, [1,1], 0] spawn BIS_fnc_textTiles;  
};
FNCcamSpawn = 
{
    _distance = 200;   
    _plr = vehicle player;   
    _dir = (getDir _plr) - 90;   
    _height = 200;   
    _camPos = _plr getPos [_distance, _dir];        
    _camPos set [2, _height];
    showCinemaBorder true;   
    _camera = "camera" camCreate _camPos;   
    _camera cameraEffect ["INTERNAL","BACK"];   
    _camera camPrepareFOV 0.700;   
    _camera camPrepareTarget _plr;   
    _camera camCommitPrepared 0;   
    _distance = _plr distance2D _camera;  
    [] spawn FNCTextSpawn; 
    sleep 0.2;
    while {_distance > 3} do    
    {
			_worldPos = positionCameraToWorld [-2,-0.2,4];   
			_camera camPreparePos _worldPos;    
			_camera camCommitPrepared 0.001;   
			waitUntil {camCommitted _camera};   
			_distance = _plr distance2D _camera;   
    };   
    _camera cameraEffect ["terminate","back"];   
    camDestroy _camera;   
};