#const k = 12.

timestep(1..horizon).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% The solver %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

edge(V,V):- vertex(V).
edge(V1,V2):-edge(V2,V1).

active_vertex(A, (X, Y)) :- spath(A, (X1, Y1), _, _), |X - X1| + |Y - Y1| < k, vertex((X, Y)).
%active_vertex(A, (X, Y)) :- spath(A, _, (X1, Y1), _), |X - X1| + |Y - Y1| < k.

% Generate all posible movements
{path(A, V1, V2,1) : start(A, V1), edge(V1, V2), agent(A), active_vertex(A, V1), active_vertex(A, V2)} .
{path(A, V2, V3,T+1) : path(A, V1, V2,T), edge(V2, V3), 
	active_vertex(A, V2), active_vertex(A, V3), agent(A), timestep(T)}.

%if agent reaches goal vertex wait action at goal vertex added for the remaining time steps 
path(A, V, V,T+1) :- path(A, _, V,T), agent(A), goal(A, V), active_vertex(A, V), timestep(T).

% Drop models with two movements of the same agent at the same time
:- path(A, V1, V2,T), path(A,V1, V3,T), V2 != V3.

% Drop models where there's an agent which haven't reached its goal
:- not path(A,_,V,_), agent(A), goal(A, V).

% Drop models where an agent continued moving after it had reached the goal.
:- agent(A), goal(A, V1), path(A, _, V2, horizon), V1 != V2, active_vertex(A, V1), active_vertex(A, V2).

% conflict detection
node_conflict(A1, A2, P, T) :- path(A1, _, P, T), path(A2, _, P, T), A2!=A1.
edge_conflict(A1, A2, P1, P2, T) :- path(A1, P1, P2, T), path(A2, P2, P1, T), A2!=A1.
conflict(A1, A2, T) :- node_conflict(A1, A2, _, T).
conflict(A1, A2, T) :- edge_conflict(A1, A2, _, _, T).

% Drop models with conflicts
:- conflict(_, _, _).

% Drop models where agents are too far away from their goals to reach it in given horizon
:- path(A, _, (X, Y), T), goal(A, (X1, Y1)), |X - X1| + |Y - Y1| > horizon.
 

% Optimize on makespan
paths_length(T) :- path(A,P1,P2,T), agent(A), goal(A,P2), vertex(P1), P1!=P2.
#minimize{ T : paths_length(T) }.

#show path/4.
