%% load .mat files for a single turtle
% FileData = load('turtle_dive_Banu.mat');
FileDataDin = load('turtle_dive_din_Banu.mat');

%% export into tables
% big_dive_Banu = struct2table(FileData.turtle_dive.big_dive.homing);
% shallow_dive_Banu = struct2table(FileData.turtle_dive.shallow_dive.homing);
% surface_dive_Banu = struct2table(FileData.turtle_dive.sub_surface.homing);

big_dive_din_Banu = struct2table(FileDataDin.turtle_dive_din.big_dive.homing);
shallow_dive_din_Banu = struct2table(FileDataDin.turtle_dive_din.shallow_dive.homing);
surface_dive_din_Banu = struct2table(FileDataDin.turtle_dive_din.sub_surface.homing);

num_sub = size(FileDataDin.turtle_dive_din.sub_surface.homing, 2);
min_length = 10; % at least 10 seconds
count = 0;

for i = 1:num_sub
	if FileDataDin.turtle_dive_din.sub_surface.homing(i).duration >= min_length
		count = count + 1;
		% clean_surface.turtle_dive.sub_surface.homing(count) = FileData.turtle_dive.sub_surface.homing(i);
		clean_surface_din.turtle_dive_din.sub_surface.homing(count) = FileDataDin.turtle_dive_din.sub_surface.homing(i);
	end
end

% clean_surface_dive_Banu = struct2table(clean_surface.turtle_dive.sub_surface.homing);
clean_surface_dive_din_Banu = struct2table(clean_surface_din.turtle_dive_din.sub_surface.homing);

%% save .csv files
% writetable(big_dive_Banu, 'big_dive_banu.csv', 'FileType', 'text');
% writetable(shallow_dive_Banu, 'shallow_dive_banu.csv', 'FileType', 'text');
% writetable(surface_dive_Banu, 'surface_dive_banu.csv', 'FileType', 'text');
% writetable(clean_surface_dive_Banu, 'clean_surface_dive_banu.csv', 'FileType', 'text');


writetable(big_dive_din_Banu, 'big_dive_din_banu.csv', 'FileType', 'text');
writetable(shallow_dive_din_Banu, 'shallow_dive_din_banu.csv', 'FileType', 'text');
writetable(surface_dive_din_Banu, 'surface_dive_din_banu.csv', 'FileType', 'text');
writetable(clean_surface_dive_din_Banu, 'clean_surface_dive_din_banu.csv', 'FileType', 'text');
