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
	angle_c_plot		= angle_c_calib;
	angle_c_norm_plot	= angle_c_norm_calib;
	angle_s_plot		= angle_s_calib;
	angle_s_norm_plot	= angle_s_norm_calib;
	roll_plot			= roll_calib;
	pitch_plot			= pitch_calib;
	yaw_m_plot			= yaw_m_calib;
	yaw_g_plot			= yaw_g_calib;
	roll_norm_plot		= roll_norm_calib;
	pitch_norm_plot		= pitch_norm_calib;
	yaw_m_norm_plot		= yaw_m_norm_calib;
	yaw_g_norm_plot		= yaw_g_norm_calib;
else
	fprintf('Use magnetic field after calibration \n')
	mag_reor_plot		= mag_reor;
	norm_mag_reor_plot	= norm_mag_reor;
	mag_norm_reor_plot	= mag_norm_reor;
	angle_c_plot		= angle_c;
	angle_c_norm_plot	= angle_c_norm;
	angle_s_plot		= angle_s;
	angle_s_norm_plot	= angle_s_norm;
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
norm_acc_mag_plot

%% angle between g and magnetic field reoriented 
angle_g_mf_plot

%% YPR 
% standard and non-standard versions must be equal, here we use rotated 
% measurement vectors
ypr_plot

%% end	
fprintf('single_turtle_orientation_plot completed \n')