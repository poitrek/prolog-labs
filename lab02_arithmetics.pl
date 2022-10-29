% Ćw. 1
suma(wektor(A1, B1, C1), wektor(A2, B2, C2), wektor(A3, B3, C3)) :- A3 is A1+A2,
    B3 is B1+B2, C3 is C1+C2.

iloczyn_sk(wektor(A1, B1, C1), wektor(A2, B2, C2), W) :-
    W is A1*A2+B1*B2+C1*C2.

% Ćw. 2
wiekszy(3, 4, 4).
wiekszy(2, 1, 2).
wiekszy(0, 5, 5).
wiekszy(1, 5, 5).
wiekszy(2, 5, 5).
% itd. w nieskończoność...
% ogólnie
wiekszy(X, Y, Z) :- Z is X, X > Y; Z is Y, Y >= X.

modul(X, Y) :- Y is -X, X < 0; Y is X, X >= 0.

% Y == suma liczb od 1 do X
sumaw(X, Y) :- X == 0, Y is 0;
    		   X > 0, X_1 is X-1, sumaw(X_1, Y1), Y is Y1+X.

% alternatywne rozwiązanie
sumaw(X, Y) :- X =:= 0, Y is 0;
    		   X > 0, sumaw(X-1, Y1), Y is Y1+X.

% Ćw. 3
%a(X, Y) :- Y is X+1; Y is X-1.
delta(A, B, C, D) :- D is B*B-4*A*C.

pierw(A, B, C, X) :- delta(A, B, C, D), D >= 0, Dsqrt is sqrt(D),
    (X is (-B + Dsqrt) / (2 * A); D > 0, X is (-B - Dsqrt) / (2 * A)).


