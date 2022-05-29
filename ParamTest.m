classdef ParamTest < matlab.unittest.TestCase
	%%% Test suit class of Param
	%%% Reference:
	%%% https://jp.mathworks.com/help/matlab/ref/matlab.unittest.test-class.html
	methods (TestClassSetup)
		function addParamTest(testCase)
			p = path;
			testCase.addTeardown(@path, p);
			addpath(fullfile(matlabroot, 'help', 'techdoc', 'matlab_oop',...
				'examples'));
		end
	end

	methods (Test)
		function testConstructor(testCase)
			p = Param('\alpha', 1:10);
			testCase.verifyEqual(p.Label, '\alpha', ...
				'Constructor failed to correctly set label');
			testCase.verifyEqual(p.Range, 1:10, ...
				'Constructor failed to correctly set range');
		end

		function testConstructorNotEnoughInputs(testCase)
			import matlab.unittest.constraints.Throws;
			testCase.verifyThat(@()Param, ...
				Throws('MATLAB:minrhs'));
		end

		function testGetLabels(testCase)
			p = Param('\alpha', 1:10)
			labels = p.getLabels(0);
			testCase.verifyEqual(size(labels), [1 10], ...
				'getLabels returns the illegal size of an array');
			testCase.verifyEqual(labels(1), "\alpha=1", ...
				'getLabels faield to correctly set labels');
			testCase.verifyEqual(labels(10), "\alpha=10", ...
				'getLabels faield to correctly set labels');
		end
	end
end
