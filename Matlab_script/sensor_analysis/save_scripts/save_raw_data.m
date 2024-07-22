% save_raw_data
%
% This script create a proper structure for allocate the raw data once
% reoriented and, for the magnetic field, before and after the calibration
% has been performed.

%% create struct
if ~exist('raw_data_struct', 'var')
	raw_data_struct = struct('ID', [], 'name', [], 'datetime_acc', [], 'datetime_mag', [], 'datetime_gyro', [], 'datetime_depth', [], 'depth', [], 'accx_reor', [], 'accy_reor', [], 'accz_reor', [], 'magx_reor', [], 'magy_reor', [], 'magz_reor', [], 'magx_calib', [], 'magy_calib', [], 'magz_calib', [], 'gyrox_reor', [], 'gyroy_reor', [], 'gyroz_reor', []);
end

if sensor_type == 1	&& release == 2 && (turtle_nm == 4 || turtle_nm == 5)
    no_gyro = 1;
else
    no_gyro = 0;
end
%% allocate data into the struct
raw_data_struct.ID			= turtle_nm;
raw_data_struct.name		= turtle_name;
raw_data_struct.datetime_acc	= datetime_acc;
raw_data_struct.datetime_mag	= datetime_mag;
raw_data_struct.datetime_depth = datetime_depth;
raw_data_struct.depth		= depth;
raw_data_struct.accx_reor	= acc_reor(:, 1);
raw_data_struct.accy_reor	= acc_reor(:, 2);
raw_data_struct.accz_reor	= acc_reor(:, 3);
raw_data_struct.magx_reor	= mag_reor(:, 1);
raw_data_struct.magy_reor	= mag_reor(:, 2);
raw_data_struct.magz_reor	= mag_reor(:, 3);
raw_data_struct.magx_calib	= mag_postcalib(:, 1);
raw_data_struct.magy_calib	= mag_postcalib(:, 2);
raw_data_struct.magz_calib	= mag_postcalib(:, 3);

if no_gyro == 0
    raw_data_struct.datetime_gyro	= datetime_gyro;
    raw_data_struct.gyrox_reor	= gyro_reor(:, 1);
    raw_data_struct.gyroy_reor	= gyro_reor(:, 2);
    raw_data_struct.gyroz_reor	= gyro_reor(:, 3);
end
%% save the struct as a .mat file

new_raw_dataset = 0;

if exist(turtle_raw_name, 'file') == 2
	fprintf([turtle_raw_name,': dataset exists!!! \n'])
	ov_to_do = 0;
	
	yn_ans = 0;
	while yn_ans < 1 || yn_ans > 2
		fprintf([turtle_raw_name, ': do you want to overwrite it? \n'])
		fprintf('1_ yes \n')
		fprintf('2_ no \n')
		yn_ans = input('');
	end
	
	if yn_ans == 1
		ov_to_do = 1;
		fprintf([turtle_raw_name, ': start overwrite... \n'])
	elseif yn_ans == 2
		ov_to_do = 0;
		fprintf([turtle_raw_name, ': overwrite operation aborted! \n'])
	end
	
else
	fprintf([turtle_raw_name, ': dataset does not exist, start making it... \n'])
	new_raw_dataset = 1;
end

if new_raw_dataset == 1 || ov_to_do == 1
	fprintf([turtle_raw_name, ': saving struct \n'])
	% save('turtle_dive', 'turtle_dive', '-v7.3');
	save(turtle_raw_name, 'raw_data_struct', '-v7.3');
	fprintf([turtle_raw_name,' saved! \n'])
end
