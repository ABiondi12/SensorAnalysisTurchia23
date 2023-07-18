% dive_analysis_paper
% evaluate dive division - add sunrise and sunset information for paper
% elaboration

if exist('id_plot', 'var') == 0
	id_plot = 1;
end 
dim_font	= 30;
dim_fontb	= 20;
BW = 1;
% total amount of time lasts in big, shallow and sub surface

%% Load structure (commented for now)
% if exist('turtle_dive.mat', 'var') == 0
%	load('turtle_dive.mat')
% end

%% sunrise and sunset
if (exist('sunrise_hour.mat', 'var') == 0) || (exist('sunset_hour.mat', 'var') == 0)
	if (exist('sunrise_hour.mat', 'file') == 2) && (exist('sunset_hour.mat', 'file') == 2)
		load('sunrise_hour.mat')
		load('sunset_hour.mat')
	else
		sunrise_sunset_hour
	end
end

[total_amount_day, total_amount_night] = day_night_amount(datetime_acc, sunrise_hour, sunset_hour);

%% big_dive
	%% offshore-inshore and day-night evaluation
big_num				= size(turtle_dive.big_dive.homing, 2);
turtle_big_time		= zeros(big_num, 1);
turtle_big_time_i	= datetime.empty(0, 1);
turtle_big_depth	= zeros(big_num, 1);
dive_type_tot		= string.empty(0, 1);
off_in_shore		= datetime(2023, 06, 02, 12, 00, 38, 000);  % per ora è indicativo

% total amount of dives divided by type
count_s = 0;
time_s	 = 0;
count_u = 0;
time_u	 = 0;
count_v = 0;
time_v	 = 0;
count_m = 0;
time_m	 = 0;
	
% day counters: to count how many dives happen during the day
count_d	= 0;
time_d	= 0;
count_s_d	= 0;
time_s_d	= 0;
count_u_d	= 0;
time_u_d	= 0;
count_v_d	= 0;
time_v_d	= 0;
count_m_d	= 0;
time_m_d	= 0;

% night counters: to count how many dives happen during the night
count_n	= 0;
time_n	= 0;
count_s_n	= 0;
time_s_n	= 0;
count_u_n	= 0;
time_u_n	= 0;
count_v_n	= 0;
time_v_n	= 0;
count_m_n	= 0;
time_m_n	= 0;

for i = 1:big_num
	turtle_big_depth(i) = min(turtle_dive.big_dive.homing(i).depth);
	turtle_big_time(i)	= seconds(turtle_dive.big_dive.homing(i).datatime(end) - turtle_dive.big_dive.homing(i).datatime(1));
	turtle_big_time_i(i, 1) = turtle_dive.big_dive.homing(i).datatime(1);
	turtle_dive.big_dive.homing(i).duration = turtle_big_time(i);
	dive_type_tot(i, 1)	= turtle_dive.big_dive.homing(i).type;
	dive_type			= turtle_dive.big_dive.homing(i).type;
	
	dive_init_day		= day(turtle_dive.big_dive.homing(i).datatime(1));
	dive_end_day		= day(turtle_dive.big_dive.homing(i).datatime(end));
	dive_init_month		= month(turtle_dive.big_dive.homing(i).datatime(1));
	dive_end_month		= month(turtle_dive.big_dive.homing(i).datatime(end));

	rise_hour	= hour(sunrise_hour);
	set_hour	= hour(sunset_hour);
	rise_min	= minute(sunrise_hour);
	set_min		= minute(sunset_hour);
	rise_sec	= second(sunrise_hour);
	set_sec		= second(sunset_hour);
	
	dive_init_sunrise	= datetime(2023, dive_init_month, dive_init_day, rise_hour, rise_min, rise_sec, 000);
	dive_init_sunset	= datetime(2023, dive_init_month, dive_init_day, set_hour, set_min, set_sec, 000);
	
	dive_end_sunrise	= datetime(2023, dive_end_month, dive_end_day, rise_hour, rise_min, rise_sec, 000);
	dive_end_sunset		= datetime(2023, dive_end_month, dive_end_day, set_hour, set_min, set_sec, 000);

	dive_init			= turtle_dive.big_dive.homing(i).datatime(1);
	dive_end			= turtle_dive.big_dive.homing(i).datatime(end);
	
	if dive_init < off_in_shore
		turtle_dive.big_dive.homing(i).offinshore = "offshore";
	else
		turtle_dive.big_dive.homing(i).offinshore = "inshore";
	end
	
	day_night = day_night_dive(turtle_big_time(i), dive_init, dive_end, dive_init_sunrise, dive_init_sunset, dive_end_sunrise, dive_end_sunset);
	turtle_dive.big_dive.homing(i).daynight = day_night;

	if day_night == "night" % night dive
		count_n	= count_n + 1;
		time_n	= time_n + turtle_big_time(i);
	elseif day_night == "day" % day dive
		count_d	= count_d + 1;
		time_d	= time_d + turtle_big_time(i);
	else
		fprintf('error in dive day-night evaluation \n')
	end
				
	switch dive_type
		case 's'
			% s shape dive
			count_s = count_s + 1;
			time_s	= time_s + turtle_big_time(i);
			
			if day_night == "night" % night dive
				count_s_n	= count_s_n + 1;
				time_s_n	= time_s_n + turtle_big_time(i);
			elseif day_night == "day" % day dive
				count_s_d	= count_s_d + 1;
				time_s_d	= time_s_d + turtle_big_time(i);
			end
			
		case 'u'
			% u shape dive
			count_u = count_u + 1;
			time_u	= time_u + turtle_big_time(i);
			
			if day_night == "night" % night dive 
				count_u_n	= count_u_n + 1;
				time_u_n	= time_u_n + turtle_big_time(i);
			elseif day_night == "day" % day dive
				count_u_d	= count_u_d + 1;
				time_u_d	= time_u_d + turtle_big_time(i);
			end
			
		case 'v'
			% v shape dive
			count_v = count_v + 1;
			time_v	= time_v + turtle_big_time(i);
			
			if day_night == "night" % night dive
				count_v_n	= count_v_n + 1;
				time_v_n	= time_v_n + turtle_big_time(i);
			elseif day_night == "day" % day dive
				count_v_d	= count_v_d + 1;
				time_v_d	= time_v_d + turtle_big_time(i);
			end
			
		otherwise
			% mixed shape dive
			count_m = count_m + 1;
			time_m	= time_m + turtle_big_time(i);
			
			if day_night == "night" % night dive
				count_m_n	= count_m_n + 1;
				time_m_n	= time_m_n + turtle_big_time(i);
			elseif day_night == "day" % day dive
				count_m_d	= count_m_d + 1;
				time_m_d	= time_m_d + turtle_big_time(i);
			end
			
	end
