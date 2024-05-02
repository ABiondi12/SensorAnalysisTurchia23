% existing_dataset_load

%% load existing dataset
if exist('all_together', 'var') == 0
	
    %% variables definition and turtle selection
	init_load
	
	if main_num > 1
		%% Raw dataset
		raw_dataset_load
		
		if main_num > 2
			%% YPR dataset
			ypr_dataset_load

			if main_num > 3
				%% dives dataset
				dive_dataset_load

				if main_num > 4
					%% ODBA dataset
					odba_dataset_load
					single_main_5_load
				else
					single_main_4_load
				end
			else
				single_main_3_load
			end
		else
			single_main_2_load
		end
	end
end