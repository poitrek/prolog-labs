% Przykładowy predykat (funkcja)
prefiks([], _).
prefiks([H|T1], [H|T2]) :- prefiks(T1, T2).

% Zamiana elementów w liście
% list_subst([a, b, b, c, d], b, z, [a, z, z, c, d]) = true
list_subst([], _, _, []).
list_subst([H | T], H, X, [X | T1]) :- list_subst(T, H, X, T1).
list_subst([H1 | T], H, X, [H1 | T1]) :- H1 \= H, list_subst(T, H, X, T1).
% Też zadziała zamiast powyższego
% list_subst([H1 | T], H, X, [H1 | T1]) :- list_subst(T, H, X, T1).

print_struct(X) :- functor(X, F, _), write('Functor: '), write(F), nl(), X =.. [_|Args],
    write('Arguments: '), write(Args).

% Zad. 1

% Tylko dla jednopoziomowej struktury T
% subst(T, A, V, R) :- T =.. TL, list_subst(TL, A, V, RL), R =.. RL.

subst(T, A, V, R) :- 
    functor(T, Fun, _), (Fun == A, NewFun = V; Fun \= A, NewFun = Fun), % Zamień funktor jeśli trzeba
    T =.. [_ | Args], subst_all(Args, A, V, RArgs), % Wywołaj podstawienie dla listy wszystkich argumentów
    R =.. [NewFun | RArgs]. % Utwórz wynikową strukturę

% Podstawienie dla listy wyrażeń
subst_all([], _, _, []).
subst_all([H | T], A, V, [RH | RT]) :- subst(H, A, V, RH), subst_all(T, A, V, RT).

% Zad. 2

apply(F, S, W) :- S =.. [Fun | Args], apply_all(F, Args, F_Args), W =.. [Fun | F_Args].

apply_all(_, [], []).
apply_all(F, [H | T], [FH | FT]) :- FH =.. [F, H], apply_all(F, T, FT).

% Rozdziela listę na N listę pierwszych elementów oraz listę pozostałych
cut(L, 0, [], L).
cut([H | T], N, [H | T1], L2) :- N > 0, N1 is N-1, cut(T, N1, T1, L2).

apply(F, N, S, W) :- S =.. [Fun | Args], apply_n(F, N, Args, F_Args), W =.. [Fun | F_Args].

apply_n(_, _, [], []).
apply_n(F, N, L, [H_FL | T_FL]) :- cut(L, N, PrefL, PostL), H_FL =.. [F | PrefL],
    apply_n(F, N, PostL, T_FL).
