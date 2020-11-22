:- include(winner).

init :- length(Board,42), assert(board(Board)), play('player1').

% ['C:\\Users\\18740\\OneDrive\\document\\4IF-Flagship\\Approche logique de l\'intelligence artificielle\\projet\\prolog_puissance4\\main.pl'].

%	'?' represents empty, 'x' represents player1, 'o' represents player2
%	functions for displaying the board
printVal(N) :- board(B), nth0(N,B,Val), var(Val), write(' ? '), !. 
printVal(N) :- board(B), nth0(N,B,Val), write(' '), write(Val), write(' ').
myWrite(X) :- 
	(X mod 7) =:= 6, printVal(X), writeln('');
	printVal(X).

displayBoard :- writeln('****************'),
				foreach(between(0,41,X),myWrite(X)),
				writeln('****************').


%
descend(Move, Board, FinalMove) :- Move > 41, FinalMove is Move-7,!.
descend(Move, Board, FinalMove) :- nth0(Move, Board, Elem), not(var(Elem)), FinalMove is Move-7,!.
descend(Move, Board, FinalMove) :- NewMove is Move+7, descend(NewMove, Board, FinalMove).


% AI need to be done after,  _ represents Player
ia(Board, Index) :-
	repeat, Index is random(7), nth0(Index, Board, Elem), var(Elem), !.



%
rightNumber(N) :- N =< 6, N >= 0.	



player(Board, Move) :- repeat, write("select a colum from 0 to 6 "), read(Move), rightNumber(Move),
				    nth0(Move, Board, Elem), var(Elem),!.


turn(Player, Board, Move) :- Player == 'player1', player(Board, Move);
					   	  	 Player == 'player2', ia(Board, Move).

%
changePlayer('player1','player2').
changePlayer('player2','player1').

getPlayer('player1', x).
getPlayer('player2', o).


%
playMove(Board, Move, NewBoard, Player) :-
				NewBoard = Board, getPlayer(Player, Piece), nth0(Move, NewBoard, Piece).

applyIt(Board, NewBoard) :- retract(board(Board)),assert(board(NewBoard)).


play(Player) :- write('New turn for: '), writeln(Player),
				board(Board),
				displayBoard,
				turn(Player, Board, Move),
				descend(Move, Board, FinalMove),
				playMove(Board, FinalMove, NewBoard, Player),
				applyIt(Board, NewBoard),
				getPlayer(Player, Piece),
				not(winner(NewBoard, Piece)),
				
				changePlayer(Player, NextPlayer),
				play(NextPlayer).






						






