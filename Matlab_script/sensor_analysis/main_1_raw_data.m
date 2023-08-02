% main_1_raw_data
% This script executes the firsts elaborations over the raw data. In
% particular, there are implemented the following steps:
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 1. DATA LOAD
% It is called the function load data, demanded to import data from a .csv
% file to Matlab variables. During data loading, the following specifics
% are to be specified:
%	a. sensor type
%		sensor = 1	for AGM
%		sensor = 2	for Axy-5
%	b. data type (to be shown)
%		type = 0		for all - recommended (acc, mag, gyro for AGM)
%		type = 1		for acc
%		type = 2		for mag
%		type = 3		for gyro (available only for AGM)
%	c. date and time in the same column or not
%		datetime_column = 1 for yes (recommended)
%		datetime_column = 2 for no
%	d. frequency for magnetic field, gyroscope and depth
%			for AGM --> acc is 10 Hz; mag, gyro and depth are 1 Hz 
%			for axy --> acc is 10 Hz; mag is 1 Hz
%
% NOTE:
%	axy data are in UTC time
%	AGM data are in local time (UTC + 3h)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 2. DATA REORIENTATION
%	raw data are espressed in sensor reference frame, here there is the
%	reorientation of their axes in order to obtain, for all the data
%	(acceleration, magnetic field and gyroscope data) the same reference
%	frame having:
%		x axis -- along turtle carapace, positive in the direction of
%					movement
%		z axis -- along vertical direction w.r.t. turtle body, positive
%					downstairs
%		y axis -- trasversal w.r.t. turtle carapace, so that to obtain a
%					right handed reference frame
%
% Note: for that part it is necessary to specify how the logger was fixed
%		over the turtle carapace
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 3. MAGNETIC FIELD CALIBRATION
% In this part, there is the calibration of the magnetic field data. It is
% asked if to execute the calibration (recommended), where is the data
% session from which to compute it and if proceed by the correction of the
% entire magnetic field dataset (recommended).
% It is executed through the launch of the script "mag_calibration", thus
% refers to it for more details about calibration procedure.
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 4. PLOT SESSION
% Plot for acceleration, magnetic field and gyroscope data, both in the
% original (sensor, local) reference frame and in the reoriented reference
% frame. For magnetic field data, also pre and post calibration values are
% shown.
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% flag definition
data_type	= -1;
calib_perf	= 0;

%% file load

% w.r.t. the data session
% load raw data and create variables for them
load_data

%% choose data
if choose_data == 0
	% Run "0" for the complete data elaboration.
	fprintf("Choose the veriable to be shown: \n")
	fprintf("0. all (acc, mag, gyro) - suggested \n")
	fprintf("1. accelerometer (acc) \n")
	fprintf("2. compass (mag) \n")

	% only agm has gyroscope sensor
	if sensor_type == 1	
		fprintf("3. gyroscope (gyro) \n")
	end

	while data_type < 0 || (data_type > 2 && sensor_type == 2) || (data_type > 3 && sensor_type == 1)
		data_type = input('');
	end
elseif choose_data == 1
	data_type = 0;
end

%% data reorientation 
%% extrapolates raw sensor data of the selected dataset
% original and rotated acc and mag vectors. Accelerometers and Magnetic
% field sensor have not the same local frame:
%	Accelerometer:	x along turtle direction (-)
%					z down directed
%					y in order to obtain a right frame
% note: this is not a right hand reference frame

%	Magnetometer:	y along turtle direction (+)
%					z down directed
%					x in order to obtain a right frame

% Rotated sensor measure are measure of both acc and mag expressed using a
% local frame that allow us to obtain YPR values directly referred to NED
% navigation frame:

% new local frame:	x along turtle direction
%					z down directed
%					y in order to obtain a right frame

if sensor_type == 1		% agm
    [acc_reor, mag_reor, gyro_reor]	= file_data_reor(acc_sens, mag_sens, gyro_sens, sensor_type);
elseif sensor_type == 2 % axy
    [acc_reor, mag_reor, unused]	= file_data_reor(acc_sens, mag_sens, acc_sens, sensor_type);
end

%% magnetic field
if data_type == 2 || data_type == 0
	% plot not calibrated data of magnetic field
	mf_not_calib_plot

    %% calibration
	if auto_calib == 0
		fprintf("Perform calibration? \n")
		fprintf("1. Yes (suggested) \n")
		fprintf("2. no				\n")

		while calib_perf < 1 || calib_perf > 2
			calib_perf = input('');
		end
	elseif auto_calib == 1 % automatic calibration perform
		calib_perf = 1;
		fprintf('Automatic start of calibration procedure... \n')
	end
	
	if calib_perf == 1
		% perform calibration and correct data
		mag_calibration
	end
end

%% acceleration
if data_type == 1 || data_type == 0
	% plot raw acceleration data
	acc_plot
end

%% gyroscope
if (data_type == 3 || data_type == 0) && sensor_type == 1 % agm
	% plot raw gyroscope data
	gyro_plot
end

%% depth
if sensor_type == 1
	l		= size(datetime_depth, 1);
	thr1	= -1.*ones(l,1);	% 1m = threshold between subsurface and shallow dive
	thr2	= -5.*ones(l,1);	% 5m = threshold between shallow dive and big dive

	figure('Name', ['figure ', num2str(id_plot),', depth profile and ranges'], 'NumberTitle','off'); id_plot = id_plot + 1;
		clf
		plot(datetime_depth, depth);
		hold on
		plot(datetime_depth, thr1, 'Linewidth', 1.5);
		plot(datetime_depth, thr2, 'Linewidth', 1.5);
		grid on
		box on
		axis tight
		xlabel('time','FontSize', dim_font)
		ylabel('depth (m)','FontSize', dim_font)
		legend('depth', 'sub surface-shallow dive', 'shallow dive-big dive','Location', 'best', 'FontSize', dim_font);
		set(gca,'FontSize', dim_font) 
		title('Depth profile and ranges')
end