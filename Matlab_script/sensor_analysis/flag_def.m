%% flag definition
% These variables are used as shortcut for obtaining an higher level of
% automatism (options are automatically selected at the beginning and not
% asked during the code execution).

choose_data = 1;			% if 0, choose of data to be shown by input
							% if 1, automatic elaboration of all data (suggested)		
							
auto_calib = 1;				% if 0, choose if to perform calibration on mf data
							% if 1, automatic perform of calibration on mf data (suggested)
							
auto_calib_use = 1;			% if 0, choose if to use calibrated mf data
							% if 1, automatically use calibrated mf data (suggested)
							
auto_calib_datetime	 = 1;	% if 1, automatic datetime insertion (suggested)
							% if 0, manual datetime insertion
							
auto_column_together = 1;	% if 1, date and time information are taken 
							% as in the same column (suggested)	

auto_norm_g_mf_angle = 0;	% if 0, not show these values (suggested)
							% if 1, you can choose to show this values
							
							% note: norm is automatically calculated since
							% it is necessary for other operation, while
							% the angle between g and mf is computed only
							% if requested from the user (with this flag
							% equal to 1)
auto_freq_selection = 1;    % if 0, choose the data acquisition frequencies
							% if 1, default values based on collected data
							% in 2023 dataset.
%% new flags

step_saving = 1;			% if 1, the code saves partial results
							% if 0, the code only produces the final
							% elaborations
							
plt_version = 0;			% if 1, create another dataset having wider dive margins
	
raw_plt_show = 1;
calib_plt_show = 1;
ypr_plt_show = 0;

%% plot variables
if exist('id_plot', 'var') == 0
	id_plot = 1;
end

if exist('dim_font', 'var') == 0
	dim_font = 30;
end

if exist('dim_fontb', 'var') == 0
	dim_fontb = 15;
end

%% add path
addpath("fcn");
addpath("general_scripts");
addpath("main");
addpath("main_1_scripts");
addpath("main_2_scripts");
addpath("main_3_scripts");
addpath("main_4_scripts");
addpath("main_5_scripts");
addpath("save_scripts");
addpath("load_scripts");
addpath("csv_file");
addpath("csv_file\Turchia2023");
addpath("csv_file\Turchia2023\Banu-C");
addpath("csv_file\Turchia2023\Banu-C\axy");
addpath("csv_file\Turchia2023\Didar-F");
addpath("csv_file\Turchia2023\Emine-D");
addpath("csv_file\Turchia2023\Emine-D\axy");
addpath("csv_file\Turchia2023\Fati-E");
addpath("csv_file\Turchia2023\Fati-E\axy");
addpath("csv_file\Turchia2023\Melis-B");
addpath("csv_file\Turchia2023\Melis-B\axy");
addpath("csv_file\Turchia2023\Sevval-A");
addpath("csv_file\Turchia2023\Deniz");
addpath("csv_file\Turchia2023\Elif");
addpath("csv_file\Turchia2023\Funda");
addpath("csv_file\Turchia2024");
addpath("csv_file\Turchia2024\calibration\");

addpath("csv_file\Turchia2024\Enes");
addpath("csv_file\Turchia2024\Enes\axy");
addpath("csv_file\Turchia2024\Atakan");
addpath("csv_file\Turchia2024\Atakan\axy");
addpath("csv_file\Turchia2024\Fatma");
addpath("csv_file\Turchia2024\Fatma\axy");
addpath("csv_file\Turchia2024\Ilkim");
addpath("csv_file\Turchia2024\Ilkim\axy");
addpath("csv_file\Turchia2024\Nurdan");
addpath("csv_file\Turchia2024\Nurdan\axy");
addpath("csv_file\Turchia2024\Paula");
addpath("csv_file\Turchia2024\Paula\axy");
addpath("csv_file\Turchia2024\Arya");
addpath("csv_file\Turchia2024\Arya\axy");
addpath("csv_file\Turchia2024\Bihter");
addpath("csv_file\Turchia2024\Bihter\axy");
addpath("csv_file\Turchia2024\Erica");
addpath("csv_file\Turchia2024\Erica\axy");
addpath("csv_file\Turchia2024\Benedetta");
addpath("csv_file\Turchia2024\Benedetta\axy");

%% correct dataset - DO NOT change this section
% There is an error in Didar dataset (missing one second), thus the code
% automatically adjust the dataset by cloning the previous second in the
% missing one.
if exist('name_table_modify', 'var') == 0
	name_table_modify	= 'Didar_agm.csv';
end