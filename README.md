# SerialRecallRNN
This is a work in progress recurrent on-center off-surround neural network module intended to explore serial recall performance in human beings

Serial recall paradigm has been used from very early on to investigate short term memory (Waugh and Norman, 1965). The major characteristics that emerge from these experiments regarding recall of a series of items are primacy and recency effect – that it is much easier to recall earlier and later items in the sequence as opposed to those in the middle. In the current work we have described a single layer of fully connected recurrent neural network with properties of self-excitation and mutual inhibition, in line with Usher and Cohen, 1999; Sengupta et. al., 2014. Transient input to the network gave rise to dynamic steady state output. The steady state output pattern was used to probe which of the inputs were ultimately ‘remembered’ at the end of simulation.  We show that such a network can account for serial recall curve shown in empirical studies at higher inhibition values. Moreover, it can also account for capacity limitation commonly observed in serial recall tasks. Varying the presentation duration in the model allowed us to account for both primacy and recency effect within the same network. Furthermore, when we modeled the effect of cues on a single item in the sequence (as elevated input onto one item and calculating the recall probability of all the items in the sequence), we found that such cues will decrease the recall probability of neighboring items in the sequence. Overall, the findings indicate the possibility of understanding primacy, recency, and cued recall effects from the dynamics of a single layer recurrent on-center off-surround neural network.

# setParams.m

The Matlab function setparams initializes a structure params with default parameter values for a simulation of a working memory task.

The structure params includes the following fields:

N: number of neurons in the simulated network
nt: number of simulation time steps
dt: time step size for the simulation
ninputs: number of items to be stored in memory
alphabeta: connectivity matrix for the network, defined as a combination of a diagonal matrix with values of parameter alpha and a matrix of ones with values of parameter beta
noise: level of Gaussian noise added to the network activity at each time step.
The setparams function sets some of these fields to default values, and returns the params structure. The default values are as follows:

N: 70
nt: 10000
dt: 0.01
ninputs: 8
alpha: 2.0
beta: 0.15
alphabeta: a connectivity matrix with diagonal values of 2.0 and off-diagonal values of 0.15.
noise: 0.05.

# serialWM.m

This function serialWM appears to simulate a simple working memory model in which a network of N neurons receives a sequence of input stimuli, represented by impulses of a fixed duration nstim. The stimuli are represented by setting the values of the corresponding neuron(s) to a constant value 0.33.

The function takes a params structure as input, containing parameters such as the number of neurons (N), the time steps (nt), the number of stimuli (nstim), the number of inputs (ninputs), and the strength of noise (noise).

The function first initializes the input (I) and network (x) matrices to zero. It then randomly selects ninputs neurons to receive the stimuli, and sets the corresponding elements of the I matrix to 0.33. If the function is called with an additional input argument, it sets the value of the kth neuron in the I matrix to a higher value of 0.43.

Next, the function initializes the x matrix to zero, and generates Gaussian noise to be added to the network activity. The main loop then runs for nt-1 iterations, updating the x matrix at each time step by computing the current value of each neuron as a function of its previous value, the external input, and the noise. If a neuron's value drops below zero, it is reset to zero.

Finally, the function returns the x matrix and the indices of the input neurons in the results structure.

# serial_memory_test.m

This code runs a simulation of a serial working memory task and calculates the recall probability of each item position.

The simulation is based on the serial WM model implemented in the function serialWM. The function setparams is used to set the parameters for the simulation.

The simulation is run for different values of nstim, which represents the number of stimuli to be memorized. The recall probability is calculated for each item position (1 to params.ninputs) by counting the number of times that the model correctly recalls each item in that position over the total number of runs.

The results are plotted as a bar graph with error bars indicating the standard error of the mean over the different values of nstim. The x-axis represents the item order (from earliest to latest), and the y-axis represents the recall probability. The title of the plot is "Serial recall".

# serial_memory_spatialCue.m

This code runs a serial recall task with varying numbers of stimuli and inputs, and records the recall probabilities for each item order. The recall probabilities are calculated as the proportion of trials in which each item was correctly recalled.

The first section sets up the parameters for the simulation using the setparams function. The variable nstim is a vector specifying the number of stimuli to be presented in each trial. The variable nrun specifies the number of simulation runs for each condition.

The main loop iterates over each value in nstim and runs the simulation with that number of stimuli for nrun iterations. For each iteration, the serialWM function is called with an additional argument k, which specifies which input is perturbed in the simulation. The recall probability is calculated for each item order and added to a running total for that condition.

After all iterations have completed, the mean recall probabilities are calculated across all runs for each item order and stored in the mean_recall_prob matrix. Finally, a plot is generated showing the recall probabilities for each item order, with each line corresponding to a different input perturbation.