end

[day_id, night_id, offshore_id, inshore_id, off_day_id, off_night_id, in_day_id, in_night_id] = find_id_day_shore(turtle_dive.big_dive.homing); 
	%% time statistics
turtle_big_time_tot	= sum(turtle_big_time);			% 1.952069999999999e+04
turtle_big_time_max	= max(turtle_big_time);			% 1.952069999999999e+04
turtle_big_time_mean	= mean(turtle_big_time);	
turtle_big_time_std	= std(turtle_big_time);	
turtle_big_time_range	= range(turtle_big_time);	
turtle_big_time_med	= median(turtle_big_time);	
turtle_big_time_quart  = quantile(turtle_big_time, [.25 .50 .75]); % the quartiles of x

turtle_big_time_tot_d	= time_d;
turtle_big_time_tot_n	= time_n;

time_s = time_s/count_s;	% mean time of s dive
time_u = time_u/count_u;	% mean time of u dive
time_v = time_v/count_v;	% mean time of v dive
time_m = time_m/count_m;	% mean time of m dive

turtle_big_time_tot_day	= sum(turtle_big_time(day_id));			% 1.952069999999999e+04
turtle_big_time_max_day	= max(turtle_big_time(day_id));			% 1.952069999999999e+04
turtle_big_time_mean_day	= mean(turtle_big_time(day_id));	
turtle_big_time_std_day	= std(turtle_big_time(day_id));	
turtle_big_time_range_day	= range(turtle_big_time(day_id));	
turtle_big_time_med_day	= median(turtle_big_time(day_id));	
turtle_big_time_quart_day  = quantile(turtle_big_time(day_id), [.25 .50 .75]); % the quartiles of x

turtle_big_time_tot_night	= sum(turtle_big_time(night_id));			% 1.952069999999999e+04
turtle_big_time_max_night	= max(turtle_big_time(night_id));			% 1.952069999999999e+04
turtle_big_time_mean_night	= mean(turtle_big_time(night_id));	
turtle_big_time_std_night	= std(turtle_big_time(night_id));	
turtle_big_time_range_night	= range(turtle_big_time(night_id));	
turtle_big_time_med_night	= median(turtle_big_time(night_id));	
turtle_big_time_quart_night  = quantile(turtle_big_time(night_id), [.25 .50 .75]); % the quartiles of x

turtle_big_time_tot_off	= sum(turtle_big_time(offshore_id));			% 1.952069999999999e+04
turtle_big_time_max_off	= max(turtle_big_time(offshore_id));			% 1.952069999999999e+04
turtle_big_time_mean_off	= mean(turtle_big_time(offshore_id));	
turtle_big_time_std_off	= std(turtle_big_time(offshore_id));	
turtle_big_time_range_off	= range(turtle_big_time(offshore_id));	
turtle_big_time_med_off	= median(turtle_big_time(offshore_id));	
turtle_big_time_quart_off  = quantile(turtle_big_time(offshore_id), [.25 .50 .75]); % the quartiles of x

