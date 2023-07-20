% run_dive_analysis
%
% In this script, dives are selected and isolated from the entire dataset
% and the dive struct is so populated, by dividing dives into the three
% categories related to the maximum reached depth (big, shallow, and
% sub-surface dives). For big dives only, there is also the evaluation and
% assignment of a shape to the dive (among s, v, u, m).
%
% Look at the code and at the present comments for the criterion used for
% isolate dives and classify them.
%	
% Depth is used as parameters with which evaluate if turtle is performing a
% dive or a surface swim phase.
%
%	check dive's type: 
%			if max depth do not reach values under -5 meters,
%			it will be clessified as 'not a dive, but a surface
%			pattern', while if depth goes under such a threshold,
%			criteria have been implemented in order to distinguish among
%			U, V, S and M (mixed, if none of the previous kind of dive
%			has been clearly identified about the in-studing dive).		
%
% Dive struct is then created, for the three dive categories, and 
% populated for every dive with information about datetime, time of
% beginning and end, depth profile, acc, mag, gyro, shape of the dive
% (for big dive only)... The struct is then saved with the name 
% "turtle_dive".
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% In this script, it is also computed the ODBA energy index for the entire
% dataset and for each single dive. ODBA computation is performed through
% a call of the script "dive_DBA_homing", which populates both ODBA and 
% ODBA_paper fields. These two fields of the dive struct differ for the 
% window over which it is computed a mean of the value of the energy index.
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% At the end of the script, the structure will be saved as .mat file under
% the name "turtle_dive.mat".
%
% NOTE:
%		dataset that is in use into this script and has to be present:
%			turtle_dataset	= turtle_dive
%
%		Struct that are going to be used during this script's execution
%		in order to build struct containing dive and surf informations:
%		dive_data = struct('datatime', [], 'datatime_depth', [], 'time_in', [], 'time_f', [], 'type', [], 'depth', [], 'accx', [], 'accy', [], 'accz', [], 'yaw', [], 'pitch', [], 'roll', [], 'ODBA', [], 'ODBA_mean', [], 'ODBA_var', [], 'VeDBA', [], 'VeDBA_mean', [], 'VeDBA_var', 'AAV', [], 'offinshore', [], 'daynight', []);
%		sup_data  = struct('datatime', [], 'datatime_depth', [], 'time_in', [], 'time_f', [], 'depth', [], 'accx', [], 'accy', [], 'accz', [], 'yaw', [], 'pitch', [], 'roll', [], 'ODBA', [], 'ODBA_mean', [], 'ODBA_var', [], 'VeDBA', [], 'VeDBA_mean', [], 'VeDBA_var', 'AAV', [], 'offinshore', [], 'daynight', []);

%% parameters
in_a_dive = 0;	% takes into account whether or not we are in a dive

%	= 0 not in a dive
%	= 1 in a dive
%	= 2 just out of a dive, need save procedure exe

% support temporal structures: each of them will hold a single dive or surf
% profiles in terms of time, accelerations, depth, energy indeces...

dive_j	= dive_data;
sdive_j	= sdive_data;
sup_j	= sup_data;

dive_j_din	= dive_data_din;
sdive_j_din	= sdive_data_din;
sup_j_din	= sup_data_din;

% id to split dataset into dives and surfaces phases
time_in_id		= 0;
time_f_id		= 0;
% time_in_id_old	= 1;
time_f_id_old	= 1;

%% homing
counter			= 0;
sh_counter		= 0;
surf_counter	= 0;

% Depth is used as parameters with which evaluate if turtle is performing a
% dive or a surface swim phase

% turtle_dataset_h = depth;
turtle_dataset_h		= zeros(size(depth, 1), size(depth, 2));
turtle_dataset_yaw		= zeros(size(yaw_m_calib, 1), size(yaw_m_calib, 2));
turtle_dataset_pitch	= zeros(size(pitch_calib, 1), size(pitch_calib, 2));
turtle_dataset_roll		= zeros(size(roll_calib, 1), size(roll_calib, 2));

count = 0;
for i = 1:length(depth)
	for j = 1:depth_step
		count = count + 1;
		turtle_dataset_h(count)		= depth(i);
		turtle_dataset_yaw(count)	= yaw_m_calib(i);
		turtle_dataset_pitch(count)	= pitch_calib(i);
		turtle_dataset_roll(count)	= roll_calib(i);
	end
end

