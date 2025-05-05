% dead reckoning - per adesso non funziona uffi uffino
%% commenti
% c'è qualcosa che non va, ho fatto il filtro e così compila, ma sbaglia
% completamente la posizione. Vorrei correggere anche la profondità ma non
% riesco, forse devo usare insEKF e farmi il mio sensore custom di
% profondità.

%% load lla data
close all
% forse devi considerare che hai la gravità come accelerazione!!! sennò ti
% dice che vai giù in profondità troppo, ma non lo so

gps_fix = readtable('Erica_gps.csv');

datetime_gps = table2array(gps_fix(:, 1));

lla = strrep(table2array(gps_fix(:, 2:4)), ',', '.');

%% init variables

% release_gps = [36.3, 28.75];
release_gps = [str2double(lla(1, 1)), str2double(lla(1, 2))];
altitude_ref = 0;
imuFs = 10;
lla_plt = str2double(lla);

Rmag = 0.0900;
Rvel = 0.0100;
Rpos = 2.5600;
% Rmag = 0.0900;
% Rvel = 0.0100;
% Rpos = 1.0000;
gpsvel = zeros(size(lla));

refloc = [release_gps(1), release_gps(2), altitude_ref];

init_or = eul2quat([deg2rad(yaw_m_calib(1)), deg2rad(pitch_calib(1)), deg2rad(roll_calib(1))]);
init_pos = [0.0, 0.0, 0.0]; % ipotizzo che parta da 0, poi da lì triangolo
init_vel = [0.0, 0.0, 0.0]; % ipotizzo che parta da 0
Dtheta_bias = [0.0, 0.0, 0.0];
Dv_bias = [0.0, 0.0, 0.0];
init_mag = mag_postcalib(1,:);
mag_bias = [100.00  100.00  100.00];

initstate = [init_or(1)  init_or(2)  init_or(3)  init_or(4)  init_pos(1)  init_pos(2)  init_pos(3)  init_vel(1)  init_vel(2)  init_vel(3)  Dtheta_bias(1)  Dtheta_bias(2)  Dtheta_bias(3)  Dv_bias(1)  Dv_bias(2)  Dv_bias(3)  init_mag(1)  init_mag(2)  init_mag(3)  mag_bias(1)  mag_bias(2)  mag_bias(3)];
% q = orientation (quaternion)
% position = init pos in NED
% v = init velocity
% 

% q0, q1, q2, q3, positionN, positionE, positionD, νN, νE, νD, ΔθbiasX,
% ΔθbiasY, ΔθbiasZ, ΔνbiasX, ΔνbiasY, ΔνbiasZ, geomagneticFieldVectorN,
% geomagneticFieldVectorE, geomagneticFieldVectorD, magbiasX, magbiasY,
% magbiasZ

%% Initialize the insfilterMARG filter object.
f = insfilterMARG;
f.IMUSampleRate = imuFs;
f.ReferenceLocation = refloc;
% f.AccelerometerBiasNoise = 2e-4;
% f.AccelerometerNoise = 2;
% f.GyroscopeBiasNoise = 1e-16;
% f.GyroscopeNoise = 1e-5;
% f.MagnetometerBiasNoise = 1e-10;
% f.GeomagneticVectorNoise = 1e-12;
% f.StateCovariance = 1e-9*ones(22);
f.State = initstate;

%% navigation variables
g = 9.81;
accel = g.*acc_reor;
gyro_rad = deg2rad(gyro_reor);
gyro = gyro_rad;
mag = mag_postcalib;

% mag = [smoothdata(mag(:, 1)), smoothdata(mag(:, 2)), smoothdata(mag(:, 3))];

fs_acc_gyro = Fs;
fs_mag = fs_acc_gyro/10;

gpsidx = 1;
magidx = 1;
magFs = fs_mag;             % Hz
gpuFs = fs_acc_gyro;        % Hz

N = size(accel,1);
p = zeros(N,3);
q = zeros(N,1,'quaternion');

%% din acceleration
% custom low pass filter

% custom_LPF_filter
custom_LPF_filter_deadreck

[dinx, diny, dinz] = apply_filter(accel(:, 1), accel(:, 2), accel(:, 3), LP_FIR);
% accel_din = [smoothdata(dinx), smoothdata(diny), smoothdata(dinz)];

acc_choice = 0;
fprintf('Acceleration to be used inside the navigation filter: \n')
fprintf('1) Total acceleration \n')
fprintf('2) Dinamic acceleration \n')

while acc_choice < 1 || acc_choice > 2
    acc_choice = input('');
end

if acc_choice == 1
    accel_filter = accel;
elseif acc_choice == 2
    accel_filter = accel_din;
end

%% Fuse accelerometer, gyroscope, magnetometer, and GPS data.

for ii = 1:size(accel_filter,1)               % Fuse IMU
   f.predict(accel_filter(ii,:), gyro(ii,:));
        
   % if ~mod(ii,fix(imuFs/magFs))            % Fuse magnetometer
   if datetime_acc(ii) == datetime_mag(magidx)
       f.fusemag(mag(magidx,:), Rmag);
       
       if datetime_mag(magidx) == datetime_gps(gpsidx)
            f.fusegps(lla_plt(gpsidx,:),Rpos,gpsvel(gpsidx,:),Rvel);
            gpsidx = gpsidx + 1;
       end
       magidx = magidx + 1;
   end

   [p(ii,:),q(ii)] = pose(f);           % Log estimated pose
end

%% Calculate and display RMS errors.

posErr = truePos - p;
qErr = rad2deg(dist(trueOrient,q));
pRMS = sqrt(mean(posErr.^2));
qRMS = sqrt(mean(qErr.^2));
fprintf('Position RMS Error\n\tX: %.2f, Y: %.2f, Z: %.2f (meters)\n\n',pRMS(1),pRMS(2),pRMS(3));
 
%%

gpsprova = 1;

for ii = 1:size(mag,1)               % Fuse IMU
    if datetime_mag(ii) == datetime_gps(gpsprova)
        if gps_prova == 1
            prova = ii;
        end
        gpsprova = gpsprova + 1;
    end
end

att_est = eulerd(q,'ZYX','frame');

%%
lla0 = [lla_plt(1, 1), lla_plt(1, 2), lla_plt(1, 3)];
lla_dr = ned2lla(p, lla0,'flat');

figure('Name', ['figure ', num2str(id_plot),', lla dead reckoning vs gps fixes'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(lla_dr(:, 1), lla_dr(:, 2), '*', 'MarkerSize', 2)
hold on
plot(lla_plt(:, 1), lla_plt(:, 2), '>', 'MarkerSize', 2)

grid on
box on
axis tight
xlabel('lat','FontSize', dim_font)
ylabel('long','FontSize', dim_font)
legend('dr', 'gps','FontSize', dim_font, 'Location', 'best')
set(gca,'FontSize', dim_font)
title('dead reckoning')



figure('Name', ['figure ', num2str(id_plot),', lla dead reckoning'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(lla_dr(:, 1), lla_dr(:, 2), '*', 'MarkerSize', 2)
grid on
box on
axis tight
xlabel('lat','FontSize', dim_font)
ylabel('long','FontSize', dim_font)
set(gca,'FontSize', dim_font)
