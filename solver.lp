% run in terminal with: clingo solver.lp simple_instance.lp 0


{spath(A,X,Y,C,D)} :- start(A,(X,Y)), edge((X,Y),(C,D)).
:- spath(A,X,Y,C,D), spath(A,X,Y,E,F), (C,D) != (E,F).
{spath(Z,A,B,C,D) : vertex((C,D)), edge((A,B),(C,D)), spath(Z,_,_,A,B)} :- agent(Z).
:- not spath(Z,_,_,A,B), agent(Z), goal(Z,(A,B)).
:- spath(Z,A,B,_,_), agent(Z), goal(Z,(A,B)).


#show spath/5.
