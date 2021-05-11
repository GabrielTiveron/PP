#!/usr/bin/env swipl

:-initialization(main, main).

main(Argv):-
  prompt(_,''),
  treat_entry(Argv, In, Out),
  %% write(In),nl,write(Out),nl,
  read_file(In, L),
  treat_lines(L,Out).

treat_entry([X|[]], I, O):-
  I = X, O = [].

treat_entry([X,Y], I, O):-
  I = X, O = Y,
  open(O, write,Out),
  write(Out, ""),
  close(Out).

init_list([]). % Inicializar lista vazia

% --------------- Tratamento de linhas do arquivo --------------- %
treat_lines([],_).

treat_lines([X|[]],[]):-
  write(X),nl.

treat_lines([X,Y|T],[]):-
  X \= Y,
  write(X),nl,
  append([Y],T,New),
  treat_lines(New,[]).

treat_lines([X|[]], N):-
  open(N, append, Out),
  write(Out, X), write(Out, "\n"),
  close(Out).

treat_lines([X,Y|T], N):-
  X \= Y,
  open(N, append, Out),
  write(Out, X), write(Out, "\n"),
  close(Out),
  append([Y],T,New),
  treat_lines(New,N).

treat_lines([_,Y|T],N):-
  append([Y], T, New),
  treat_lines(New,N).

% --------------- Fim Tratamento de linhas de Entrada --------------- %
% --------------- Leitura de linhas de Entrada --------------- %

read_file(N, L):-             % Leitura de arquivo se fornecido
  read_file_to_string(N, X, []),
  split_string(X, "\n", "\n", L).

read_file([], L):-                      % Leitura via entrada padrão. (Ex. cat)
  read_line_to_string(user_input, Line),
  Line \= end_of_file,
  append([Line], New, L),
  read_file([],New).

read_file([],_).
