classdef AbsSelfConsistentEquation < handle
	%%% Abstract base class of a self consistent equation
	%%% This is called by SCESolver to calculate solutions
	%%% of a self consistent equation.
	
	methods (Abstract)
		selfConsistentEquation(obj, op, params)
		initOP(obj, params);
	end
end
