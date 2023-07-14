% gyro_plot

% date and time column not together
if datetime_column == 2
	% do not use date time information, but number of samples. It is not a
	% suggested thing to do, better to create a .csv file with date and
	% time column together.
	
	end_sample = length(data_gyrox);
	
	% plot of sensor gyro data, thus before reorientation
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
	
	% plot of gyro data, thus after reorientation  - single axes
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
	
% Date and Time column together, here it is used datetime information.
% Highly recommended.
else
	
	% plot of sensor gyro data, thus before reorientation
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

	% gyroscope reoriented - single axes
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
end