turtle_big_time_tot_in			= sum(turtle_big_time(inshore_id));			% 1.952069999999999e+04
turtle_big_time_max_in			= max(turtle_big_time(inshore_id));			% 1.952069999999999e+04
turtle_big_time_mean_in			= mean(turtle_big_time(inshore_id));	
turtle_big_time_std_in			= std(turtle_big_time(inshore_id));	
turtle_big_time_range_in		= range(turtle_big_time(inshore_id));	
turtle_big_time_med_in			= median(turtle_big_time(inshore_id));	
turtle_big_time_quart_in		= quantile(turtle_big_time(inshore_id), [.25 .50 .75]); % the quartiles of x

turtle_big_time_tot_off_day		= sum(turtle_big_time(off_day_id));			% 1.952069999999999e+04
turtle_big_time_max_off_day		= max(turtle_big_time(off_day_id));			% 1.952069999999999e+04
turtle_big_time_mean_off_day	= mean(turtle_big_time(off_day_id));	
turtle_big_time_std_off_day		= std(turtle_big_time(off_day_id));	
turtle_big_time_range_off_day	= range(turtle_big_time(off_day_id));	
turtle_big_time_med_off_day		= median(turtle_big_time(off_day_id));	
turtle_big_time_quart_off_day	= quantile(turtle_big_time(off_day_id), [.25 .50 .75]); % the quartiles of x

turtle_big_time_tot_in_day		= sum(turtle_big_time(in_day_id));			% 1.952069999999999e+04
turtle_big_time_max_in_day		= max(turtle_big_time(in_day_id));			% 1.952069999999999e+04
turtle_big_time_mean_in_day		= mean(turtle_big_time(in_day_id));	
turtle_big_time_std_in_day		= std(turtle_big_time(in_day_id));	
turtle_big_time_range_in_day	= range(turtle_big_time(in_day_id));	
turtle_big_time_med_in_day		= median(turtle_big_time(in_day_id));	
turtle_big_time_quart_in_day	= quantile(turtle_big_time(in_day_id), [.25 .50 .75]); % the quartiles of x

turtle_big_time_tot_off_night	= sum(turtle_big_time(off_night_id));			% 1.952069999999999e+04
turtle_big_time_max_off_night	= max(turtle_big_time(off_night_id));			% 1.952069999999999e+04
turtle_big_time_mean_off_night	= mean(turtle_big_time(off_night_id));	
turtle_big_time_std_off_night	= std(turtle_big_time(off_night_id));	
turtle_big_time_range_off_night	= range(turtle_big_time(off_night_id));	
turtle_big_time_med_off_night	= median(turtle_big_time(off_night_id));	
turtle_big_time_quart_off_night	= quantile(turtle_big_time(off_night_id), [.25 .50 .75]); % the quartiles of x

turtle_big_time_tot_in_night		= sum(turtle_big_time(in_night_id));			% 1.952069999999999e+04
turtle_big_time_max_in_night		= max(turtle_big_time(in_night_id));			% 1.952069999999999e+04
turtle_big_time_mean_in_night		= mean(turtle_big_time(in_night_id));	
turtle_big_time_std_in_night		= std(turtle_big_time(in_night_id));	
turtle_big_time_range_in_night		= range(turtle_big_time(in_night_id));	
turtle_big_time_med_in_night		= median(turtle_big_time(in_night_id));	
turtle_big_time_quart_in_night		= quantile(turtle_big_time(in_night_id), [.25 .50 .75]); % the quartiles of x
		
	%% depth statistics
turtle_big_depth_max	= min(turtle_big_depth);	
turtle_big_depth_mean	= mean(turtle_big_depth);	
turtle_big_depth_std	= std(turtle_big_depth);	
turtle_big_depth_range	= range(turtle_big_depth);	
turtle_big_depth_med	= median(turtle_big_depth);	
turtle_big_depth_quart = quantile(turtle_big_depth, [.25 .50 .75]); % the quartiles of x

turtle_big_depth_max_day	= min(turtle_big_depth(day_id));	
turtle_big_depth_mean_day	= mean(turtle_big_depth(day_id));	
turtle_big_depth_std_day	= std(turtle_big_depth(day_id));	
turtle_big_depth_range_day	= range(turtle_big_depth(day_id));	
turtle_big_depth_med_day	= median(turtle_big_depth(day_id));	
turtle_big_depth_quart_day = quantile(turtle_big_depth(day_id), [.25 .50 .75]); % the quartiles of x

turtle_big_depth_max_night		= min(turtle_big_depth(night_id));	
turtle_big_depth_tot_night		= sum(turtle_big_depth(night_id));			% 1.952069999999999e+04
turtle_big_depth_mean_night	= mean(turtle_big_depth(night_id));	
turtle_big_depth_std_night		= std(turtle_big_depth(night_id));	
turtle_big_depth_range_night	= range(turtle_big_depth(night_id));	
turtle_big_depth_med_night		= median(turtle_big_depth(night_id));	
turtle_big_depth_quart_night	= quantile(turtle_big_depth(night_id), [.25 .50 .75]); % the quartiles of x

