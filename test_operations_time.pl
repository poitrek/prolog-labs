:-use_module(library(yall)).
p(1,a).
p(2,b).

suma1(0, 0).
suma1(N, S) :- N > 0, N1 is N-1, suma1(N1, S1), S is S1+N.

suma(N, S) :- suma(N, 0, S).
suma(0, A, A).
suma(N, A, S) :- N > 0, A1 is A+N, N1 is N-1, suma(N1, A1, S).

% wersja 0
repeat(_, 0, []).
repeat(El, N, [El|Tr]) :- N > 0, N1 is N - 1, repeat(El, N1, Tr).
% wersja 1 (gorsza)
repeat1(_, N, []) :- N is 0.
repeat1(El, N, [El|Tr]) :- N > 0, repeat(El, N-1, Tr).
% repeat(El, W, H, X) - repeat El in a WxH array
repeat(El, W, 0, [S]) :- repeat(El, W, S).
repeat(El, W, H, [SH|ST]) :- H > 0, H1 is H-1, repeat(El, W, SH), repeat(El, W, H1, ST).


% Fibonacci - z akumulatorem
fib(N, F) :- fib(N, 0, 1, F).
fib(0, F1, F2, F1).
fib(N, F1, F2, F) :- N>0, N1 is N-1, F11 is F2, F12 is F1+F2, fib(N1, F11, F12, F).
% Fibonacci naiwnie
fib1(0, 0).
fib1(1, 1).
fib1(N, F) :- N > 0, N1 is N-1, N2 is N-2, fib1(N1, F1), fib1(N2, F2), F is F1+F2.

% Ustaw nową wartość tablicy
set([_|LT], El, 0, [El|LT]).
set([LH|LT], El, N, [LH|NLT]) :- N > 0, N1 is N-1, set(LT, El, N1, NLT).

run_test(N) :-
    repeat(a, N, L), N2 is N // 2,
    statistics(walltime, [TimeSinceStart | [TimeSinceLastCall]]),
    set(L, b, N2, L1),
    statistics(walltime, [NewTimeSinceStart | [ExecutionTime]]),
    write('Execution took '), write(ExecutionTime), write(' ms.'), nl.
