:-include('functions.pl').
% ------------------- Tratamento com as flags -c ---------------- %
count_ap([],_,_).

count_ap([X|[]], [], Count):-
  tab(6),
  write(Count),
  write(" "),
  write(X),nl.

count_ap([X,Y|T],[],Count):-
  X == Y,
  increment(Count, NewC),
  append([Y], T, New),
  count_ap(New,[],NewC).

count_ap([X,Y|T],[],Count):-
  X \= Y,
  write_count(X,[],Count),
  append([Y],T,New),
  count_ap(New,[],1).

count_ap([X|[]], N,Count):-
  write_count(X,N,Count).

count_ap([X,Y|T],N,Count):-
  X == Y,
  increment(Count, NewC),
  append([Y], T, New),
  count_ap(New,N,NewC).

count_ap([X,Y|T], N, Count):-
  X \= Y,
  write_count(X,N,Count),
  append([Y],T,New),
  count_ap(New,N,1).

% count_ap([_,Y|T],N,_):-
%   append([Y], T, New),
%   count_ap(New,N, 0).
