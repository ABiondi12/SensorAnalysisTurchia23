% norm_acc_mag_plot

%% norm of acceleration, rotated measures
figure('Name', ['figure ', num2str(id_plot),', acceleration norm / g reoriented'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
	plot(datetime_acc, norm_acc_reor);
	grid on
	box on
	axis tight
	xlabel('time','FontSize', dim_font)
	ylabel('acc_{norm}/g','FontSize', dim_font)
	set(gca,'FontSize', dim_font) 
	title('Acceleration norm / g reoriented')
		
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

%% plot of static acceleration norm, rotated measures
figure('Name', ['figure ', num2str(id_plot),', static acceleration norm / g reoriented'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_acc(5:end-5), norm_acc_stat(5:end-5));
	grid on
	box on
	axis tight
	xlabel('time','FontSize', dim_font)
	ylabel('acc_{norm}/g','FontSize', dim_font)
	set(gca,'FontSize', dim_font) 
	title('Static acceleration norm / g reoriented')
			
%% plot of norm of magnetic field, rotated measures
figure('Name', ['figure ', num2str(id_plot),', magnetic field norm reoriented'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
	F_micro_plot = ones(size(norm_mag_reor_plot, 1), size(norm_mag_reor_plot, 2))*F_micro;
	plot(datetime_mag, [norm_mag_reor_plot, F_micro_plot]);
	grid on
	box on
	axis tight
	xlabel('time','FontSize', dim_font)
	ylabel('mf_{norm} (\mu T)','FontSize', dim_font)
	set(gca,'FontSize', dim_font) 
	title('Magnetic field norm reoriented')

%% 3D plot of normalized magnetic field, rotated measures
figure('Name', ['figure ', num2str(id_plot),', 3D plot of normalized magnetic field reoriented'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot3(mag_norm_reor_plot(:, 1), mag_norm_reor_plot(:, 2), mag_norm_reor_plot(:, 3), 'o');
	grid on
	box on
	axis equal
	xlabel('normalized mag_x','FontSize', dim_font)
	ylabel('normalized mag_y','FontSize', dim_font)
	zlabel('normalized mag_z','FontSize', dim_font)
	set(gca,'FontSize', dim_font) 
	title('Normalized magnetic field reoriented')	

%% 3D plot of magnetic field, rotated measures
figure('Name', ['figure ', num2str(id_plot),', 3D plot of magnetic field reoriented'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot3(mag_reor_plot(:, 1), mag_reor_plot(:, 2), mag_reor_plot(:, 3), 'o');
	grid on
	box on
	axis equal
	xlabel('mag_x (\mu T)','FontSize', dim_font)
	ylabel('mag_y (\mu T)','FontSize', dim_font)
	zlabel('mag_z (\mu T)','FontSize', dim_font)
	set(gca,'FontSize', dim_font) 
	title('Magnetic field reoriented')	

%% magnetic field reoriented  - single axes
if calib == 1
	figure('Name', ['figure ', num2str(id_plot),', magnetic field reoriented and calibrated'], 'NumberTitle','off'); id_plot = id_plot + 1;
	clf
		subplot(3,1,1)
			plot(datetime_mag, mag_reor_plot(:, 1), 'DisplayName', 'mag_x');
			grid on
			axis tight
			xlabel('time','FontSize', dim_fontb)
			ylabel('mag (\mu T)','FontSize', dim_fontb)
			legend('Location', 'best','FontSize', dim_fontb, 'Location', 'best')
			set(gca,'FontSize', dim_fontb) 
			title('Mag_x of magnetic field reoriented')
		subplot(3,1,2)
			plot(datetime_mag, mag_reor_plot(:, 2), 'DisplayName', 'mag_y');
			grid on
			axis tight
			xlabel('time','FontSize', dim_fontb)
			ylabel('mag','FontSize', dim_fontb)
			legend('Location', 'best','FontSize', dim_fontb, 'Location', 'best')
			set(gca,'FontSize', dim_fontb) 
			title('Mag_y of magnetic field reoriented')
		subplot(3,1,3)
			plot(datetime_mag, mag_reor_plot(:, 3), 'DisplayName', 'mag_z');
			grid on
			axis tight
			xlabel('time','FontSize', dim_fontb)
			ylabel('mag','FontSize', dim_fontb)
			legend('Location', 'best','FontSize', dim_fontb, 'Location', 'best')
			set(gca,'FontSize', dim_fontb) 
			title('Mag_z of magnetic field reoriented')	
		sgtitle('Magnetic field reoriented and calibrated', 'FontSize', dim_font)
end