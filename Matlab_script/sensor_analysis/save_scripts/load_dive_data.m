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

counter		= size(turtle_dive.big_dive.homing, 2);
sh_counter	= size(turtle_dive.shallow_dive.homing, 2);
surf_counter = size(turtle_dive.sub_surface.homing, 2);

%% din

if exist(turtle_dive_name_din) == 2
	load(turtle_dive_name_din);
else
	errorStruct.message = 'Data file not found.';
	errorStruct.identifier = 'MyFunction:fileNotFound';

	error(errorStruct)
end