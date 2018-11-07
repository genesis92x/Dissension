DIS_THeights = 
{
	//_Test = [Object Center,Area,Precision (Recommended no lower than 5)] call DIS_THeights;
	//player setposASL (_Test select 0 select 1); -> Highest point
	//player setposASL (_Test ((count _Test) - 1) select 1); -> Lowest Point
	params ["_Obj","_range","_Prec"];
	if (_Prec < 1) then {_Prec = 1};
	private _Rng = (_range/2);
	private _ArrayOne = [];
	private _CenterPos = (getpos _Obj);
	private _StartingPos = [(_CenterPos select 0) - _Rng,(_CenterPos select 1) - _Rng,(_CenterPos select 2)];
	private _EndingPos = [(_CenterPos select 0) + _Rng,(_CenterPos select 1) + _Rng,(_CenterPos select 2)];
	private _StarterArray = [];
	private _Counter = 0;
	private _limit = (round (_range/_Prec));
	while {_Counter < _limit} do
	{
		_StarterArray pushback _StartingPos;
		_StartingPos = [(_StartingPos select 0),(_StartingPos select 1)+_Prec,(_StartingPos select 2)];
		_ArrayOne pushback _StartingPos;	
		_Counter = _Counter + 1;
	};
	
	{
		_MarkerPos = _x;
		_StartingPos = [(_MarkerPos select 0)+_Prec,(_MarkerPos select 1),(_MarkerPos select 2)];
		_Counter = 0;
		while {_Counter < _limit} do
		{
			_ArrayOne pushback _StartingPos;
			_StartingPos = [(_StartingPos select 0) + _Prec,(_StartingPos select 1),(_StartingPos select 2)];	
			_Counter = _Counter + 1;		
		};
	} foreach _StarterArray;
	
	private _FinalArray = [];
	{
		private _height = [(_x select 0),(_x select 1),(getTerrainHeightASL _x)];
		private _FinalPush = [(_height select 2),_height];
		_FinalArray pushback _FinalPush;
	} foreach _ArrayOne;
	_FinalArray sort false;
	
	_FinalArray
};

