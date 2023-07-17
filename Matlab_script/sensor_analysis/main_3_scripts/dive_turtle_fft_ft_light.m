% dive_turtle_fft_ft_light
%
% computes fft-ft analysis over dives and surfaces and save into struct
% their results.

% acc are raw reoriented data
% din are dynamic component (acc - static, gravity) - Unused
% din_nw are only for sub surface section and are dynamic component - waves
% probably effect

%% init
turtle_dive_fft = turtle_dive;			%% raw acc data
% turtle_dive_fft_din = turtle_dive_din;	%% din acc data (no waves on sub surf components)

if exist('turtle_name', 'var') == 0
	turtle_name = turtle_dive_fft.name;
end

if exist('fs', 'var') == 0
	fs = 10;
end

%% big dives
for ii = 1 : counter
	t_fft_dive = turtle_dive_fft.big_dive.homing(ii).datatime;
	t_fft_dp_dive = turtle_dive_fft.big_dive.homing(ii).datatime_depth;
	depth_dive = turtle_dive_fft.big_dive.homing(ii).depth;
	motion_type = 'homing';
	
	%% accx
	accx = turtle_dive_fft.big_dive.homing(ii).accx;
	
	[P_accx, F_accx, T_accx] = pspectrum(accx, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
	[spect_zero_max, spect_lf_max, spect_max, freq_spect_zero_max, freq_spect_lf_max, freq_spect_max] = trial_freq_spect_fftft(turtle_name, motion_type, P_accx, F_accx, 0, 'noplot', t_fft_dp_dive, depth_dive);
	
	turtle_dive_fft.big_dive.homing(ii).spect_zero_max_accx = spect_zero_max;
	turtle_dive_fft.big_dive.homing(ii).freq_spect_zero_max_accx = freq_spect_zero_max;
	turtle_dive_fft.big_dive.homing(ii).spect_lf_max_accx = spect_lf_max;
	turtle_dive_fft.big_dive.homing(ii).freq_spect_lf_max_accx = freq_spect_lf_max;
	turtle_dive_fft.big_dive.homing(ii).spect_max_accx = spect_max;
	turtle_dive_fft.big_dive.homing(ii).freq_spect_max_accx = freq_spect_max;
	turtle_dive_fft.big_dive.homing(ii).time_max_accx = T_accx;
	%% dinx - commented
	%{ 
	dinx = turtle_dive_fft_din.big_dive.homing(ii).dinx;
	[P_dinx, F_dinx, T_dinx] = pspectrum(dinx, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
	[spect_zero_max, spect_lf_max, spect_max, freq_spect_zero_max, freq_spect_lf_max, freq_spect_max] = trial_freq_spect_fftft(turtle_name, motion_type, P_dinx, F_dinx, 0, 'noplot', t_fft, depth);
	turtle_dive_fft_din.big_dive.homing(ii).spect_zero_max_accx = spect_zero_max;
	turtle_dive_fft_din.big_dive.homing(ii).freq_spect_zero_max_accx = freq_spect_zero_max;
	turtle_dive_fft_din.big_dive.homing(ii).spect_lf_max_accx = spect_lf_max;
	turtle_dive_fft_din.big_dive.homing(ii).freq_spect_lf_max_accx = freq_spect_lf_max;
	turtle_dive_fft_din.big_dive.homing(ii).spect_max_accx = spect_max;
	turtle_dive_fft_din.big_dive.homing(ii).freq_spect_max_accx = freq_spect_max;
	turtle_dive_fft_din.big_dive.homing(ii).time_max_accx = T_dinx;
	%}
	%% accy
	accy = turtle_dive_fft.big_dive.homing(ii).accy;
	[P_accy, F_accy, T_accy] = pspectrum(accy, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
	[spect_zero_max, spect_lf_max, spect_max, freq_spect_zero_max, freq_spect_lf_max, freq_spect_max] = trial_freq_spect_fftft(turtle_name, motion_type, P_accy, F_accy, 0, 'noplot', t_fft_dp_dive, depth_dive);
	
	turtle_dive_fft.big_dive.homing(ii).spect_zero_max_accy = spect_zero_max;
	turtle_dive_fft.big_dive.homing(ii).freq_spect_zero_max_accy = freq_spect_zero_max;
	turtle_dive_fft.big_dive.homing(ii).spect_lf_max_accy = spect_lf_max;
	turtle_dive_fft.big_dive.homing(ii).freq_spect_lf_max_accy = freq_spect_lf_max;
	turtle_dive_fft.big_dive.homing(ii).spect_max_accy = spect_max;
	turtle_dive_fft.big_dive.homing(ii).freq_spect_max_accy = freq_spect_max;
	turtle_dive_fft.big_dive.homing(ii).time_max_accy = T_accy;
	%% diny - commented
	%{
	diny = turtle_dive_fft_din.big_dive.homing(ii).diny;
	
	[P_diny, F_diny, T_diny] = pspectrum(diny, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
	[spect_zero_max, spect_lf_max, spect_max, freq_spect_zero_max, freq_spect_lf_max, freq_spect_max] = trial_freq_spect_fftft(turtle_name, motion_type, P_diny, F_diny, 0, 'noplot', t_fft, depth);
	
	turtle_dive_fft_din.big_dive.homing(ii).spect_zero_max_accy = spect_zero_max;
	turtle_dive_fft_din.big_dive.homing(ii).freq_spect_zero_max_accy = freq_spect_zero_max;
	turtle_dive_fft_din.big_dive.homing(ii).spect_lf_max_accy = spect_lf_max;
	turtle_dive_fft_din.big_dive.homing(ii).freq_spect_lf_max_accy = freq_spect_lf_max;
	turtle_dive_fft_din.big_dive.homing(ii).spect_max_accy = spect_max;
	turtle_dive_fft_din.big_dive.homing(ii).freq_spect_max_accy = freq_spect_max;
	turtle_dive_fft_din.big_dive.homing(ii).time_max_accy = T_diny;
	%}
	%% accz	
	accz = turtle_dive_fft.big_dive.homing(ii).accz;
	[P_accz, F_accz, T_accz] = pspectrum(accz, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
	[spect_zero_max, spect_lf_max, spect_max, freq_spect_zero_max, freq_spect_lf_max, freq_spect_max] = trial_freq_spect_fftft(turtle_name, motion_type, P_accz, F_accz, 0, 'noplot', t_fft_dp_dive, depth_dive);
	
	turtle_dive_fft.big_dive.homing(ii).spect_zero_max_accz = spect_zero_max;
	turtle_dive_fft.big_dive.homing(ii).freq_spect_zero_max_accz = freq_spect_zero_max;
	turtle_dive_fft.big_dive.homing(ii).spect_lf_max_accz = spect_lf_max;
	turtle_dive_fft.big_dive.homing(ii).freq_spect_lf_max_accz = freq_spect_lf_max;
	turtle_dive_fft.big_dive.homing(ii).spect_max_accz = spect_max;
	turtle_dive_fft.big_dive.homing(ii).freq_spect_max_accz = freq_spect_max;
	turtle_dive_fft.big_dive.homing(ii).time_max_accz = T_accz;
	%% dinz - commented
	%{
	dinz = turtle_dive_fft_din.big_dive.homing(ii).dinz;
	
	[P_dinz, F_dinz, T_dinz] = pspectrum(dinz, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
	[spect_zero_max, spect_lf_max, spect_max, freq_spect_zero_max, freq_spect_lf_max, freq_spect_max] = trial_freq_spect_fftft(turtle_name, motion_type, P_dinz, F_dinz, 0, 'noplot', t_fft, depth);
	
	turtle_dive_fft_din.big_dive.homing(ii).spect_zero_max_accz = spect_zero_max;
	turtle_dive_fft_din.big_dive.homing(ii).freq_spect_zero_max_accz = freq_spect_zero_max;
	turtle_dive_fft_din.big_dive.homing(ii).spect_lf_max_accz = spect_lf_max;
	turtle_dive_fft_din.big_dive.homing(ii).freq_spect_lf_max_accz = freq_spect_lf_max;
	turtle_dive_fft_din.big_dive.homing(ii).spect_max_accz = spect_max;
	turtle_dive_fft_din.big_dive.homing(ii).freq_spect_max_accz = freq_spect_max;
	turtle_dive_fft_din.big_dive.homing(ii).time_max_accz = T_dinz;
	%}
end

%% shallow dives
for ii = 1 : sh_counter
	t_fft_dive = turtle_dive_fft.shallow_dive.homing(ii).datatime;
	t_fft_dp_dive = turtle_dive_fft.shallow_dive.homing(ii).datatime_depth;
	depth_dive = turtle_dive_fft.shallow_dive.homing(ii).depth;
	motion_type = 'homing';
	
	%% accx
	accx = turtle_dive_fft.shallow_dive.homing(ii).accx;
	
	[P_accx, F_accx, T_accx] = pspectrum(accx, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
	[spect_zero_max, spect_lf_max, spect_max, freq_spect_zero_max, freq_spect_lf_max, freq_spect_max] = trial_freq_spect_fftft(turtle_name, motion_type, P_accx, F_accx, 0, 'noplot', t_fft_dp_dive, depth_dive);
	
	turtle_dive_fft.shallow_dive.homing(ii).spect_zero_max_accx = spect_zero_max;
	turtle_dive_fft.shallow_dive.homing(ii).freq_spect_zero_max_accx = freq_spect_zero_max;
	turtle_dive_fft.shallow_dive.homing(ii).spect_lf_max_accx = spect_lf_max;
	turtle_dive_fft.shallow_dive.homing(ii).freq_spect_lf_max_accx = freq_spect_lf_max;
	turtle_dive_fft.shallow_dive.homing(ii).spect_max_accx = spect_max;
	turtle_dive_fft.shallow_dive.homing(ii).freq_spect_max_accx = freq_spect_max;
	turtle_dive_fft.shallow_dive.homing(ii).time_max_accx = T_accx;
	%% dinx - commented
	%{
	dinx = turtle_dive_fft_din.shallow_dive.homing(ii).dinx;
	
	[P_dinx, F_dinx, T_dinx] = pspectrum(dinx, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
	[spect_zero_max, spect_lf_max, spect_max, freq_spect_zero_max, freq_spect_lf_max, freq_spect_max] = trial_freq_spect_fftft(turtle_name, motion_type, P_dinx, F_dinx, 0, 'noplot', t_fft, depth);
	
	turtle_dive_fft_din.shallow_dive.homing(ii).spect_zero_max_accx = spect_zero_max;
	turtle_dive_fft_din.shallow_dive.homing(ii).freq_spect_zero_max_accx = freq_spect_zero_max;
	turtle_dive_fft_din.shallow_dive.homing(ii).spect_lf_max_accx = spect_lf_max;
	turtle_dive_fft_din.shallow_dive.homing(ii).freq_spect_lf_max_accx = freq_spect_lf_max;
	turtle_dive_fft_din.shallow_dive.homing(ii).spect_max_accx = spect_max;
	turtle_dive_fft_din.shallow_dive.homing(ii).freq_spect_max_accx = freq_spect_max;
	turtle_dive_fft_din.shallow_dive.homing(ii).time_max_accx = T_dinx;
	%}
	%% accy
	accy = turtle_dive_fft.shallow_dive.homing(ii).accy;
	[P_accy, F_accy, T_accy] = pspectrum(accy, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
	[spect_zero_max, spect_lf_max, spect_max, freq_spect_zero_max, freq_spect_lf_max, freq_spect_max] = trial_freq_spect_fftft(turtle_name, motion_type, P_accy, F_accy, 0, 'noplot', t_fft_dp_dive, depth_dive);
	
	turtle_dive_fft.shallow_dive.homing(ii).spect_zero_max_accy = spect_zero_max;
	turtle_dive_fft.shallow_dive.homing(ii).freq_spect_zero_max_accy = freq_spect_zero_max;
	turtle_dive_fft.shallow_dive.homing(ii).spect_lf_max_accy = spect_lf_max;
	turtle_dive_fft.shallow_dive.homing(ii).freq_spect_lf_max_accy = freq_spect_lf_max;
	turtle_dive_fft.shallow_dive.homing(ii).spect_max_accy = spect_max;
	turtle_dive_fft.shallow_dive.homing(ii).freq_spect_max_accy = freq_spect_max;
	turtle_dive_fft.shallow_dive.homing(ii).time_max_accy = T_accy;
	%% diny - commented
	%{
	diny = turtle_dive_fft_din.shallow_dive.homing(ii).diny;
	
	[P_diny, F_diny, T_diny] = pspectrum(diny, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
	[spect_zero_max, spect_lf_max, spect_max, freq_spect_zero_max, freq_spect_lf_max, freq_spect_max] = trial_freq_spect_fftft(turtle_name, motion_type, P_diny, F_diny, 0, 'noplot', t_fft, depth);
	
	turtle_dive_fft_din.shallow_dive.homing(ii).spect_zero_max_accy = spect_zero_max;
	turtle_dive_fft_din.shallow_dive.homing(ii).freq_spect_zero_max_accy = freq_spect_zero_max;
	turtle_dive_fft_din.shallow_dive.homing(ii).spect_lf_max_accy = spect_lf_max;
	turtle_dive_fft_din.shallow_dive.homing(ii).freq_spect_lf_max_accy = freq_spect_lf_max;
	turtle_dive_fft_din.shallow_dive.homing(ii).spect_max_accy = spect_max;
	turtle_dive_fft_din.shallow_dive.homing(ii).freq_spect_max_accy = freq_spect_max;
	turtle_dive_fft_din.shallow_dive.homing(ii).time_max_accy = T_diny;
	%}
	%% accz
	accz = turtle_dive_fft.shallow_dive.homing(ii).accz;
	[P_accz, F_accz, T_accz] = pspectrum(accz, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
	[spect_zero_max, spect_lf_max, spect_max, freq_spect_zero_max, freq_spect_lf_max, freq_spect_max] = trial_freq_spect_fftft(turtle_name, motion_type, P_accz, F_accz, 0, 'noplot', t_fft_dp_dive, depth_dive);
	
	turtle_dive_fft.shallow_dive.homing(ii).spect_zero_max_accz = spect_zero_max;
	turtle_dive_fft.shallow_dive.homing(ii).freq_spect_zero_max_accz = freq_spect_zero_max;
	turtle_dive_fft.shallow_dive.homing(ii).spect_lf_max_accz = spect_lf_max;
	turtle_dive_fft.shallow_dive.homing(ii).freq_spect_lf_max_accz = freq_spect_lf_max;
	turtle_dive_fft.shallow_dive.homing(ii).spect_max_accz = spect_max;
	turtle_dive_fft.shallow_dive.homing(ii).freq_spect_max_accz = freq_spect_max;
	turtle_dive_fft.shallow_dive.homing(ii).time_max_accz = T_accz;
	%% dinz - commented
	%{
	dinz = turtle_dive_fft_din.shallow_dive.homing(ii).dinz;
	
	[P_dinz, F_dinz, T_dinz] = pspectrum(dinz, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
	[spect_zero_max, spect_lf_max, spect_max, freq_spect_zero_max, freq_spect_lf_max, freq_spect_max] = trial_freq_spect_fftft(turtle_name, motion_type, P_dinz, F_dinz, 0, 'noplot', t_fft, depth);
	
	turtle_dive_fft_din.shallow_dive.homing(ii).spect_zero_max_accz = spect_zero_max;
	turtle_dive_fft_din.shallow_dive.homing(ii).freq_spect_zero_max_accz = freq_spect_zero_max;
	turtle_dive_fft_din.shallow_dive.homing(ii).spect_lf_max_accz = spect_lf_max;
	turtle_dive_fft_din.shallow_dive.homing(ii).freq_spect_lf_max_accz = freq_spect_lf_max;
	turtle_dive_fft_din.shallow_dive.homing(ii).spect_max_accz = spect_max;
	turtle_dive_fft_din.shallow_dive.homing(ii).freq_spect_max_accz = freq_spect_max;
	turtle_dive_fft_din.shallow_dive.homing(ii).time_max_accz = T_dinz;
	%}
end

%% sub surface
for ii = 1 : surf_counter
	t_fft_dive = turtle_dive_fft.sub_surface.homing(ii).datatime;
	t_fft_dp_dive = turtle_dive_fft.sub_surface.homing(ii).datatime_depth;
	depth_dive = turtle_dive_fft.sub_surface.homing(ii).depth;
	motion_type = 'homing';
	
	%% accx
	accx = turtle_dive_fft.sub_surface.homing(ii).accx;
	if isempty(accx) == 0 && size(accx, 1) > 1
		[P_accx, F_accx, T_accx] = pspectrum(accx, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
		[spect_zero_max, spect_lf_max, spect_max, freq_spect_zero_max, freq_spect_lf_max, freq_spect_max] = trial_freq_spect_fftft(turtle_name, motion_type, P_accx, F_accx, 0, 'noplot', t_fft_dp_dive, depth_dive);
		
		turtle_dive_fft.sub_surface.homing(ii).spect_zero_max_accx = spect_zero_max;
		turtle_dive_fft.sub_surface.homing(ii).freq_spect_zero_max_accx = freq_spect_zero_max;
		turtle_dive_fft.sub_surface.homing(ii).spect_lf_max_accx = spect_lf_max;
		turtle_dive_fft.sub_surface.homing(ii).freq_spect_lf_max_accx = freq_spect_lf_max;
		turtle_dive_fft.sub_surface.homing(ii).spect_max_accx = spect_max;
		turtle_dive_fft.sub_surface.homing(ii).freq_spect_max_accx = freq_spect_max;
		turtle_dive_fft.sub_surface.homing(ii).time_max_accx = T_accx;
	end
	%% dinx - commented
	%{
	dinx = turtle_dive_fft.sub_surface_no_waves.homing(ii).dinx_nw;
	if isempty(dinx) == 0
		[P_dinx, F_dinx, T_dinx] = pspectrum(dinx, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
		[spect_zero_max, spect_lf_max, spect_max, freq_spect_zero_max, freq_spect_lf_max, freq_spect_max] = trial_freq_spect_fftft(turtle_name, motion_type, P_dinx, F_dinx, 0, 'noplot', t_fft, depth);
		
		turtle_dive_fft.sub_surface_no_waves.homing(ii).spect_zero_max_accx = spect_zero_max;
		turtle_dive_fft.sub_surface_no_waves.homing(ii).freq_spect_zero_max_accx = freq_spect_zero_max;
		turtle_dive_fft.sub_surface_no_waves.homing(ii).spect_lf_max_accx = spect_lf_max;
		turtle_dive_fft.sub_surface_no_waves.homing(ii).freq_spect_lf_max_accx = freq_spect_lf_max;
		turtle_dive_fft.sub_surface_no_waves.homing(ii).spect_max_accx = spect_max;
		turtle_dive_fft.sub_surface_no_waves.homing(ii).freq_spect_max_accx = freq_spect_max;
		turtle_dive_fft.sub_surface_no_waves.homing(ii).time_max_accx = T_dinx;
	end
	%}
	%% dinx_nw
	dinx = turtle_dive_fft.sub_surface_no_waves.homing(ii).dinx_nw;
	if isempty(dinx) == 0 && size(dinx, 1) > 1
		[P_dinx_nw, F_dinx_nw, T_dinx_nw] = pspectrum(dinx, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
		[spect_zero_max_nw, spect_lf_max_nw, spect_max_nw, freq_spect_zero_max_nw, freq_spect_lf_max_nw, freq_spect_max_nw] = trial_freq_spect_fftft(turtle_name, motion_type, P_dinx_nw, F_dinx_nw, 0, 'noplot', t_fft_dp_dive, depth_dive);
		
		turtle_dive_fft.sub_surface_no_waves.homing(ii).spect_zero_max_accx_nw = spect_zero_max_nw;
		turtle_dive_fft.sub_surface_no_waves.homing(ii).freq_spect_zero_max_accx_nw = freq_spect_zero_max_nw;
		turtle_dive_fft.sub_surface_no_waves.homing(ii).spect_lf_max_accx_nw = spect_lf_max_nw;
		turtle_dive_fft.sub_surface_no_waves.homing(ii).freq_spect_lf_max_accx_nw = freq_spect_lf_max_nw;
		turtle_dive_fft.sub_surface_no_waves.homing(ii).spect_max_accx_nw = spect_max_nw;
		turtle_dive_fft.sub_surface_no_waves.homing(ii).freq_spect_max_accx_nw = freq_spect_max_nw;
		turtle_dive_fft.sub_surface_no_waves.homing(ii).time_max_accx_nw = T_dinx_nw;
	end
	%% accy
	accy = turtle_dive_fft.sub_surface.homing(ii).accy;
	if isempty(accy) == 0 && size(accy, 1) > 1
		[P_accy, F_accy, T_accy] = pspectrum(accy, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
		[spect_zero_max, spect_lf_max, spect_max, freq_spect_zero_max, freq_spect_lf_max, freq_spect_max] = trial_freq_spect_fftft(turtle_name, motion_type, P_accy, F_accy, 0, 'noplot', t_fft_dp_dive, depth_dive);
		
		turtle_dive_fft.sub_surface.homing(ii).spect_zero_max_accy = spect_zero_max;
		turtle_dive_fft.sub_surface.homing(ii).freq_spect_zero_max_accy = freq_spect_zero_max;
		turtle_dive_fft.sub_surface.homing(ii).spect_lf_max_accy = spect_lf_max;
		turtle_dive_fft.sub_surface.homing(ii).freq_spect_lf_max_accy = freq_spect_lf_max;
		turtle_dive_fft.sub_surface.homing(ii).spect_max_accy = spect_max;
		turtle_dive_fft.sub_surface.homing(ii).freq_spect_max_accy = freq_spect_max;
		turtle_dive_fft.sub_surface.homing(ii).time_max_accy = T_accy;
	end
	%% diny - commented
	%{
	diny = turtle_dive_fft_din.sub_surface.homing(ii).diny;
	if isempty(diny) == 0
		[P_diny, F_diny, T_diny] = pspectrum(diny, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
		[spect_zero_max, spect_lf_max, spect_max, freq_spect_zero_max, freq_spect_lf_max, freq_spect_max] = trial_freq_spect_fftft(turtle_name, motion_type, P_diny, F_diny, 0, 'noplot', t_fft, depth);
		
		turtle_dive_fft_din.sub_surface.homing(ii).spect_zero_max_accy = spect_zero_max;
		turtle_dive_fft_din.sub_surface.homing(ii).freq_spect_zero_max_accy = freq_spect_zero_max;
		turtle_dive_fft_din.sub_surface.homing(ii).spect_lf_max_accy = spect_lf_max;
		turtle_dive_fft_din.sub_surface.homing(ii).freq_spect_lf_max_accy = freq_spect_lf_max;
		turtle_dive_fft_din.sub_surface.homing(ii).spect_max_accy = spect_max;
		turtle_dive_fft_din.sub_surface.homing(ii).freq_spect_max_accy = freq_spect_max;
		turtle_dive_fft_din.sub_surface.homing(ii).time_max_accy = T_diny;
	end
	%}
	%% diny_nw
	diny = turtle_dive_fft.sub_surface_no_waves.homing(ii).diny_nw;
	if isempty(diny) == 0 && size(diny, 1) > 1
		[P_diny_nw, F_diny_nw, T_diny_nw] = pspectrum(diny, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
		[spect_zero_max_nw, spect_lf_max_nw, spect_max_nw, freq_spect_zero_max_nw, freq_spect_lf_max_nw, freq_spect_max_nw] = trial_freq_spect_fftft(turtle_name, motion_type, P_diny_nw, F_diny_nw, 0, 'noplot', t_fft_dp_dive, depth_dive);
		
		turtle_dive_fft.sub_surface_no_waves.homing(ii).spect_zero_max_accy_nw = spect_zero_max_nw;
		turtle_dive_fft.sub_surface_no_waves.homing(ii).freq_spect_zero_max_accy_nw = freq_spect_zero_max_nw;
		turtle_dive_fft.sub_surface_no_waves.homing(ii).spect_lf_max_accy_nw = spect_lf_max_nw;
		turtle_dive_fft.sub_surface_no_waves.homing(ii).freq_spect_lf_max_accy_nw = freq_spect_lf_max_nw;
		turtle_dive_fft.sub_surface_no_waves.homing(ii).spect_max_accy_nw = spect_max_nw;
		turtle_dive_fft.sub_surface_no_waves.homing(ii).freq_spect_max_accy_nw = freq_spect_max_nw;
		turtle_dive_fft.sub_surface_no_waves.homing(ii).time_max_accy_nw = T_diny_nw;
	end
	%% accz
	accz = turtle_dive_fft.sub_surface.homing(ii).accz;
	if isempty(accz) == 0 && size(accz, 1) > 1
		[P_accz, F_accz, T_accz] = pspectrum(accz, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
		[spect_zero_max, spect_lf_max, spect_max, freq_spect_zero_max, freq_spect_lf_max, freq_spect_max] = trial_freq_spect_fftft(turtle_name, motion_type, P_accz, F_accz, 0, 'noplot', t_fft_dp_dive, depth_dive);
		
		turtle_dive_fft.sub_surface.homing(ii).spect_zero_max_accz = spect_zero_max;
		turtle_dive_fft.sub_surface.homing(ii).freq_spect_zero_max_accz = freq_spect_zero_max;
		turtle_dive_fft.sub_surface.homing(ii).spect_lf_max_accz = spect_lf_max;
		turtle_dive_fft.sub_surface.homing(ii).freq_spect_lf_max_accz = freq_spect_lf_max;
		turtle_dive_fft.sub_surface.homing(ii).spect_max_accz = spect_max;
		turtle_dive_fft.sub_surface.homing(ii).freq_spect_max_accz = freq_spect_max;
		turtle_dive_fft.sub_surface.homing(ii).time_max_accz = T_accz;
	end
	%% dinz - commented
	%{
	if isempty(dinz) == 0
		dinz = turtle_dive_fft_din.sub_surface.homing(ii).dinz;
		[P_dinz, F_dinz, T_dinz] = pspectrum(dinz, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
		[spect_zero_max, spect_lf_max, spect_max, freq_spect_zero_max, freq_spect_lf_max, freq_spect_max] = trial_freq_spect_fftft(turtle_name, motion_type, P_dinz, F_dinz, 0, 'noplot', t_fft, depth);
		
		turtle_dive_fft_din.sub_surface.homing(ii).spect_zero_max_accz = spect_zero_max;
		turtle_dive_fft_din.sub_surface.homing(ii).freq_spect_zero_max_accz = freq_spect_zero_max;
		turtle_dive_fft_din.sub_surface.homing(ii).spect_lf_max_accz = spect_lf_max;
		turtle_dive_fft_din.sub_surface.homing(ii).freq_spect_lf_max_accz = freq_spect_lf_max;
		turtle_dive_fft_din.sub_surface.homing(ii).spect_max_accz = spect_max;
		turtle_dive_fft_din.sub_surface.homing(ii).freq_spect_max_accz = freq_spect_max;
		turtle_dive_fft_din.sub_surface.homing(ii).time_max_accz = T_dinz;
	end
	%}
	%% dinz_nw
	dinz = turtle_dive_fft.sub_surface_no_waves.homing(ii).dinz_nw;
	if isempty(dinz) == 0 && size(dinz, 1) > 1
		[P_dinz_nw, F_dinz_nw, T_dinz_nw] = pspectrum(dinz, fs, 'spectrogram', 'Leakage', 1, 'OverlapPercent', 99, 'MinThreshold',-60);
		[spect_zero_max_nw, spect_lf_max_nw, spect_max_nw, freq_spect_zero_max_nw, freq_spect_lf_max_nw, freq_spect_max_nw] = trial_freq_spect_fftft(turtle_name, motion_type, P_dinz_nw, F_dinz_nw, 0, 'noplot', t_fft_dp_dive, depth_dive);
		
		turtle_dive_fft.sub_surface_no_waves.homing(ii).spect_zero_max_accz_nw = spect_zero_max_nw;
		turtle_dive_fft.sub_surface_no_waves.homing(ii).freq_spect_zero_max_accz_nw = freq_spect_zero_max_nw;
		turtle_dive_fft.sub_surface_no_waves.homing(ii).spect_lf_max_accz_nw = spect_lf_max_nw;
		turtle_dive_fft.sub_surface_no_waves.homing(ii).freq_spect_lf_max_accz_nw = freq_spect_lf_max_nw;
		turtle_dive_fft.sub_surface_no_waves.homing(ii).spect_max_accz_nw = spect_max_nw;
		turtle_dive_fft.sub_surface_no_waves.homing(ii).freq_spect_max_accz_nw = freq_spect_max_nw;
		turtle_dive_fft.sub_surface_no_waves.homing(ii).time_max_accz_nw = T_dinz_nw;
	end
end

%% save struct
new_dive_fft_dataset = 0;

if exist (turtle_dive_fft_name, 'file') == 2
	fprintf([turtle_dive_fft_name, ': dive dataset exists!!! \n'])
	load(turtle_dive_fft_name)
	fprintf([turtle_dive_fft_name, ': dataset loaded \n'])
	ov_to_do = 0;
	
	yn_ans = 0;
	while yn_ans < 1 || yn_ans > 2
		fprintf([turtle_dive_fft_name, ': dataset correctly loaded, do you want to overwrite it? \n'])
		fprintf('1_ yes \n')
		fprintf('2_ no \n')
		yn_ans = input('');
	end
	
	if yn_ans == 1
		ov_to_do = 1;
		fprintf([turtle_dive_fft_name, ': start overwrite \n'])
	elseif yn_ans == 2
		ov_to_do = 0;
		fprintf([turtle_dive_fft_name, ': overwrite operation aborted \n'])
	end
	
else
	fprintf([turtle_dive_fft_name, ': dataset not exists, start making it \n'])
	new_dive_fft_dataset = 1;
end

if new_dive_fft_dataset == 1 || ov_to_do == 1
	turtle_dive_fft_analysis = turtle_dive_fft;
	fprintf([turtle_dive_fft_name, ': saving struct \n'])
	save('turtle_dive_fft_analysis', 'turtle_dive_fft_analysis', '-v7.3');
	fprintf('turtle_dive_fft_analysis.mat saved! \n')
end