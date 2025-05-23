function [day_night] = day_night_dive(turtle_dive_last, dive_init, dive_end, sunrise_init, sunset_init, sunrise_end, sunset_end)
% day_night_dive 
% This function takes as input information about the dive start and stop
% time and about sunrise and sunset hours and return "day" if it happens
% mostly during the day and "night" if it happens mostly during the night.
%
% INPUT:
%	turtle_dive_last	- duration (seconds) of the entire dive
%	dive_init			- start of the dive, datetime information
%	dive_end			- end of the dive, datetime information
%	sunrise_init		- sunrise datetime information of the same day in
%							which the dive starts
%	sunset_init			- sunset datetime information of the same day in
%							which the dive starts
%	sunrise_end			- sunrise datetime information of the same day in
%							which the dive ends
%	sunset_end			- sunset datetime information of the same day in
%							which the dive ends
%
% OUTPUT:
%	day_night			- "day" or "night", depending on the period in 
%							which the dive is mostly performed



if sunrise_init == sunrise_end && sunset_init == sunset_end
	% dive is enclosed in the same day
	
	if dive_init > sunrise_init && dive_end < sunset_end
		% dive during the day
		day_night = "day";
	elseif (dive_init < sunrise_init && dive_end < sunrise_init)
		% dive during the night, before sunrise
		day_night = "night";
	elseif (dive_init > sunset_end && dive_end > sunset_end)
		% dive during the night, after sunset
		day_night = "night";
	elseif (dive_init < sunrise_init && dive_end > sunrise_init)
		% start before sunrise but end after sunrise
		if seconds(sunrise_init - dive_init) < turtle_dive_last/2
			% less than a half of the dive takes place during the night
			day_night = "day";
		else
			% more than a half of the dive takes place during the night
			day_night = "night";
		end
	elseif (dive_init < sunset_end && dive_end > sunset_end)
		% start before sunset but end after sunset
		if seconds(sunset_end - dive_init) < turtle_dive_last/2
			% less than a half of the dive takes place during the day
			day_night = 'night';
		else
			% more than a half of the dive takes place during the day
			day_night = 'day';
		end
	else 
			day_night = "ERROR";
	end
else
	% a dive cannot lasts for more than few hours during the homing phase,
	% thus a dive which starts and ends in two consecutive days happens for
	% sure during the night
	day_night = 'night';
end