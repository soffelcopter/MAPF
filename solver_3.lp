timestep(1..horizon).


% Vertex V belongs to the subraph of agent A, and the distance 
% from the shortest path up to this vertex is L.
% k is a constant.
subgraph(A, V, 0) :- spath(A, V, _, _).
subgraph(A, V, 1) :- spath(A, V1, _, _), edge(V1, V).
subgraph(A, V, L) :- subgraph(A, V1, L1), L1 != 0, edge(V1, V), L = L1 + 1, L <= k.

% Summarize into a single predicate, because we don't need the distance
% from the shortest path for searching for solution.
subgraph(A, V) :- subgraph(A, V, _).

% Search for the solution within the subgraph.

% Generate all posible movements
{path(A, V1, V2)} :- start(A, V1), edge(V1, V2), subgraph(A, V2).

% Drop models with two movements of the same agent at the same time
:- path(A, V1, V2), path(A,V1, V3), V2 != V3.

% Drop models where there's an agent which haven't reach its goal
:- not path(A, _, V), agent(A), goal(A, V).

% Drop models where an agent continued moving after it had reached the goal.
:- path(A, V, _), agent(A), goal(A, V).

% conflict detection
node_conflict(A1, A2, P, T) :- spath(A1, _, P, T), spath(A2, _, P, T), A2!=A1.
edge_conflict(A1, A2, P1, P2, T) :- spath(A1, P1, P2, T), spath(A2, P2, P1, T), A2!=A1.
conflict(A1, A2, T) :- node_conflict(A1, A2, _, T).
conflict(A1, A2, T) :- edge_conflict(A1, A2, _, _, T).

% Drop models with conflicts
:- conflict(_, _, _).