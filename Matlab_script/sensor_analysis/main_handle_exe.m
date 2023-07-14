% main_handle_exe

clear
clc
close all

dim_font	= 30;
dim_fontb	= 15;
id_plot		= 1;

%% add path
addpath("fcn");
addpath("main_1_scripts");
addpath("main_2_scripts");
addpath("main_3_scripts");
addpath("main_4_scripts");
addpath("csv_file");
addpath("csv_file\old_trial");
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

%% main_launch
fprintf('1. Start raw data elaboration \n')
main_1_raw_data

fprintf('2. Start ypr computation \n')
main_2_ypr

fprintf('3. Start dives analysis and stft \n')
main_3_dive_analysis

fprintf('4. Start ODBA computation \n')
main_4_ODBA_statistics_paper

%% table creation
fprintf('5. Start table creation \n')
tab_dives_entire
fprintf('Table correctly created and saved \n')