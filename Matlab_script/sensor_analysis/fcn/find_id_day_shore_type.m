function [off_id_type, in_id_type, day_id_type, night_id_type, off_day_id_type, off_night_id_type, in_day_id_type, in_night_id_type] = find_id_day_shore_type(id_type, offshore, inshore, day, night, off_day_id, off_night_id, in_day_id, in_night_id) 
% find_id_day_shore_type
% This function takes as input the id of the list of dives that are of a 
% specific dive type and the id of the list of dives that has been made
% during the day, during the night, offshore, inshore and their
% combinations (without taking into account the dive type distinction) and
% returns the id list of the dive of the specified type that has been made
% during the day, during the night, offshore, inshore and their
% combinations.
%
% INPUT:
%	id_type			- id list of the dive of a certain type (e.g. s)
%	offshore		- id list of the dive performed offshore (all the types)
%	inshore			- id list of the dive performed inshore (all the types)
%	day				- id list of the dive performed during the day (all the types)
%	night			- id list of the dive performed during the night (all the types)
%	off_day_id		- id list of the dive performed offshore during the day (all the types)
%	off_night_id	- id list of the dive performed offshore during the night (all the types)
%	in_day_id		- id list of the dive performed inshore during the day (all the types)
%	in_night_id		- id list of the dive performed inshore during the night (all the types)
%
% OUTPUT:
%	off_id_type			- id list of the dive performed offshore (specified type only)
%	in_id_type			- id list of the dive performed inshore (specified type only)
%	day_id_type			- id list of the dive performed during the day (specified type only)
%	night_id_type		- id list of the dive performed during the night (specified type only)
%	off_day_id_type		- id list of the dive performed offshore during the day (specified type only)
%	off_night_id_type	- id list of the dive performed offshore during the night (specified type only)
%	in_day_id_type		- id list of the dive performed inshore during the day (specified type only)
%	in_night_id_type	- id list of the dive performed inshore during the night (specified type only)
%
% NOTE:
%	you need to already have executed find_id_day_shore function over a
%	struct of dives for obtaining id lists used as input in this function.

%% type counters initialization
off_id_type = [];
in_id_type = [];
day_id_type = [];
night_id_type = [];

off_day_id_type = [];
off_night_id_type = [];
in_day_id_type = [];
in_night_id_type = [];

for i=1:length(id_type)
	if ~isempty(find(offshore == id_type(i)))
		off_id_type = [off_id_type; id_type(i)];
	end
end

for i=1:length(id_type)
	if ~isempty(find(inshore == id_type(i)))
		in_id_type = [in_id_type; id_type(i)];
	end
end

for i=1:length(id_type)
	if ~isempty(find(day == id_type(i)))
		day_id_type = [day_id_type; id_type(i)];
	end
end

for i=1:length(id_type)
	if ~isempty(find(night == id_type(i)))
		night_id_type = [night_id_type; id_type(i)];
	end
end

for i=1:length(id_type)
	if ~isempty(find(off_day_id == id_type(i)))
		off_day_id_type = [off_day_id_type; id_type(i)];
	end
end

for i=1:length(id_type)
	if ~isempty(find(off_night_id == id_type(i)))
		off_night_id_type = [off_night_id_type; id_type(i)];
	end
end

for i=1:length(id_type)
	if ~isempty(find(in_day_id == id_type(i)))
		in_day_id_type = [in_day_id_type; id_type(i)];
	end
end

for i=1:length(id_type)
	if ~isempty(find(in_night_id == id_type(i)))
		in_night_id_type = [in_night_id_type; id_type(i)];
	end
end