//This function will compare two arrays and find the objects that are cloest to one another.
//This function will aim to be as optimized as possible but should not be over-utilized as it will do MANY calculations in a short period of time.
//For the return variable _this select 0 will be the distance, _this select 1 will be the object from array1, and _this select 2 will be the object from array 2.


//[_List1,_List2,false] call dis_ADistC;
private _Array1 = _this select 0;
private _Array2 = _this select 1;
private _Order = _this select 2;
private _pos = [0,0,0];
private _pos2 = [0,0,0];
private _Array1L = [];
{

	//Pull and remember the first object from array1
	private _O = _x;
	//Find out if the object in the array is an OBJECT, STRING, or ARRAY. Then grab its position
	if (_O isEqualType objNull) then {_pos = getPos _O;} else { if (_O isEqualType grpNull) then {_pos = getPos (leader _O);} else {if (_O isEqualType "") then {_pos = getMarkerPos _O} else {_pos = _O}; };};
	
	
	//Now we need to check EVERY OTHER OBJECT in the 2nd array.
	{
		//Find out if the object in the array is an OBJECT, STRING, or ARRAY. Then grab its position
		if (_x isEqualType objNull) then {_pos2 = getPos _x;} else { if (_x isEqualType grpNull) then {_pos2 = getPos (leader _x);} else {if (_x isEqualType "") then {_pos2 = getMarkerPos _x} else {_pos2 = _x}; };};
		
		//Find the distance between the 2 points
		private _ND = _pos distance2D _pos2;
		
		//Put them into an array
		_Array1L pushback [_ND,_O,_x];
	} forEach _Array2;
} forEach _Array1;

//Since the distance is the first in the array, it will sort based on that. True = shortest on top. False = furthest on top.
_Array1L sort _order;

//Finally lets spit out the final array. With this, we will return the whole array. This may be useful in the future for finding "close enough" targets or groups.
_Array1L