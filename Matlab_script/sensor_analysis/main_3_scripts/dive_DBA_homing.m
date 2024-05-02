% dive_DBA_homing
%
% Dynamic version consist in eliminate the continuous component from big
% dives and shallow dives and the continuous and low components (under
% 0.2Hz) from surface periods, in order to take into account also the
% possible waves effects.

%% general parameters
f_acq	= 10;					% sampling rate (10 sample per second)
dim_1s	= 1 * f_acq;			% number of samples in 1 second
dim_5s = -5 * f_acq;			% provo 1 secondo

%% custom low pass filter
custom_LPF_filter
	
%% big dive loop
for i = 1 : counter
	a_x = turtle_dive.big_dive.homing(i).accx;
	a_y = turtle_dive.big_dive.homing(i).accy;
	a_z = turtle_dive.big_dive.homing(i).accz;
	
	[d_filt_x_B, d_filt_y_B, d_filt_z_B] = apply_filter(a_x, a_y, a_z, LP_FIR);
	
	turtle_dive_din.big_dive.homing(i).dinx = d_filt_x_B;
	turtle_dive_din.big_dive.homing(i).diny = d_filt_y_B;
	turtle_dive_din.big_dive.homing(i).dinz = d_filt_z_B;
	
	%[d_filt_x_B, d_filt_y_B, d_filt_z_B] = apply_filter(dives_h(i).accx, dives_h(i).accy, dives_h(i).accz, LP_FIR);
	
	% dives_h_din(i).dinx = d_filt_x_B;
	% dives_h_din(i).diny = d_filt_y_B;
	% dives_h_din(i).dinz = d_filt_z_B;
	
	%% energy indeces: DBA using acc 1 second smoothdata
	[turtle_dive.big_dive.homing(i).ODBA, ~, ~, ~, ~, ~] = energy_indeces(a_x, a_y, a_z, dim_1s);
	[turtle_dive.big_dive.homing(i).ODBA_paper, ~, ~, ~, ~, ~] = energy_indeces(a_x, a_y, a_z, dim_5s);
	turtle_dive.big_dive.homing(i).ODBA_mean	= movmean(turtle_dive.big_dive.homing(i).ODBA, dim_1s);
	turtle_dive.big_dive.homing(i).ODBA_var		= movvar(turtle_dive.big_dive.homing(i).ODBA, dim_1s);
	
	% [dives_h(i).ODBA, ~, ~, ~, ~, ~] = energy_indeces(a_x, a_y, a_z, dim_1s);
	% [dives_h(i).ODBA_paper, ~, ~, ~, ~, ~] = energy_indeces(a_x, a_y, a_z, dim_5s);
	% dives_h(i).ODBA_mean	= movmean(dives_h(i).ODBA, dim_1s);
	% dives_h(i).ODBA_var		= movvar(dives_h(i).ODBA, dim_1s);
		
	%% energy indeces: DBA using lf homemade acc 1 second smoothdata
	[turtle_dive_din.big_dive.homing(i).ODBA, ~, ~, ~, ~, ~] = energy_indeces(d_filt_x_B, d_filt_y_B, d_filt_z_B, dim_1s);
	[turtle_dive_din.big_dive.homing(i).ODBA_paper, ~, ~, ~, ~, ~] = energy_indeces(d_filt_x_B, d_filt_y_B, d_filt_z_B, dim_5s);
	turtle_dive_din.big_dive.homing(i).ODBA_mean	= movmean(turtle_dive_din.big_dive.homing(i).ODBA, dim_1s);
	turtle_dive_din.big_dive.homing(i).ODBA_var		= movvar(turtle_dive_din.big_dive.homing(i).ODBA, dim_1s);

	% [dives_h_din(i).ODBA, ~, dives_h_din(i).VeDBA, ~, ~, ~] = energy_indeces(d_filt_x_B, d_filt_y_B, d_filt_z_B, dim_1s);
	% [dives_h_din(i).ODBA_paper, ~, ~, ~, ~, ~] = energy_indeces(d_filt_x_B, d_filt_y_B, d_filt_z_B, dim_5s);
	% dives_h_din(i).ODBA_mean	= movmean(dives_h_din(i).ODBA, dim_1s);
	% dives_h_din(i).ODBA_var		= movvar(dives_h_din(i).ODBA, dim_1s);

end

%% shallow dive loop
if exist('LP_FIR', 'var') == 0	
	% custom lowpass FIR filter for data sampled at 10 Hz. The passband-edge
	% frequency is 0.015 Hz. The passband ripple is 0.01 dB and the stopband
	% attenuation is 80 dB. Constrain the filter order to 200.
	
	custom_LPF_filter
end

