% estimation of the path followed by the turtles

% version 1: using ypr and gps data and acceleration data (dead rec)
% version 2: using gyroscope also

fix_sat = readtable('Banu_satelliti.xlsx');
datetime_sat	= table2array(fix_sat(6:end, 1));
trial_lat		= table2array(fix_sat(6:end, 9));
trial_long		= table2array(fix_sat(6:end, 10));

lat_id = find(~isnan(trial_lat));
long_id = find(~isnan(trial_long));

% equal = find(lat_id ~= long_id); check, they are the same id

datetime_sat_filt	= datetime_sat(lat_id);
trial_lat_filt		= trial_lat(lat_id);
trial_long_filt		= trial_long(lat_id);

% dead reckoning

% Idee:
%	from latitude and longitude -- global x and y in order to have a point
%	in the map
%
%	from ypr -- convert x, y, z coordinates in pseudo-NED ref into NED ref
%	frame, in order to be able to use them and try to reconstruct the
%	route.
%
% Need a local map where to place latitude and longitude values (as for the
% first turtles
%
% You also have to filter acc data in order to isolate gravity measures and
% only integrate the dynamic one.
%
	datetime_acc_path	= datetime_acc;
	data_accx_path		= acc_reor(:, 1);
	data_accy_path		= acc_reor(:, 2);
	data_accz_path		= acc_reor(:, 3);
	acc_reor_path		= acc_reor;

	datetime_gyro_path	= datetime_gyro;
	data_gyrox_path		= gyro_reor(:, 1);
	data_gyroy_path		= gyro_reor(:, 2);
	data_gyroz_path		= gyro_reor(:, 3);
	gyro_reor_path		= gyro_reor;
	
	datetime_depth_path	= datetime_depth;
	depth_path			= depth;
	
	yaw_m_path 		= yaw_m_calib;
	pitch_path		= pitch_calib;
	roll_path		= roll_calib;

	
% mi sa che devo prendere un SDR centrato tipo nel punto di partenza e
% orientato come NED e poi da li vedere lo spostamento, usando i fix del
% GPS per correggere e ypr per ruotare gli assi di accelerometro e
% giroscopio prima del loro utilizzo per dead reckoning. Uso di acc e gyro
% per dead reck e eventualmente filtri di Kalman da vedere, non ne ho idea
% XD
%
% vedi appunti di navigazione e di isi e sys sub per vedere come si applica
% questa roba, Krank aveva fatto con Heading e basta.
