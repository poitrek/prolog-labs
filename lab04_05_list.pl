
% [H | T] = [ada, piotr, romek, maja, zenek].

% member(X, L) - X jest elementem listy L
member(X, [X|_]).
member(X, [_|T]) :- member(X, T).

intersection(X, Y) :- member(Z, X), member(Z, Y).
% append([1, 2], 3, [1, 2, 3])
append([], X, [X]).
append([H | T], X, [H | T1]) :- append(T, X, T1).

% join([1, 2, 3], [4, 5], [1, 2, 3, 4, 5])
join([], X, X).
join([H | T], X, [H | T1]) :- join(T, X, T1).

% Ostatni element listy
last_el(X, [X]).
last_el(X, [_|T]) :- last_el(X, T).

prefiks([], _).
prefiks([H|T1], [H|T2]) :- prefiks(T1, T2).

% Podlista spójna
% podlista([a, d, f], [b, c, a, d, f, x, y])
podlista([], _).
podlista([H1|T1], [H2|T2]) :- prefiks([H1|T1], [H2|T2]); podlista([H1|T1], T2).

% Sortowanie (sortowanie przez wstawianie)
wstaw_sorted(X, [], [X]).
% wstaw_sorted(5, [2, 4, 6, 8, 10], [2, 4, 5, 6, 8, 10]
% wstaw_sorted(1, [2, 4, 6, 8, 10], [1, 2, 4, 6, 8, 10])

wstaw_sorted(X, [H|T], [X, H | T]) :- X =< H. 
wstaw_sorted(X, [H|T], [H|T1]) :- X > H, wstaw_sorted(X, T, T1).
% Alternatywnie
%wstaw_sorted(X, [H|T], [H1|T1]) :- X < H, H1 = X, T1 = [H|T]; X >= H, H1 = H, wstaw_sorted(X, T, T1).

sortuj([], []).
sortuj([H|T], L2) :- sortuj(T, T2), wstaw_sorted(H, T2, L2).

% Podlista niekoniecznie spójna
% podlista2([1,2,3], [a,1,a,b,b,2,b,a,3]).
podlista2([], _).
podlista2([H|T], [H|T2]) :- podlista2(T, T2).
podlista2(L, [_|T2]) :- L \= [], podlista2(L, T2).

%not_empty(X) :- X \= [].

% Permutacja
% permutacja([], []).
% permutacja([H|T1], [H|T2]) :- permutacja(T1, T2).
% Raczej nie
% permutacja([H1|T1], [H2|T2]) :- member(H1, T2), member(H2, T1), permutacja(T1, T2).

contains_sorted(L1, [El|L1], El).
contains_sorted([H|T1], [H|T2], El) :- H \= El, contains_sorted(T1, T2, El).

% Wstaw X w dowolne (1 z n, gdzie n - długość L) miejsce listy L
insert_anywhere(L, X, [X|L]).
insert_anywhere([H|T], X, [H|T1]) :- insert_anywhere(T, X, T1).

% permutacja(X, Y) - uzgadnia z Y kolejne permutacje X
permutacja([], []).
permutacja([H|T], P) :- permutacja(T, PT), insert_anywhere(PT, H, P).


% usun_element(L1, E, L2) - usuwa z listy L1 pierwsze wystąpienie elementu E i uzgadnia
% wynikową listę z L2. Jeśli elementu nie ma na liście, to uzgadnia listę L2 z L1
usun_element([X|T], X, T).
usun_element([], _, []).
usun_element([H|T1], X, [H|T2]) :- H \= X, usun_element(T1, X, T2).

% usun_duplikaty(L1, L2) - usuwa z listy L1 duplikaty i uzgadnia wynik z listą L2
usun_duplikaty([], []).
usun_duplikaty([H|T1], T2) :- member(H, T1), usun_duplikaty(T1, T2), !.
usun_duplikaty([H|T1], [H|T2]) :- \+member(H, T1), usun_duplikaty(T1, T2).

% ------ więcej ------

% usuń wszystkie wystąpienia X w L1
usun_wszystkie([], _, []).
usun_wszystkie([X|T1], X, T2) :- usun_wszystkie(T1, X, T2).
usun_wszystkie([H|T1], X, [H|T2]) :- H \= X, usun_wszystkie(T1, X, T2).

% Usuń wszystkie elementy spełniające predykat Pred/1
usun_gdzie([], _, []).
usun_gdzie([H|T1], Pred, T2) :- call(Pred, H), usun_gdzie(T1, Pred, T2).
usun_gdzie([H|T1], Pred, [H|T2]) :- \+call(Pred, H), usun_gdzie(T1, Pred, T2).
% Np. even(X) - X jest parzyste
even(X) :- X // 2 =:= X / 2.
% usun_gdzie([1,2,3,4,5], even, X)


% ---------- Zadania z kartkówki ----------
% 1
dodatnie([], 0).
dodatnie([H|T], N) :- H > 0, dodatnie(T, N1), N is N1+1;
                    H =< 0, dodatnie(T, N).
% 2
double([], []).
double([H|T1], [H,H|T2]) :- double(T1, T2).
