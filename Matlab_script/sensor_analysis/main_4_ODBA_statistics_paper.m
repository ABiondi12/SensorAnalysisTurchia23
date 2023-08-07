% main_4_ODBA_statistics_paper
%
%	In this script there is the evaluation of ODBA statistics, like:
%		- max
%		- mean
%		- std
%		- range
%		- median
%		- quartile
%
%	among the dives computed by the turtle, grouped into big, shallow and 
%	sub surface. Moreover, only for big dives, the same evaluations are 
%	also performed by keeping into account the different dives shapes. 
%	Finally, again for big dives only, the same statistic parameters are
%	computed for the descent, bottom and ascent phases of the dives.
%
%	Then, the same parameters are finally evaluated for dives grouped also
%	depending on their spatial (offshore-inshore) and temporal (day-night)
%	distributions, and for combinations of the two (off-day, off-night,
%	in-day, in-night). Also with this additional division, the parameters
%	are computed for the various dive phases (descent, bottom, ascent) and
%	by keeping into account only s-shaped dives.

%% evaluate dive division

if exist('id_plot', 'var') == 0
	id_plot = 1;
end 
dim_font	= 30;
dim_fontb	= 20;
BW = 1;
% total amount of time lasts in big, shallow and sub surface

%% Load structure

% if exist('turtle_dive.mat', 'var')  == 0
% 	load('turtle_dive.mat')
% end

% if exist('turtle_DBA_paper.mat', 'var')  == 0
% 	load('turtle_DBA_paper.mat')
% end

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
big_num					= size(turtle_dive.big_dive.homing, 2);
turtle_big_ODBA			= zeros(big_num, 1);
turtle_big_ODBA_bott	= zeros(big_num, 1);
turtle_big_ODBA_asc		= zeros(big_num, 1);
turtle_big_ODBA_disc	= zeros(big_num, 1);
dive_type				= zeros(big_num, 1);

id_s = [];	
id_u = [];	
id_v = [];	
id_m = [];	

[day_id, night_id, offshore_id, inshore_id, off_day_id, off_night_id, in_day_id, in_night_id] = find_id_day_shore(turtle_dive.big_dive.homing); 

for i = 1:big_num
	turtle_big_ODBA(i)		= turtle_DBA_paper.big_dive.homing.ODBA.mean(i);
	turtle_big_ODBA_bott(i)	= turtle_DBA_paper.big_dive.homing.ODBA.bott(i);
	turtle_big_ODBA_asc(i)	= turtle_DBA_paper.big_dive.homing.ODBA.asc(i);
	turtle_big_ODBA_disc(i)	= turtle_DBA_paper.big_dive.homing.ODBA.disc(i);

	dive_type = turtle_dive.big_dive.homing(i).type;
	
	switch dive_type
		case 's'
			id_s = [id_s; i];
		case 'u'
			id_u = [id_u; i];
		case 'v'
			id_v = [id_v; i];
		case 'm'
			id_m = [id_m; i];
	end
end

[offshore_id_s, inshore_id_s, day_id_s, night_id_s, off_day_id_s, off_night_id_s, in_day_id_s, in_night_id_s] = find_id_day_shore_type(id_s, offshore_id, inshore_id, day_id, night_id, off_day_id, off_night_id, in_day_id, in_night_id);

	%% ODBA statistics
% tot
turtle_big_ODBA_max		= max(turtle_big_ODBA);			
turtle_big_ODBA_mean	= mean(turtle_big_ODBA);	
turtle_big_ODBA_std		= std(turtle_big_ODBA);	
turtle_big_ODBA_range	= range(turtle_big_ODBA);	
turtle_big_ODBA_med		= median(turtle_big_ODBA);	
turtle_big_ODBA_quart  = quantile(turtle_big_ODBA, [.25 .50 .75]); % the quartiles of x

% bott
turtle_big_ODBA_max_bott	= max(turtle_big_ODBA_bott);			
turtle_big_ODBA_mean_bott	= mean(turtle_big_ODBA_bott);	
turtle_big_ODBA_std_bott	= std(turtle_big_ODBA_bott);	
turtle_big_ODBA_range_bott	= range(turtle_big_ODBA_bott);	
turtle_big_ODBA_med_bott	= median(turtle_big_ODBA_bott);	
turtle_big_ODBA_quart_bott	= quantile(turtle_big_ODBA_bott, [.25 .50 .75]); % the quartiles of x

% asc
turtle_big_ODBA_max_asc		= max(turtle_big_ODBA_asc);			
turtle_big_ODBA_mean_asc	= mean(turtle_big_ODBA_asc);	
turtle_big_ODBA_std_asc		= std(turtle_big_ODBA_asc);	
turtle_big_ODBA_range_asc	= range(turtle_big_ODBA_asc);	
turtle_big_ODBA_med_asc		= median(turtle_big_ODBA_asc);	
turtle_big_ODBA_quart_asc	= quantile(turtle_big_ODBA_asc, [.25 .50 .75]); % the quartiles of x

% disc
turtle_big_ODBA_max_disc	= max(turtle_big_ODBA_disc);			
turtle_big_ODBA_mean_disc	= mean(turtle_big_ODBA_disc);	
turtle_big_ODBA_std_disc	= std(turtle_big_ODBA_disc);	
turtle_big_ODBA_range_disc	= range(turtle_big_ODBA_disc);	
turtle_big_ODBA_med_disc	= median(turtle_big_ODBA_disc);	
turtle_big_ODBA_quart_disc	= quantile(turtle_big_ODBA_disc, [.25 .50 .75]); % the quartiles of x

	%% ODBA day and night statistics
% entire dive, day
turtle_big_ODBA_max_day		= max(turtle_big_ODBA(day_id));			
turtle_big_ODBA_mean_day	= mean(turtle_big_ODBA(day_id));	
turtle_big_ODBA_std_day		= std(turtle_big_ODBA(day_id));	
turtle_big_ODBA_range_day	= range(turtle_big_ODBA(day_id));	
turtle_big_ODBA_med_day		= median(turtle_big_ODBA(day_id));	
turtle_big_ODBA_quart_day	= quantile(turtle_big_ODBA(day_id), [.25 .50 .75]); % the quartiles of x
% entire dive, night
turtle_big_ODBA_max_night		= max(turtle_big_ODBA(night_id));			
turtle_big_ODBA_mean_night		= mean(turtle_big_ODBA(night_id));	
turtle_big_ODBA_std_night		= std(turtle_big_ODBA(night_id));	
turtle_big_ODBA_range_night		= range(turtle_big_ODBA(night_id));	
turtle_big_ODBA_med_night		= median(turtle_big_ODBA(night_id));	
turtle_big_ODBA_quart_night		= quantile(turtle_big_ODBA(night_id), [.25 .50 .75]); % the quartiles of x

% bottom phase, day
turtle_big_ODBA_max_day_bott	= max(turtle_big_ODBA_bott(day_id));			
turtle_big_ODBA_mean_day_bott	= mean(turtle_big_ODBA_bott(day_id));	
turtle_big_ODBA_std_day_bott	= std(turtle_big_ODBA_bott(day_id));	
turtle_big_ODBA_range_day_bott	= range(turtle_big_ODBA_bott(day_id));	
turtle_big_ODBA_med_day_bott	= median(turtle_big_ODBA_bott(day_id));	
turtle_big_ODBA_quart_day_bott	= quantile(turtle_big_ODBA_bott(day_id), [.25 .50 .75]); % the quartiles of x
% bottom phase, night
turtle_big_ODBA_max_night_bott		= max(turtle_big_ODBA_bott(night_id));			
turtle_big_ODBA_mean_night_bott		= mean(turtle_big_ODBA_bott(night_id));	
turtle_big_ODBA_std_night_bott		= std(turtle_big_ODBA_bott(night_id));	
turtle_big_ODBA_range_night_bott	= range(turtle_big_ODBA_bott(night_id));	
turtle_big_ODBA_med_night_bott		= median(turtle_big_ODBA_bott(night_id));	
turtle_big_ODBA_quart_night_bott	= quantile(turtle_big_ODBA_bott(night_id), [.25 .50 .75]); % the quartiles of x

