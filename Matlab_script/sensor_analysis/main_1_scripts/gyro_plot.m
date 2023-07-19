% gyro_plot
% This script is demanded to plot gyroscope data both in local reference
% frame and in reoriented reference frame. Reoriented reference frame
% consists in:
% 	- x longitudinal along turtle carapace, positive in motion direction
%	- z vertical w.r.t. turtle carapace, positive downwards
%	- y trasversal w.r.t. turtle carapace, so that to obtain a right hand 
%		reference frame
%
% There are three plot produced here:
%	1. plot of sensor gyroscope data, before reorientation
%	2. plot of gyroscope data, after reorientation
%	3. plot of gyroscope data, after reorientation - single axes plot
%
% Moreover, if date and time information are available (it happens when
% they are in the same column into the .csv file), datetime is shown along
% x-axis of the plot, otherwise it will be present the samples number.

%% plot

%% date and time column not together, samples number information
if datetime_column == 2
	% do not use date time information, but number of samples. It is not a
	% recommended thing to do, better to create a .csv file with date and
	% time column together.
	
	end_sample = length(data_gyrox);
	
	% plot of sensor gyroscope data, before reorientation
	figure('Name', ['figure ', num2str(id_plot),', gyroscope axes not reoriented'], 'NumberTitle','off'); id_plot = id_plot + 1;
	clf
	subplot(2,1,1)
	plot(1:end_sample, gyro_sens(:, 1))
	hold on
	plot(1:end_sample, gyro_sens(:, 2))
	plot(1:end_sample, gyro_sens(:, 3))
	grid on
	box on
	axis tight
	xlabel('x','FontSize', 20)
	ylabel('y','FontSize', 20)
	zlabel('z','FontSize', 20)
	legend('x gyro', 'y gyro', 'z gyro','Location', 'southeast','FontSize', 20)
	set(gca,'FontSize', 20)
	title("Gyroscope, axes not reoriented")
	hold off
	subplot(2,1,2)
	plot(1:depth_step:end_sample, depth)
	grid on
	box on
	axis tight
	xlabel('x','FontSize', 20)
	ylabel('y','FontSize', 20)
	zlabel('z','FontSize', 20)
	legend('depth','Location', 'southeast','FontSize', 20)
	set(gca,'FontSize', 20)
	title("Depth profile")
	
	% plot of sensor gyroscope data, after reorientation:
	%	x is along turtle carapace in the movement direction
	%	z is positive downwards
	%	y is so that to obtain a right hand reference frame	
	figure('Name', ['figure ', num2str(id_plot),', gyroscope axes reoriented'], 'NumberTitle','off'); id_plot = id_plot + 1;
	clf
	subplot(2,1,1)
	plot(1:end_sample, gyro_reor(:, 1))
	hold on
	plot(1:end_sample, gyro_reor(:, 2))
	plot(1:end_sample, gyro_reor(:, 3))
	grid on
	box on
	axis tight
	xlabel('x','FontSize', 20)
	ylabel('y','FontSize', 20)
	zlabel('z','FontSize', 20)
	legend('x gyro', 'y gyro', 'z gyro','Location', 'southeast','FontSize', 20)
	set(gca,'FontSize', 20)
	title("Gyroscope, axes reoriented")
	hold off
	subplot(2,1,2)
	plot(1:depth_step:end_sample, depth)
	grid on
	box on
	axis tight
	xlabel('x','FontSize', 20)
	ylabel('y','FontSize', 20)
	zlabel('z','FontSize', 20)
	legend('depth','Location', 'southeast','FontSize', 20)
	set(gca,'FontSize', 20)
	title("Depth profile")
	
	% gyroscope reoriented - single axes plot
	figure('Name', ['figure ', num2str(id_plot),', gyroscope data reoriented - single axes'], 'NumberTitle','off'); id_plot = id_plot + 1;
	clf	
	subplot(3,1,1)
		plot(1:end_sample, gyro_reor(:, 1), 'DisplayName', 'gyro_x');
		grid on
		box on
		axis tight
		xlabel('time','FontSize', dim_fontb)
		ylabel('gyro_x','FontSize', dim_fontb)
		legend('Location', 'best','FontSize', dim_fontb, 'Location', 'best')
		set(gca,'FontSize', dim_fontb) 
		title('gyro_x reoriented')
	subplot(3,1,2)
		plot(1:end_sample, gyro_reor(:, 2), 'DisplayName', 'gyro_y');
		grid on
		box on
		axis tight
		xlabel('time','FontSize', dim_fontb)
		ylabel('gyro_y','FontSize', dim_fontb)
		legend('Location', 'best','FontSize', dim_fontb, 'Location', 'best')
		set(gca,'FontSize', dim_fontb) 
		title('gyro_y reoriented')
	subplot(3,1,3)
		plot(1:end_sample, gyro_reor(:, 3), 'DisplayName', 'gyro_z');
		grid on
		box on
		axis tight
		xlabel('time','FontSize', dim_fontb)
		ylabel('gyro_z','FontSize', dim_fontb)
		legend('Location', 'best','FontSize', dim_fontb, 'Location', 'best')
		set(gca,'FontSize', dim_fontb) 
		title('Gyro_z reoriented') 	
	sgtitle('Gyroscope data reoriented - single axes','FontSize', dim_font)

	
