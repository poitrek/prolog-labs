% d(A, X, B) - uzgadnia B z pochodną wyrażenia A względem X


expr(X) :- number(X); variable(X).
expr(X+Y) :- expr(X), expr(Y).
expr(X-Y) :- expr(X), expr(Y).
expr(X*Y) :- expr(X), expr(Y).
expr(X/Y) :- expr(X), expr(Y).
expr(X^Y) :- expr(X), expr(Y).
expr(-X) :- expr(X).
expr(ln(X)) :- expr(X).
variable(x).
variable(y).
% variable(X) :- atom(X).


% zmienna niezależna od X
d(Y, X, 0) :- expr(X), variable(Y), X \= Y.
% stała niezależna od X
d(N, X, 0) :- expr(X), number(N).
% f. tożsamościowa
d(X, X, 1) :- expr(X).
% (n*f(x))' = n*f'(x)
d(N*W, X, N*DW) :- number(N), d(W, X, DW).
% (x^n)' = nx^(n-1)
d(X^N, X, N*X^(N-1)) :- expr(X), number(N).
% (f(x)^n)' = nf(x)^(n-1)*f'(x)
d(W^N, X, N*W^(N-1)*DW) :- number(N), d(W, X, DW).
% pochodna sumy, różnicy, iloczynu, ilorazu
d(W+U, X, DW+DU) :- d(W, X, DW), d(U, X, DU).
d(W-U, X, DW-DU) :- d(W, X, DW), d(U, X, DU).
d(W*U, X, W*DU+DW*U) :- d(W, X, DW), d(U, X, DU).
d(W/U, X, (W*DU-DW*U)/(U^2)) :- d(W, X, DW), d(U, X, DU).
% logarytm naturalny
d(ln(W), X, DW/W) :- d(W, X, DW).
% (n^f(x))' = n^f(x)*ln(n)*f'(x)
d(N^W, X, N^W*ln(N)*DW) :- number(N), d(W, X, DW).


% Uprość Op(X, Y) --> E jeśli X == Value lub Y == Value. W przeciwnym razie pozostaw
simp_if_equal(X, Y, Op, Value, E) :- (X == Value; Y == Value), OXY =.. [Op, X, Y],
    simp(OXY, E).
% simp_if_equal(X, Y, Op, Value, E) :- X \= Value, Y \= Value, E =.. [Op, X, Y].
% Uprość Op(X, Y) --> E jeśli Y == Value
simp_if_equal_1(X, Y, Op, Value, E) :- Y == Value, OXY =.. [Op, X, Y], simp(OXY, E).
% simp_if_equal_1(X, Y, Op, Value, E) :- Y \= Value, E =.. [Op, X, Y].
% Uprość jeśli Pred(X) == Pred(Y) == true
simp_if_pred(X, Y, Op, Pred, E) :- call(Pred, X), call(Pred, Y), OXY =.. [Op, X, Y],
    simp(OXY, E).
simp_if_pred_1(X, Y, Op, Pred, E) :- call(Pred, Y), OXY =.. [Op, X, Y], simp(OXY, E).
% simp_if_pred(X, Y, Op, Pred, E) :- (\+call(Pred, X); \+call(Pred, Y)), E =.. [Op, X, Y].

% użycie: simp_if_pred(X, Y, +, number, E)

% upraszczanie
simp(X, X) :- variable(X); number(X).
simp(X+Y, Z) :- number(X), number(Y), Z is X+Y.
simp(X-Y, Z) :- number(X), number(Y), Z is X-Y.
simp(X*Y, Z) :- number(X), number(Y), Z is X*Y.
simp(X/Y, Z) :- number(X), number(Y), Z is X/Y.
simp(X^Y, Z) :- number(X), number(Y), Z is X^Y.
% simp(+(M, +(N, X)), E) :- number(M), number(N), \+number(X), simp(+(X, +(M, N)), E), !.
% simp(+(M, +(X, N)), E) :- number(M), number(N), \+number(X), simp(+(X, +(M, N)), E), !.
% simp(X+M+N, E) :- number(M), number(N), \+number(X), simp(M+N+X, E), !.
simp(X+0, XS) :- simp(X, XS), !.
simp(0+X, XS) :- simp(X, XS), !.
simp(X-0, XS) :- simp(X, XS), !.
simp(0-X, -XS) :- simp(X, XS), !.
simp(X*1, XS) :- simp(X, XS), !.
simp(1*X, XS) :- simp(X, XS), !.
simp(0*_, 0).
simp(_*0, 0).
simp(X/1, XS) :- simp(X, XS), !.
simp(X^1, XS) :- simp(X, XS), !.
simp(_^0, 1).
simp(1^_, 1).
simp(X*M+X*N, E) :- number(M), number(N), P is M+N, simp(X*P, E), !.
simp(X*M+N*X, E) :- number(M), number(N), P is M+N, simp(X*P, E), !.
simp(M*X+X*N, E) :- number(M), number(N), P is M+N, simp(X*P, E), !.
simp(M*X+N*X, E) :- number(M), number(N), P is M+N, simp(X*P, E), !.
simp(X*M-X*N, E) :- number(M), number(N), P is M-N, simp(X*P, E), !.
simp(X*M-N*X, E) :- number(M), number(N), P is M-N, simp(X*P, E), !.
simp(M*X-X*N, E) :- number(M), number(N), P is M-N, simp(X*P, E), !.
simp(M*X-N*X, E) :- number(M), number(N), P is M-N, simp(X*P, E), !.
simp(X+Y, E) :- simp(X, XS), simp(Y, YS), (simp_if_equal(XS, YS, +, 0, E); 
    simp_if_pred(XS, YS, +, number, E); E=XS+YS), !.
simp(X-Y, E) :- simp(X, XS), simp(Y, YS), (simp_if_equal(XS, YS, -, 0, E);
    simp_if_pred(XS, YS, -, number, E); E=XS-YS), !.
simp(X*Y, E) :- simp(X, XS), simp(Y, YS), (simp_if_equal(XS, YS, *, 1, E); 
    simp_if_pred(XS, YS, *, number, E); E=XS*YS), !.
simp(X/Y, E) :- simp(X, XS), simp(Y, YS), (simp_if_equal_1(XS, YS, /, 1, E); 
    simp_if_pred_1(XS, YS, /, number, E); E=XS/YS), !.
simp(X^Y, E) :- simp(X, XS), simp(Y, YS), (simp_if_equal_1(XS, YS, ^, 1, E); 
    simp_if_pred_1(XS, YS, ^, number, E); E=XS^YS), !.
