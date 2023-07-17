function [norma_acc, acc_normz, norma_mag, mag_normz, norma_gyro, gyro_normz] = norm_acc_mg(acc, mag, gyro)
% norm_acc_mg
% This function computes both norm and normalized vector of acceleration, 
% gyroscope, and magnetic field vectors passed as input arguments, whose 
% must be already reoriented in the desired reference frame.
%
% INPUT:
%	acc		- acceleration dataset (nx3, n = num. samples)
%	mag		- magnetic field dataset (nx3, n = num. samples)
%	gyro	- gyroscope dataset (nx3, n = num. samples)
% OUTPUT:
%	norma_acc	- norm of acceleration vector
%	acc_normz	- normalized acceleration dataset (nx3, n = num. samples)
%	norma_mag	- norm of magnetic field vector
%	mag_normz	- normalized magnetic field dataset (nx3, n = num. samples)
%	norma_gyro	- norm of angular velocity vector
%	gyro_normz	- normalized gyroscope dataset (nx3, n = num. samples)
%
%% acceleration
len_acc = size(acc, 1);

norma_acc = zeros(len_acc, 1);
acc_normz = zeros(len_acc, 3);

for i=1:len_acc
	norma_acc(i)= norm(acc(i, :));
	acc_normz(i, :) = acc(i, :)./norma_acc(i);
end

%% magnetic field
len_mag = size(mag, 1);

norma_mag = zeros(len_mag, 1);
mag_normz =  zeros(len_mag, 3);

for i=1:len_mag
	norma_mag(i) = norm(mag(i, :));
	mag_normz(i, :) = mag(i, :)./norma_mag(i);
end

%% gyroscope
if nargin > 2
	len_gyro = size(gyro, 1);

	norma_gyro = zeros(len_gyro, 1);
	gyro_normz =  zeros(len_gyro, 3);

	for i=1:len_gyro
		norma_gyro(i)=norm(gyro(i, :));
		gyro_normz(i, :) = gyro(i, :)./norma_gyro(i);
	end
else
	norma_gyro = 0;
	gyro_normz = 0;
end

%% exit
fprintf('norm_acc_mg completed \n')