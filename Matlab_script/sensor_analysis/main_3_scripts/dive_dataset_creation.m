% dive_dataset_creation
% This script handles the creation of dive dataset structures used for 
% hosting a single dive information. In particular, there are created three 
% structs:
%	- one for big dives			(max_depth > 5m)
%	- one for shallow dives		(1m < max_depth <= 5m)
%	- one for sub surface dives (max_depth <= 1m)
%	
% Each struct (lets say dive_info) has the following fields:
%
% 	dive_info.datatime			- date and time info of the dive duration (acc freq)
%	dive_info.datatime_depth	- date and time info of the dive duration (depth freq)
%	dive_info.time_in			- start datetime of the dive
%	dive_info.time_f			- stop datetime of the dive
%	dive_info.type				- type of dive (meaningful for big dive only)
%	dive_info.depth				- depth profile of the dive 
%	dive_info.accx				- acceleration along x axis during the dive 
%	dive_info.accy				- acceleration along y axis during the dive
%	dive_info.accz				- acceleration along z axis during the dive
%	dive_info.yaw				- yaw angle during the dive
%	dive_info.pitch				- pitch angle during the dive
%	dive_info.roll				- roll angle during the dive
%	dive_info.ODBA				- ODBA energy index computed during the dive
%	dive_info.ODBA_mean			- mean of ODBA for the entire dive (single value)
%	dive_info.ODBA_var			- variance of ODBA for the entire dive (single value)
%	dive_info.ODBA_paper		- ODBA energy index computed during the
%									dive (smoothed version)
%
% There are also these other fields, but for now they are unused:
%
%	dive_info.VeDBA
%	dive_info.VeDBA_mean
%	dive_info.VeDBA_var
%	dive_info.AAV
%


% general information

%% big dive data: over 5m depth
if ~exist('dive_data', 'var')
	dive_data = struct('datatime', [], 'datatime_depth', [], 'time_in', [], 'time_f', [], 'type', [], 'depth', [], 'accx', [], 'accy', [], 'accz', [], 'yaw', [], 'pitch', [], 'roll', [], 'ODBA', [], 'ODBA_mean', [], 'ODBA_var', [], 'ODBA_paper', [], 'VeDBA', [], 'VeDBA_mean', [], 'VeDBA_var', [], 'AAV', []);
end

if ~exist('empty_dive', 'var')
	empty_dive = dive_data;
	empty_dive.datatime = [];
	empty_dive.datatime_depth = [];
	empty_dive.time_in = [];
	empty_dive.time_f = [];
	empty_dive.type = [];
	empty_dive.depth = [];
	empty_dive.accx = [];
	empty_dive.accy = [];
	empty_dive.accz = [];
	empty_dive.yaw = [];
	empty_dive.pitch = [];
	empty_dive.roll = [];
	empty_dive.ODBA = [];
	empty_dive.ODBA_mean = [];
	empty_dive.ODBA_var = [];
	empty_dive.ODBA_paper = [];
end

if ~exist('dive_data_din', 'var')
	dive_data_din = struct('datatime', [], 'datatime_depth', [], 'time_in', [], 'time_f', [], 'type', [], 'depth', [], 'dinx', [], 'diny', [], 'dinz', [], 'yaw', [], 'pitch', [], 'roll', [], 'ODBA', [], 'ODBA_mean', [], 'ODBA_var', [] , 'ODBA_paper', [], 'VeDBA', [], 'VeDBA_mean', [], 'VeDBA_var', [], 'AAV', []);
end

if ~exist('empty_dive_din', 'var')
	empty_dive_din = dive_data_din;
	empty_dive_din.datatime = [];
	empty_dive_din.datatime_depth = [];
	empty_dive_din.time_in = [];
	empty_dive_din.time_f = [];
	empty_dive_din.type = [];
	empty_dive_din.depth = [];
	empty_dive_din.dinx = [];
	empty_dive_din.diny = [];
	empty_dive_din.dinz = [];
	empty_dive_din.yaw = [];
	empty_dive_din.pitch = [];
	empty_dive_din.roll = [];
	empty_dive_din.ODBA = [];
	empty_dive_din.ODBA_mean = [];
	empty_dive_din.ODBA_var = [];
	empty_dive_din.ODBA_paper = [];
end

%% shallow dive data: between 1m and 5m depth
if ~exist('sdive_data', 'var')
	sdive_data = struct('datatime', [], 'datatime_depth', [], 'time_in', [], 'time_f', [], 'depth', [], 'accx', [], 'accy', [], 'accz', [], 'yaw', [], 'pitch', [], 'roll', [], 'ODBA', [], 'ODBA_mean', [], 'ODBA_var', [], 'ODBA_paper', [], 'VeDBA', [], 'VeDBA_mean', [], 'VeDBA_var', [], 'AAV', []);
end

