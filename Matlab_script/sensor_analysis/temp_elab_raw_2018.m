%% Zeynep
% raw reor
end_sample_2018 = length(turtle_turchia(5).homing.accx);
accx_2018 = turtle_turchia(5).homing.accx;
accy_2018 = turtle_turchia(5).homing.accy;
accz_2018 = turtle_turchia(5).homing.accz;
depth_2018 = turtle_turchia(5).homing.depth;
datetime_2018 = turtle_turchia(5).homing.datatime;

% raw not reor
end_sample_2018_nr = length(turtle_turchia_not_reor(5).homing.accx);
accx_2018_nr = turtle_turchia_not_reor(5).homing.accx;
accy_2018_nr = turtle_turchia_not_reor(5).homing.accy;
accz_2018_nr = turtle_turchia_not_reor(5).homing.accz;
depth_2018_nr = turtle_turchia_not_reor(5).homing.depth;
datetime_2018_nr = turtle_turchia_not_reor(5).homing.datatime;

figure('Name', 'Zeynep Acceleration axes reoriented', 'NumberTitle','off'); id_plot = id_plot + 1;
	clf
	subplot(2,1,1)
    plot(datetime_2018, accx_2018)
	hold on
    plot(datetime_2018, accy_2018)
    plot(datetime_2018, accz_2018)
	grid on
	box on
	axis tight
	xlabel('x','FontSize', 20)
	ylabel('y','FontSize', 20)
	zlabel('z','FontSize', 20)
	legend('x acc', 'y acc', 'z acc','Location', 'southeast','FontSize', 20)
	set(gca,'FontSize', 20)
	title("Zeynep Acceleration, axes reoriented")
	hold off
	subplot(2,1,2)
    plot(datetime_2018, depth_2018)
	grid on
	box on
	axis tight
    ylim([min(depth_2018)-1 1])
	xlabel('x','FontSize', 20)
	ylabel('y','FontSize', 20)
	zlabel('z','FontSize', 20)
	legend('depth','Location', 'southeast','FontSize', 20)
	set(gca,'FontSize', 20)
	title("Depth profile")

figure('Name', 'Zeynep Acceleration axes not reoriented', 'NumberTitle','off'); id_plot = id_plot + 1;
	clf
	subplot(2,1,1)
    plot(datetime_2018_nr, accx_2018_nr)
	hold on
    plot(datetime_2018_nr, accy_2018_nr)
    plot(datetime_2018_nr, accz_2018_nr)
	grid on
	box on
	axis tight
	xlabel('x','FontSize', 20)
	ylabel('y','FontSize', 20)
	zlabel('z','FontSize', 20)
	legend('x acc', 'y acc', 'z acc','Location', 'southeast','FontSize', 20)
	set(gca,'FontSize', 20)
	title("Zeynep Acceleration, axes not reoriented")
	hold off
	subplot(2,1,2)
    plot(datetime_2018_nr, depth_2018_nr)
	grid on
	box on
	axis tight
    ylim([min(depth_2018_nr)-1 1])
	xlabel('x','FontSize', 20)
	ylabel('y','FontSize', 20)
	zlabel('z','FontSize', 20)
	legend('depth','Location', 'southeast','FontSize', 20)
	set(gca,'FontSize', 20)
	title("Depth profile")

%% Defne1
% raw reor
end_sample_2018_D = length(turtle_turchia(6).homing.accx);
accx_2018_D = turtle_turchia(6).homing.accx;
accy_2018_D = turtle_turchia(6).homing.accy;
accz_2018_D = turtle_turchia(6).homing.accz;
depth_2018_D = turtle_turchia(6).homing.depth;
datetime_2018_D = turtle_turchia(6).homing.datatime;

% raw not reor
end_sample_2018_nr_D = length(turtle_turchia_not_reor(6).homing.accx);
accx_2018_nr_D = turtle_turchia_not_reor(6).homing.accx;
accy_2018_nr_D = turtle_turchia_not_reor(6).homing.accy;
accz_2018_nr_D = turtle_turchia_not_reor(6).homing.accz;
depth_2018_nr_D = turtle_turchia_not_reor(6).homing.depth;
datetime_2018_nr_D = turtle_turchia_not_reor(6).homing.datatime;

figure('Name', 'Defne Acceleration axes reoriented', 'NumberTitle','off'); id_plot = id_plot + 1;
	clf
	subplot(2,1,1)
    plot(datetime_2018_D, accx_2018_D)
	hold on
    plot(datetime_2018_D, accy_2018_D)
    plot(datetime_2018_D, accz_2018_D)
	grid on
	box on
	axis tight
	xlabel('x','FontSize', 20)
	ylabel('y','FontSize', 20)
	zlabel('z','FontSize', 20)
	legend('x acc', 'y acc', 'z acc','Location', 'southeast','FontSize', 20)
	set(gca,'FontSize', 20)
	title("Defne Acceleration, axes reoriented")
	hold off
	subplot(2,1,2)
    plot(datetime_2018_D, depth_2018_D)
	grid on
	box on
	axis tight
    ylim([min(depth_2018_D)-1 1])
	xlabel('x','FontSize', 20)
	ylabel('y','FontSize', 20)
	zlabel('z','FontSize', 20)
	legend('depth','Location', 'southeast','FontSize', 20)
	set(gca,'FontSize', 20)
	title("Depth profile")

%{  
figure('Name', 'Defne Acceleration axes not reoriented', 'NumberTitle','off'); id_plot = id_plot + 1;
	clf
	subplot(2,1,1)
    plot(datetime_2018_nr_D, accx_2018_nr_D)
	hold on
    plot(datetime_2018_nr_D, accy_2018_nr_D)
    plot(datetime_2018_nr_D, accz_2018_nr_D)
	grid on
	box on
	axis tight
	xlabel('x','FontSize', 20)
	ylabel('y','FontSize', 20)
	zlabel('z','FontSize', 20)
	legend('x acc', 'y acc', 'z acc','Location', 'southeast','FontSize', 20)
	set(gca,'FontSize', 20)
	title("Defne Acceleration, axes not reoriented")
	hold off
	subplot(2,1,2)
    plot(datetime_2018_nr_D, depth_2018_nr_D)
	grid on
	box on
	axis tight
    ylim([min(depth_2018_nr_D)-1 1])
	xlabel('x','FontSize', 20)
	ylabel('y','FontSize', 20)
	zlabel('z','FontSize', 20)
	legend('depth','Location', 'southeast','FontSize', 20)
	set(gca,'FontSize', 20)
	title("Depth profile")
%}