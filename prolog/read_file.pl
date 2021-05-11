#!/usr/bin/env swipl
:-initialization(main, main).

main(Argv):-
  prompt(_,''),
  read_file(Argv, L),
  write(L),
  nl.

read_file([N], L):-
  % pahrase_from_file(X, N).
  read_file_to_string(N, X, []),
  split_string(X, "\n", "\n", L).
