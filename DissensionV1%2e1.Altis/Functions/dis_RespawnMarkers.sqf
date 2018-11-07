//This will constantly set markers where they need to be!

dis_MarkerRefresh = true;
while {dis_MarkerRefresh} do
{
	"respawn_west" setMarkerPos (getPosASL Dis_WestCommander);
	"respawn_east" setMarkerPos (getPosASL Dis_EastCommander);
	
	sleep 15;
};