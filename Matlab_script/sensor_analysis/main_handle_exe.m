% main_handle_exe
%
% This script is the main one, that has to be launched in order to execute
% an entire evaluation of a single turtle dataset relative to a period of
% open sea swimming, like the homing period.
%
% There are simply called some sub-main scripts, each of them executing a
% different group of tasks, from raw data loading and reorientation, to
% stft evaluation, dives division and analysis and energy indices over each
% of them.
%
% The other main scripts that are recalled from here are, in order:
%
%	1. main_1_raw_data
%	2. main_2_ypr
%	3. main_3_dive_analysis
%	4. main_4_ODBA_statistics_paper
%
% Refers to each of them, separately, by calling "help name_of_the_script"
% for knowing what is executed inside of each specific sub-main script.
%
% At the very end, after every sub-main scripts has been executed, a table
% that summarize the results is created and saved.

%% start
clear
clc
close all

dim_font	= 30;
dim_fontb	= 15;
id_plot		= 1;

%% dataset correction - DO NOT change this section
% There is an error in Didar dataset (missing one second).
name_table_modify	= 'Didar_agm.csv';	% not to be changed

%% flag definition

choose_data = 1;	% if 0, choose of data to be shown by input
					% if 1, automatic elaboration of all data (suggested)								
auto_calib = 1;		% if 0, choose if to perform calibration on mf data
					% if 1, automatic perform of calibration on mf data (suggested)
auto_calib_use = 1; % if 0, choose if to use calibrated mf data
					% if 1, automatically use calibrated mf data (suggested)
auto_calib_datetime	 = 1;	% if 1, automatic datetime insertion (suggested)
							% if 0, manual datetime insertion
auto_column_together = 1;	% if 1, date and time information are taken 
							% as in the same column (suggested)	
						
%% add path
addpath("fcn");
addpath("main_1_scripts");
addpath("main_2_scripts");
addpath("main_3_scripts");
addpath("main_4_scripts");
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

%% file name selection: to be updated for every new elaboration

turtle_info	

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