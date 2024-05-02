% load data
%
% Load raw collected data from a .csv file and create variables to host 
% them. During the loading procedure, some information has to be given:
%
%	a. Date and Time data into the .csv file
%			1. same column (recommended)
%			2. separeted column (not recommended, datetime info does not
%			work yet)
%
%	b. Sensor model
%			1. AGMD
%			2. Axy-5
%
% Moreover, it is assumed that acceleration data has been taken with 10Hz
% of frequency (future improvement should be to been able to select also 
% this frequency). Then, it is asked to give frequencies of the other
% sensors, that are magnetic field sensor, depth sensor and gyroscope.
%
%	c. magnetic field data frequency:
%		1. acc_linked
%		2. 1 Hz (Turchia 2023)
%		3. 2 Hz
%
%	d. Gyroscope data frequency:
%		1. acc_linked
%		2. 1 Hz (Turchia 2023)
%		3. 2 Hz
%
%	e. depth data frequency:
%		1. acc_linked
%		2. 1 Hz (Turchia 2023)
%		3. 2 Hz

%% comment
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

if auto_column_together == 0
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
elseif auto_column_together == 1
	datetime_column = 1;
end

% Choice of the sensor model.
fprintf("Choose the logger model: \n")
fprintf("1. AGM \n")
fprintf("2. Axy-5 \n")

while sensor_type <= 0 || sensor_type > 2
	sensor_type = input('');
end

%% read table

if sensor_type == 1
	name_table = name_table_agm;
elseif sensor_type == 2
	name_table = name_table_axy;
end


%% check for already present raw .mat file
new_raw_dataset = 0;
if exist(turtle_raw_name, 'file') == 2
	fprintf([turtle_raw_name,': dataset already exists!!! \n'])
	ov_to_do = 0;
	
	yn_ans = 0;
	while yn_ans < 1 || yn_ans > 2
		fprintf([turtle_raw_name, ': do you want to load the dataset again? \n'])
		fprintf('1_ yes \n')
		fprintf('2_ no \n')
		yn_ans = input('');
	end
	
	if yn_ans == 1
		ov_to_do = 1;
		fprintf([turtle_raw_name, ': start loading... \n'])
	elseif yn_ans == 2
		ov_to_do = 0;
		fprintf([turtle_raw_name, ': load operation aborted! \n'])
	end
else
	new_raw_dataset = 1;
end

%% Load data

step_data_def

if (sensor_type == 1 && (new_raw_dataset == 1 || ov_to_do == 1)) || sensor_type == 2

	data		= readtable(name_table);
	data_calib	= readtable(name_table_calib);	

	if strcmp(name_table, name_table_modify)
		data_new = [data(1:1936431, :);data(1936422:1936430, :); data(1936432:end, :)];
		data = data_new;
	end

	% Select frequency for magnetometer
	%	acc = 10 Hz - mag = 1 Hz for AGM
	%	acc = 10 Hz - mag = 1 Hz for axy

	%% load data
	% date and time together
	if datetime_column == 1 
		datetime_acc	= table2array(data(1:end, 2));
		data_accx		= table2array(data(1:end, 3));
		data_accy		= table2array(data(1:end, 4));
		data_accz		= table2array(data(1:end, 5));
		acc_sens		= [data_accx, data_accy, data_accz];

		[nan_find_x, nan_find_y] = find(isnan(acc_sens));
		if isempty(nan_find_x) == 0 || isempty(nan_find_y) == 0
			count = 0;
			while isempty(nan_find_x) == 0 && isempty(nan_find_y) == 0 && count < 10 
				count = count +1;
				fprintf('Nan number found, correct...\n');
				acc_sens(nan_find_x, nan_find_y) = acc_sens(nan_find_x-1, nan_find_y);
				[nan_find_x, nan_find_y] = find(isnan(acc_sens));
			end
		end

		if isempty(nan_find_x) == 0 || isempty(nan_find_y) == 0
			fprintf('too many NaN in the acceleration dataset, get a look to your data before proceeding \n');
		end

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

			[nan_find_x, nan_find_y] = find(isnan(gyro_sens));
			if isempty(nan_find_x) == 0 || isempty(nan_find_y) == 0
				count = 0;
				while isempty(nan_find_x) == 0 && isempty(nan_find_y) == 0 && count < 10 
					count = count +1;
					fprintf('Nan number found, correct...\n');
					gyro_sens(nan_find_x, nan_find_y) = gyro_sens(nan_find_x-1, nan_find_y);
					[nan_find_x, nan_find_y] = find(isnan(gyro_sens));
				end
			end

			if isempty(nan_find_x) == 0 || isempty(nan_find_y) == 0
				fprintf('too many NaN in the gyroscope dataset, get a look to your data before proceeding \n');
			end

		end

	elseif datetime_column == 2 % date and time together - not working for now
		date_acc	= table2array(data(:, 2));
		time_acc	= table2array(data(:, 3));

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

	[nan_find_x, nan_find_y] = find(isnan(mag_sens));
	if isempty(nan_find_x) == 0 || isempty(nan_find_y) == 0
		count = 0;
		while isempty(nan_find_x) == 0 && isempty(nan_find_y) == 0 && count < 10 
			count = count + 1;
			fprintf('Nan number found, correct...\n');
			mag_sens(nan_find_x, nan_find_y) = mag_sens(nan_find_x-1, nan_find_y);
			[nan_find_x, nan_find_y] = find(isnan(mag_sens));
		end
	end

	if isempty(nan_find_x) == 0 || isempty(nan_find_y) == 0
		fprintf('too many NaN in the magnetometer dataset, get a look to your data before proceeding \n');
	end
else
	load_raw_data
	fprintf('Load operation completed! \n')
end