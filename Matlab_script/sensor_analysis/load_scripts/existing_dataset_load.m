% existing_dataset_load

%% load existing dataset
if exist('all_together', 'var') == 0
	
    if exist('added_once', 'var') == 0
        addpath("C:\Users\UTENTE\Documents\GitHub\SensorAnalysisTurchia23\Matlab_script\sensor_analysis\general_scripts")
	    add_path;
    end

    if main_num == 1 || (main_num == 2 && exist('from_main_1', 'var') == 0) || (main_num == 3 && exist('from_main_2', 'var') == 0) || (main_num == 4 && exist('from_main_3', 'var') == 0) || (main_num == 5 && exist('from_main_4', 'var') == 0)
    %% variables definition and turtle selection
	    init_load
    end

	if main_num > 1
		%% Raw dataset
		raw_dataset_load
		
		if main_num > 2
			%% YPR dataset
			ypr_dataset_load

			if main_num > 3
				%% dives dataset
				dive_dataset_load

				if main_num > 4
					%% ODBA dataset
					odba_dataset_load
					single_main_5_load
				else
					single_main_4_load
				end
			else
				single_main_3_load
			end
		else
			single_main_2_load
		end
    end
else
    %% release
    if exist('release', 'var') == 0 && exist('turtle_nm', 'var') == 0
        release = 0;
        if release == 0
        
            fprintf("Which releases: \n")
            fprintf("1. 2023 \n")
            fprintf("2. 2024 \n")
            fprintf("New turtle \n")
            while release <= 0 || release > 3
                release = input('');
            end
        end
    
        %% Turle name selection
        % Selection of the turtle and variables name definition
        [turtle_nm, turtle_name, name_table_agm, name_table_axy, name_table_calib, turtle_raw_name, turtle_ypr_name, turtle_dive_name, turtle_dive_plt_name, turtle_dive_fft_name, turtle_DBA_name, turtle_DBA_name_paper, turtle_dive_name_din, turtle_dive_plt_name_din, turtle_dive_fft_name_din, turtle_DBA_name_paper_din, turtle_freq_name, carapace_model] = turtle_info(0, release);
    end
end