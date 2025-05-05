% non mi torna, non ha senso secondo me. Quando integro il gyro fa del
% casino. Secondo me il problema è lì e infatti anche il filtro di Kalman
% per la rotta mi sminchia malissimo.

close all
%% data
gyro_fft_exe = 1;
Fs_acc_gyro = Fs*10;
Fs_mag = Fs;
Fpass_acc = 0.01;
Fpass_gyro_low = 0.0001; % taglia solo la componente continua
Fpass_gyro_high = 1; % dovrebbe andare bene per un bandpass come soglia alta
g = 9.81;
movmean_size  = 50;

acc_reor_g = g.*acc_reor;
acc_reor_x = lowpass(acc_reor_g(:, 1), Fpass_acc, Fs_acc_gyro);
acc_reor_y = lowpass(acc_reor_g(:, 2), Fpass_acc, Fs_acc_gyro);
acc_reor_z = lowpass(acc_reor_g(:, 3), Fpass_acc, Fs_acc_gyro);

acc_reor_tot = [acc_reor_x, acc_reor_y, acc_reor_z];

% LOWPASS
% gyro_reor_x = lowpass(gyro_reor(:, 1), Fpass_gyro_low, Fs_acc_gyro);
% gyro_reor_y = lowpass(gyro_reor(:, 2), Fpass_gyro_low, Fs_acc_gyro);
% gyro_reor_z = lowpass(gyro_reor(:, 3), Fpass_gyro_low, Fs_acc_gyro);
% gyro_rad = deg2rad([gyro_reor_x, gyro_reor_y, gyro_reor_z]); % se c'è un - è aggiunto per vedere il segno degli assi se è corretto o al contrario

% HIGHPASS
% gyro_reor_x = highpass(gyro_reor(:, 1), Fpass_gyro_high, Fs_acc_gyro);
% gyro_reor_y = highpass(gyro_reor(:, 2), Fpass_gyro_high, Fs_acc_gyro);
% gyro_reor_z = highpass(gyro_reor(:, 3), Fpass_gyro_high, Fs_acc_gyro);
% gyro_rad = deg2rad([gyro_reor_x, gyro_reor_y, gyro_reor_z]); % se c'è un - è aggiunto per vedere il segno degli assi se è corretto o al contrario

% BANDPASS
gyro_reor_x = bandpass(gyro_reor(:, 1), [Fpass_gyro_low, Fpass_gyro_high], Fs_acc_gyro);
gyro_reor_y = bandpass(gyro_reor(:, 2), [Fpass_gyro_low, Fpass_gyro_high], Fs_acc_gyro);
gyro_reor_z = bandpass(gyro_reor(:, 3), [Fpass_gyro_low, Fpass_gyro_high], Fs_acc_gyro);
gyro_rad = deg2rad([gyro_reor_x, gyro_reor_y, gyro_reor_z]); % se c'è un - è aggiunto per vedere il segno degli assi se è corretto o al contrario
% torna sia con + che con - l'andamento, questo mi fa sospettare sulla poca
% influenza del giroscopio nei calcoli....
%% AHRS filter
accel_att = acc_reor_tot(1:10:end, :);
gyro_att = gyro_rad(1:10:end, :);
mag_att = mag_postcalib;

Fs_att = Fs/10;

fuse = ahrsfilter('SampleRate',Fs_att, 'ExpectedMagneticFieldStrength', F_micro);
[q_ahrs, ang_vel_ahrs] = fuse(accel_att, gyro_att, mag_att);
time = datetime_mag; 

% plot 
angles_est_ahrs = eulerd(q_ahrs,'ZYX','frame');

