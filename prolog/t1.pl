#!/usr/bin/env swipl

:-include('parse_args.pl').
:-include('c_flag.pl').
:-include('cd_flag.pl').
:-include('d_flag.pl').
:-include('D_flag.pl').
:-include('u_flag.pl').
:-include('group_flag.pl').

:-initialization(main, main).

main(Argv):-
  prompt(_,''),
  check_args(Argv,C,D,R,U,G,Ar,Fin,Fout),
  validade_flags(C,D,R,U,G,Ar),
  validate_io(Fin,Fout),
  read_file(Fin, L),
  ((C == 1, D == 0, R == 1, U == 0) -> count_distinct(L,Fout,1);
    (G > 0, (C == 1; D == 1; R == 1; U == 1; Ar > 0)) -> exclusive();
    (C == 1, D == 1) -> meaningless();
    (R == 1, U == 1) -> halt(0);
    (C == 1, D == 0, R == 0, U == 0) -> count_ap(L,Fout,1);
    (C == 0, D == 1, R == 0) -> (Ar == 3 -> pre_file(Fout);true),
                                            show_equals(L,Fout,1,Ar);
    (C == 0, D == 0, R == 1) -> show_once(L,Fout,1);
    (C == 0, D == 0, R == 0, U == 1) -> show_unique(L,Fout,1);
    (C == 1, D == 0, R == 0, U == 1) -> count_unique(L,Fout,1);
    (C == 0, D == 0, R == 0, U == 0, G > 0) ->
                                            ( G >= 3 -> pre_file(Fout);true),
                                            group_lines(L,Fout,G);
    treat_lines(L,Fout)).

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

read_file([], L):-                      % Leitura via entrada padrão. (Ex. cat)
  % write("Entrei certo"),nl,
  read_line_to_string(user_input, Line),
  Line \= end_of_file,
  append([Line], New, L),
  read_file([],New).

read_file([],_).

read_file(N, L):-             % Leitura de arquivo se fornecido
  % write("Entrei errado"),nl,
  read_file_to_string(N, X, []),
  split_string(X, "\n", "\n", L).
