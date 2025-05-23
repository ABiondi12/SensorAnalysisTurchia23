% main_3_dive_analysis
% 
% This script it is demanded to estrapolate and save dives from the 
% original dataset into a properly created struct, in order to perform
% statistical analysis using only data of dives. Dives are classified
% depending on:
%	- maximum depth
%	- shape
%	- offshore-inshore
%	- day-night
%
% Moreover, on every single dataset, it is computed a time-frequency
% analysis so as to highlight the presence of dominant frequencies and
% an energy index (ODBA) is obtain so as to evaluate how many energy is
% required for the turtle in performing that movement.
%
% It is also implemented a rudimental criterion with which try to
% classify dives among U, S and V type (to be refined yet)
%
% By going deeper, the script is organized as follow:
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 1. creation of dive dataset structure
%
%		create the structs used for hosting dives information, one for big
%		dives (max_depth > 5m), one for shallow dives (1m < max_depth <=
%		5m), and one for sub surface dives (max_depth <= 1m). 
%		This is done by calling "dive_dataset_creation" script, thus refers
%		to it for more details.
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 2. dive information selection
%
%		here dives are selected and isolated from the entire dataset and
%		the dive struct is so populated, by dividing dives into the three
%		categories related to the maximum reached depth (big, shallow, and
%		sub-surface dives). For big dives only, there is also the
%		evaluation and assignment of a shape to the dive (among s, v, u,
%		m).
%		Dive struct is then created, for the three dive categories, and 
%		populated for every dive with information about datetime, time of
%		beginning and end, depth profile, acc, mag, gyro, shape of the dive
%		(for big dive only)... The struct is then saved with the name
%		"turtle_dive_***" (*** = name of the turtle).
%		
%		This entire part is demanded to the script "run_dive_analysis",
%		thus refer to it for more details.
%
%		In this script, it is also computed the ODBA energy index for the
%		entire dataset and for each single dive. ODBA computation is
%		performed through a call of the script "dive_DBA_homing", which
%		populates both ODBA and ODBA_paper. These two fields of the dive 
%		struct differ for the window over which is computed a mean of the
%		value of the energy index.
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 3. offshore-inshore and day-night information and statistics
% 
%		Here, there is the evaluation of every dive collocation in time
%		(day-night) and space (offshore-inshore) and the assignment of
%		these flags to every dive in the previously created structure. 
%
%		Then, there are some statistics (min, max, median, mean,
%		quartile...) relative to:
%		- time spent offshore-inshore
%		- time of dive during night-day
%		- time of dive in combination off/inshore and day/night
%		- depth of dive during night/day
%		- depth of dive offshore/inshore
%		- depth of dive for combination day/night and off/inshore
%
%	It is also implemented by keeping into account dive shape (for big dive
%	only).
%
%	All these values are computed inside "dive_analysis_paper" script,
%	thus refer to it for more details.
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 4. ODBA analysis
%
%		Here, there is the evaluation of ODBA and VeDBA values associated 
%		to each dive and shallow section, adapted to the requirement that
%		has been chosen to be used in the paper results.
%
%		Here is also performed division among descent, bottom, and ascent 
%		phases, in order to evaluate if energetic index differs 
%		significantly depending on turtle behavior.
%
% mean ODBA and mean VeDBA
%		Computation for each section of the average value assumed by ODBA 
%		and VeDBA. Then, separate the descent, bottom, and ascent phases
%		for the dives, so as to compare them to each other.
%
% ODBA: mean and variance
%		There will be a single reference value for each dives and each 
%		surface phases (that is for periods between two consecutive dives).
%
%	This is implemented inside the script "mean_ODBA_paper", thus refer to
%	it for more details.
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% init
main_num = 3;

existing_dataset_load

if exist('main_num', 'var') == 0
	main_num = 3;
end

if new_dive_dataset == 1 || ov_to_do == 0

	%% creation of dive dataset structure
	fprintf('turtle dataset creation \n')
	dive_dataset_creation	 

	%% dive information selection	
	fprintf('run dive analysis \n')
	run_dive_analysis	% also ODBA computation (call of dive_DBA_homing)
						% dive_DBA_homing populates both ODBA and ODBA_paper,
						% which differ for the window over which is computed a
						% mean of the value of the energy index.

	%% offshore-inshore and day-night information and statistics
	fprintf('dive analysis paper \n')
	dive_analysis_paper	

	%% save dive struct (ODBA included)
	save_dive_data

else
	load_dive_data
	fprintf('Load operation completed! \n')
end