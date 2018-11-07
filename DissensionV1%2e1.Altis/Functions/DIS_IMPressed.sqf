//Additional quality of life functions. Pressing up and down on keyboard will move the interaction menu.
//Example: [Display #46,15,false,false,true];
// moduleName_keyDownEHId = findDisplay 46 displayAddEventHandler ["KeyDown",_this call DGN_IMPressed];

_Control = _this select 0; 
_Code = _this select 1;
_Shift = _this select 2;
_Ctrl = _this select 3;
_Alt = _this select 4;

////Key Codes
//Up Arrow : 200
//Down Arrow: 208
//Right Arrow: 205
//Left Arrow: 203
//W : 17
//S : 31
//A : 30
//D : 32
//Enter: 28
//E: 18
//
////

private _index = "";
switch (_Code) do {
    case 17: 
		{
			//W
			_index = tvCurSel ((findDisplay 27000) displayCtrl (27100));
			private _NewSelection1 = (_index select 0) - 1; 			
			private _NewSelection2 = -1;
			private _NewSelection3 = -1;
			private _NewSelAct2 = false;
			private _NewSelAct3 = false;
			
			if (_NewSelection1 < -1) then {_NewSelection1 = 0;};
			
			if !(isNil {_index select 1}) then 
			{
				_NewSelection2 = (_index select 1);				
				_NewSelection2 = _NewSelection2 - 1;
				_NewSelAct2 = true;
				
			
			if !(isNil {_index select 2}) then 
			{
				_NewSelection3 = (_index select 2);
				_NewSelection3 = _NewSelection3 - 1;
				_NewSelAct3 = true;
				
			};
			};

			if (_NewSelAct2 && _NewSelection3 < 0) then {_index set [1,_NewSelection2];};
			if (_NewSelAct3) then {_index set [2,_NewSelection3];};
			if (_NewSelection2 isEqualTo -1 && _NewSelection3 isEqualto -1) then {_index set [0,_NewSelection1];};


			if (_NewSelection2 isEqualTo -1 && _NewSelection3 isEqualTo -1) then {_index deleteAt 1;};		
			if (_NewSelection3 isEqualTo -1) then {_index deleteAt 2;};			
			((findDisplay 27000) displayCtrl (27100)) tvSetCurSel _index;
		};
    case 31: 
		{
			//S
			_index = tvCurSel ((findDisplay 27000) displayCtrl (27100));
			private _NewSelection = (_index select 0) + 1; 
			if (_NewSelection < 0) then {_NewSelection = 0;};
			_index set [0,_NewSelection];
			((findDisplay 27000) displayCtrl (27100)) tvSetCurSel _index;
		};
    case 32: 
		{
			//D
			_index = tvCurSel ((findDisplay 27000) displayCtrl (27100));
			((findDisplay 27000) displayCtrl (27100)) tvExpand _index;
			//((findDisplay 27000) displayCtrl (27100)) tvSetCurSel [_index,];
			
			
		};			
    case 1: 
		{
			//ESC
			closeDialog 2;
		};
		
};