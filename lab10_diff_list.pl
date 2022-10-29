app(A-B, B-C, A-C).
app1(A:B, B:C, A:C).

% A.

% rot([H|T], W) :- append(T, [H], W).
% rot2(A-B, [])

% rotate([a, b, c, d, e|X]-X, [b, c, d, e, a|Y]-Y)
rotate([H|T]-Z, Lrot-Zrot) :- app(T-Z, [H|Z1]-Z1, Lrot-Zrot).

rot2([H|T]-Z, T-Z1) :- Z = [H|Z1].
rot3([H|T]-[H|Z], T-Z).

% B.

% Inne

% Odwrócenie listy
% rev([a, b, c, d | X]-X, [d, c, b, a | Y]-Y).
