function [acc_reor, mag_reor, gyro_reor] = file_data_reor(acc, mag, gyro, sensor_model, auto_load_info)
% file_data_reor
% This function takes as input data from sensors, as accelerometer and
% gyroscope, and gives as output their reoriented version so as to obtain a
% pseudo-NED reference frame, that is:
%	- x axis along turtle carapace, positive from the tail to the head
%	- z axis positive downwards w.r.t. turtle carapace
%	- y so as to obtain a right hand frame
%
% POSSIBLE CONFIGURATIONS:
% the configurations that has been taken into account are all with the 
% logger fixed horizontally with the bigger base downstairs and the smooth 
% angle upstairs and:
%	1. the connector to the front
%	2. the connector to the back
%	3. the connector to the right
%	4. the connector to the left
% with respect to the positive turtle longitudinal axis (the one along with
% the turtle moves).
%
% REORIENT:
%	* Original raw orientation for AGM: 
%		- accx is longitudinal and positive along the connector side.
%		- accy is trasversal and positive to the side of the dot.
%		- accz is vertical and positive downstairs.
%		- magx is trasversal and negative to the side of the dot.
%		- magy is longitudinal and negative along the connector side.
%		- magz is vertical and positive downstairs.
%		- gyrox is longitudinal and negative along the connector side.
%		- gyroy is trasversal and negative to the side of the dot.
%		- gyroz is vertical and positive upstairs.
%
%	* Original raw orientation for Axy: 
%		- accx is longitudinal and positive along the connector side. 
%		- accy is trasversal and positive to the connector side.
%		- accz is vertical and positive downstairs.
%		- magx is longitudinal and positive along the connector side.
%		- magy is trasversal and positive to the connector side.
%		- magz is vertical and positive upstairs.
%
% INPUT:
%	acc			 - acceleration raw data (matrix nx3, n = num of samples)
%	mag			 - magnetic field raw data (matrix nx3, n = num of samples)
%	gyro		 - gyroscope raw data (matrix nx3, n = num of samples)
%	sensor_model - axy-5 or AGM
%
% OUTPUT:
%	acc_reor	 - acceleration reoriented data (matrix nx3, n = num of samples)
%	mag_reor	 - magnetic field reoriented data (matrix nx3, n = num of samples)
%	gyro_reor	 - gyroscope reoriented data (matrix nx3, n = num of samples)
%
% NOTE:
%	gyroscope input and output are significant only for AGM sensor, in case
%	of Axy-5 sensor you can simply use acc data for gyro and ignore the
%	output.
no_gyro = 0;

if acc(1:1) == gyro(1:1)
    no_gyro = 1;
end
%% acc and mag extrapulation: 'original' raw data
acc_x = acc(:, 1);
acc_y = acc(:, 2);
acc_z = acc(:, 3);

if iscell(acc_x)
    acc_x = -str2double(acc_x);
end
if iscell(acc_y)
    acc_y = -str2double(acc_y);
end
if iscell(acc_z)
    acc_z = -str2double(acc_z);
end

acc_sens_orig = [acc_x, acc_y, acc_z];

mag_x = mag(:, 1);
mag_y = mag(:, 2);
mag_z = mag(:, 3);

if iscell(mag_x)
    mag_x = -str2double(mag_x);
end
if iscell(mag_y)
    mag_y = -str2double(mag_y);
end
if iscell(mag_z)
    mag_z = -str2double(mag_z);
end

if sensor_model == 1 && no_gyro == 0 % agm with gyro
    gyro_x = gyro(:, 1);
    gyro_y = gyro(:, 2);
    gyro_z = gyro(:, 3);

    if iscell(gyro_x)
        gyro_x = -str2double(gyro_x);
    end
    if iscell(gyro_y)
        gyro_y = -str2double(gyro_y);
    end
    if iscell(gyro_z)
        gyro_z = -str2double(gyro_z);
    end

    gyro_sens_orig = [gyro_x, gyro_y, gyro_z];
end

%% Possible configurations
% the configurations that has been taken into account are all with the 
% logger fixed horizontally with the bigger base downstairs and the smooth 
% angle upstairs and:
%	1. the connector to the front
%	2. the connector to the back
%	3. the connector to the right
%	4. the connector to the left
% with respect to the positive turtle longitudinal axis (the one along with
% the turtle moves).

