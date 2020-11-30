getMovedResult2(Index, Player, RF) :- board(Board),
									  nth0(Index, Board, Elem), var(Elem),
									  descend(Index, Board, FinalMove),
									  playMove(Board, FinalMove, NewBoard, Player),
									  getPlayer(Player, Piece),
									  forAllIndex(0, NewBoard, Piece, Results),
									  assert(newboard(NewBoard)),
								      moveSimulationSimple2(0, Player, ResultsStep2),
								      retract(newboard(NewBoard)),
								      %writeln(ResultsStep2),
								      max_list(Results, R),
								      max_list(ResultsStep2, R2),
								      evolveList(R, R2, RF).


getMovedResult2(Index, Player, R1) :- board(Board),
									  nth0(Index, Board, Elem), nonvar(Elem),
									  R1 = -2.


getMovedResults2(Index, Player, R1, R2) :- getMovedResult2(Index, Player, R1),
										   changePlayer(Player, Opponent), getMovedResult(Index, Opponent, R2). 

moveSimulation2(Index, Player, [H1], [H2]) :- Index == 6, getMovedResults2(Index, Player, H1, H2),!.

moveSimulation2(Index, Player, [H1|MyList], [H2|DefenseList]) :- Index < 6, NewIndex is Index+1, getMovedResults2(Index, Player, H1, H2),
															    moveSimulation2(NewIndex, Player, MyList, DefenseList).	


indexToMove3(Index, Player) :- moveSimulation2(0, Player, MyList, DefenseList), writeln(MyList), writeln(DefenseList), findMove(MyList, DefenseList, Index),!.





%
getMovedResultsSimple2(Index, Player, R2) :- changePlayer(Player, Opponent), getMovedResultBoard(Index, Opponent, R2). 						  

moveSimulationSimple2(Index, Player, [H2]) :- Index == 6, getMovedResultsSimple2(Index, Player, H2),!.

moveSimulationSimple2(Index, Player, [H2|DefenseList]) :- Index < 6, NewIndex is Index+1, getMovedResultsSimple2(Index, Player, H2),
														  moveSimulationSimple2(NewIndex, Player, DefenseList).


getMovedResultBoard(Index, Player, R1) :- newboard(Board),
										  nth0(Index, Board, Elem), var(Elem),
									 	  descend(Index, Board, FinalMove),
									 	  playMove(Board, FinalMove, Step2Board, Player),
									 	  getPlayer(Player, Piece),
								    	  forAllIndex(0, Step2Board, Piece, Results),
									 	  max_list(Results, R1).


getMovedResultBoard(Index, Player, R1) :- newboard(Board), nth0(Index, Board, Elem), nonvar(Elem),
									 	  R1 = -2.	


evolveList(R, R2, RF) :- R >= 4, RF = R,!.
evolveList(R, R2, RF) :- R < 4, R2 >= 4, RF = -1,!.
evolveList(R, R2, RF) :- R < 4, R2 == 3, RF is R-1,!.
evolveList(R, R2, RF) :- R < 4, R2 < 3, RF = R,!.

