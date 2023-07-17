function[start_id, stop_id] = time_id(dataset, Yi, Mi, Di, Hi, MIi, Si, MSi, Yf, Mf, Df, Hf, MIf, Sf, MSf)
% time_id
% This function takes as input a datetime vector and information about the
% starting time and stop time and returns as output the id inside the
% datetime vector corresponding to those two moment.
%
% INPUT:
%	dataset - datetime vector where to look for start and stop time
%	Yi, Mi, Di, Hi, MIi, Si, MSi - year, month, day, hour, minute, second,
%									millisecond of the start time
%	Yf, Mf, Df, Hf, MIf, Sf, MSf - year, month, day, hour, minute, second,
%									millisecond of the stop time
%
% OUTPUT:
%	start_id	- id of the position inside "dataset" of the datetime
%					information passed as input for the start time
%	stop_id		- id of the position inside "dataset" of the datetime
%					information passed as input for the stop time

%% elaboration
	start = datetime(Yi, Mi, Di, Hi, MIi, Si, MSi);
	stop = datetime(Yf, Mf, Df, Hf, MIf, Sf, MSf);

	if (stop-start)<0 % differences between two istants
		tmp = stop;
		stop = start;
		start = tmp;
	end

	start_id = 0;
	stop_id = 0;
	
	for i = 1:length(dataset)
		if dataset(i) == start && start_id == 0
			start_id = i;
		end
		if dataset(i)==stop && stop_id == 0
			stop_id = i;
		end
		if stop_id > 0 && start_id > 0
			break
		end
	end
end