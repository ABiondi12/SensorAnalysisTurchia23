% load data
%
% Load raw data from a .csv file and create variables to host them.
%
% Comment about axes orientation:
%	acc  x -- seems  x
%	acc  y -- seems  y
%	acc  z -- seems  z
%	gyro x -- seems -x
%	gyro y -- seems -y
%	gyro z -- seems -z (in agm_z seems z)

%% flag definition
sensor_type		= 0;
datetime_column = 0;
freq_mag		= 0;
freq_gyro		= 0;
freq_depth		= 0;

%% Select data parameters

fprintf("Datetime or Date - time information? \n")
fprintf("1. Date and Time columns together \n")
fprintf("2. Date and Time columns divided (not properly working for now) \n")

% Datetime column into .csv file. Only Date and Time together works
% properly by also including datetime information.
% In Date and Time column divided, we do not use date time information, 
% but number of samples. It is not a recommended thing to do, it is better 
% to create a .csv file with date and time column together.
	
while datetime_column <= 0 || datetime_column > 2
	datetime_column = input('');
end

% Choice of the sensor model.
fprintf("Choose the logger model: \n")
fprintf("1. AGM \n")
fprintf("2. Axy-5 \n")

while sensor_type <= 0 || sensor_type > 2
	sensor_type = input('');
end

% Select frequency for magnetometer
%	acc = 10 Hz - mag = 1 Hz for AGM
%	acc = 10 Hz - mag = 1 Hz for axy
fprintf("Choose the magnetometer frequency: \n")
fprintf("1. acc_linked \n")
fprintf("2. 1 Hz (Turchia 2023) \n")
fprintf("3. 2 Hz \n")

while freq_mag <= 0 || freq_mag > 3
	freq_mag = input('');
end

if freq_mag == 1
	mag_step = 1;
elseif freq_mag == 2
	mag_step = 10;
else
	mag_step = 5;
end

if sensor_type == 1	% AGM
	% Select frequency for gyroscope
	%	acc = 10 Hz - gyro = 1 Hz for AGM
	fprintf("Choose the gyroscope frequency: \n")
	fprintf("1. acc_linked \n")
	fprintf("2. 1 Hz (Turchia 2023) \n")
	fprintf("3. 2 Hz \n")
	
	while freq_gyro <= 0 || freq_gyro > 3
		freq_gyro = input('');
	end
	
	if freq_gyro == 1
		gyro_step = 1;
	elseif freq_gyro == 2
		gyro_step = 10;
	else
		gyro_step = 5;
	end
	
	% Select frequency for depth
	%	acc = 10 Hz - depth = 1 Hz for AGM
	fprintf("Choose the depth frequency: \n")
	fprintf("1. acc_linked \n")
	fprintf("2. 1 Hz (Turchia 2023) \n")
	fprintf("3. 2 Hz \n")
	
	while freq_depth <= 0 || freq_depth > 3
		freq_depth = input('');
	end
	
	if freq_depth == 1
		depth_step = 1;
	elseif freq_depth == 2
		depth_step = 10;
	else
		depth_step = 5;
	end
end

%% load data
% date and time together
if datetime_column == 1 
	datetime_acc	= table2array(data(1:end, 2));
	data_accx		= table2array(data(1:end, 3));
	data_accy		= table2array(data(1:end, 4));
	data_accz		= table2array(data(1:end, 5));
	acc_sens		= [data_accx, data_accy, data_accz];
	
	if sensor_type == 2		% axy
		datetime_mag	= table2array(data(1:mag_step:end, 2));
		data_magx		= table2array(data(1:mag_step:end, 6));
		data_magy		= table2array(data(1:mag_step:end, 7));
		data_magz		= table2array(data(1:mag_step:end, 8));
	elseif sensor_type == 1	% AGM
		datetime_mag	= table2array(data(1:mag_step:end, 2));
		data_magx		= table2array(data(1:mag_step:end, 9));   
		data_magy		= table2array(data(1:mag_step:end, 10));
		data_magz		= table2array(data(1:mag_step:end, 11));
		datetime_gyro	= table2array(data(1:gyro_step:end, 2));
		data_gyrox		= table2array(data(1:gyro_step:end, 6));
		data_gyroy		= table2array(data(1:gyro_step:end, 7));
		data_gyroz		= table2array(data(1:gyro_step:end, 8));
		datetime_depth	= table2array(data(1:depth_step:end, 2));
		depth			= table2array(data(1:depth_step:end, 13));
		depth			= - depth;
		gyro_sens		= [data_gyrox, data_gyroy, data_gyroz];
	end
elseif datetime_column == 2 % date and time together - not working for now
	date_acc	= table2array(data(:, 2));
	time_acc	= table2array(data(:, 3));
	%	datetime_acc = date_acc + time_acc;
	%	datetime_acc = datetime([date_acc, time_acc], 'InputFormat', 'GG/MM/YY HH:mm:ss.sss');
	data_accx	= table2array(data(:, 4));
	data_accy	= table2array(data(:, 5));
	data_accz	= table2array(data(:, 6));
	acc_sens	= [data_accx, data_accy, data_accz];
	if sensor_type == 2		% axy
		date_mag	= table2array(data(1:mag_step:end, 2));
		time_mag	= table2array(data(1:mag_step:end, 3));
		%	datetime_mag = datetime([date_mag, time_mag], 'InputFormat', 'GG/MM/YY HH:mm:ss.sss');
		data_magx	= table2array(data(1:mag_step:end, 7));
		data_magy	= table2array(data(1:mag_step:end, 8));
		data_magz	= table2array(data(1:mag_step:end, 9));
	elseif sensor_type == 1	% AGM
		date_mag	= table2array(data(1:mag_step:end, 2));
		time_mag	= table2array(data(1:mag_step:end, 3));
		%	datetime_mag = datetime([date_mag, time_mag], 'InputFormat', 'GG/MM/YY HH:mm:ss.sss');
		data_magx	= table2array(data(1:mag_step:end, 10));
		data_magy	= table2array(data(1:mag_step:end, 11));
		data_magz	= table2array(data(1:mag_step:end, 12));
		data_gyrox	= table2array(data(1:gyro_step:end, 7));
		data_gyroy	= table2array(data(1:gyro_step:end, 8));
		data_gyroz	= table2array(data(1:gyro_step:end, 9));
		depth		= table2array(data(1:depth_step:end, 14));
		depth		= - depth;
		gyro_sens	= [data_gyrox, data_gyroy, data_gyroz];
	end
end
mag_sens = [data_magx, data_magy, data_magz];