:-include('functions.pl').
% #!/usr/bin/env swipl
%
% :-initialization(main, main).
%
% main(Argv):-
%   prompt(_,''),
%   % C is 0, D is 0, R is 0,
%   % init_list(Fin),init_list(Fout),
%   check_args(Argv,C,D,R, U,Fin,Fout),
%   validate_io(Fin, Fout),
%   validade_flags(C,D,R),
%   write("C = "),write(C),nl,
%   write("D = "),write(D),nl,
%   write("R = "),write(R),nl,
%   write("Fin = "),write(Fin),nl,
%   write("Fout = "),write(Fout),nl.

% is_empty()

validade_flags(C,D,R,U):-
  (var(C) -> C is 0;C is 1),
  (var(D) -> D is 0;D is 1),
  (var(R) -> R is 0;R is 1),
  (var(U) -> U is 0;U is 1).

validate_io(I,O):-
  (var(I) -> init_list(I);true),
  (var(O) -> init_list(O);true).

check_args([],_,_,_,_,_).
check_args([H|T], C, D, R, U,Fin,Fout):-
  sub_string(H, B, L, A,'--'),
  [B, L] = [0,2],
  (A == 4; A == 7),
  first_class(H),
  check_args(T,C,D,R, U,Fin,Fout).

check_args(['-c'| T], C, D, R, U,Fin,Fout):-
  C is 1,
  check_args(T, C, D, R, U,Fin,Fout).

check_args(['--count'| T], C, D, R, U,Fin,Fout):-
  C is 1,
  check_args(T, C, D, R, U,Fin,Fout).

check_args(['-d'| T], C, D, R, U,Fin,Fout):-
  R is 1,
  check_args(T, C, D, R, U,Fin,Fout).

check_args(['--repeated'| T], C, D, R, U,Fin,Fout):-
  R is 1,
  check_args(T, C, D, R, U,Fin,Fout).

check_args(['-D'| T], C, D, R, U,Fin,Fout):-
  D is 1,
  check_args(T, C, D, R, U,Fin,Fout).

check_args(['-cd'| T], C, D, R, U,Fin,Fout):-
  R is 1,
  C is 1,
  check_args(T, C, D, R, U,Fin,Fout).

check_args(['-dc'| T], C, D, R, U,Fin,Fout):-
  R is 1,
  C is 1,
  check_args(T, C, D, R, U,Fin,Fout).

check_args(['-u'| T],C,D,R,U,Fin,Fout):-
  U is 1,
  check_args(T, C, D, R, U,Fin,Fout).

check_args(['--unique'| T],C,D,R,U,Fin,Fout):-
  U is 1,
  check_args(T, C, D, R, U,Fin,Fout).

check_args(['-dcD'| _], _,_,_,_,_,_):-
  meaningless().

check_args(['-cdD'| _], _,_,_,_,_,_):-
  meaningless().

check_args(['-Ddc'| _], _,_,_,_,_,_):-
  meaningless().

check_args(['-Dcd'| _], _,_,_,_,_,_):-
  meaningless().

check_args(['-dDc'| _], _,_,_,_,_,_):-
  meaningless().

check_args(['-cDd'| _], _,_,_,_,_,_):-
  meaningless().

check_args([H|T], C, D, R, Fin, Fout):-
  atom_chars(H, X),
  X = [L|_],
  % write(L),nl,
  L \= '-',
  % write(X),nl,
  % write("T = "),write(T),nl,
  % is_empty(Fin, In), is_empty(Fout)
  (var(Fin) -> string_chars(Fin, X),check_args(T, C, D, R, U, H, Fout);
  var(Fout) -> string_chars(Fout, X),check_args(T, C, D, R, U,Fin, H);
  end_args(H)).
  % string_chars(Fin, X),
  % write(Fin),nl,
  % write(T),nl,
  % check_args(T, C, D, R, Fin, Fout).

check_args([H|_], _, _, _, _, _):-
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
