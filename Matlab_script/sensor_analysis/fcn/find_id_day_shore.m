function [day_id, night_id, offshore, inshore, off_day_id, off_night_id, in_day_id, in_night_id] = find_id_day_shore(turtle_dive_type_homing) 

% you have to pass something like this: turtle_dive.big_dive.homing

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