%% reorient
% For AGM: 
%	- accx is longitudinal and positive along the connector side.
%	- accy is trasversal and positive to the side of the dot.
%	- accz is vertical and positive downstairs.
%	- magx is trasversal and negative to the side of the dot.
%	- magy is longitudinal and negative along the connector side.
%	- magz is vertical and positive downstairs.
%	- gyrox is longitudinal and negative along the connector side.
%	- gyroy is trasversal and negative to the side of the dot.
%	- gyroz is vertical and positive upstairs.
%
% For Axy: 
%	- accx is longitudinal and positive along the connector side. 
%	- accy is trasversal and positive to the connector side.
%	- accz is vertical and positive downstairs.
%	- magx is longitudinal and positive along the connector side.
%	- magy is trasversal and positive to the connector side.
%	- magz is vertical and positive upstairs.
%
% Lets start before by aligning all the sensors with the same reference
% frame as those of the acceletometer (for AGM, also change y axis sign of 
% acc so as to obtain a right hand reference frame).
% For AGM:
% 	- gyrox_new = -gyrox
%	- gyroy_new = -gyroy
%	- gyroz_new = -gyroz
%	- magx_new	= -magy
%	- magy_new	= -magx
%	- magz_new	=  magz
% For Axy:
%	- magx_new	=  magx
%	- magy_new	=  magy
%	- magz_new	= -magz

if sensor_model == 1
    mag_sens_orig = [-mag_y, -mag_x, mag_z];	    % AGM
    if no_gyro == 0 
	    gyro_sens_orig = [-gyro_x, -gyro_y, -gyro_z];
    end
elseif sensor_model == 2
    mag_sens_orig = [mag_x, mag_y, -mag_z];	        % Axy-5
end

if auto_load_info == 0

	logger_config = 0;
	fprintf("Choose the logger configuration: \n")
	fprintf("1. connector to the front \n")
	fprintf("2. connector to the back (Turtle carapace setup) \n")
	fprintf("3. connector to the right \n")
	fprintf("4. connector to the left \n")

	while logger_config <= 0 || logger_config > 4
		logger_config = input('');
	end
else
	logger_config = 2;
end

if sensor_model == 1
    if logger_config == 1
        acc_reor = [acc_x, -acc_y, acc_z]; % right hand reference frame
        mag_reor = [-mag_y, mag_x, mag_z];
        if no_gyro == 0
            gyro_reor = [-gyro_x, gyro_y, -gyro_z];
        else
            gyro_reor = acc_reor;
        end
    elseif logger_config == 2
        acc_reor = [-acc_x, acc_y, acc_z];
        mag_reor = [mag_y, -mag_x, mag_z];
        if no_gyro == 0 
            gyro_reor = [gyro_x, -gyro_y, -gyro_z];
        else
            gyro_reor = acc_reor;
        end
    elseif logger_config == 3
        acc_reor = [acc_y, acc_x, acc_z];
        mag_reor = [-mag_x, -mag_y, mag_z];
        if no_gyro == 0
            gyro_reor = [-gyro_y, -gyro_x, -gyro_z];
        else
            gyro_reor = acc_reor;
        end
    elseif logger_config == 4
        acc_reor = [-acc_y, -acc_x, -acc_z];
        mag_reor = [mag_x, mag_y, mag_z];
        if no_gyro == 0
            gyro_reor = [gyro_y, gyro_x, -gyro_z];
        else
            gyro_reor = acc_reor;
        end
    end
elseif sensor_model == 2
    gyro_reor = 0;
    if logger_config == 1
        acc_reor = [acc_x, acc_y, acc_z];
        mag_reor = [mag_x, mag_y, -mag_z];
        gyro_reor = acc_reor;
    elseif logger_config == 2
        acc_reor = [-acc_x, -acc_y, acc_z];
        mag_reor = [-mag_x, -mag_y, -mag_z];
        gyro_reor = acc_reor;
    elseif logger_config == 3
        acc_reor = [-acc_y, acc_x, acc_z];
        mag_reor = [-mag_y, mag_x, -mag_z];
        gyro_reor = acc_reor;
    elseif logger_config == 4
        acc_reor = [acc_y, -acc_x, acc_z];
        mag_reor = [mag_y, -mag_x, -mag_z];
        gyro_reor = acc_reor;
    end
end

%% save struct (not for now)