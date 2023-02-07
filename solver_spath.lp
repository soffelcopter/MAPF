timestep(1..horizon).

% Generate all posible movements
{spath(A, V1, V2,1) : start(A, V1), edge(V1, V2), agent(A)} .
{spath(A, V2, V3,T+1) : spath(A, V1, V2,T), edge(V2, V3), 
	agent(A), timestep(Z), T<Z}.

%if agent reaches goal vertex wait action at goal vertex added for the remaining time steps 
spath(A, V, V,T+1) :- spath(A, _, V,T), agent(A), goal(A, V), timestep(T), timestep(Z), T<Z.

% Drop models with two movements of the same agent at the same time
:- spath(A, V1, V2,T), spath(A,V1, V3,T), V2 != V3.

% Drop models where there's an agent which haven't reached its goal
:- not spath(A,_,V,_), agent(A), goal(A, V).

% Drop models where an agent continued moving after it had reached the goal.
:- spath(A, V, _,_), agent(A), goal(A, V).