#!/usr/bin/env swipl

:-initialization(main, main).

main(Argv):-
  prompt(_,''),
  % init_list(L),
  % write(L),
  read_file(Argv, L),
  % write(L).
  treat_lines(L).

init_list([]).

% --------------- Tratamento de linhas do arquivo --------------- %
treat_lines([]).

treat_lines([X|[]]):-
  write(X),nl.

treat_lines([X,Y|T]):-
  X \= Y,
  write(X),nl,
  append([Y],T,New),
  treat_lines(New).

treat_lines([_,Y|T]):-
  append([Y], T, New),
  treat_lines(New).

% --------------- Fim Tratamento de linhas de Entrada --------------- %
% --------------- Leitura de linhas de Entrada --------------- %

read_file([N], L):-
  read_file_to_string(N, X, []),
  split_string(X, "\n", "\n", L).

read_file([], L):-
  read_line_to_string(user_input, Line),
  Line \= end_of_file,
  % append([], L, New),
  write(Line),nl,
  % write(New),
  append([Line], L,New),
  read_file([],New).

read_file([],_).
