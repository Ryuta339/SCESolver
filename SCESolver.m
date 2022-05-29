classdef SCESolver < handle
	%%% Solver class of a self consistent equation
	
	properties
		Params(1, :) {mustBeA(Params, ["Param"])} = Param.empty;
		SCE(1, 1) {mustBeA(SCE, ["AbsSelfConsistentEquation"])} ...
			= ExampleSelfConsistentEquation;
		Options(1, 1) {mustBeA(Options, ["optim.options.Fsolve"])} ...
			= optimoptions('fsolve', 'Display', 'none', 'MaxIter', 1e+3, ...
			'TolFun', 1e-10, 'FiniteDifferenceType', 'central', ...
			'FiniteDifferenceStepSize', 1e-10);
	end

	methods (Access = private)
		function calc(obj)
			disp('calculate!');
		end

		function save(obj)
			disp('save!');
		end
	end

	methods
		function obj = SCESolver(params, sce)
			obj.Params = params;
			obj.SCE = sce;
		end

		function solve(obj)
			disp('solve!');
			obj.calc();
			obj.save();
		end
	end
end
