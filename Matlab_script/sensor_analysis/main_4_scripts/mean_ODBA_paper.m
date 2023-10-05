% mean_ODBA_paper
%
% This script is demanded to handle the ODBA analysis.
% In particular, it consists in the evaluation of ODBA and VeDBA energetic  
% indices associated to each dive (big and shallow) and sub-surface section, 
% adapted to the requirement that has been chosen to be used in the paper 
% results.
%
% Here it is also performed the division among descent, bottom, and  
% ascent phases of big dives only, in order to evaluate if energetic 
% index differs significantly depending on turtle behavior during a deep 
% dive.
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% In particular, by starting from the ODBA analysis already performed in
% "dive_DBA_homing" script, the following operations are implemented:
%
% 1. mean and variance for ODBA (and VeDBA)
%	Here, there is the computation, for each section, of the average value 
%	(and associated variance) assumed by the ODBA and VeDBA indices. The 
%	same is done by separating the descent, bottom, and ascent phases for 
%	the big dives only.
%
%	Note:	there will be a single reference value for each dives and each 
%			surface phases (periods between two consecutive dives).
%
% 2. Creation of a struct and saving operation as .mat file.

%% results
% ODBA and VeDBA are higher in shallow phases then in dives.
% Each point of graphs produced below corresponds to index mean over the
% entire section's time length. As we can observe, index mean associated to
% dives are lower than the one associated to shallow water navigation.
%
% Here is also performed division among discending, bottom, and ascending 
% phases, in order to evaluate if energetic index differs significantly
% depending on turtle behavior. Not an evidence is highlight,
% but when there is a difference which can be clearly seen, it is always
% with bottom phases as lower energetic phases, discending phases as middle
% energetic consumption phases and ascending with higher energy
% consumption.

%% turtle_dive load - commented
%if exist('turtle_dive.mat', 'var') == 0
%	load('turtle_dive.mat')
%end

num_5s = 50;					% smooth data
name_turtle = turtle_dive.name;
th_depth = 0.5;					% Threshold which determines if we are
								% still in bottom phase or not.

homing_counter		= size(turtle_dive.big_dive.homing, 2);
sh_homing_counter	= size(turtle_dive.shallow_dive.homing, 2);
surf_homing_counter = size(turtle_dive.sub_surface.homing, 2);

%% mean ODBA and VeDBA
% Computation for each section of the average value assumed by ODBA and VeDBA.
% Then, separate the descent, bottom, and ascent phases for the dives, 
% so as to compare them to each other.

%% ODBA: mean and variance
% There will be a value for each dives and each surface phases (that
% stay for period between two consecutive dives)
%% big dive
mean_ODBA_dive_h		= zeros(homing_counter, 1);
mean_ODBA_dive_h_disc	= zeros(homing_counter, 1);
mean_ODBA_dive_h_bott	= zeros(homing_counter, 1);
mean_ODBA_dive_h_asc	= zeros(homing_counter, 1);

if isempty(turtle_dive.big_dive.homing(1).pitch) == 0
	mean_pitch_dive_h_disc	= zeros(homing_counter, 1);
	mean_pitch_dive_h_bott	= zeros(homing_counter, 1);
	mean_pitch_dive_h_asc	= zeros(homing_counter, 1);
	
end

var_ODBA_dive_h			= zeros(homing_counter, 1);

