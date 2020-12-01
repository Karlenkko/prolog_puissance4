indexToMove5(Index, Player) :- moveSimulation2(0, Player, MyList, DefenseList),
							   weights(Weights, 0), transformToWeights(MyList, Weights, Results), findMoveDyn(Results, DefenseList, Index),!.



findMoveDyn(MyList, DefenseList, Index) :- max_list(MyList, MyResult),	
							            MyResult >= 4, nth0(Index, MyList, MyResult),!.

findMoveDyn(MyList, DefenseList, Index) :- max_list(DefenseList, DefenseResult),	
							   			containNumber(DefenseList, DefenseResult, N), N == 1, nth0(Index, DefenseList, DefenseResult),!.

findMoveDyn(MyList, DefenseList, Index) :-	max_list(DefenseList, DefenseResult),	
							   			containNumber(DefenseList, DefenseResult, N), N > 1, allIndex(DefenseList, DefenseList, DefenseResult, IndexList),
							   			tranformPositive(MyList, PositiveList), tranformStatistic(PositiveList, StatisticList, 0), 
							   			chooseIndex(StatisticList, IndexList, Index), !.


chooseIndex(List, IndexList, Index) :- repeat, randomIndex(List, Index),
				       				   contains_var(Index, IndexList),!.


tranformPositive([],[]).
tranformPositive([H|MyList], [H2|PositiveList]) :- tranformPositive(MyList, PositiveList), H2 is H+6, !.


tranformStatistic([],[],_).
tranformStatistic([H|MyList], [H2|StatisticList], X) :- NewX is X+H, tranformStatistic(MyList, StatisticList, NewX), H2 is NewX, !. 

randomIndex(List, Index) :-  max_list(List, Max), Random is random(Max), chooseElement(List, Random, Element), nth0(Index, List, Element).

chooseElement([], Random, Random) :- !.
chooseElement([H|List], Random, Element) :- H > Random, Element is H, !.
chooseElement([H|List], Random, Element) :- H =< Random, chooseElement(List, Random, Element), !.