turtle_big_depth_max_off	= min(turtle_big_depth(offshore_id));	
turtle_big_depth_tot_off	= sum(turtle_big_depth(offshore_id));			% 1.952069999999999e+04
turtle_big_depth_mean_off	= mean(turtle_big_depth(offshore_id));	
turtle_big_depth_std_off	= std(turtle_big_depth(offshore_id));	
turtle_big_depth_range_off	= range(turtle_big_depth(offshore_id));	
turtle_big_depth_med_off	= median(turtle_big_depth(offshore_id));	
turtle_big_depth_quart_off = quantile(turtle_big_depth(offshore_id), [.25 .50 .75]); % the quartiles of x

turtle_big_depth_max_in	= min(turtle_big_depth(inshore_id));	
turtle_big_depth_tot_in	= sum(turtle_big_depth(inshore_id));			% 1.952069999999999e+04
turtle_big_depth_mean_in	= mean(turtle_big_depth(inshore_id));	
turtle_big_depth_std_in	= std(turtle_big_depth(inshore_id));	
turtle_big_depth_range_in	= range(turtle_big_depth(inshore_id));	
turtle_big_depth_med_in	= median(turtle_big_depth(inshore_id));	
turtle_big_depth_quart_in	= quantile(turtle_big_depth(inshore_id), [.25 .50 .75]); % the quartiles of x

turtle_big_depth_max_off_day	= min(turtle_big_depth(off_day_id));	
turtle_big_depth_tot_off_day	= sum(turtle_big_depth(off_day_id));			% 1.952069999999999e+04
turtle_big_depth_mean_off_day	= mean(turtle_big_depth(off_day_id));	
turtle_big_depth_std_off_day	= std(turtle_big_depth(off_day_id));	
turtle_big_depth_range_off_day	= range(turtle_big_depth(off_day_id));	
turtle_big_depth_med_off_day	= median(turtle_big_depth(off_day_id));	
turtle_big_depth_quart_off_day = quantile(turtle_big_depth(off_day_id), [.25 .50 .75]); % the quartiles of x

turtle_big_depth_max_in_day	= min(turtle_big_depth(in_day_id));	
turtle_big_depth_tot_in_day	= sum(turtle_big_depth(in_day_id));			% 1.952069999999999e+04
turtle_big_depth_mean_in_day	= mean(turtle_big_depth(in_day_id));	
turtle_big_depth_std_in_day	= std(turtle_big_depth(in_day_id));	
turtle_big_depth_range_in_day	= range(turtle_big_depth(in_day_id));	
turtle_big_depth_med_in_day	= median(turtle_big_depth(in_day_id));	
turtle_big_depth_quart_in_day	= quantile(turtle_big_depth(in_day_id), [.25 .50 .75]); % the quartiles of x

turtle_big_depth_max_off_night		= min(turtle_big_depth(off_night_id));	
turtle_big_depth_tot_off_night		= sum(turtle_big_depth(off_night_id));			% 1.952069999999999e+04
turtle_big_depth_mean_off_night	= mean(turtle_big_depth(off_night_id));	
turtle_big_depth_std_off_night		= std(turtle_big_depth(off_night_id));	
turtle_big_depth_range_off_night	= range(turtle_big_depth(off_night_id));	
turtle_big_depth_med_off_night		= median(turtle_big_depth(off_night_id));	
turtle_big_depth_quart_off_night	= quantile(turtle_big_depth(off_night_id), [.25 .50 .75]); % the quartiles of x

turtle_big_depth_max_in_night		= min(turtle_big_depth(in_night_id));	
turtle_big_depth_tot_in_night		= sum(turtle_big_depth(in_night_id));			% 1.952069999999999e+04
turtle_big_depth_mean_in_night		= mean(turtle_big_depth(in_night_id));	
turtle_big_depth_std_in_night		= std(turtle_big_depth(in_night_id));	
turtle_big_depth_range_in_night	= range(turtle_big_depth(in_night_id));	
turtle_big_depth_med_in_night		= median(turtle_big_depth(in_night_id));	
turtle_big_depth_quart_in_night	= quantile(turtle_big_depth(in_night_id), [.25 .50 .75]); % the quartiles of x

%% shallow dive
	%% offshore-inshore and day-night evaluation
sh_num				= size(turtle_dive.shallow_dive.homing, 2);
turtle_sh_time		= zeros(sh_num, 1);
turtle_sh_time_i	= datetime.empty(0, 1);
turtle_sh_depth	= zeros(sh_num, 1);
turtle_sh_time_tot_d = 0;
turtle_sh_time_tot_n = 0;
count_sh_n = 0;
count_sh_d = 0;

