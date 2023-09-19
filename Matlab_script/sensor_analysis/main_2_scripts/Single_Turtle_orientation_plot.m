% Single_Turtle_orientation_plot
% This script is demanded to handle the plot section for the firsts data
% elaborations. At the beginning, it is possible (if auto_calib_use = 0, 
% this parameter can be set at the beginning of the script main_1_raw_data) 
% to choose if to show magnetic field data before or after calibration.
%
% The plot scripts that are called from this script are the following:
%
%	1. norm_acc_mag_plot
%			plot for the norm of the measured vectors (acceleration and
%			magnetic field)
%
%	2. angle_g_mf_plot
%			plot the computed angle over time between the gravity 
%			vector (obtained as static component from the acceleration data
%			by filtering them with a low pass filter) and the measured 
%			magnetic field vector.
%
%	3. ypr_plot
%			plot of yaw, pitch and roll angles, computed in main_2_ypr 
%			script, over time.
%
% For more details, refer directly to the specific scripts by calling the
% help command (help name_of_the_script).
%

%% plot parameters
dim_font = 30;
dim_fontb = 15;

%% flag
calib = 0;

%% calibrated or not calibrated data
if calib_perf == 1
	if auto_calib_use == 0
		while calib ~= 1 && calib ~= 2
			fprintf('Use calibrated magnetic field? \n')
			fprintf('1 = yes \n')
			fprintf('2 = no \n')

			calib = input('');
		end
	elseif auto_calib_use == 1
		calib = 1;
	end
else
	calib = 2;
end
	
if calib == 1
	fprintf('Use magnetic field after calibration \n')
	mag_reor_plot		= mag_postcalib;
	norm_mag_reor_plot	= norm_mag_reor_calib;
	mag_norm_reor_plot	= mag_norm_reor_calib;
	if auto_norm_g_mf_angle == 1 && g_mf_angle_enable == 1
		angle_c_plot		= angle_c_calib;
		angle_c_norm_plot	= angle_c_norm_calib;
		angle_s_plot		= angle_s_calib;
		angle_s_norm_plot	= angle_s_norm_calib;
	end
	roll_plot			= roll_calib;
	pitch_plot			= pitch_calib;
	yaw_m_plot			= yaw_m_calib;
	yaw_g_plot			= yaw_g_calib;
	roll_norm_plot		= roll_norm_calib;
	pitch_norm_plot		= pitch_norm_calib;
	yaw_m_norm_plot		= yaw_m_norm_calib;
	yaw_g_norm_plot		= yaw_g_norm_calib;
else
	fprintf('Use magnetic field before calibration \n')
	mag_reor_plot		= mag_reor;
	norm_mag_reor_plot	= norm_mag_reor;
	mag_norm_reor_plot	= mag_norm_reor;
	if auto_norm_g_mf_angle == 1 && g_mf_angle_enable == 1
		angle_c_plot		= angle_c;
		angle_c_norm_plot	= angle_c_norm;
		angle_s_plot		= angle_s;
		angle_s_norm_plot	= angle_s_norm;
	end
	roll_plot			= roll;
	pitch_plot			= pitch;
	yaw_m_plot			= yaw_m;
	yaw_g_plot			= yaw_g;
	roll_norm_plot		= roll_norm;
	pitch_norm_plot		= pitch_norm;
	yaw_m_norm_plot		= yaw_m_norm;
	yaw_g_norm_plot		= yaw_g_norm;
end

%% acceleration plot
yn_norm = 0;
if auto_norm_g_mf_angle == 1
	fprintf('Do you want to see the norm of g and mf data? \n')
	fprintf('1. Yes \n')
	fprintf('2. No \n')
	while yn_norm <= 0 || yn_norm > 2
		yn_norm = input('');
	end
	if yn_norm == 1
		norm_acc_mag_plot
	end
end
%% angle between g and magnetic field reoriented 
yn_angle = 0;
if auto_norm_g_mf_angle == 1 && g_mf_angle_enable == 1
	fprintf('Do you want to see the angle between g and mf data? \n')
	fprintf('1. Yes \n')
	fprintf('2. No \n')
	while yn_angle <= 0 || yn_angle > 2
		yn_angle = input('');
	end
	if yn_angle == 1
		angle_g_mf_plot
	end
end
%% YPR 
% standard and non-standard versions must be equal, here we use rotated 
% measurement vectors
ypr_plot

%% end	
fprintf('single_turtle_orientation_plot completed \n')