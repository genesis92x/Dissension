//This is simply a function that loops messages every so often to the player...to help new players and not annoy older players.

sleep 30;
private _Messages = 
[
	"Press ESC to access your Commander Interface. This is where you can interact with most things for Dissension. It takes roughly 15 seconds to fully initialize upon spawning.",
	"Tap 'J' to show what towns are currently engaged by your side on the map. The diagonal markers are visible for 30 seconds.",
	"More abilities are unlocked through levelling. These can be found under 'Player Request' in the 'Commander Interface'.",
	"Join groups by pressing the 'U' button.",
	"Call in bombs onto enemy structures by getting close enough and using the addaction. Be careful, even AI can call for demolition of your structures. You have 300 seconds to disable the explosive.",
	"The number of AI you can recruit is dependent on your rank. Every 10 ranks is an additional 1 AI.",
	"Tap L CTRL + R to repack your magazines."
];
private _MessageCnt = 0;
waitUntil
{
	private _NewMessage = _Messages select _MessageCnt;
	systemChat format ["DISSENSION TIPS: %1",_NewMessage];
	_MessageCnt = _MessageCnt + 1;
	if (_MessageCnt > ((count _Messages) - 1)) then
	{
		_MessageCnt = 0;
	};

	sleep 600;
	false
};