function [acc_sens_orig, mag_sens_acc_reor, acc_sens, mag_sens ] = reor_acc_mag(raw_data, sensor_type, start_id_fcn, stop_id_fcn)
% Function demanded to take as input the raw data coming from the sensor
% and the sensor model, and to reorient them in order to obtain the value
% in a coherent reference frame with a "local" NED reference frame.

%% validity check
if sensor_type < 1 || sensor_type > 2
    error('invalid sensor type, select 1 for AGM and 2 for Axy-5')
end

if start_id_fcn <0 || stop_id_fcn  < 0
	error('invalid time indeces, they must be positive integer values')

elseif start_id_fcn > stop_id_fcn
	error('invalid time indeces, start must correspond a previous instant wrt stop')
end

if start_id_fcn == 0
	start_id_fcn = 1;
end

%% acc and mag extrapulation: 'original' raw data
acc_x = raw_data.accx(start_id_fcn:stop_id_fcn);
acc_y = raw_data.accy(start_id_fcn:stop_id_fcn);
acc_z = raw_data.accz(start_id_fcn:stop_id_fcn);

acc_sens_orig = [acc_x, acc_y, acc_z];

mag_x = raw_data.magx(start_id_fcn:stop_id_fcn);
mag_y = raw_data.magy(start_id_fcn:stop_id_fcn);
mag_z = raw_data.magz(start_id_fcn:stop_id_fcn);

mag_sens_orig = [mag_x, mag_y, mag_z];
% magnetometer has y axis along turtle trajectory direction, z along down
% direction and x in order to obtain a 'rigth' frame. In order to align its
% frame to the one of accelerometers (we want to have both of them
% expressed using the same local reference frame) its necessary to rotate
% its raw measure of pi/2 around its z axis and of pi around current x axis
% (current axis composition of rotation matrices)

% rotz(pi/2)*rotx(pi)
% if turtle_dataset_id == 1 versione vecchia dove tenevo acc non
% riorientata ovunque

mag_sens_acc_reor = [mag_y, mag_x, -mag_z];	%  microTesla
	
% acc and mag extrapulation: 'rotated' raw data
% rotx(pi) = [1 0 0; 0 -1 0; 0 0 -1]
acc_sens = [acc_x, -acc_y, -acc_z];
% rotx(pi) = [1 0 0; 0 -1 0; 0 0 -1] applied to 'original' mag data, which
% are the ones already realigned to accelerometer local reference frame:
% [mag_y, mag_x, -mag_z]
mag_sens = [mag_y, -mag_x, mag_z];

% we can also start from sensor frame and apply directly rotation needed to
% bring it as NED
%				[0	1	0]
%	Rz(-pi/2) =	[-1	0	0]
%				[0	0	1]
%
% mag_sens = Rz(-pi/2) * [mag_x; mag_y; mag_z] = [mag_y; -mag_x; mag_z]