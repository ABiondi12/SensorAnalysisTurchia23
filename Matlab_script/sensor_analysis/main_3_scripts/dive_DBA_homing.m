% dive_DBA_homing
%
% Dynamic version consist in eliminate the continuous component from big
% dives and shallow dives and the continuous and low components (under
% 0.2Hz) from surface periods, in order to take into account also the
% possible waves effects.

%% general parameters
f_acq	= 10;					% sampling rate (10 sample per second)
dim_1s	= 1 * f_acq;			% number of samples in 1 second
dim_5s = -5 * f_acq;		% provo 1 secondo

%% custom low pass filter
	% custom lowpass FIR filter for data sampled at 10 Hz. The passband-edge
	% frequency is 0.015 Hz. The passband ripple is 0.01 dB and the stopband
	% attenuation is 80 dB. Constrain the filter order to 200.

	N   = 200;
	Fs  = 10;
	Fp  = 0.015; 
	Ap  = 0.01;
	Ast = 80;
	
	Rp  = (10^(Ap/20) - 1)/(10^(Ap/20) + 1);
	Rst = 10^(-Ast/20);
	
	NUM = firceqrip(N,Fp/(Fs/2),[Rp Rst],'passedge');
	fvtool(NUM,'Fs',Fs)
	LP_FIR = dsp.FIRFilter('Numerator',NUM);
	
%% big dive loop
for i = 1 : counter
	a_x = dives_h(i).accx;
	a_y = dives_h(i).accy;
	a_z = dives_h(i).accz;

	%% using current custom lpf 
	a_x_filt = LP_FIR(a_x);
	a_y_filt = LP_FIR(a_y);
	a_z_filt = LP_FIR(a_z);
	
	d_filt_x_B	= a_x - a_x_filt;
	d_filt_y_B	= a_y - a_y_filt;
	d_filt_z_B	= a_z - a_z_filt;
	
	dives_h_din(i).dinx = d_filt_x_B;
	dives_h_din(i).diny = d_filt_y_B;
	dives_h_din(i).dinz = d_filt_z_B;
	
	%% energy indeces: DBA using acc 1 second smoothdata
	[dives_h(i).ODBA, ~, dives_h(i).VeDBA, ~, ~, ~] = energy_indeces(a_x, a_y, a_z, dim_1s);
	
	[dives_h(i).ODBA_paper, ~, ~, ~, ~, ~] = energy_indeces(a_x, a_y, a_z, dim_5s);

	dives_h(i).ODBA_mean	= movmean(dives_h(i).ODBA, dim_1s);
	dives_h(i).ODBA_var		= movvar(dives_h(i).ODBA, dim_1s);
	% dives_h(i).VeDBA_mean	= movmean(dives_h(i).VeDBA, dim_1s);
	% dives_h(i).VeDBA_var	= movvar(dives_h(i).VeDBA, dim_1s);
		
	yaw_rate_grad		= diff(dives_h(i).yaw);		% AVeY
	pitch_rate_grad		= diff(dives_h(i).pitch);	% AVeP
	roll_rate_grad		= diff(dives_h(i).roll);	% AVeR

	% dives_h(i).AAV		= sqrt(yaw_rate_grad.^2 + pitch_rate_grad.^2 + roll_rate_grad.^2);
	% dives_h_din(i).AAV	= dives_h(i).AAV;

	%% energy indeces: DBA using lf homemade acc 1 second smoothdata
	[dives_h_din(i).ODBA, ~, dives_h_din(i).VeDBA, ~, ~, ~] = energy_indeces(d_filt_x_B, d_filt_y_B, d_filt_z_B, dim_1s);
	
	[dives_h_din(i).ODBA_paper, ~, ~, ~, ~, ~] = energy_indeces(d_filt_x_B, d_filt_y_B, d_filt_z_B, dim_5s);

	dives_h_din(i).ODBA_mean	= movmean(dives_h_din(i).ODBA, dim_1s);
	dives_h_din(i).ODBA_var		= movvar(dives_h_din(i).ODBA, dim_1s);
			


%	dives_h(i).AAV		= sqrt(yaw_rate_grad.^2 + pitch_rate_grad.^2 + roll_rate_grad.^2);
%	dives_h_din(i).AAV	= dives_h(i).AAV;

end

