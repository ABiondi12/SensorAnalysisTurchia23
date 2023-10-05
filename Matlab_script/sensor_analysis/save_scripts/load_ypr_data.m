% load_ypr_data
%
% This script load ypr data allocated in a specified .mat file

if exist(turtle_ypr_name) == 2
	load(turtle_ypr_name);

	datetime_ypr	= ypr_data_struct.datetime_ypr;
	roll_calib			= ypr_data_struct.roll;
	pitch_calib			= ypr_data_struct.pitch;
	yaw_m_calib			= ypr_data_struct.yaw_m;
	yaw_g_calib			= ypr_data_struct.yaw_g;
else
	errorStruct.message = 'Data file not found.';
	errorStruct.identifier = 'MyFunction:fileNotFound';

	error(errorStruct)
end