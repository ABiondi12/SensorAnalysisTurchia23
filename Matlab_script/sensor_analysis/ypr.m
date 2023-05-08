% sensor = 1 for agm.
% sensor = 2 for axy.
clear
clc
close all


sensor = 1;

data = readtable('agm_gyro_z.csv');

if sensor == 1
	data_gyrox = table2array(data(1:end, 7));
	data_gyroy = table2array(data(1:end, 8));
	data_gyroz = table2array(data(1:end, 9));
end

end_sample = length(data_gyrox);

gyro_sens = [data_gyrox, data_gyroy, data_gyroz];

%% plot section

id_plot = 1;

	%% plot: Uncalibrated vs Calibrated magnetic field fitting ellipsoids/sphere
	
	figure(id_plot); id_plot = id_plot + 1;
	clf
	plot3(data_gyrox, data_gyroy, data_gyroz, 'LineStyle','none','Marker', 'o','MarkerSize', 3)
	grid on
	box on
	axis equal
	xlabel('x','FontSize', 20)
	ylabel('y','FontSize', 20)
	zlabel('z','FontSize', 20)
	legend('x gyro', 'y gyro', 'z gyro','Location', 'southoutside','FontSize', 20)
	set(gca,'FontSize', 20)
	title("gyro axes")
	hold off
	
	figure(id_plot); id_plot = id_plot + 1;
	clf
	plot(1:end_sample, data_gyrox, 'Marker', 'o','MarkerSize', 3)
	hold on
	plot(1:end_sample, data_gyroy, 'Marker', 'o','MarkerSize', 3)
	plot(1:end_sample, data_gyroz, 'Marker', 'o','MarkerSize', 3)
	grid on
	box on
	axis equal
	xlabel('x','FontSize', 20)
	ylabel('y','FontSize', 20)
	zlabel('z','FontSize', 20)
	legend('x gyro', 'y gyro', 'z gyro','Location', 'southoutside','FontSize', 20)
	set(gca,'FontSize', 20)
	title("gyro axes")
	hold off
	