function [day_id, night_id, offshore, inshore, off_day_id, off_night_id, in_day_id, in_night_id] = find_id_day_shore(turtle_dive_type_homing) 
% find_id_day_shore
% This function takes as input a struct relatives to a list of dives with
% their description (start time, stop time...) and returns the indices 
% of the list relative to:
%	- offshore dives
%	- inshore dives
%	- day dives
%	- night dives
%	- combination of the previous
%		- offshore day
%		- offshore night
%		- inshore day
%		- inshore night
%
% INPUT:
% you have to pass a structure like this: turtle_dive.big_dive.homing
% which contains a list is composed as follow (for a generic i-dive)
% 
% turtle_dive_type_homing = turtle_dive.big_dive.homing;
%		turtle_dive_type_homing(i).datatime;
%		turtle_dive_type_homing(i).datatime_depth;
%		turtle_dive_type_homing(i).time_in;
%		turtle_dive_type_homing(i).time_f;
%		turtle_dive_type_homing(i).type;
%		turtle_dive_type_homing(i).depth;
%		turtle_dive_type_homing(i).accx;
%		turtle_dive_type_homing(i).accy;
%		turtle_dive_type_homing(i).accz;
%		turtle_dive_type_homing(i).yaw;
%		turtle_dive_type_homing(i).pitch;
%		turtle_dive_type_homing(i).roll;
%		turtle_dive_type_homing(i).ODBA;
%		turtle_dive_type_homing(i).ODBA_mean;
%		turtle_dive_type_homing(i).ODBA_var;
%		turtle_dive_type_homing(i).ODBA_paper;
%
% OUTPUT:
%	day_id			- id of dives performed during the day
%	night_id		- id of dives performed during the night
%	offshore		- id of dives performed offshore
%	inshore			- id of dives performed inshore
%	off_day_id		- id of dives performed offshore and during the day
%	off_night_id	- id of dives performed offshore during the night
%	in_day_id		- id of dives performed inshore and during the day
%	in_night_id		- id of dives performed inshore and during the night

for i = 1:size(turtle_dive_type_homing, 2)
	dive_info(i, 1) = turtle_dive_type_homing(i).offinshore;
	dive_info(i, 2) = turtle_dive_type_homing(i).daynight;
end

% bb(:, 1) = ["day"; "night"; "day"; "night"; "day"];
% bb(:, 2) = ["offshore"; "offshore"; "offshore"; "inshore"; "inshore"];

day_id = find(dive_info(:, 2) == "day");
night_id = find(dive_info(:, 2) == "night");

offshore = find(dive_info(:, 1) == "offshore");
inshore = find(dive_info(:, 1) == "inshore");

off_day_id = [];
off_night_id = [];
in_day_id = [];
in_night_id = [];

for i=1:length(day_id)
	if ~isempty(find(offshore == day_id(i)))
		off_day_id = [off_day_id; day_id(i)];
	end
end

for i=1:length(night_id)
	if ~isempty(find(offshore == night_id(i)))
		off_night_id = [off_night_id; night_id(i)];
	end
end

for i=1:length(day_id)
	if ~isempty(find(inshore == day_id(i)))
		in_day_id = [in_day_id; day_id(i)];
	end
end

for i=1:length(night_id)
	if ~isempty(find(inshore == night_id(i)))
		in_night_id = [in_night_id; night_id(i)];
	end
end
