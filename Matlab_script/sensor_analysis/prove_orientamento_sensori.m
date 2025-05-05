clc
close all
clear
clearvars

addpath("C:\Users\UTENTE\Documents\GitHub\SensorAnalysisTurchia23\Matlab_script\sensor_analysis\csv_file")
addpath("C:\Users\UTENTE\Documents\GitHub\SensorAnalysisTurchia23\Matlab_script\sensor_analysis\csv_file\old_trial")
if exist('id_plot', 'var') == 0
	id_plot = 1;
end

%%%

data_prova_or = readtable("sensor_analysis\csv_file\old_trial\agm_gyro_x.csv");

acc_prova_or_x		= table2array(data_prova_or(1:end, 4));
acc_prova_or_y		= table2array(data_prova_or(1:end, 5));
acc_prova_or_z		= table2array(data_prova_or(1:end, 6));

gyro_prova_or_x		= table2array(data_prova_or(1:end, 7));
gyro_prova_or_y		= table2array(data_prova_or(1:end, 8));
gyro_prova_or_z		= table2array(data_prova_or(1:end, 9));

figure('Name', ['figure ', num2str(id_plot),', acceleration axes not reoriented'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(acc_prova_or_x)
hold on
plot(acc_prova_or_y)
plot(acc_prova_or_z)
grid on
box on
axis tight
xlabel('x','FontSize', 20)
ylabel('y','FontSize', 20)
zlabel('z','FontSize', 20)
legend('x acc', 'y acc', 'z acc','Location', 'southeast','FontSize', 20)
set(gca,'FontSize', 20)
title("Acceleration, test orientation")

figure('Name', ['figure ', num2str(id_plot),', gyroscope axes not reoriented'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot(gyro_prova_or_x)
hold on
plot(gyro_prova_or_y)
plot(gyro_prova_or_z)
grid on
box on
axis tight
xlabel('x','FontSize', 20)
ylabel('y','FontSize', 20)
zlabel('z','FontSize', 20)
legend('x gyro', 'y gyro', 'z gyro','Location', 'southeast','FontSize', 20)
set(gca,'FontSize', 20)
title("Gyroscope, test orientation")