for i = 1 : sh_counter
	a_x = turtle_dive.shallow_dive.homing(i).accx;
	a_y = turtle_dive.shallow_dive.homing(i).accy;
	a_z = turtle_dive.shallow_dive.homing(i).accz;

	[d_filt_x_B, d_filt_y_B, d_filt_z_B] = apply_filter(a_x, a_y, a_z, LP_FIR);
	
	turtle_dive_din.shallow_dive.homing(i).dinx = d_filt_x_B;
	turtle_dive_din.shallow_dive.homing(i).diny = d_filt_y_B;
	turtle_dive_din.shallow_dive.homing(i).dinz = d_filt_z_B;

	% sdives_h_din(i).dinx = d_filt_x_B;
	% sdives_h_din(i).diny = d_filt_y_B;
	% sdives_h_din(i).dinz = d_filt_z_B;
	
	%% energy indeces: DBA using acc 1 second smoothdata
	[turtle_dive.shallow_dive.homing(i).ODBA, ~, ~, ~, ~, ~] = energy_indeces(a_x, a_y, a_z, dim_1s);
	[turtle_dive.shallow_dive.homing(i).ODBA_paper, ~, ~, ~, ~, ~] = energy_indeces(a_x, a_y, a_z, dim_5s);

	turtle_dive.shallow_dive.homing(i).ODBA_mean	= movmean(turtle_dive.shallow_dive.homing(i).ODBA, dim_1s);
	turtle_dive.shallow_dive.homing(i).ODBA_var	= movvar(turtle_dive.shallow_dive.homing(i).ODBA, dim_1s);
	
	% [sdives_h(i).ODBA, ~, ~, ~, ~, ~] = energy_indeces(a_x, a_y, a_z, dim_1s);
	% [sdives_h(i).ODBA_paper, ~, ~, ~, ~, ~] = energy_indeces(a_x, a_y, a_z, dim_5s);

	% sdives_h(i).ODBA_mean	= movmean(sdives_h(i).ODBA, dim_1s);
	% sdives_h(i).ODBA_var	= movvar(sdives_h(i).ODBA, dim_1s);
	
	%% energy indeces: DBA using lf homemade acc 1 second smoothdata
	[turtle_dive_din.shallow_dive.homing(i).ODBA, ~, ~, ~, ~, ~] = energy_indeces(d_filt_x_B, d_filt_y_B, d_filt_z_B, dim_1s);
	[turtle_dive_din.shallow_dive.homing(i).ODBA_paper, ~, ~, ~, ~, ~] = energy_indeces(d_filt_x_B, d_filt_y_B, d_filt_z_B, dim_5s);

	turtle_dive_din.shallow_dive.homing(i).ODBA_mean	= movmean(turtle_dive_din.shallow_dive.homing(i).ODBA, dim_1s);
	turtle_dive_din.shallow_dive.homing(i).ODBA_var	= movvar(turtle_dive_din.shallow_dive.homing(i).ODBA, dim_1s);

	% [sdives_h_din(i).ODBA, ~, ~, ~, ~, ~] = energy_indeces(d_filt_x_B, d_filt_y_B, d_filt_z_B, dim_1s);
	% [sdives_h_din(i).ODBA_paper, ~, ~, ~, ~, ~] = energy_indeces(d_filt_x_B, d_filt_y_B, d_filt_z_B, dim_5s);

	% sdives_h_din(i).ODBA_mean	= movmean(sdives_h_din(i).ODBA, dim_1s);
	% sdives_h_din(i).ODBA_var	= movvar(sdives_h_din(i).ODBA, dim_1s);

end

%% surf loop
yn_waves = 0;
fprintf('Do you want to cancel possible waves effect on surface data? \n')
fprintf('1. Yes \n')
fprintf('2. No \n')

while yn_waves < 1 || yn_waves > 2
	yn_waves = input('');
end


if exist('LP_FIR', 'var') == 0
	% custom lowpass FIR filter for data sampled at 10 Hz. The passband-edge
	% frequency is 0.015 Hz. The passband ripple is 0.01 dB and the stopband
	% attenuation is 80 dB. Constrain the filter order to 200.

	custom_LPF_filter
	
end	

	% custom lowpass FIR filter for data sampled at 10 Hz. The passband-edge
	% frequency is 0.2 Hz. The passband ripple is 0.01 dB and the stopband
	% attenuation is 80 dB. Constrain the filter order to 200.

if yn_waves == 1
	if exist('LP_FIR_w', 'var') == 0
		custom_LPF_filter
	end
end

