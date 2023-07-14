% acc_plot

% date and time column not together
if datetime_column == 2 
	% do not use date time information, but number of samples. It is not a
	% suggested thing to do, better to create a .csv file with date and
	% time column together.
	
	end_sample = length(data_accx);
	
	% plot of sensor acc data, thus before reorientation
	figure('Name', ['figure ', num2str(id_plot),', acceleration axes not reoriented'], 'NumberTitle','off'); id_plot = id_plot + 1;
	clf
	subplot(2,1,1)
	plot(1:end_sample, acc_sens(:, 1))
	hold on
	plot(1:end_sample, acc_sens(:, 2))
	plot(1:end_sample, acc_sens(:, 3))
	grid on
	box on
	axis tight
	xlabel('x','FontSize', 20)
	ylabel('y','FontSize', 20)
	zlabel('z','FontSize', 20)
	legend('x acc', 'y acc', 'z acc','Location', 'southeast','FontSize', 20)
	set(gca,'FontSize', 20)
	title("Acceleration, axes not reoriented")
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
	
	% plot of acc data, thus after reorientation 
	%	x is along turtle carapace in the movement direction
	%	z is positive downwards
	%	y is so that to obtain a right hand reference frame
	figure('Name', ['figure ', num2str(id_plot),', acceleration axes reoriented'], 'NumberTitle','off'); id_plot = id_plot + 1;
	clf
	subplot(2,1,1)
	plot(1:end_sample, acc_reor(:, 1))
	hold on
	plot(1:end_sample, acc_reor(:, 2))
	plot(1:end_sample, acc_reor(:, 3))
	grid on
	box on
	axis tight
	xlabel('x','FontSize', 20)
	ylabel('y','FontSize', 20)
	zlabel('z','FontSize', 20)
	legend('x acc', 'y acc', 'z acc','Location', 'southeast','FontSize', 20)
	set(gca,'FontSize', 20)
	title("Acceleration, axes reoriented")
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
	
	% acceleration reoriented - single axes
	figure('Name', ['figure ', num2str(id_plot),', acceleration reoriented - single axes'], 'NumberTitle','off'); id_plot = id_plot + 1;
	clf	
	subplot(3,1,1)
		plot(1:end_sample, acc_reor(:, 1), 'DisplayName', 'acc_x');
		grid on
		box on
		axis tight
		xlabel('time','FontSize', dim_fontb)
		ylabel('acc','FontSize', dim_fontb)
		legend('Location', 'best','FontSize', dim_fontb, 'Location', 'best')
		set(gca,'FontSize', dim_fontb) 
		title('acc_x reoriented')
	subplot(3,1,2)
		plot(1:end_sample, acc_reor(:, 2), 'DisplayName', 'acc_y');
		grid on
		box on
		axis tight
		xlabel('time','FontSize', dim_fontb)
		ylabel('acc','FontSize', dim_fontb)
		legend('Location', 'best','FontSize', dim_fontb, 'Location', 'best')
		set(gca,'FontSize', dim_fontb) 
		title('acc_y reoriented')
	subplot(3,1,3)
		plot(1:end_sample, acc_reor(:, 3), 'DisplayName', 'acc_z');
		grid on
		box on
		axis tight
		xlabel('time','FontSize', dim_fontb)
		ylabel('acc','FontSize', dim_fontb)
		legend('Location', 'best','FontSize', dim_fontb, 'Location', 'best')
		set(gca,'FontSize', dim_fontb) 
		title('Acc_z reoriented') 	
	sgtitle('Acceleration reoriented - single axes','FontSize', dim_font)

% Date and Time column together, here it is used datetime information.
% Highly recommended.
elseif datetime_column == 1

	% plot of sensor acc data, thus before reorientation	
	figure('Name', ['figure ', num2str(id_plot),', acceleration axes not reoriented'], 'NumberTitle','off'); id_plot = id_plot + 1;
	clf
	subplot(2,1,1)
	plot(datetime_acc, acc_sens(:, 1))
	hold on
	plot(datetime_acc, acc_sens(:, 2))
	plot(datetime_acc, acc_sens(:, 3))
	grid on
	box on
	axis tight
	xlabel('x','FontSize', 20)
	ylabel('y','FontSize', 20)
	zlabel('z','FontSize', 20)
	legend('x acc', 'y acc', 'z acc','Location', 'southeast','FontSize', 20)
	set(gca,'FontSize', 20)
	title("Acceleration, axes not reoriented")
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
	
	% plot of acc data, thus after reorientation 
	%	x is along turtle carapace in the movement direction
	%	z is positive downwards
	%	y is so that to obtain a right hand reference frame
	figure('Name', ['figure ', num2str(id_plot),', acceleration axes reoriented'], 'NumberTitle','off'); id_plot = id_plot + 1;
	clf
	subplot(2,1,1)
	plot(datetime_acc, acc_reor(:, 1))
	hold on
	plot(datetime_acc, acc_reor(:, 2))
	plot(datetime_acc, acc_reor(:, 3))
	grid on
	box on
	axis tight
	xlabel('x','FontSize', 20)
	ylabel('y','FontSize', 20)
	zlabel('z','FontSize', 20)
	legend('x acc', 'y acc', 'z acc','Location', 'southeast','FontSize', 20)
	set(gca,'FontSize', 20)
	title("Acceleration, axes reoriented")
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
	
	% acceleration reoriented - single axes
	figure('Name', ['figure ', num2str(id_plot),', acceleration reoriented - single axes'], 'NumberTitle','off'); id_plot = id_plot + 1;
	clf	
	subplot(3,1,1)
		plot(datetime_acc, acc_reor(:, 1), 'DisplayName', 'acc_x');
		grid on
		box on
		axis tight
		xlabel('time','FontSize', dim_fontb)
		ylabel('acc','FontSize', dim_fontb)
		legend('Location', 'best','FontSize', dim_fontb, 'Location', 'best')
		set(gca,'FontSize', dim_fontb) 
		title('acc_x reoriented')
	subplot(3,1,2)
		plot(datetime_acc, acc_reor(:, 2), 'DisplayName', 'acc_y');
		grid on
		box on
		axis tight
		xlabel('time','FontSize', dim_fontb)
		ylabel('acc','FontSize', dim_fontb)
		legend('Location', 'best','FontSize', dim_fontb, 'Location', 'best')
		set(gca,'FontSize', dim_fontb) 
		title('acc_y reoriented')
	subplot(3,1,3)
		plot(datetime_acc, acc_reor(:, 3), 'DisplayName', 'acc_z');
		grid on
		box on
		axis tight
		xlabel('time','FontSize', dim_fontb)
		ylabel('acc','FontSize', dim_fontb)
		legend('Location', 'best','FontSize', dim_fontb, 'Location', 'best')
		set(gca,'FontSize', dim_fontb) 
		title('Acc_z reoriented') 	
	sgtitle('Acceleration reoriented - single axes','FontSize', dim_font)
end