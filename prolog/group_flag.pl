:-include('functions.pl').

pre_file([]):-
  nl.

pre_file(N):-
  open(N, append, Out),
  write(Out, "\n"),
  close(Out).

group_lines([],_,_).

group_lines([X|[]],[],G):-
  write(X),nl,
  ((G == 2; G == 4) -> nl;true).

group_lines([X,Y|T],[],G):-
  X == Y,
  %(G == 1 -> nl;true),
  write_d(X,[],0),
  append([Y],T,New),
  group_lines(New,[],G).

group_lines([X,Y|T],[],G):-
  X \= Y,
  write_d(X,[],G),
  append([Y],T,New),
  group_lines(New,[],G).

group_lines([X|[]], N,G):-
  open(N, append, Out),
  write(Out, X), write(Out, "\n"),
  ((G == 2; G == 4)-> write(Out,"\n");true),
  close(Out).

group_lines([X,Y|T], N,G):-
  X \= Y,
  write_d(X,N,G),
  append([Y],T,New),
  group_lines(New,N,G).

group_lines([X,Y|T],N,G):-
  write_d(X,N,0),
  append([Y], T, New),
  group_lines(New,N,G).