for i = 1:sh_num
	turtle_sh_depth(i) = min(turtle_dive.shallow_dive.homing(i).depth);
	turtle_sh_time(i) = seconds(turtle_dive.shallow_dive.homing(i).datatime(end) - turtle_dive.shallow_dive.homing(i).datatime(1));
	turtle_sh_time_i(i, 1) = turtle_dive.shallow_dive.homing(i).datatime(1);
	turtle_dive.shallow_dive.homing(i).duration = turtle_sh_time(i);
	dive_init_day		= day(turtle_dive.shallow_dive.homing(i).datatime(1));
	dive_end_day		= day(turtle_dive.shallow_dive.homing(i).datatime(end));
	dive_init_month		= month(turtle_dive.shallow_dive.homing(i).datatime(1));
	dive_end_month		= month(turtle_dive.shallow_dive.homing(i).datatime(end));
	
% 	rise_hour	= hour(sunrise_hour(2));
% 	set_hour	= hour(sunset_hour(2));
% 	rise_min	= minute(sunrise_hour(2));
% 	set_min		= minute(sunset_hour(2));
% 	rise_sec	= second(sunrise_hour(2));
% 	set_sec		= second(sunset_hour(2));
	
	dive_init_sunrise	= datetime(2023, dive_init_month, dive_init_day, rise_hour, rise_min, rise_sec, 000);
	dive_init_sunset	= datetime(2023, dive_init_month, dive_init_day, set_hour, set_min, set_sec, 000);
	
	dive_end_sunrise	= datetime(2023, dive_end_month, dive_end_day, rise_hour, rise_min, rise_sec, 000);
	dive_end_sunset		= datetime(2023, dive_end_month, dive_end_day, set_hour, set_min, set_sec, 000);

	dive_init			= turtle_dive.shallow_dive.homing(i).datatime(1);
	dive_end			= turtle_dive.shallow_dive.homing(i).datatime(end);
	
	if dive_init < off_in_shore
		turtle_dive.shallow_dive.homing(i).offinshore = "offshore";
	else
		turtle_dive.shallow_dive.homing(i).offinshore = "inshore";
	end

	day_night = day_night_dive(turtle_sh_time(i), dive_init, dive_end, dive_init_sunrise, dive_init_sunset, dive_end_sunrise, dive_end_sunset);
	turtle_dive.shallow_dive.homing(i).daynight = day_night;

	if day_night == "night" % night dive
		count_sh_n	= count_sh_n + 1;
		turtle_sh_time_tot_n = turtle_sh_time_tot_n + turtle_sh_time(i);
	elseif day_night == "day" % day dive
		count_sh_d	= count_sh_d + 1;
		turtle_sh_time_tot_d = turtle_sh_time_tot_d + turtle_sh_time(i);
	else
		fprintf('error in dive day-night evaluation \n')
	end
	
end

[day_ids, night_ids, offshore_ids, inshore_ids, off_day_ids, off_night_ids, in_day_ids, in_night_ids] = find_id_day_shore(turtle_dive.shallow_dive.homing); 
	%% time statistics
turtle_sh_time_tot		= sum(turtle_sh_time);			% 3.564929999999979e+04
turtle_sh_time_max		= max(turtle_sh_time);			% 1.952069999999999e+04
turtle_sh_time_mean	= mean(turtle_sh_time);	
turtle_sh_time_std		= std(turtle_sh_time);	
turtle_sh_time_range	= range(turtle_sh_time);	
turtle_sh_time_med		= median(turtle_sh_time);	
turtle_sh_time_quart	= quantile(turtle_sh_time, [.25 .50 .75]); % the quartiles of x
	
turtle_sh_time_tot_day	= sum(turtle_sh_time(day_ids));			% 1.952069999999999e+04
turtle_sh_time_max_day	= max(turtle_sh_time(day_ids));			% 1.952069999999999e+04
turtle_sh_time_mean_day	= mean(turtle_sh_time(day_ids));	
turtle_sh_time_std_day	= std(turtle_sh_time(day_ids));	
turtle_sh_time_range_day	= range(turtle_sh_time(day_ids));	
turtle_sh_time_med_day	= median(turtle_sh_time(day_ids));	
turtle_sh_time_quart_day  = quantile(turtle_sh_time(day_ids), [.25 .50 .75]); % the quartiles of x

turtle_sh_time_tot_night	= sum(turtle_sh_time(night_ids));			% 1.952069999999999e+04
turtle_sh_time_max_night	= max(turtle_sh_time(night_ids));			% 1.952069999999999e+04
turtle_sh_time_mean_night	= mean(turtle_sh_time(night_ids));	
turtle_sh_time_std_night	= std(turtle_sh_time(night_ids));	
turtle_sh_time_range_night	= range(turtle_sh_time(night_ids));	
turtle_sh_time_med_night	= median(turtle_sh_time(night_ids));	
turtle_sh_time_quart_night  = quantile(turtle_sh_time(night_ids), [.25 .50 .75]); % the quartiles of x

