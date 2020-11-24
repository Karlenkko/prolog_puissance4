winRowLeft(Index, Board, Interval, Piece, Number, Result) :- not(member(Index, Interval)), Result is Number-1, !.
winRowLeft(Index, Board, Interval, Piece, Number, Result) :- nth0(Index, Board, Val), Val \== Piece, Result is Number-1, !.
winRowLeft(Index, Board, Interval, Piece, Number, Result) :- NewIndex is Index-1, NewNumber is Number+1, winRowLeft(NewIndex, Board, Interval, Piece, NewNumber, Result).

winRowRight(Index, Board, Interval, Piece, Number, Result) :- not(member(Index, Interval)), Result is Number-1, !.
winRowRight(Index, Board, Interval, Piece, Number, Result) :- nth0(Index, Board, Val), Val \== Piece, Result is Number-1, !.
winRowRight(Index, Board, Interval, Piece, Number, Result) :- NewIndex is Index+1, NewNumber is Number+1, winRowRight(NewIndex, Board, Interval, Piece, NewNumber, Result).

winColUp(Index, Board, Interval, Piece, Number, Result) :- not(member(Index, Interval)), Result is Number-1, !.
winColUp(Index, Board, Interval, Piece, Number, Result) :- nth0(Index, Board, Val), Val \== Piece, Result is Number-1, !.
winColUp(Index, Board, Interval, Piece, Number, Result) :- NewIndex is Index-7, NewNumber is Number+1, winColUp(NewIndex, Board, Interval, Piece, NewNumber, Result).

winColDown(Index, Board, Interval, Piece, Number, Result) :- not(member(Index, Interval)), Result is Number-1, !.
winColDown(Index, Board, Interval, Piece, Number, Result) :- nth0(Index, Board, Val), Val \== Piece, Result is Number-1, !.
winColDown(Index, Board, Interval, Piece, Number, Result) :- NewIndex is Index+7, NewNumber is Number+1, winColDown(NewIndex, Board, Interval, Piece, NewNumber, Result).

winDiagLeft(Index, Board, Piece, Number, Result) :- Index < 7, Result = Number,!.
winDiagLeft(Index, Board, Piece, Number, Result) :- (Index mod 7) =:= 0, Result is Number-1, !.
winDiagLeft(Index, Board, Piece, Number, Result) :- nth0(Index, Board, Val), Val \== Piece, Result is Number-1, !.
winDiagLeft(Index, Board, Piece, Number, Result) :- Index > 7, NewIndex is Index-8, NewNumber is Number+1, winDiagLeft(NewIndex, Board, Piece, NewNumber, Result).

winDiagRight(Index, Board, Piece, Number, Result) :- Index > 33, Result = Number,!.
winDiagRight(Index, Board, Piece, Number, Result) :- (Index mod 7) =:= 6, Result is Number-1, !.
winDiagRight(Index, Board, Piece, Number, Result) :- nth0(Index, Board, Val), Val \== Piece, Result is Number-1, !.
winDiagRight(Index, Board, Piece, Number, Result) :- Index < 34, NewIndex is Index+8, NewNumber is Number+1, winDiagRight(NewIndex, Board, Piece, NewNumber, Result).


winRDiagLeft(Index, Board, Piece, Number, Result) :- Index > 35, Result = Number, !.
winRDiagLeft(Index, Board, Piece, Number, Result) :- (Index mod 7) =:= 0, Result is Number-1, !.
winRDiagLeft(Index, Board, Piece, Number, Result) :- nth0(Index, Board, Val), Val \== Piece, Result is Number-1, !.
winRDiagLeft(Index, Board, Piece, Number, Result) :- Index < 35, NewIndex is Index+6, NewNumber is Number+1, winRDiagLeft(NewIndex, Board, Piece, NewNumber, Result).

winRDiagRight(Index, Board, Piece, Number, Result) :- Index < 6, Result = Number, !.
winRDiagRight(Index, Board, Piece, Number, Result) :- (Index mod 7) =:= 6, Result is Number-1, !.
winRDiagRight(Index, Board, Piece, Number, Result) :- nth0(Index, Board, Val), Val \== Piece, Result is Number-1, !.
winRDiagRight(Index, Board, Piece, Number, Result) :- Index > 6, NewIndex is Index-6, NewNumber is Number+1, winRDiagRight(NewIndex, Board, Piece, NewNumber, Result).

