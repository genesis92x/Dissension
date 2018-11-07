/* 
* @Author:  DnA
* @Profile: http://steamcommunity.com/id/dna_uk
* @Date:    2014-05-10 15:52:48
* @Last Modified by:   DnA
* @Last Modified time: 2014-05-11 03:17:48
* @Version: 0.1b
*/

if ( isDedicated ) exitWith {};

[] spawn {

	if ( isMultiplayer || { getNumber ( missionConfigFile >> "briefing" ) != 1 } ) then {

		if ( isMultiplayer ) then {

			//--- Exit if mission is already in progress
			if ( getClientState == "BRIEFING READ" ) exitWith {};

			//--- Wait for briefing
			waitUntil { getClientState == "BRIEFING SHOWN" };

		};

		//--- Determine IDD of RscDisplayGetReady
		private "_idd";
		_idd = switch true do { 

			case ( !isMultiplayer ): { 37 };
			case ( isServer ): { 52 };
			case ( !isServer ): { 53 };

		};

		//--- Check if briefing is open
		if ( !isNull findDisplay _idd ) then {

			//--- Programatically activate the "texture" button
			ctrlActivate ( ( findDisplay _idd ) displayCtrl 107 );

		};


	};

	if ( isMultiplayer ) then {

		//--- Wait for game to be in progress
		waitUntil { getClientState == "BRIEFING READ" };

	};

	//--- Wait for game map to become available
	waitUntil { !isNull findDisplay 12 }; 

	//--- Programatically activate the "texture" button
	ctrlActivate ( ( findDisplay 12 ) displayCtrl 107 );

};

true