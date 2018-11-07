disableSerialization;
//["Testing",'#FFFFFF'] spawn Dis_MessageFramework;
_Message = _this select 0;
_TextColor = _this select 1;

if (isNil "_TextColor") then {_TextColor ='#FFFFFF'};
if (isNil "_Message") then {_Message = "No message set!"};

systemchat _Message;
playsound "Beep_Target";
10000 cutRsc ["Dis_InfoHud","PLAIN"];
_ui = uiNamespace getVariable "Dis_InfoHud";
(_ui displayCtrl 1100) ctrlSetBackgroundColor [0.65, 0.65, 0.65, 0.25];   
(_ui displayCtrl 1100) ctrlSetStructuredText (parseText format ["<t shadow='1' shadowColor='#000000'><t size='1'><t align='Center'><t color='%2'>%1</t> </t></t></t>",_Message,_TextColor]);
(_ui displayCtrl 1100) ctrlSetPosition [0,-0.20,1,0.1];
(_ui displayCtrl 1100) ctrlCommit 0;
10000 cutFadeOut 10;