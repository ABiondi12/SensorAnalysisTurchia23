%% load .mat files for a single turtle
% FileData = load('turtle_dive_Banu.mat');
FileDataDin = load('turtle_dive_din_Banu.mat');

num_big = size(FileDataDin.turtle_dive_din.big_dive.homing, 2);
num_sh = size(FileDataDin.turtle_dive_din.shallow_dive.homing, 2);
num_sub = size(FileDataDin.turtle_dive_din.sub_surface.homing, 2);

min_length = 10; % at least 10 seconds
count = 0;

%% export into tables
% big_dive_Banu = struct2table(FileData.turtle_dive.big_dive.homing);
% shallow_dive_Banu = struct2table(FileData.turtle_dive.shallow_dive.homing);
% surface_dive_Banu = struct2table(FileData.turtle_dive.sub_surface.homing);
for i = 1:num_big
	str_big_dive_din_Banu(i).time_in = FileDataDin.turtle_dive_din.big_dive.homing(i).time_in;
	str_big_dive_din_Banu(i).time_f = FileDataDin.turtle_dive_din.big_dive.homing(i).time_f;
	str_big_dive_din_Banu(i).type = FileDataDin.turtle_dive_din.big_dive.homing(i).type;
	str_big_dive_din_Banu(i).depth = min(FileDataDin.turtle_dive_din.big_dive.homing(i).depth);
	str_big_dive_din_Banu(i).duration = FileDataDin.turtle_dive_din.big_dive.homing(i).duration;
	str_big_dive_din_Banu(i).daynight = FileDataDin.turtle_dive_din.big_dive.homing(i).daynight;
end

for i = 1:num_sh
	str_shallow_dive_din_Banu(i).time_in = FileDataDin.turtle_dive_din.shallow_dive.homing(i).time_in;
	str_shallow_dive_din_Banu(i).time_f = FileDataDin.turtle_dive_din.shallow_dive.homing(i).time_f;
	str_shallow_dive_din_Banu(i).depth = min(FileDataDin.turtle_dive_din.shallow_dive.homing(i).depth);
	str_shallow_dive_din_Banu(i).duration = FileDataDin.turtle_dive_din.shallow_dive.homing(i).duration;
	str_shallow_dive_din_Banu(i).daynight = FileDataDin.turtle_dive_din.shallow_dive.homing(i).daynight;
end

for i = 1:num_sub
	str_surface_dive_din_Banu(i).time_in = FileDataDin.turtle_dive_din.sub_surface.homing(i).time_in;
	str_surface_dive_din_Banu(i).time_f = FileDataDin.turtle_dive_din.sub_surface.homing(i).time_f;
	str_surface_dive_din_Banu(i).depth = min(FileDataDin.turtle_dive_din.sub_surface.homing(i).depth);
	str_surface_dive_din_Banu(i).duration = FileDataDin.turtle_dive_din.sub_surface.homing(i).duration;
	str_surface_dive_din_Banu(i).daynight = FileDataDin.turtle_dive_din.sub_surface.homing(i).daynight;
	
	if str_surface_dive_din_Banu(i).duration >= min_length
		count = count + 1;
		% clean_surface.turtle_dive.sub_surface.homing(count) = FileData.turtle_dive.sub_surface.homing(i);
		str_clean_surface_din(count) = str_surface_dive_din_Banu(i);
	end
end

%% struct
%% YPR
FileDataYPR = load('turtle_ypr_Banu.mat');

datetime_ypr = FileDataYPR.ypr_data_struct.datetime_ypr;
pitch = FileDataYPR.ypr_data_struct.pitch;
roll = FileDataYPR.ypr_data_struct.roll;
yaw_g = FileDataYPR.ypr_data_struct.yaw_g;
yaw_m = FileDataYPR.ypr_data_struct.yaw_m;

ypr_info = struct('datetime', datetime_ypr, 'pitch', pitch, 'roll', roll, 'yaw_g', yaw_g, 'yaw_m', yaw_m);
ypr_info_table_Banu = struct2table(ypr_info);

%% struct2table
big_dive_din_Banu = struct2table(str_big_dive_din_Banu);
shallow_dive_din_Banu = struct2table(str_shallow_dive_din_Banu);
surface_dive_din_Banu = struct2table(str_surface_dive_din_Banu);

% clean_surface_dive_Banu = struct2table(clean_surface.turtle_dive.sub_surface.homing);
clean_surface_dive_din_Banu = struct2table(str_clean_surface_din);

%% save .csv files
% writetable(big_dive_Banu, 'big_dive_banu.csv', 'FileType', 'text');
% writetable(shallow_dive_Banu, 'shallow_dive_banu.csv', 'FileType', 'text');
% writetable(surface_dive_Banu, 'surface_dive_banu.csv', 'FileType', 'text');
% writetable(clean_surface_dive_Banu, 'clean_surface_dive_banu.csv', 'FileType', 'text');


writetable(big_dive_din_Banu, 'big_dive_din_banu.csv', 'FileType', 'text');
writetable(shallow_dive_din_Banu, 'shallow_dive_din_banu.csv', 'FileType', 'text');
writetable(surface_dive_din_Banu, 'surface_dive_din_banu.csv', 'FileType', 'text');
writetable(clean_surface_dive_din_Banu, 'clean_surface_dive_din_banu.csv', 'FileType', 'text');

writetable(ypr_info_table_Banu, 'ypr_info_Banu.csv', 'FileType', 'text');