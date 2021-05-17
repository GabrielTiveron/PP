#!/usr/bin/env swipl

:-include('parse_args.pl').
:-include('c_flag.pl').
:-include('cd_flag.pl').
:-include('d_flag.pl').
:-include('D_flag.pl').

:-initialization(main, main).

main(Argv):-
  prompt(_,''),
  % write("Antes parse"),nl,
  check_args(Argv,C,D,R,U,Fin,Fout),
  % write("Dps parse"),nl,
  validade_flags(C,D,R,U),
  % write("Dps Validade"),nl,
  validate_io(Fin,Fout),
  % write("Dps validate"),nl,
  write("C = "),write(C),nl,
  write("D = "),write(D),nl,
  write("R = "),write(R),nl,
  write("U = "),write(U),nl,
  write("Fin = "),write(Fin),nl,
  write("Fout = "),write(Fout),nl,
  write("==============================="),nl,
  treat_entry(Fout),
  % write("Antes Ler"),nl,
  %% write(In),nl,write(Out),nl,
  read_file(Fin, L),
  ((C == 1, D == 0, R == 1) -> count_distinct(L,Fout,1);
   (C == 1, D == 0, R == 0) -> count_ap(L,Fout,1);
   (C == 0, D == 1, R == 0) -> show_equals(L,Fout,1);
   (C == 0, D == 0, R == 1) -> show_once(L,Fout,1);
   (C == 0, D == 0, R == 0) -> treat_lines(L,Fout)).

% ------------------- Tratamento de Entrada e Saída ---------------- %
treat_entry([]).
treat_entry(O):-
   open(O, write, Out),
   write(Out,""),close(Out).

% ------------------- Fim Tratamento de Entrada e Saída ---------------- %

% --------------- Comportamento padrão --------------- %
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

% --------------- Fim Comportamento padrão ------------------- %
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
