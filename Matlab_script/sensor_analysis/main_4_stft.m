% main_4_stft

%% init
if exist('all_together', 'var') == 0
    % metti qua i load dei dati grezzi che sono derivanti dal main1 e il
    % nome della tartaruga, altrimenti hai già tutto dal main1
	
	clear_all_variables
	
    flag_def
    [turtle_nm, turtle_name, name_table_agm, name_table_axy, name_table_calib, turtle_raw_name, turtle_ypr_name, turtle_dive_name, turtle_dive_fft_name, turtle_DBA_name, turtle_DBA_name_paper, turtle_freq_name] = turtle_info(0);
	
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
				[turtle_nm, turtle_name, name_table_agm, name_table_axy, name_table_calib, turtle_raw_name, turtle_ypr_name, turtle_dive_name, turtle_dive_fft_name, turtle_DBA_name, turtle_DBA_name_paper, turtle_freq_name] = turtle_info(raw_data_struct.ID);
			elseif turtle_switch == 2
				fprintf('overwrite operation: start load raw data referred to the current turtle... \n')
				load_raw_data
				fprintf('overwrite operation: completed \n')				
			end
		end
	end
	
	if exist('ypr_data_struct', 'var') == 0
		fprintf('load ypr values \n')
		load_ypr_data
	else
		if strcmp(ypr_data_struct.name, turtle_name)
			fprintf('ypr data already present in the workspace \n')
		else
			fprintf('ypr data referred to another turtle are already present in the workspace \n')
			fprintf('overwrite operation: start load ypr data referred to the current turtle... \n')
			load_ypr_data
			fprintf('overwrite operation: completed \n')				
		end
	end
	
		if exist('turtle_dive', 'var') == 0
		fprintf('load single dives values \n')
		load_dive_data
	else
		if strcmp(turtle_dive.name, turtle_name)
			fprintf('single dives data already present in the workspace \n')
		else
			fprintf('single dives data referred to another turtle are already present in the workspace \n')
			fprintf('overwrite operation: start load single dives data referred to the current turtle... \n')
			load_dive_data
			fprintf('overwrite operation: completed \n')				
		end
	end
end

%% short-time Fourier transform execution over dives and plot
comp_stft = 0;
fprintf("Do you want to execute stft for big, shallow and sub-surface dives? \n")
fprintf("1. Yes \n")
fprintf("2. no \n")

while comp_stft < 1 || comp_stft > 2
	comp_stft = input('');
end

if comp_stft == 1
    dive_turtle_fft_ft_light		 
end

%% short-time Fourier transform plot over big dives
show_stft = 0;
fprintf("Do you want to see stft plot for big dives? \n")
fprintf("1. Yes \n")
fprintf("2. no \n")

while show_stft < 1 || show_stft > 2
	show_stft = input('');
end

if show_stft == 1
    stft_aligned_plot		 
end

%% ODBA analysis
mean_ODBA_paper

%% single stft plot

single_plot = 0;
first = 1;
again = 1;

while again == 1
		
	if first == 1
		
		fprintf("Do you want to see a single stft plot? \n")
		fprintf("1. Yes \n")
		fprintf("2. No \n")

		while single_plot < 1 || single_plot > 2
			single_plot = input('');
		end	
		
	elseif first == 0
		single_plot = again;
	end
	
	first = 0;
	
	if single_plot == 1
		
		fprintf("Single period plot: starting of the process... \n")
		stft_single_aligned_plot
		fprintf("Single period plot: process completed. \n")
		
		again = 0;
		fprintf("Do you want to see another single stft plot? \n")
		fprintf("1. Yes \n")
		fprintf("2. No \n")

		while again < 1 || again > 2
			again = input('');
		end
		
		if again ~= 1
			fprintf("Single period plot: ending of the process... \n")
		end
	else
		again = 0;
		fprintf("Single period plot: ending of the process... \n")
	end
end
fprintf("Single period plot: process ended. \n")