makespanBound(T) :- T = #max{L:spath(_,_,_,L)}.
timestep(1..T):- makespanBound(T).

edge(V,V):- vertex(V).
edge(V1,V2):-edge(V2,V1).


% Generate all posible movements
{path(A, V1, V2,1) : start(A, V1), edge(V1, V2), agent(A)} .
{path(A, V2, V3,T+1) : path(A, V1, V2,T), edge(V2, V3), agent(A), timestep(Z), T<Z}.
%if agent reaches goal vertex wait action at goal vertex added for the remaining time steps 
path(A, V, V,T+1) :- path(A, _, V,T), agent(A), goal(A, V), timestep(T), timestep(Z), T<Z.

% Drop models with two movements of the same agent at the same time
:- path(A, V1, V2,T), path(A,V1, V3,T), V2 != V3.

% Drop models where there's an agent which haven't reached its goal
:- not path(A,_,V,_), agent(A), goal(A, V).

% Drop models where an agent continued moving after it had reached the goal.
:- path(A, V, _,_), agent(A), goal(A, V).

% conflict detection
node_conflict(A1, A2, P, T) :- path(A1, _, P, T), path(A2, _, P, T), A2!=A1.
edge_conflict(A1, A2, P1, P2, T) :- path(A1, P1, P2, T), path(A2, P2, P1, T), A2!=A1.
conflict(A1, A2, T) :- node_conflict(A1, A2, _, T).
conflict(A1, A2, T) :- edge_conflict(A1, A2, _, _, T).

% Drop models with conflicts
:- conflict(_, _, _).

#show path/4.