turtle_sh_time_tot_off	= sum(turtle_sh_time(offshore_ids));			% 1.952069999999999e+04
turtle_sh_time_max_off	= max(turtle_sh_time(offshore_ids));			% 1.952069999999999e+04
turtle_sh_time_mean_off	= mean(turtle_sh_time(offshore_ids));	
turtle_sh_time_std_off	= std(turtle_sh_time(offshore_ids));	
turtle_sh_time_range_off	= range(turtle_sh_time(offshore_ids));	
turtle_sh_time_med_off	= median(turtle_sh_time(offshore_ids));	
turtle_sh_time_quart_off  = quantile(turtle_sh_time(offshore_ids), [.25 .50 .75]); % the quartiles of x

turtle_sh_time_tot_in		= sum(turtle_sh_time(inshore_ids));			% 1.952069999999999e+04
turtle_sh_time_max_in		= max(turtle_sh_time(inshore_ids));			% 1.952069999999999e+04
turtle_sh_time_mean_in	= mean(turtle_sh_time(inshore_ids));	
turtle_sh_time_std_in		= std(turtle_sh_time(inshore_ids));	
turtle_sh_time_range_in	= range(turtle_sh_time(inshore_ids));	
turtle_sh_time_med_in		= median(turtle_sh_time(inshore_ids));	
turtle_sh_time_quart_in	= quantile(turtle_sh_time(inshore_ids), [.25 .50 .75]); % the quartiles of x

turtle_sh_time_tot_off_day	= sum(turtle_sh_time(off_day_ids));			% 1.952069999999999e+04
turtle_sh_time_max_off_day	= max(turtle_sh_time(off_day_ids));			% 1.952069999999999e+04
turtle_sh_time_mean_off_day	= mean(turtle_sh_time(off_day_ids));	
turtle_sh_time_std_off_day	= std(turtle_sh_time(off_day_ids));	
turtle_sh_time_range_off_day	= range(turtle_sh_time(off_day_ids));	
turtle_sh_time_med_off_day	= median(turtle_sh_time(off_day_ids));	
turtle_sh_time_quart_off_day  = quantile(turtle_sh_time(off_day_ids), [.25 .50 .75]); % the quartiles of x

turtle_sh_time_tot_in_day		= sum(turtle_sh_time(in_day_ids));			% 1.952069999999999e+04
turtle_sh_time_max_in_day		= max(turtle_sh_time(in_day_ids));			% 1.952069999999999e+04
turtle_sh_time_mean_in_day	= mean(turtle_sh_time(in_day_ids));	
turtle_sh_time_std_in_day		= std(turtle_sh_time(in_day_ids));	
turtle_sh_time_range_in_day	= range(turtle_sh_time(in_day_ids));	
turtle_sh_time_med_in_day		= median(turtle_sh_time(in_day_ids));	
turtle_sh_time_quart_in_day	= quantile(turtle_sh_time(in_day_ids), [.25 .50 .75]); % the quartiles of x

turtle_sh_time_tot_off_night		= sum(turtle_sh_time(off_night_ids));			% 1.952069999999999e+04
turtle_sh_time_max_off_night		= max(turtle_sh_time(off_night_ids));			% 1.952069999999999e+04
turtle_sh_time_mean_off_night		= mean(turtle_sh_time(off_night_ids));	
turtle_sh_time_std_off_night		= std(turtle_sh_time(off_night_ids));	
turtle_sh_time_range_off_night	= range(turtle_sh_time(off_night_ids));	
turtle_sh_time_med_off_night		= median(turtle_sh_time(off_night_ids));	
turtle_sh_time_quart_off_night	= quantile(turtle_sh_time(off_night_ids), [.25 .50 .75]); % the quartiles of x

turtle_sh_time_tot_in_night		= sum(turtle_sh_time(in_night_ids));			% 1.952069999999999e+04
turtle_sh_time_max_in_night		= max(turtle_sh_time(in_night_ids));			% 1.952069999999999e+04
turtle_sh_time_mean_in_night		= mean(turtle_sh_time(in_night_ids));	
turtle_sh_time_std_in_night		= std(turtle_sh_time(in_night_ids));	
turtle_sh_time_range_in_night		= range(turtle_sh_time(in_night_ids));	
turtle_sh_time_med_in_night		= median(turtle_sh_time(in_night_ids));	
turtle_sh_time_quart_in_night		= quantile(turtle_sh_time(in_night_ids), [.25 .50 .75]); % the quartiles of x
	%% depth statistics
turtle_sh_depth_max	= min(turtle_sh_depth);	
turtle_sh_depth_mean	= mean(turtle_sh_depth);	
turtle_sh_depth_std	= std(turtle_sh_depth);	
turtle_sh_depth_range	= range(turtle_sh_depth);	
turtle_sh_depth_med	= median(turtle_sh_depth);	
turtle_sh_depth_quart = quantile(turtle_sh_depth, [.25 .50 .75]); % the quartiles of x

