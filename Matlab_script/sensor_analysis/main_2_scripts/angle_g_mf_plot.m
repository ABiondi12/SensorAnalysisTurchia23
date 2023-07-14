% angle_g_mf_plot

% the not normed and normed version must give the same value, you can 
% comment one of the two versions once verified that it happens

angle_c_NED_plt = angle_c_NED * ones(size(angle_c_plot, 1), size(angle_c_plot, 2));
angle_s_NED_plt = angle_s_NED * ones(size(angle_s_plot, 1), size(angle_s_plot, 2));
	%% acos
figure('Name', ['figure ', num2str(id_plot),', angle between g and magnetic field reoriented (acos)'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_mag, [angle_c_plot, angle_c_NED_plt])
	grid on
	box on
	axis tight
	ylim([20, 60])
	xlabel('time','FontSize', dim_font)
	ylabel('angle (deg)','FontSize', dim_font)
	legend('computed angle', 'expected angle','FontSize', dim_font, 'Location', 'best')
	set(gca,'FontSize', dim_font) 
	title('Angle between g and magnetic field reoriented (acos)')
	
	%% asin	
figure('Name', ['figure ', num2str(id_plot),', angle between g and magnetic field reoriented (asin)'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_mag, [angle_s_plot, angle_s_NED_plt])
	grid on
	box on
	axis tight
	ylim([20, 60])
	xlabel('time','FontSize', dim_font)
	ylabel('angle (deg)','FontSize', dim_font)
	legend('computed angle', 'expected angle','FontSize', dim_font, 'Location', 'best')
	set(gca,'FontSize', dim_font) 
	title('Angle between g and magnetic field reoriented (asin)')
	
	%% acos norm
figure('Name', ['figure ', num2str(id_plot),', angle between normalized g and magnetic field reoriented (acos)'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_mag, [angle_c_norm_plot, angle_c_NED_plt])
	grid on
	box on
	axis tight
	ylim([20, 60])
	xlabel('time','FontSize', dim_font)
	ylabel('angle (deg)','FontSize', dim_font)
	legend('computed angle', 'expected angle','FontSize', dim_font, 'Location', 'best')
	set(gca,'FontSize', dim_font) 
	title('Angle between normalized g and magnetic field reoriented (acos)')
	
	%% asin norm
figure('Name', ['figure ', num2str(id_plot),', angle between normalized g and magnetic field reoriented (asin)'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_mag, [angle_s_norm_plot, angle_s_NED_plt])
	grid on
	box on
	axis tight
	ylim([20, 60])
	xlabel('time','FontSize', dim_font)
	ylabel('angle (deg)','FontSize', dim_font)
	legend('computed angle', 'expected angle','FontSize', dim_font, 'Location', 'best')
	set(gca,'FontSize', dim_font) 
	title('Angle between normalized g and magnetic field reoriented (asin)')
