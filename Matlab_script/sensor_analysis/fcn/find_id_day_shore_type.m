function [off_id_type, in_id_type, day_id_type, night_id_type, off_day_id_type, off_night_id_type, in_day_id_type, in_night_id_type] = find_id_day_shore_type(id_type, offshore, inshore, day, night, off_day_id, off_night_id, in_day_id, in_night_id) 

% type
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