turtle_sh_depth_max_day	= min(turtle_sh_depth(day_ids));	
turtle_sh_depth_mean_day	= mean(turtle_sh_depth(day_ids));	
turtle_sh_depth_std_day	= std(turtle_sh_depth(day_ids));	
turtle_sh_depth_range_day	= range(turtle_sh_depth(day_ids));	
turtle_sh_depth_med_day	= median(turtle_sh_depth(day_ids));	
turtle_sh_depth_quart_day = quantile(turtle_sh_depth(day_ids), [.25 .50 .75]); % the quartiles of x

turtle_sh_depth_max_night		= min(turtle_sh_depth(night_ids));	
turtle_sh_depth_tot_night		= sum(turtle_sh_depth(night_ids));			% 1.952069999999999e+04
turtle_sh_depth_mean_night	= mean(turtle_sh_depth(night_ids));	
turtle_sh_depth_std_night		= std(turtle_sh_depth(night_ids));	
turtle_sh_depth_range_night	= range(turtle_sh_depth(night_ids));	
turtle_sh_depth_med_night		= median(turtle_sh_depth(night_ids));	
turtle_sh_depth_quart_night	= quantile(turtle_sh_depth(night_ids), [.25 .50 .75]); % the quartiles of x

turtle_sh_depth_max_off	= min(turtle_sh_depth(offshore_ids));	
turtle_sh_depth_tot_off	= sum(turtle_sh_depth(offshore_ids));			% 1.952069999999999e+04
turtle_sh_depth_mean_off	= mean(turtle_sh_depth(offshore_ids));	
turtle_sh_depth_std_off	= std(turtle_sh_depth(offshore_ids));	
turtle_sh_depth_range_off	= range(turtle_sh_depth(offshore_ids));	
turtle_sh_depth_med_off	= median(turtle_sh_depth(offshore_ids));	
turtle_sh_depth_quart_off = quantile(turtle_sh_depth(offshore_ids), [.25 .50 .75]); % the quartiles of x

turtle_sh_depth_max_in	= min(turtle_sh_depth(inshore_ids));	
turtle_sh_depth_tot_in	= sum(turtle_sh_depth(inshore_ids));			% 1.952069999999999e+04
turtle_sh_depth_mean_in	= mean(turtle_sh_depth(inshore_ids));	
turtle_sh_depth_std_in	= std(turtle_sh_depth(inshore_ids));	
turtle_sh_depth_range_in	= range(turtle_sh_depth(inshore_ids));	
turtle_sh_depth_med_in	= median(turtle_sh_depth(inshore_ids));	
turtle_sh_depth_quart_in	= quantile(turtle_sh_depth(inshore_ids), [.25 .50 .75]); % the quartiles of x

turtle_sh_depth_max_off_day	= min(turtle_sh_depth(off_day_ids));	
turtle_sh_depth_tot_off_day	= sum(turtle_sh_depth(off_day_ids));			% 1.952069999999999e+04
turtle_sh_depth_mean_off_day	= mean(turtle_sh_depth(off_day_ids));	
turtle_sh_depth_std_off_day	= std(turtle_sh_depth(off_day_ids));	
turtle_sh_depth_range_off_day	= range(turtle_sh_depth(off_day_ids));	
turtle_sh_depth_med_off_day	= median(turtle_sh_depth(off_day_ids));	
turtle_sh_depth_quart_off_day = quantile(turtle_sh_depth(off_day_ids), [.25 .50 .75]); % the quartiles of x

turtle_sh_depth_max_in_day	= min(turtle_sh_depth(in_day_ids));	
turtle_sh_depth_tot_in_day	= sum(turtle_sh_depth(in_day_ids));			% 1.952069999999999e+04
turtle_sh_depth_mean_in_day	= mean(turtle_sh_depth(in_day_ids));	
turtle_sh_depth_std_in_day	= std(turtle_sh_depth(in_day_ids));	
turtle_sh_depth_range_in_day	= range(turtle_sh_depth(in_day_ids));	
turtle_sh_depth_med_in_day	= median(turtle_sh_depth(in_day_ids));	
turtle_sh_depth_quart_in_day	= quantile(turtle_sh_depth(in_day_ids), [.25 .50 .75]); % the quartiles of x

turtle_sh_depth_max_off_night		= min(turtle_sh_depth(off_night_ids));	
turtle_sh_depth_tot_off_night		= sum(turtle_sh_depth(off_night_ids));			% 1.952069999999999e+04
turtle_sh_depth_mean_off_night	= mean(turtle_sh_depth(off_night_ids));	
turtle_sh_depth_std_off_night		= std(turtle_sh_depth(off_night_ids));	
turtle_sh_depth_range_off_night	= range(turtle_sh_depth(off_night_ids));	
turtle_sh_depth_med_off_night		= median(turtle_sh_depth(off_night_ids));	
turtle_sh_depth_quart_off_night	= quantile(turtle_sh_depth(off_night_ids), [.25 .50 .75]); % the quartiles of x

