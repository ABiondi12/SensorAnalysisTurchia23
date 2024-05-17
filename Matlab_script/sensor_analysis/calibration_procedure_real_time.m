% calibration procedure 
%% start
clear
clc
close all

%% flag definition
% These variables are used as shortcut for obtaining an higher level of
% automatism (options are automatically selected at the beginning and not
% asked during the code execution).

flag_def

%% load_calibration_dataset
[turtle_nm, turtle_name, name_table_agm, name_table_axy, name_table_calib, turtle_raw_name, turtle_ypr_name, turtle_dive_name, turtle_dive_plt_name, turtle_dive_fft_name, turtle_DBA_name, turtle_DBA_name_paper, turtle_dive_name_din, turtle_dive_plt_name_din, turtle_dive_fft_name_din, turtle_DBA_name_paper_din, turtle_freq_name] = turtle_info(0);	

%% main_launch

auto_calib_datetime = 0; % manually insert calibration start and stop time
fprintf('1. Start raw data elaboration \n')
main_1_raw_data
