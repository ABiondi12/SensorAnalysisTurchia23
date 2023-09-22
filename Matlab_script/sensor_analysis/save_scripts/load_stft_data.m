% load_stft_data
%
% This script load stft data allocated in a specified .mat file

if exist(turtle_stft_name) == 2
	turtle_dive_fft = load(turtle_stft_name);
else
	errorStruct.message = 'Data file not found.';
	errorStruct.identifier = 'MyFunction:fileNotFound';

	error(errorStruct)
end