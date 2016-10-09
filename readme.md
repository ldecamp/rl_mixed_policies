Mixed Policies Learning for Self driving agent
==============================================

This project contains a matlab driving agent simulator

This simulate a simplified driving environment simulation which contains the following parameters:

1. road (paved road for the driving agent to drive on)
2. grass (part of the environment that the agent should not drive on)
3. other cars

The goal of the self driving agent is to learn how to drive on the road whilst avoiding other cars. 

The simulation implements Benjamin Rosman and Subramanian Ramamoorthy paper's: [A game-theoretic procedure for learning hierarchically structured strategies][1]

The essence of the approach is that it learns a set of base Policies from a fixed number of reference environments. 
It then uses these base policies to learn an appopriate driving behaviour from a previously unseen environment.

Run the code:
See Readme.txt


[1]: http://ieeexplore.ieee.org/document/5509632/?arnumber=5509632