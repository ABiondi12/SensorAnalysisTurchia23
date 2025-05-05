% ypr_plot
% This script is demanded to plot yaw, pitch and roll angles, computed in
% main_2_ypr script, over time. In particular, the following plots are
% produced:
%
%	1. Yaw, Pitch and Roll computed with reoriented	vectors (gravity vector
%		obtained from acceleration data and magnetic field vector after 
%		calibration) w.r.t. magnetic North.
%	2. Yaw, Pitch and Roll computed with reoriented	versors (gravity versor
%		obtained from acceleration data and magnetic field versor after 
%		calibration) w.r.t. magnetic North.
%	3. Yaw, Pitch and Roll computed with reoriented	vectors (gravity vector
%		obtained from acceleration data and magnetic field vector after 
%		calibration) w.r.t. geographic North.
%	4. Yaw, Pitch and Roll computed with reoriented	versors (gravity versor
%		obtained from acceleration data and magnetic field versor after 
%		calibration) w.r.t. geographic North.
%	5. Yaw angle computed with reoriented vectors (gravity vector
%		obtained from acceleration data and magnetic field vector after 
%		calibration) w.r.t. magnetic North.
%	5. Yaw angle computed with reoriented vectors (gravity vector
%		obtained from acceleration data and magnetic field vector after 
%		calibration) w.r.t. geographic North.
%
% NOTE: versor is the normalized version of a vector

%% YPR reoriented w.r.t. magnetic North after calibration
figure('Name', ['figure ', num2str(id_plot),', YPR reoriented w.r.t. magnetic North'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_mag, [roll_plot, pitch_plot, yaw_m_plot], '*', 'MarkerSize', 2)
	grid on
	box on
	axis tight
	xlabel('time','FontSize', dim_font)
	ylabel('angle (deg)','FontSize', dim_font)
	legend('Roll', 'Pitch', 'Yaw','FontSize', dim_font, 'Location', 'best')
	set(gca,'FontSize', dim_font) 
	title('YPR reoriented w.r.t. magnetic North')
	
%% YPR norm reoriented w.r.t. magnetic North after calibration
figure('Name', ['figure ', num2str(id_plot),', YPR norm reoriented w.r.t. magnetic North'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_mag, [roll_norm_plot, pitch_norm_plot, yaw_m_norm_plot], '*', 'MarkerSize', 2)
	grid on
	box on
	axis tight
	xlabel('time','FontSize', dim_font)
	ylabel('angle (deg)','FontSize', dim_font)
	legend('Roll', 'Pitch', 'Yaw','FontSize', dim_font, 'Location', 'best')
	set(gca,'FontSize', dim_font) 
	title('YPR norm reoriented w.r.t. magnetic North')

%% YPR reoriented w.r.t. geographic	North after calibration
figure('Name', ['figure ', num2str(id_plot),', YPR reoriented w.r.t. geographic North'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_mag, [roll_plot, pitch_plot, yaw_g_plot], '*', 'MarkerSize', 2)
	grid on
	box on
	axis tight
	xlabel('time','FontSize', dim_font)
	ylabel('angle (deg)','FontSize', dim_font)
	legend('Roll', 'Pitch', 'Yaw','FontSize', dim_font, 'Location', 'best')
	set(gca,'FontSize', dim_font) 
	title('YPR reoriented w.r.t. geographic North')
	
%% YPR norm reoriented w.r.t. geographic North after calibration
figure('Name', ['figure ', num2str(id_plot),', YPR norm reoriented w.r.t. geographic North '], 'NumberTitle','off'); id_plot = id_plot + 1;
	clf
plot(datetime_mag, [roll_norm_plot, pitch_norm_plot, yaw_g_norm_plot], '*', 'MarkerSize', 2)
	grid on
	box on
	axis tight
	xlabel('time','FontSize', dim_font)
	ylabel('angle (deg)','FontSize', dim_font)
	legend('Roll', 'Pitch', 'Yaw','FontSize', dim_font, 'Location', 'best')
	set(gca,'FontSize', dim_font) 
	title('YPR norm reoriented w.r.t. geographic North')
	
	%% Yaw reoriented w.r.t. geographic North
figure('Name', ['figure ', num2str(id_plot),', Yaw angle w.r.t. geographic North'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_mag, yaw_g_plot, '*', 'MarkerSize', 2)
	grid on
	box on
	axis tight
	xlabel('time','FontSize', dim_font)
	ylabel('angle (deg)','FontSize', dim_font)
	legend('Yaw','FontSize', dim_font, 'Location', 'best')
	set(gca,'FontSize', dim_font) 
	title('Yaw angle w.r.t. geographic North')
	
	%% Yaw reoriented w.r.t. magnetic North
figure('Name', ['figure ', num2str(id_plot),', Yaw angle w.r.t. magnetic North'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_mag, yaw_m_plot, '*', 'MarkerSize', 2)
	grid on
	box on
	axis tight
	xlabel('time','FontSize', dim_font)
	ylabel('angle (deg)','FontSize', dim_font)
	legend('Yaw','FontSize', dim_font, 'Location', 'best')
	set(gca,'FontSize', dim_font) 
	title('Yaw angle w.r.t. magnetic North')

	%% Yaw reoriented w.r.t. magnetic North

yaw_m_plot_wrap = rad2deg(wrapTo2Pi(deg2rad(yaw_m_plot)));

figure('Name', ['figure ', num2str(id_plot),', Yaw angle w.r.t. magnetic North'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_mag, yaw_m_plot_wrap, '*', 'MarkerSize', 2)
	grid on
	box on
	axis tight
	xlabel('time','FontSize', dim_font)
	ylabel('angle (deg)','FontSize', dim_font)
	legend('Yaw','FontSize', dim_font, 'Location', 'best')
	set(gca,'FontSize', dim_font) 
	title('Yaw angle w.r.t. magnetic North')


	%% Yaw reoriented w.r.t. geographic North

yaw_g_plot_wrap = rad2deg(wrapTo2Pi(deg2rad(yaw_g_plot)));

figure('Name', ['figure ', num2str(id_plot),', Yaw angle w.r.t. geographic North'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(datetime_mag, yaw_g_plot_wrap, '*', 'MarkerSize', 2)
	grid on
	box on
	axis tight
	xlabel('time','FontSize', dim_font)
	ylabel('angle (deg)','FontSize', dim_font)
	legend('Yaw','FontSize', dim_font, 'Location', 'best')
	set(gca,'FontSize', dim_font) 
	title('Yaw angle w.r.t. geographic North')




    