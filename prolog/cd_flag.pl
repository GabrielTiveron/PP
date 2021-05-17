:-include('functions.pl').
% ------------------- Tratamento com as flags -cd ---------------- %
count_distinct([],_,_).

count_distinct([X|[]], [], Count):-
  (Count > 1 ->
    write_count(X,[],Count);Count == 1).

count_distinct([X,Y|T],[],Count):-
  X == Y,
  increment(Count, NewC),
  append([Y], T, New),
  count_distinct(New,[],NewC).

count_distinct([X,Y|T],[],Count):-
  X \= Y,
  (Count > 1 ->
    write_count(X,[],Count),
    append([Y],T,New),
    count_distinct(New,[],1)
  ;append([Y],T,New), count_distinct(New,[],1)).

count_distinct([X|[]], N,Count):-
  (Count > 1 ->
    write_count(X,N,Count);Count == 1).

count_distinct([X,Y|T],N,Count):-
  X == Y,
  increment(Count, NewC),
  append([Y], T, New),
  count_distinct(New,N,NewC).

count_distinct([X,Y|T], N, Count):-
  X \= Y,
  (Count > 1 ->
    write_count(X,N,Count),
    append([Y],T,New),
    count_distinct(New,N,1)
  ;append([Y],T,New), count_distinct(New,N,1)).

count_distinct([_,Y|T],N,_):-
  append([Y], T, New),
  count_distinct(New,N, 0).