figure('Name', ['figure ', num2str(id_plot),', ypr - ahrs filter'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_mag, angles_est_ahrs, 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
title('YPR orientation Estimate - ahrs filter')
legend('z-axis', 'y-axis', 'x-axis')
ylabel('Rotation (degrees)')

%
figure('Name', ['figure ', num2str(id_plot),', yaw vs my yaw - ahrs filter'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_mag, smoothdata(angles_est_ahrs(:, 1), "movmedian", movmean_size), 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
hold on
plot(datetime_mag, yaw_m_calib, 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
title('Yaw orientation Estimate vs old - ahrs filter')
legend('yaw', 'yaw mio')
ylabel('Rotation (degrees)')

%
figure('Name', ['figure ', num2str(id_plot),', pitch vs my pitch - ahrs filter'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_mag, smoothdata(angles_est_ahrs(:, 2), "movmedian", movmean_size), 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
hold on
plot(datetime_mag, pitch_calib, 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
title('pitch orientation Estimate vs old - ahrs filter')
legend('pitch', 'pitch mio')
ylabel('Rotation (degrees)')

%
figure('Name', ['figure ', num2str(id_plot),', roll vs my roll - ahrs filter'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_mag, smoothdata(angles_est_ahrs(:, 3), "movmedian", movmean_size), 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
hold on
plot(datetime_mag, roll_calib, 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
title('roll orientation Estimate vs old - ahrs filter')
legend('roll', 'roll mio')
ylabel('Rotation (degrees)')

%
figure('Name', ['figure ', num2str(id_plot),', yaw - ahrs filter'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_mag, smoothdata(angles_est_ahrs(:, 1), "movmedian", movmean_size), 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
title('Yaw orientation Estimate - ahrs filter')
legend('z-axis')
ylabel('Rotation (degrees)')

%
figure('Name', ['figure ', num2str(id_plot),', pitch - ahrs filter'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_mag, smoothdata(angles_est_ahrs(:, 2), "movmedian", movmean_size), 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
title('Pitch orientation Estimate - ahrs filter')
legend('y-axis')
ylabel('Rotation (degrees)')

%
figure('Name', ['figure ', num2str(id_plot),', roll - ahrs filter'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_mag, smoothdata(angles_est_ahrs(:, 3), "movmedian", movmean_size), 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
title('Roll orientation Estimate - ahrs filter')
legend('x-axis')
ylabel('Rotation (degrees)')

%% ecompass
% Pass the magnetic field strength and acceleration to the ecompass 
% function. The ecompass function returns a quaternion rotation operator. 
% Convert the quaternion to Euler angles in degrees.

q = ecompass(accel_att, mag_att);
e = eulerd(q,'ZYX','frame');

% plot
figure('Name', ['figure ', num2str(id_plot),', ypr - ecompass'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_mag, e, 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
title('YPR orientation Estimate - ecompass')
legend('z-axis', 'y-axis', 'x-axis')
ylabel('Rotation (degrees)')

figure('Name', ['figure ', num2str(id_plot),', yaw vs my yaw - ecompass'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_mag, e(:, 1), 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
hold on
plot(datetime_mag, yaw_m_calib, 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
title('Yaw orientation Estimate vs old - ecompass')
legend('yaw', 'yaw mio')
ylabel('Rotation (degrees)')

figure('Name', ['figure ', num2str(id_plot),', pitch vs my pitch - ecompass'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_mag, e(:, 2), 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
hold on
plot(datetime_mag, pitch_calib, 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
title('Pitch orientation Estimate vs old - ecompass')
legend('pitch', 'pitch mio')
ylabel('Rotation (degrees)')

figure('Name', ['figure ', num2str(id_plot),', roll vs my roll - ecompass'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_mag, e(:, 3), 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
hold on
plot(datetime_mag, roll_calib, 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
title('Roll orientation Estimate vs old - ecompass')
legend('roll', 'roll mio')
ylabel('Rotation (degrees)')

%% IMU filter
% HO TROVATO QUESTO SU MATWORKS:
% The imufilter system object fuses accelerometer and gyroscope data using 
% an internal error-state Kalman filter. The filter is capable of removing 
% the gyroscope bias noise, which drifts over time. The filter does not 
% process magnetometer data, so it does not correctly estimate the 
% direction of north. The algorithm assumes the initial position of the 
% sensor is in such a way that device X-axis of the sensor is pointing 
% towards magnetic north, the device Y-axis of the sensor is pointing to 
% east and the device Z-axis of the sensor is pointing downwards. The 
% sensor must be stationary, before the start of this example.

all_sample = 0;

if all_sample == 0
    accel_att = acc_reor_tot(1:10:end, :);
    gyro_att = gyro_rad(1:10:end, :); 
    Fs_att = Fs/10;
    datetime_plt = datetime_mag;
elseif all_sample == 1
    accel_att = acc_reor_tot;
    gyro_att = gyro_rad; 
    Fs_att = Fs;
    datetime_plt = datetime_acc;
end

fuse = imufilter('SampleRate',Fs_att);
[q_imu, ang_vel_imu] = fuse(accel_att, gyro_att);

% plot
angles_est_imu = eulerd(q_imu,'ZYX','frame');

figure('Name', ['figure ', num2str(id_plot),', ypr imu filter'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_plt, angles_est_imu, 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
title('YPR orientation Estimate - imu filter')
legend('z-axis', 'y-axis', 'x-axis')
ylabel('Rotation (degrees)')

%
figure('Name', ['figure ', num2str(id_plot),', yaw vs my yaw imu filter'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_plt, smoothdata(angles_est_imu(:, 1), "movmedian", movmean_size), 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
hold on
plot(datetime_mag, yaw_m_calib, 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
title('Yaw orientation Estimate vs old - imu filter')
legend('yaw', 'yaw mio')
ylabel('Rotation (degrees)')

%
figure('Name', ['figure ', num2str(id_plot),', pitch vs pitch mio - imu filter'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_plt, smoothdata(angles_est_imu(:, 2), "movmedian", movmean_size), 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
hold on
plot(datetime_mag, pitch_calib, 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
title('pitch orientation Estimate vs old - imu filter')
legend('x-axis')
ylabel('Rotation (degrees)')

%
figure('Name', ['figure ', num2str(id_plot),', roll vs roll mio - imu filter'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_plt, smoothdata(angles_est_imu(:, 3), "movmedian", movmean_size), 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
hold on
plot(datetime_mag, roll_calib, 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
title('Roll orientation Estimate vs old - imu filter')
legend('x-axis')
ylabel('Rotation (degrees)')

%
figure('Name', ['figure ', num2str(id_plot),', yaw - imu filter'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_plt, smoothdata(angles_est_imu(:, 1), "movmedian", movmean_size), 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
title('Yaw orientation Estimate - imu filter')
legend('z-axis')
ylabel('Rotation (degrees)')

%
figure('Name', ['figure ', num2str(id_plot),', pitch - imu filter'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_plt, smoothdata(angles_est_imu(:, 2), "movmedian", movmean_size), 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
title('Pitch orientation Estimate - imu filter')
legend('y-axis')
ylabel('Rotation (degrees)')

%
figure('Name', ['figure ', num2str(id_plot),', roll - imu filter'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_plt, smoothdata(angles_est_imu(:, 3), "movmedian", movmean_size), 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
title('Roll orientation Estimate - imu filter')
legend('x-axis')
ylabel('Rotation (degrees)')



%% ahrs vs imu

%
figure('Name', ['figure ', num2str(id_plot),', ahrs yaw vs imu yaw'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_mag, smoothdata(angles_est_ahrs(:, 1), "movmedian", movmean_size), 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
hold on
plot(datetime_mag, smoothdata(angles_est_imu(:, 1), "movmedian", movmean_size), 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
title('ahrs yaw vs imu yaw')
legend('ahrs', 'imu')
ylabel('Rotation (degrees)')

%
figure('Name', ['figure ', num2str(id_plot),', ahrs pitch vs imu pitch'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_mag, smoothdata(angles_est_ahrs(:, 2), "movmedian", movmean_size), 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
hold on
plot(datetime_mag, smoothdata(angles_est_imu(:, 2), "movmedian", movmean_size), 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
title('ahrs pitch vs imu pitch')
legend('ahrs', 'imu')
ylabel('Rotation (degrees)')

%
figure('Name', ['figure ', num2str(id_plot),', ahrs roll vs imu roll'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_mag, smoothdata(angles_est_ahrs(:, 3), "movmedian", movmean_size), 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
hold on
plot(datetime_mag, smoothdata(angles_est_imu(:, 3), "movmedian", movmean_size), 'LineStyle',':', 'Marker', 'o', 'MarkerSize', 2)
title('ahrs roll vs imu roll')
legend('ahrs', 'imu')
ylabel('Rotation (degrees)')


%% gyro fft

if gyro_fft_exe == 1
    Freq = Fs_acc_gyro;
    L = length(gyro_reor(:, 1));
    n = 2^nextpow2(L);
    f_plt = Freq*(0:(n/2))/n;
    

    gyro_fft_x = fft(gyro_reor(:, 1), n);
    P_gx = abs(gyro_fft_x/sqrt(n)).^2;
    gyro_fft_y = fft(gyro_reor(:, 2), n);
    P_gy = abs(gyro_fft_y/sqrt(n)).^2;
    gyro_fft_z = fft(gyro_reor(:, 3), n);
    P_gz = abs(gyro_fft_z/sqrt(n)).^2;
   
    gyro_fft_x_fl = fft(gyro_reor_x, n);
    P_gx_fl = abs(gyro_fft_x_fl/sqrt(n)).^2;
    gyro_fft_y_fl = fft(gyro_reor_y, n);
    P_gy_fl = abs(gyro_fft_y_fl/sqrt(n)).^2;
    gyro_fft_z_fl = fft(gyro_reor_z, n);
    P_gz_fl = abs(gyro_fft_z_fl/sqrt(n)).^2;

    
    
    figure('Name', ['figure ', num2str(id_plot),', gyrox fft'], 'NumberTitle','off'); id_plot = id_plot + 1;
    clf
    plot(f_plt,P_gx(1:n/2+1))
    hold on
    plot(f_plt,P_gx_fl(1:n/2+1))
    legend('no filt', 'filt')
    title('gyrox fft')
    
    figure('Name', ['figure ', num2str(id_plot),', gyroy fft'], 'NumberTitle','off'); id_plot = id_plot + 1;
    clf
    plot(f_plt,P_gy(1:n/2+1))
    hold on
    plot(f_plt,P_gy_fl(1:n/2+1))
    legend('no filt', 'filt')
    title('gyroy fft')
    
    figure('Name', ['figure ', num2str(id_plot),', gyroz fft'], 'NumberTitle','off'); id_plot = id_plot + 1;
    clf
    plot(f_plt,P_gz(1:n/2+1))
    hold on
    plot(f_plt,P_gz_fl(1:n/2+1))
    legend('no filt', 'filt')
    title('gyroz fft')
end