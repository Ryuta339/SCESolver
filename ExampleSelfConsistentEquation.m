classdef ExampleSelfConsistentEquation < AbsSelfConsistentEquation
	methods
		function out = selfConsistentEquation(obj, op, params)
			DVI = 400;
			sig = 4.0;
			dz = sig ./ DVI;
			zz = dz .* (-DVI:1:DVI);
			Dzz = normpdf(zz, 0, 1) .* dz;

			H = sqrt(op(2,1)) .* zz + params(2,1) .* op(1,1);
			
			m = Dzz * tanh(params(1,1).*H)';
			q = Dzz * (tanh(params(1,1).*H).^2)';
			
			out(1,1) = m - op(1,1);
			out(2,1) = q - op(2,1);
		end

		function op = initOP(obj, parans)
			op = [1; 1];
		end
	end
end