thr_sup_h		= -0.5;		% depth over which a possible dive occurs: start dive evaluation
surf_dive_th_sh = -1;		% depth over which a shallow or a big dive occurs
surf_dive_th_h	= -5;		% depth over which a big dive occurs
offset_depth_h	= max(turtle_dataset_h); % possible offset evaluation in depth data

for i = 1: size(datetime_acc, 1)-2
	if turtle_dataset_h(i)> thr_sup_h	% while turtle is still in surface
		if turtle_dataset_h(i+1) < thr_sup_h && in_a_dive == 0  % && turtle_dataset_h(i+1)-turtle_dataset_h(i+2) >= thr_dive
			% start dive if depth goes under -0.5m	
% 			ii = i;
% 			while turtle_dataset_h(ii)< thr_h && ii > time_f_id_old + 5	
% 				ii = ii - 1;
% 			end
% 			time_in_id	= ii;	
% 			time_in		= turtle_dataset.homing.datatime(time_in_id);	% takes data 1 s before to take into account that turtle
			least_section_length = 1*mag_step;	% at least one second
			before_param = 2*mag_step;			% margin before and after a dive
        
			if i > before_param && (i-before_param) > time_f_id_old + least_section_length				% at least 1 second for each section
				time_in		= datetime_acc(i-before_param);		% takes data 1 s before to take into account that turtle -- update: take 5 seconds before
				time_in_id	= i-before_param;							            %	starts dive since it goes underwater, before reaching 0.5m
			else
				if i <= before_param
					time_in_id	= min([i, time_f_id_old + least_section_length]);
				elseif (i-before_param) <= time_f_id_old + least_section_length
					time_in_id	= time_f_id_old + least_section_length;
				end
				time_in	= datetime_acc(time_in_id);
			end
			in_a_dive	= 1;
		end
		
		if i > 2 && time_in_id > 0 && in_a_dive == 1 && turtle_dataset_h(i-1) < thr_sup_h 
			% stop dive if depth comes back over -0.5m ( -0.25m)
			if i < size(datetime_acc, 1)-before_param
				time_f		= datetime_acc(i+before_param);
				time_f_id	= i+before_param;				
			else
				time_f_id	= size(datetime_acc, 1);
				time_f		= datetime_acc(time_f_id);
			end
	
