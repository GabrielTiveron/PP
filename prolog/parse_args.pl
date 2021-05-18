% #!/usr/bin/env swipl
% :-include('functions.pl').
% % %
% :-initialization(main, main).
%
% main(Argv):-
%   prompt(_,''),
%   % C is 0, D is 0, R is 0,
%   % init_list(Fin),init_list(Fout),
%   % write("Antes parse"),nl,
%   check_args(Argv,C,D,R, U,G,Ar,Fin,Fout),
%   % write("Dps parse"),nl,
%   validate_io(Fin, Fout),
%   validade_flags(C,D,R,U,G,Ar),
%   write("C = "),write(C),nl,
%   write("D = "),write(D),nl,
%   write("R = "),write(R),nl,
%   write("U = "),write(U),nl,
%   write("G = "),write(G),nl,
%   write("Ar = "),write(Ar),nl,
%   write("Fin = "),write(Fin),nl,
%   write("Fout = "),write(Fout),nl.

% is_empty()


validade_flags(C,D,R,U,G,Ar):-
  (var(C) -> C is 0;C is 1),
  (var(D) -> D is 0;D is 1),
  (var(R) -> R is 0;R is 1),
  (var(U) -> U is 0;U is 1),
  (var(G) -> G is 0;
            (G == 1;G == 2;
             G == 3;G == 4)),
  (var(Ar) -> Ar is 0;
             (Ar == 0; Ar == 1;
              Ar == 2; Ar == 3)).

validate_io(I,O):-
  (var(I) -> init_list(I);true),
  (var(O) -> init_list(O);true).

check_args([],_,_,_,_,_,_,_,_).
% check_args([H|T], C, D, R, U,Fin,Fout):-
%   atom_chars(H, X),
%   X = [L|Xs],
%   L == '-',
%   append([Xs], T, New),
  % check_args(New, C, D, R, U,Fin,Fout).
check_args([H|T], C, D, R, U,G,Ar,Fin,Fout):-
  sub_string(H, B, L, A,'--'),
  [B, L] = [0,2],
  (A == 4; A == 7),
  first_class(H),
  check_args(T,C,D,R, U,G,Ar,Fin,Fout).

check_args(['--all-repeated'|T],C,D,R, U,G,Ar,Fin,Fout):-
  Ar is 0, D is 1,
  check_args(T,C,D,R, U,G,Ar,Fin,Fout).

check_args(['--all-repeated=none'|T],C,D,R, U,G,Ar,Fin,Fout):-
  Ar is 0, D is 1,
  check_args(T,C,D,R, U,G,Ar,Fin,Fout).

check_args(['--all-repeated=prepend'|T],C,D,R, U,G,Ar,Fin,Fout):-
  Ar is 3, D is 1,
  check_args(T,C,D,R, U,G,Ar,Fin,Fout).

check_args(['--all-repeated=separate'|T],C,D,R, U,G,Ar,Fin,Fout):-
  Ar is 1, D is 1,
  check_args(T,C,D,R, U,G,Ar,Fin,Fout).

check_args(['--group'|T],C,D,R, U,G,Ar,Fin,Fout):-
  G is 1,
  check_args(T,C,D,R, U,G,Ar,Fin,Fout).


check_args(['--group=prepend'|T],C,D,R, U,G,Ar,Fin,Fout):-
  G is 3,
  check_args(T,C,D,R, U,G,Ar,Fin,Fout).

check_args(['--group=append'|T],C,D,R, U,G,Ar,Fin,Fout):-
  G is 2,
  check_args(T,C,D,R, U,G,Ar,Fin,Fout).

check_args(['--group=separate'|T],C,D,R, U,G,Ar,Fin,Fout):-
  G is 1,
  check_args(T,C,D,R, U,G,Ar,Fin,Fout).

check_args(['--group=both'|T],C,D,R, U,G,Ar,Fin,Fout):-
  G is 4,
  check_args(T,C,D,R, U,G,Ar,Fin,Fout).

check_args(['-c'| T], C, D, R, U,G,Ar,Fin,Fout):-
  C is 1,
  check_args(T, C, D, R, U,G,Ar,Fin,Fout).

check_args(['--count'| T], C, D, R, U,G,Ar,Fin,Fout):-
  C is 1,
  check_args(T, C, D, R, U,G,Ar,Fin,Fout).

check_args(['-d'| T], C, D, R, U,G,Ar,Fin,Fout):-
  R is 1,
  check_args(T, C, D, R, U,G,Ar,Fin,Fout).

check_args(['--repeated'| T], C, D, R, U,G,Ar,Fin,Fout):-
  R is 1,
  check_args(T, C, D, R, U,G,Ar,Fin,Fout).

check_args(['-D'| T], C, D, R, U,G,Ar,Fin,Fout):-
  D is 1,
  check_args(T, C, D, R, U,G,Ar,Fin,Fout).

check_args(['-cd'| T], C, D, R, U,G,Ar,Fin,Fout):-
  R is 1,
  C is 1,
  check_args(T, C, D, R, U,G,Ar,Fin,Fout).

check_args(['-dc'| T], C, D, R, U,G,Ar,Fin,Fout):-
  R is 1,
  C is 1,
  check_args(T, C, D, R, U,G,Ar,Fin,Fout).

check_args(['-u'| T],C,D,R,U,G,Ar,Fin,Fout):-
  write(T),nl,
  U is 1,
  check_args(T, C, D, R, U,G,Ar,Fin,Fout).

check_args(['--unique'| T],C,D,R,U,G,Ar,Fin,Fout):-
  U is 1,
  check_args(T, C, D, R, U,G,Ar,Fin,Fout).

