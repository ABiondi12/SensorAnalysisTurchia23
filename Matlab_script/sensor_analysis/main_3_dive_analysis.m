% main_3_dive_analysis
% 
% This script it is demanded to estrapolate and save dives from the 
% original dataset into a properly created struct, in order to perform
% statistical analysis using only data of dives. Dives are classified
% depending on:
%	- maximum depth
%	- shape
%	- offshore-inshore
%	- day-night
%
% Moreover, on every single dataset, it is computed a time-frequency
% analysis so as to highlight the presence of dominant frequencies and
% an energy index (ODBA) is obtain so as to evaluate how many energy is
% required for the turtle in performing that movement.
%
% It is also implemented a rudimental criterion with which try to
% classify dives among U, S and V type (to be refined yet)
%
% By going deeper, the script is organized as follow:
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 1. creation of dive dataset structure
%
%		create the structs used for hosting dives information, one for big
%		dives (max_depth > 5m), one for shallow dives (1m < max_depth <=
%		5m), and one for sub surface dives (max_depth <= 1m). 
%		This is done by calling "dive_dataset_creation" script, thus refers
%		to it for more details.
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 2. dive information selection
%
%		here dives are selected and isolated from the entire dataset and
%		the dive struct is so populated, by dividing dives into the three
%		categories related to the maximum reached depth (big, shallow, and
%		sub-surface dives). For big dives only, there is also the
%		evaluation and assignment of a shape to the dive (among s, v, u,
%		m).
%		Dive struct is then created, for the three dive categories, and 
%		populated for every dive with information about datetime, time of
%		beginning and end, depth profile, acc, mag, gyro, shape of the dive
%		(for big dive only)... The struct is then saved with the name
%		"turtle_dive_***" (*** = name of the turtle).
%		
%		This entire part is demanded to the script "run_dive_analysis",
%		thus refer to it for more details.
%
%		In this script, it is also computed the ODBA energy index for the
%		entire dataset and for each single dive. ODBA computation is
%		performed through a call of the script "dive_DBA_homing", which
%		populates both ODBA and ODBA_paper. These two fields of the dive 
%		struct differ for the window over which is computed a mean of the
%		value of the energy index.
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 3. offshore-inshore and day-night information and statistics
% 
%		Here, there is the evaluation of every dive collocation in time
%		(day-night) and space (offshore-inshore) and the assignment of
%		these flags to every dive in the previously created structure. 
%
%		Then, there are some statistics (min, max, median, mean,
%		quartile...) relative to:
%		- time spent offshore-inshore
%		- time of dive during night-day
%		- time of dive in combination off/inshore and day/night
%		- depth of dive during night/day
%		- depth of dive offshore/inshore
%		- depth of dive for combination day/night and off/inshore
%
%	It is also implemented by keeping into account dive shape (for big dive
%	only).
%
%	All these values are computed inside "dive_analysis_paper" script,
%	thus refer to it for more details.
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 4. short-time Fourier transform execution over dives and plot
%
%		Here, for the entire dataset and then for every dive, separately,
%		it is evaluated and plotted a time-frequency analysis, performed  
%		using a short-time Fourier transform over the acceleration data.
%		This evaluation is performed to highlight dominant frequencies over 
%		the acceleration of the turtle that can be eventually associated to 
%		its flippers beat.
%		Plot are shown w.r.t. depth profile in order to study the variation 
%		and presence/absence of a dominant frequency depending on the 
%		turtle behaviour.
%
%	These operations are implemented into the scripts:
%	"dive_turtle_fft_ft_light" and "stft_aligned_plot", thus refer to them
%	for more details.
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 5. ODBA analysis
%
%		Here, there is the evaluation of ODBA and VeDBA values associated 
%		to each dive and shallow section, adapted to the requirement that
%		has been chosen to be used in the paper results.
%
%		Here is also performed division among descent, bottom, and ascent 
%		phases, in order to evaluate if energetic index differs 
%		significantly depending on turtle behavior.
%
% mean ODBA and mean VeDBA
%		Computation for each section of the average value assumed by ODBA 
%		and VeDBA. Then, separate the descent, bottom, and ascent phases
%		for the dives, so as to compare them to each other.
%
% ODBA: mean and variance
%		There will be a single reference value for each dives and each 
%		surface phases (that is for periods between two consecutive dives).
%
%	This is implemented inside the script "mean_ODBA_paper", thus refer to
%	it for more details.
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 6. single stft plot
%
%		Here, for a single big dive, shallow dive and sub surface period,
%		it is possible to evaluate and plot a time-frequency analysis,   
%		performed using a short-time Fourier transform over the acc data.
%		This evaluation is performed to highlight dominant frequencies over 
%		the acceleration of the turtle that can be eventually associated to 
%		its flippers beat.
%		Plot are shown w.r.t. depth profile in order to study the variation 
%		and presence/absence of a dominant frequency depending on the 
%		turtle behaviour.
%
%	The period has to be chosen at the beginning of the running session.

%% init
if exist('all_together', 'var') == 0
    % metti qua il load dei dati che servono
	
	clear_all_variables
	
    flag_def
	  
    [turtle_name, name_table_agm, name_table_axy, name_table_calib, turtle_raw_name, turtle_ypr_name, turtle_dive_name, turtle_dive_fft_name, turtle_DBA_name, turtle_DBA_name_paper, turtle_freq_name] = turtle_info(0);
	
	if exist('raw_data_struct', 'var') == 0
		fprintf('load raw values \n')
		load_raw_data
	else
		if strcmp(raw_data_struct.name, turtle_name)
			fprintf('raw data already present in the workspace \n')
		else
			fprintf('raw data referred to another turtle are already present in the workspace \n')
			unconsistent_turtle = 0;
			fprintf('Do you want to use the selected turtle or the one present in the workspace? \n')
			fprintf('1. Workspace \n')
			fprintf('2. Last selected \n')
			while unconsistent_turtle < 1 || unconsistent_turtle > 2
				turtle_switch = input('');
			end
			if turtle_switch == 1
				[turtle_name, name_table_agm, name_table_axy, name_table_calib, turtle_raw_name, turtle_ypr_name, turtle_dive_name, turtle_dive_fft_name, turtle_DBA_name, turtle_DBA_name_paper, turtle_freq_name] = turtle_info(raw_data_struct.ID);
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
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% creation of dive dataset structure
dive_dataset_creation	 

%% dive information selection			 
run_dive_analysis	% also ODBA computation (call of dive_DBA_homing)
					% dive_DBA_homing populates both ODBA and ODBA_paper,
					% which differ for the window over which is computed a
					% mean of the value of the energy index.

%% offshore-inshore and day-night information and statistics
dive_analysis_paper	

%% save dive struct (ODBA included)
save_dive_data
