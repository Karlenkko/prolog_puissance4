:- include(ai_defense).
%
containNumber([], Element, 0) :- !.
containNumber([H|List], Element, N) :-  H \== Element, containNumber(List, Element, N), !.
containNumber([H|List], Element, N) :-  H == Element, containNumber(List, Element, NewN), N is NewN+1.

%
allIndex([], List2, Element, []) :- !.
allIndex([H|List], List2, Element, RL) :- H \== Element,
											  allIndex(List, List2, Element, RL),!.
allIndex([H|List], List2, Element, [R|RL]) :- H == Element, nth0(R1, [H|List], Element), length(List2, L2), length([H|List], L1),
											  R is R1+L2-L1,
											  allIndex(List, List2, Element, RL),!.
%
transformIndexList(List, [], []).
transformIndexList(List, [H|AvailableIndex], [R|Results]) :-  nth0(H, List, R), transformIndexList(List, AvailableIndex, Results).											  

findMaxFromIndex(MyList, IndexList, MaxIndex) :- transformIndexList(MyList, IndexList, Results), max_list(Results, MaxValue), nth0(IndexMiddle, Results, MaxValue), nth0(IndexMiddle, IndexList, MaxIndex).


getMovedResults(Index, Player, R1, R2) :- getMovedResult(Index, Player, R1),
										  changePlayer(Player, Opponent), getMovedResult(Index, Opponent, R2). 


moveSimulation(Index, Player, [H1], [H2]) :- Index == 6, getMovedResults(Index, Player, H1, H2),!.

moveSimulation(Index, Player, [H1|MyList], [H2|DefenseList]) :- Index < 6, NewIndex is Index+1, getMovedResults(Index, Player, H1, H2),
															    moveSimulation(NewIndex, Player, MyList, DefenseList).	

findMove(MyList, DefenseList, Index) :- max_list(MyList, MyResult),	
							            MyResult == 4, nth0(Index, MyList, MyResult),!.

findMove(MyList, DefenseList, Index) :- max_list(DefenseList, DefenseResult),	
							   			containNumber(DefenseList, DefenseResult, N), N == 1, nth0(Index, DefenseList, DefenseResult),!.

findMove(MyList, DefenseList, Index) :-	max_list(DefenseList, DefenseResult),	
							   			containNumber(DefenseList, DefenseResult, N), N > 1, allIndex(DefenseList, DefenseList, DefenseResult, IndexList),
							   			findMaxFromIndex(MyList, IndexList, Index),!.						   			

indexToMove2(Index, Player) :- moveSimulation(0, Player, MyList, DefenseList), writeln(MyList), writeln(DefenseList), findMove(MyList, DefenseList, Index),!.	



							  																					    					
