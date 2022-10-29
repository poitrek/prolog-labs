% Konstrukcja liczb Peano
num(0). num(s(X)) :- num(X).

% X+5, X+10
s5(X, s(s(s(s(s(X)))))) :- num(X).
s10(X, Z) :- s5(X, Y), s5(Y, Z).

% X jest mniejsze od Y
less(0, s(X)) :- num(X).
less(s(X), s(Y)) :- less(X, Y).

greater(s(X), 0) :- num(X).
greater(s(X), s(Y)) :- greater(X, Y).

% Z == X + Y
add(0, X, X) :- num(X).
add(s(X), Y, s(Z)) :- add(X, Y, Z).

mul(0, X, 0) :- num(X).
mul(s(X), Y, Z) :- add(Z1, Y, Z), mul(X, Y, Z1).

% Odejmowanie Z == max(0, X-Y)
%sub(X, 0, X) :- num(X).
sub(X, Y, Z) :- add(Z, Y, X); \+add(Z, Y, X), Z = 0.

% Podzielność div(X, Y) - X dzieli Y
%\+div(0, Y).
div(X, Y) :- X \= 0, num(X),
            (Y = 0; add(X, Y1, Y), div(X, Y1)).

% Reszta z dzielenia Z = X % Y
rem(X, Y, X) :- greater(Y, X).
rem(X, Y, Z) :- add(X1, Y, X), rem(X1, Y, Z).

% Konwersja "normalnej" liczby w systemie dziesietnym na l. w postaci Peano
dec_to_peano(0, 0).
dec_to_peano(N, s(X)) :- N > 0, N1 is N-1, dec_to_peano(N1, X).

peano_to_dec(0, 0).
peano_to_dec(s(X), N) :- peano_to_dec(X, N1), N is N1+1.