% 			jj = i;
% 			while turtle_dataset_h(jj)< thr_h && jj < size(turtle_dataset.homing.datatime, 1)	
% 				jj = jj + 1;
% 			end
% 			time_f_id	= jj;	
% 			time_f		= turtle_dataset.homing.datatime(time_f_id);	

			in_a_dive	= 2;
		end
		
		% if turtle is in surface but immediately after been resurfacing
		% from a possible dive:
		
		if in_a_dive == 2
			dive_depth = turtle_dataset_h(time_in_id:time_f_id);
			dive_type = dive_type_check(dive_depth, surf_dive_th_h, surf_dive_th_sh);
			
			% check dive's type: if max depth do not reach values under -5
			% meters, it will be clessified as 'not a dive, but a surface
			% pattern', while if depth goes under such a threshold,
			% criteria have been implemented in order to distinguish among
			% U, V, S and M (mixed, if none of the previous kind of dive
			% has been clearly identified about the in-studing dive)
			
			
			if dive_type ~= 'n'			% it is a dive
				if dive_type == 'p'
					% shallow dive
					sdive_j.datatime = datetime_acc(time_in_id:time_f_id);
					sdive_j.datatime_depth = datetime_acc(time_in_id:depth_step:time_f_id);
					sdive_j.time_in	= time_in;
					sdive_j.time_f	= time_f;
					sdive_j.depth	= turtle_dataset_h(time_in_id:depth_step:time_f_id);
					sdive_j.accx	= acc_reor(time_in_id:time_f_id, 1);
					sdive_j.accy	= acc_reor(time_in_id:time_f_id, 2);
					sdive_j.accz	= acc_reor(time_in_id:time_f_id, 3);

					% sdive_j_din.datatime	= sdive_j.datatime;
					% sdive_j_din.time_in	= sdive_j.time_in;
					% sdive_j_din.time_f	= sdive_j.time_f;
					% sdive_j_din.depth		= sdive_j.depth;

					sdive_j.yaw		= turtle_dataset_yaw(time_in_id:mag_step:time_f_id);
					sdive_j.pitch	= turtle_dataset_pitch(time_in_id:mag_step:time_f_id);
					sdive_j.roll	= turtle_dataset_roll(time_in_id:mag_step:time_f_id);

						% sdive_j_din.yaw		= sdive_j.yaw;
						% sdive_j_din.pitch	= sdive_j.pitch;
						% sdive_j_din.roll	= sdive_j.roll;		

					if sh_counter > 0
						sdives_h = [sdives_h, sdive_j];
						% sdives_h_din = [sdives_h_din, sdive_j_din];

					elseif sh_counter == 0
						sdives_h = sdive_j;
						% sdives_h_din = sdive_j_din;
					end
				else					
					dive_j.datatime = datetime_acc(time_in_id:time_f_id);
					dive_j.datatime_depth = datetime_acc(time_in_id:depth_step:time_f_id);
					dive_j.time_in	= time_in;
					dive_j.time_f	= time_f;
					dive_j.depth	= turtle_dataset_h(time_in_id:depth_step:time_f_id);
					dive_j.accx		= acc_reor(time_in_id:time_f_id, 1);
					dive_j.accy		= acc_reor(time_in_id:time_f_id, 2);
					dive_j.accz		= acc_reor(time_in_id:time_f_id, 3);

					% dive_j_din.datatime = dive_j.datatime;
					% dive_j_din.time_in	= dive_j.time_in;
					% dive_j_din.time_f	= dive_j.time_f;
					% dive_j_din.depth	= dive_j.depth;

					dive_j.yaw		= turtle_dataset_yaw(time_in_id:mag_step:time_f_id);
					dive_j.pitch	= turtle_dataset_pitch(time_in_id:mag_step:time_f_id);
					dive_j.roll		= turtle_dataset_roll(time_in_id:mag_step:time_f_id);

					% dive_j_din.yaw		= dive_j.yaw;
					% dive_j_din.pitch	= dive_j.pitch;
					% dive_j_din.roll		= dive_j.roll;		
					
					dive_j.type = dive_type;
					% dive_j_din.type = dive_type;

					if counter > 0
						dives_h = [dives_h, dive_j];
						% dives_h_din = [dives_h_din, dive_j_din];

					elseif counter == 0
						dives_h = dive_j;
						% dives_h_din = dive_j_din;
					end
				end
				% save information about period between this dive and the
				% previous one as a surf into the proper struct
				sup_j.datatime	= datetime_acc(time_f_id_old:time_in_id-1);
				sup_j.datatime_depth = datetime_acc(time_f_id_old:depth_step:time_in_id-1);
				sup_j.time_in	= datetime_acc(time_f_id_old);
				sup_j.time_f	= datetime_acc(time_in_id - 1);
% 				sup_j.time_in	= time_in;
% 				sup_j.time_f	= time_f;
				sup_j.depth		= turtle_dataset_h(time_f_id_old:depth_step:time_in_id-1);
				sup_j.accx		= acc_reor(time_f_id_old:time_in_id-1, 1);
				sup_j.accy		= acc_reor(time_f_id_old:time_in_id-1, 2);
				sup_j.accz		= acc_reor(time_f_id_old:time_in_id-1, 3);

				% sup_j_din.datatime	= sup_j.datatime;
				% sup_j_din.time_in	= sup_j.time_in;
				% sup_j_din.time_f	= sup_j.time_f;
				% sup_j_din.depth		= sup_j.depth;

				sup_j.yaw	= turtle_dataset_yaw(time_f_id_old:mag_step:time_in_id-1);
				sup_j.pitch = turtle_dataset_pitch(time_f_id_old:mag_step:time_in_id-1);
				sup_j.roll	= turtle_dataset_roll(time_f_id_old:mag_step:time_in_id-1);

					% sup_j_din.yaw	= sup_j.yaw;
					% sup_j_din.pitch	= sup_j.pitch;
					% sup_j_din.roll	= sup_j.roll;

				if surf_counter > 0
					surfs_h = [surfs_h, sup_j];
					surfs_h_din = [surfs_h_din, sup_j_din];
				elseif surf_counter == 0
					surfs_h = sup_j;
					surfs_h_din = sup_j_din;
				end

				% save last dive instant of time to be used as the first
				% one of the surf phase between this dive and the next one
				time_f_id_old		= time_f_id;
				if dive_type == 'p'
					sh_counter	= sh_counter + 1;						
				else
					counter		= counter + 1;
				end
				surf_counter = surf_counter + 1;
			end
			
			% reset variables in order to check for next dives and surfs
			dive_j		= empty_dive;
			sdive_j		= empty_sdive;
			sup_j		= empty_sup;
			dive_j_din	= empty_dive_din;
			sdive_j_din	= empty_sdive_din;
			sup_j_din	= empty_sup_din;
			
			in_a_dive	= 0;
			time_in_id	= 0;
			time_f_id	= 0;
		end
	end
