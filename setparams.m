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
% @deftypefn {} {@var{retval} =} setParams (@var{input1}, @var{input2})
%
% @seealso{}
% @end deftypefn

% Author: Rakesh Sengupta <rakesh@CCC-SRU>
% Created: 2023-03-17


function params = setparams

params.N = 70;
params.nt = 10000;
%params.nstim = 400;
params.dt = 0.01;

params.ninputs = 8;

alpha = 2.0;
beta = 0.15;

params.alphabeta = alpha*eye(params.N) + beta*(eye(params.N) - ones(params.N));
params.noise = 0.05;