%% datetime information
% Date and Time column together, here it is used datetime information.
% Highly recommended.
elseif datetime_column == 1
	
	% plot of sensor gyroscope data, before reorientation
	figure('Name', ['figure ', num2str(id_plot),', gyroscope axes not reoriented'], 'NumberTitle','off'); id_plot = id_plot + 1;
	clf
	subplot(2,1,1)
	plot(datetime_gyro, gyro_sens(:, 1))
	hold on
	plot(datetime_gyro, gyro_sens(:, 2))
	plot(datetime_gyro, gyro_sens(:, 3))
	grid on
	box on
	axis tight
	xlabel('x','FontSize', 20)
	ylabel('y','FontSize', 20)
	zlabel('z','FontSize', 20)
	legend('x gyro', 'y gyro', 'z gyro','Location', 'southeast','FontSize', 20)
	set(gca,'FontSize', 20)
	title("Gyroscope, axes not reoriented")
	hold off
	subplot(2,1,2)
	plot(datetime_depth, depth)
	grid on
	box on
	axis tight
	xlabel('x','FontSize', 20)
	ylabel('y','FontSize', 20)
	zlabel('z','FontSize', 20)
	legend('depth','Location', 'southeast','FontSize', 20)
	set(gca,'FontSize', 20)
	title("Depth profile")
	
	% plot of sensor gyroscope data, before reorientation:
	%	x is along turtle carapace in the movement direction
	%	z is positive downwards
	%	y is so that to obtain a right hand reference frame

	figure('Name', ['figure ', num2str(id_plot),', gyroscope axes reoriented'], 'NumberTitle','off'); id_plot = id_plot + 1;
	clf
	subplot(2,1,1)
	plot(datetime_gyro, gyro_reor(:, 1))
	hold on
	plot(datetime_gyro, gyro_reor(:, 2))
	plot(datetime_gyro, gyro_reor(:, 3))
	grid on
	box on
	axis tight
	xlabel('x','FontSize', 20)
	ylabel('y','FontSize', 20)
	zlabel('z','FontSize', 20)
	legend('x gyro', 'y gyro', 'z gyro','Location', 'southeast','FontSize', 20)
	set(gca,'FontSize', 20)
	title("Gyroscope, axes reoriented")
	hold off
	subplot(2,1,2)
	plot(datetime_depth, depth)
	grid on
	box on
	axis tight
	xlabel('x','FontSize', 20)
	ylabel('y','FontSize', 20)
	zlabel('z','FontSize', 20)
	legend('depth','Location', 'southeast','FontSize', 20)
	set(gca,'FontSize', 20)
	title("Depth profile")

	% gyroscope reoriented - single axes plot
	figure('Name', ['figure ', num2str(id_plot),', gyroscope data reoriented - single axes'], 'NumberTitle','off'); id_plot = id_plot + 1;
	clf	
	subplot(3,1,1)
		plot(datetime_gyro, gyro_reor(:, 1), 'DisplayName', 'gyro_x');
		grid on
		box on
		axis tight
		xlabel('time','FontSize', dim_fontb)
		ylabel('gyro_x','FontSize', dim_fontb)
		legend('Location', 'best','FontSize', dim_fontb, 'Location', 'best')
		set(gca,'FontSize', dim_fontb) 
		title('gyro_x reoriented')
	subplot(3,1,2)
		plot(datetime_gyro, gyro_reor(:, 2), 'DisplayName', 'gyro_y');
		grid on
		box on
		axis tight
		xlabel('time','FontSize', dim_fontb)
		ylabel('gyro_y','FontSize', dim_fontb)
		legend('Location', 'best','FontSize', dim_fontb, 'Location', 'best')
		set(gca,'FontSize', dim_fontb) 
		title('gyro_y reoriented')
	subplot(3,1,3)
		plot(datetime_gyro, gyro_reor(:, 3), 'DisplayName', 'gyro_z');
		grid on
		box on
		axis tight
		xlabel('time','FontSize', dim_fontb)
		ylabel('gyro_z','FontSize', dim_fontb)
		legend('Location', 'best','FontSize', dim_fontb, 'Location', 'best')
		set(gca,'FontSize', dim_fontb) 
		title('Gyro_z reoriented') 	
	sgtitle('Gyroscope data reoriented - single axes','FontSize', dim_font)

end