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
							
%% new flags

step_saving = 1;			% if 1, the code saves partial results
							% if 0, the code only produces the final
							% elaborations
%% add path
addpath("fcn");
addpath("main_1_scripts");
addpath("main_2_scripts");
addpath("main_3_scripts");
addpath("main_4_scripts");
addpath("main_5_scripts");
addpath("save_scripts");
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
