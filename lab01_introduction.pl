% definiujemy plcie
m(jacek). m(czarek). m(roman). m(karol). m(witold). m(franek).
m(jan). m(mariusz). m(onufry). m(michal).
k(ala). k(ola). k(magda). k(wanda). k(kunegunda). k(zuzanna).
k(aneta). k(ewa). k(nina). k(kamila).

% definiujemy mezow kobiet
maz(jacek, ala). maz(karol, wanda). maz(witold, kunegunda).
maz(mariusz, magda). maz(onufry, ola). maz(blazej, kamila).

% definiujemy dzieci kobiet
dziecko(ola, ala). dziecko(magda, ala). dziecko(michal, ala).
dziecko(czarek, wanda). dziecko(roman, wanda).
dziecko(franek, kunegunda). dziecko(zuzanna, kunegunda).
dziecko(onufry, magda). dziecko(aneta, magda).
dziecko(ewa, ola). dziecko(nina, ola).
dziecko(magda, kamila).

% dziecko - Y jest mezczyzna
dziecko(X, Y) :- maz(Y, Z), dziecko(X, Z).

syn(X,Y) :- m(X), dziecko(X,Y).
corka(X,Y) :- k(X), dziecko(X,Y).
wnuk(X,Y) :- dziecko(X,Z), dziecko(Z,Y).
% X jest dziadkiem Y
dziadek(X, Y) :- wnuk(Y, X), m(X).
% X jest czyimkolwiek dziadkiem
dziadek(X) :- dziadek(X, _).
% X jest potomkiem Y
potomek(X, Y) :- dziecko(X, Y); dziecko(X, Z), potomek(Z, Y).
