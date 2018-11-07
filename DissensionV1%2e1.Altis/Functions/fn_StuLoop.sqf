//This function will forever loop the stuck function

waitUntil 
{
	sleep 30;
	[] call DIS_fnc_StuCheck;
	false
};

/*
while {true} do 
{
	sleep 30;
	[] call DIS_fnc_StuCheck;
};