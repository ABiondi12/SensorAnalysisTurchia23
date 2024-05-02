% stft_aligned_plot
%
% This script handles the plot for a single big dive, shallow dive or sub 
% surface period (to be selected) of the Time-Frequency analysis over the 
% acceleration data along the x and the y axis, respectively.
%
% Plot are shown w.r.t. depth profile in order to study the variation 
% and presence/absence of a dominant frequency depending on the 
% turtle behaviour (especially for what concern the dive profile).
%
% Moreover, there is also the plot of the ODBA computed over each 
% profile, again compared with the dive pattern. This is done for
% evaluating if there is some evidence in the variation of the ODBA
% depending on the period phase.

% CAMBIA CON IL DATASET TURTLE_DIVE_PLT E TURTLE_DIVE_DIN_PLT
%% Matlab_pspectrum plot
if exist('id_plot', 'var') == 0
	id_plot = 1;
end

if exist('dim_font', 'var') == 0
	dim_font = 30;
end

if exist('dim_fontb', 'var') == 0
	dim_fontb = 15;
end
%% period information

name_turtle = turtle_name;
% motion_type = 'homing';
fs = 10;

%% shallow dives or sub surface period
type_period = 0;

fprintf("Do you want to see a big dive, a shallow dive or a sub surface period? \n")
fprintf("1. Big dive \n")
fprintf("2. Shallow dive \n")
fprintf("3. Sub surface period \n")

while type_period < 1 || type_period > 3
	type_period = input('');
end

if type_period == 1
	max_num = counter;
	string_period = 'Big dive ';
elseif type_period == 2
	max_num = sh_counter;
	string_period = 'Shallow dive ';
elseif type_period == 3
	max_num = surf_counter;
	string_period = 'Sub surface period ';
end

num_period = 0;

fprintf("Select the period you want to see:  \n")
fprintf("min: 1 \n")
fprintf(['max: ', num2str(max_num), ' \n'])

while num_period < 1 || num_period > max_num
	num_period = input('');
end

yn_din = 0;

fprintf("Do you want to see the filtered version?  \n")
fprintf("1. Yes \n")
fprintf('2. No \n')

while yn_din < 1 || yn_din > 2
	yn_din = input('');
end
%% selected period

if type_period == 1
	if yn_din == 1
		if plt_version == 1
			turtle_dive_show = turtle_dive_din_plt.big_dive;
		else
			turtle_dive_show = turtle_dive_din.big_dive;
		end
	elseif yn_din == 2
		if plt_version == 1
			turtle_dive_show = turtle_dive_plt.big_dive;
		else
			turtle_dive_show = turtle_dive.big_dive;
		end
	end
	
	dive_type = turtle_dive_show.homing(num_period).type;

elseif type_period == 2
	if yn_din == 1
		if plt_version == 1
			turtle_dive_show = turtle_dive_din_plt.shallow_dive;
		else
			turtle_dive_show = turtle_dive_din.shallow_dive;
		end
	elseif yn_din == 2
		if plt_version == 1
			turtle_dive_show = turtle_dive_plt.shallow_dive;
		else
			turtle_dive_show = turtle_dive.shallow_dive;
		end
	end
elseif type_period == 3
	if yn_din == 1
		if plt_version == 1
			turtle_dive_show = turtle_dive_din_plt.sub_surface;
		else
			turtle_dive_show = turtle_dive_din.sub_surface;
		end
	elseif yn_din == 2
		if plt_version == 1
			turtle_dive_show = turtle_dive_plt.sub_surface;
		else
			turtle_dive_show = turtle_dive.sub_surface;
		end
	end
end

i_char = num2str(num_period);

if yn_din == 1
	if type_period == 3
		yn_waves = 0;

		fprintf("Do you want to see the waves filtered version?  \n")
		fprintf("1. Yes \n")
		fprintf('2. No \n')

		while yn_waves < 1 || yn_waves > 2
			yn_waves = input('');
		end

		if yn_waves == 1
			accx = turtle_dive_show.homing(num_period).dinx_nw;
			accy = turtle_dive_show.homing(num_period).diny_nw;
			accz = turtle_dive_show.homing(num_period).dinz_nw;
		elseif yn_waves == 2
			accx = turtle_dive_show.homing(num_period).dinx;
			accy = turtle_dive_show.homing(num_period).diny;
			accz = turtle_dive_show.homing(num_period).dinz;
		end
		
	else
		accx = turtle_dive_show.homing(num_period).dinx;
		accy = turtle_dive_show.homing(num_period).diny;
		accz = turtle_dive_show.homing(num_period).dinz;
	end
	
elseif yn_din == 2
	accx = turtle_dive_show.homing(num_period).accx;
	accy = turtle_dive_show.homing(num_period).accy;
	accz = turtle_dive_show.homing(num_period).accz;
end

depth_plt = turtle_dive_show.homing(num_period).depth;
t_fft_depth = turtle_dive_show.homing(num_period).datatime_depth;
t_fft = turtle_dive_show.homing(num_period).datatime;
odba = turtle_dive_show.homing(num_period).ODBA;

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
	sgtitle(['Dive num ', i_char, ', type ', dive_type, ', ', name_turtle, ' : ODBA'],'FontSize', dim_font)

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
	sgtitle([string_period, ' num ', i_char, ', type ', dive_type, ', ', name_turtle, ' : time-frequency analysis, accx'],'FontSize', dim_font)
	
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
	sgtitle(['plot: ', string_period, ' num ', i_char, ', type ', dive_type, ', ', name_turtle, ' : time-frequency analysis, accy'],'FontSize', dim_font)

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
	sgtitle([string_period , i_char, ', type ', dive_type, ', ' , name_turtle, ' : time-frequency analysis, accz'],'FontSize', dim_font)

%}