function [norma_acc, acc_normz, norma_mag, mag_normz, norma_gyro, gyro_normz] = norm_acc_mg(acc, mag, gyro)
% computes both norm and normalized vector of acc and mag vectors passed as
% input arguments, whose must be already reoriented in the desired frame
%% acc
len_acc = size(acc, 1);

norma_acc = zeros(len_acc, 1);
acc_normz = zeros(len_acc, 3);

for i=1:len_acc
	norma_acc(i)= norm(acc(i, :));
	acc_normz(i, :) = acc(i, :)./norma_acc(i);
end

%% mag
len_mag = size(mag, 1);

norma_mag = zeros(len_mag, 1);
mag_normz =  zeros(len_mag, 3);

for i=1:len_mag
	norma_mag(i) = norm(mag(i, :));
	mag_normz(i, :) = mag(i, :)./norma_mag(i);
end

%% gyro
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