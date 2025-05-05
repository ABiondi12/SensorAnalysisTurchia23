% init_load

clear_all_variables

if clear_workspace == 1
    calib_proc_real_time = 1;
    fprintf('calib_proc_real_time created \n');
end

flag_def

%% release selection
release = 0;
if release == 0

    fprintf("Which releases: \n")
    fprintf("1. 2023 \n")
    fprintf("2. 2024 \n")
    fprintf("3. new turtle \n")

    while release <= 0 || release > 3
        release = input('');
    end
end

%% load data info
[turtle_nm, turtle_name, name_table_agm, name_table_axy, name_table_calib, turtle_raw_name, turtle_ypr_name, turtle_dive_name, turtle_dive_plt_name, turtle_dive_fft_name, turtle_DBA_name, turtle_DBA_name_paper, turtle_dive_name_din, turtle_dive_plt_name_din, turtle_dive_fft_name_din, turtle_DBA_name_paper_din, turtle_freq_name, carapace_model] = turtle_info(0, release);

if main_num > 1 % not exe at the beginning of main 1
	if exist('depth_step', 'var') == 0 || clear_workspace == 1
		step_data_def
	end
end