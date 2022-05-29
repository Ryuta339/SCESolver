classdef SCESolver < handle
	%%% Solver class of a self consistent equation
	
	properties
		Params {mustBeA(Params, ["Param"])} = Param.empty;
		SCE {mustBeA(SCE, ["AbsSelfConsistentEquation", "uint8"])} = uint8(0);
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
		function solve(obj)
			disp('solve!');
			obj.calc();
			obj.save();
		end
	end
end
