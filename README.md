# MAPF with prunning

This repository contains an ASP solver for MAPF which is based on the idea of tree pruning as described in [1]. 

To run the solver:

```
clingo --out-atomf='%s.' solver_with_prunning.lp instance.lp 0
```

This solver applies two pruning strategies:
1. For each agent, remove from the underlying graph the nodes that lay further than k steps away from the shortest path.
2. Discard a model if at any time step there is an agent that will not be able to reach its goal within the horizon.

The solver was tested on the instances in the `Instances` folder. Not all instances are solvable by this solver.
| Solved | Not solved |
| ------------- | ------------- |
| room_s10_a30_w5 <br> test_s4x2_a6_exchange <br> test_s5_a1_smol <br> test_s5_a2_detour <br> test_s5_a2_exchange(hard) <br> test_s5_a2_square | maze_s10_a25 <br> maze_s10_a30 <br> random_s10_a15_c50 <br> random_s10_a20_c55 <br> room_s10_a15_w1 |

The main reason for failing is the size and the density of the instances. Even after pruning, the search space remains too big to be solved in reasonable time.

#### References

[1] M. Husár, J. Švancara, P. Obermeier, R. Barták, and T. Schaub, “Reduction-based Solving of Multi-agent Pathfinding on Large Maps Using Graph Pruning,” in Proc. of the 21st International Conference on Autonomous Agents and Multiagent Systems (AAMAS 2022), 2022, p. 9.


