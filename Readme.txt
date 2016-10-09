%%%%%% Description of Programs %%%%%%%%%%%
Main programs:
z_runTestMap: Train the mixed policy on the test map and returns:
- the expected reward of the policy on the test map after 10000 iterations
- one episod of the game (if the game is paused, it means that a random action has been selected and the programs wait for a key to continue).
- The plots of the weights distribution for each section of the map (in the Composite folder).
- The plots of the evolution of the expected reward over section training

z_runTraining: Train the mixed policy on a new generated training map and returns the same metrics as in the z_runTestMap

z_learnBasisNoCars: Learn the policy for each primitives using Q-learning when no cars are on the road (to save policies into file set savePolicy flag to true). This outputs:
- All policies learn under a file in Appendix folder.
- The performance graph in a file under Appendix folder (if saveGraph flag true)

z_learnBasisWithCars: Same as above but for case when cars on the road
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%% Execution procedure %%%%%%%%%%%%%%%%%
If you want to see the result of the composite policy on the test map just run z_runTestMap (same for training case with z_runTraining)

If you want to retrain the primitive policies execute z_learnBasisWithCars with savePolicy flag true. They can then be used in the composite policy training
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
