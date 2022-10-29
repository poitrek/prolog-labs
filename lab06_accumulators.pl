suma1(0, 0).
suma1(N, S) :- N > 0, N1 is N-1, suma1(N1, S1), S is S1+N.

suma(N, S) :- suma(N, 0, S).
suma(0, A, A).
suma(N, A, S) :- N > 0, A1 is A+N, N1 is N-1, suma(N1, A1, S).

dlugosc(L, N) :- dlugosc(L, 0, N).
dlugosc([], N, N).
dlugosc([_|T], M, N) :- M1 is M+1, dlugosc(T, M1, N).

% Suma listy
suma_l(L, N) :- suma_l(L, 0, N).
suma_l([], N, N).
suma_l([H|T], M, N) :- M1 is M+H, suma_l(T, M1, N).

% Zad. 1. Silnia
silnia(N, S) :- silnia(N, 1, S).
silnia(0, M, M).
silnia(N, M, S) :- N1 is N-1, M1 is M*N, silnia(N1, M1, S).

% Fib
fib(N, F) :- fib(N, 0, 1, F).
fib(0, F1, F2, F1).
fib(N, F1, F2, F) :- N>0, N1 is N-1, F11 is F2, F12 is F1+F2, fib(N1, F11, F12, F).


% Zad. 2. Przekatna macierzy
% przekatna([1, 2, 3], [4, 5, 6], [7, 8, 9], D).
% D = [1, 5, 9]
% Dodaj n-ty elem. z listy do listy L1
append_nth([H|_], 0, L1, L2) :- append(L1, [H], L2).
append_nth([_|T], N, L1, L2) :- N > 0, N1 is N-1, append_nth(T, N1, L1, L2).

przekatna(L, D) :- przekatna(L, 0, [], D).
przekatna([], _, D, D).
przekatna([H|T], N, DD, D) :- append_nth(H, N, DD, DD1), N1 is N+1, przekatna(T, N1, DD1, D).

% Zad. 3. Sumy
sumy(L, X, Y) :- sumy(L, 0, 0, X, Y).
sumy([], X, Y, X, Y).
sumy([H|T], Su, Sd, X, Y) :- H >= 0, Sd1 is Sd + H, sumy(T, Su, Sd1, X, Y);
        H < 0, Su1 is Su + H, sumy(T, Su1, Sd, X, Y).

% Zad. 4. Spłaszcz listę
% splaszcz([a, [1, [ b, [], c ], a, 1]], P).
% P = [a,1,b,c,a,1]
jest_lista([]).
jest_lista([_|_]).
zlacz(L1, [], L1).
zlacz(L1, [H|T2], L3) :- append(L1, [H], L4), zlacz(L4, T2, L3).
splaszcz(L, P) :- splaszcz(L, [], [], P).
splaszcz([], [], P, P).
splaszcz([], [Hr|Tr], P, Pres) :- splaszcz([Hr], Tr, P, Pres).
splaszcz([H|T], R, P, PRes) :- jest_lista(H), zlacz(T, R, R1), splaszcz(H, R1, P, PRes);
        \+ jest_lista(H), append(P, [H], P1), splaszcz(T, R, P1, PRes).


% Inne

% Reverse - naiwnie
odwroc1([], []).
odwroc1([H1|T1], L2) :- odwroc1(T1, T1Rev), append(T1Rev, [H1], L2).
% Reverse - mądrze
odwroc(L, LR) :- odwroc(L, [], LR).
odwroc([], LR, LR).
odwroc([H|T], LAk, LR) :- odwroc(T, [H|LAk], LR).

% Sortuj
wstaw_sorted([], X, [X]).
wstaw_sorted([H|T], X, [X, H|T]) :- 
sortuj(L, LS) :- sortuj(L, [], LS).
sortuj([], LS, LS).
% sortuj([H|T], )