check_args(['-dcD'| T], C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, D is 1, R is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).

check_args(['-cdD'| T], C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, D is 1, R is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).

check_args(['-Ddc'| T], C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, D is 1, R is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).

check_args(['-Dcd'| T], C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, D is 1, R is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).

check_args(['-dDc'| T], C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, D is 1, R is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).

check_args(['-cDd'| T], C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, D is 1, R is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).

check_args(['-cud'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).

check_args(['-cdu'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).

check_args(['-ucd'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).

check_args(['-udc'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).

check_args(['-dcu'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).

check_args(['-duc'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).

check_args(['-ud'|T],C,D,R,U,G,Ar,Fin,Fout):-
  R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).

check_args(['-du'|T],C,D,R,U,G,Ar,Fin,Fout):-
  R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).

check_args(['-Du'|T],C,D,R,U,G,Ar,Fin,Fout):-
  D is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).

check_args(['-uD'|T],C,D,R,U,G,Ar,Fin,Fout):-
  D is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).

check_args(['-cu'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).

check_args(['-uc'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).

check_args(['-udDc'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, D is 1, R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).
check_args(['-duDc'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, D is 1, R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).
check_args(['-Dudc'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, D is 1, R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).
check_args(['-uDdc'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, D is 1, R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).
check_args(['-dDuc'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, D is 1, R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).
check_args(['-Dduc'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, D is 1, R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).
check_args(['-Ddcu'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, D is 1, R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).
check_args(['-dDcu'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, D is 1, R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).
check_args(['-cDdu'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, D is 1, R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).
check_args(['-Dcdu'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, D is 1, R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).
check_args(['-dcDu'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, D is 1, R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).
check_args(['-cdDu'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, D is 1, R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).
check_args(['-cuDd'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, D is 1, R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).
check_args(['-ucDd'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, D is 1, R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).
check_args(['-Dcud'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, D is 1, R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).
check_args(['-cDud'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, D is 1, R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).
check_args(['-uDcd'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, D is 1, R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).
check_args(['-Ducd'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, D is 1, R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).
check_args(['-ducD'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, D is 1, R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).
check_args(['-udcD'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, D is 1, R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).
check_args(['-cduD'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, D is 1, R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).
check_args(['-dcuD'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, D is 1, R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).
check_args(['-ucdD'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, D is 1, R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).
check_args(['-cudD'|T],C,D,R,U,G,Ar,Fin,Fout):-
  C is 1, D is 1, R is 1, U is 1,
  check_args(T,C,D,R,U,G,Ar,Fin,Fout).

check_args([H|T], C, D, R,U,G,Ar,Fin, Fout):-
  atom_chars(H, X),
  X = [L|_],
  % write(L),nl,
  L \= '-',
  % write(X),nl,
  % write("T = "),write(T),nl,
  % is_empty(Fin, In), is_empty(Fout)
  (var(Fin) -> string_chars(Fin, X),check_args(T, C, D, R, U, G,Ar, H, Fout);
  var(Fout) -> string_chars(Fout, X),check_args(T, C, D, R, U,G,Ar,Fin, H);
  end_args(H)).
  % string_chars(Fin, X),
  % write(Fin),nl,
  % write(T),nl,
  % check_args(T, C, D, R, Fin, Fout).

check_args([H|_], _, _, _, _, _,_,_):-
  % write("T = "),write(T),nl,
  write('uniq: invalid option -- \''),write(H),write("'"),nl,
  write("Try 'uniq --help' for more information."),
  nl,halt(0).

end_args(X):-
  write("uniq: extra operand ‘"),
  write(X),write("’"),nl,
  write("Try 'uniq --help' for more information."),nl,
  halt(0).

meaningless():-
  write("uniq: printing all duplicated lines and repeat counts is meaningless"),nl,
  write("Try 'uniq --help' for more information."),nl, halt(0).

first_class('--help'):-
  write("Usage: uniq [OPTION]... [INPUT [OUTPUT]]
Filter adjacent matching lines from INPUT (or standard input),
writing to OUTPUT (or standard output).

With no options, matching lines are merged to the first occurrence.

Mandatory arguments to long options are mandatory for short options too.
  -c, --count           prefix lines by the number of occurrences
  -d, --repeated        only print duplicate lines, one for each group
  -D                    print all duplicate lines
      --all-repeated[=METHOD]  like -D, but allow separating groups
                                 with an empty line;
                                 METHOD={none(default),prepend,separate}
  -f, --skip-fields=N   avoid comparing the first N fields
      --group[=METHOD]  show all items, separating groups with an empty line;
                          METHOD={separate(default),prepend,append,both}
  -i, --ignore-case     ignore differences in case when comparing
  -s, --skip-chars=N    avoid comparing the first N characters
  -u, --unique          only print unique lines
  -z, --zero-terminated     line delimiter is NUL, not newline
  -w, --check-chars=N   compare no more than N characters in lines
      --help     display this help and exit
      --version  output version information and exit

A field is a run of blanks (usually spaces and/or TABs), then non-blank
characters.  Fields are skipped before chars.

Note: 'uniq' does not detect repeated lines unless they are adjacent.
You may want to sort the input first, or use 'sort -u' without 'uniq'.
Also, comparisons honor the rules specified by 'LC_COLLATE'.

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Full documentation at: <https://www.gnu.org/software/coreutils/uniq>
or available locally via: info '(coreutils) uniq invocation'
"),halt(0).
first_class('--version'):-
  write("uniq (GNU coreutils) 8.30
Copyright (C) 2018 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by Richard M. Stallman and David MacKenzie.
"),halt(0).
first_class(_).
