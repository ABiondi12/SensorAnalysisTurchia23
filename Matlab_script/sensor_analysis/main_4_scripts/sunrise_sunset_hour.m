% sunrise_sunset_hour
%
% This script contains the sunrise and sunset hours for the specific
% time and space instant during which the turtle has performed the homing 
% travel (supposed as reference the first day and the capture beach).
%
% Time is in Local UTC+3h.
%
% There are three different sunset and sunrise definitions:
%	1. Civil		
%	2. Nautical		
%	3. Astronomical 
%
% Here, it is asked what definition has to be used in the script for the
% evaluation of the periods of daylight and of darkness.
% We recommend to use nautical sunrise and sunset hours for the division
% between day (light) and night (darkness).
%
% NOTE:
% To apply the same code with different dataset, it is necessary to
% manually update the sunrise and sunset days and hours by changing their
% values directly in the code (for all the three definitions). These values
% are available online once selected date and space position.
%
% The variables to be updated are the following:
%
%	sunrise_hour	= (datetime(year, month, day, hour, min, sec, msec));
%	sunset_hour		= (datetime(year, month, day, hour, min, sec, msec));

%% parameters

sun_kind = 0;

clear sunrise_hour
clear sunset_hour

while sun_kind <=0 || sun_kind > 3
	fprintf('Which kind of sunrise/sunset: \n')
	fprintf('1. civil \n')
	fprintf('2. nautical (suggested) \n')
	fprintf('3. astronomical \n')

	sun_kind = input('');
end

if sun_kind == 1
	if turtle_nm > 0 && turtle_nm < 6
		sunrise_hour	= (datetime(2023, 05, 30, 05, 16, 00, 000));
		sunset_hour		= (datetime(2023, 05, 30, 20, 46, 00, 000));
	else
		sunrise_hour	= (datetime(2023, 06, 26, 04, 59, 00, 000));
		sunset_hour		= (datetime(2023, 06, 26, 21, 13, 00, 000));
	end
	
elseif sun_kind == 2
	if turtle_nm > 0 && turtle_nm < 6
		sunrise_hour	= (datetime(2023, 05, 30, 04, 39, 00, 000));
		sunset_hour		= (datetime(2023, 05, 30, 21, 23, 00, 000));
	else
		sunrise_hour	= (datetime(2023, 06, 26, 04, 16, 00, 000));
		sunset_hour		= (datetime(2023, 06, 26, 21, 56, 00, 000));
	end
elseif sun_kind == 3
	if turtle_nm > 0 && turtle_nm < 6
		sunrise_hour	= (datetime(2023, 05, 30, 03, 58, 00, 000));
		sunset_hour		= (datetime(2023, 05, 30, 22, 04, 00, 000));
	else
		sunrise_hour	= (datetime(2023, 06, 26, 03, 25, 00, 000));
		sunset_hour		= (datetime(2023, 06, 26, 22, 47, 00, 000));
	end
end

save('sunrise_hour', 'sunrise_hour')
save('sunset_hour', 'sunset_hour')
