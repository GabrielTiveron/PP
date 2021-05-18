:-multifile(increment/2).
:-multifile(init_list/1).
:-multifile(write_count/3).
:-multifile(write_d/2).
:-multifile(write_d/3).
:-multifile(count_nothing/0).
:-multifile(exclusive/0).
% ------------------- Increment ---------------------------------- %
increment(X, X1):-
  X1 is X+1.
% ------------------- Init List ---------------------------------- %
init_list([]).

%-------------------- Write count -------------------------------- %
write_count(X, [], Count):-
  tab(6),
  write(Count),
  write(" "),
  write(X),nl.

write_count(X,N,Count):-
  open(N, append, Out),
  write(Out, "      "),
  write(Out, Count), write(Out," "),
  write(Out, X), write(Out, "\n"),
  close(Out).

%-------------------- Write -------------------------------- %
write_d(X,[]):-
  write(X),
  nl.
write_d(X,N):-
  open(N, append, Out),
  write(Out, X), write(Out, "\n"),
  close(Out).

write_d(X,[],G):-
  write(X),nl,
  ((G > 0) -> nl;true).
write_d(X,N,G):-
  open(N, append, Out),
  write(Out, X), write(Out, "\n"),
  ((G > 0) -> write(Out, "\n");true),
  close(Out).


%---------------- count unique distinct --------------------- %
count_nothing():-
  halt(0).

% --------------- --group exclusion ------------------------- %
exclusive():-
  write("uniq: --group is mutually exclusive with -c/-d/-D/-u"),nl,
  write("Try 'uniq --help' for more information."),nl,
  halt(0).
