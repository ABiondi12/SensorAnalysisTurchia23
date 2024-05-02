% raw_dataset_load

if exist('raw_data_struct', 'var') == 0
	fprintf('load raw values \n')
	load_raw_data
else
	if strcmp(raw_data_struct.name, turtle_name)
		fprintf('raw data already present in the workspace \n')
	else
		fprintf('raw data referred to another turtle are already present in the workspace \n')
		turtle_switch = 0;
		fprintf('Do you want to use the selected turtle or the one present in the workspace? \n')
		fprintf('1. Workspace \n')
		fprintf('2. Last selected \n')
		while turtle_switch < 1 || turtle_switch > 2
			turtle_switch = input('');
		end
		if turtle_switch == 1
			[turtle_nm, turtle_name, name_table_agm, name_table_axy, name_table_calib, turtle_raw_name, turtle_ypr_name, turtle_dive_name, turtle_dive_plt_name, turtle_dive_fft_name, turtle_DBA_name, turtle_DBA_name_paper, turtle_dive_name_din, turtle_dive_plt_name_din, turtle_dive_fft_name_din, turtle_DBA_name_paper_din, turtle_freq_name] = turtle_info(raw_data_struct.ID);
			
		elseif turtle_switch == 2
			fprintf('overwrite operation: start load raw data referred to the current turtle... \n')
			load_raw_data
			fprintf('overwrite operation: completed \n')
		end
	end
end