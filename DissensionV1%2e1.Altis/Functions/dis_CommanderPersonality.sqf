private ["_YearArray", "_LeapYear", "_RandomDay", "_Year", "_MonthArray", "_RandomYear", "_RandomMonth", "_RandomFirstName", "_RandomLastName", "_ArmyFocus", "_MoodTraitArray", "_FirstName", "_LastName", "_FinalFocus", "_MoodTrait", "_FinalName", "_BirthDate", "_NewCommanderAdd", "_SetupArray"];

if ((side _this) isEqualTo West) then
{
	_YearArray = [];
	_LeapYear = FALSE;
	_RandomDay = [];
	
	for "_Year" from 1950 to 1995 do {_YearArray pushback _Year;};
	_MonthArray = ["January","February","March","April","May","June","July","August","September","October","November","December"];
	
	_RandomYear = _YearArray call BIS_fnc_SelectRandom;
	_RandomMonth = _MonthArray call BIS_fnc_SelectRandom;
	
	
	if ((_RandomYear isEqualTo 1952) || (_RandomYear isEqualTo 1956) || (_RandomYear isEqualTo 1960) || (_RandomYear isEqualTo 1964) || (_RandomYear isEqualTo 1968) || (_RandomYear isEqualTo 1972) || (_RandomYear isEqualTo 1976) ||
		(_RandomYear isEqualTo 1980) || (_RandomYear isEqualTo 1984) || (_RandomYear isEqualTo 1988) || (_RandomYear isEqualTo 1992)) then {_LeapYear = TRUE;};
	
	if ((_RandomMonth isEqualTo "January") || (_RandomMonth isEqualTo "March") || (_RandomMonth isEqualTo "May") || (_RandomMonth isEqualTo "July") || 
		(_RandomMonth isEqualTo "August") || (_RandomMonth isEqualTo "October") || (_RandomMonth isEqualTo "December")) then {_RandomDay = floor (random 31);};
		
	if ((_RandomMonth isEqualTo "February") && (_LeapYear)) then {_RandomDay = floor (random 29);};
	if ((_RandomMonth isEqualTo "February") && !(_LeapYear)) then {_RandomDay = floor (random 28);};
	
	if ((_RandomMonth isEqualTo "April") || (_RandomMonth isEqualTo "June") || (_RandomMonth isEqualTo "September") || (_RandomMonth isEqualTo "November")) then 
																										{_RandomDay = floor (random 30);};
																										
	if (_RandomDay isEqualTo 0) then {_RandomDay = 1};
	/*	
	_RandomFirstName = ["James","John","Robert","Michael","William","David","Richard","Charles","Joseph","Thomas","Christopher","Daniel","Paul","Mark","Donald","George","Kenneth","Steven","Edward","Brian","Ronald","Anthony","Kevin","Jason","Matthew","Gary","Timothy"
										,"Jose","Larry","Jeffrey","Frank","Scott","Eric","Stephen","Andrew","Raymond","Gregory","Joshua","Jerry","Dennis","Walter","Patrick","Peter","Harold","Douglas","Henry","Carl","Arthur","Ryan","Roger","Joe","Juan","Jack","Albert","Jonathan"
										,"Justin","Terry","Garald","Keith","Samuel","Willie","Ralph","Lawrence","Nicholas","Roy","Benjamin","Bruce","Brandon","Adam","Harry","Fred","Wayne","Billy","Steve","Louis","Jeremy","Aaron","Randy","Howard","Eugene","Carlos","Russell"
										,"Bobby","Victor","Martin","Ernest","Phillip","Todd","Jesse","Craig","Alan","Shawn","Clarence","Sean","Philip","Chris","Johnny","Earl","Jimmy","Antonio","Danny","Bryan","Tony","Luis","Mike","Stanley","Leonard","Nathan","Dale","Manuel","Rodney"
										,"Curtis","Norman","Allen","Marvin","Vincent","Glenn","Jeffery","Travis","Jeff","Chad","Jacob","Lee","Melvin","Alfred","Kyle","Francis","Bradley","Jesus","Herbert","Fredrick","Ray","Joel","Edwin","Don","Eddie","Ricky","Troy","Randall","Barry"
										,"Alexander","Bernard","Mario","Leroy","Francisco","Marcus","Micheal","Theodore","Clifford","Miguel","Oscar","Jay","Jim","Tom","Calvin","Alex","Jon","Ronnie","Bill","Lloyd","Tommy","Leon","Derek","Warren","Darrell","Jerome","Floyd","Leo","Alvin"
										,"Tim","Wesley","Gordon","Dean","Greg","Jorge","Dustin","Pedro","Derrick","Dan","Lewis","Zachary","Corey","Herman","Maurice","Vernon","Roberto","Clyde","Glen","Hector","Shane","Ricardo","Sam","Rick","Lester","Brent","Ramon","Charlie","Tyler","Gilbert"
										,"Gene","Marc","Reginald","Ruben","Brett","Angel","Nathaniel","Rafael","Leslie","Edgar","Milton","Raul","Ben","Chester","Cecil","Duane","Franklin","Andre","Elmer","Brad","Gabriel","Ron","Mitchell","Roland","Arnold","Harvey","Jared","Adrian","Karl","Cory"
										,"Claude","Erik","Darryl","Jamie","Neil","Jessie","Christian","Jaiver","Fernado","Clinton","Ted","Mathew","Tyrone","Darren","Loonie","Lance","Cody","Julio","Kelly","Kurt","Allan","Nelson","Guy","Clayton","Hugh","Max","Dwayne","Dwight","Armando","Felix"
										,"Jimmie","Everett","Jordan","Ian","Wallace","Ken","Bob","Jaime","Casey","Alfredo","Alberto","Dave","Ivan","Johnnie","Sidney","Byron","Julian","Isaac","Morris","Clifton","Willard","Daryl","Ross","Virgil","Andy","Marshall","Salvador","Perry","Kirk"
										,"Sergio","Marion","Tracy","Seth","Kent","Terrance","Rene","Eduardo","Terrence","Enrique","Freddie","Wade"];
	
	_RandomLastName = ["Smith","Brown","Johnson","Jones","Williams","Davis","Miller","Wilson","Taylor","Clark","White","Moore","Thompson","Allen","Martin","Hall","Adams","Thomas","Wright","Baker","Walker","Anderson","Lewis","Harris","Hill","King","Jackson"
										,"Lee","Green","Wood","Parker","Campbell","Young","Robinson","Stewart","Scott","Rogers","Roberts","Cook","Phillips","Turner","Carter","Ward","Foster","Morgan","Howard","Cox","JR","Bailey","Richardson","Reed","Russell","Edwards","Morris","Wells","Palmer"
										,"Ann","Mitchell","Evans","Gray","Wheeler","Warren","Cooper","Bell","Collins","Carpenter","Stone","Cole","Ellis","Bennet","Harrison","Fisher","Henry","Spencer","Watson","Porter","Nelson","James","Marshall","Butler","Hamilton","Tucker","Stevens"
										,"Webb","May","West","Reynolds","Hunt","Barnes","Perkins","Brooks","Long","Price","Fuller","Powell","Perry","Alexander","Rice","Hart","Ross","Arnold","Shaw","Ford","Pierce","Lawrence","Henderson","Freeman","Mason","Andrews","Geaham","Chapman"
										,"Hughes","Mills","Gardner","Jordan","Ball","Nichols","Gibson","Greene","Wallace","Baldwin","Day","Deaver","Sherman","Murphy","Lane","Knight","Holmes","Bishop","Kelly","French","Myers","Mentioned","Patterson","Elizabeth","Case","Curtis","Simmons"
										,"Jenkins","Berry","Hopkins","Clarke","Fox","Gordon","Hunter","Roberson","Payne","Johnston","Barker","Grant","Murrary","Church","Webster","Richards","Sanders","Page","Crawford","Duncan","Warner","Hale","Kennedy","Rose","Carr","Black","Bates","Chase"
										,"Pratt","Austin","Hawkins","Stephens","Ferguson","Parsons","Simpson","Armstrong","Fowler","Potter","Hayes","Griffin","Bryant","Weaver","Boyd","Townsend","Coleman","Holland","Stanley","Hicks","Gilbert","Bradely","Chandler","Barber","Bartlett"
										,"Woods","Sutton","Montgomery","Dean","Morse","Brewer","Newton","Sullivan","Jane","Graves","Phelps","Hubbard","Fletcher","Drake","Douglas","Dunn","Burton","Sharp","McDonald","Elliott","Eaton","Harvey","Peterson","Franklin","Morrison","George"
										,"Lincoln","Snyder","Hudson","Snow","Cobb","England","Gregory","Wilcox","Bowen","Howell","Cunningham","Bowman","Norton","Lord","Willis","Holt","Little","Williamson","Davidson","Harrington","Marsh","County","Daigle","Leonard","Harper","Dixon","Matthews"
										,"Ray","Mary","Whitney","Burns","Boone","Peck","Bradford","Owen","Garrett","Barrett","Hammond","Oliver","John","Mann","Stuart","Peters","Welch","Reeves","Hull","Caldwell","Rhodes","Howe","Owens","Gates","Bush","Pearson","Newman","Frost","Wagner"
										,"Bruce","Kimball","Abbott","Plantagenet","Robbins","Briggs","Wade","Mullins","Woodward","Stafford","Barton","Todd","Goodwin","Dyer","Horton","Watkins","Cummings","Sparks","Bacon","Gould","Sawyer","Neal","Kelley","Reid","Cooke","Osborne","Hancock"];
		*/

	_RandomName = name (leader DIS_WestCommander);
	_ArmyFocus = ["Infantry","Heavy Armor","Light Armor","Helicraft","Aircraft"];
							
	_MoodTraitArray = [
										["Aggressive","This commander believes in taking territory quickly and with many troops! Resting or setting up heavy defensive lines is simply a waste of time."],
										["Defensive","This commander believes in slowly taking territory while heavily defending it. This commander will more likely have patrols around fortified positions."],
										["Private Military Contractor","This commander prefers paying others to do work for him. He will focus heavily on getting cold hard cash to pay mercenaries to do his work. This also means paying rebels to make capturing towns a little more...difficult for the opposing team."],
										["Support Enthusiast","This commander loves aggressively pushing with forces while simultaneously saturating the area with devastating artillery. This commander also loves deploying mortar support, sniper support, and other forms of vehicle support to keep his forces in combat."],
										["Guerilla","This commander likes to play as dirty as possible while remaining out of the thick of things. This means laying traps, setting up frequent ambushes, stealing enemy tech, and even creating fake caches laced with explosives."]
										];
							
	//_FirstName = _RandomFirstName call BIS_fnc_SelectRandom;
	//_LastName = _RandomLastName call BIS_fnc_SelectRandom;
	_FinalFocus = _ArmyFocus call BIS_fnc_SelectRandom;
	_MoodTrait = _MoodTraitArray call BIS_fnc_SelectRandom;
	
	//_FinalName = format ["%1 %2",_FirstName,_LastName];
	_BirthDate = format ["%1 %2, %3",_RandomMonth,_RandomDay,_RandomYear];
	_NewCommanderAdd = [_RandomName,_BirthDate,_FinalFocus,_MoodTrait];

	
	
	//Unit random loot
	//Lets set the units beginning levels of hunger, thirst, and other equipment.
	//						Owner-Population-Status-Power-Food-Water-Stabilization-Other resources array-
	// Power,Food,Water -> [Consumption,Production,Available];
	//_SetupArray = [player,[],"Camp Site",[0,0,0],[0,0,0],[0,0,0],100,[],0,0,[],[]];
	W_CommanderInfo = _NewCommanderAdd;
	publicVariable "W_CommanderInfo";
}
else
{
	_YearArray = [];
	_LeapYear = FALSE;
	_RandomDay = [];
	
	for "_Year" from 1950 to 1995 do {_YearArray pushback _Year;};
	_MonthArray = ["January","February","March","April","May","June","July","August","September","October","November","December"];
	
	_RandomYear = _YearArray call BIS_fnc_SelectRandom;
	_RandomMonth = _MonthArray call BIS_fnc_SelectRandom;
	
	
	if ((_RandomYear isEqualTo 1952) || (_RandomYear isEqualTo 1956) || (_RandomYear isEqualTo 1960) || (_RandomYear isEqualTo 1964) || (_RandomYear isEqualTo 1968) || (_RandomYear isEqualTo 1972) || (_RandomYear isEqualTo 1976) ||
		(_RandomYear isEqualTo 1980) || (_RandomYear isEqualTo 1984) || (_RandomYear isEqualTo 1988) || (_RandomYear isEqualTo 1992)) then {_LeapYear = TRUE;};
	
	if ((_RandomMonth isEqualTo "January") || (_RandomMonth isEqualTo "March") || (_RandomMonth isEqualTo "May") || (_RandomMonth isEqualTo "July") || 
		(_RandomMonth isEqualTo "August") || (_RandomMonth isEqualTo "October") || (_RandomMonth isEqualTo "December")) then {_RandomDay = floor (random 31);};
		
	if ((_RandomMonth isEqualTo "February") && (_LeapYear)) then {_RandomDay = floor (random 29);};
	if ((_RandomMonth isEqualTo "February") && !(_LeapYear)) then {_RandomDay = floor (random 28);};
	
	if ((_RandomMonth isEqualTo "April") || (_RandomMonth isEqualTo "June") || (_RandomMonth isEqualTo "September") || (_RandomMonth isEqualTo "November")) then 
																										{_RandomDay = floor (random 30);};
																										
	if (_RandomDay isEqualTo 0) then {_RandomDay = 1};
	/*	
	_RandomFirstName = ["James","John","Robert","Michael","William","David","Richard","Charles","Joseph","Thomas","Christopher","Daniel","Paul","Mark","Donald","George","Kenneth","Steven","Edward","Brian","Ronald","Anthony","Kevin","Jason","Matthew","Gary","Timothy"
										,"Jose","Larry","Jeffrey","Frank","Scott","Eric","Stephen","Andrew","Raymond","Gregory","Joshua","Jerry","Dennis","Walter","Patrick","Peter","Harold","Douglas","Henry","Carl","Arthur","Ryan","Roger","Joe","Juan","Jack","Albert","Jonathan"
										,"Justin","Terry","Garald","Keith","Samuel","Willie","Ralph","Lawrence","Nicholas","Roy","Benjamin","Bruce","Brandon","Adam","Harry","Fred","Wayne","Billy","Steve","Louis","Jeremy","Aaron","Randy","Howard","Eugene","Carlos","Russell"
										,"Bobby","Victor","Martin","Ernest","Phillip","Todd","Jesse","Craig","Alan","Shawn","Clarence","Sean","Philip","Chris","Johnny","Earl","Jimmy","Antonio","Danny","Bryan","Tony","Luis","Mike","Stanley","Leonard","Nathan","Dale","Manuel","Rodney"
										,"Curtis","Norman","Allen","Marvin","Vincent","Glenn","Jeffery","Travis","Jeff","Chad","Jacob","Lee","Melvin","Alfred","Kyle","Francis","Bradley","Jesus","Herbert","Fredrick","Ray","Joel","Edwin","Don","Eddie","Ricky","Troy","Randall","Barry"
										,"Alexander","Bernard","Mario","Leroy","Francisco","Marcus","Micheal","Theodore","Clifford","Miguel","Oscar","Jay","Jim","Tom","Calvin","Alex","Jon","Ronnie","Bill","Lloyd","Tommy","Leon","Derek","Warren","Darrell","Jerome","Floyd","Leo","Alvin"
										,"Tim","Wesley","Gordon","Dean","Greg","Jorge","Dustin","Pedro","Derrick","Dan","Lewis","Zachary","Corey","Herman","Maurice","Vernon","Roberto","Clyde","Glen","Hector","Shane","Ricardo","Sam","Rick","Lester","Brent","Ramon","Charlie","Tyler","Gilbert"
										,"Gene","Marc","Reginald","Ruben","Brett","Angel","Nathaniel","Rafael","Leslie","Edgar","Milton","Raul","Ben","Chester","Cecil","Duane","Franklin","Andre","Elmer","Brad","Gabriel","Ron","Mitchell","Roland","Arnold","Harvey","Jared","Adrian","Karl","Cory"
										,"Claude","Erik","Darryl","Jamie","Neil","Jessie","Christian","Jaiver","Fernado","Clinton","Ted","Mathew","Tyrone","Darren","Loonie","Lance","Cody","Julio","Kelly","Kurt","Allan","Nelson","Guy","Clayton","Hugh","Max","Dwayne","Dwight","Armando","Felix"
										,"Jimmie","Everett","Jordan","Ian","Wallace","Ken","Bob","Jaime","Casey","Alfredo","Alberto","Dave","Ivan","Johnnie","Sidney","Byron","Julian","Isaac","Morris","Clifton","Willard","Daryl","Ross","Virgil","Andy","Marshall","Salvador","Perry","Kirk"
										,"Sergio","Marion","Tracy","Seth","Kent","Terrance","Rene","Eduardo","Terrence","Enrique","Freddie","Wade"];
	
	_RandomLastName = ["Smith","Brown","Johnson","Jones","Williams","Davis","Miller","Wilson","Taylor","Clark","White","Moore","Thompson","Allen","Martin","Hall","Adams","Thomas","Wright","Baker","Walker","Anderson","Lewis","Harris","Hill","King","Jackson"
										,"Lee","Green","Wood","Parker","Campbell","Young","Robinson","Stewart","Scott","Rogers","Roberts","Cook","Phillips","Turner","Carter","Ward","Foster","Morgan","Howard","Cox","JR","Bailey","Richardson","Reed","Russell","Edwards","Morris","Wells","Palmer"
										,"Ann","Mitchell","Evans","Gray","Wheeler","Warren","Cooper","Bell","Collins","Carpenter","Stone","Cole","Ellis","Bennet","Harrison","Fisher","Henry","Spencer","Watson","Porter","Nelson","James","Marshall","Butler","Hamilton","Tucker","Stevens"
										,"Webb","May","West","Reynolds","Hunt","Barnes","Perkins","Brooks","Long","Price","Fuller","Powell","Perry","Alexander","Rice","Hart","Ross","Arnold","Shaw","Ford","Pierce","Lawrence","Henderson","Freeman","Mason","Andrews","Geaham","Chapman"
										,"Hughes","Mills","Gardner","Jordan","Ball","Nichols","Gibson","Greene","Wallace","Baldwin","Day","Deaver","Sherman","Murphy","Lane","Knight","Holmes","Bishop","Kelly","French","Myers","Mentioned","Patterson","Elizabeth","Case","Curtis","Simmons"
										,"Jenkins","Berry","Hopkins","Clarke","Fox","Gordon","Hunter","Roberson","Payne","Johnston","Barker","Grant","Murrary","Church","Webster","Richards","Sanders","Page","Crawford","Duncan","Warner","Hale","Kennedy","Rose","Carr","Black","Bates","Chase"
										,"Pratt","Austin","Hawkins","Stephens","Ferguson","Parsons","Simpson","Armstrong","Fowler","Potter","Hayes","Griffin","Bryant","Weaver","Boyd","Townsend","Coleman","Holland","Stanley","Hicks","Gilbert","Bradely","Chandler","Barber","Bartlett"
										,"Woods","Sutton","Montgomery","Dean","Morse","Brewer","Newton","Sullivan","Jane","Graves","Phelps","Hubbard","Fletcher","Drake","Douglas","Dunn","Burton","Sharp","McDonald","Elliott","Eaton","Harvey","Peterson","Franklin","Morrison","George"
										,"Lincoln","Snyder","Hudson","Snow","Cobb","England","Gregory","Wilcox","Bowen","Howell","Cunningham","Bowman","Norton","Lord","Willis","Holt","Little","Williamson","Davidson","Harrington","Marsh","County","Daigle","Leonard","Harper","Dixon","Matthews"
										,"Ray","Mary","Whitney","Burns","Boone","Peck","Bradford","Owen","Garrett","Barrett","Hammond","Oliver","John","Mann","Stuart","Peters","Welch","Reeves","Hull","Caldwell","Rhodes","Howe","Owens","Gates","Bush","Pearson","Newman","Frost","Wagner"
										,"Bruce","Kimball","Abbott","Plantagenet","Robbins","Briggs","Wade","Mullins","Woodward","Stafford","Barton","Todd","Goodwin","Dyer","Horton","Watkins","Cummings","Sparks","Bacon","Gould","Sawyer","Neal","Kelley","Reid","Cooke","Osborne","Hancock"];
		*/

	_RandomName = name (leader DIS_EastCommander);
	_ArmyFocus = ["Infantry","Heavy Armor","Light Armor","Helicraft","Aircraft"];
							
	_MoodTraitArray = [
											["Aggressive","This commander believes in taking territory quickly and with many troops! Resting or setting up heavy defensive lines is simply a waste of time."],
											["Defensive","This commander believes in slowly taking territory while heavily defending it. This commander will more likely have patrols around fortified positions."],
											["Private Military Contractor","This commander prefers paying others to do work for him. He will focus heavily on getting cold hard cash to pay mercenaries to do his work. This also means paying rebels to make capturing towns a little more...difficult for the opposing team."],
											["Support Enthusiast","This commander loves aggressively pushing with forces while simultaneously saturating the area with devastating artillery. This commander also loves deploying mortar support, sniper support, and other forms of vehicle support to keep his forces in combat."],
											["Guerilla","This commander likes to play as dirty as possible while remaining out of the thick of things. This means laying traps, setting up frequent ambushes, stealing enemy tech, and even creating fake caches laced with explosives."]
										];
							
	//_FirstName = _RandomFirstName call BIS_fnc_SelectRandom;
	//_LastName = _RandomLastName call BIS_fnc_SelectRandom;
	_FinalFocus = _ArmyFocus call BIS_fnc_SelectRandom;
	_MoodTrait = _MoodTraitArray call BIS_fnc_SelectRandom;
	
	//_FinalName = format ["%1 %2",_FirstName,_LastName];
	_BirthDate = format ["%1 %2, %3",_RandomMonth,_RandomDay,_RandomYear];
	_NewCommanderAdd = [_RandomName,_BirthDate,_FinalFocus,_MoodTrait];

	
	
	//Unit random loot
	//Lets set the units beginning levels of hunger, thirst, and other equipment.
	//						Owner-Population-Status-Power-Food-Water-Stabilization-Other resources array-
	// Power,Food,Water -> [Consumption,Production,Available];
	//_SetupArray = [player,[],"Camp Site",[0,0,0],[0,0,0],[0,0,0],100,[],0,0,[],[]];
	E_CommanderInfo = _NewCommanderAdd;
	publicVariable "E_CommanderInfo";
};