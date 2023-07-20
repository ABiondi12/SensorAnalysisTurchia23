% mag_calibration_plot
% This script will show magnetic field (mf) dataset before and after 
% calibration correction (data are those relative to the main turtle 
% movement, also if the calibration session is in a different file):
%
% 1. plot:		Uncalibrated vs Calibrated magnetic field data best fitting 
%				(ellips - sphere)
%					* ellips - Uncalibrated mf
%					* sphere - Calibrated mf
%
% 2. plot:		uncalibrated mf data and best fitting ellips
%
% 3. plot:		calibrated mf data and best fitting sphere
%
% 4. 3D plot:	calibrated magnetic field, rotated measures
%
% 5. plot:		calibrated magnetic field reoriented  - single axes

%% plot
% plot: Uncalibrated vs Calibrated mf data best fitting (ellips - sphere)
%	ellips - Uncalibrated mf
%	sphere - Calibrated mf
figure('Name', ['figure ', num2str(id_plot),', uncalibrated vs calibrated magnetic field fitting'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot3(ellips_fit(:, 1), ellips_fit(:, 2), ellips_fit(:, 3), 'LineStyle','none','Marker', 'o','MarkerSize',1,'MarkerEdgeColor','g', 'MarkerFaceColor','g')
hold on
plot3(sphere_fit(:, 1), sphere_fit(:, 2), sphere_fit(:, 3), 'LineStyle','none','Marker', 'o','MarkerSize',1, 'MarkerEdgeColor','r', 'MarkerFaceColor','r')
grid on
box on
axis equal
xlabel('x uT','FontSize', 20)
ylabel('y uT','FontSize', 20)
zlabel('z uT','FontSize', 20)
legend('Uncalibrated best fitting', 'Calibrated best fitting','Location', 'southeast','FontSize', 20)
set(gca,'FontSize', 20)
title("Uncalibrated vs Calibrated" + newline + "magnetic field fitting")
hold off

% plot: Uncalibrated mf data and best fitting ellips
figure('Name', ['figure ', num2str(id_plot),', uncalibrated magnetic field fitting'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot3(ellips_fit(:, 1), ellips_fit(:, 2), ellips_fit(:, 3), 'LineStyle','none','Marker', 'o','MarkerSize',1,'MarkerEdgeColor','g', 'MarkerFaceColor','g')
hold on
plot3(mag_reor(:, 1), mag_reor(:, 2), mag_reor(:, 3), 'LineStyle','none','Marker', 'o','MarkerSize', 3)
grid on
box on
axis equal
xlabel('x uT','FontSize', 20)
ylabel('y uT','FontSize', 20)
zlabel('z uT','FontSize', 20)
legend('Uncalibrated best fitting', 'magnetic field','Location', 'southeast','FontSize', 20)
set(gca,'FontSize', 20)
title("Uncalibrated magnetic field fitting")
hold off

% plot: Calibrated mf data and best fitting sphere
figure('Name', ['figure ', num2str(id_plot),', calibrated magnetic field fitting'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot3(sphere_fit(:, 1), sphere_fit(:, 2), sphere_fit(:, 3), 'LineStyle','none','Marker', 'o','MarkerSize',1,'MarkerEdgeColor','g', 'MarkerFaceColor','g')
hold on
plot3(mag_postcalib(:, 1), mag_postcalib(:, 2), mag_postcalib(:, 3), 'LineStyle','none','Marker', 'o','MarkerSize', 3)
grid on
box on
axis equal
xlabel('x uT','FontSize', 20)
ylabel('y uT','FontSize', 20)
zlabel('z uT','FontSize', 20)
legend('Calibrated best fitting', 'Calibrated magnetic field','Location', 'southeast','FontSize', 20)
set(gca,'FontSize', 20)
title("Calibrated magnetic field fitting")
hold off

%% magnetic field calibrated
% 3D plot of magnetic field, rotated measures
figure('Name', ['figure ', num2str(id_plot),', 3D plot of calibrated magnetic field, reoriented measures'], 'NumberTitle','off'); id_plot = id_plot + 1;
	clf
	plot3(mag_postcalib(:, 1), mag_postcalib(:, 2), mag_postcalib(:, 3), 'o');
	grid on
	box on
	axis equal
	xlabel('mag_x (\mu T)','FontSize', dim_font)
	ylabel('mag_y (\mu T)','FontSize', dim_font)
	zlabel('mag_z (\mu T)','FontSize', dim_font)
	set(gca,'FontSize', dim_font) 
	title('Calibrated magnetic field, reoriented measures')	

% magnetic field reoriented  - single axes
figure('Name', ['figure ', num2str(id_plot),', magnetic field reoriented and calibrated'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
	subplot(3,1,1)
		plot(datetime_mag, mag_postcalib(:, 1), 'DisplayName', 'mag_x');
		grid on
		axis tight
		xlabel('time','FontSize', dim_fontb)
		ylabel('mag (\mu T)','FontSize', dim_fontb)
		legend('Location', 'best','FontSize', dim_fontb, 'Location', 'best')
		set(gca,'FontSize', dim_fontb) 
		title('Mag_x of magnetic field reoriented')
	subplot(3,1,2)
		plot(datetime_mag, mag_postcalib(:, 2), 'DisplayName', 'mag_y');
		grid on
		axis tight
		xlabel('time','FontSize', dim_fontb)
		ylabel('mag','FontSize', dim_fontb)
		legend('Location', 'best','FontSize', dim_fontb, 'Location', 'best')
		set(gca,'FontSize', dim_fontb) 
		title('Mag_y of magnetic field reoriented')
	subplot(3,1,3)
		plot(datetime_mag, mag_postcalib(:, 3), 'DisplayName', 'mag_z');
		grid on
		axis tight
		xlabel('time','FontSize', dim_fontb)
		ylabel('mag','FontSize', dim_fontb)
		legend('Location', 'best','FontSize', dim_fontb, 'Location', 'best')
		set(gca,'FontSize', dim_fontb) 
		title('Mag_z of magnetic field reoriented')	
	sgtitle('Magnetic field reoriented and calibrated', 'FontSize', dim_font)
