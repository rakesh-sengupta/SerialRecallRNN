% Copyright (C) 2023 Rakesh Sengupta
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <https://www.gnu.org/licenses/>.

% -*- texinfo -*-
% @deftypefn {} {@var{retval} =} serialWM (@var{input1}, @var{input2})
% This function serialWM appears to simulate a simple working memory model in which a network of N neurons receives a sequence of input stimuli, r
% epresented by impulses of a fixed duration nstim. The stimuli are represented by setting the values of t
% he corresponding neuron(s) to a constant value 0.33.
%
% The function takes a params structure as input, containing parameters such as the number of neurons 
% (N), the time steps (nt), the number of stimuli (nstim), the number of inputs (ninputs), 
% and the strength of noise (noise).
% 
% The function first initializes the input (I) and network (x) matrices to zero. 
% It then randomly selects ninputs neurons to receive the stimuli, and sets the corresponding 
% elements of the I matrix to 0.33. If the function is called with an additional input argument, 
% it sets the value of the kth neuron in the I matrix to a higher value of 0.43.
%
% Next, the function initializes the x matrix to zero, and generates Gaussian noise 
% to be added to the network activity. The main loop then runs for nt-1 iterations, updating the 
% x matrix at each time step by computing the current value of each neuron as a function of its previous value, 
% the external input, and the noise. If a neuron's value drops below zero, it is reset to zero.
%
% Finally, the function returns the x matrix and the indices of the input neurons in the results structure.
% @seealso{}
% @end deftypefn

% Author: Rakesh Sengupta <rakesh@CCC-SRU>
% Created: 2023-03-17


function results = serialWM(params,varargin)

N = params.N;
nt = params.nt;
dt = params.dt;
nstim = params.nstim;
ninputs = params.ninputs;
alphabeta = params.alphabeta;


I = zeros(N,nt);

a = randperm(N);
inputs = a(1:ninputs);

if(nargin == 1)

    for i = 1:ninputs
        I(inputs(i),((i-1)*nstim+1):(i*nstim)) = 0.33;
    end

else
    k = varargin{1,1};
    for i = 1:ninputs
        I(inputs(i),((i-1)*nstim+1):(i*nstim)) = 0.33;
    end
    I(inputs(k),((k-1)*nstim+1):(k*nstim)) = 0.43;
end
    
x = zeros(N,nt);
noise = params.noise*randn(N,nt);

for i = 1:nt-1
    b = find(x(:,i)<0);
    if(isempty(b) ~=1)
        x(b,i) = 0;
    end
    fx = x(:,i)./(1+x(:,i));
    x(:,i+1) = (1-dt)*x(:,i) + dt*(alphabeta*fx + I(:,i) + noise(:,i));
end
%plot(1:nt,x)
results.x = x;
results.b = inputs;
