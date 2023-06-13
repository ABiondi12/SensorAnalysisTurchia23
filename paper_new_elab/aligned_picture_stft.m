%% Matlab_pspectrum
close all
clear

load("mat_file_tobeloaded\turtle7_turchia_dive.mat")

dim_fontb = 20;
dim_font = 30;

if exist('id_plot', 'var') == 0
	id_plot = 1;
end

num_dive = length(turtle7_turchia_dive.big_dive.homing);
motion_type = 'homing';
name_turtle = turtle7_turchia_dive.name;
fs = 10;

for i = 1:num_dive

    i_char = num2str(i);
	accx = turtle7_turchia_dive.big_dive.homing(i).accx;
	accy = turtle7_turchia_dive.big_dive.homing(i).accy;
	accz = turtle7_turchia_dive.big_dive.homing(i).accz;
	depth = turtle7_turchia_dive.big_dive.homing(i).depth;
	t_fft = turtle7_turchia_dive.big_dive.homing(i).datatime;
	odba = turtle7_turchia_dive.big_dive.homing(i).ODBA;
    % odba_mean = turtle7_turchia_dive.big_dive.homing(i).ODBA_paper;
    dive_type = turtle7_turchia_dive.big_dive.homing(i).type;

	%%

    %{
	mean_odba = mean(odba, 'all');
	fh2 = figure('Name', ['figure ', num2str(id_plot), ' ', name_turtle, ' ', motion_type, ' ', dive_type, ' dive: ODBA'], 'NumberTitle','off'); id_plot = id_plot + 1;
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
	plot(t_fft, depth, 'DisplayName', 'Depth');
	grid on;
	axis tight
	xlabel('time','FontSize', dim_fontb)
	ylabel('Depth (m)','FontSize', dim_fontb)
	% legend('Location', 'best','FontSize', dim_fontb)
	set(gca,'FontSize', dim_fontb)
	sgtitle(['Dive ', i_char, ', ', name_turtle, ' ', motion_type, ', ', dive_type, ' dive: ODBA'],'FontSize', dim_font)

%}
	%%
	[P_accx, F_accx, T_accx] = pspectrum(accx, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);

%{	
    figure('Name', ['figure ', num2str(id_plot), ' ', name_turtle, ' ', motion_type, ': Matlab time-frequency analysis, accx'], 'NumberTitle','off'); id_plot = id_plot + 1;
	clf
	subplot(2, 1, 1)
	pspectrum(accx, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
	ylim([0, 2]);
	set(gca,'FontSize', dim_fontb)
	subplot(2, 1, 2)
	plot(t_fft, depth, 'DisplayName', 'Depth');
	grid on;
	axis tight
	xlabel('time','FontSize', dim_fontb)
	ylabel('Depth (m)','FontSize', dim_fontb)
	legend('Location', 'best','FontSize', dim_fontb)
	set(gca,'FontSize', dim_fontb)
	sgtitle([name_turtle, ' ', motion_type, ': Matlab time-frequency analysis, accx'],'FontSize', dim_font)
%}
	%%

%{
	fh2 = figure('Name', ['figure ', num2str(id_plot), ' ', name_turtle, ' ', motion_type, ' ', dive_type, ' dive: Matlab time-frequency analysis, accx'], 'NumberTitle','off'); id_plot = id_plot + 1;
	clf
	sfh3 = subplot(2,1,1,'Parent',fh2);
	pspectrum(accx, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
	ylim([0, 2]);
	set(gca,'FontSize', dim_fontb)
	sfh4 = subplot(2,1,2,'Parent',fh2);
	plot(t_fft, depth, 'DisplayName', 'Depth');
	sfh4.Position = sfh4.Position + [0 0 -0.031 0];
	grid on
	axis tight
	xlabel('time','FontSize', dim_fontb)
	ylabel('Depth (m)','FontSize', dim_fontb)
	% legend('Location', 'best','FontSize', dim_fontb)
	set(gca,'FontSize', dim_fontb)
	sgtitle(['Dive ', i_char, ', ', name_turtle, ' ', motion_type, ', ', dive_type, ' dive: Matlab time-frequency analysis, accx'],'FontSize', dim_font)
%}

	%%
	[P_accy, F_accy, T_accy] = pspectrum(accy, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);

%{	
    figure('Name', ['figure ', num2str(id_plot), ' ', name_turtle, ' ', motion_type, ': Matlab time-frequency analysis, accy'], 'NumberTitle','off'); id_plot = id_plot + 1;
	clf
	subplot(2, 1, 1)
	pspectrum(accy, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
	ylim([0, 2]);
	set(gca,'FontSize', dim_fontb)
	subplot(2, 1, 2)
	plot(t_fft, depth, 'DisplayName', 'Depth');
	grid on;
	axis tight
	xlabel('time','FontSize', dim_fontb)
	ylabel('Depth (m)','FontSize', dim_fontb)
	legend('Location', 'best','FontSize', dim_fontb)
	set(gca,'FontSize', dim_fontb)
	sgtitle([name_turtle, ' ', motion_type, ': Matlab time-frequency analysis, accy'],'FontSize', dim_font)
%}
    
    %% 

	fh2 = figure('Name', ['figure ', num2str(id_plot), ' ', name_turtle, ' ', motion_type, ' ', dive_type, ' dive: Matlab time-frequency analysis, accy'], 'NumberTitle','off'); id_plot = id_plot + 1;
	clf
	sfh3 = subplot(2,1,1,'Parent',fh2);
	pspectrum(accy, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
	ylim([0, 2]);
	set(gca,'FontSize', dim_fontb)
	sfh4 = subplot(2,1,2,'Parent',fh2);
	plot(t_fft, depth, 'DisplayName', 'Depth');
	sfh4.Position = sfh4.Position + [0 0 -0.031 0];
	grid on;
	axis tight
	xlabel('time','FontSize', dim_fontb)
	ylabel('Depth (m)','FontSize', dim_fontb)
	% legend('Location', 'best','FontSize', dim_fontb)
	set(gca,'FontSize', dim_fontb)
	sgtitle(['Dive ', i_char, ', ', name_turtle, ' ', motion_type, ', ', dive_type, ' dive: Matlab time-frequency analysis, accy'],'FontSize', dim_font)

	%%

	[P_accz, F_accz, T_accz] = pspectrum(accz, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);

%{
	figure('Name', ['figure ', num2str(id_plot), ' ', name_turtle, ' ', motion_type, ': Matlab time-frequency analysis, accz'], 'NumberTitle','off'); id_plot = id_plot + 1;
	clf
	subplot(2, 1, 1)
	pspectrum(accz, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
	ylim([0, 2]);
	set(gca,'FontSize', dim_fontb)
	subplot(2, 1, 2)
	plot(t_fft, depth, 'DisplayName', 'Depth');
	grid on;
	axis tight
	xlabel('time','FontSize', dim_fontb)
	ylabel('Depth (m)','FontSize', dim_fontb)
	legend('Location', 'best','FontSize', dim_fontb)
	set(gca,'FontSize', dim_fontb)
	sgtitle([name_turtle, ' ', motion_type, ': Matlab time-frequency analysis, accz'],'FontSize', dim_font)
%}
	%%
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