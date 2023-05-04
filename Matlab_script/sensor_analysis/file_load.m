	% load .csv file on a Matlab table
	raw_data = readtable('raw_data_S1.csv', 'HeaderLines',1);  % skips the first row of data

    sensor_model = 0;
    % sensor selection
    while sensor_model == 0
        % maybe this information can be obtained from the sensor ID
        fprintf('\n Which sensor is? \n')
		fprintf('1: AGM \n');
		fprintf('2: Axy-5 \n');

		sensor_model = input('');

        if sensor_model ~= 1 || sensor_model ~= 2
            sensor_model = 0;
        end
    end

	% time elaboration: from datetime to second
	datatime_h	= table2array(raw_data(:, 2));	% data and time information during data recording
	dt_h		= datatime_h - datatime_h(1);	% relative time w.r.t. first sample, datetime 
	dt_s_h		= seconds(dt_h);				% bring datetime values into elapsed seconds information

	delta_h		= diff(dt_s_h, 1);				% delta t between a sample and the previous one: sample time
	
	% save for each turtles its dt sampling period
	delta_t_hm(2) = mean(delta_h);
	
	% load raw data into structure
	data_raw.datatime		= datatime_h;
	data_raw.time			= dt_s_h;
	data_raw.accx			= table2array(raw_data(:, 3));
	data_raw.accy			= table2array(raw_data(:, 4));
	data_raw.accz			= table2array(raw_data(:, 5));

    if sensor_model == 1        % AGM
	    data_raw.gyrox			= table2array(raw_data(:, 6));
	    data_raw.gyroy			= table2array(raw_data(:, 7));
	    data_raw.gyroz			= table2array(raw_data(:, 8));
	    data_raw.magx			= table2array(raw_data(:, 9));
	    data_raw.magy			= table2array(raw_data(:, 10));
	    data_raw.magz			= table2array(raw_data(:, 11));
	    data_raw.depth			= table2array(raw_data(:, 13));
    elseif sensor_model == 2    % Axy-5
        data_raw.magx			= table2array(raw_data(:, 6));
	    data_raw.magy			= table2array(raw_data(:, 7));
	    data_raw.magz			= table2array(raw_data(:, 8));
    end

	file_data_reor