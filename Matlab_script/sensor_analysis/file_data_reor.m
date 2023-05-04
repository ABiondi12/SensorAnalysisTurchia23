% struct_sensor_reoriented
%% acc and mag extrapulation: 'original' raw data
acc_x = data_raw.accx;
acc_y = data_raw.accy;
acc_z = data_raw.accz;

acc_sens_orig = [acc_x, acc_y, acc_z];

mag_x = data_raw.magx;
mag_y = data_raw.magy;
mag_z = data_raw.magz;

if sensor_model == 1
    gyro_x = data_raw.gyrox;
    gyro_y = data_raw.gyroy;
    gyro_z = data_raw.gyroz;

    gyro_sens_orig = [gyro_x, gyro_y, gyro_z];
end



%% reorient
% magnetometer has y axis along turtle trajectory direction, z along down
% direction and x in order to obtain a 'rigth' frame. In order to align its
% frame to the one of accelerometers (we want to have both of them
% expressed using the same local reference frame) its necessary to rotate
% its raw measure of pi/2 around its z axis and of pi around current x axis
% (current axis composition of rotation matrices)

% rotz(pi/2)*rotx(pi)

if sensor_model == 1
    mag_sens_orig = [mag_y, mag_x, -mag_z];	%  microTesla AGM
elseif sensor_model == 2
    mag_sens_orig = [mag_y, mag_x, -mag_z];	%  microTesla Axy-5 CHECK
end
%% CHECK SUI NUOVI DISPOSITIVI COME SONO MESSI I SENSORI SIA UNO RISPETTO
%% ALL'ALTRO SIA RISPETTO A LOCAL NED
	
%% old (wrong)
% % acc and mag extrapulation: 'rotated' raw data
% % rotx(pi) = [1 0 0; 0 -1 0; 0 0 -1]
% 
% acc_sens = [acc_x, -acc_y, -acc_z];
% gyro_sens = [gyro_x, -gyro_y, -gyro_z];
% % rotx(pi) = [1 0 0; 0 -1 0; 0 0 -1] applied to 'original' mag data, which
% % are the ones already realigned to accelerometer local reference frame:
% % [mag_y, mag_x, -mag_z]
% 
% mag_sens = [mag_y, -mag_x, mag_z];
% 
% % we can also start from sensor frame and apply directly rotation needed to
% % bring it as NED
% %				[0	1	0]
% %	Rz(-pi/2) =	[-1	0	0]
% %				[0	0	1]
% %
% % mag_sens = Rz(-pi/2) * [mag_x; mag_y; mag_z] = [mag_y; -mag_x; mag_z]

%% new: vertical placement, wide base in back, tip down (high connector)*

% for how the sensor is mounted inside the structure (vertical with 
% 	connector at the top, wide base at the rear):

% for mag. data must be rotated of -pi/2 around y-axis and of -pi/2 around 
% z-axis (after first rotation):  
%							[0 0 -1]	[0  1 0]	[0  0 -1]
%	Ry(-pi/2)*Rx(-pi/2) =	[0 1  0] *  [-1 0 0] =  [-1 0  0]
%							[1 0  0]	[0 0  1]	[0  1  0]

% mag_sens = Ry(-pi/2) * Rx(-pi/2) * mag_sens_orig = [-mag_z, -mag_x, mag_y]

% For acc data must be rotated of pi around z-axis and of -pi/2 around
% y-axis (after first rotation): 
%						[-1 0  0]	[0 0 -1]	[0  0 1]
%	Rz(pi)*Ry(-pi/2) =	[0  -1 0] * [0 1  0] =  [0 -1 0]
%						[0  0  1]	[1 0  0]	[1 0  0]

% acc_sens = Rz(pi) * Ry(-pi/2) * acc_sens_orig = [acc_z, -acc_y, acc_x]

% It can be obtain also by rotating the measurements obtained for the 
% horizontal version of -pi/2 around the y-axis:
% acc_sens = [acc_x, -acc_y, -acc_z];
% mag_sens = [mag_y, -mag_x, mag_z];

% acc_sens' = Ry(-pi/2) * acc_sens = [acc_z, -acc_y, acc_x] 
% mag_sens' = Ry(-pi/2) * mag_sens = [-mag_z, -mag_x, mag_y];

% Attention, in the wander phase the sensor floats with the orange part at
% the top, so the sensor is placed horizontally with the wide base upwards.
% Then, the correction to be made is different. For the pre-deployment 
% phase, on the other hand, it makes little sense to talk about it because
% there is no fixed reference, it is me who rotate it in my hands, but for
% simplicity of interpretation of the data I reorient it as when it is on
% board the turtle.

acc_sens	= [acc_z, -acc_y, acc_x];
mag_sens	= [-mag_z, -mag_x, mag_y];

if sensor_model == 1
    gyro_sens	= [gyro_z, -gyro_y, gyro_x];
end

%% assign to the struct
data_raw.accx = acc_sens(:, 1);
data_raw.accy = acc_sens(:, 2);
data_raw.accz = acc_sens(:, 3);

data_raw.magx = mag_sens(:, 1);
data_raw.magy = mag_sens(:, 2);
data_raw.magz = mag_sens(:, 3);

if sensor_model == 1
    data_raw.gyrox = gyro_sens(:, 1);
    data_raw.gyroy = gyro_sens(:, 2);
    data_raw.gyroz = gyro_sens(:, 3);
end

%% save struct

fprintf(['all reoriented data have been correctly loaded \n'])
	
fprintf('Saving data_raw.mat... \n')
save('data_raw', 'data_raw');
fprintf('data_raw.mat saved! \n')