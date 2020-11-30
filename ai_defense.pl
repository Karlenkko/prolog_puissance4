numberRow(Index, B, Piece, FinalResult) :- getRowInterval(Index, Interval), winRowLeft(Index, B, Interval, Piece, 1, Result), winRowRight(Index, B, Interval, Piece, Result, FinalResult).
numberCol(Index, B, Piece, FinalResult) :- getColInterval(Index, Interval), winColUp(Index, B, Interval, Piece, 1, Result), winColDown(Index, B, Interval, Piece, Result, FinalResult).
numberDia(Index, B, Piece, FinalResult) :- winDiagLeft(Index, B, Piece, 1, Result), winDiagRight(Index, B, Piece, Result, FinalResult).
numberRDia(Index, B, Piece, FinalResult) :- winRDiagLeft(Index, B, Piece, 1, Result), winRDiagRight(Index, B, Piece, Result, FinalResult).

getResultNumber(Index, B, Piece, Result) :- numberRow(Index, B, Piece, X1), numberCol(Index, B, Piece, X2), numberDia(Index, B, Piece, X3), numberRDia(Index, B, Piece, X4), List = [X1, X2, X3, X4],
											max_list([X1, X2, X3, X4], Result).


forAllIndex(Index, B, Piece, [H]) :- Index == 41, getResultNumber(Index, B, Piece, H),!.
forAllIndex(Index, B, Piece, [H|ListResult]) :- Index < 41, NewIndex is Index+1, getResultNumber(Index, B, Piece, H), forAllIndex(NewIndex, B, Piece, ListResult).


% simple defense AI

getMovedResultsSimple(Index, Player, R2) :- changePlayer(Player, Opponent), getMovedResult(Index, Opponent, R2). 						  

moveSimulationSimple(Index, Player, [H2]) :- Index == 6, getMovedResultsSimple(Index, Player, H2),!.

moveSimulationSimple(Index, Player, [H2|DefenseList]) :- Index < 6, NewIndex is Index+1, getMovedResultsSimple(Index, Player, H2),
														 moveSimulationSimple(NewIndex, Player, DefenseList).						

indexToMove(Index, Player) :- moveSimulationSimple(0, Player, Results), write(Results), max_list(Results, R1), nth0(Index, Results, R1), writeln(Index),!.

% 

getMovedResult(Index, Player, R1) :- board(Board),
									 nth0(Index, Board, Elem), var(Elem),
									 descend(Index, Board, FinalMove),
									 playMove(Board, FinalMove, NewBoard, Player),
									 getPlayer(Player, Piece),
									 forAllIndex(0, NewBoard, Piece, Results),
									 max_list(Results, R1).


getMovedResult(Index, Player, R1) :- board(Board),
									 nth0(Index, Board, Elem), nonvar(Elem),
									 R1 = -2.




