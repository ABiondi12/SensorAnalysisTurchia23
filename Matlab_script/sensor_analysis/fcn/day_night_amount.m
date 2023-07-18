function [total_amount_day, total_amount_night] = day_night_amount(datetime_acc, sunrise, sunset)
% day_night_amount
% This function takes as input a datetime array relatives to a single dive
% and sunrise and sunset hours and computes the amount of time in which the
% specific dive lasts during day hours and in which it lasts during night
% hours.
%
% INPUT:
%	datetime_acc 	- datetime information of the dive (with the frequency
%						of the acceleration data, that is the highest one)
%	sunrise			- datetime information of the sunrise
%	sunset			- datetime information of the sunset
%
% OUTPUT:
%	total_amount_day	- portion of the dive happened during the day (s)
%	total_amount_night	- portion of the dive happened during the night (s)

%% Parameters definition
% number of days present in each month of the year
days_in_month = [31; 28; 31; 30; 31; 30; 31; 31; 30; 31; 30; 31];

% counters
total_amount_day	= 0;
total_amount_night	= 0;

% T = timeofday(DT) returns a duration array whose values equal the elapsed 
%		time since midnight for each element in DT.

% duration representing the elapsed time since midnight to sunrise and 
% sunset, respectively.
sunrise_hour	= timeofday(sunrise);
sunset_hour 	= timeofday(sunset);

% midnight
midnight		= timeofday(datetime(2017, 06, 28, 00, 00, 00, 000));

% duration of the day in seconds
day_last		= seconds(sunset_hour - sunrise_hour);
% duration of the night in seconds
night_last		= 86400 - day_last;

%% evaluate dive division in day-night hours
init			= datetime_acc(1);	% starting datetime of the dive
init_day		= day(init);		% starting day of the dive
init_month		= month(init);		% starting month of the dive
init_hour		= timeofday(init);	% elapsed time since midnight to the starting of the dive


finish			= datetime_acc(end); % ending datetime of the dive
finish_day		= day(finish);		 % ending day of the dive
finish_month	= month(finish);	 % ending month of the dive
finish_hour		= timeofday(finish); % elapsed time since midnight to the ending of the dive

% dive happens into the same day
if init_day == finish_day && init_month == finish_month
	% dive starts during the night (firsts hours of the current day, 
	% before sunrise)
	if init_hour <= sunrise_hour 
		if finish_hour < sunrise_hour && init_hour < finish_hour
			total_amount_night = total_amount_night + seconds(finish_hour - init_hour);
		else
		% add this dive portion to the night counter
			total_amount_night = total_amount_night + seconds(sunrise_hour - init_hour);
			% dive ends during the day
			if finish_hour < sunset_hour 
				total_amount_day = total_amount_day + seconds(finish_hour - sunrise_hour);
			% dive ends during the night (lasts hours of the current days,
			% after sunset)
			else
				total_amount_day	= total_amount_day + seconds(sunset_hour - sunrise_hour);
				total_amount_night	= total_amount_night + seconds(finish_hour - sunset_hour);
			end
		end
	else
		if finish_hour <= sunset_hour
			total_amount_day = total_amount_day + seconds(finish_hour - init_hour);
		elseif finish_hour > sunset_hour && init_hour <= sunset_hour
			total_amount_day = total_amount_day + seconds(sunset_hour - init_hour);
			total_amount_night = total_amount_night + seconds(finish_hour - sunset_hour);
		elseif finish_hour > sunset_hour && init_hour > sunset_hour
			total_amount_night = total_amount_night + seconds(finish_hour - init_hour);
		end
	end
else
	% Beginning of the day (day before)
	if init_hour <= sunrise_hour
		total_amount_night	= total_amount_night + night_last - seconds(init_hour - midnight);
		total_amount_day	= total_amount_day + day_last;
	elseif init_hour > sunrise_hour && init_hour <= sunset_hour
		total_amount_day	= total_amount_day + seconds(sunset_hour - init_hour);
		total_amount_night	= total_amount_night + (86400 - seconds(sunset_hour - midnight));
	elseif init_hour > sunset_hour
		total_amount_day	= total_amount_day + 0;
		total_amount_night	= total_amount_night + (86400 - seconds(init_hour - midnight));
	end

	% End of the day (day after)
	if finish_hour < sunrise_hour
		total_amount_night	= total_amount_night + seconds(finish_hour - midnight);
		total_amount_day	= total_amount_day + 0;
	elseif finish_hour > sunrise_hour && finish_hour <= sunset_hour
		total_amount_day	= total_amount_day + seconds(finish_hour - sunrise_hour);
		total_amount_night	= total_amount_night + seconds(sunrise_hour - midnight);
	elseif finish_hour > sunset_hour
		total_amount_day	= total_amount_day + seconds(sunset_hour - sunrise_hour);
		total_amount_night	= total_amount_night + seconds(sunrise_hour - midnight) + seconds(finish_hour-sunset_hour);			
	end

	% Central part of the day
	if init_month == finish_month && init_day < finish_day
		total_amount_day	= total_amount_day + day_last * (finish_day - init_day - 1);
		total_amount_night	= total_amount_night + night_last * (finish_day - init_day - 1);
	else
		if finish_month - init_month == 1 && finish_day == 1 && init_day == days_in_month(init_month)
			total_amount_day	= total_amount_day + day_last * ((days_in_month(init_month) - init_day) + finish_day - 1);
			total_amount_night	= total_amount_night + night_last * ((days_in_month(init_month) - init_day) + finish_day - 1);
		else
			fprintf('too many data, a dive cannot last more than few hours \')
		end
	end
end