end

%% ODBA evaluation
% once dive and surf phases have been splitted out into two structs, energy
% indeces will be evaluated over them inside 'dive_DBA_homing'
dive_DBA_homing 

%% prepare struct
turtle_nm = 0;
fprintf('Turtle name: \n')
fprintf('1. Melis \n')
fprintf('2. Banu \n')
fprintf('3. Fati \n')
fprintf('4. Emine \n')

while turtle_nm <= 0 || turtle_nm > 4
	turtle_nm = input('');
end

if turtle_nm == 1
	turtle_name = "Melis";
elseif turtle_nm == 2
	turtle_name = "Banu";
elseif turtle_nm == 3
	turtle_name = "Fati";
elseif turtle_nm == 4
	turtle_name = "Emine";
end

turtle_dives = struct('homing', dives_h);
turtle_sdives = struct('homing', sdives_h);
turtle_surfs = struct('homing', surfs_h);
turtle_surfs_din = struct('homing', surfs_h_din);

% turtle_dives_din = struct('homing', dives_h_din);
% turtle_sdives_din = struct('homing', sdives_h_din);

turtle_dive = struct('name', turtle_name, 'big_dive', turtle_dives, 'shallow_dive', turtle_sdives, 'sub_surface', turtle_surfs, 'sub_surface_no_waves', turtle_surfs_din);
% turtle_dive_din = struct('name', turtle_dataset.name, 'big_dive', turtle_dives_din, 'shallow_dive', turtle_sdives_din, 'sub_surface', turtle_surfs_din);

%% save struct
new_dive_dataset = 0;

if exist (turtle_dive_name, 'file') == 2
	fprintf([turtle_dive_name,': dataset exists!!! \n'])
%	load(turtle_dive_name)
	fprintf([turtle_dive_name, ': dataset loaded \n'])
	ov_to_do = 0;
	
	yn_ans = 0;
	while yn_ans < 1 || yn_ans > 2
		fprintf([turtle_dive_name, ': dataset correctly loaded, do you want to overwrite it? \n'])
		fprintf('1_ yes \n')
		fprintf('2_ no \n')
		yn_ans = input('');
	end
	
	if yn_ans == 1
		ov_to_do = 1;
		fprintf([turtle_dive_name, ': start overwrite \n'])
	elseif yn_ans == 2
		ov_to_do = 0;
		fprintf([turtle_dive_name, ': overwrite operation aborted \n'])
	end
	
else
	fprintf([turtle_dive_name, ': dataset not exists, start making it \n'])
	new_dive_dataset = 1;
end

if new_dive_dataset == 1 || ov_to_do == 1
	turtle_dive_dataset = turtle_dive;
	fprintf([turtle_dive_name, ': saving struct \n'])
	save('turtle_dive', 'turtle_dive', '-v7.3');
	fprintf('turtle_dive.mat saved! \n')
end

%% save struct din
%{
new_dive_dataset_din = 0;

if exist (turtle_dive_name_din, 'file') == 2
	fprintf([turtle_dive_name_din,': dataset exists!!! \n'])
	load(turtle_dive_name_din)
	fprintf([turtle_dive_name_din, ': dataset loaded \n'])
	ov_to_do = 0;
	
	yn_ans = 0;
	while yn_ans < 1 || yn_ans > 2
		fprintf([turtle_dive_name_din, ': dataset correctly loaded, do you want to overwrite it? \n'])
		fprintf('1_ yes \n')
		fprintf('2_ no \n')
		yn_ans = input('');
	end
	
	if yn_ans == 1
		ov_to_do = 1;
		fprintf([turtle_dive_name_din, ': start overwrite \n'])
	elseif yn_ans == 2
		ov_to_do = 0;
		fprintf([turtle_dive_name_din, ': overwrite operation aborted \n'])
	end
	
else
	fprintf([turtle_dive_name_din, ': dataset not exists, start making it \n'])
	new_dive_dataset_din = 1;
end
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
