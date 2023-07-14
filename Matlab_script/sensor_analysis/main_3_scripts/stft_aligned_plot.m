%% Matlab_pspectrum plot
dim_fontb = 20;
dim_font = 30;

if exist('id_plot', 'var') == 0
	id_plot = 1;
end

%% entire path

name_turtle = turtle_name;
% motion_type = 'homing';
fs = 10;

accx = acc_reor(:,1);
accy = acc_reor(:,2);
accz = acc_reor(:,3);
depth_plt = depth;
t_fft_depth = datetime_depth;   
t_fft = datetime_acc;
	%% accx
[P_accx, F_accx, T_accx] = pspectrum(accx, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);

% fh2 = figure('Name', ['figure ', num2str(id_plot), ' ', name_turtle, ' ', motion_type, ': Matlab time-frequency analysis, accx'], 'NumberTitle','off'); id_plot = id_plot + 1;
fh2 = figure(id_plot); id_plot = id_plot + 1;
clf
sfh3 = subplot(2,1,1,'Parent',fh2);
pspectrum(accx, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
ylim([0, 2]);
set(gca,'FontSize', dim_fontb)
sfh4 = subplot(2,1,2,'Parent',fh2);
plot(t_fft_depth, depth_plt, 'DisplayName', 'Depth');
sfh4.Position = sfh4.Position + [0 0 -0.031 0];
grid on
axis tight
xlabel('time','FontSize', dim_fontb)
ylabel('Depth (m)','FontSize', dim_fontb)
% legend('Location', 'best','FontSize', dim_fontb)
set(gca,'FontSize', dim_fontb)
sgtitle(['Turtle ', name_turtle, ': Matlab time-frequency analysis, accx'],'FontSize', dim_font)
    
	%% accy
[P_accy, F_accy, T_accy] = pspectrum(accy, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);

% fh2 = figure('Name', ['figure ', num2str(id_plot), ' ', name_turtle, ' ', motion_type, ': Matlab time-frequency analysis, accy'], 'NumberTitle','off'); id_plot = id_plot + 1;
fh2 = figure(id_plot); id_plot = id_plot + 1;
clf
sfh3 = subplot(2,1,1,'Parent',fh2);
pspectrum(accy, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
ylim([0, 2]);
set(gca,'FontSize', dim_fontb)
sfh4 = subplot(2,1,2,'Parent',fh2);
plot(t_fft_depth, depth_plt, 'DisplayName', 'Depth');
sfh4.Position = sfh4.Position + [0 0 -0.031 0];
grid on;
axis tight
xlabel('time','FontSize', dim_fontb)
ylabel('Depth (m)','FontSize', dim_fontb)
% legend('Location', 'best','FontSize', dim_fontb)
set(gca,'FontSize', dim_fontb)
sgtitle(['Turtle ', name_turtle, ': Matlab time-frequency analysis, accy'],'FontSize', dim_font)

%% deep dives

for i = 1:counter

    i_char = num2str(i);
	accx = turtle_dive.big_dive.homing(i).accx;
	accy = turtle_dive.big_dive.homing(i).accy;
	accz = turtle_dive.big_dive.homing(i).accz;
	depth_plt = turtle_dive.big_dive.homing(i).depth;
	t_fft_depth = turtle_dive.big_dive.homing(i).datatime_depth;
	t_fft = turtle_dive.big_dive.homing(i).datatime;
	odba = turtle_dive.big_dive.homing(i).ODBA;
    % odba_mean = turtle_dive.big_dive.homing(i).ODBA_paper;
    dive_type = turtle_dive.big_dive.homing(i).type;

		%% ODBA

	mean_odba = mean(odba, 'all');
	%fh2 = figure('Name', ['figure ', num2str(id_plot), ' ', name_turtle, ' ', motion_type, ' ', dive_type, ' dive: ODBA'], 'NumberTitle','off'); id_plot = id_plot + 1;
	fh2 = figure(id_plot); id_plot = id_plot + 1;
	clf
	sfh3 = subplot(2,1,1,'Parent',fh2);
	plot(t_fft, odba, 'DisplayName', 'ODBA');
	hold on
	plot(t_fft, mean_odba.*ones(size(odba, 1), size(odba, 2)), 'DisplayName', 'mean ODBA');
	set(gca,'FontSize', dim_fontb)
	grid on;
	axis tight;
    xlabel('time','FontSize', dim_fontb)
	ylabel('ODBA','FontSize', dim_fontb)
    legend('Location', 'best','FontSize', dim_fontb)
	sfh4 = subplot(2,1,2,'Parent',fh2);
	plot(t_fft_depth, depth_plt, 'DisplayName', 'Depth');
	grid on;
	axis tight
	xlabel('time','FontSize', dim_fontb)
	ylabel('Depth (m)','FontSize', dim_fontb)
	% legend('Location', 'best','FontSize', dim_fontb)
	set(gca,'FontSize', dim_fontb)
	sgtitle(['Dive ', i_char, ', ', name_turtle, ', ', dive_type, ' dive: ODBA'],'FontSize', dim_font)

		%% accx
	[P_accx, F_accx, T_accx] = pspectrum(accx, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);	%%

	% fh2 = figure('Name', ['figure ', num2str(id_plot), ' ', name_turtle, ' ', motion_type, ' ', dive_type, ' dive: Matlab time-frequency analysis, accx'], 'NumberTitle','off'); id_plot = id_plot + 1;
	fh2 = figure(id_plot); id_plot = id_plot + 1;
	clf
	sfh3 = subplot(2,1,1,'Parent',fh2);
	pspectrum(accx, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
	ylim([0, 2]);
	set(gca,'FontSize', dim_fontb)
	sfh4 = subplot(2,1,2,'Parent',fh2);
	plot(t_fft_depth, depth_plt, 'DisplayName', 'Depth');
	sfh4.Position = sfh4.Position + [0 0 -0.031 0];
	grid on
	axis tight
	xlabel('time','FontSize', dim_fontb)
	ylabel('Depth (m)','FontSize', dim_fontb)
	% legend('Location', 'best','FontSize', dim_fontb)
	set(gca,'FontSize', dim_fontb)
	sgtitle(['Dive ', i_char, ', ', name_turtle, ', ', dive_type, ' dive: Matlab time-frequency analysis, accx'],'FontSize', dim_font)

		%% accy
	[P_accy, F_accy, T_accy] = pspectrum(accy, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);

	% fh2 = figure('Name', ['figure ', num2str(id_plot), ' ', name_turtle, ' ', motion_type, ' ', dive_type, ' dive: Matlab time-frequency analysis, accy'], 'NumberTitle','off'); id_plot = id_plot + 1;
	fh2 = figure(id_plot); id_plot = id_plot + 1;
	clf
	sfh3 = subplot(2,1,1,'Parent',fh2);
	pspectrum(accy, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
	ylim([0, 2]);
	set(gca,'FontSize', dim_fontb)
	sfh4 = subplot(2,1,2,'Parent',fh2);
	plot(t_fft_depth, depth_plt, 'DisplayName', 'Depth');
	sfh4.Position = sfh4.Position + [0 0 -0.031 0];
	grid on;
	axis tight
	xlabel('time','FontSize', dim_fontb)
	ylabel('Depth (m)','FontSize', dim_fontb)
	% legend('Location', 'best','FontSize', dim_fontb)
	set(gca,'FontSize', dim_fontb)
	sgtitle(['Dive ', i_char, ', ', name_turtle, ', ', dive_type, ' dive: Matlab time-frequency analysis, accy'],'FontSize', dim_font)

		%% accz

%	[P_accz, F_accz, T_accz] = pspectrum(accz, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);

%{
	fh2 = figure('Name', ['figure ', num2str(id_plot), ' ', name_turtle, ' ', motion_type, ' ', dive_type, ' dive: Matlab time-frequency analysis, accz'], 'NumberTitle','off'); id_plot = id_plot + 1;
	clf
	sfh3 = subplot(2,1,1,'Parent',fh2);
	pspectrum(accz, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
	ylim([0, 2]);
	set(gca,'FontSize', dim_fontb)
	sfh4 = subplot(2,1,2,'Parent',fh2);
	plot(t_fft, depth, 'DisplayName', 'Depth');
	sfh4.Position = sfh4.Position + [0 0 -0.031 0];
	grid on;
	axis tight
	xlabel('time','FontSize', dim_fontb)
	ylabel('Depth (m)','FontSize', dim_fontb)
	legend('Location', 'best','FontSize', dim_fontb)
	set(gca,'FontSize', dim_fontb)
	sgtitle(['Dive ', i_char, ', ', name_turtle, ' ', motion_type, ', ', dive_type, ' dive: Matlab time-frequency analysis, accz'],'FontSize', dim_font)
%}
end