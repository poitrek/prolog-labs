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


% zmienna niezależna od X
d(Y, X, 0) :- expr(X), variable(Y), X \= Y.
% stała niezależna od X
d(N, X, 0) :- expr(X), number(N).
% f. tożsamościowa
d(X, X, 1) :- expr(X).
% (n*f(x))' = n*f'(x)
d(N*W, X, N*DW) :- number(N), d(W, X, DW), !.
% (x^n)' = nx^(n-1)
d(X^N, X, N*X^(N-1)) :- expr(X), number(N), !.
% (f(x)^n)' = nf(x)^(n-1)*f'(x)
d(W^N, X, N*W^(N-1)*DW) :- number(N), d(W, X, DW).
% pochodna sumy, różnicy, iloczynu, ilorazu
d(W+U, X, DW+DU) :- d(W, X, DW), d(U, X, DU).
d(W-U, X, DW-DU) :- d(W, X, DW), d(U, X, DU).
d(W*U, X, W*DU+DW*U) :- d(W, X, DW), d(U, X, DU), !.
d(W/U, X, (W*DU-DW*U)/(U^2)) :- d(W, X, DW), d(U, X, DU).
% logarytm naturalny
d(ln(W), X, DW/W) :- d(W, X, DW).
% (n^f(x))' = n^f(x)*ln(n)*f'(x)
d(N^W, X, N^W*ln(N)*DW) :- number(N), d(W, X, DW).
d(sin(W), X, cos(W)*DW) :- d(W, X, DW).
d(cos(W), X, -sin(W)*DW) :- d(W, X, DW).

simp(X, Y) :- simp(X, 0, Y).
% upraszczanie
simp(X, _, X) :- variable(X); number(X).
simp(X+Y, _, Z) :- number(X), number(Y), Z is X+Y, !.
simp(X-Y, _, Z) :- number(X), number(Y), Z is X-Y, !.
simp(X*Y, _, Z) :- number(X), number(Y), Z is X*Y, !.
simp(X/Y, _, Z) :- number(X), number(Y), Z is X/Y, !.
simp(X^Y, _, Z) :- number(X), number(Y), Z is X^Y, !.
simp(+(M, +(N, X)), F, E) :- number(M), number(N), \+number(X), simp(+(X, +(M, N)), F, E), !.
simp(+(M, +(X, N)), F, E) :- number(M), number(N), \+number(X), simp(+(X, +(M, N)), F, E), !.
% simp(X+M+N, E) :- number(M), number(N), \+number(X), simp(M+N+X, E), !.
simp(X+0, F, XS) :- simp(X, F, XS), !.
simp(0+X, F, XS) :- simp(X, F, XS), !.
simp(X-0, F, XS) :- simp(X, F, XS), !.
simp(0-X, F, -XS) :- simp(X, F, XS), !.
simp(X*1, F, XS) :- simp(X, F, XS), !.
simp(1*X, F, XS) :- simp(X, F, XS), !.
simp(0*_, _, 0) :- !.
simp(_*0, _, 0) :- !.
simp(X/1, F, XS) :- simp(X, F, XS), !.
simp(X^1, F, XS) :- simp(X, F, XS), !.
simp(_^0, _, 1) :- !.
simp(1^_, _, 1) :- !.
simp(X*M+X*N, F, E) :- number(M), number(N), P is M+N, simp(X*P, F, E), !.
simp(X*M+N*X, F, E) :- number(M), number(N), P is M+N, simp(X*P, F, E), !.
simp(M*X+X*N, F, E) :- number(M), number(N), P is M+N, simp(X*P, F, E), !.
simp(M*X+N*X, F, E) :- number(M), number(N), P is M+N, simp(X*P, F, E), !.
simp(X*M-X*N, F, E) :- number(M), number(N), P is M-N, simp(X*P, F, E), !.
simp(X*M-N*X, F, E) :- number(M), number(N), P is M-N, simp(X*P, F, E), !.
simp(M*X-X*N, F, E) :- number(M), number(N), P is M-N, simp(X*P, F, E), !.
simp(M*X-N*X, F, E) :- number(M), number(N), P is M-N, simp(X*P, F, E), !.
simp(X+Y, 0, E) :- simp(X, 0, XS), simp(Y, 0, YS), (simp(XS+YS, 1, E); E=XS+YS), !.
simp(X-Y, 0, E) :- simp(X, 0, XS), simp(Y, 0, YS), (simp(XS-YS, 1, E); E=XS-YS), !.
simp(X*Y, 0, E) :- simp(X, 0, XS), simp(Y, 0, YS), (simp(XS*YS, 1, E); E=XS*YS), !.
simp(X/Y, 0, E) :- simp(X, 0, XS), simp(Y, 0, YS), (simp(XS/YS, 1, E); E=XS/YS), !.
simp(X^Y, 0, E) :- simp(X, 0, XS), simp(Y, 0, YS), (simp(XS^YS, 1, E); E=XS^YS), !.
simp(X+Y, 1, X+Y).
simp(X-Y, 1, X-Y).
simp(X*Y, 1, X*Y).
simp(X/Y, 1, X/Y).
simp(X^Y, 1, X^Y).
simp(-X, F, -E) :- simp(X, F, E).
simp(ln(X), F, ln(E)) :- simp(X, F, E).
simp(sin(X), F, sin(E)) :- simp(X, F, E).
simp(cos(X), F, cos(E)) :- simp(X, F, E).