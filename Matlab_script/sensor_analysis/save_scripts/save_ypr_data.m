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
    formatSpec = "%s : dataset exists!!! \n";
    print_msg = compose(formatSpec, turtle_ypr_name);
    fprintf(print_msg)

	ov_to_do = 0;
	
	yn_ans = 0;
	while yn_ans < 1 || yn_ans > 2
        formatSpec = "%s : do you want to overwrite it? \n";
        print_msg = compose(formatSpec, turtle_ypr_name);
        fprintf(print_msg)
    
		fprintf('1_ yes \n')
		fprintf('2_ no \n')
		yn_ans = input('');
	end
	
	if yn_ans == 1
		ov_to_do = 1;
        formatSpec = "%s : start overwrite... \n";
        print_msg = compose(formatSpec, turtle_ypr_name);
        fprintf(print_msg)
    
	elseif yn_ans == 2
		ov_to_do = 0;
        formatSpec = "%s : overwrite operation aborted \n";
        print_msg = compose(formatSpec, turtle_ypr_name);
        fprintf(print_msg)
		
	end
	
else
    formatSpec = "%s : dataset not exists, start making it \n";
    print_msg = compose(formatSpec, turtle_ypr_name);
    fprintf(print_msg)
	
	new_ypr_dataset = 1;
end

if new_ypr_dataset == 1 || ov_to_do == 1
    formatSpec = "%s : saving struct \n";
    print_msg = compose(formatSpec, turtle_ypr_name);
    fprintf(print_msg)
	
	save(turtle_ypr_name, 'ypr_data_struct', '-v7.3');
    formatSpec = "%s : saved! \n";
    print_msg = compose(formatSpec, turtle_ypr_name);
    fprintf(print_msg)
end
