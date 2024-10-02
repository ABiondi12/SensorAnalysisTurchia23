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
clc
close all
clear
clearvars

%% flag definition
% These variables are used as shortcut for obtaining an higher level of
% automatism (options are automatically selected at the beginning and not
% asked during the code execution).

flag_def

% all_together = 0;           % if exists, the code is executed all together, otherwise you have to call each main_i separately and in order

%% main_launch
fprintf('1. Start raw data elaboration \n')
main_1_raw_data
from_main_1 = 1;

fprintf('2. Start ypr computation \n')
main_2_ypr
from_main_2 = 1;

fprintf('3. Start dives analysis and ODBA \n')
main_3_dive_analysis
from_main_3 = 1;

fprintf('4. Start stft computation \n')
main_4_stft
from_main_4 = 1;

% fprintf('5. Start ODBA evaluation \n')
main_5_ODBA_statistics_paper

%% table creation
% fprintf('6. Start table creation \n')
tab_dives_entire
% fprintf('Table correctly created and saved \n')

clear all_together