% ascent phase, day
turtle_big_ODBA_max_day_asc		= max(turtle_big_ODBA_asc(day_id));			
turtle_big_ODBA_mean_day_asc	= mean(turtle_big_ODBA_asc(day_id));	
turtle_big_ODBA_std_day_asc		= std(turtle_big_ODBA_asc(day_id));	
turtle_big_ODBA_range_day_asc	= range(turtle_big_ODBA_asc(day_id));	
turtle_big_ODBA_med_day_asc		= median(turtle_big_ODBA_asc(day_id));	
turtle_big_ODBA_quart_day_asc	= quantile(turtle_big_ODBA_asc(day_id), [.25 .50 .75]); % the quartiles of x
% ascent phase, night
turtle_big_ODBA_max_night_asc	= max(turtle_big_ODBA_asc(night_id));			
turtle_big_ODBA_mean_night_asc	= mean(turtle_big_ODBA_asc(night_id));	
turtle_big_ODBA_std_night_asc	= std(turtle_big_ODBA_asc(night_id));	
turtle_big_ODBA_range_night_asc	= range(turtle_big_ODBA_asc(night_id));	
turtle_big_ODBA_med_night_asc	= median(turtle_big_ODBA_asc(night_id));	
turtle_big_ODBA_quart_night_asc	= quantile(turtle_big_ODBA_asc(night_id), [.25 .50 .75]); % the quartiles of x

% discent phase, day
turtle_big_ODBA_max_day_disc	= max(turtle_big_ODBA_disc(day_id));			
turtle_big_ODBA_mean_day_disc	= mean(turtle_big_ODBA_disc(day_id));	
turtle_big_ODBA_std_day_disc	= std(turtle_big_ODBA_disc(day_id));	
turtle_big_ODBA_range_day_disc	= range(turtle_big_ODBA_disc(day_id));	
turtle_big_ODBA_med_day_disc	= median(turtle_big_ODBA_disc(day_id));	
turtle_big_ODBA_quart_day_disc	= quantile(turtle_big_ODBA_disc(day_id), [.25 .50 .75]); % the quartiles of x
% discent phase, night
turtle_big_ODBA_max_night_disc	= max(turtle_big_ODBA_disc(night_id));			
turtle_big_ODBA_mean_night_disc	= mean(turtle_big_ODBA_disc(night_id));	
turtle_big_ODBA_std_night_disc	= std(turtle_big_ODBA_disc(night_id));	
turtle_big_ODBA_range_night_disc= range(turtle_big_ODBA_disc(night_id));	
turtle_big_ODBA_med_night_disc	= median(turtle_big_ODBA_disc(night_id));	
turtle_big_ODBA_quart_night_disc= quantile(turtle_big_ODBA_disc(night_id), [.25 .50 .75]); % the quartiles of x

	%% ODBA offshore and inshore statistics
% entire dive, offshore
turtle_big_ODBA_max_off		= max(turtle_big_ODBA(offshore_id));			
turtle_big_ODBA_mean_off	= mean(turtle_big_ODBA(offshore_id));	
turtle_big_ODBA_std_off		= std(turtle_big_ODBA(offshore_id));	
turtle_big_ODBA_range_off	= range(turtle_big_ODBA(offshore_id));	
turtle_big_ODBA_med_off		= median(turtle_big_ODBA(offshore_id));	
turtle_big_ODBA_quart_off	= quantile(turtle_big_ODBA(offshore_id), [.25 .50 .75]); % the quartiles of x
% entire dive, inshore
turtle_big_ODBA_max_in		= max(turtle_big_ODBA(inshore_id));			
turtle_big_ODBA_mean_in		= mean(turtle_big_ODBA(inshore_id));	
turtle_big_ODBA_std_in		= std(turtle_big_ODBA(inshore_id));	
turtle_big_ODBA_range_in	= range(turtle_big_ODBA(inshore_id));	
turtle_big_ODBA_med_in		= median(turtle_big_ODBA(inshore_id));	
turtle_big_ODBA_quart_in	= quantile(turtle_big_ODBA(inshore_id), [.25 .50 .75]); % the quartiles of x

% bottom phase, offshore
turtle_big_ODBA_max_off_bott	= max(turtle_big_ODBA_bott(offshore_id));			
turtle_big_ODBA_mean_off_bott	= mean(turtle_big_ODBA_bott(offshore_id));	
turtle_big_ODBA_std_off_bott	= std(turtle_big_ODBA_bott(offshore_id));	
turtle_big_ODBA_range_off_bott	= range(turtle_big_ODBA_bott(offshore_id));	
turtle_big_ODBA_med_off_bott	= median(turtle_big_ODBA_bott(offshore_id));	
turtle_big_ODBA_quart_off_bott	= quantile(turtle_big_ODBA_bott(offshore_id), [.25 .50 .75]); % the quartiles of x
% bottom phase, inshore
turtle_big_ODBA_max_in_bott		= max(turtle_big_ODBA_bott(inshore_id));			
turtle_big_ODBA_mean_in_bott	= mean(turtle_big_ODBA_bott(inshore_id));	
turtle_big_ODBA_std_in_bott		= std(turtle_big_ODBA_bott(inshore_id));	
turtle_big_ODBA_range_in_bott	= range(turtle_big_ODBA_bott(inshore_id));	
turtle_big_ODBA_med_in_bott		= median(turtle_big_ODBA_bott(inshore_id));	
turtle_big_ODBA_quart_in_bott	= quantile(turtle_big_ODBA_bott(inshore_id), [.25 .50 .75]); % the quartiles of x

% ascent phase, offshore
turtle_big_ODBA_max_off_asc		= max(turtle_big_ODBA_asc(offshore_id));			
turtle_big_ODBA_mean_off_asc	= mean(turtle_big_ODBA_asc(offshore_id));	
turtle_big_ODBA_std_off_asc		= std(turtle_big_ODBA_asc(offshore_id));	
turtle_big_ODBA_range_off_asc	= range(turtle_big_ODBA_asc(offshore_id));	
turtle_big_ODBA_med_off_asc		= median(turtle_big_ODBA_asc(offshore_id));	
turtle_big_ODBA_quart_off_asc	= quantile(turtle_big_ODBA_asc(offshore_id), [.25 .50 .75]); % the quartiles of x
% ascent phase, inshore
turtle_big_ODBA_max_in_asc		= max(turtle_big_ODBA_asc(inshore_id));			
turtle_big_ODBA_mean_in_asc		= mean(turtle_big_ODBA_asc(inshore_id));	
turtle_big_ODBA_std_in_asc		= std(turtle_big_ODBA_asc(inshore_id));	
turtle_big_ODBA_range_in_asc	= range(turtle_big_ODBA_asc(inshore_id));	
turtle_big_ODBA_med_in_asc		= median(turtle_big_ODBA_asc(inshore_id));	
turtle_big_ODBA_quart_in_asc	= quantile(turtle_big_ODBA_asc(inshore_id), [.25 .50 .75]); % the quartiles of x

