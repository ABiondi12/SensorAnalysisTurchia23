% load_dive_data
%
% This script load dive data allocated in a specified .mat file

if exist(turtle_dive_name) == 2
	load(turtle_dive_name);
else
	errorStruct.message = 'Data file not found.';
	errorStruct.identifier = 'MyFunction:fileNotFound';

	error(errorStruct)
end

%% din

if exist(turtle_dive_name_din) == 2
	load(turtle_dive_name_din);
else
	errorStruct.message = 'Data file not found.';
	errorStruct.identifier = 'MyFunction:fileNotFound';

	error(errorStruct)
end