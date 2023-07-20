% norm_acc_mag_plot
% This script produces plot for the norm of the measured vectors. 
% In particular, here there are the following plot:
%
%	1. norm of acceleration vector, reoriented measures
%	2. norm of static acceleration vector, reoriented measures
%	3. norm of magnetic field vector, reoriented measures
%	4. 3D plot of normalized magnetic field before calibration, reoriented 
%		measures
%
% Depending on calib parameter (set in Single_Turtle_orientation_plot) it
% will be used the magnetic field vector calibrated (calib = 1) or not
% calibrated (calib = 2).
%
% Moreover, for obtaining the static acceleration from the acceleration 
% sensor data (reoriented) it is applied a low pass filter (isolate static
% acceleration by keeping only low frequency components (ideally, only the 
% continuous one).

%% 1. norm of acceleration, reoriented measures
figure('Name', ['figure ', num2str(id_plot),', norm of acceleration vector, reoriented axes'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
	plot(datetime_acc, norm_acc_reor);
	grid on
	box on
	axis tight
	xlabel('time','FontSize', dim_font)
	ylabel('acc_{norm}/g','FontSize', dim_font)
	set(gca,'FontSize', dim_font) 
	title('Norm of acceleration vector, reoriented axes')
		
%% filter for isolate static acceleration
% filter parameter definition
Fpass = 0.01;
Fs_acc = 10;

% low pass filter applied on acceleration data to isolate low freq
% components (ideally, the static one (continuous))
g_x_B = lowpass(acc_reor(:, 1), Fpass, Fs_acc);
g_y_B = lowpass(acc_reor(:, 2), Fpass, Fs_acc);
g_z_B = lowpass(acc_reor(:, 3), Fpass, Fs_acc);

acc_stat = [g_x_B g_y_B g_z_B];

% norm of static acceleration component
[norm_acc_stat, ~, norm_mag_reor_stat, ~, ~, ~] = norm_acc_mg(acc_stat, mag_reor_plot);

%% 2. plot of static acceleration norm, rotated measures
figure('Name', ['figure ', num2str(id_plot),', norm of static acceleration vector, reoriented axes'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_acc(5:end-5), norm_acc_stat(5:end-5));
	grid on
	box on
	axis tight
	xlabel('time','FontSize', dim_font)
	ylabel('acc_{norm}/g','FontSize', dim_font)
	set(gca,'FontSize', dim_font) 
	title('Norm of static acceleration vector, reoriented axes')

%% 3. plot of norm of magnetic field, reoriented measures

if calib == 1 % calibrated magnetic field
	figure('Name', ['figure ', num2str(id_plot),', norm of calibrated magnetic field vector, reoriented axes'], 'NumberTitle','off'); id_plot = id_plot + 1;
else 
	figure('Name', ['figure ', num2str(id_plot),', norm of not calibrated magnetic field vector, reoriented axes'], 'NumberTitle','off'); id_plot = id_plot + 1;
end
	clf
	F_micro_plot = ones(size(norm_mag_reor_plot, 1), size(norm_mag_reor_plot, 2))*F_micro;
	plot(datetime_mag, [norm_mag_reor_plot, F_micro_plot]);
	grid on
	box on
	axis tight
	xlabel('time','FontSize', dim_font)
	ylabel('mf_{norm} (\mu T)','FontSize', dim_font)
	set(gca,'FontSize', dim_font) 
	if calib == 1 % calibrated magnetic field
		title('Norm of calibrated magnetic field vector, reoriented axes')
	else 
		title('Norm of not calibrated magnetic field vector, reoriented axes')
	end

%% 4. 3D plot of normalized magnetic field, rotated measures
if calib == 1 % calibrated magnetic field
	figure('Name', ['figure ', num2str(id_plot),', 3D plot of normalized calibrated magnetic field, reoriented measures'], 'NumberTitle','off'); id_plot = id_plot + 1;
else 
	figure('Name', ['figure ', num2str(id_plot),', 3D plot of normalized not calibrated magnetic field'], 'NumberTitle','off'); id_plot = id_plot + 1;
end
	clf
	plot3(mag_norm_reor_plot(:, 1), mag_norm_reor_plot(:, 2), mag_norm_reor_plot(:, 3), 'o');
	grid on
	box on
	axis equal
	xlabel('normalized mag_x','FontSize', dim_font)
	ylabel('normalized mag_y','FontSize', dim_font)
	zlabel('normalized mag_z','FontSize', dim_font)
	set(gca,'FontSize', dim_font) 
	if calib == 1 % calibrated magnetic field
		title('Normalized calibrated magnetic field, reoriented measures')
	else 
		title('Normalized not calibrated magnetic field, reoriented measures')
	end