//DIS_fnc_CreateRope
private _Obj = _this select 3 select 0;

if (isNil "DIS_RopeArray") then
{
	DIS_RopeArray = [];
};

_RopeAttachAction = player addAction ["Attach To...", 
{
	
	private _Obj = (_this select 3 select 0);
	private _AtObj = cursorObject;
	
	private _BoundingArray = boundingBoxReal _Obj;
	private _p1 = _BoundingArray select 0;
	private _p2 = _BoundingArray select 1;
	private _Corners = 
	[
		[_p2 select 0,_p2 select 1,_p2 select 2],
		[_p1 select 0,_p1 select 1,_p2 select 2],
		[_p2 select 0,_p1 select 1,_p2 select 2],
		[_p1 select 0,_p2 select 1,_p2 select 2]
	];
	
	{
		private _Rope = ropeCreate [_Obj, [0,0,-0.75], _AtObj, _x, 15];
		DIS_RopeArray pushback _Rope;
	} foreach _Corners;	
		
	player removeAction (_this select 2);
	
},[_Obj],0,false,false,"","true",8,false,""];


//RawrRope = ropeCreate [PHeli, [0,0,0], Box1, [0,0,0], 30]	