% mean_ODBA_paper

% Here, I work on ODBA and VeDBA values associated to each dive and
% shallow section.
%% results
% ODBA and VeDBA are higher in shallow phases then in dives.
% Each point of graphs produced below corresponds to index mean over the
% entire section's time length. As we can observe, index mean associated to
% dives are lower than the one associated to shallow water navigation.

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
mean_ODBA_surf_h		= zeros(surf_homing_counter, 1);

if isempty(turtle_dive.big_dive.homing(1).pitch) == 0
	mean_pitch_dive_h_disc	= zeros(homing_counter, 1);
	mean_pitch_dive_h_bott	= zeros(homing_counter, 1);
	mean_pitch_dive_h_asc	= zeros(homing_counter, 1);
	
end

var_ODBA_dive_h			= zeros(homing_counter, 1);
var_ODBA_surf_h			= zeros(surf_homing_counter, 1);

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
mean_ODBA_sdive_h_din	= zeros(sh_homing_counter, 1);

var_ODBA_sdive_h		= zeros(sh_homing_counter, 1);
var_ODBA_sdive_h_din	= zeros(sh_homing_counter, 1);

for i = 1:sh_homing_counter
	% mean and variance of ODBA energy index assumed during dive-i
	mean_ODBA_sdive_h(i) = mean(turtle_dive.shallow_dive.homing(i).ODBA_paper);
	var_ODBA_sdive_h(i)	= var(turtle_dive.shallow_dive.homing(i).ODBA_paper);

end
%% sub surface
for i = 1:surf_homing_counter
	mean_ODBA_surf_h(i) = mean(turtle_dive.sub_surface.homing(i).ODBA_paper);
	var_ODBA_surf_h(i)	= var(turtle_dive.sub_surface.homing(i).ODBA_paper);
end


%% save struct ODBA and VeDBA

% struct creation

% means ODBA struct and means VeDBA struct for a turtle (dives and
% surfs still splitted in two separate struct)
turtle_dives_ODBA_h		= struct('mean', mean_ODBA_dive_h, 'var', var_ODBA_dive_h, 'disc', mean_ODBA_dive_h_disc, 'asc', mean_ODBA_dive_h_asc, 'bott', mean_ODBA_dive_h_bott);
turtle_sdives_ODBA_h	= struct('mean', mean_ODBA_sdive_h, 'var', var_ODBA_sdive_h);
turtle_surfs_ODBA_h		= struct('mean', mean_ODBA_surf_h, 'var', var_ODBA_surf_h);

if exist('mean_pitch_dive_h_disc', 'var') && isempty(turtle_dive.big_dive.homing(1).pitch) == 0
	turtle_dives_pitch_h	= struct('mean_disc', mean_pitch_dive_h_disc, 'mean_asc', mean_pitch_dive_h_asc, 'mean_bott', mean_pitch_dive_h_bott);
	% merge together ODBA and VeDBA into a single struct (dives and
	% surfs still splitted in two separate struct)
	turtle_dives_DBA_h		= struct('ODBA',turtle_dives_ODBA_h, 'pitch', turtle_dives_pitch_h);
else
	turtle_dives_DBA_h		= struct('ODBA',turtle_dives_ODBA_h);
end

% merge together ODBA and VeDBA into a single struct (dives and
% surfs still splitted in two separate struct)
turtle_sdives_DBA_h		= struct('ODBA',turtle_sdives_ODBA_h);
turtle_surfs_DBA_h		= struct('ODBA',turtle_surfs_ODBA_h);

turtle_dives_DBA	= struct('homing', turtle_dives_DBA_h);
turtle_sdives_DBA	= struct('homing', turtle_sdives_DBA_h);
turtle_surf_DBA		=	struct('homing', turtle_surfs_DBA_h);
	
	% merge together dive and surf data
turtle_DBA			= struct('big_dive', turtle_dives_DBA, 'shallow_dive', turtle_sdives_DBA, 'sub_surface', turtle_surf_DBA);


new_DBA_dataset = 0;

if exist (turtle_DBA_name_paper, 'file') == 2
	fprintf([turtle_DBA_name_paper ': dive dataset exists!!! \n'])
	load(turtle_DBA_name_paper)
	fprintf([turtle_DBA_name_paper ': dataset loaded \n'])
	ov_to_do = 0;
	
	yn_ans = 0;
	while yn_ans < 1 || yn_ans > 2
		fprintf([turtle_DBA_name_paper ': dataset correctly loaded, do you want to overwrite it? \n'])
		fprintf('1_ yes \n')
		fprintf('2_ no \n')
		yn_ans = input('');
	end
	
	if yn_ans == 1
		ov_to_do = 1;
		fprintf([turtle_DBA_name_paper ': start overwrite \n'])
	elseif yn_ans == 2
		ov_to_do = 0;
		fprintf([turtle_DBA_name_paper ': overwrite operation aborted \n'])
	end
	
else
	fprintf([turtle_DBA_name_paper ': dataset not exists, start making it \n'])
	new_DBA_dataset = 1;
end

% if a new struct has to be created or if an old struct has to be
% overwritten:

if new_DBA_dataset == 1 || ov_to_do == 1
		turtle_DBA_paper = turtle_DBA;
		fprintf([turtle_DBA_name_paper ': saving struct \n'])
		save('turtle_DBA_paper', 'turtle_DBA_paper', '-v7.3');
		fprintf([turtle_DBA_name_paper ': turtle_DBA_paper.mat saved! \n'])
end