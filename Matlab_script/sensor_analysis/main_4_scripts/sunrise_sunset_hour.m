% sunrise_sunset_hour
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
	sunrise_hour	= (datetime(2023, 05, 30, 05, 16, 00, 000));
	sunset_hour		= (datetime(2023, 05, 30, 20, 46, 00, 000));
elseif sun_kind == 2
	sunrise_hour	= (datetime(2023, 05, 30, 04, 39, 00, 000));
	sunset_hour		= (datetime(2023, 05, 30, 21, 23, 00, 000));
elseif sun_kind == 3
	sunrise_hour	= (datetime(2023, 05, 30, 03, 58, 00, 000));
	sunset_hour		= (datetime(2023, 05, 30, 22, 04, 00, 000));
end

save('sunrise_hour', 'sunrise_hour')
save('sunset_hour', 'sunset_hour')