if ~exist('empty_sdive', 'var')
	empty_sdive = sdive_data;
	empty_sdive.datatime = [];
	empty_sdive.datatime_depth = [];
	empty_sdive.time_in = [];
	empty_sdive.time_f = [];
	empty_sdive.depth = [];
	empty_sdive.accx = [];
	empty_sdive.accy = [];
	empty_sdive.accz = [];
	empty_sdive.yaw = [];
	empty_sdive.pitch = [];
	empty_sdive.roll = [];
	empty_sdive.ODBA = [];
	empty_sdive.ODBA_mean = [];
	empty_sdive.ODBA_var = [];
	empty_sdive.ODBA_paper = [];
end

if ~exist('sdive_data_din', 'var')
	sdive_data_din = struct('datatime', [], 'datatime_depth', [], 'time_in', [], 'time_f', [], 'depth', [], 'dinx', [], 'diny', [], 'dinz', [], 'yaw', [], 'pitch', [], 'roll', [], 'ODBA', [], 'ODBA_mean', [], 'ODBA_var', [], 'ODBA_paper', [], 'VeDBA', [], 'VeDBA_mean', [], 'VeDBA_var', [], 'AAV', []);
end

if ~exist('empty_sdive_din', 'var')
	empty_sdive_din = sdive_data_din;
	empty_sdive_din.datatime = [];
	empty_sdive_din.datatime_depth = [];
	empty_sdive_din.time_in = [];
	empty_sdive_din.time_f = [];
	empty_sdive_din.depth = [];
	empty_sdive_din.dinx = [];
	empty_sdive_din.diny = [];
	empty_sdive_din.dinz = [];
	empty_sdive_din.yaw = [];
	empty_sdive_din.pitch = [];
	empty_sdive_din.roll = [];
	empty_sdive_din.ODBA = [];
	empty_sdive_din.ODBA_mean = [];
	empty_sdive_din.ODBA_var = [];
	empty_sdive_din.ODBA_paper = [];	
end

%% sub surface data: until 1 m depth
if ~exist('sup_data', 'var')
	sup_data = struct('datatime', [], 'datatime_depth', [], 'time_in', [], 'time_f', [], 'depth', [], 'accx', [], 'accy', [], 'accz', [], 'yaw', [], 'pitch', [], 'roll', [], 'ODBA', [], 'ODBA_mean', [], 'ODBA_var', [] ,'ODBA_paper', [], 'VeDBA', [], 'VeDBA_mean', [], 'VeDBA_var', [], 'AAV', []);
end

if ~exist('empty_sup', 'var')
	empty_sup = sup_data;
	empty_sup.datatime = [];
	empty_sup.datatime_depth = [];
	empty_sup.time_in = [];
	empty_sup.time_f = [];
	empty_sup.depth = [];
	empty_sup.accx = [];
	empty_sup.accy = [];
	empty_sup.accz = [];
	empty_sup.yaw = [];
	empty_sup.pitch = [];
	empty_sup.roll = [];
	empty_sup.ODBA = [];
	empty_sup.ODBA_mean = [];
	empty_sup.ODBA_var = [];
	empty_sup.ODBA_paper = [];
end

if ~exist('sup_data_din', 'var')
	sup_data_din = struct('datatime', [], 'datatime_depth', [], 'time_in', [], 'time_f', [], 'depth', [], 'dinx', [], 'diny', [], 'dinz', [], 'dinx_nw', [], 'diny_nw', [], 'dinz_nw', [], 'yaw', [], 'pitch', [], 'roll', [], 'ODBA', [], 'ODBA_mean', [], 'ODBA_var', [], 'ODBA_paper', [], 'ODBA_nw', [], 'ODBA_mean_nw', [], 'ODBA_var_nw', [], 'ODBA_paper_nw', [], 'VeDBA', [], 'VeDBA_nw', [], 'VeDBA_mean', [], 'VeDBA_var', [], 'AAV', []);
end

if ~exist('empty_sup_din', 'var')
	empty_sup_din = sup_data_din;
	empty_sup_din.datatime = [];
	empty_sup_din.datatime_depth = [];
	empty_sup_din.time_in = [];
	empty_sup_din.time_f = [];
	empty_sup_din.depth = [];
	empty_sup_din.dinx = [];
	empty_sup_din.diny = [];
	empty_sup_din.dinz = [];
	empty_sup_din.dinx_nw = [];
	empty_sup_din.diny_nw = [];
	empty_sup_din.dinz_nw = [];
	empty_sup_din.yaw = [];
	empty_sup_din.pitch = [];
	empty_sup_din.roll = [];
	empty_sup_din.ODBA = [];
	empty_sup_din.ODBA_mean = [];
	empty_sup_din.ODBA_var = [];
	empty_sup_din.ODBA_paper = [];
	empty_sup_din.ODBA_nw = [];
	empty_sup_din.ODBA_mean_nw = [];
	empty_sup_din.ODBA_var_nw = [];
	empty_sup_din.ODBA_paper_nw = [];
end
	