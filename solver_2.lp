% run in terminal with: clingo solver.lp simple_instance.lp 0

% edge(P,P) :- vertex(P).

timestep(1..horizon).

% conflict detection
node_conflict(A1, A2, P, T) :- spath(A1, _, P, T), spath(A2, _, P, T), A2!=A1.
edge_conflict(A1, A2, P1, P2, T) :- spath(A1, P1, P2, T), spath(A2, P2, P1, T), A2!=A1.
conflict(A1, A2, T) :- node_conflict(A1, A2, _, T).
conflict(A1, A2, T) :- edge_conflict(A1, A2, _, _, T).

% alternative move to avoid a conflict
1 {move(A1, P1, P3, T)} 1 :- conflict(A1, A2, T), spath(A1, P1, P2, T), edge(P1, P3), P3 != P2,
							 not new_spath(A3, _, P3, T), A3!=A1, agent(A3).

new_spath(A2, P1, P2, T) :- spath(A2, P1, P2, T), move(A1, _, _, T), conflict(A1, A2, T).
new_spath(A1, P1, P2, T) :- spath(A1, P1, P2, T), not conflict(A1, _, T).
new_spath(A1, P1, P3, T) :- move(A1, P1, P3, T).

first_conflict(A1, T1) :- T1 = #min{T : conflict(A1, _, T)}, agent(A1).
no_conflict_spath(A1, P1, P2, T) :- spath(A1, P1, P2, T), not first_conflict(A1, _).
no_conflict_spath(A1, P1, P2, T) :- spath(A1, P1, P2, T), first_conflict(A1, T1), T1>T.


% drop models 
#show new_spath/4.
#show move/4.
#show no_conflict_spath/4.
#show conflict/3.
#show first_conflict/2.
