function [total_amount_day, total_amount_night] = day_night_amount(datetime_acc, sunrise, sunset)
	
days_in_month = [31; 28; 31; 30; 31; 30; 31; 31; 30; 31; 30; 31];

total_amount_day	= 0;
total_amount_night	= 0;

sunrise_hour	= timeofday(sunrise);
sunset_hour 	= timeofday(sunset);

midnight		= timeofday(datetime(2017, 06, 28, 00, 00, 00, 000));

day_last		= seconds(sunset_hour - sunrise_hour);
night_last		= 86400 - day_last;

%% evaluate 
init			= datetime_acc(1);
init_day		= day(init);
init_month		= month(init);
init_hour		= timeofday(init);


finish			= datetime_acc(end);
finish_day		= day(finish);
finish_month	= month(finish);
finish_hour		= timeofday(finish);


if init_day == finish_day && init_month == finish_month
	if init_hour < sunrise_hour
		total_amount_night = total_amount_night + seconds(sunrise_hour - init_hour);
		if finish_hour < sunset_hour
			total_amount_day = total_amount_day + seconds(finish_hour - sunrise_hour);
		else
			total_amount_day	= total_amount_day + seconds(sunset_hour - sunrise_hour);
			total_amount_night	= total_amount_night + seconds(finish_hour - sunset_hour);
		end
	else
		if finish_hour < sunset_hour
			total_amount_day = total_amount_day + seconds(finish_hour - init_hour);
		else
			total_amount_day = total_amount_day + seconds(sunset_hour - init_hour);
			total_amount_night = total_amount_night + seconds(finish_hour - sunset_hour);
		end
	end
else
	% init day
	if init_hour < sunrise_hour
		total_amount_night	= total_amount_night + night_last - seconds(init_hour - midnight);
		total_amount_day		= total_amount_day + day_last;
	elseif init_hour > sunrise_hour && init_hour < sunset_hour
		total_amount_day		= total_amount_day + seconds(sunset_hour - init_hour);
		total_amount_night	= total_amount_night + (86400 - seconds(sunset_hour - midnight));
	elseif init_hour > sunset_hour
		total_amount_day	= total_amount_day + 0;
		total_amount_night	= total_amount_night + (86400 - seconds(init_hour - midnight));
	end

	% finish day
	if finish_hour < sunrise_hour
		total_amount_night	= total_amount_night + seconds(finish_hour - midnight);
		total_amount_day	= total_amount_day + 0;
	elseif finish_hour > sunrise_hour && finish_hour < sunset_hour
		total_amount_day	= total_amount_day + seconds(finish_hour - sunrise_hour);
		total_amount_night	= total_amount_night + seconds(sunrise_hour - midnight);
	elseif finish_hour > sunset_hour
		total_amount_day	= total_amount_day + seconds(sunset_hour - sunrise_hour);
		total_amount_night	= total_amount_night + seconds(sunrise_hour - midnight) + seconds(finish_hour-sunset_hour);			
	end

	% central day
	if init_month == finish_month
		total_amount_day	= total_amount_day + day_last * (finish_day - init_day - 1);
		total_amount_night	= total_amount_night + night_last * (finish_day - init_day - 1);
	else
		if finish_month - init_month == 1
			total_amount_day	= total_amount_day + day_last * ((days_in_month(init_month) - init_day) + finish_day - 1);
			total_amount_night	= total_amount_night + night_last * ((days_in_month(init_month) - init_day) + finish_day - 1);
		else
			fprintf('too many data \')
		end
	end
end
