% ypr_plot

%% YPR reoriented	w.r.t. magnetic	North
figure('Name', ['figure ', num2str(id_plot),', YPR reoriented w.r.t. magnetic North'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_mag, [roll_plot, pitch_plot, yaw_m_plot])
	grid on
	box on
	axis tight
	xlabel('time','FontSize', dim_font)
	ylabel('angle (deg)','FontSize', dim_font)
	legend('Roll', 'Pitch', 'Yaw','FontSize', dim_font, 'Location', 'best')
	set(gca,'FontSize', dim_font) 
	title('YPR reoriented w.r.t. magnetic North')
	
%% YPR norm reoriented	w.r.t. magnetic		North
figure('Name', ['figure ', num2str(id_plot),', YPR norm reoriented w.r.t. magnetic North'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_mag, [roll_norm_plot, pitch_norm_plot, yaw_m_norm_plot])
	grid on
	box on
	axis tight
	xlabel('time','FontSize', dim_font)
	ylabel('angle (deg)','FontSize', dim_font)
	legend('Roll', 'Pitch', 'Yaw','FontSize', dim_font, 'Location', 'best')
	set(gca,'FontSize', dim_font) 
	title('YPR norm reoriented w.r.t. magnetic North')

%% YPR reoriented		w.r.t. geographic	North
figure('Name', ['figure ', num2str(id_plot),', YPR reoriented w.r.t. geographic North'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_mag, [roll_plot, pitch_plot, yaw_g_plot])
	grid on
	box on
	axis tight
	xlabel('time','FontSize', dim_font)
	ylabel('angle (deg)','FontSize', dim_font)
	legend('Roll', 'Pitch', 'Yaw','FontSize', dim_font, 'Location', 'best')
	set(gca,'FontSize', dim_font) 
	title('YPR reoriented w.r.t. geographic North')
	
%% YPR norm reoriented	w.r.t. geographic	North after calibration
figure('Name', ['figure ', num2str(id_plot),', YPR norm reoriented w.r.t. geographic North '], 'NumberTitle','off'); id_plot = id_plot + 1;
	clf
plot(datetime_mag, [roll_norm_plot, pitch_norm_plot, yaw_g_norm_plot])
	grid on
	box on
	axis tight
	xlabel('time','FontSize', dim_font)
	ylabel('angle (deg)','FontSize', dim_font)
	legend('Roll', 'Pitch', 'Yaw','FontSize', dim_font, 'Location', 'best')
	set(gca,'FontSize', dim_font) 
	title('YPR norm reoriented w.r.t. geographic North')
	
	%% Yaw reoriented		w.r.t. geographic	North
figure('Name', ['figure ', num2str(id_plot),', Yaw angle w.r.t. geographic North'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_mag, yaw_g_plot)
	grid on
	box on
	axis tight
	xlabel('time','FontSize', dim_font)
	ylabel('angle (deg)','FontSize', dim_font)
	legend('Yaw','FontSize', dim_font, 'Location', 'best')
	set(gca,'FontSize', dim_font) 
	title('Yaw angle w.r.t. geographic North')