%% shallow dive loop
if exist('LP_FIR', 'var') == 0	
	% custom lowpass FIR filter for data sampled at 10 Hz. The passband-edge
	% frequency is 0.015 Hz. The passband ripple is 0.01 dB and the stopband
	% attenuation is 80 dB. Constrain the filter order to 200.
	
	N   = 200;
	Fs  = 10;
	Fp  = 0.015;
	Ap  = 0.01;
	Ast = 80;
	
	Rp  = (10^(Ap/20) - 1)/(10^(Ap/20) + 1);
	Rst = 10^(-Ast/20);
	
	NUM = firceqrip(N,Fp/(Fs/2),[Rp Rst],'passedge');
	fvtool(NUM,'Fs',Fs)
	LP_FIR = dsp.FIRFilter('Numerator',NUM);
end

for i = 1 : sh_counter
	a_x = sdives_h(i).accx;
	a_y = sdives_h(i).accy;
	a_z = sdives_h(i).accz;
	
	a_x_filt = LP_FIR(a_x);
	a_y_filt = LP_FIR(a_y);
	a_z_filt = LP_FIR(a_z);
	
	d_filt_x_B	= a_x - a_x_filt;
	d_filt_y_B	= a_y - a_y_filt;
	d_filt_z_B	= a_z - a_z_filt;
	
	sdives_h_din(i).dinx = d_filt_x_B;
	sdives_h_din(i).diny = d_filt_y_B;
	sdives_h_din(i).dinz = d_filt_z_B;
	
	%% energy indeces: DBA using acc 1 second smoothdata
	[sdives_h(i).ODBA, ~, sdives_h(i).VeDBA, ~, ~, ~] = energy_indeces(a_x, a_y, a_z, dim_1s);

	[sdives_h(i).ODBA_paper, ~, ~, ~, ~, ~] = energy_indeces(a_x, a_y, a_z, dim_5s);

	sdives_h(i).ODBA_mean	= movmean(sdives_h(i).ODBA, dim_1s);
	sdives_h(i).ODBA_var	= movvar(sdives_h(i).ODBA, dim_1s);
	
	yaw_rate_grad		= diff(sdives_h(i).yaw);	% AVeY
	pitch_rate_grad		= diff(sdives_h(i).pitch);	% AVeP
	roll_rate_grad		= diff(sdives_h(i).roll);	% AVeR

	%% energy indeces: DBA using lf homemade acc 1 second smoothdata
	[sdives_h_din(i).ODBA, ~, sdives_h_din(i).VeDBA, ~, ~, ~] = energy_indeces(d_filt_x_B, d_filt_y_B, d_filt_z_B, dim_1s);

	[sdives_h_din(i).ODBA_paper, ~, ~, ~, ~, ~] = energy_indeces(d_filt_x_B, d_filt_y_B, d_filt_z_B, dim_5s);

	sdives_h_din(i).ODBA_mean	= movmean(sdives_h_din(i).ODBA, dim_1s);
	sdives_h_din(i).ODBA_var	= movvar(sdives_h_din(i).ODBA, dim_1s);
	
	yaw_rate_grad		= diff(sdives_h(i).yaw);	% AVeY
	pitch_rate_grad		= diff(sdives_h(i).pitch);	% AVeP
	roll_rate_grad		= diff(sdives_h(i).roll);	% AVeR

	% sdives_h(i).AAV		= sqrt(yaw_rate_grad.^2 + pitch_rate_grad.^2 + roll_rate_grad.^2);
	% sdives_h_din(i).AAV	= sdives_h(i).AAV;
end

%% surf loop
yn_waves = 0;
fprintf('Do you want to also cancel possible waves effect on surface data? \n')
fprintf('1. Yes \n')
fprintf('2. No \n')

while yn_waves < 1 || yn_waves > 2
	yn_waves = input('');
end


if exist('LP_FIR', 'var') == 0
	% custom lowpass FIR filter for data sampled at 10 Hz. The passband-edge
	% frequency is 0.015 Hz. The passband ripple is 0.01 dB and the stopband
	% attenuation is 80 dB. Constrain the filter order to 200.

	N   = 200;
	Fs  = 10;
	Fp  = 0.015; 
	Ap  = 0.01;
	Ast = 80;

	Rp  = (10^(Ap/20) - 1)/(10^(Ap/20) + 1);
	Rst = 10^(-Ast/20);

	NUM = firceqrip(N,Fp/(Fs/2),[Rp Rst],'passedge');
	fvtool(NUM,'Fs',Fs)

	LP_FIR = dsp.FIRFilter('Numerator',NUM);
