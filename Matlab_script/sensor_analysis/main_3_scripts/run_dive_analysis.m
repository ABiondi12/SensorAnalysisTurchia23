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

% depth margins
thr_sup_h		= -0.5;		% depth over which a possible dive occurs: start dive evaluation
surf_dive_th_sh = -1;		% depth over which a shallow or a big dive occurs
surf_dive_th_h	= -5;		% depth over which a big dive occurs

% sections margins
least_section_length = 1*mag_step;	% at least one second
before_param = 1*mag_step;			% margin before and after a dive -- maybe too much
before_param_plt = 3*mag_step;

% different margin for select a dive
if plt_version == 1
	dive_j_plt	= dive_data;
	sdive_j_plt	= sdive_data;
	sup_j_plt	= sup_data;
	
	dive_j_din_plt	= dive_data_din;
	sdive_j_din_plt	= sdive_data_din;
	sup_j_din_plt	= sup_data_din;

	time_in_id_plt		= 0;
	time_f_id_plt		= 0;

	time_f_id_old_plt	= 1;
end

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

offset_depth_h	= max(turtle_dataset_h); % possible offset evaluation in depth data

for i = 1: size(datetime_acc, 1)-2
	if turtle_dataset_h(i)> thr_sup_h	% while turtle is still in surface
		if turtle_dataset_h(i+1) < thr_sup_h && in_a_dive == 0  % && turtle_dataset_h(i+1)-turtle_dataset_h(i+2) >= thr_dive
			% start dive if depth goes under -0.5m	
			if plt_version == 1 
				time_in_id_plt = i - before_param_plt;
				time_in_plt = datetime_acc(time_in_id_plt);
			end
			
			if i > before_param && (i-before_param) > time_f_id_old + least_section_length				% at least 1 second for each section
				time_in_id	= i-before_param;					% starts dive since it goes underwater, before reaching 0.5m
				time_in		= datetime_acc(i-before_param);		% takes data 1 s before to take into account that turtle
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
				time_f_id	= i+before_param;		
				time_f		= datetime_acc(time_f_id);
				
			else
				time_f_id	= size(datetime_acc, 1);
				time_f		= datetime_acc(time_f_id);
			end
			
			if plt_version == 1
				if i < size(datetime_acc, 1)-before_param_plt
					time_f_id_plt	= i+before_param_plt;		
					time_f_plt		= datetime_acc(time_f_id_plt);

				else
					time_f_id_plt	= size(datetime_acc, 1);
					time_f_plt		= datetime_acc(time_f_id_plt);
				end
			end

			in_a_dive	= 2;
		end
		
		% if turtle is in surface but immediately after been resurfacing
		% from a possible dive:
		
		if in_a_dive == 2
			dive_depth = turtle_dataset_h(time_in_id:time_f_id);
			if plt_version == 1
				dive_depth_plt = turtle_dataset_h(time_in_id_plt:time_f_id_plt);
			end
			
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

					% din version
					sdive_j_din.datatime	= sdive_j.datatime;
					sdive_j_din.datatime_depth	= sdive_j.datatime_depth;
					sdive_j_din.time_in		= sdive_j.time_in;
					sdive_j_din.time_f		= sdive_j.time_f;
					sdive_j_din.depth		= sdive_j.depth;

					sdive_j.yaw		= turtle_dataset_yaw(time_in_id:mag_step:time_f_id);
					sdive_j.pitch	= turtle_dataset_pitch(time_in_id:mag_step:time_f_id);
					sdive_j.roll	= turtle_dataset_roll(time_in_id:mag_step:time_f_id);

					% plt version
					if plt_version == 1
						sdive_j_plt.datatime = datetime_acc(time_in_id_plt:time_f_id_plt);
						sdive_j_plt.datatime_depth = datetime_acc(time_in_id_plt:depth_step:time_f_id_plt);
						sdive_j_plt.time_in	= time_in_plt;
						sdive_j_plt.time_f	= time_f_plt;
						sdive_j_plt.depth	= turtle_dataset_h(time_in_id_plt:depth_step:time_f_id_plt);
						sdive_j_plt.accx	= acc_reor(time_in_id_plt:time_f_id_plt, 1);
						sdive_j_plt.accy	= acc_reor(time_in_id_plt:time_f_id_plt, 2);
						sdive_j_plt.accz	= acc_reor(time_in_id_plt:time_f_id_plt, 3);
						
						% plt version
						sdive_j_din_plt.datatime	= sdive_j_plt.datatime;
						sdive_j_din_plt.datatime_depth	= sdive_j_plt.datatime_depth;
						sdive_j_din_plt.time_in		= sdive_j_plt.time_in;
						sdive_j_din_plt.time_f		= sdive_j_plt.time_f;
						sdive_j_din_plt.depth		= sdive_j_plt.depth;

						sdive_j_plt.yaw		= turtle_dataset_yaw(time_in_id_plt:mag_step:time_f_id_plt);
						sdive_j_plt.pitch	= turtle_dataset_pitch(time_in_id_plt:mag_step:time_f_id_plt);
						sdive_j_plt.roll	= turtle_dataset_roll(time_in_id_plt:mag_step:time_f_id_plt);
					end
					
						
					if sh_counter > 0
						sdives_h = [sdives_h, sdive_j];
						sdives_h_din = [sdives_h_din, sdive_j_din];

						if plt_version == 1
							sdives_h_plt = [sdives_h_plt, sdive_j_plt];
							sdives_h_din_plt = [sdives_h_din_plt, sdive_j_din_plt];
						end
					elseif sh_counter == 0
						sdives_h = sdive_j;
						sdives_h_din = sdive_j_din;
						
						if plt_version == 1
							sdives_h_plt = sdive_j_plt;
							sdives_h_din_plt = sdive_j_din_plt;
						end
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
					
					% din version
					dive_j_din.datatime = dive_j.datatime;
					dive_j_din.datatime_depth = dive_j.datatime_depth;
					dive_j_din.time_in	= dive_j.time_in;
					dive_j_din.time_f	= dive_j.time_f;
					dive_j_din.depth	= dive_j.depth;

					dive_j.yaw		= turtle_dataset_yaw(time_in_id:mag_step:time_f_id);
					dive_j.pitch	= turtle_dataset_pitch(time_in_id:mag_step:time_f_id);
					dive_j.roll		= turtle_dataset_roll(time_in_id:mag_step:time_f_id);
	
					% plt version
					if plt_version == 1
						
						dive_j_plt.datatime = datetime_acc(time_in_id_plt:time_f_id_plt);
						dive_j_plt.datatime_depth = datetime_acc(time_in_id_plt:depth_step:time_f_id_plt);
						dive_j_plt.time_in	= time_in_plt;
						dive_j_plt.time_f	= time_f_plt;
						dive_j_plt.depth	= turtle_dataset_h(time_in_id_plt:depth_step:time_f_id_plt);
						dive_j_plt.accx		= acc_reor(time_in_id_plt:time_f_id_plt, 1);
						dive_j_plt.accy		= acc_reor(time_in_id_plt:time_f_id_plt, 2);
						dive_j_plt.accz		= acc_reor(time_in_id_plt:time_f_id_plt, 3);

						dive_j_din_plt.datatime = dive_j_plt.datatime;
						dive_j_din_plt.datatime_depth = dive_j_plt.datatime_depth;
						dive_j_din_plt.time_in	= dive_j_plt.time_in;
						dive_j_din_plt.time_f	= dive_j_plt.time_f;
						dive_j_din_plt.depth	= dive_j_plt.depth;

						dive_j_plt.yaw		= turtle_dataset_yaw(time_in_id_plt:mag_step:time_f_id_plt);
						dive_j_plt.pitch	= turtle_dataset_pitch(time_in_id_plt:mag_step:time_f_id_plt);
						dive_j_plt.roll		= turtle_dataset_roll(time_in_id_plt:mag_step:time_f_id_plt);
					end
					
					dive_j.type = dive_type;
					dive_j_din.type = dive_type;

					if plt_version == 1
						dive_j_plt.type = dive_type;
						dive_j_din_plt.type = dive_type;
					end
					
					if counter > 0
						dives_h = [dives_h, dive_j];
						dives_h_din = [dives_h_din, dive_j_din];

						if plt_version == 1
							dives_h_plt = [dives_h_plt, dive_j_plt];
							dives_h_din_plt = [dives_h_din_plt, dive_j_din_plt];
						end

					elseif counter == 0
						dives_h = dive_j;
						dives_h_din = dive_j_din;

						if plt_version == 1
							dives_h_plt = dive_j_plt;
							dives_h_din_plt = dive_j_din_plt;
						end

					end
				end
				% save information about period between this dive and the
				% previous one as a surf into the proper struct
				sup_j.datatime	= datetime_acc(time_f_id_old:time_in_id-1);
				sup_j.datatime_depth = datetime_acc(time_f_id_old:depth_step:time_in_id-1);
				sup_j.time_in	= datetime_acc(time_f_id_old);
				sup_j.time_f	= datetime_acc(time_in_id - 1);
				sup_j.depth		= turtle_dataset_h(time_f_id_old:depth_step:time_in_id-1);
				sup_j.accx		= acc_reor(time_f_id_old:time_in_id-1, 1);
				sup_j.accy		= acc_reor(time_f_id_old:time_in_id-1, 2);
				sup_j.accz		= acc_reor(time_f_id_old:time_in_id-1, 3);
	
				% din version
				sup_j_din.datatime	= sup_j.datatime;
				sup_j_din.datatime_depth	= sup_j.datatime_depth;
				sup_j_din.time_in	= sup_j.time_in;
				sup_j_din.time_f	= sup_j.time_f;
				sup_j_din.depth		= sup_j.depth;

				sup_j.yaw	= turtle_dataset_yaw(time_f_id_old:mag_step:time_in_id-1);
				sup_j.pitch = turtle_dataset_pitch(time_f_id_old:mag_step:time_in_id-1);
				sup_j.roll	= turtle_dataset_roll(time_f_id_old:mag_step:time_in_id-1);

				% plot version
				if plt_version == 1
				
					sup_j_plt.datatime	= datetime_acc(time_f_id_old_plt:time_in_id_plt-1);
					sup_j_plt.datatime_depth = datetime_acc(time_f_id_old_plt:depth_step:time_in_id_plt-1);
					sup_j_plt.time_in	= datetime_acc(time_f_id_old_plt);
					sup_j_plt.time_f	= datetime_acc(time_in_id_plt - 1);
					sup_j_plt.depth		= turtle_dataset_h(time_f_id_old_plt:depth_step:time_in_id_plt-1);
					sup_j_plt.accx		= acc_reor(time_f_id_old_plt:time_in_id_plt-1, 1);
					sup_j_plt.accy		= acc_reor(time_f_id_old_plt:time_in_id_plt-1, 2);
					sup_j_plt.accz		= acc_reor(time_f_id_old_plt:time_in_id_plt-1, 3);

					sup_j_din_plt.datatime	= sup_j_plt.datatime;
					sup_j_din_plt.datatime_depth	= sup_j_plt.datatime_depth;
					sup_j_din_plt.time_in	= sup_j_plt.time_in;
					sup_j_din_plt.time_f	= sup_j_plt.time_f;
					sup_j_din_plt.depth		= sup_j_plt.depth;

					sup_j_plt.yaw	= turtle_dataset_yaw(time_f_id_old_plt:mag_step:time_in_id_plt-1);
					sup_j_plt.pitch = turtle_dataset_pitch(time_f_id_old_plt:mag_step:time_in_id_plt-1);
					sup_j_plt.roll	= turtle_dataset_roll(time_f_id_old_plt:mag_step:time_in_id_plt-1);

				end
				
				if surf_counter > 0
					surfs_h = [surfs_h, sup_j];
					surfs_h_din = [surfs_h_din, sup_j_din];

					if plt_version == 1
						surfs_h_plt = [surfs_h_plt, sup_j_plt];
						surfs_h_din_plt = [surfs_h_din_plt, sup_j_din_plt];
					end
					
				elseif surf_counter == 0
					surfs_h = sup_j;
					surfs_h_din = sup_j_din;

					if plt_version == 1
						surfs_h_plt = sup_j_plt;
						surfs_h_din_plt = sup_j_din_plt;
					end
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

			if plt_version == 1
				dive_j_plt		= empty_dive;
				sdive_j_plt		= empty_sdive;
				sup_j_plt		= empty_sup;
				dive_j_din_plt	= empty_dive_din;
				sdive_j_din_plt	= empty_sdive_din;
				sup_j_din_plt	= empty_sup_din;
			end
			
			in_a_dive	= 0;
			time_in_id	= 0;
			time_f_id	= 0;
		end
	end
