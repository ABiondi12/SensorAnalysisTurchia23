function[spect_zero_max, spect_bott_max, spect_max, freq_spect_zero_max, freq_spect_bott_max, freq_spect_max] = trial_freq_spect_fftft(name_turtle, motion_type, P_acc, F_acc, id_plot, name_signal, t_fft, depth)
% trial_freq_spect_fftft

%% init
dim_fontb	= 20;
dim_font	= 30;
th_zero		= 0;
th_bott		= 0.15;
th_min	= 0.3;

%% indices definition
% indeces from which to start evaluating the components of the spectrum 
% because they are associated with frequencies greater than the threshold.
% Split into three frequency bands in order to highlight both flippers beat
% frequency, waves frequency and other possible factors (hoping all of them
% work at different frequency bands).

ind_zero = find(F_acc > th_zero);
ind_bott = find(F_acc > th_bott);
ind_min  = find(F_acc > th_min);

% position in the array of the first data associated to a certain frequency
% band.
id_zero = ind_zero(1);
id_bott = ind_bott(1);
id_min	= ind_min(1);				

% It returns both max spectral power and frequency at which this maximum
% power value occurs
[spect_zero_max, id_spect_zero_max] = max(P_acc(id_zero:id_bott-1, :));
id_spect_zero_max = id_spect_zero_max + id_zero-1;

[spect_bott_max, id_spect_bott_max] = max(P_acc(id_bott:id_min-1, :));
id_spect_bott_max = id_spect_bott_max + id_bott-1;
									
[spect_max, id_spect_max] = max(P_acc(id_min:end, :));
id_spect_max = id_spect_max + id_min-1;

for ii = 1:length(id_spect_zero_max)
	freq_spect_zero_max(ii) = F_acc(id_spect_zero_max(ii));
end

for ii = 1:length(id_spect_bott_max)
	freq_spect_bott_max(ii) = F_acc(id_spect_bott_max(ii));
end

for ii = 1:length(id_spect_max)
	freq_spect_max(ii) = F_acc(id_spect_max(ii));
end

freq_spect_zero_max_smooth = smoothdata(freq_spect_zero_max, 'movmedian', 10);
freq_spect_bott_max_smooth = smoothdata(freq_spect_bott_max, 'movmedian', 10);
freq_spect_max_smooth = smoothdata(freq_spect_max, 'movmedian', 10);
%% plot
if id_plot > 0 && strcmp(name_signal, 'noplot') == 0
	figure('Name', ['figure ', num2str(id_plot), ' ', name_turtle, ' ', motion_type, ': analysis of most significant frequencies in ', name_signal], 'NumberTitle','off'); id_plot = id_plot + 1;

	subplot(2,1,1)
	plot (freq_spect_max, 'DisplayName', ['freq over ', num2str(th_min)])
	hold on
	plot (freq_spect_bott_max, 'DisplayName', ['freq between ', num2str(th_bott), ' and ', num2str(th_min)])
	plot (freq_spect_zero_max, 'DisplayName', ['freq between ', num2str(th_zero), ' and ', num2str(th_bott)])
	legend('Location', 'best','FontSize', dim_fontb)
	set(gca,'FontSize', dim_fontb)
	subplot(2,1,2)
	plot(t_fft, depth, 'DisplayName', 'Depth');
	legend('Location', 'best','FontSize', dim_fontb)
	set(gca,'FontSize', dim_fontb)
	sgtitle([name_turtle, ' ', motion_type, ': ', name_signal, ' analysis of most significant frequencies'],'FontSize', dim_font);

	figure('Name', ['figure ', num2str(id_plot), ' ', name_turtle, ' ', motion_type, ': analysis of most significant frequencies smoothed in', name_signal], 'NumberTitle','off');

	subplot(2,1,1)
	plot (freq_spect_max_smooth, 'DisplayName', ['freq over ', num2str(th_min)])
	hold on
	plot (freq_spect_bott_max_smooth, 'DisplayName', ['freq between ', num2str(th_bott), ' and ', num2str(th_min)])
	plot (freq_spect_zero_max_smooth, 'DisplayName', ['freq between ', num2str(th_zero), ' and ', num2str(th_bott)])
	legend('Location', 'best','FontSize', dim_fontb)
	set(gca,'FontSize', dim_fontb)
	subplot(2,1,2)
	plot(t_fft, depth, 'DisplayName', 'Depth');
	legend('Location', 'best','FontSize', dim_fontb)
	set(gca,'FontSize', dim_fontb)
	sgtitle([name_turtle, ' ', motion_type, ': ', name_signal, ' analysis of most significant frequencies smoothed'], 'FontSize', dim_font);
end