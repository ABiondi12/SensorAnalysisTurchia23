% single_main_5_load

%% Load sunrise-sunset structure

if (exist('sunrise_hour.mat', 'var') == 0) || (exist('sunset_hour.mat', 'var') == 0)
	if (exist('sunrise_hour.mat', 'file') == 2) && (exist('sunset_hour.mat', 'file') == 2)
		load('sunrise_hour.mat')
		load('sunset_hour.mat')
	else
		sunrise_sunset_hour
	end
end