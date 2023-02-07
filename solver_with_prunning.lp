%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Generate spath(...) %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% The solver %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


makespanBound(T) :- T = #max{L:spath(_,_,_,L)}.
%timestep(1..T):- makespanBound(T).

edge(V,V):- vertex(V).
edge(V1,V2):-edge(V2,V1).


% Vertex V belongs to the subraph of agent A, and the distance 
% from the shortest path up to this vertex is L.
% k is a constant.
active_vertex(A, V, 0) :- spath(A, V, _, _).
active_vertex(A, V, 1) :- spath(A, V1, _, _), edge(V1, V).
active_vertex(A, V, L) :- active_vertex(A, V1, L1), L1 != 0, 
	edge(V1, V), L = L1 + 1, L <= k.

% Summarize into a single predicate, because we don't need the distance
% from the shortest path for searching for solution.
active_vertex(A, V) :- active_vertex(A, V, _).

% Generate all posible movements
{path(A, V1, V2,1) : start(A, V1), edge(V1, V2), agent(A)} .
{path(A, V2, V3,T+1) : path(A, V1, V2,T), edge(V2, V3), 
	active_vertex(A, V2), active_vertex(A, V3), agent(A), timestep(Z), T<Z}.

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
