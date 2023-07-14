% dive_dataset_creation

% general information

%% big dive data: over 5m depth
if ~exist('dive_data', 'var')
	dive_data = struct('datatime', [], 'time_in', [], 'time_f', [], 'type', [], 'depth', [], 'accx', [], 'accy', [], 'accz', [], 'yaw', [], 'pitch', [], 'roll', [], 'ODBA', [], 'ODBA_mean', [], 'ODBA_var', [], 'ODBA_paper', [], 'VeDBA', [], 'VeDBA_mean', [], 'VeDBA_var', [], 'AAV', []);
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
	dive_data_din = struct('datatime', [], 'time_in', [], 'time_f', [], 'type', [], 'depth', [], 'dinx', [], 'diny', [], 'dinz', [], 'yaw', [], 'pitch', [], 'roll', [], 'ODBA', [], 'ODBA_mean', [], 'ODBA_var', [] , 'ODBA_paper', [], 'VeDBA', [], 'VeDBA_mean', [], 'VeDBA_var', [], 'AAV', []);
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
	sdive_data = struct('datatime', [], 'time_in', [], 'time_f', [], 'depth', [], 'accx', [], 'accy', [], 'accz', [], 'yaw', [], 'pitch', [], 'roll', [], 'ODBA', [], 'ODBA_mean', [], 'ODBA_var', [], 'ODBA_paper', [], 'VeDBA', [], 'VeDBA_mean', [], 'VeDBA_var', [], 'AAV', []);
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
	sdive_data_din = struct('datatime', [], 'time_in', [], 'time_f', [], 'depth', [], 'dinx', [], 'diny', [], 'dinz', [], 'yaw', [], 'pitch', [], 'roll', [], 'ODBA', [], 'ODBA_mean', [], 'ODBA_var', [], 'ODBA_paper', [], 'VeDBA', [], 'VeDBA_mean', [], 'VeDBA_var', [], 'AAV', []);
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
	sup_data = struct('datatime', [], 'time_in', [], 'time_f', [], 'depth', [], 'accx', [], 'accy', [], 'accz', [], 'yaw', [], 'pitch', [], 'roll', [], 'ODBA', [], 'ODBA_mean', [], 'ODBA_var', [] ,'ODBA_paper', [], 'VeDBA', [], 'VeDBA_mean', [], 'VeDBA_var', [], 'AAV', []);
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
	sup_data_din = struct('datatime', [], 'time_in', [], 'time_f', [], 'depth', [], 'dinx', [], 'diny', [], 'dinz', [], 'dinx_nw', [], 'diny_nw', [], 'dinz_nw', [], 'yaw', [], 'pitch', [], 'roll', [], 'ODBA', [], 'ODBA_mean', [], 'ODBA_var', [], 'ODBA_paper', [], 'VeDBA', [], 'VeDBA_mean', [], 'VeDBA_var', [], 'AAV', []);
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
end
	