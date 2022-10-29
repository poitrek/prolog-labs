
% Wywoływanie display:
% working_directory(X, X), concat(X, 'peano - teoria.txt', Y), display(Y).

display(FileName) :- open(FileName, read, F), process_char(F).

process_char(F) :- at_end_of_stream(F), !, close(F).
process_char(F) :- get_char(F, C), put_char(C), process_char(F).


% Użycie:
% working_directory(Dir, Dir), concat(Dir, 'stuff.txt', FilePath), split2(FilePath, 'stuff1.txt', 'stuff2.txt').

split2(FileName, FileNameA, FileNameB) :-
    open(FileName, read, F), open(FileNameA, write, FA), open(FileNameB, write, FB),
    process_stuff(F, FA, FB).

process_stuff(F, FA, FB) :- at_end_of_stream(F), !, close(F), close(FA), close(FB).
process_stuff(F, FA, FB) :- get_char(F, C), put_char(FA, C), process_stuff(F, FB, FA).

% Użycie:
% working_directory(Dir, Dir), concat(Dir, 'stuff1.txt', File1), concat(Dir, 'stuff2.txt', File2), join2(File1, File2, 'stuff_joined.txt').

join2(FileNameA, FileNameB, FileName) :- 
    open(FileName, write, F), open(FileNameA, read, FA), open(FileNameB, read, FB),
    join_next(FA, FB, F).

join_next(FA, FB, F) :- (at_end_of_stream(FA); at_end_of_stream(FB)),
    !, close(F), close(FA), close(FB).
join_next(FA, FB, F) :- get_char(FA, C), put_char(F, C), join_next(FB, FA, F).


% Wypisz znaki o kodach ASCII z zakresu A, B
putchars(A, B) :- A > B; A =< B, put(A), A1 is A+1, putchars(A1, B).

% Usuń z zawartości pliku wystąpienia określonego znaku, np. spacji
% working_directory(Dir, Dir), concat(Dir, 'stuff.txt', FilePath),
%   erase_from_file(FilePath, ' ', 'stuff_erased.txt').

erase_from_file(InFileName, Char, OutFileName) :- open(InFileName, read, InStream),
    open(OutFileName, write, OutStream), rewrite_next(InStream, Char, OutStream).

rewrite_next(InStream, _, OutStream) :- at_end_of_stream(InStream), !,
    close(InStream), close(OutStream).

rewrite_next(InStream, Char, OutStream) :- get_char(InStream, C),
    (C == Char; C \= Char, put_char(OutStream, C)),
    rewrite_next(InStream, Char, OutStream).

% kartkowka
