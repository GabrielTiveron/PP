:-include('functions.pl').
% ------------------- Tratamento com as flags -D ---------------- %
show_equals([],_,_,_).

show_equals([X|[]], [], Count,_):-
  (Count > 1 ->
    write_d(X,[]);Count == 1).

show_equals([X,Y|T],[],Count,Ar):-
  X == Y,
  increment(Count, NewC),
  write_d(X, [],0),
  append([Y], T, New),
  show_equals(New,[],NewC,Ar).

show_equals([X,Y|T],[],Count,Ar):-
  X \= Y,
  (Count > 1 ->
    write_d(X,[],Ar),
    append([Y],T,New),
    show_equals(New,[],1,Ar)
  ;append([Y],T,New), show_equals(New,[],1,Ar)).

show_equals([X|[]], N,Count,Ar):-
  (Count > 1 ->
    write_d(X,N,Ar);Count == 1).

show_equals([X,Y|T],N,Count,Ar):-
  X == Y,
  increment(Count, NewC),
  write_d(X,N,Ar),
  append([Y], T, New),
  show_equals(New,N,NewC,Ar).

show_equals([X,Y|T], N, Count,Ar):-
  X \= Y,
  (Count > 1 ->
    write_d(X,N,Ar),
    append([Y],T,New),
    show_equals(New,N,1)
  ;append([Y],T,New), show_equals(New,N,1,Ar)).

show_equals([_,Y|T],N,_,Ar):-
  append([Y], T, New),
  show_equals(New,N, 1,Ar).
