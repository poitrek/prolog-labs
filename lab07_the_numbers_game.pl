
% Niepotrzebne
usun([H|T], H, T).
usun([H|T], X, [H|L1]) :- H =\= X, usun(T, X, L1).

% Zakładamy, że L_i >= 1, X >= 1
wygrywa(L, K, X) :- member(X, L), X >= K.
wygrywa(L, K, X) :- K =< 1; member(X, L), K1 is K-X, \+wygrywa(L, K1, _).

graj(L, K) :- ruch_gracza(L, K, 0).
sprawdz(K) :- K =< 0.
wyp_licznik(Licznik) :- write('Licznik: [ '), write(Licznik), write(' ]\n').
% Wprowadzanie danych z walidacją
gracz_wejscie(L, X) :- write('Podaj liczbe z listy '), write(L), read(X1),
    (member(X1, L), X=X1; write('Niepoprawna liczba.\n'), gracz_wejscie(L, X)).

% sprawdz(K, gracz) :- K =< 0, write('Wygralem.'); K > 1.
% sprawdz(K, komputer) :- K =< 0, write('Gratulacje, wygrales!'); K > 1.

ruch_gracza(L, K, Licznik) :- sprawdz(K), write('Wygralem.');
    gracz_wejscie(L, X), 
    Licznik1 is Licznik+X, wyp_licznik(Licznik1), K1 is K-X, 
    ruch_komputera(L, K1, Licznik1).

ruch_komputera(L, K, Licznik) :- sprawdz(K), write('Gratulacje, wygrales!');
    (wygrywa(L, K, X); member(X, L)), write('Wybieram >> '), write(X), write(' <<\n'),
    Licznik1 is Licznik+X, wyp_licznik(Licznik1), K1 is K-X,
    ruch_gracza(L, K1, Licznik1).
