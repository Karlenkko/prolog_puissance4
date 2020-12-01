indexToMove4(Index, Player) :- moveSimulation2(0, Player, MyList, DefenseList),
							   weights(Weights, 0), transformToWeights(MyList, Weights, Results), findMove(Results, DefenseList, Index),!.



weights([H], Index) :- Index == 6, getWeight(Index, H),!.  
weights([H|List], Index) :- Index < 6, NewIndex is Index+1, weights(List, NewIndex), getWeight(Index, H).  

getWeight(Index, Weights) :- board(Board), descend(Index, Board, FinalMove),
					   		 calculateWeight(FinalMove, Weights).

% class 1
calculateWeight(FinalMove, Weights) :- (FinalMove mod 7) =:= 0, Weights = 3, !.
calculateWeight(FinalMove, Weights) :- (FinalMove mod 7) =:= 6, Weights = 3, !.
calculateWeight(FinalMove, Weights) :- div(FinalMove, 7) =:= 0, Weights = 3, !.
calculateWeight(FinalMove, Weights) :- div(FinalMove, 7) =:= 5, Weights = 3, !.

% class 2
calculateWeight(FinalMove, Weights) :- (FinalMove mod 7) =:= 1, Weights = 2, !.
calculateWeight(FinalMove, Weights) :- (FinalMove mod 7) =:= 5, Weights = 2, !.
calculateWeight(FinalMove, Weights) :- div(FinalMove, 7) =:= 1, Weights = 2, !.
calculateWeight(FinalMove, Weights) :- div(FinalMove, 7) =:= 4, Weights = 2, !.

% class 3
calculateWeight(FinalMove, Weights) :- (FinalMove mod 7) =:= 2, Weights = 1, !.
calculateWeight(FinalMove, Weights) :- (FinalMove mod 7) =:= 4, Weights = 1, !.

% class 4
calculateWeight(FinalMove, Weights) :- (FinalMove mod 7) =:= 3, Weights = 0, !.


transformToWeights([], [], []).
transformToWeights([H|MyList], [H2|Weights], [H3|Results]) :- H >= 4, transformToWeights(MyList, Weights, Results), H3 = H, !.
transformToWeights([H|MyList], [H2|Weights], [H3|Results]) :- H < 4, transformToWeights(MyList, Weights, Results), H3 is H-H2, !.