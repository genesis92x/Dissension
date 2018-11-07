	/*
	Author: code34 nicolas_boiteux@yahoo.fr
	Copyright (C) 2014-2015 Nicolas BOITEUX

	CLASS OO_CAMERA
	
	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.
	
	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>. 
	*/

	#include "oop.h"

	CLASS("OO_CAMERA")
		PRIVATE VARIABLE("bool","attach");
		PRIVATE VARIABLE("object","camera");
		PRIVATE VARIABLE("string","name");
		PRIVATE VARIABLE("string","ctrlname");
		PRIVATE STATIC_VARIABLE("scalar","globalinstanceid");
		PRIVATE VARIABLE("scalar","instanceid");

		PUBLIC FUNCTION("array","constructor") {
			private ["_cam", "_instanceid", "_name"];

			_instanceid = MEMBER("globalinstanceid",nil);
			if (isNil "_instanceid") then {_instanceid = 0;};
			_instanceid = _instanceid + 1;
			MEMBER("globalinstanceid",_instanceid);
			MEMBER("instanceid",_instanceid);						

			_name = "rtt"+str(_instanceid);
			MEMBER("name", _name);

			_cam = "camera" camCreate [position player select 0, position player select 1, 50];
			_cam cameraEffect ["internal","back", _name]; 
			MEMBER("camera", _cam);

			_name = "ctrlname" + str(MEMBER("instanceid", nil));
			MEMBER("ctrlname", _name);
		};

		PUBLIC FUNCTION("array","setPipEffect") {
			MEMBER("name", nil) setPiPEffect _this;
		};

		PUBLIC FUNCTION("object", "backCamera"){
			_array = [_this,[0.7,-2,1.5]];
			MEMBER("attachTo", _array);
		};

		PUBLIC FUNCTION("object", "topCamera"){
			_array = [_this,[0,0,30]];
			MEMBER("attachTo", _array);
		};

		PUBLIC FUNCTION("object", "goProCamera"){
			_array = [_this,[0,1,0], "neck"];
			MEMBER("attachTo", _array);
		};

		PUBLIC FUNCTION("array", "attachTo"){
			private ["_object", "_position", "_poscamera", "_vehicle"];
			
			_object = _this select 0;
			_position = _this select 1;
			
			if(count _this > 2) then {
				_poscamera = _this select 2;
			} else {
				_poscamera = "";
			};
			_vehicle = vehicle _object;

			MEMBER("camera", nil) attachto [_object,_position, _poscamera];
			MEMBER("camera", nil) camSetTarget _object;
			MEMBER("camera", nil) camCommit 0;
			MEMBER("attach", true);
			
			while { MEMBER("attach", nil) } do {
				if(_vehicle != vehicle _object) then {
					_vehicle = vehicle _object;
					MEMBER("camera", nil) attachto [_vehicle,_position, _poscamera];
					MEMBER("camera", nil) camSetTarget _vehicle;
					MEMBER("camera", nil) camCommit 0;
				};
				sleep 1;	
			};
		};

		PUBLIC FUNCTION("array", "detach"){
			MEMBER("attach", false);
		};

		PUBLIC FUNCTION("object", "uavCamera"){
			private ["_uav", "_position", "_wp"];
			_position = [position _this select 0, position _this select 1, 100];
			_uav = createVehicle ["B_UAV_01_F", _position, [], 0, "FLY"]; 
			createVehicleCrew _uav; 
			_uav flyInHeight 50;
			MEMBER("camera", nil) attachTo [_uav, [0,1,0]];

			while { alive _uav} do {
				_position = [position _this select 0, position _this select 1, 100];
				_wp = (group _uav) addWaypoint [_position, 0];
				_wp setWaypointType "LOITER"; 
				_wp setWaypointLoiterType "CIRCLE_L"; 
				_wp setWaypointLoiterRadius 100;
				sleep 30;
				deletewaypoint _wp;
			};
			sleep 30;
			deletevehicle _uav;
		};

		PUBLIC FUNCTION("array","r2w") {
			uiNamespace setvariable [MEMBER("ctrlname", nil), findDisplay 46 ctrlCreate ["RscPicture", -1]]; 
			(uiNamespace getvariable MEMBER("ctrlname", nil)) ctrlSetPosition _this; 
			(uiNamespace getvariable MEMBER("ctrlname", nil)) ctrlCommit 0; 
			(uiNamespace getvariable MEMBER("ctrlname", nil)) ctrlSetText "#(argb,512,512,9)r2t("+ MEMBER("name", nil) + ",1.0)"; 
		};

		PUBLIC FUNCTION("object","r2o") {
			private ["_object"];
			_object = _this;
			_object setObjectTexture [0, "#(argb,512,512,9)r2t("+ MEMBER("name", nil) + ",1.0)"];
		};		

		PUBLIC FUNCTION("","deconstructor") { 
			camDestroy MEMBER("camera", nil);
			ctrlDelete (uiNamespace getvariable MEMBER("ctrlname", nil));
			DELETE_VARIABLE("attach");
			DELETE_VARIABLE("camera");
			DELETE_VARIABLE("ctrlname");
			DELETE_VARIABLE("instanceid");
			DELETE_VARIABLE("name");
		};
	ENDCLASS;