% mag calibration
%% select calibration section
same_dataset = 0;

while same_dataset ~= 1 && same_dataset ~= 2
	fprintf('Calibration set is at the beginning of the dataset?\n')
	fprintf('1 = yes \n')
	fprintf('2 = no \n')
	
	same_dataset = input('');
end

% hand-self insertion of start and stop time of the calibration section
fprintf('Calibration session: \n')
fprintf('Start year: \n')
Yi = input('');
fprintf('Start month: \n')
Mi = input('');
fprintf('Start day: \n')
Di = input('');
fprintf('Start hour: \n')
Hi = input('');
fprintf('Start minute: \n')
MIi = input('');
fprintf('Start second: \n')
Si = input('');
MSi = 000;

fprintf('Stop year: \n')
Yf = input('');
fprintf('Stop month: \n')
Mf = input('');
fprintf('Stop day: \n')
Df = input('');
fprintf('Stop hour: \n')
Hf = input('');
fprintf('Stop minute: \n')
MIf = input('');
fprintf('Stop second: \n')
Sf = input('');
MSf = 000;

%% Calibration perform
if same_dataset == 1	% Yes
	[start_id_calib, stop_id_calib] = time_id(datetime_mag, Yi, Mi, Di, Hi, MIi, Si, MSi, Yf, Mf, Df, Hf, MIf, Sf, MSf);
	mag_reor_calib = mag_reor(start_id_calib:stop_id_calib, :);
else					% no
	datetime_acc_calib	= table2array(data_calib(:, 2));
	data_accx_calib		= table2array(data_calib(:, 3));
	data_accy_calib		= table2array(data_calib(:, 4));
	data_accz_calib		= table2array(data_calib(:, 5));
	acc_sens_calib		= [data_accx_calib, data_accy_calib, data_accz_calib];
	
	if sensor == 2		% axy
		datetime_mag_calib	= table2array(data_calib(1:10:end, 2));
		data_magx_calib		= table2array(data_calib(1:10:end, 6));
		data_magy_calib		= table2array(data_calib(1:10:end, 7));
		data_magz_calib		= table2array(data_calib(1:10:end, 8));
	elseif sensor == 1	% AGM
		datetime_mag_calib	= table2array(data_calib(:, 2));
		data_magx_calib		= table2array(data_calib(:, 9));        
		data_magy_calib		= table2array(data_calib(:, 10));
		data_magz_calib		= table2array(data_calib(:, 11));
		data_gyrox_calib	= table2array(data_calib(:, 6));
		data_gyroy_calib	= table2array(data_calib(:, 7));
		data_gyroz_calib	= table2array(data_calib(:, 8));
		gyro_sens_calib		= [data_gyrox_calib, data_gyroy_calib, data_gyroz_calib];
	end
	mag_calib = [data_magx_calib, data_magy_calib, data_magz_calib];
	
	% reorient data
	if sensor == 1			% AGM
		[acc_reor_calib, mag_reor_calib, gyro_reor_calib]	= file_data_reor(acc_sens_calib, mag_sens_calib, gyro_sens_calib, sensor);
	elseif sensor == 2		% axy
		[acc_reor_calib, mag_reor_calib, unused_calib]		= file_data_reor(acc_sens_calib, mag_sens_calib, acc_sens_calib, sensor);
	end
	
end

% function that execute the calibration:
%	compute correction indeces
%	apply indices over the entire dataset
[mag_postcalib, soft_iron, hard_iron, exp_mag_strength, sphere_fit, ellips_fit] = mag_calib_main(mag_reor, mag_reor_calib);
norma_mag_postcalib = norm(mag_postcalib);

%% plot
mag_calibration_plot