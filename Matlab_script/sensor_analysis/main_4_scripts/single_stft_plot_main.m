% single_stft_plot_main

single_plot = 0;
first = 1;
again = 1;

while again == 1
	
	if first == 1
		
		fprintf("Do you want to see a single stft plot? \n")
		fprintf("1. Yes \n")
		fprintf("2. No \n")
		
		while single_plot < 1 || single_plot > 2
			single_plot = input('');
		end
		
	elseif first == 0
		single_plot = again;
	end
	
	first = 0;
	
	if single_plot == 1
		
		fprintf("Single period plot: starting of the process... \n")
		stft_single_aligned_plot
		fprintf("Single period plot: process completed. \n")
		
		again = 0;
		fprintf("Do you want to see another single stft plot? \n")
		fprintf("1. Yes \n")
		fprintf("2. No \n")
		
		while again < 1 || again > 2
			again = input('');
		end
		
		if again ~= 1
			fprintf("Single period plot: ending of the process... \n")
		end
	else
		again = 0;
		fprintf("Single period plot: ending of the process... \n")
	end
end
fprintf("Single period plot: process ended. \n")