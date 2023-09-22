% load_ypr_data
%
% This script load ypr data allocated in a specified .mat file

if exist(turtle_ypr_name) == 2
	load(turtle_ypr_name);

	datetime_ypr	= ypr_data_struct.datetime_ypr;
	roll			= ypr_data_struct.roll;
	pitch			= ypr_data_struct.pitch;
	yaw_m			= ypr_data_struct.yaw_m;
	yaw_g			= ypr_data_struct.yaw_g;
else
	errorStruct.message = 'Data file not found.';
	errorStruct.identifier = 'MyFunction:fileNotFound';

	error(errorStruct)
end