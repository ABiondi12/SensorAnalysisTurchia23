% mf_info

%% Local magnetic field extrapulation from online dataset in NED ref. frame

% chosen an indicative point to compute magnetic field, 'time-space'
% variability is very low, so we decides to adopt the same one for
% every turtles and every days. (If necessary, you can select day and
% position from each turtle dataset)

% NOTE: it is necessary to change lat and long values by updating them to
% the correct space coordinates of the release.

% Turchia coordinates

if turtle_nm >= 1 && turtle_nm < 7	% first release
	height		= 0;
	lat			= 36.6060000; % from satellite info about turtles patterns
	long		= 28.8150000; % from satellite info about turtles patterns
	year_calib	= 2023;
	month_calib	= 5;
	day_calib	= 30;
	model		= '2020';
elseif turtle_nm >= 7 && turtle_nm < 10	% second release
	height		= 0;
	lat			= 36.6060000; % from satellite info about turtles patterns
	long		= 28.8150000; % from satellite info about turtles patterns
	year_calib	= 2023;
	month_calib	= 06;
	day_calib	= 26;
	model		= '2020';
end
% local magnetic field from online dataset (NED frame)
% Results have nanoTesla magnitude
%   Output calculated by wrldmagm are:
%   XYZ    :magnetic field vector in nanotesla (nT).
%   H      :horizontal intensity in nanotesla (nT).
%   DEC    :declination in degrees.
%   DIP    :inclination in degrees.
%   F      :total intensity in nanotesla (nT).
[XYZ, H, D, I, F] = wrldmagm(height, lat, long, decyear(year_calib, month_calib, day_calib), model);

% Sensors data have microTesla magnitude, so we bring all measures
% expressed in microTesla by dividing the first one by 1000
XYZ_micro = XYZ./1000;
H_micro = H/1000;		% horizontal plane intensity (magnitude)
F_micro = F/1000;		% total intensity (magnitude)
