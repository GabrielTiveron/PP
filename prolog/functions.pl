:-multifile(increment/2).
:-multifile(init_list/1).
:-multifile(write_count/3).
:-multifile(write_d/2).
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
