% Graf acykliczny ab, bc, bd, ce, cf, df, fe
e(a, b). e(b, c). e(b, d). e(c, e). e(c, f). e(d, f). e(f, e).

% path(X, Y) :- e(X, Y); e(X, Z), path(Z, Y).
path(X, Y) :- e(X, Y); path(X, Z), e(Z, Y).


% Czy istnieje sciezka z X do Y o dlugosci N
path_l(X, Y, N) :- N =:= 1, e(X, Y).
path_l(X, Y, N) :- N > 1, N1 is N-1, e(X, Z), path_l(Z, Y, N1).

even(N) :- N / 2 =:= N // 2.
odd(N) :- \+ even(N).
% Problem Collatza
collatz(N) :- write(N), write(' '), 
    (N =:= 1; N > 1,
        (even(N), Nnext is N / 2;
        odd(N), Nnext is 3*N+1),
        collatz(Nnext)).

% Ktory element ciagu zbiegl sie do 1
collatz2(N, Cnt) :- 
    N =:= 1, Cnt is 1;
    N > 1,
    (even(N), Nnext is N / 2;
    odd(N), Nnext is 3*N+1),
    collatz2(Nnext, Cnt2),
    Cnt is Cnt2+1.

% Wspolczynnik dwumianowy
binom(K, L , X) :- L =:= 0, X is 1; L =\= 0, K =:= L, X is 1;
        L =\= 0, K =\= L, K1 is K-1, L1 is L-1, binom(K1, L, X1),
        binom(K1, L1, X2), X is X1+X2.

binom2(K, L, X) :-
    L =:= K, X is 1;
    L =:= 0, X is 1;
    K1 is K - 1, binom2(K1, L, X1), L1 is L - 1, binom2(K1, L1, X2), X is X1 + X2.
