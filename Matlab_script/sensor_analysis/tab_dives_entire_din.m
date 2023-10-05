% tab_dives_entire
%
% This script is demanded to summarize into a single table all the
% meaningfull results obtained from the dataset analysis of a single turtle
% homing journey.
%
% In particular, the structure of the table is the following:
% Let's see the structure for big dives informations, but the same will be
% produced also for shallow dives and sub-surface periods.
% 
%% Table structure:
%
% ID dive					--> counter	for the big dive number	
% datetime start dive		--> turtle_dive.big_dive.homing.datatime(1)				
% dive depth type			--> big, shallow or sub-surface, three columns each
%								composed by a sub-table
% dive profile (S, U..)		--> turtle_dive.big_dive.homing.type (only for big dives is significant)								
% max depth dive			--> turtle_big_depth o min(turtle_dive.big_dive.homing(i).depth)
% dive duration				--> turtle_dive.big_dive.homing.duration
% day/night					--> turtle_dive.big_dive.homing.daynight				
% offshore/inshore			--> turtle_dive.big_dive.homing.offinshore				
% 
% ODBA mean dive			--> turtle_DBA.big_dive.homing.mean								
% ODBA ascent phase			--> turtle_DBA.big_dive.homing.asc									
% ODBA descent phase		--> turtle_DBA.big_dive.homing.disc								
% ODBA bottom phase			--> turtle_DBA.big_dive.homing.bott								
%
% As already mentioned, the same parameters taken for big dives are also
% inserted in the table for shallow dives and sub surface periods
% (turtle_DBA.shallow_dive.homing.*** and turtle_DBA.sub_surface.homing.***,
% respectively).

%% prepare data for tab

%% big dive
% turtle_big_time_i --> time init
turtle_ID_big_dive = [1:big_num]';
dive_type_big_range([1:big_num], 1) = "big";

% dive_type_tot	 --> dive type

% turtle_big_depth  --> max depth

% turtle_big_time	 --> duration

daynight_big_tab([day_id], 1)	= "day";
daynight_big_tab([night_id], 1)	= "night";

offinshore_big_tab([offshore_id], 1) = "offshore";
offinshore_big_tab([inshore_id], 1)	= "inshore";

turtle_big_ODBA_table	= struct2array(turtle_DBA_paper_din.big_dive.homing.ODBA);
turtle_big_ODBA_mean	= turtle_big_ODBA_table(:, 1);
turtle_big_ODBA_asc		= turtle_big_ODBA_table(:, 4);
turtle_big_ODBA_disc	= turtle_big_ODBA_table(:, 3);
turtle_big_ODBA_bott	= turtle_big_ODBA_table(:, 5);

%% shallow dive
turtle_ID_sh_dive = [1:sh_num]';

% turtle_sh_time_i --> time init

dive_type_sh_range([1:sh_num], 1)	= "shallow";
dive_type_tot_sh([1:sh_num], 1)		= "shallow";

% turtle_sh_depth  --> max depth
% turtle_sh_time	 --> duration

daynight_sh_tab([day_ids], 1)	= "day";
daynight_sh_tab([night_ids], 1) = "night";

offinshore_sh_tab([offshore_ids], 1)	= "offshore";
offinshore_sh_tab([inshore_ids], 1)		= "inshore";

turtle_sh_ODBA_table = struct2array(turtle_DBA_paper_din.shallow_dive.homing.ODBA);
turtle_sh_ODBA_mean = turtle_sh_ODBA_table(:, 1);
turtle_sh_ODBA_asc([1:sh_num], 1) = -1;
turtle_sh_ODBA_disc([1:sh_num], 1) = -1;
turtle_sh_ODBA_bott([1:sh_num], 1) = -1;

	%% subsurface
turtle_ID_sub_dive = [1:sub_num]';

% turtle_sub_time_i --> time init

dive_type_sub_range([1:sub_num], 1)	= "subsurface";
dive_type_tot_sub([1:sub_num], 1)	= "subsurface";

% turtle_sub_depth  --> max depth

% turtle_sub_time	--> duration

daynight_sub_tab([day_idsub], 1) = "day";
daynight_sub_tab([night_idsub], 1) = "night";

offinshore_sub_tab([offshore_idsub], 1) = "offshore";
offinshore_sub_tab([inshore_idsub], 1) = "inshore";

turtle_sub_ODBA_table = struct2array(turtle_DBA_paper_din.sub_surface.homing.ODBA);
turtle_sub_ODBA_mean = turtle_sub_ODBA_table(:, 1);
turtle_sub_ODBA_asc([1:sub_num], 1)	 = -1;
turtle_sub_ODBA_disc([1:sub_num], 1) = -1;
turtle_sub_ODBA_bott([1:sub_num], 1) = -1;

	
%% table
				 
tab_entire.dive_num =	[turtle_ID_big_dive;...
						 turtle_ID_sh_dive;...
						 turtle_ID_sub_dive];

tab_entire.time_init =	[turtle_big_time_i;...
						 turtle_sh_time_i;...
						 turtle_sub_time_i];

tab_entire.duration =	[turtle_big_time;...
						 turtle_sh_time;...
						 turtle_sub_time];

tab_entire.depth_range =	[dive_type_big_range;...
							 dive_type_sh_range;...
							 dive_type_sub_range];
						 
tab_entire.dive_profile =	[dive_type_tot;...
							 dive_type_tot_sh;...
							 dive_type_tot_sub];
						
tab_entire.max_depth =	[turtle_big_depth;...
						 turtle_sh_depth;...
						 turtle_sub_depth];
					 
tab_entire.daynight =	[daynight_big_tab;...
						 daynight_sh_tab;...
						 daynight_sub_tab];

tab_entire.offinshore =	[offinshore_big_tab;...
						 offinshore_sh_tab;...
						 offinshore_sub_tab];
					 
tab_entire.ODBA_mean =	[turtle_big_ODBA_mean;...
						 turtle_sh_ODBA_mean;...
						 turtle_sub_ODBA_mean];
					 
tab_entire.ODBA_asc =	[turtle_big_ODBA_asc;...
						 turtle_sh_ODBA_asc;...
						 turtle_sub_ODBA_asc];
					 
tab_entire.ODBA_desc =	[turtle_big_ODBA_disc;...
						 turtle_sh_ODBA_disc;...
						 turtle_sub_ODBA_disc];
					 
tab_entire.ODBA_bott =	[turtle_big_ODBA_bott;...
						 turtle_sh_ODBA_bott;...
						 turtle_sub_ODBA_bott];
					 
tab_entire_tab = struct2table(tab_entire);
writetable(tab_entire_tab, 'tab_entire_analysis_din', 'FileType', 'text');