% discent phase, offshore
turtle_big_ODBA_max_off_disc	= max(turtle_big_ODBA_disc(offshore_id));			
turtle_big_ODBA_mean_off_disc	= mean(turtle_big_ODBA_disc(offshore_id));	
turtle_big_ODBA_std_off_disc	= std(turtle_big_ODBA_disc(offshore_id));	
turtle_big_ODBA_range_off_disc	= range(turtle_big_ODBA_disc(offshore_id));	
turtle_big_ODBA_med_off_disc	= median(turtle_big_ODBA_disc(offshore_id));	
turtle_big_ODBA_quart_off_disc	= quantile(turtle_big_ODBA_disc(offshore_id), [.25 .50 .75]); % the quartiles of x
% discent phase, inshore
turtle_big_ODBA_max_in_disc		= max(turtle_big_ODBA_disc(inshore_id));			
turtle_big_ODBA_mean_in_disc	= mean(turtle_big_ODBA_disc(inshore_id));	
turtle_big_ODBA_std_in_disc		= std(turtle_big_ODBA_disc(inshore_id));	
turtle_big_ODBA_range_in_disc	= range(turtle_big_ODBA_disc(inshore_id));	
turtle_big_ODBA_med_in_disc		= median(turtle_big_ODBA_disc(inshore_id));	
turtle_big_ODBA_quart_in_disc	= quantile(turtle_big_ODBA_disc(inshore_id), [.25 .50 .75]); % the quartiles of x

	%% ODBA day-night and offshore-inshore statistics
