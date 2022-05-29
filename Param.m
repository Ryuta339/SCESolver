classdef Param < handle
	%%% A parameter deciding an order parameter equation
	properties
		Label {mustBeText} = ''
		Range (1, :) {mustBeNumeric}
	end
	methods
		function obj = Param(label, range)
			obj.Label = label;
			obj.Range = range;
		end

		function labels = getLabels(obj, digit)
			labels = strings(size(obj.Range));
			[~, N] = size(obj.Range);
			for idx=1:N
				labels(1, idx) = sprintf('%s=%.*f', obj.Label, digit, obj.Range(1, idx));
			end
		end
	end
end
