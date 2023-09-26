% save_ypr_data
%
% This script create a proper structure for allocate norm and ypr data.

%% create struct
if ~exist('raw_data_struct', 'var')
	ypr_data_struct = struct('name', [], 'datetime_ypr', [], 'roll', [], 'pitch', [], 'yaw_m', [], 'yaw_g', []);
end
	
%% allocate data into the struct
ypr_data_struct.name			= turtle_name;
ypr_data_struct.datetime_ypr	= datetime_mag;
ypr_data_struct.roll			= roll_calib;
ypr_data_struct.pitch			= pitch_calib;
ypr_data_struct.yaw_m			= yaw_m_calib;
ypr_data_struct.yaw_g			= yaw_g_calib;

%% save the struct as a .mat file

new_ypr_dataset = 0;

if exist (turtle_ypr_name, 'file') == 2
	fprintf([turtle_ypr_name,': dataset exists!!! \n'])
	ov_to_do = 0;
	
	yn_ans = 0;
	while yn_ans < 1 || yn_ans > 2
		fprintf([turtle_ypr_name, ': do you want to overwrite it? \n'])
		fprintf('1_ yes \n')
		fprintf('2_ no \n')
		yn_ans = input('');
	end
	
	if yn_ans == 1
		ov_to_do = 1;
		fprintf([turtle_ypr_name, ': start overwrite... \n'])
	elseif yn_ans == 2
		ov_to_do = 0;
		fprintf([turtle_ypr_name, ': overwrite operation aborted \n'])
	end
	
else
	fprintf([turtle_ypr_name, ': dataset not exists, start making it \n'])
	new_ypr_dataset = 1;
end

if new_ypr_dataset == 1 || ov_to_do == 1
	fprintf([turtle_ypr_name, ': saving struct \n'])
	save(turtle_ypr_name, 'ypr_data_struct', '-v7.3');
	fprintf([turtle_ypr_name,' saved! \n'])
end
