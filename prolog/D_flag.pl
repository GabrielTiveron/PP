:-include('functions.pl').
% ------------------- Tratamento com as flags -d ---------------- %
show_equals([],_,_).

show_equals([X|[]], [], Count):-
  (Count > 1 ->
    write_d(X,[]);Count == 1).

show_equals([X,Y|T],[],Count):-
  X == Y,
  increment(Count, NewC),
  write_d(X, []),
  append([Y], T, New),
  show_equals(New,[],NewC).

show_equals([X,Y|T],[],Count):-
  X \= Y,
  (Count > 1 ->
    write_d(X,[]),
    append([Y],T,New),
    show_equals(New,[],1)
  ;append([Y],T,New), show_equals(New,[],1)).

show_equals([X|[]], N,Count):-
  (Count > 1 ->
    write_d(X,N);Count == 1).

show_equals([X,Y|T],N,Count):-
  X == Y,
  increment(Count, NewC),
  write_d(X,N),
  append([Y], T, New),
  show_equals(New,N,NewC).

show_equals([X,Y|T], N, Count):-
  X \= Y,
  (Count > 1 ->
    write_d(X,N),
    append([Y],T,New),
    show_equals(New,N,1)
  ;append([Y],T,New), show_equals(New,N,1)).

show_equals([_,Y|T],N,_):-
  append([Y], T, New),
  show_equals(New,N, 0).
