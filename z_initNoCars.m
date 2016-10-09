%define all global parameters and constants

%defines actions values
UP_LEFT=1;
UP=2;
UP_RIGHT=3;

blockSize=5; % This will function as the dimension of the road basis
% images (blockSize x blockSize), as well as the view range, in rows of
% your car (including the current row).
rewards=[1, -1, -20]; % the rewards are state-based. In order: paved
% square, non-paved square, and car collision. Agents can occupy the same
% square as another car, and the collision does not end the instance, but
% there is a significant reward penalty.
global actionsRewards;
actionsRewards=rewards;
probabilityOfUniformlyRandomDirectionTaken=0.15; % Noisy driver actions.
% An action will not always have the desired effect. Since there are always
% 3 viable next states, this means that the transition probabilities are
% 90% towards the desired state, and 5% towards each other one.

noCarOnRowProbability = 0.8 ; % the probability that there is no car
% spawned for each row
global pNoCarOnRowTest;
pNoCarOnRowTest=noCarOnRowProbability;

roadBasisGridMaps=generateMiniMaps; % Generates the 8 road basis grid
% maps, complete with an initial location for your agent. (Also see the
% GridMap class).

%Q-learning constants
global learningRate;
learningRate=0.5;
global discountFactor;
discountFactor=1.0;
%declare global params to avoid overload functions
global N_ACTIONS;
N_ACTIONS=3;
global showUILearning;
showUILearning=true; % state whether display UI when learning
global showProgress;
showProgress=false;
global pRandomAction;
%create alias (name too long...)
pRandomAction=probabilityOfUniformlyRandomDirectionTaken;
global mapSize;
mapSize=blockSize;
%defines value for initial Q-Values
global initialQValue;
initialQValue=10;
global execLearning;
execLearning=true;
