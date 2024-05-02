% main_4_stft
% It is possible to obtain the stft analysis of all the big dives together or of a single dive (big,
% shallow or sub-surface) of a selected turtle.
%
% 1. stft of the dataset and of all the dives, separately
%
%		Here, for the entire dataset and then for every dive, separately,
%		it is evaluated and plotted a time-frequency analysis, performed  
%		using a short-time Fourier transform over the acceleration data.
%		This evaluation is performed to highlight dominant frequencies over 
%		the acceleration of the turtle that can be eventually associated to 
%		its flippers beat.
%		Plot are shown w.r.t. depth profile in order to study the variation 
%		and presence/absence of a dominant frequency depending on the 
%		turtle behaviour.
%
%	These operations are implemented into the scripts:
%	"dive_turtle_fft_ft_light" and "stft_aligned_plot", thus refer to them
%	for more details.
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 2. single stft plot
%
%		Here, for a single big dive, shallow dive and sub surface period,
%		it is possible to evaluate and plot a time-frequency analysis,   
%		performed using a short-time Fourier transform over the acc data.
%		This evaluation is performed to highlight dominant frequencies over 
%		the acceleration of the turtle that can be eventually associated to 
%		its flippers beat.
%		Plot are shown w.r.t. depth profile in order to study the variation 
%		and presence/absence of a dominant frequency depending on the 
%		turtle behaviour.
%
%	The period has to be chosen at the beginning of the running session.
%% init
main_num = 4;

existing_dataset_load

if exist('main_num', 'var') == 0
	main_num = 4;
end

%% short-time Fourier transform execution over dives and plot

if new_fft_dataset == 1 || ov_to_do == 0

	comp_stft = 0;
	fprintf("Do you want to execute stft for all big, shallow and sub-surface dives? \n")
	fprintf("1. Yes \n")
	fprintf("2. no \n")

	while comp_stft < 1 || comp_stft > 2
		comp_stft = input('');
	end

	if comp_stft == 1
		
		dive_turtle_fft_ft_light		 

		%% short-time Fourier transform plot over big dives
		show_stft = 0;
		fprintf("Do you want to see stft plots for big dives only? \n")
		fprintf("1. Yes \n")
		fprintf("2. no \n")

		while show_stft < 1 || show_stft > 2
			show_stft = input('');
		end

		if show_stft == 1
			stft_aligned_plot		 
		end
	end

else
	load_stft_data
	fprintf('Load operation completed! \n')
end

%% ODBA analysis

if new_odba_dataset == 1 || ov_to_do_odba == 0
	mean_ODBA_paper
else
	load_ODBA_paper_data
	fprintf('Load operation completed! \n')
end

%% single stft plot

single_stft_plot_main
