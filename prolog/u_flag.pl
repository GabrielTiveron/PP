:-include('functions.pl').
% ------------------- Tratamento com a flag -u ---------------- %
show_unique([],_,_).

show_unique([X|[]], [], Count):-
  (Count == 1 ->
    write_d(X,[]);Count > 1).

show_unique([X,Y|T],[],Count):-
  X == Y,
  increment(Count, NewC),
  append([Y], T, New),
  show_unique(New,[],NewC).

show_unique([X,Y|T],[],Count):-
  X \= Y,
  (Count == 1 ->
    write_d(X,[]),
    append([Y],T,New),
    show_unique(New,[],1)
  ;append([Y],T,New), show_unique(New,[],1)).

show_unique([X|[]], N,Count):-
  (Count == 1 ->
    write_d(X,N);Count > 1).

show_unique([X,Y|T],N,Count):-
  X == Y,
  increment(Count, NewC),
  append([Y], T, New),
  show_unique(New,N,NewC).

show_unique([X,Y|T], N, Count):-
  X \= Y,
  (Count == 1 ->
    write_d(X,N),
    append([Y],T,New),
    show_unique(New,N,1)
  ;append([Y],T,New), show_unique(New,N,1)).

show_unique([_,Y|T],N,_):-
  append([Y], T, New),
  show_unique(New,N, 0).

% -------------------- count_unique ---------------------- %
count_unique([],_,_).

count_unique([X|[]], [], Count):-
  (Count == 1 ->
    write_count(X,[],Count);Count > 1).

count_unique([X,Y|T],[],Count):-
  X == Y,
  increment(Count, NewC),
  append([Y], T, New),
  count_unique(New,[],NewC).

count_unique([X,Y|T],[],Count):-
  X \= Y,
  (Count == 1 ->
    write_count(X,[],Count),
    append([Y],T,New),
    count_unique(New,[],1)
  ;append([Y],T,New), count_unique(New,[],1)).

count_unique([X|[]], N,Count):-
  (Count == 1 ->
    write_count(X,N,Count);Count > 1).

count_unique([X,Y|T],N,Count):-
  X == Y,
  increment(Count, NewC),
  append([Y], T, New),
  count_unique(New,N,NewC).

count_unique([X,Y|T], N, Count):-
  X \= Y,
  (Count == 1 ->
    write_count(X,N,Count),
    append([Y],T,New),
    count_unique(New,N,1)
  ;append([Y],T,New), count_unique(New,N,1)).

count_unique([_,Y|T],N,_):-
  append([Y], T, New),
  show_unique(New,N, 0).
