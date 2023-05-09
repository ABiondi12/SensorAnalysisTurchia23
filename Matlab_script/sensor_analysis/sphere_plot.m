% sensor = 1	for agm.
% sensor = 2	for axy.
% type = 1		for acc
% type = 2		for mag

clear
clc
close all


sensor = 1;
type = 1;
id_plot = 1;

data = readtable('agm_accy_bis.csv');

if type == 2
	if sensor == 2
		data_magx = table2array(data(1:5:end, 7));
		data_magy = table2array(data(1:5:end, 8));
		data_magz = table2array(data(1:5:end, 9));
	elseif sensor == 1
		data_magx = table2array(data(:, 10));
		data_magy = table2array(data(:, 11));
		data_magz = table2array(data(:, 12));
	end

	end_sample = length(data_magx);

	mag_sens = [data_magx, data_magy, data_magz];
	[mag_postcalib, soft_iron, hard_iron, exp_mag_strength, sphere_fit, ellips_fit] = mag_calib_main(mag_sens);

	norma_mag_postcalib = norm(mag_postcalib);

	% plot: Uncalibrated vs Calibrated magnetic field fitting ellipsoids/sphere
	figure(id_plot); id_plot = id_plot + 1;
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
		legend('Uncalibrated best fitting', 'Calibrated best fitting','Location', 'southoutside','FontSize', 20)
		set(gca,'FontSize', 20)
		title("Uncalibrated vs Calibrated" + newline + "magnetic field fitting")
		hold off

	figure(id_plot); id_plot = id_plot + 1;
		clf
		plot3(ellips_fit(:, 1), ellips_fit(:, 2), ellips_fit(:, 3), 'LineStyle','none','Marker', 'o','MarkerSize',1,'MarkerEdgeColor','g', 'MarkerFaceColor','g')
		hold on
		plot3(data_magx, data_magy, data_magz, 'LineStyle','none','Marker', 'o','MarkerSize', 3)
		grid on
		box on
		axis equal
		xlabel('x uT','FontSize', 20)
		ylabel('y uT','FontSize', 20)
		zlabel('z uT','FontSize', 20)
		legend('Uncalibrated best fitting', 'Calibrated best fitting','Location', 'southoutside','FontSize', 20)
		set(gca,'FontSize', 20)
		title("Uncalibrated vs Calibrated" + newline + "magnetic field fitting")
		hold off

	figure(id_plot); id_plot = id_plot + 1;
		clf
		plot3(data_magx, data_magy, data_magz, 'LineStyle','none','Marker', 'o','MarkerSize', 3)
		grid on
		box on
		axis equal
		xlabel('x uT','FontSize', 20)
		ylabel('y uT','FontSize', 20)
		zlabel('z uT','FontSize', 20)
		set(gca,'FontSize', 20)
		title("axis")
		hold off
		
elseif type == 1
	data_accx = table2array(data(:, 4));
	data_accy = table2array(data(:, 5));
	data_accz = table2array(data(:, 6));
	end_sample = length(data_accx);
	
	% Plot section
	figure(id_plot); id_plot = id_plot + 1;
		clf
		plot(1:end_sample, data_accx, 'Marker', 'o','MarkerSize', 3)
		hold on
		plot(1:end_sample, data_accy, 'Marker', 'o','MarkerSize', 3)
		plot(1:end_sample, data_accz, 'Marker', 'o','MarkerSize', 3)
		grid on
		box on
		axis tight
		xlabel('x','FontSize', 20)
		ylabel('y','FontSize', 20)
		zlabel('z','FontSize', 20)
		legend('x acc', 'y acc', 'z acc','Location', 'southoutside','FontSize', 20)
		set(gca,'FontSize', 20)
		title("acc axes")
		hold off
end