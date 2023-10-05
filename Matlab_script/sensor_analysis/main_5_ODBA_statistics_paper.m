% main_5_ODBA_statistics_paper
%
%	In this script there is the evaluation of ODBA statistics, like:
%		- max
%		- mean
%		- std
%		- range
%		- median
%		- quartile
%
%	among the dives computed by the turtle, grouped into big, shallow and 
%	sub surface. Moreover, only for big dives, the same evaluations are 
%	also performed by keeping into account the different dives shapes. 
%	Finally, again for big dives only, the same statistic parameters are
%	computed for the descent, bottom and ascent phases of the dives.
%
%	Then, the same parameters are finally evaluated for dives grouped also
%	depending on their spatial (offshore-inshore) and temporal (day-night)
%	distributions, and for combinations of the two (off-day, off-night,
%	in-day, in-night). Also with this additional division, the parameters
%	are computed for the various dive phases (descent, bottom, ascent) and
%	by keeping into account only s-shaped dives.


%% init
if exist('all_together', 'var') == 0
    % metti qua il load dei dati che servono
	
	clear_all_variables
	
    flag_def
    [turtle_nm, turtle_name, name_table_agm, name_table_axy, name_table_calib, turtle_raw_name, turtle_ypr_name, turtle_dive_name, turtle_dive_fft_name, turtle_DBA_name, turtle_DBA_name_paper, turtle_dive_name_din, turtle_dive_fft_name_din, turtle_DBA_name_paper_din, turtle_freq_name] = turtle_info(0);
	
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
				[turtle_nm, turtle_name, name_table_agm, name_table_axy, name_table_calib, turtle_raw_name, turtle_ypr_name, turtle_dive_name, turtle_dive_fft_name, turtle_DBA_name, turtle_DBA_name_paper, turtle_dive_name_din, turtle_dive_fft_name_din, turtle_DBA_name_paper_din, turtle_freq_name] = turtle_info(raw_data_struct.ID);
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
	
	if exist('turtle_DBA_paper', 'var') == 0
		fprintf('load ODBA paper values \n')
		load_ODBA_paper_data
	else
		if strcmp(turtle_DBA_paper.name, turtle_name)
			fprintf('ODBA paper data already present in the workspace \n')
		else
			fprintf('ODBA paper data referred to another turtle are already present in the workspace \n')
			fprintf('overwrite operation: start load ODBA paper data referred to the current turtle... \n')
			load_ODBA_paper_data
			fprintf('overwrite operation: completed \n')				
		end
	end
end

%% evaluate dive division

if exist('id_plot', 'var') == 0
	id_plot = 1;
end 
dim_font	= 30;
dim_fontb	= 20;
BW = 1;
% total amount of time lasts in big, shallow and sub surface

%% Load structure

% if exist('turtle_dive.mat', 'var')  == 0
% 	load('turtle_dive.mat')
% end

% if exist('turtle_DBA_paper.mat', 'var')  == 0
% 	load('turtle_DBA_paper.mat')
% end

if (exist('sunrise_hour.mat', 'var') == 0) || (exist('sunset_hour.mat', 'var') == 0)
	if (exist('sunrise_hour.mat', 'file') == 2) && (exist('sunset_hour.mat', 'file') == 2)
		load('sunrise_hour.mat')
		load('sunset_hour.mat')
	else
		sunrise_sunset_hour
	end
end

[total_amount_day, total_amount_night] = day_night_amount(datetime_acc, sunrise_hour, sunset_hour);


ODBA_statistics_paper
ODBA_statistics_paper_din