end

%% prepare struct

turtle_dives = struct('homing', dives_h);
turtle_sdives = struct('homing', sdives_h);
turtle_surfs = struct('homing', surfs_h);

turtle_dives_din = struct('homing', dives_h_din);
turtle_sdives_din = struct('homing', sdives_h_din);
turtle_surfs_din = struct('homing', surfs_h_din);

turtle_dive = struct('name', turtle_name, 'big_dive', turtle_dives, 'shallow_dive', turtle_sdives, 'sub_surface', turtle_surfs);
turtle_dive_din = struct('name', turtle_name, 'big_dive', turtle_dives_din, 'shallow_dive', turtle_sdives_din, 'sub_surface', turtle_surfs_din);

%% prepare struct plot
if plt_version == 1
	turtle_dives_plt = struct('homing', dives_h_plt);
	turtle_sdives_plt = struct('homing', sdives_h_plt);
	turtle_surfs_plt = struct('homing', surfs_h_plt);

	turtle_dives_din_plt = struct('homing', dives_h_din_plt);
	turtle_sdives_din_plt = struct('homing', sdives_h_din_plt);
	turtle_surfs_din_plt = struct('homing', surfs_h_din_plt);

	turtle_dive_plt = struct('name', turtle_name, 'big_dive', turtle_dives_plt, 'shallow_dive', turtle_sdives_plt, 'sub_surface', turtle_surfs_plt);
	turtle_dive_din_plt = struct('name', turtle_name, 'big_dive', turtle_dives_din_plt, 'shallow_dive', turtle_sdives_din_plt, 'sub_surface', turtle_surfs_din_plt);
end

%% ODBA evaluation
% once dive and surf phases have been splitted out into two structs, energy
% indeces will be evaluated over them inside 'dive_DBA_homing'
fprintf('dive ODBA \n')
dive_DBA_homing 
