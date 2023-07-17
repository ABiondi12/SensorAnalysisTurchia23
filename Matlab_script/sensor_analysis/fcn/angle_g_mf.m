function [angle_cos, angle_sin, angle_tn]= angle_g_mf(acc, mag, step)
% angle_g_mf
% This function is demanded to compute the angle between the magnetic field
% vector and the gravity vector obtained by filtering the acceleration data
% with a lowpass filter.
%
% It is known that:
%	a*b = |a|*|b|*cos(theta) --> cos(theta)=a*b/(|a|*|b|)
%	a^b = |a|*|b|*sin(theta) --> sin(theta)=a^b/(|a|*|b|)
%
% where a = magnetic field and b = gravity
%
% In order to facilitate the computation we proceed by normalizing the
% vectors before they are used in angles evaluation, which brings to have 
% the denominator always unitary

%% Acc resampling
% so that to have the same length as the magnetic field dataset
if(length(acc)~=length(mag))
	acc = acc(1:step:end, :);
end

%% low pass filter
Fpass = 0.01;

if step == 10
	Fs = 1;
elseif step == 5
	Fs = 2;
elseif step == 1
	Fs = 10;
end

g_x_B = lowpass(acc(:, 1), Fpass, Fs);
g_y_B = lowpass(acc(:, 2), Fpass, Fs);
g_z_B = lowpass(acc(:, 3), Fpass, Fs);

acc = [g_x_B g_y_B g_z_B];
[~, acc_n, ~, mag_n] = norm_acc_mg(acc, mag);

len = size(acc, 1);
angle_cos = zeros(len, 1);
angle_sin = zeros(len, 1);
angle_tn = zeros(len, 1);

%% angle computation
% for each temporal frame
for i = 1:len
	angle_cos(i) = acos(mag_n(i, :)*acc_n(i, :)')*180/pi;
	angle_sin(i) = asin(norm(cross(mag_n(i, :), acc_n(i, :))))*180/pi;
	angle_tn(i) = atan2((norm(cross(mag_n(i, :), acc_n(i, :)))),(mag_n(i, :)*acc_n(i, :)'))*(180/pi);
end

% 	% to debug correctness of obtained results
% 	% diff(i) = angle_cos(i) - angle_sin(i); 
% end
n_2s = 20;
more = 10; %  2*more second smooth
angle_cos			= smoothdata(angle_cos, 'movmean', more*n_2s);
angle_sin			= smoothdata(angle_sin, 'movmean', more*n_2s);
angle_tn			= smoothdata(angle_tn, 'movmean', n_2s);

fprintf('angle_g_mf completed \n')