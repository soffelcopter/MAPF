vertex((1,1..5)).
vertex((3,1..5)).
vertex((5,1..5)).
vertex((1..5,1)).
vertex((1..5,5)).

edge((X,Y),(X,Y+1)) :- vertex((X,Y)), vertex((X,Y+1)).
edge((X,Y),(X+1,Y)) :- vertex((X,Y)), vertex((X+1,Y)).
edge(X,Y) :- edge(Y,X).

agent(a1).
start(a1,(1,1)).
goal(a1,(5,5)).

spath(a1,(1,1),(2,1),1).
spath(a1,(2,1),(3,1),2).
spath(a1,(3,1),(3,2),3).
spath(a1,(3,2),(3,3),4).
spath(a1,(3,3),(3,4),5).
spath(a1,(3,4),(3,5),6).
spath(a1,(3,5),(4,5),7).
spath(a1,(4,5),(5,5),8).

agent(a2).
start(a2,(5,5)).
goal(a2,(1,1)).

spath(a2,(2,1),(1,1),8).
spath(a2,(3,1),(2,1),7).
spath(a2,(3,2),(3,1),6).
spath(a2,(3,3),(3,2),5).
spath(a2,(3,4),(3,3),4).
spath(a2,(3,5),(3,4),3).
spath(a2,(4,5),(3,5),2).
spath(a2,(5,5),(4,5),1).

#const horizon=8.
