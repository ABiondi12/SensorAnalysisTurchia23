% init_load

clear_all_variables

flag_def

[turtle_nm, turtle_name, name_table_agm, name_table_axy, name_table_calib, turtle_raw_name, turtle_ypr_name, turtle_dive_name, turtle_dive_plt_name, turtle_dive_fft_name, turtle_DBA_name, turtle_DBA_name_paper, turtle_dive_name_din, turtle_dive_plt_name_din, turtle_dive_fft_name_din, turtle_DBA_name_paper_din, turtle_freq_name] = turtle_info(0);

if main_num > 1 % not exe at the beginning of main 1
	if exist('depth_step', 'var') == 0 || clear_workspace == 1
		step_data_def
	end
end