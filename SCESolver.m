classdef SCESolver < handle
	%%% Solver class of a self consistent equation

	properties (Access = private)
		indeces(1, :) {mustBePositive, mustBeInteger}
	end
	
	properties
		Params(1, :) {mustBeA(Params, ["Param"])} = Param.empty;
		SCE(1, 1) {mustBeA(SCE, ["AbsSelfConsistentEquation"])} ...
			= ExampleSelfConsistentEquation;
		Options(1, 1) {mustBeA(Options, ["optim.options.Fsolve"])} ...
			= optimoptions('fsolve', 'Display', 'none', 'MaxIter', 1e+3, ...
			'TolFun', 1e-10, 'FiniteDifferenceType', 'central', ...
			'FiniteDifferenceStepSize', 1e-10);
		ResultPath {mustBeText} = "./results";
	end

	methods (Access = private)
		function op = calc(obj, op0, params)
			if all(~isnan(op0))
				fun = @(op) obj.SCE.selfConsistentEquation(op, params);
				[op_out, ~, exitflag, ~] = fsolve(fun, op0, obj.Options);
				op0 = op_out;
			else
				op0 = zeros(size(op0));
			end;
			op = op0;
		end

		function save(obj, mat1)
			[~, nParams] = size(obj.indeces);
			filename = strcat(obj.ResultPath, '/op', sprintf('_%d', obj.indeces(1, :)), '.mat');
			save(filename, 'mat1');
		end

		function recursiveSolve(obj, n)
			[~, nParams] = size(obj.indeces);
			if n == nParams
				op0 = obj.SCE.initOP();
				[nops, ~] = size(op0);
				op_st = zeros(nops, length(obj.Params(1,n).Range));
				idx = 1;
				for p=obj.Params(1,n).Range
					params = zeros(nParams, 1);
					for ni=1:(nParams-1)
						params(ni, 1) = obj.Params(ni).Range(1, obj.indeces(ni));
					end
					params(nParams, 1) = p;
					op_st(:, idx) = obj.calc(op0, params);
					idx = idx + 1;
				end
				obj.save(op_st);
			else
				idx = 1;
				for p=obj.Params(1,n).Range
					obj.indeces(1, n) = idx;
					obj.recursiveSolve(n+1);
					idx = idx + 1;
				end
			end
		end
	end

	methods
		function obj = SCESolver(params, sce)
			obj.Params = params;
			obj.SCE = sce;
			obj.indeces = ones(size(params));
		end

		function solve(obj)
			obj.recursiveSolve(1);
		end
	end
end
