% run in terminal with: clingo solver.lp simple_instance.lp 0


{path(A,(X,Y),(C,D))} :- start(A,(X,Y)), edge((X,Y),(C,D)).
:- path(A,(X,Y),(C,D)), path(A,(X,Y),(E,F)), (C,D) != (E,F).
{path(Z,(A,B),(C,D)) : vertex((C,D)), edge((A,B),(C,D)), path(Z,(_,_),(A,B))} :- agent(Z).
:- not path(Z,(_,_),(A,B)), agent(Z), goal(Z,(A,B)).
:- path(Z,(A,B),(_,_)), agent(Z), goal(Z,(A,B)).


#show path/5.
