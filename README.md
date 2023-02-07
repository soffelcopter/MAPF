# MAPF with prunning

This repository contains an ASP solver for MAPF which is based on the idea of tree prunning as described in [1]. 
To run the solver:

```
clingo --out-atomf='%s.' -V0 -c horizon=15 solver.lp instance.lp
```

[1] M. Husár, J. Švancara, P. Obermeier, R. Barták, and T. Schaub, “Reduction-based Solving of Multi-agent Pathfinding on Large Maps Using Graph Pruning,” in Proc. of the 21st International Conference on Autonomous Agents and Multiagent Systems (AAMAS 2022), 2022, p. 9.


