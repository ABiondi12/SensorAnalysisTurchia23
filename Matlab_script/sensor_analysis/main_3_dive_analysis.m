% main_3_dive_analysis

% using this script it is possible to save dives from the original dataset
% into a properly created struct, in order to do statistical analysis using
% only data of dives.

% Here is also implemented a rudimental criterion with which try to
% classify dives among U, S and V type (to be refined yet)

%% creation of dive dataset structure
dive_dataset_creation	 

%% dive information selection
turtle_info				 
run_dive_analysis	% also ODBA computation (call of dive_DBA_homing)
					% dive_DBA_homing populates both ODBA and ODBA_paper,
					% which differ for the window over which is computed a
					% mean of the value of the energy index.

%% offshore-inshore and day-night information and statistics
dive_analysis_paper		 

%% short-time Fourier transform execution over dives and plot
dive_turtle_fft_ft_light 
stft_aligned_plot		 

%% ODBA analysis
mean_ODBA_paper