end	

	% custom lowpass FIR filter for data sampled at 10 Hz. The passband-edge
	% frequency is 0.2 Hz. The passband ripple is 0.01 dB and the stopband
	% attenuation is 80 dB. Constrain the filter order to 200.

if yn_waves == 1
	if exist('LP_FIR_w', 'var') == 0
		Fp_w  = 0.2;

		NUM_w = firceqrip(N,Fp_w/(Fs/2),[Rp Rst],'passedge');
		fvtool(NUM_w,'Fs',Fs)
		LP_FIR_w = dsp.FIRFilter('Numerator',NUM_w);
	end
end

for i = 1 : surf_counter
	a_x = surfs_h(i).accx;
	a_y = surfs_h(i).accy;
	a_z = surfs_h(i).accz;

	if isempty(a_x) == 0
	%% using current custom lpf
		a_x_filt = LP_FIR(a_x);
		a_y_filt = LP_FIR(a_y);
		a_z_filt = LP_FIR(a_z);

		d_filt_x_B	= a_x - a_x_filt;
		d_filt_y_B	= a_y - a_y_filt;
		d_filt_z_B	= a_z - a_z_filt;
		
		surfs_h_din(i).dinx = d_filt_x_B;
		surfs_h_din(i).diny = d_filt_y_B;
		surfs_h_din(i).dinz = d_filt_z_B;
		
	%% using current custom lpf no waves
		if yn_waves == 1
			a_x_filt_din = LP_FIR_w(a_x);
			a_y_filt_din = LP_FIR_w(a_y);
			a_z_filt_din = LP_FIR_w(a_z);

			d_filt_x_B_din	= a_x - a_x_filt_din;
			d_filt_y_B_din	= a_y - a_y_filt_din;
			d_filt_z_B_din	= a_z - a_z_filt_din;

			surfs_h_din(i).dinx_nw = d_filt_x_B_din;
			surfs_h_din(i).diny_nw = d_filt_y_B_din;
			surfs_h_din(i).dinz_nw = d_filt_z_B_din;
		end
		
		%% energy indeces: DBA using acc 1 second smoothdata
		[surfs_h(i).ODBA, ~, surfs_h(i).VeDBA, ~, ~, ~] = energy_indeces(a_x, a_y, a_z, dim_1s);

		surfs_h(i).ODBA_mean	= movmean(surfs_h(i).ODBA, dim_1s);
		surfs_h(i).ODBA_var		= movvar(surfs_h(i).ODBA, dim_1s);
		
		[surfs_h(i).ODBA_paper, ~, ~, ~, ~, ~] = energy_indeces(a_x, a_y, a_z, dim_5s);

	%% energy indeces: DBA using lf custom acc 1 second smoothdata
		[surfs_h_din(i).ODBA, ~, surfs_h_din(i).VeDBA, ~, ~, ~] = energy_indeces(d_filt_x_B, d_filt_y_B, d_filt_z_B, dim_1s);

		surfs_h_din(i).ODBA_mean	= movmean(surfs_h_din(i).ODBA, dim_1s);
		surfs_h_din(i).ODBA_var		= movvar(surfs_h_din(i).ODBA, dim_1s);
		
		[surfs_h_din(i).ODBA_paper, ~, ~, ~, ~, ~] = energy_indeces(d_filt_x_B, d_filt_y_B, d_filt_z_B, dim_5s);

		% cutting also waves components
		[surfs_h_din(i).ODBA_nw, ~, surfs_h_din(i).VeDBA_nw, ~, ~, ~] = energy_indeces(d_filt_x_B_din, d_filt_y_B_din, d_filt_z_B_din, dim_1s);

		surfs_h_din(i).ODBA_mean_nw	= movmean(surfs_h_din(i).ODBA_nw, dim_1s);
		surfs_h_din(i).ODBA_var_nw	= movvar(surfs_h_din(i).ODBA_nw, dim_1s);
		
		[surfs_h_din(i).ODBA_paper_nw, ~, ~, ~, ~, ~] = energy_indeces(d_filt_x_B_din, d_filt_y_B_din, d_filt_z_B_din, dim_5s);

	end
end
