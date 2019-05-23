//Create the tasks for the towns so the players know how many resources the towns provide
CompleteTaskArray = [];


	

	//	CompleteTaskResourceArray pushback [_Pole,[_CashFlowRandom,_PowerFlowRandom,_OilFlowRandom,_MaterialsFlowRandom],_Loc,_Pos];	
{
	_Pole = _x select 0;
	_Loc = _x select 2;
	_Pos = _x select 3;
	_CashFlowRandom = _x select 1 select 0;
	_PowerFlowRandom = _x select 1 select 1;
	_OilFlowRandom = _x select 1 select 2;
	_MaterialsFlowRandom = _x select 1 select 3;
	

	
	_currentTask = player createSimpleTask [format["%1",_Loc]];
	_currentTask setSimpleTaskDestination _Pos;
	_currentTask setSimpleTaskDescription [format["Cash: %1<br/>Power: %2<br/>Oil: %3<br/>Materials: %4",_CashFlowRandom,_PowerFlowRandom,_OilFlowRandom,_MaterialsFlowRandom],format["%1",_Loc],"Description"];

	CompleteTaskArray pushback _currentTask;
} foreach CompleteTaskResourceArray;