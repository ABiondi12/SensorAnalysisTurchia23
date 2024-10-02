% load_stft_data
%
% This script load stft data allocated in a specified .mat file

% if exist(turtle_stft_name, 'file') == 2
% 	turtle_dive_fft = load(turtle_stft_name);
if exist(turtle_dive_fft_name, 'file') == 2
	turtle_dive_fft = load(turtle_dive_fft_name);
else
	errorStruct.message = 'Data file not found.';
	errorStruct.identifier = 'MyFunction:fileNotFound';

	error(errorStruct)
end

%% din

% if exist(turtle_stft_name_din, 'file') == 2
% 	turtle_dive_fft_din = load(turtle_stft_name_din);
if exist(turtle_dive_fft_name_din, 'file') == 2
	turtle_dive_fft_din = load(turtle_dive_fft_name_din);
else
	errorStruct.message = 'Data file not found.';
	errorStruct.identifier = 'MyFunction:fileNotFound';

	error(errorStruct)
end