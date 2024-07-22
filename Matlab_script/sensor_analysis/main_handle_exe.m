% main_handle_exe
%
% This script is the main one, that has to be launched in order to execute
% an entire evaluation of a single turtle dataset relative to a period of
% open sea swimming, like the homing period.
%
% There are simply called some sub-main scripts, each of them executing a
% different group of tasks, from raw data loading and reorientation, to
% stft evaluation, dives division and analysis of energy indices over each
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
% At the beginning, there is the selection of some flag for obtaining a
% higher level of automatization of the code execution. By keeping the flag
% equal to 1, the related decision is already selected (with the suggested
% option) and there is no control from the user during the code execution.
%
% At the very end, after every sub-main scripts has been executed, a table
% that summarize the results is created and saved.

%% start
clear
clc
close all

%% dataset correction - DO NOT change this section
% There is an error in Didar dataset (missing one second), thus the code
% automatically adjust the dataset by cloning the previous second in the
% missing one.
name_table_modify	= 'Didar_agm.csv';	% not to be changed

all_together = 0;           % if exists, the code is executed all together, otherwise you have to call each main_i separately and in order

release = 0;

%% release
if release == 0

    fprintf("Which releases: \n")
    fprintf("1. 2023 \n")
    fprintf("2. 2024 \n")

    while release <= 0 || release > 2
        release = input('');
    end
end


%% flag definition
% These variables are used as shortcut for obtaining an higher level of
% automatism (options are automatically selected at the beginning and not
% asked during the code execution).

flag_def

%% Turle name selection
% Selection of the turtle and variables name definition
[turtle_nm, turtle_name, name_table_agm, name_table_axy, name_table_calib, turtle_raw_name, turtle_ypr_name, turtle_dive_name, turtle_dive_plt_name, turtle_dive_fft_name, turtle_DBA_name, turtle_DBA_name_paper, turtle_dive_name_din, turtle_dive_plt_name_din, turtle_dive_fft_name_din, turtle_DBA_name_paper_din, turtle_freq_name] = turtle_info(0, release);

%% main_launch
fprintf('1. Start raw data elaboration \n')
main_1_raw_data

fprintf('2. Start ypr computation \n')
main_2_ypr

% fprintf('3. Start dives analysis and ODBA \n')
% main_3_dive_analysis

% fprintf('4. Start stft computation \n')
% main_4_stft

% fprintf('5. Start ODBA evaluation \n')
% main_5_ODBA_statistics_paper

%% table creation
% fprintf('6. Start table creation \n')
% tab_dives_entire
% fprintf('Table correctly created and saved \n')

clear all_together