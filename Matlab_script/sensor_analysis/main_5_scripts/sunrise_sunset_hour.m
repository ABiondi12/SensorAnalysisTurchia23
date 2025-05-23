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

if release == 1

    if sun_kind == 1 % civil

	    if turtle_nm >= 1 && turtle_nm < 7
		    sunrise_hour	= (datetime(2023, 05, 30, 05, 16, 00, 000));
		    sunset_hour		= (datetime(2023, 05, 30, 20, 46, 00, 000));
	    elseif turtle_nm >= 7 && turtle_nm < 10
		    sunrise_hour	= (datetime(2023, 06, 26, 04, 59, 00, 000));
		    sunset_hour		= (datetime(2023, 06, 26, 21, 13, 00, 000));
	    end
	    
    elseif sun_kind == 2 % nautical
    
	    if turtle_nm >= 1 && turtle_nm < 7
		    sunrise_hour	= (datetime(2023, 05, 30, 04, 39, 00, 000));
		    sunset_hour		= (datetime(2023, 05, 30, 21, 23, 00, 000));
	    elseif turtle_nm >= 7 && turtle_nm < 10
		    sunrise_hour	= (datetime(2023, 06, 26, 04, 16, 00, 000));
		    sunset_hour		= (datetime(2023, 06, 26, 21, 56, 00, 000));
	    end
    elseif sun_kind == 3 % astronomical
    
	    if turtle_nm >= 1 && turtle_nm < 7
		    sunrise_hour	= (datetime(2023, 05, 30, 03, 58, 00, 000));
		    sunset_hour		= (datetime(2023, 05, 30, 22, 04, 00, 000));
	    elseif turtle_nm >= 7 && turtle_nm < 10
		    sunrise_hour	= (datetime(2023, 06, 26, 03, 25, 00, 000));
		    sunset_hour		= (datetime(2023, 06, 26, 22, 47, 00, 000));
	    end
    end

elseif release == 2

    if sun_kind == 1 % civil

	    if turtle_nm >= 1 && turtle_nm < 6
		    sunrise_hour	= (datetime(2024, 05, 20, 05, 24, 00, 000));
		    sunset_hour		= (datetime(2024, 05, 20, 20, 39, 00, 000));
	    elseif turtle_nm >= 6 && turtle_nm < 11
		    sunrise_hour	= (datetime(2024, 06, 10, 05, 15, 00, 000));
		    sunset_hour		= (datetime(2024, 06, 10, 20, 54, 00, 000));
	    end
	    
    elseif sun_kind == 2 % nautical

	    if turtle_nm >= 1 && turtle_nm < 6
		    sunrise_hour	= (datetime(2024, 05, 20, 04, 48, 00, 000));
		    sunset_hour		= (datetime(2024, 05, 20, 21, 16, 00, 000));
	    elseif turtle_nm >= 6 && turtle_nm < 11
		    sunrise_hour	= (datetime(2024, 06, 10, 04, 37, 00, 000));
		    sunset_hour		= (datetime(2024, 06, 10, 21, 33, 00, 000));
        end

    elseif sun_kind == 3 % astronomical
    
	    if turtle_nm >= 1 && turtle_nm < 6
		    sunrise_hour	= (datetime(2024, 05, 20, 04, 09, 00, 000));
		    sunset_hour		= (datetime(2024, 05, 20, 21, 55, 00, 000));
	    elseif turtle_nm >= 6 && turtle_nm < 11
		    sunrise_hour	= (datetime(2024, 06, 10, 03, 54, 00, 000));
		    sunset_hour		= (datetime(2024, 06, 10, 22, 15, 00, 000));
	    end
    end
end
save('sunrise_hour', 'sunrise_hour')
save('sunset_hour', 'sunset_hour')