% tot
turtle_big_ODBA_max_off_day		= max(turtle_big_ODBA(off_day_id));			
turtle_big_ODBA_mean_off_day	= mean(turtle_big_ODBA(off_day_id));	
turtle_big_ODBA_std_off_day		= std(turtle_big_ODBA(off_day_id));	
turtle_big_ODBA_range_off_day	= range(turtle_big_ODBA(off_day_id));	
turtle_big_ODBA_med_off_day		= median(turtle_big_ODBA(off_day_id));	
turtle_big_ODBA_quart_off_day  = quantile(turtle_big_ODBA(off_day_id), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_in_day		= max(turtle_big_ODBA(in_day_id));			
turtle_big_ODBA_mean_in_day		= mean(turtle_big_ODBA(in_day_id));	
turtle_big_ODBA_std_in_day		= std(turtle_big_ODBA(in_day_id));	
turtle_big_ODBA_range_in_day	= range(turtle_big_ODBA(in_day_id));	
turtle_big_ODBA_med_in_day		= median(turtle_big_ODBA(in_day_id));	
turtle_big_ODBA_quart_in_day	= quantile(turtle_big_ODBA(in_day_id), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_off_night	= max(turtle_big_ODBA(off_night_id));			
turtle_big_ODBA_mean_off_night	= mean(turtle_big_ODBA(off_night_id));	
turtle_big_ODBA_std_off_night	= std(turtle_big_ODBA(off_night_id));	
turtle_big_ODBA_range_off_night	= range(turtle_big_ODBA(off_night_id));	
turtle_big_ODBA_med_off_night	= median(turtle_big_ODBA(off_night_id));	
turtle_big_ODBA_quart_off_night	= quantile(turtle_big_ODBA(off_night_id), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_in_night	= max(turtle_big_ODBA(in_night_id));			
turtle_big_ODBA_mean_in_night	= mean(turtle_big_ODBA(in_night_id));	
turtle_big_ODBA_std_in_night	= std(turtle_big_ODBA(in_night_id));	
turtle_big_ODBA_range_in_night	= range(turtle_big_ODBA(in_night_id));	
turtle_big_ODBA_med_in_night	= median(turtle_big_ODBA(in_night_id));	
turtle_big_ODBA_quart_in_night	= quantile(turtle_big_ODBA(in_night_id), [.25 .50 .75]); % the quartiles of x

% bott
turtle_big_ODBA_max_off_day_bott	= max(turtle_big_ODBA_bott(off_day_id));			
turtle_big_ODBA_mean_off_day_bott	= mean(turtle_big_ODBA_bott(off_day_id));	
turtle_big_ODBA_std_off_day_bott	= std(turtle_big_ODBA_bott(off_day_id));	
turtle_big_ODBA_range_off_day_bott	= range(turtle_big_ODBA_bott(off_day_id));	
turtle_big_ODBA_med_off_day_bott	= median(turtle_big_ODBA_bott(off_day_id));	
turtle_big_ODBA_quart_off_day_bott  = quantile(turtle_big_ODBA_bott(off_day_id), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_in_day_bott		= max(turtle_big_ODBA_bott(in_day_id));			
turtle_big_ODBA_mean_in_day_bott	= mean(turtle_big_ODBA_bott(in_day_id));	
turtle_big_ODBA_std_in_day_bott		= std(turtle_big_ODBA_bott(in_day_id));	
turtle_big_ODBA_range_in_day_bott	= range(turtle_big_ODBA_bott(in_day_id));	
turtle_big_ODBA_med_in_day_bott		= median(turtle_big_ODBA_bott(in_day_id));	
turtle_big_ODBA_quart_in_day_bott	= quantile(turtle_big_ODBA_bott(in_day_id), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_off_night_bott		= max(turtle_big_ODBA_bott(off_night_id));			
turtle_big_ODBA_mean_off_night_bott		= mean(turtle_big_ODBA_bott(off_night_id));	
turtle_big_ODBA_std_off_night_bott		= std(turtle_big_ODBA_bott(off_night_id));	
turtle_big_ODBA_range_off_night_bott	= range(turtle_big_ODBA_bott(off_night_id));	
turtle_big_ODBA_med_off_night_bott		= median(turtle_big_ODBA_bott(off_night_id));	
turtle_big_ODBA_quart_off_night_bott	= quantile(turtle_big_ODBA_bott(off_night_id), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_in_night_bott		= max(turtle_big_ODBA_bott(in_night_id));			
turtle_big_ODBA_mean_in_night_bott		= mean(turtle_big_ODBA_bott(in_night_id));	
turtle_big_ODBA_std_in_night_bott		= std(turtle_big_ODBA_bott(in_night_id));	
turtle_big_ODBA_range_in_night_bott		= range(turtle_big_ODBA_bott(in_night_id));	
turtle_big_ODBA_med_in_night_bott		= median(turtle_big_ODBA_bott(in_night_id));	
turtle_big_ODBA_quart_in_night_bott		= quantile(turtle_big_ODBA_bott(in_night_id), [.25 .50 .75]); % the quartiles of x

% asc
turtle_big_ODBA_max_off_day_asc		= max(turtle_big_ODBA_asc(off_day_id));			
turtle_big_ODBA_mean_off_day_asc	= mean(turtle_big_ODBA_asc(off_day_id));	
turtle_big_ODBA_std_off_day_asc		= std(turtle_big_ODBA_asc(off_day_id));	
turtle_big_ODBA_range_off_day_asc	= range(turtle_big_ODBA_asc(off_day_id));	
turtle_big_ODBA_med_off_day_asc		= median(turtle_big_ODBA_asc(off_day_id));	
turtle_big_ODBA_quart_off_day_asc  = quantile(turtle_big_ODBA_asc(off_day_id), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_in_day_asc		= max(turtle_big_ODBA_asc(in_day_id));			
turtle_big_ODBA_mean_in_day_asc		= mean(turtle_big_ODBA_asc(in_day_id));	
turtle_big_ODBA_std_in_day_asc		= std(turtle_big_ODBA_asc(in_day_id));	
turtle_big_ODBA_range_in_day_asc	= range(turtle_big_ODBA_asc(in_day_id));	
turtle_big_ODBA_med_in_day_asc		= median(turtle_big_ODBA_asc(in_day_id));	
turtle_big_ODBA_quart_in_day_asc	= quantile(turtle_big_ODBA_asc(in_day_id), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_off_night_asc	= max(turtle_big_ODBA_asc(off_night_id));			
turtle_big_ODBA_mean_off_night_asc	= mean(turtle_big_ODBA_asc(off_night_id));	
turtle_big_ODBA_std_off_night_asc	= std(turtle_big_ODBA_asc(off_night_id));	
turtle_big_ODBA_range_off_night_asc	= range(turtle_big_ODBA_asc(off_night_id));	
turtle_big_ODBA_med_off_night_asc	= median(turtle_big_ODBA_asc(off_night_id));	
turtle_big_ODBA_quart_off_night_asc	= quantile(turtle_big_ODBA_asc(off_night_id), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_in_night_asc	= max(turtle_big_ODBA_asc(in_night_id));			
turtle_big_ODBA_mean_in_night_asc	= mean(turtle_big_ODBA_asc(in_night_id));	
turtle_big_ODBA_std_in_night_asc	= std(turtle_big_ODBA_asc(in_night_id));	
turtle_big_ODBA_range_in_night_asc	= range(turtle_big_ODBA_asc(in_night_id));	
turtle_big_ODBA_med_in_night_asc	= median(turtle_big_ODBA_asc(in_night_id));	
turtle_big_ODBA_quart_in_night_asc	= quantile(turtle_big_ODBA_asc(in_night_id), [.25 .50 .75]); % the quartiles of x

% disc
turtle_big_ODBA_max_off_day_disc	= max(turtle_big_ODBA_disc(off_day_id));			
turtle_big_ODBA_mean_off_day_disc	= mean(turtle_big_ODBA_disc(off_day_id));	
turtle_big_ODBA_std_off_day_disc	= std(turtle_big_ODBA_disc(off_day_id));	
turtle_big_ODBA_range_off_day_disc	= range(turtle_big_ODBA_disc(off_day_id));	
turtle_big_ODBA_med_off_day_disc	= median(turtle_big_ODBA_disc(off_day_id));	
turtle_big_ODBA_quart_off_day_disc	= quantile(turtle_big_ODBA_disc(off_day_id), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_in_day_disc		= max(turtle_big_ODBA_disc(in_day_id));			
turtle_big_ODBA_mean_in_day_disc	= mean(turtle_big_ODBA_disc(in_day_id));	
turtle_big_ODBA_std_in_day_disc		= std(turtle_big_ODBA_disc(in_day_id));	
turtle_big_ODBA_range_in_day_disc	= range(turtle_big_ODBA_disc(in_day_id));	
turtle_big_ODBA_med_in_day_disc		= median(turtle_big_ODBA_disc(in_day_id));	
turtle_big_ODBA_quart_in_day_disc	= quantile(turtle_big_ODBA_disc(in_day_id), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_off_night_disc	= max(turtle_big_ODBA_disc(off_night_id));			
turtle_big_ODBA_mean_off_night_disc	= mean(turtle_big_ODBA_disc(off_night_id));	
turtle_big_ODBA_std_off_night_disc	= std(turtle_big_ODBA_disc(off_night_id));	
turtle_big_ODBA_range_off_night_disc= range(turtle_big_ODBA_disc(off_night_id));	
turtle_big_ODBA_med_off_night_disc	= median(turtle_big_ODBA_disc(off_night_id));	
turtle_big_ODBA_quart_off_night_disc= quantile(turtle_big_ODBA_disc(off_night_id), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_in_night_disc	= max(turtle_big_ODBA_disc(in_night_id));			
turtle_big_ODBA_mean_in_night_disc	= mean(turtle_big_ODBA_disc(in_night_id));	
turtle_big_ODBA_std_in_night_disc	= std(turtle_big_ODBA_disc(in_night_id));	
turtle_big_ODBA_range_in_night_disc	= range(turtle_big_ODBA_disc(in_night_id));	
turtle_big_ODBA_med_in_night_disc	= median(turtle_big_ODBA_disc(in_night_id));	
turtle_big_ODBA_quart_in_night_disc	= quantile(turtle_big_ODBA_disc(in_night_id), [.25 .50 .75]); % the quartiles of x

	%% ODBA S type statistics
		%% ODBA statistics
% tot
turtle_big_ODBA_max_s	= max(turtle_big_ODBA(id_s));			
turtle_big_ODBA_mean_s	= mean(turtle_big_ODBA(id_s));	
turtle_big_ODBA_std_s	= std(turtle_big_ODBA(id_s));	
turtle_big_ODBA_range_s	= range(turtle_big_ODBA(id_s));	
turtle_big_ODBA_med_s	= median(turtle_big_ODBA(id_s));	
turtle_big_ODBA_quart_s	= quantile(turtle_big_ODBA(id_s), [.25 .50 .75]); % the quartiles of x

% bott
turtle_big_ODBA_max_bott_s	= max(turtle_big_ODBA_bott(id_s));			
turtle_big_ODBA_mean_bott_s	= mean(turtle_big_ODBA_bott(id_s));	
turtle_big_ODBA_std_bott_s	= std(turtle_big_ODBA_bott(id_s));	
turtle_big_ODBA_range_bott_s= range(turtle_big_ODBA_bott(id_s));	
turtle_big_ODBA_med_bott_s	= median(turtle_big_ODBA_bott(id_s));	
turtle_big_ODBA_quart_bott_s= quantile(turtle_big_ODBA_bott(id_s), [.25 .50 .75]); % the quartiles of x

% asc
turtle_big_ODBA_max_asc_s	= max(turtle_big_ODBA_asc(id_s));			
turtle_big_ODBA_mean_asc_s	= mean(turtle_big_ODBA_asc(id_s));	
turtle_big_ODBA_std_asc_s	= std(turtle_big_ODBA_asc(id_s));	
turtle_big_ODBA_range_asc_s	= range(turtle_big_ODBA_asc(id_s));	
turtle_big_ODBA_med_asc_s	= median(turtle_big_ODBA_asc(id_s));	
turtle_big_ODBA_quart_asc_s	= quantile(turtle_big_ODBA_asc(id_s), [.25 .50 .75]); % the quartiles of x

% disc
turtle_big_ODBA_max_disc_s	= max(turtle_big_ODBA_disc(id_s));			
turtle_big_ODBA_mean_disc_s	= mean(turtle_big_ODBA_disc(id_s));	
turtle_big_ODBA_std_disc_s	= std(turtle_big_ODBA_disc(id_s));	
turtle_big_ODBA_range_disc_s= range(turtle_big_ODBA_disc(id_s));	
turtle_big_ODBA_med_disc_s	= median(turtle_big_ODBA_disc(id_s));	
turtle_big_ODBA_quart_disc_s= quantile(turtle_big_ODBA_disc(id_s), [.25 .50 .75]); % the quartiles of x

		%% ODBA day and night statistics
% tot
turtle_big_ODBA_max_day_s	= max(turtle_big_ODBA(day_id_s));			
turtle_big_ODBA_mean_day_s	= mean(turtle_big_ODBA(day_id_s));	
turtle_big_ODBA_std_day_s	= std(turtle_big_ODBA(day_id_s));	
turtle_big_ODBA_range_day_s	= range(turtle_big_ODBA(day_id_s));	
turtle_big_ODBA_med_day_s	= median(turtle_big_ODBA(day_id_s));	
turtle_big_ODBA_quart_day_s	= quantile(turtle_big_ODBA(day_id_s), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_night_s		= max(turtle_big_ODBA(night_id_s));			
turtle_big_ODBA_mean_night_s	= mean(turtle_big_ODBA(night_id_s));	
turtle_big_ODBA_std_night_s		= std(turtle_big_ODBA(night_id_s));	
turtle_big_ODBA_range_night_s	= range(turtle_big_ODBA(night_id_s));	
turtle_big_ODBA_med_night_s		= median(turtle_big_ODBA(night_id_s));	
turtle_big_ODBA_quart_night_s	= quantile(turtle_big_ODBA(night_id_s), [.25 .50 .75]); % the quartiles of x

% bott
turtle_big_ODBA_max_day_bott_s	= max(turtle_big_ODBA_bott(day_id_s));			
turtle_big_ODBA_mean_day_bott_s	= mean(turtle_big_ODBA_bott(day_id_s));	
turtle_big_ODBA_std_day_bott_s	= std(turtle_big_ODBA_bott(day_id_s));	
turtle_big_ODBA_range_day_bott_s= range(turtle_big_ODBA_bott(day_id_s));	
turtle_big_ODBA_med_day_bott_s	= median(turtle_big_ODBA_bott(day_id_s));	
turtle_big_ODBA_quart_day_bott_s= quantile(turtle_big_ODBA_bott(day_id_s), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_night_bott_s	= max(turtle_big_ODBA_bott(night_id_s));			
turtle_big_ODBA_mean_night_bott_s	= mean(turtle_big_ODBA_bott(night_id_s));	
turtle_big_ODBA_std_night_bott_s	= std(turtle_big_ODBA_bott(night_id_s));	
turtle_big_ODBA_range_night_bott_s	= range(turtle_big_ODBA_bott(night_id_s));	
turtle_big_ODBA_med_night_bott_s	= median(turtle_big_ODBA_bott(night_id_s));	
turtle_big_ODBA_quart_night_bott_s	= quantile(turtle_big_ODBA_bott(night_id_s), [.25 .50 .75]); % the quartiles of x

% asc
turtle_big_ODBA_max_day_asc_s	= max(turtle_big_ODBA_asc(day_id_s));			
turtle_big_ODBA_mean_day_asc_s	= mean(turtle_big_ODBA_asc(day_id_s));	
turtle_big_ODBA_std_day_asc_s	= std(turtle_big_ODBA_asc(day_id_s));	
turtle_big_ODBA_range_day_asc_s	= range(turtle_big_ODBA_asc(day_id_s));	
turtle_big_ODBA_med_day_asc_s	= median(turtle_big_ODBA_asc(day_id_s));	
turtle_big_ODBA_quart_day_asc_s	= quantile(turtle_big_ODBA_asc(day_id_s), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_night_asc_s		= max(turtle_big_ODBA_asc(night_id_s));			
turtle_big_ODBA_mean_night_asc_s	= mean(turtle_big_ODBA_asc(night_id_s));	
turtle_big_ODBA_std_night_asc_s		= std(turtle_big_ODBA_asc(night_id_s));	
turtle_big_ODBA_range_night_asc_s	= range(turtle_big_ODBA_asc(night_id_s));	
turtle_big_ODBA_med_night_asc_s		= median(turtle_big_ODBA_asc(night_id_s));	
turtle_big_ODBA_quart_night_asc_s	= quantile(turtle_big_ODBA_asc(night_id_s), [.25 .50 .75]); % the quartiles of x

% disc
turtle_big_ODBA_max_day_disc_s		= max(turtle_big_ODBA_disc(day_id_s));			
turtle_big_ODBA_mean_day_disc_s		= mean(turtle_big_ODBA_disc(day_id_s));	
turtle_big_ODBA_std_day_disc_s		= std(turtle_big_ODBA_disc(day_id_s));	
turtle_big_ODBA_range_day_disc_s	= range(turtle_big_ODBA_disc(day_id_s));	
turtle_big_ODBA_med_day_disc_s		= median(turtle_big_ODBA_disc(day_id_s));	
turtle_big_ODBA_quart_day_disc_s	= quantile(turtle_big_ODBA_disc(day_id_s), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_night_disc_s	= max(turtle_big_ODBA_disc(night_id_s));			
turtle_big_ODBA_mean_night_disc_s	= mean(turtle_big_ODBA_disc(night_id_s));	
turtle_big_ODBA_std_night_disc_s	= std(turtle_big_ODBA_disc(night_id_s));	
turtle_big_ODBA_range_night_disc_s	= range(turtle_big_ODBA_disc(night_id_s));	
turtle_big_ODBA_med_night_disc_s	= median(turtle_big_ODBA_disc(night_id_s));	
turtle_big_ODBA_quart_night_disc_s	= quantile(turtle_big_ODBA_disc(night_id_s), [.25 .50 .75]); % the quartiles of x

		%% ODBA offshore and inshore statistics
% tot
turtle_big_ODBA_max_off_s	= max(turtle_big_ODBA(offshore_id_s));			
turtle_big_ODBA_mean_off_s	= mean(turtle_big_ODBA(offshore_id_s));	
turtle_big_ODBA_std_off_s	= std(turtle_big_ODBA(offshore_id_s));	
turtle_big_ODBA_range_off_s	= range(turtle_big_ODBA(offshore_id_s));	
turtle_big_ODBA_med_off_s	= median(turtle_big_ODBA(offshore_id_s));	
turtle_big_ODBA_quart_off_s	= quantile(turtle_big_ODBA(offshore_id_s), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_in_s	= max(turtle_big_ODBA(inshore_id_s));			
turtle_big_ODBA_mean_in_s	= mean(turtle_big_ODBA(inshore_id_s));	
turtle_big_ODBA_std_in_s	= std(turtle_big_ODBA(inshore_id_s));	
turtle_big_ODBA_range_in_s	= range(turtle_big_ODBA(inshore_id_s));	
turtle_big_ODBA_med_in_s	= median(turtle_big_ODBA(inshore_id_s));	
turtle_big_ODBA_quart_in_s	= quantile(turtle_big_ODBA(inshore_id_s), [.25 .50 .75]); % the quartiles of x

% bott
turtle_big_ODBA_max_off_bott_s	= max(turtle_big_ODBA_bott(offshore_id_s));			
turtle_big_ODBA_mean_off_bott_s	= mean(turtle_big_ODBA_bott(offshore_id_s));	
turtle_big_ODBA_std_off_bott_s	= std(turtle_big_ODBA_bott(offshore_id_s));	
turtle_big_ODBA_range_off_bott_s= range(turtle_big_ODBA_bott(offshore_id_s));	
turtle_big_ODBA_med_off_bott_s	= median(turtle_big_ODBA_bott(offshore_id_s));	
turtle_big_ODBA_quart_off_bott_s= quantile(turtle_big_ODBA_bott(offshore_id_s), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_in_bott_s	= max(turtle_big_ODBA_bott(inshore_id_s));			
turtle_big_ODBA_mean_in_bott_s	= mean(turtle_big_ODBA_bott(inshore_id_s));	
turtle_big_ODBA_std_in_bott_s	= std(turtle_big_ODBA_bott(inshore_id_s));	
turtle_big_ODBA_range_in_bott_s	= range(turtle_big_ODBA_bott(inshore_id_s));	
turtle_big_ODBA_med_in_bott_s	= median(turtle_big_ODBA_bott(inshore_id_s));	
turtle_big_ODBA_quart_in_bott_s	= quantile(turtle_big_ODBA_bott(inshore_id_s), [.25 .50 .75]); % the quartiles of x

% asc
turtle_big_ODBA_max_off_asc_s	= max(turtle_big_ODBA_asc(offshore_id_s));			
turtle_big_ODBA_mean_off_asc_s	= mean(turtle_big_ODBA_asc(offshore_id_s));	
turtle_big_ODBA_std_off_asc_s	= std(turtle_big_ODBA_asc(offshore_id_s));	
turtle_big_ODBA_range_off_asc_s	= range(turtle_big_ODBA_asc(offshore_id_s));	
turtle_big_ODBA_med_off_asc_s	= median(turtle_big_ODBA_asc(offshore_id_s));	
turtle_big_ODBA_quart_off_asc_s	= quantile(turtle_big_ODBA_asc(offshore_id_s), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_in_asc_s	= max(turtle_big_ODBA_asc(inshore_id_s));			
turtle_big_ODBA_mean_in_asc_s	= mean(turtle_big_ODBA_asc(inshore_id_s));	
turtle_big_ODBA_std_in_asc_s	= std(turtle_big_ODBA_asc(inshore_id_s));	
turtle_big_ODBA_range_in_asc_s	= range(turtle_big_ODBA_asc(inshore_id_s));	
turtle_big_ODBA_med_in_asc_s	= median(turtle_big_ODBA_asc(inshore_id_s));	
turtle_big_ODBA_quart_in_asc_s	= quantile(turtle_big_ODBA_asc(inshore_id_s), [.25 .50 .75]); % the quartiles of x

% disc
turtle_big_ODBA_max_off_disc_s	= max(turtle_big_ODBA_disc(offshore_id_s));			
turtle_big_ODBA_mean_off_disc_s	= mean(turtle_big_ODBA_disc(offshore_id_s));	
turtle_big_ODBA_std_off_disc_s	= std(turtle_big_ODBA_disc(offshore_id_s));	
turtle_big_ODBA_range_off_disc_s= range(turtle_big_ODBA_disc(offshore_id_s));	
turtle_big_ODBA_med_off_disc_s	= median(turtle_big_ODBA_disc(offshore_id_s));	
turtle_big_ODBA_quart_off_disc_s= quantile(turtle_big_ODBA_disc(offshore_id_s), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_in_disc_s	= max(turtle_big_ODBA_disc(inshore_id_s));			
turtle_big_ODBA_mean_in_disc_s	= mean(turtle_big_ODBA_disc(inshore_id_s));	
turtle_big_ODBA_std_in_disc_s	= std(turtle_big_ODBA_disc(inshore_id_s));	
turtle_big_ODBA_range_in_disc_s	= range(turtle_big_ODBA_disc(inshore_id_s));	
turtle_big_ODBA_med_in_disc_s	= median(turtle_big_ODBA_disc(inshore_id_s));	
turtle_big_ODBA_quart_in_disc_s	= quantile(turtle_big_ODBA_disc(inshore_id_s), [.25 .50 .75]); % the quartiles of x

		%% ODBA day-night and offshore-inshore statistics
% tot
turtle_big_ODBA_max_off_day_s	= max(turtle_big_ODBA(off_day_id_s));			
turtle_big_ODBA_mean_off_day_s	= mean(turtle_big_ODBA(off_day_id_s));	
turtle_big_ODBA_std_off_day_s	= std(turtle_big_ODBA(off_day_id_s));	
turtle_big_ODBA_range_off_day_s	= range(turtle_big_ODBA(off_day_id_s));	
turtle_big_ODBA_med_off_day_s	= median(turtle_big_ODBA(off_day_id_s));	
turtle_big_ODBA_quart_off_day_s	= quantile(turtle_big_ODBA(off_day_id_s), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_in_day_s	= max(turtle_big_ODBA(in_day_id_s));			
turtle_big_ODBA_mean_in_day_s	= mean(turtle_big_ODBA(in_day_id_s));	
turtle_big_ODBA_std_in_day_s	= std(turtle_big_ODBA(in_day_id_s));	
turtle_big_ODBA_range_in_day_s	= range(turtle_big_ODBA(in_day_id_s));	
turtle_big_ODBA_med_in_day_s	= median(turtle_big_ODBA(in_day_id_s));	
turtle_big_ODBA_quart_in_day_s	= quantile(turtle_big_ODBA(in_day_id_s), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_off_night_s		= max(turtle_big_ODBA(off_night_id_s));			
turtle_big_ODBA_mean_off_night_s	= mean(turtle_big_ODBA(off_night_id_s));	
turtle_big_ODBA_std_off_night_s		= std(turtle_big_ODBA(off_night_id_s));	
turtle_big_ODBA_range_off_night_s	= range(turtle_big_ODBA(off_night_id_s));	
turtle_big_ODBA_med_off_night_s		= median(turtle_big_ODBA(off_night_id_s));	
turtle_big_ODBA_quart_off_night_s	= quantile(turtle_big_ODBA(off_night_id_s), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_in_night_s	= max(turtle_big_ODBA(in_night_id_s));			
turtle_big_ODBA_mean_in_night_s	= mean(turtle_big_ODBA(in_night_id_s));	
turtle_big_ODBA_std_in_night_s	= std(turtle_big_ODBA(in_night_id_s));	
turtle_big_ODBA_range_in_night_s= range(turtle_big_ODBA(in_night_id_s));	
turtle_big_ODBA_med_in_night_s	= median(turtle_big_ODBA(in_night_id_s));	
turtle_big_ODBA_quart_in_night_s= quantile(turtle_big_ODBA(in_night_id_s), [.25 .50 .75]); % the quartiles of x

% bott
turtle_big_ODBA_max_off_day_bott_s	= max(turtle_big_ODBA_bott(off_day_id_s));			
turtle_big_ODBA_mean_off_day_bott_s	= mean(turtle_big_ODBA_bott(off_day_id_s));	
turtle_big_ODBA_std_off_day_bott_s	= std(turtle_big_ODBA_bott(off_day_id_s));	
turtle_big_ODBA_range_off_day_bott_s= range(turtle_big_ODBA_bott(off_day_id_s));	
turtle_big_ODBA_med_off_day_bott_s	= median(turtle_big_ODBA_bott(off_day_id_s));	
turtle_big_ODBA_quart_off_day_bott_s= quantile(turtle_big_ODBA_bott(off_day_id_s), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_in_day_bott_s	= max(turtle_big_ODBA_bott(in_day_id_s));			
turtle_big_ODBA_mean_in_day_bott_s	= mean(turtle_big_ODBA_bott(in_day_id_s));	
turtle_big_ODBA_std_in_day_bott_s	= std(turtle_big_ODBA_bott(in_day_id_s));	
turtle_big_ODBA_range_in_day_bott_s	= range(turtle_big_ODBA_bott(in_day_id_s));	
turtle_big_ODBA_med_in_day_bott_s	= median(turtle_big_ODBA_bott(in_day_id_s));	
turtle_big_ODBA_quart_in_day_bott_s	= quantile(turtle_big_ODBA_bott(in_day_id_s), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_off_night_bott_s	= max(turtle_big_ODBA_bott(off_night_id_s));			
turtle_big_ODBA_mean_off_night_bott_s	= mean(turtle_big_ODBA_bott(off_night_id_s));	
turtle_big_ODBA_std_off_night_bott_s	= std(turtle_big_ODBA_bott(off_night_id_s));	
turtle_big_ODBA_range_off_night_bott_s	= range(turtle_big_ODBA_bott(off_night_id_s));	
turtle_big_ODBA_med_off_night_bott_s	= median(turtle_big_ODBA_bott(off_night_id_s));	
turtle_big_ODBA_quart_off_night_bott_s	= quantile(turtle_big_ODBA_bott(off_night_id_s), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_in_night_bott_s		= max(turtle_big_ODBA_bott(in_night_id_s));			
turtle_big_ODBA_mean_in_night_bott_s	= mean(turtle_big_ODBA_bott(in_night_id_s));	
turtle_big_ODBA_std_in_night_bott_s		= std(turtle_big_ODBA_bott(in_night_id_s));	
turtle_big_ODBA_range_in_night_bott_s	= range(turtle_big_ODBA_bott(in_night_id_s));	
turtle_big_ODBA_med_in_night_bott_s		= median(turtle_big_ODBA_bott(in_night_id_s));	
turtle_big_ODBA_quart_in_night_bott_s	= quantile(turtle_big_ODBA_bott(in_night_id_s), [.25 .50 .75]); % the quartiles of x

% asc
turtle_big_ODBA_max_off_day_asc_s	= max(turtle_big_ODBA_asc(off_day_id_s));			
turtle_big_ODBA_mean_off_day_asc_s	= mean(turtle_big_ODBA_asc(off_day_id_s));	
turtle_big_ODBA_std_off_day_asc_s	= std(turtle_big_ODBA_asc(off_day_id_s));	
turtle_big_ODBA_range_off_day_asc_s	= range(turtle_big_ODBA_asc(off_day_id_s));	
turtle_big_ODBA_med_off_day_asc_s	= median(turtle_big_ODBA_asc(off_day_id_s));	
turtle_big_ODBA_quart_off_day_asc_s	= quantile(turtle_big_ODBA_asc(off_day_id_s), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_in_day_asc_s	= max(turtle_big_ODBA_asc(in_day_id_s));			
turtle_big_ODBA_mean_in_day_asc_s	= mean(turtle_big_ODBA_asc(in_day_id_s));	
turtle_big_ODBA_std_in_day_asc_s	= std(turtle_big_ODBA_asc(in_day_id_s));	
turtle_big_ODBA_range_in_day_asc_s	= range(turtle_big_ODBA_asc(in_day_id_s));	
turtle_big_ODBA_med_in_day_asc_s	= median(turtle_big_ODBA_asc(in_day_id_s));	
turtle_big_ODBA_quart_in_day_asc_s	= quantile(turtle_big_ODBA_asc(in_day_id_s), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_off_night_asc_s		= max(turtle_big_ODBA_asc(off_night_id_s));			
turtle_big_ODBA_mean_off_night_asc_s	= mean(turtle_big_ODBA_asc(off_night_id_s));	
turtle_big_ODBA_std_off_night_asc_s		= std(turtle_big_ODBA_asc(off_night_id_s));	
turtle_big_ODBA_range_off_night_asc_s	= range(turtle_big_ODBA_asc(off_night_id_s));	
turtle_big_ODBA_med_off_night_asc_s		= median(turtle_big_ODBA_asc(off_night_id_s));	
turtle_big_ODBA_quart_off_night_asc_s	= quantile(turtle_big_ODBA_asc(off_night_id_s), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_in_night_asc_s		= max(turtle_big_ODBA_asc(in_night_id_s));			
turtle_big_ODBA_mean_in_night_asc_s		= mean(turtle_big_ODBA_asc(in_night_id_s));	
turtle_big_ODBA_std_in_night_asc_s		= std(turtle_big_ODBA_asc(in_night_id_s));	
turtle_big_ODBA_range_in_night_asc_s	= range(turtle_big_ODBA_asc(in_night_id_s));	
turtle_big_ODBA_med_in_night_asc_s		= median(turtle_big_ODBA_asc(in_night_id_s));	
turtle_big_ODBA_quart_in_night_asc_s	= quantile(turtle_big_ODBA_asc(in_night_id_s), [.25 .50 .75]); % the quartiles of x

% disc
turtle_big_ODBA_max_off_day_disc_s		= max(turtle_big_ODBA_disc(off_day_id_s));			
turtle_big_ODBA_mean_off_day_disc_s		= mean(turtle_big_ODBA_disc(off_day_id_s));	
turtle_big_ODBA_std_off_day_disc_s		= std(turtle_big_ODBA_disc(off_day_id_s));	
turtle_big_ODBA_range_off_day_disc_s	= range(turtle_big_ODBA_disc(off_day_id_s));	
turtle_big_ODBA_med_off_day_disc_s		= median(turtle_big_ODBA_disc(off_day_id_s));	
turtle_big_ODBA_quart_off_day_disc_s	= quantile(turtle_big_ODBA_disc(off_day_id_s), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_in_day_disc_s		= max(turtle_big_ODBA_disc(in_day_id_s));			
turtle_big_ODBA_mean_in_day_disc_s		= mean(turtle_big_ODBA_disc(in_day_id_s));	
turtle_big_ODBA_std_in_day_disc_s		= std(turtle_big_ODBA_disc(in_day_id_s));	
turtle_big_ODBA_range_in_day_disc_s		= range(turtle_big_ODBA_disc(in_day_id_s));	
turtle_big_ODBA_med_in_day_disc_s		= median(turtle_big_ODBA_disc(in_day_id_s));	
turtle_big_ODBA_quart_in_day_disc_s		= quantile(turtle_big_ODBA_disc(in_day_id_s), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_off_night_disc_s	= max(turtle_big_ODBA_disc(off_night_id_s));			
turtle_big_ODBA_mean_off_night_disc_s	= mean(turtle_big_ODBA_disc(off_night_id_s));	
turtle_big_ODBA_std_off_night_disc_s	= std(turtle_big_ODBA_disc(off_night_id_s));	
turtle_big_ODBA_range_off_night_disc_s	= range(turtle_big_ODBA_disc(off_night_id_s));	
turtle_big_ODBA_med_off_night_disc_s	= median(turtle_big_ODBA_disc(off_night_id_s));	
turtle_big_ODBA_quart_off_night_disc_s	= quantile(turtle_big_ODBA_disc(off_night_id_s), [.25 .50 .75]); % the quartiles of x

turtle_big_ODBA_max_in_night_disc_s		= max(turtle_big_ODBA_disc(in_night_id_s));			
turtle_big_ODBA_mean_in_night_disc_s	= mean(turtle_big_ODBA_disc(in_night_id_s));	
turtle_big_ODBA_std_in_night_disc_s		= std(turtle_big_ODBA_disc(in_night_id_s));	
turtle_big_ODBA_range_in_night_disc_s	= range(turtle_big_ODBA_disc(in_night_id_s));	
turtle_big_ODBA_med_in_night_disc_s		= median(turtle_big_ODBA_disc(in_night_id_s));	
turtle_big_ODBA_quart_in_night_disc_s	= quantile(turtle_big_ODBA_disc(in_night_id_s), [.25 .50 .75]); % the quartiles of x

%% shallow dive
sh_num			= size(turtle_dive.shallow_dive.homing, 2);
turtle_sh_ODBA	= zeros(sh_num, 1);

for i = 1:sh_num
	turtle_sh_ODBA(i)	= turtle_DBA_paper.shallow_dive.homing.ODBA.mean(i);
end

[day_ids, night_ids, offshore_ids, inshore_ids, off_day_ids, off_night_ids, in_day_ids, in_night_ids] = find_id_day_shore(turtle_dive.shallow_dive.homing); 

	%% ODBA statistics
% tot
turtle_sh_ODBA_max		= max(turtle_sh_ODBA);			
turtle_sh_ODBA_mean		= mean(turtle_sh_ODBA);	
turtle_sh_ODBA_std		= std(turtle_sh_ODBA);	
turtle_sh_ODBA_range	= range(turtle_sh_ODBA);	
turtle_sh_ODBA_med		= median(turtle_sh_ODBA);	
turtle_sh_ODBA_quart	= quantile(turtle_sh_ODBA, [.25 .50 .75]); % the quartiles of x

	%% ODBA day and night statistics
% tot
turtle_sh_ODBA_max_day		= max(turtle_sh_ODBA(day_ids));			
turtle_sh_ODBA_mean_day		= mean(turtle_sh_ODBA(day_ids));	
turtle_sh_ODBA_std_day		= std(turtle_sh_ODBA(day_ids));	
turtle_sh_ODBA_range_day	= range(turtle_sh_ODBA(day_ids));	
turtle_sh_ODBA_med_day		= median(turtle_sh_ODBA(day_ids));	
turtle_sh_ODBA_quart_day	= quantile(turtle_sh_ODBA(day_ids), [.25 .50 .75]); % the quartiles of x

turtle_sh_ODBA_max_night	= max(turtle_sh_ODBA(night_ids));			
turtle_sh_ODBA_mean_night	= mean(turtle_sh_ODBA(night_ids));	
turtle_sh_ODBA_std_night	= std(turtle_sh_ODBA(night_ids));	
turtle_sh_ODBA_range_night	= range(turtle_sh_ODBA(night_ids));	
turtle_sh_ODBA_med_night	= median(turtle_sh_ODBA(night_ids));	
turtle_sh_ODBA_quart_night	= quantile(turtle_sh_ODBA(night_ids), [.25 .50 .75]); % the quartiles of x

	%% ODBA offshore and inshore statistics
% tot
turtle_sh_ODBA_max_off		= max(turtle_sh_ODBA(offshore_ids));			
turtle_sh_ODBA_mean_off		= mean(turtle_sh_ODBA(offshore_ids));	
turtle_sh_ODBA_std_off		= std(turtle_sh_ODBA(offshore_ids));	
turtle_sh_ODBA_range_off	= range(turtle_sh_ODBA(offshore_ids));	
turtle_sh_ODBA_med_off		= median(turtle_sh_ODBA(offshore_ids));	
turtle_sh_ODBA_quart_off	= quantile(turtle_sh_ODBA(offshore_ids), [.25 .50 .75]); % the quartiles of x

turtle_sh_ODBA_max_in		= max(turtle_sh_ODBA(inshore_ids));			
turtle_sh_ODBA_mean_in		= mean(turtle_sh_ODBA(inshore_ids));	
turtle_sh_ODBA_std_in		= std(turtle_sh_ODBA(inshore_ids));	
turtle_sh_ODBA_range_in		= range(turtle_sh_ODBA(inshore_ids));	
turtle_sh_ODBA_med_in		= median(turtle_sh_ODBA(inshore_ids));	
turtle_sh_ODBA_quart_in		= quantile(turtle_sh_ODBA(inshore_ids), [.25 .50 .75]); % the quartiles of x

	%% ODBA day-night and offshore-inshore statistics
% tot
turtle_sh_ODBA_max_off_day		= max(turtle_sh_ODBA(off_day_ids));			
turtle_sh_ODBA_mean_off_day		= mean(turtle_sh_ODBA(off_day_ids));	
turtle_sh_ODBA_std_off_day		= std(turtle_sh_ODBA(off_day_ids));	
turtle_sh_ODBA_range_off_day	= range(turtle_sh_ODBA(off_day_ids));	
turtle_sh_ODBA_med_off_day		= median(turtle_sh_ODBA(off_day_ids));	
turtle_sh_ODBA_quart_off_day	= quantile(turtle_sh_ODBA(off_day_ids), [.25 .50 .75]); % the quartiles of x

turtle_sh_ODBA_max_in_day		= max(turtle_sh_ODBA(in_day_ids));			
turtle_sh_ODBA_mean_in_day		= mean(turtle_sh_ODBA(in_day_ids));	
turtle_sh_ODBA_std_in_day		= std(turtle_sh_ODBA(in_day_ids));	
turtle_sh_ODBA_range_in_day		= range(turtle_sh_ODBA(in_day_ids));	
turtle_sh_ODBA_med_in_day		= median(turtle_sh_ODBA(in_day_ids));	
turtle_sh_ODBA_quart_in_day		= quantile(turtle_sh_ODBA(in_day_ids), [.25 .50 .75]); % the quartiles of x

turtle_sh_ODBA_max_off_night	= max(turtle_sh_ODBA(off_night_ids));			
turtle_sh_ODBA_mean_off_night	= mean(turtle_sh_ODBA(off_night_ids));	
turtle_sh_ODBA_std_off_night	= std(turtle_sh_ODBA(off_night_ids));	
turtle_sh_ODBA_range_off_night	= range(turtle_sh_ODBA(off_night_ids));	
turtle_sh_ODBA_med_off_night	= median(turtle_sh_ODBA(off_night_ids));	
turtle_sh_ODBA_quart_off_night	= quantile(turtle_sh_ODBA(off_night_ids), [.25 .50 .75]); % the quartiles of x

turtle_sh_ODBA_max_in_night		= max(turtle_sh_ODBA(in_night_ids));			
turtle_sh_ODBA_mean_in_night	= mean(turtle_sh_ODBA(in_night_ids));	
turtle_sh_ODBA_std_in_night		= std(turtle_sh_ODBA(in_night_ids));	
turtle_sh_ODBA_range_in_night	= range(turtle_sh_ODBA(in_night_ids));	
turtle_sh_ODBA_med_in_night		= median(turtle_sh_ODBA(in_night_ids));	
turtle_sh_ODBA_quart_in_night	= quantile(turtle_sh_ODBA(in_night_ids), [.25 .50 .75]); % the quartiles of x

%% sub surface
sub_num			= size(turtle_dive.sub_surface.homing, 2);
turtle_sub_ODBA	= zeros(sub_num, 1);

for i = 1:sub_num
	turtle_sub_ODBA(i) = turtle_DBA_paper.sub_surface.homing.ODBA.mean(i);
end

	%% ODBA statistics
% tot
turtle_sub_ODBA_max		= max(turtle_sub_ODBA);			
turtle_sub_ODBA_mean	= mean(turtle_sub_ODBA);	
turtle_sub_ODBA_std		= std(turtle_sub_ODBA);	
turtle_sub_ODBA_range	= range(turtle_sub_ODBA);	
turtle_sub_ODBA_med		= median(turtle_sub_ODBA);	
turtle_sub_ODBA_quart	= quantile(turtle_sub_ODBA, [.25 .50 .75]); % the quartiles of x

%% Plot
ODBA_analysis_paper_plot

