:-include('functions.pl').
% ------------------- Tratamento com as flags -d ---------------- %
show_once([],_,_).

show_once([X|[]], [], Count):-
  (Count > 1 ->
    write_d(X,[]);Count == 1).

show_once([X,Y|T],[],Count):-
  X == Y,
  increment(Count, NewC),
  append([Y], T, New),
  show_once(New,[],NewC).

show_once([X,Y|T],[],Count):-
  X \= Y,
  (Count > 1 ->
    write_d(X,[]),
    append([Y],T,New),
    show_once(New,[],1)
  ;append([Y],T,New), show_once(New,[],1)).

show_once([X|[]], N,Count):-
  (Count > 1 ->
    write_d(X,N);Count == 1).

show_once([X,Y|T],N,Count):-
  X == Y,
  increment(Count, NewC),
  append([Y], T, New),
  show_once(New,N,NewC).

show_once([X,Y|T], N, Count):-
  X \= Y,
  (Count > 1 ->
    write_d(X,N),
    append([Y],T,New),
    show_once(New,N,1)
  ;append([Y],T,New), show_once(New,N,1)).

show_once([_,Y|T],N,_):-
  append([Y], T, New),
  show_once(New,N, 0).
