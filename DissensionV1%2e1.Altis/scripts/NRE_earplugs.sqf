/*
Script name:	NRE_earplugs.sqf
Created on:		03.06.2015 (06/03/2015)
Author:			NemesisRE
Author website:	http://nrecom.net

Description:	Adds action to insert/remove Earplugs (toggles).
				Inspired by A3Wasteland132DSOv14.Altis kopfh script

License:		Copyright (C) 2015 Steven "NemesisRE" Köberich

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


Manual:			Call from init.sqf via:
					execVM "scripts\NRE_earplugs.sqf";

				Add following to your stringtable.xml:
					<?xml version="1.0" encoding="UTF-8"?>
					<Project name="NRE Earplugs">
						<Package name="NREEarplugs">
							<Key ID="STR_NREEP_IN_HINT">
								<Original>You have insert the earplugs!</Original>
								<English>You have insert the earplugs!</English>
								<Russian>Беруши вставлены!</Russian>
								<German>Du hast die Ohrstoepsel eingesteckt!</German>
								<Spanish>¡Te has puesto los tapones!</Spanish>
							</Key>
							<Key ID="STR_NREEP_OUT_HINT">
								<Original>You have removed the earplugs!</Original>
								<English>You have removed the earplugs!</English>
								<Russian>Беруши вытащены!</Russian>
								<German>Du hast die Ohrstoepsel rausgenommen!</German>
								<Spanish>¡Te has quitado los tapones!</Spanish>
							</Key>
							<Key ID="STR_NREEP_IN_ACTION">
								<Original>Insert earplugs</Original>
								<English>Insert earplugs</English>
								<Russian>Вставить беруши</Russian>
								<German>Ohrstoepsel einstecken</German>
								<Spanish>Ponerte los tapones</Spanish>
							</Key>
							<Key ID="STR_NREEP_OUT_ACTION">
								<Original>Remove earplugs</Original>
								<English>Remove earplugs</English>
								<Russian>Вытащить беруши!</Russian>
								<German>Ohrstoepsel rausnehmen</German>
								<Spanish>Quitarte los tapones</Spanish>
							</Key>
						</Package>
					</Project>
*/

waitUntil {!isNull player}; //to prevent MP / JIP issues

NreEarplugsPath = "scripts\";

if (isNil "NreEarplugsActive") then {
	NreEarplugsActive = 0;
	1 fadeSound 1;
	_id = player addAction [("<t color=""#00FF00"">" + (localize "STR_NREEP_IN_ACTION") +"</t>"),NreEarplugsPath+"NRE_earplugs.sqf","",5,false,true,"",""];
	player setVariable ["NreEarplugsAction", _id];
	// Handle respawn
	player addEventHandler ["Respawn", {
		NreEarplugsActive = 0;
		1 fadeSound 1;
		_id = (_this select 1) getVariable "NreEarplugsAction";
		(_this select 1) removeAction _id;
		_id = (_this select 0) addAction [("<t color=""#00FF00"">" + (localize "STR_NREEP_IN_ACTION") +"</t>"),NreEarplugsPath+"NRE_earplugs.sqf","",5,false,true,"",""];
		(_this select 0) setVariable ["NreEarplugsAction", _id];
	}];
	breakto "firstInitFinished";
};

if ( NreEarplugsActive == 1 ) then {
	NreEarplugsActive = 0;
	1 fadeSound 1;
	hint format	[ localize "STR_NREEP_OUT_HINT" ];
	_id = player getVariable "NreEarplugsAction";
	player removeAction _id;
	_id = player addAction [("<t color=""#00FF00"">" + (localize "STR_NREEP_IN_ACTION") +"</t>"),NreEarplugsPath+"NRE_earplugs.sqf","",5,false,true,"",""];
	player setVariable ["NreEarplugsAction", _id];
} else {
	NreEarplugsActive = 1;
	1 fadeSound 0.4;
	hint format	[ localize "STR_NREEP_IN_HINT" ];
	_id = player getVariable "NreEarplugsAction";
	player removeAction _id;
	_id = player addAction [("<t color=""#FF0000"">" + (localize "STR_NREEP_OUT_ACTION") +"</t>"),NreEarplugsPath+"NRE_earplugs.sqf","",5,false,true,"",""];
	player setVariable ["NreEarplugsAction", _id];
};

scopename "firstInitFinished";
