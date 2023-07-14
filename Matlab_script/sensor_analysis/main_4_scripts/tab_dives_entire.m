% tab_dives_entire
addpath("mat_file_tobeloaded");
%% table structure
% tabella con colonne:
% 
% ID tarta					--> noto									
% ID dive					--> counter									
% datetime start dive		--> turtle_dive.big_dive.homing.datatime(1)				
% tipo dive (sub-sh-big)	--> 3 tabelle, colonna con scritto se big, shallow...				
% dive profile (S, U..)		--> turtle_dive.big_dive.homing.type								dive_typei_tot
% max depth dive			--> turtle_big_depth o min(turtle_dive.big_dive.homing(i).depth)	turtlei_big_depth
% dive duration				--> turtle_dive.big_dive.homing.duration							turtlei_big_time
% day/night					--> turtle_dive.big_dive.homing.daynight				
% offshore/inshore			--> turtle_dive.big_dive.homing.offinshore				
% 
% ODBA medio dive			--> turtle_DBA.big_dive.homing.mean								struct2array
% ODBA ascend				--> turtle_DBA.big_dive.homing.asc									struct2array
% ODBA descend				--> turtle_DBA.big_dive.homing.disc								struct2array
% ODBA bottom				--> turtle_DBA.big_dive.homing.bott								struct2array

%% load dives information

% no load for now
%{
if exist('turtle_dive.mat', 'var')  == 0
	load('turtle_dive.mat')
end

% load DBA information
if exist('turtle_DBA_paper.mat', 'var')  == 0
	load('turtle_DBA_paper.mat')
end
%}
%% prepare data for tab

	%% big dive
	
		%% unused
% turtle_ID_big		= 2.*ones(size(turtle2_big_time, 1), size(turtle2_big_time, 2));
% turtle_ID_sh		= 2.*ones(size(turtle2_sh_time, 1), size(turtle2_sh_time, 2));
% turtle2_ID_sub	= 2.*ones(size(turtle2_sub_time, 1), size(turtle2_sub_time, 2));

		%% used
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

turtle_big_ODBA			= struct2array(turtle_DBA_paper.big_dive.homing.ODBA);
turtle_big_ODBA_mean	= turtle_big_ODBA(:, 1);
turtle_big_ODBA_asc		= turtle_big_ODBA(:, 4);
turtle_big_ODBA_disc	= turtle_big_ODBA(:, 3);
turtle_big_ODBA_bott	= turtle_big_ODBA(:, 5);
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

turtle_sh_ODBA = struct2array(turtle_DBA_paper.shallow_dive.homing.ODBA);
turtle_sh_ODBA_mean = turtle_sh_ODBA(:, 1);
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

turtle_sub_ODBA = struct2array(turtle_DBA_paper.sub_surface.homing.ODBA);
turtle_sub_ODBA_mean = turtle_sub_ODBA(:, 1);
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
writetable(tab_entire_tab, 'tab_entire_analysis', 'FileType', 'text');
