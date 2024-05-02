% main_5_ODBA_statistics_paper
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


%% init and load structure
main_num = 5;

existing_dataset_load

if exist('main_num', 'var') == 0
	main_num = 5;
end

%% evaluate dive division

BW = 1;
% total amount of time lasts in big, shallow and sub surface

[total_amount_day, total_amount_night] = day_night_amount(datetime_acc, sunrise_hour, sunset_hour);

ODBA_statistics_paper
ODBA_statistics_paper_din