getRowInterval(Index, Interval) :- X is div(Index, 7), X1 is X*7, X2 is X1+1, X3 is X1+2, X4 is X1+3, X5 is X1+4, X6 is X1+5, X7 is X1+6, Interval = [X1, X2, X3, X4, X5, X6, X7].
getColInterval(Index, Interval) :- X is (Index mod 7), X1 is X, X2 is X+7, X3 is X+14, X4 is X+21, X5 is X+28, X6 is X+35, Interval = [X1, X2, X3, X4, X5, X6].

winPoint(Index, B, Piece) :- getRowInterval(Index, Interval), winRowLeft(Index, B, Interval, Piece, 1, Result), winRowRight(Index, B, Interval, Piece, Result, FinalResult), FinalResult == 4, !.
winPoint(Index, B, Piece) :- getColInterval(Index, Interval), winColUp(Index, B, Interval, Piece, 1, Result), winColDown(Index, B, Interval, Piece, Result, FinalResult), FinalResult == 4, !.
winPoint(Index, B, Piece) :- winDiagLeft(Index, B, Piece, 1, Result), winDiagRight(Index, B, Piece, Result, FinalResult), FinalResult == 4, !.
winPoint(Index, B, Piece) :- winRDiagLeft(Index, B, Piece, 1, Result), winRDiagRight(Index, B, Piece, Result, FinalResult), FinalResult == 4, !.



for(Index, B, Piece) :- winPoint(Index, B, Piece),!.
for(Index, B, Piece) :- Index < 41, NewIndex is Index+1, for(NewIndex, B, Piece).

win(B, Piece) :- for(0, B, Piece).




