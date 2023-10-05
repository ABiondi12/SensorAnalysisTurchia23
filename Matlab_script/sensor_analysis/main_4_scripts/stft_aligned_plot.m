% stft_aligned_plot
%
% This script handles the plot, for the entire dataset and for each big 
% dive, separately, of the Time-Frequency analysis over the acceleration
% data along the x and the y axis, respectively.
%
% Plot are shown w.r.t. depth profile in order to study the variation 
% and presence/absence of a dominant frequency depending on the 
% turtle behaviour (especially for what concern the dive profile).
%
% Moreover, there is also the plot of the ODBA computed over each dive
% profile, again compared with the dive pattern. This is done for
% evaluating if there is some evidence in the variation of the ODBA
% depending on the dive phase (descent, bottom, ascent phase).

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

yn_entire_path = 0;

fprintf('Do you want to see all the dataset? \n')
fprintf('1. Yes \n')
fprintf('2. No \n')
while yn_entire_path < 1 || yn_entire_path > 2
	yn_entire_path = input('');
end

if yn_entire_path == 1
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
end

%% deep dives

yn_filtered = 0;
fprintf('Do you want to use filtered acceleration data? \n')
fprintf('1. Yes \n')
fprintf('2. No \n')
while yn_filtered < 1 || yn_filtered > 2
	yn_filtered = input('');
end

for i = 1:counter

    i_char = num2str(i);
	
	if yn_filtered == 1
		accx = turtle_dive_din.big_dive.homing(ii).dinx;
		accy = turtle_dive_din.big_dive.homing(ii).diny;
		accz = turtle_dive_din.big_dive.homing(ii).dinz;
		odba = turtle_dive_din.big_dive.homing(i).ODBA;

	elseif yn_filtered == 2
		accx = turtle_dive.big_dive.homing(ii).accx;
		accy = turtle_dive.big_dive.homing(ii).accy;
		accz = turtle_dive.big_dive.homing(ii).accz;
		odba = turtle_dive.big_dive.homing(i).ODBA;
	end

	depth_plt = turtle_dive.big_dive.homing(i).depth;
	t_fft_depth = turtle_dive.big_dive.homing(i).datatime_depth;
	t_fft = turtle_dive.big_dive.homing(i).datatime;
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