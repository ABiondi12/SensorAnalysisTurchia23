% uncalibrated magnetic field plot

% plot: Uncalibrated magnetic field, not reoriented - 3D
figure('Name', ['figure ', num2str(id_plot),', Magnetic field 3D representation - not reoriented'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot3(mag_sens(:, 1), mag_sens(:, 2), mag_sens(:, 3), 'LineStyle','none','Marker', 'o','MarkerSize', 3)
grid on
box on
axis equal
xlabel('x uT','FontSize', 20)
ylabel('y uT','FontSize', 20)
zlabel('z uT','FontSize', 20)
set(gca,'FontSize', 20)
title("Magnetic field 3D, not reoriented axes")
hold off

% plot: Uncalibrated magnetic field, reoriented - 3D
figure('Name', ['figure ', num2str(id_plot),', Magnetic field 3D representation - reoriented'], 'NumberTitle','off'); id_plot = id_plot + 1;
clf
plot3(mag_reor(:, 1), mag_reor(:, 2), mag_reor(:, 3), 'LineStyle','none','Marker', 'o','MarkerSize', 3)
grid on
box on
axis equal
xlabel('x uT','FontSize', 20)
ylabel('y uT','FontSize', 20)
zlabel('z uT','FontSize', 20)
set(gca,'FontSize', 20)
title("Magnetic field 3D, reoriented axes")
hold off

if datetime_column == 1
	% suggested, date and time column together. Used datetime info
	
	% plot: Uncalibrated magnetic field, not reoriented
	figure('Name', ['figure ', num2str(id_plot),', Magnetic field representation - not reoriented'], 'NumberTitle','off'); id_plot = id_plot + 1;
	clf
	plot(datetime_mag, mag_sens(:, 1))
	hold on
	plot(datetime_mag, mag_sens(:, 2))
	plot(datetime_mag, mag_sens(:, 3))
	grid on
	box on
	axis tight
	xlabel('x','FontSize', 20)
	ylabel('y','FontSize', 20)
	zlabel('z','FontSize', 20)
	legend('x mag', 'y mag', 'z mag','Location', 'southoutside','FontSize', 20)
	set(gca,'FontSize', 20)
	title("Magnetic field, not reoriented axes")
	hold off
	
	% plot: Uncalibrated magnetic field, reoriented
	figure('Name', ['figure ', num2str(id_plot),', Magnetic field representation - reoriented'], 'NumberTitle','off'); id_plot = id_plot + 1;
	clf
	plot(datetime_mag, mag_reor(:, 1))
	hold on
	plot(datetime_mag, mag_reor(:, 2))
	plot(datetime_mag, mag_reor(:, 3))
	grid on
	box on
	axis tight
	xlabel('x','FontSize', 20)
	ylabel('y','FontSize', 20)
	zlabel('z','FontSize', 20)
	legend('x mag', 'y mag', 'z mag','Location', 'southoutside','FontSize', 20)
	set(gca,'FontSize', 20)
	title("Magnetic field, reoriented axes")
	hold off
	
	% plot: Uncalibrated magnetic field, reoriented (single axis)
	figure('Name', ['figure ', num2str(id_plot),', magnetic field reoriented - single axes'], 'NumberTitle','off'); id_plot = id_plot + 1;
	clf
	subplot(3,1,1)
		plot(datetime_mag, mag_reor(:, 1), 'DisplayName', 'mag_x');
		grid on
		axis tight
		xlabel('time','FontSize', dim_fontb)
		ylabel('mag (\mu T)','FontSize', dim_fontb)
		legend('Location', 'best','FontSize', dim_fontb, 'Location', 'best')
		set(gca,'FontSize', dim_fontb) 
		title('Mag_x of magnetic field reoriented')
	subplot(3,1,2)
		plot(datetime_mag, mag_reor(:, 2), 'DisplayName', 'mag_y');
		grid on
		axis tight
		xlabel('time','FontSize', dim_fontb)
		ylabel('mag','FontSize', dim_fontb)
		legend('Location', 'best','FontSize', dim_fontb, 'Location', 'best')
		set(gca,'FontSize', dim_fontb) 
		title('Mag_y of magnetic field reoriented')
	subplot(3,1,3)
		plot(datetime_mag, mag_reor(:, 3), 'DisplayName', 'mag_z');
		grid on
		axis tight
		xlabel('time','FontSize', dim_fontb)
		ylabel('mag','FontSize', dim_fontb)
		legend('Location', 'best','FontSize', dim_fontb, 'Location', 'best')
		set(gca,'FontSize', dim_fontb) 
		title('Mag_z of magnetic field reoriented')	
	sgtitle('Magnetic field reoriented - single axes', 'FontSize', dim_font)
else
	% date and time column not together.
	% do not use date time information, but number of samples. It is not a
	% suggested thing to do, better to create a .csv file with date and
	% time column together.
	
	sample_tot = length(mag_sens);
	
	% plot: Uncalibrated magnetic field, not reoriented
	figure('Name', ['figure ', num2str(id_plot),', Magnetic field representation - not reoriented'], 'NumberTitle','off'); id_plot = id_plot + 1;
	clf
	plot(1:sample_tot, mag_sens(:, 1))
	hold on
	plot(1:sample_tot, mag_sens(:, 2))
	plot(1:sample_tot, mag_sens(:, 3))
	grid on
	box on
	axis tight
	xlabel('x','FontSize', 20)
	ylabel('y','FontSize', 20)
	zlabel('z','FontSize', 20)
	legend('x mag', 'y mag', 'z mag','Location', 'southoutside','FontSize', 20)
	set(gca,'FontSize', 20)
	title("Magnetic field, not reoriented axes")
	hold off
	
	% plot: Uncalibrated magnetic field, reoriented
	figure('Name', ['figure ', num2str(id_plot),', Magnetic field representation - reoriented'], 'NumberTitle','off'); id_plot = id_plot + 1;
	clf
	plot(1:sample_tot, mag_reor(:, 1))
	hold on
	plot(1:sample_tot, mag_reor(:, 2))
	plot(1:sample_tot, mag_reor(:, 3))
	grid on
	box on
	axis tight
	xlabel('x','FontSize', 20)
	ylabel('y','FontSize', 20)
	zlabel('z','FontSize', 20)
	legend('x mag', 'y mag', 'z mag','Location', 'southoutside','FontSize', 20)
	set(gca,'FontSize', 20)
	title("Magnetic field, reoriented axes")
	hold off
	
	% plot: Uncalibrated magnetic field, reoriented (single axis)
	figure('Name', ['figure ', num2str(id_plot),', magnetic field reoriented - single axes'], 'NumberTitle','off'); id_plot = id_plot + 1;
	clf
	subplot(3,1,1)
		plot(1:sample_tot, mag_reor(:, 1), 'DisplayName', 'mag_x');
		grid on
		axis tight
		xlabel('time','FontSize', dim_fontb)
		ylabel('mag (\mu T)','FontSize', dim_fontb)
		legend('Location', 'best','FontSize', dim_fontb, 'Location', 'best')
		set(gca,'FontSize', dim_fontb) 
		title('Mag_x of magnetic field reoriented')
	subplot(3,1,2)
		plot(1:sample_tot, mag_reor(:, 2), 'DisplayName', 'mag_y');
		grid on
		axis tight
		xlabel('time','FontSize', dim_fontb)
		ylabel('mag','FontSize', dim_fontb)
		legend('Location', 'best','FontSize', dim_fontb, 'Location', 'best')
		set(gca,'FontSize', dim_fontb) 
		title('Mag_y of magnetic field reoriented')
	subplot(3,1,3)
		plot(1:sample_tot, mag_reor(:, 3), 'DisplayName', 'mag_z');
		grid on
		axis tight
		xlabel('time','FontSize', dim_fontb)
		ylabel('mag','FontSize', dim_fontb)
		legend('Location', 'best','FontSize', dim_fontb, 'Location', 'best')
		set(gca,'FontSize', dim_fontb) 
		title('Mag_z of magnetic field reoriented')	
	sgtitle('Magnetic field reoriented - single axes', 'FontSize', dim_font)
end