for i = 1:homing_counter
	mean_ODBA_dive_h(i) = mean(turtle_dive.big_dive.homing(i).ODBA_paper);
	var_ODBA_dive_h(i)	= var(turtle_dive.big_dive.homing(i).ODBA_paper);
	
	% phases split: descendent, bottom, ascendent
	depth				= turtle_dive.big_dive.homing(i).depth;
	max_depth			= min(depth); % min since depth has negative values
	
	first_bottom			= 0;
	no_bottom_counter_disc	= 0;
	no_bottom_counter_asc	= 0;
	bottom_counter			= 0;
	tot_dive				= length(depth);
	
	for j = 1:tot_dive
		if depth(j)- max_depth >= th_depth
			
			if first_bottom == 0		% bottom has to be reached yet
				no_bottom_counter_disc		= no_bottom_counter_disc + 1;
				mean_ODBA_dive_h_disc(i)	= mean_ODBA_dive_h_disc(i)	+ turtle_dive.big_dive.homing(i).ODBA_paper(ceil(j/num_5s));
				
				if isempty(turtle_dive.big_dive.homing(i).pitch) == 0
					mean_pitch_dive_h_disc(i)	= mean_pitch_dive_h_disc(i)	+ turtle_dive.big_dive.homing(i).pitch(j);
				end
			elseif first_bottom == 1	% bottom has already been reached
				no_bottom_counter_asc		= no_bottom_counter_asc + 1;
				mean_ODBA_dive_h_asc(i)		= mean_ODBA_dive_h_asc(i)	+ turtle_dive.big_dive.homing(i).ODBA_paper(ceil(j/num_5s));
				if isempty(turtle_dive.big_dive.homing(i).pitch) == 0
					mean_pitch_dive_h_asc(i)	= mean_pitch_dive_h_asc(i)	+ turtle_dive.big_dive.homing(i).pitch(j);
				end
			end
			
		elseif depth(j)- max_depth < th_depth
			if first_bottom == 0
				first_bottom = 1;
			end
			bottom_counter				= bottom_counter + 1;
			mean_ODBA_dive_h_bott(i)	= mean_ODBA_dive_h_bott(i)	+ turtle_dive.big_dive.homing(i).ODBA_paper(ceil(j/num_5s));
			if isempty(turtle_dive.big_dive.homing(i).pitch) == 0
				mean_pitch_dive_h_bott(i)	= mean_pitch_dive_h_bott(i)	+ turtle_dive.big_dive.homing(i).pitch(j);
			end
		end
	end
	
	% mean computed by hand (cumulative sum of ODBA over time divided
	% by time length (in terms of number of samples inside the dive)
	mean_ODBA_dive_h_disc(i)	= mean_ODBA_dive_h_disc(i)	/ no_bottom_counter_disc;
	mean_ODBA_dive_h_asc(i)		= mean_ODBA_dive_h_asc(i)	/ no_bottom_counter_asc;
	mean_ODBA_dive_h_bott(i)	= mean_ODBA_dive_h_bott(i)	/ bottom_counter;
		
	if exist('mean_pitch_dive_h_disc', 'var')
		mean_pitch_dive_h_disc(i)	= mean_pitch_dive_h_disc(i)	/ no_bottom_counter_disc;
		mean_pitch_dive_h_asc(i)	= mean_pitch_dive_h_asc(i)	/ no_bottom_counter_asc;
		mean_pitch_dive_h_bott(i)	= mean_pitch_dive_h_bott(i)	/ bottom_counter;
	end
end
%% shallow dive
mean_ODBA_sdive_h		= zeros(sh_homing_counter, 1);
var_ODBA_sdive_h		= zeros(sh_homing_counter, 1);

for i = 1:sh_homing_counter
	% mean and variance of ODBA energy index assumed during dive-i
	mean_ODBA_sdive_h(i) = mean(turtle_dive.shallow_dive.homing(i).ODBA_paper);
	var_ODBA_sdive_h(i)	= var(turtle_dive.shallow_dive.homing(i).ODBA_paper);

end
%% sub surface
mean_ODBA_surf_h		= zeros(surf_homing_counter, 1);
var_ODBA_surf_h			= zeros(surf_homing_counter, 1);

for i = 1:surf_homing_counter
	mean_ODBA_surf_h(i) = mean(turtle_dive.sub_surface.homing(i).ODBA_paper);
	var_ODBA_surf_h(i)	= var(turtle_dive.sub_surface.homing(i).ODBA_paper);
end

%% din version

%% ODBA: mean and variance
% There will be a value for each dives and each surface phases (that
% stay for period between two consecutive dives)
%% big dive
mean_ODBA_dive_h_din		= zeros(homing_counter, 1);
mean_ODBA_dive_h_disc_din	= zeros(homing_counter, 1);
mean_ODBA_dive_h_bott_din	= zeros(homing_counter, 1);
mean_ODBA_dive_h_asc_din	= zeros(homing_counter, 1);

if isempty(turtle_dive_din.big_dive.homing(1).pitch) == 0
	mean_pitch_dive_h_disc_din	= zeros(homing_counter, 1);
	mean_pitch_dive_h_bott_din	= zeros(homing_counter, 1);
	mean_pitch_dive_h_asc_din	= zeros(homing_counter, 1);
	
end

var_ODBA_dive_h_din			= zeros(homing_counter, 1);

for i = 1:homing_counter
	mean_ODBA_dive_h_din(i) = mean(turtle_dive_din.big_dive.homing(i).ODBA_paper);
	var_ODBA_dive_h_din(i)	= var(turtle_dive_din.big_dive.homing(i).ODBA_paper);
	
	% phases split: descendent, bottom, ascendent
	depth				= turtle_dive.big_dive.homing(i).depth;
	max_depth			= min(depth); % min since depth has negative values
	
	first_bottom_din			= 0;
	no_bottom_counter_disc_din	= 0;
	no_bottom_counter_asc_din	= 0;
	bottom_counter_din			= 0;
	tot_dive				= length(depth);
	
	for j = 1:tot_dive
		if depth(j)- max_depth >= th_depth
			
			if first_bottom_din == 0		% bottom has to be reached yet
				no_bottom_counter_disc_din		= no_bottom_counter_disc_din + 1;
				mean_ODBA_dive_h_disc_din(i)	= mean_ODBA_dive_h_disc_din(i)	+ turtle_dive_din.big_dive.homing(i).ODBA_paper(ceil(j/num_5s));
				
				if isempty(turtle_dive_din.big_dive.homing(i).pitch) == 0
					mean_pitch_dive_h_disc_din(i)	= mean_pitch_dive_h_disc_din(i)	+ turtle_dive_din.big_dive.homing(i).pitch(j);
				end
			elseif first_bottom_din == 1	% bottom has already been reached
				no_bottom_counter_asc_din		= no_bottom_counter_asc_din + 1;
				mean_ODBA_dive_h_asc_din(i)		= mean_ODBA_dive_h_asc_din(i)	+ turtle_dive_din.big_dive.homing(i).ODBA_paper(ceil(j/num_5s));
				if isempty(turtle_dive_din.big_dive.homing(i).pitch) == 0
					mean_pitch_dive_h_asc_din(i)	= mean_pitch_dive_h_asc_din(i)	+ turtle_dive_din.big_dive.homing(i).pitch(j);
				end
			end
			
		elseif depth(j)- max_depth < th_depth
			if first_bottom_din == 0
				first_bottom_din = 1;
			end
			bottom_counter_din				= bottom_counter_din + 1;
			mean_ODBA_dive_h_bott_din(i)	= mean_ODBA_dive_h_bott_din(i)	+ turtle_dive_din.big_dive.homing(i).ODBA_paper(ceil(j/num_5s));
			if isempty(turtle_dive_din.big_dive.homing(i).pitch) == 0
				mean_pitch_dive_h_bott_din(i)	= mean_pitch_dive_h_bott_din(i)	+ turtle_dive_din.big_dive.homing(i).pitch(j);
			end
		end
	end
	
	% mean computed by hand (cumulative sum of ODBA over time divided
	% by time length (in terms of number of samples inside the dive)
	mean_ODBA_dive_h_disc_din(i)	= mean_ODBA_dive_h_disc_din(i)	/ no_bottom_counter_disc_din;
	mean_ODBA_dive_h_asc_din(i)		= mean_ODBA_dive_h_asc_din(i)	/ no_bottom_counter_asc_din;
	mean_ODBA_dive_h_bott_din(i)	= mean_ODBA_dive_h_bott_din(i)	/ bottom_counter_din;
		
	if exist('mean_pitch_dive_h_disc_din', 'var')
		mean_pitch_dive_h_disc_din(i)	= mean_pitch_dive_h_disc_din(i)	/ no_bottom_counter_disc_din;
		mean_pitch_dive_h_asc_din(i)	= mean_pitch_dive_h_asc_din(i)	/ no_bottom_counter_asc_din;
		mean_pitch_dive_h_bott_din(i)	= mean_pitch_dive_h_bott_din(i)	/ bottom_counter_din;
	end
end
%% shallow dive
mean_ODBA_sdive_h_din	= zeros(sh_homing_counter, 1);
var_ODBA_sdive_h_din	= zeros(sh_homing_counter, 1);

for i = 1:sh_homing_counter
	% mean and variance of ODBA energy index assumed during dive-i
	mean_ODBA_sdive_h_din(i) = mean(turtle_dive_din.shallow_dive.homing(i).ODBA_paper);
	var_ODBA_sdive_h_din(i)	= var(turtle_dive_din.shallow_dive.homing(i).ODBA_paper);

end
%% sub surface
mean_ODBA_surf_h_din	= zeros(surf_homing_counter, 1);
var_ODBA_surf_h_din		= zeros(surf_homing_counter, 1);

mean_ODBA_surf_h_din_nw	= zeros(surf_homing_counter, 1);
var_ODBA_surf_h_din_nw	= zeros(surf_homing_counter, 1);

for i = 1:surf_homing_counter
	mean_ODBA_surf_h_din(i) = mean(turtle_dive_din.sub_surface.homing(i).ODBA_paper);
	var_ODBA_surf_h_din(i)	= var(turtle_dive_din.sub_surface.homing(i).ODBA_paper);
	mean_ODBA_surf_h_din_nw(i) = mean(turtle_dive_din.sub_surface.homing(i).ODBA_paper_nw);
	var_ODBA_surf_h_din_nw(i)	= var(turtle_dive_din.sub_surface.homing(i).ODBA_paper_nw);
end

%% save struct ODBA and VeDBA

save_ODBA_paper_data