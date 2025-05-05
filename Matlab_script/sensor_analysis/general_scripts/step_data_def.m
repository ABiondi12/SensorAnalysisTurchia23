freq_mag		= 0;
freq_gyro		= 0;
freq_depth		= 0;

if release == 3
    auto_freq_selection = 0;
end

if auto_freq_selection == 0

	fprintf("Choose the magnetometer frequency: \n")
	fprintf("1. acc_linked \n")
	fprintf("2. 1 Hz (Turchia 2023) \n")
	fprintf("3. 2 Hz \n")

	while freq_mag <= 0 || freq_mag > 3
		freq_mag = input('');
	end

	if freq_mag == 1
		mag_step = 1;
	elseif freq_mag == 2
		mag_step = 10;
	else
		mag_step = 5;
	end

	% Select frequency for gyroscope
	%	acc = 10 Hz - gyro = 1 Hz for AGM
	fprintf("Choose the gyroscope frequency: \n")
	fprintf("1. acc_linked (Turchia 2023) \n")
	fprintf("2. 1 Hz \n")
	fprintf("3. 2 Hz \n")

	while freq_gyro <= 0 || freq_gyro > 3
		freq_gyro = input('');
	end

	if freq_gyro == 1
		gyro_step = 1;
	elseif freq_gyro == 2
		gyro_step = 10;
	else
		gyro_step = 5;
	end

	% Select frequency for depth
	%	acc = 10 Hz - depth = 1 Hz for AGM
	fprintf("Choose the depth frequency: \n")
	fprintf("1. acc_linked \n")
	fprintf("2. 1 Hz (Turchia 2023) \n")
	fprintf("3. 2 Hz \n")

	while freq_depth <= 0 || freq_depth > 3
		freq_depth = input('');
	end

	if freq_depth == 1
		depth_step = 1;
	elseif freq_depth == 2
		depth_step = 10;
	else
		depth_step = 5;
	end
else
	mag_step = 10;
	gyro_step = 1;
	depth_step = 10;
end