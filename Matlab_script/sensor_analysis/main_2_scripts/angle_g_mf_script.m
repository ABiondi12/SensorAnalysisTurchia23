% angle_g_mf

%% angle g_mf using NED values from online dataset
% angle between g and magnetic field evaluated using NED values ​​obtained
% from online database. We use normalized vectors, since we are only
% interested in directions.

% normalized magnetic field vector
XYZ_m_norm = XYZ_micro/norm(XYZ_micro);
% XYZ_m_norm = XYZ_micro/F_micro;	F_micro is the magnitude of mf

% normalized gravity vector expressed in NED reference frame
acc_NED = [0 0 1];

% % NED with N along magnetic north direction, we see E as zero
% XYZ_m_mag = rotz(-D, 'deg') * XYZ_micro;
% XYZ_m_mag_norm = XYZ_m_mag/norm(XYZ_m_mag);

% angle evaluation: we would like to obtain this value also using logger
% collected data.
[angle_c_NED, angle_s_NED, angle_tn_NED]= angle_g_mf(acc_NED, XYZ_m_norm', mag_step);
% angle_g_mf_NED = 90 - I;  should be the same as previously computed one,
% check 'angle_g_mf' script correctly works.

%% Norm computation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if release == 2 && (turtle_nm == 4 || turtle_nm == 5)
    fprintf('norm_acc_mg using rotated sensor measures \n')
[norm_acc_reor, acc_norm_reor, norm_mag_reor, mag_norm_reor,  ~, ~] = norm_acc_mg(acc_reor, mag_reor);

fprintf('norm_acc_mg using rotated sensor measures and calibrated magnetic field \n')
[~, ~, norm_mag_reor_calib, mag_norm_reor_calib, ~, ~] = norm_acc_mg(acc_reor, mag_postcalib);

else    
    fprintf('norm_acc_mg using rotated sensor measures \n')
    [norm_acc_reor, acc_norm_reor, norm_mag_reor, mag_norm_reor, norm_gyro_reor, gyro_norm_reor] = norm_acc_mg(acc_reor, mag_reor, gyro_reor);
    
    fprintf('norm_acc_mg using rotated sensor measures and calibrated magnetic field \n')
    [~, ~, norm_mag_reor_calib, mag_norm_reor_calib, ~, ~] = norm_acc_mg(acc_reor, mag_postcalib, gyro_reor);
end

if isnan(acc_norm_reor(end, 1))
	acc_norm_reor(end, 1) = 0;
end

if isnan(acc_norm_reor(end, 2))
	acc_norm_reor(end, 2) = 0;
end

if isnan(acc_norm_reor(end, 3))
	acc_norm_reor(end, 3) = 0;
end

%% NOTE: angle between g and mf and YPR angles computed with sensors data
% evaluation of the validity of the method by checking if the angle between
% the magnetic field and the gravitational field can be considered as a
% constant of the problem.

% Adopted 'rotated' data, rotated as they were collected with a
% logger having z axis along down direction and x axis along
% turtle motion direction.


% accelerometer - gravity field will be seen as [0 0 g]^T if accelerometer
%					has z axis along down direction
%% angle g_mf using reoriented collected data from loggers
if auto_norm_g_mf_angle == 1
	g_mf_angle_enable = 0;
	fprintf('Do you want to compute the angle between g and mf? \n')
	fprintf('1. Yes \n')
	fprintf('2. No \n')
	while g_mf_angle_enable <= 0 || g_mf_angle_enable > 2
		g_mf_angle_enable = input('');
	end
	
	if g_mf_angle_enable == 1
		% z axis along down (NED)
		fprintf('angle_g_mf using rotated sensor measures \n')
		[angle_c, angle_s, angle_tn]= angle_g_mf(acc_reor, mag_reor, mag_step);
		fprintf('angle_g_mf using rotated sensor measures once divided by their norm \n')
		[angle_c_norm, angle_s_norm, angle_tn_norm]= angle_g_mf(acc_norm_reor, mag_norm_reor, mag_step);
		
		if auto_calib == 1 || calib_perf == 1
			fprintf('angle_g_mf using rotated sensor measures and calibrated magnetic field \n')
			[angle_c_calib, angle_s_calib, angle_tn_calib]= angle_g_mf(acc_reor, mag_postcalib, mag_step);
			fprintf('angle_g_mf using rotated sensor measures once divided by their norm  and calibrated magnetic field \n')
			[angle_c_norm_calib, angle_s_norm_calib, angle_tn_norm_calib]= angle_g_mf(acc_norm_reor, mag_norm_reor_calib, mag_step);
		end
	end
end