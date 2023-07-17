
function [dive_ty] =  dive_type_check(depth, surf_dive_th, surf_dive_th_sh)
% dive_type_check
% Function that evaluate the shape of a single dive using a self made
% classification:
%	U - if the bottom phase occupies more than 80% of the total dive time
%	S - if the sum between descent and ascent time lasts for more than 75% 
%		of the total duration of the dive and the descent and ascent times 
%		differ by more than (>) 20% of the total duration of the dive.
%	V - if the sum between descent and ascent time lasts for more than 75% 
%		of the total duration of the dive and the descent and ascent times 
%		differ by less than (<=) 20% of the total duration of the dive.
%	M - if the dive does not fall into any of the above categories.
%
% NOTE: all the percentages can be modified in the function code.
%
% INPUT:
%	depth			- depth profile of the dive (negative values)
%	surf_dive_th	- depth over which a big dive occurs (-5m)
%	surf_dive_th_sh - depth over which a shallow or a big dive occurs (-1m)
%
% OUTPUT:
%	dive_ty			- dive type among "s", "u", "v", and "m"

%% parameters (change if you do not meet the classification)
perc_bottom_u = 80;			% if the bottom phase occupies more than 80% of
% the total dive time then it is a U-shaped dive

perc_disc_asc_v = 75;		% if the sum between descent and ascent time
% lasts for more than 75% of the total duration
% of the dive then we are in S or V dive.
% The difference between ascent and descent
% time discriminates if it is a V or S dive.

perc_disc_asc_equal = 20;	% If the descent and ascent times differ by
% more than 20% of the total duration of the
% dive then they are to be considered
% different.

% If the dive does not fall into any of the above categories,
% it will be labeled as a mixed dive (uncertain in the classification)

%% evaluation
max_depth = min(depth);
if surf_dive_th_sh < 0
	if max_depth > surf_dive_th_sh
		dive_ty = 'n';
	elseif max_depth <= surf_dive_th_sh && max_depth > surf_dive_th
		dive_ty = 'p';
	else
		th_depth = 0.5;
		first_bottom = 0;
		no_bottom_counter_disc = 0;
		no_bottom_counter_asc = 0;
		bottom_counter = 0;
		tot_dive = length(depth);
		
		for i = 1:tot_dive
			if depth(i)- max_depth >= th_depth
				if first_bottom == 0
					no_bottom_counter_disc = no_bottom_counter_disc + 1;
				elseif first_bottom == 1
					no_bottom_counter_asc = no_bottom_counter_asc + 1;
				end
				
			elseif depth(i)- max_depth < th_depth
				if first_bottom == 0
					first_bottom = 1;
				end
				bottom_counter = bottom_counter + 1;
			end
		end
		
		if bottom_counter*100/tot_dive > perc_bottom_u
			dive_ty = 'u';
		elseif no_bottom_counter_asc*100/tot_dive - no_bottom_counter_disc*100/tot_dive < perc_disc_asc_equal && no_bottom_counter_asc*100/tot_dive + no_bottom_counter_disc*100/tot_dive > perc_disc_asc_v
			dive_ty = 'v';
		elseif no_bottom_counter_asc*100/tot_dive - no_bottom_counter_disc*100/tot_dive >= perc_disc_asc_equal
			dive_ty = 's';
		else
			dive_ty = 'm';
		end
	end
else % internesting
	if max_depth > surf_dive_th
		dive_ty = 'n';
		
	else
		th_depth = 0.5;
		first_bottom = 0;
		no_bottom_counter_disc = 0;
		no_bottom_counter_asc = 0;
		bottom_counter = 0;
		tot_dive = length(depth);
		
		for i = 1:tot_dive
			if depth(i)- max_depth >= th_depth
				if first_bottom == 0
					no_bottom_counter_disc = no_bottom_counter_disc + 1;
				elseif first_bottom == 1
					no_bottom_counter_asc = no_bottom_counter_asc + 1;
				end
				
			elseif depth(i)- max_depth < th_depth
				if first_bottom == 0
					first_bottom = 1;
				end
				bottom_counter = bottom_counter + 1;
			end
		end
		
		if bottom_counter*100/tot_dive > perc_bottom_u
			dive_ty = 'u';
		elseif no_bottom_counter_asc*100/tot_dive - no_bottom_counter_disc*100/tot_dive < perc_disc_asc_equal && no_bottom_counter_asc*100/tot_dive + no_bottom_counter_disc*100/tot_dive > perc_disc_asc_v
			dive_ty = 'v';
		elseif no_bottom_counter_asc*100/tot_dive - no_bottom_counter_disc*100/tot_dive >= perc_disc_asc_equal
			dive_ty = 's';
		else
			dive_ty = 'm';
		end
	end
end
	% m stands for mixed dive
	% n stands for surface (no dive or shallow dive)