winner(B, Piece) :- B = [P,Q,R,S,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,P,Q,R,S,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,P,Q,R,S,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,P,Q,R,S,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.

winner(B, Piece) :- B = [_,_,_,_,_,_,_,P,Q,R,S,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,P,Q,R,S,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,P,Q,R,S,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,P,Q,R,S,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.

winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,P,Q,R,S,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,P,Q,R,S,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,P,Q,R,S,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,P,Q,R,S,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.

winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,P,Q,R,S,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,P,Q,R,S,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,P,Q,R,S,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,P,Q,R,S,_,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.

winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,P,Q,R,S,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,P,Q,R,S,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,P,Q,R,S,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,P,Q,R,S,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.

winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,P,Q,R,S,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,P,Q,R,S,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,P,Q,R,S,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,P,Q,R,S], P == Q, Q == R, R == S, nonvar(P), P == Piece.

winner(B, Piece) :- B = [P,_,_,_,_,_,_,Q,_,_,_,_,_,_,R,_,_,_,_,_,_,S,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,P,_,_,_,_,_,_,Q,_,_,_,_,_,_,R,_,_,_,_,_,_,S,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,P,_,_,_,_,_,_,Q,_,_,_,_,_,_,R,_,_,_,_,_,_,S,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,P,_,_,_,_,_,_,Q,_,_,_,_,_,_,R,_,_,_,_,_,_,S,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,P,_,_,_,_,_,_,Q,_,_,_,_,_,_,R,_,_,_,_,_,_,S,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,P,_,_,_,_,_,_,Q,_,_,_,_,_,_,R,_,_,_,_,_,_,S,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,P,_,_,_,_,_,_,Q,_,_,_,_,_,_,R,_,_,_,_,_,_,S,_,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.

winner(B, Piece) :- B = [_,_,_,_,_,_,_,P,_,_,_,_,_,_,Q,_,_,_,_,_,_,R,_,_,_,_,_,_,S,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,P,_,_,_,_,_,_,Q,_,_,_,_,_,_,R,_,_,_,_,_,_,S,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,P,_,_,_,_,_,_,Q,_,_,_,_,_,_,R,_,_,_,_,_,_,S,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,P,_,_,_,_,_,_,Q,_,_,_,_,_,_,R,_,_,_,_,_,_,S,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,P,_,_,_,_,_,_,Q,_,_,_,_,_,_,R,_,_,_,_,_,_,S,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,P,_,_,_,_,_,_,Q,_,_,_,_,_,_,R,_,_,_,_,_,_,S,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,P,_,_,_,_,_,_,Q,_,_,_,_,_,_,R,_,_,_,_,_,_,S,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.

winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,P,_,_,_,_,_,_,Q,_,_,_,_,_,_,R,_,_,_,_,_,_,S,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,P,_,_,_,_,_,_,Q,_,_,_,_,_,_,R,_,_,_,_,_,_,S,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,P,_,_,_,_,_,_,Q,_,_,_,_,_,_,R,_,_,_,_,_,_,S,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,P,_,_,_,_,_,_,Q,_,_,_,_,_,_,R,_,_,_,_,_,_,S,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,P,_,_,_,_,_,_,Q,_,_,_,_,_,_,R,_,_,_,_,_,_,S,_,_], P == Q, P == R, P == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,P,_,_,_,_,_,_,Q,_,_,_,_,_,_,R,_,_,_,_,_,_,S,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,P,_,_,_,_,_,_,Q,_,_,_,_,_,_,R,_,_,_,_,_,_,S], P == Q, Q == R, R == S, nonvar(P), P == Piece.

winner(B, Piece) :- B = [P,_,_,_,_,_,_,_,Q,_,_,_,_,_,_,_,R,_,_,_,_,_,_,_,S,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,P,_,_,_,_,_,_,_,Q,_,_,_,_,_,_,_,R,_,_,_,_,_,_,_,S,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,P,_,_,_,_,_,_,_,Q,_,_,_,_,_,_,_,R,_,_,_,_,_,_,_,S,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,P,_,_,_,_,_,_,_,Q,_,_,_,_,_,_,_,R,_,_,_,_,_,_,_,S,_,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.

winner(B, Piece) :- B = [_,_,_,_,_,_,_,P,_,_,_,_,_,_,_,Q,_,_,_,_,_,_,_,R,_,_,_,_,_,_,_,S,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,P,_,_,_,_,_,_,_,Q,_,_,_,_,_,_,_,R,_,_,_,_,_,_,_,S,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,P,_,_,_,_,_,_,_,Q,_,_,_,_,_,_,_,R,_,_,_,_,_,_,_,S,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,P,_,_,_,_,_,_,_,Q,_,_,_,_,_,_,_,R,_,_,_,_,_,_,_,S,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.

winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,P,_,_,_,_,_,_,_,Q,_,_,_,_,_,_,_,R,_,_,_,_,_,_,_,S,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,P,_,_,_,_,_,_,_,Q,_,_,_,_,_,_,_,R,_,_,_,_,_,_,_,S,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,P,_,_,_,_,_,_,_,Q,_,_,_,_,_,_,_,R,_,_,_,_,_,_,_,S,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,P,_,_,_,_,_,_,_,Q,_,_,_,_,_,_,_,R,_,_,_,_,_,_,_,S], P == Q, Q == R, R == S, nonvar(P), P == Piece.

winner(B, Piece) :- B = [_,_,_,P,_,_,_,_,_,Q,_,_,_,_,_,R,_,_,_,_,_,S,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,P,_,_,_,_,_,Q,_,_,_,_,_,R,_,_,_,_,_,S,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,P,_,_,_,_,_,Q,_,_,_,_,_,R,_,_,_,_,_,S,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,P,_,_,_,_,_,Q,_,_,_,_,_,R,_,_,_,_,_,S,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.

winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,P,_,_,_,_,_,Q,_,_,_,_,_,R,_,_,_,_,_,S,_,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,P,_,_,_,_,_,Q,_,_,_,_,_,R,_,_,_,_,_,S,_,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,P,_,_,_,_,_,Q,_,_,_,_,_,R,_,_,_,_,_,S,_,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,P,_,_,_,_,_,Q,_,_,_,_,_,R,_,_,_,_,_,S,_,_,_,_,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.

winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,P,_,_,_,_,_,Q,_,_,_,_,_,R,_,_,_,_,_,S,_,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,P,_,_,_,_,_,Q,_,_,_,_,_,R,_,_,_,_,_,S,_,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,P,_,_,_,_,_,Q,_,_,_,_,_,R,_,_,_,_,_,S,_,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.
winner(B, Piece) :- B = [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,P,_,_,_,_,_,Q,_,_,_,_,_,R,_,_,_,_,_,S,_,_,_], P == Q, Q == R, R == S, nonvar(P), P == Piece.


