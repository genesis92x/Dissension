
class CfgAbilities
{
	class MoneySend
	{
		displayName = "Send Money";
		cost = 0;
		description = "Select a player from the list and enter the amount to send";
		confirmCode = "0 = _this spawn dis_fnc_TabMoneyConfirm;";
		LevelRequire = 0;
	};
	class RequestPickup
	{
		displayName = "Request Pickup";
		cost = 250;
		description = "Trust the AI with your life and request an AI controlled helicopter to drop-off your squad at any location selected on the map. We are not liable for any unexpected collisions or explosions.";
		confirmCode = "0 = _this spawn dis_fnc_RequestPickup;";
		LevelRequire = 0;		
	};	
	class AmmoD
	{
		displayName = "Personal Ammo Drop";
		cost = 150;
		description = "Request ammo for your primary weapon. The ammo dropped will only be for your primary weapon. Dropped from parachute. A marker is placed on the map when the dropped touches down. Be warned, everyone within a 2km radius will see this marker.";
		confirmCode = "0 = _this spawn dis_fnc_AmmoDrop;";
		LevelRequire = 5;
	};
	class ATVD
	{
		displayName = "Request ATV";
		cost = 550;
		description = "Request an ATV to be air-dropped on your location. Be warned, everyone within a 2km radius will see this marker.";
		confirmCode = "0 = _this spawn dis_fnc_ATVD;";
		LevelRequire = 10;		
	};	
	class HCAS
	{
		displayName = "Request Light CAS Support";
		cost = 600;
		description = "Request a helicraft for CAS. It will also mark identified enemies on the map for a short time. It is also generally bad ass.";
		confirmCode = "0 = _this spawn dis_fnc_HCAS;";
		LevelRequire = 15;		
	};		
	class SquadAD
	{
		displayName = "Squad Ammo Drop";
		cost = 500;
		description = "Request ammo for every primary weapon in your squad. The ammo dropped will only be for your squad's primary weapons. Dropped from parachute. A marker is placed on the map when the dropped touches down. Be warned, everyone within a 2km radius will see this marker.";
		confirmCode = "0 = _this spawn dis_fnc_SquadAD;";
		LevelRequire = 20;		
	};
	class HHCAS
	{
		displayName = "Request Heavy CAS Support";
		cost = 800;
		description = "Request a heavy helicraft for CAS. It will also mark identified enemies on the map for a short time. It is also generally bad ass.";
		confirmCode = "0 = _this spawn dis_fnc_HHCAS;";
		LevelRequire = 25;		
	};			
		class LeafletD
	{
		displayName = "Leaflet Drop";
		cost = 400;
		description = "This works only for resistance forces. Drops leaflets that encourage families to evacuate the area - drastically dropping morale of enemy resistance fighters. Dropping leaflets near enemy resistance squads for a chance to route enemy forces.";
		confirmCode = "0 = _this spawn dis_fnc_LeafletD;";
		LevelRequire = 30;
	};
	class FARP
	{
		displayName = "F.A.R.P.";
		cost = 1000;
		description = "A container is dropped near your location that has the ability to rearm, refuel, and repair. The container has enough supplies for 10 uses before it is depleted.";
		confirmCode = "0 = _this spawn dis_fnc_FARP;";
		LevelRequire = 40;
	};	
	class Halo
	{
		displayName = "H.A.L.O.";
		cost = 400;
		description = "Be HALO dropped over 1000M on any target location. You will need to use the addaction to deploy your parachute. +150 per AI within 150 meters.";
		confirmCode = "0 = _this spawn dis_fnc_HALO;";
		LevelRequire = 50;
	};
	class DIGIN
	{
		displayName = "Dig In";
		cost = 250;
		description = "Provides you with 2 sangbags to place. This ability also lets you place structures anywhere on the map for a short time.";
		confirmCode = "0 = _this spawn dis_fnc_DIGIN;";
		LevelRequire = 60;
	};
	class RequestGunShip
	{
		displayName = "Gun Ship";
		cost = 3000;
		description = "An AI piloted gunship that will fly around a selected target, allowing you to gun the aircraft. Aircraft will come to your location to pick you up. Be sure to request a pickup in a safe and clear location.";
		confirmCode = "0 = _this spawn DIS_fnc_RequestGunship;";
		LevelRequire = 65;
	};	
	class transportD
	{
		displayName = "Request Vehicle";
		cost = 900;
		description = "Purchase a four seater vehicle that will be air-dropped to your location. be warned, everyone within a 2km radius will see this marker.";
		confirmCode = "0 = _this spawn dis_fnc_transportD;";
		LevelRequire = 70;
	};
	class CommAssist
	{
		displayName = "Commander AI Assist";
		cost = 500;
		description = "Request the AI commander to send a group of units to your position. This is not guaranteed, and you will NOT get your money back if the commander decides against it.";
		confirmCode = "0 = _this spawn dis_fnc_CommAssist;";
		LevelRequire = 80;
	};
	class AirAssist
	{
		displayName = "Aircraft Support";
		cost = 600;
		description = "Request an assault aircraft to support your position for 15 minutes. Or until it dies.";
		confirmCode = "0 = _this spawn DIS_fnc_AirAssist;";
		LevelRequire = 90;
	};
	class MissileBarrage
	{
		displayName = "Missile Barrage";
		cost = 1000;
		description = "Request a barrage of 30 advanced artillery rounds, striking in a 150 meter radius. You will not be able to unselect the map until you pick a location to fire. You must be within 2000 meters of your targeted position.";
		confirmCode = "0 = _this spawn DIS_fnc_MissileBarrage;";
		LevelRequire = 100;
	};
};



