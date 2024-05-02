% custom_LPF

% custom lowpass FIR filter for data sampled at 10 Hz. The passband-edge
% frequency is 0.015 Hz. The passband ripple is 0.01 dB and the stopband
% attenuation is 80 dB. Constrain the filter order to 200.

N   = 200;
Fs  = 10;
Fp  = 0.015;
Fp_w = 0.2;
Ap  = 0.01;
Ast = 80;

Rp  = (10^(Ap/20) - 1)/(10^(Ap/20) + 1);
Rst = 10^(-Ast/20);

if exist('yn_waves', 'var') == 0 || yn_waves == 0
	NUM = firceqrip(N,Fp/(Fs/2),[Rp Rst],'passedge');
	fvtool(NUM,'Fs',Fs)
	LP_FIR = dsp.FIRFilter('Numerator',NUM);
elseif yn_waves == 1
	NUM_w = firceqrip(N,Fp_w/(Fs/2),[Rp Rst],'passedge');
	fvtool(NUM_w,'Fs',Fs)
	LP_FIR_w = dsp.FIRFilter('Numerator',NUM_w);
end