turtle_sh_depth_max_in_night		= min(turtle_sh_depth(in_night_ids));	
turtle_sh_depth_tot_in_night		= sum(turtle_sh_depth(in_night_ids));			% 1.952069999999999e+04
turtle_sh_depth_mean_in_night		= mean(turtle_sh_depth(in_night_ids));	
turtle_sh_depth_std_in_night		= std(turtle_sh_depth(in_night_ids));	
turtle_sh_depth_range_in_night	= range(turtle_sh_depth(in_night_ids));	
turtle_sh_depth_med_in_night		= median(turtle_sh_depth(in_night_ids));	
turtle_sh_depth_quart_in_night	= quantile(turtle_sh_depth(in_night_ids), [.25 .50 .75]); % the quartiles of x

%% sub surface
	%% offshore-inshore and day-night evaluation
sub_num			= size(turtle_dive.sub_surface.homing, 2);
turtle_sub_time	= zeros(sub_num, 1);
turtle_sub_time_i	= datetime.empty(0, 1);
turtle_sub_depth	= zeros(sub_num, 1);

turtle_sub_time_tot_d_div = 0; % sono quelle che derivano dalla divisione in day e night, ma sono meno precise delle altre 
turtle_sub_time_tot_n_div = 0;	% perché tratti lunghi di sub non vengono divisi, bensì assegnati tutti come day o night
								% anche se sono a cavallo di alba/tramonto.

count_sub_n = 0;
count_sub_d = 0;

for i = 1:sub_num
	turtle_sub_time(i)		= seconds(turtle_dive.sub_surface.homing(i).datatime(end) - turtle_dive.sub_surface.homing(i).datatime(1));
	turtle_sub_time_i(i, 1)	= turtle_dive.sub_surface.homing(i).datatime(1);
	turtle_sub_depth(i)	= min(turtle_dive.sub_surface.homing(i).depth);
	turtle_dive.sub_surface.homing(i).duration = turtle_sub_time(i);

	dive_init_day		= day(turtle_dive.sub_surface.homing(i).datatime(1));
	dive_end_day		= day(turtle_dive.sub_surface.homing(i).datatime(end));
	dive_init_month		= month(turtle_dive.sub_surface.homing(i).datatime(1));
	dive_end_month		= month(turtle_dive.sub_surface.homing(i).datatime(end));
	
	dive_init_sunrise	= datetime(2023, dive_init_month, dive_init_day, rise_hour, rise_min, rise_sec, 000);
	dive_init_sunset	= datetime(2023, dive_init_month, dive_init_day, set_hour, set_min, set_sec, 000);
	
	dive_end_sunrise	= datetime(2023, dive_end_month, dive_end_day, rise_hour, rise_min, rise_sec, 000);
	dive_end_sunset		= datetime(2023, dive_end_month, dive_end_day, set_hour, set_min, set_sec, 000);

	dive_init			= turtle_dive.sub_surface.homing(i).datatime(1);
	dive_end			= turtle_dive.sub_surface.homing(i).datatime(end);
	
	if dive_init < off_in_shore
		turtle_dive.sub_surface.homing(i).offinshore = "offshore";
	else
		turtle_dive.sub_surface.homing(i).offinshore = "inshore";
	end

	day_night = day_night_dive(turtle_sub_time(i), dive_init, dive_end, dive_init_sunrise, dive_init_sunset, dive_end_sunrise, dive_end_sunset);
	turtle_dive.sub_surface.homing(i).daynight = day_night;

	if day_night == "night" % night dive
		count_sub_n	= count_sub_n + 1;
		turtle_sub_time_tot_n_div = turtle_sub_time_tot_n_div + turtle_sub_time(i);
	elseif day_night == "day" % day dive
		count_sub_d	= count_sub_d + 1;
		turtle_sub_time_tot_d_div = turtle_sub_time_tot_d_div + turtle_sub_time(i);
	else
		fprintf('error in dive day-night evaluation \n')
	end

end

turtle_sub_time_tot	= sum(turtle_sub_time);			% 8.881460000000011e+04
turtle_sub_time_mean	= turtle_sub_time_tot/sub_num;	% 1.982468750000002e+02

turtle_sub_time_tot_d	= total_amount_day - turtle_big_time_tot_d - turtle_sh_time_tot_d;
turtle_sub_time_tot_n	= total_amount_night - turtle_big_time_tot_n - turtle_sh_time_tot_n;
	
[day_idsub, night_idsub, offshore_idsub, inshore_idsub, off_day_idsub, off_night_idsub, in_day_idsub, in_night_idsub] = find_id_day_shore(turtle_dive.sub_surface.homing); 