for i = 1 : surf_counter
	
	if isempty(surfs_h(i).accx) == 0
		a_x = turtle_dive.sub_surface.homing(i).accx;
		a_y = turtle_dive.sub_surface.homing(i).accy;
		a_z = turtle_dive.sub_surface.homing(i).accz;

		[d_filt_x_B, d_filt_y_B, d_filt_z_B] = apply_filter(a_x, a_y, a_z, LP_FIR);
		
		turtle_dive_din.sub_surface.homing(i).dinx = d_filt_x_B;
		turtle_dive_din.sub_surface.homing(i).diny = d_filt_y_B;
		turtle_dive_din.sub_surface.homing(i).dinz = d_filt_z_B;

		% surfs_h_din(i).dinx = d_filt_x_B;
		% surfs_h_din(i).diny = d_filt_y_B;
		% surfs_h_din(i).dinz = d_filt_z_B;
		
	%% using custom lpf no waves
		if yn_waves == 1
			
			[d_filt_x_B_din, d_filt_y_B_din, d_filt_z_B_din] = apply_filter(a_x, a_y, a_z, LP_FIR_w);

			turtle_dive_din.sub_surface.homing(i).dinx_nw = d_filt_x_B_din;
			turtle_dive_din.sub_surface.homing(i).diny_nw = d_filt_y_B_din;
			turtle_dive_din.sub_surface.homing(i).dinz_nw = d_filt_z_B_din;
			
			% surfs_h_din(i).dinx_nw = d_filt_x_B_din;
			% surfs_h_din(i).diny_nw = d_filt_y_B_din;
			% surfs_h_din(i).dinz_nw = d_filt_z_B_din;
		end
		
		%% energy indeces: DBA using acc 1 second smoothdata
		[turtle_dive.sub_surface.homing(i).ODBA, ~, ~, ~, ~, ~] = energy_indeces(a_x, a_y, a_z, dim_1s);
		[turtle_dive.sub_surface.homing(i).ODBA_paper, ~, ~, ~, ~, ~] = energy_indeces(a_x, a_y, a_z, dim_5s);

		turtle_dive.sub_surface.homing(i).ODBA_mean	= movmean(turtle_dive.sub_surface.homing(i).ODBA, dim_1s);
		turtle_dive.sub_surface.homing(i).ODBA_var	= movvar(turtle_dive.sub_surface.homing(i).ODBA, dim_1s);

		% [surfs_h(i).ODBA, ~, ~, ~, ~, ~] = energy_indeces(a_x, a_y, a_z, dim_1s);
		% [surfs_h(i).ODBA_paper, ~, ~, ~, ~, ~] = energy_indeces(a_x, a_y, a_z, dim_5s);

		% surfs_h(i).ODBA_mean	= movmean(surfs_h(i).ODBA, dim_1s);
		% surfs_h(i).ODBA_var		= movvar(surfs_h(i).ODBA, dim_1s);

	%% energy indeces: DBA using lf custom acc 1 second smoothdata
		[turtle_dive_din.sub_surface.homing(i).ODBA, ~, ~, ~, ~, ~] = energy_indeces(d_filt_x_B, d_filt_y_B, d_filt_z_B, dim_1s);
		[turtle_dive_din.sub_surface.homing(i).ODBA_paper, ~, ~, ~, ~, ~] = energy_indeces(d_filt_x_B, d_filt_y_B, d_filt_z_B, dim_5s);

		turtle_dive_din.sub_surface.homing(i).ODBA_mean	= movmean(turtle_dive_din.sub_surface.homing(i).ODBA, dim_1s);
		turtle_dive_din.sub_surface.homing(i).ODBA_var	= movvar(turtle_dive_din.sub_surface.homing(i).ODBA, dim_1s);
		
		% [surfs_h_din(i).ODBA, ~, ~, ~, ~, ~] = energy_indeces(d_filt_x_B, d_filt_y_B, d_filt_z_B, dim_1s);
		% [surfs_h_din(i).ODBA_paper, ~, ~, ~, ~, ~] = energy_indeces(d_filt_x_B, d_filt_y_B, d_filt_z_B, dim_5s);

		% surfs_h_din(i).ODBA_mean	= movmean(surfs_h_din(i).ODBA, dim_1s);
		% surfs_h_din(i).ODBA_var		= movvar(surfs_h_din(i).ODBA, dim_1s);
		
		% cutting also waves components
		[turtle_dive_din.sub_surface.homing(i).ODBA_nw, ~, ~, ~, ~, ~] = energy_indeces(d_filt_x_B_din, d_filt_y_B_din, d_filt_z_B_din, dim_1s);
		[turtle_dive_din.sub_surface.homing(i).ODBA_paper_nw, ~, ~, ~, ~, ~] = energy_indeces(d_filt_x_B_din, d_filt_y_B_din, d_filt_z_B_din, dim_5s);

		turtle_dive_din.sub_surface.homing(i).ODBA_mean_nw	= movmean(turtle_dive_din.sub_surface.homing(i).ODBA_nw, dim_1s);
		turtle_dive_din.sub_surface.homing(i).ODBA_var_nw	= movvar(turtle_dive_din.sub_surface.homing(i).ODBA_nw, dim_1s);
		
		% [surfs_h_din(i).ODBA_nw, ~, ~, ~, ~, ~] = energy_indeces(d_filt_x_B_din, d_filt_y_B_din, d_filt_z_B_din, dim_1s);
		% [surfs_h_din(i).ODBA_paper_nw, ~, ~, ~, ~, ~] = energy_indeces(d_filt_x_B_din, d_filt_y_B_din, d_filt_z_B_din, dim_5s);

		% surfs_h_din(i).ODBA_mean_nw	= movmean(surfs_h_din(i).ODBA_nw, dim_1s);
		% surfs_h_din(i).ODBA_var_nw	= movvar(surfs_h_din(i).ODBA_nw, dim_1s);
		
	end
end
