vertex((1..2,1..2)).
edge((1,1),(1,2)).
edge((1,1),(2,1)).
edge((1,2),(2,2)).
edge((2,1),(2,2)).
edge(X,Y) :- edge(Y,X).

agent(a1).
start(a1,(1,1)).
goal(a1,(2,2)).


agent(a2).
start(a2,(2,2)).
goal(a2,(1,1)).

spath(a1,(1,1),(1,2),1).
spath(a1,(1,2),(2,2),2).

spath(a2,(2,2),(1,2),1).
spath(a2,(1,2),(1,1),2).

#const horizon=3.