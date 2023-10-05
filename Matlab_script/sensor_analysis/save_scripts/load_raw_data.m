% load_raw_data
%
% This script load raw data allocated in a specified .mat file

if exist(turtle_raw_name) == 2
	load(turtle_raw_name);

	turtle_nm = raw_data_struct.ID;
	turtle_name = raw_data_struct.name;
	datetime_acc	= raw_data_struct.datetime_acc;
	datetime_mag	= raw_data_struct.datetime_mag;
	datetime_gyro	= raw_data_struct.datetime_gyro;
	datetime_depth	= raw_data_struct.datetime_depth;
	depth			= raw_data_struct.depth;
	acc_reor		= [raw_data_struct.accx_reor, raw_data_struct.accy_reor, raw_data_struct.accz_reor];
	mag_reor		= [raw_data_struct.magx_reor, raw_data_struct.magy_reor, raw_data_struct.magz_reor];
	mag_postcalib	= [raw_data_struct.magx_calib, raw_data_struct.magy_calib, raw_data_struct.magz_calib];
	gyro_reor		= [raw_data_struct.gyrox_reor,raw_data_struct.gyroy_reor ,raw_data_struct.gyroz_reor];
else
	errorStruct.message = 'Data file not found.';
	errorStruct.identifier = 'MyFunction:fileNotFound';

	error(errorStruct)
end