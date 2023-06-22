function[start_id, stop_id] = time_id(dataset, Yi, Mi, Di, Hi, MIi, Si, MSi, Yf, Mf, Df, Hf, MIf, Sf, MSf)
% type = 'n' significa che passo un dataset dove ho già questa informazione
% scelta a priori

	start = datetime(Yi, Mi, Di, Hi, MIi, Si, MSi);
	stop = datetime(Yf, Mf, Df, Hf, MIf, Sf, MSf);

	if (stop-start)<0 %funzione che fa la differenza di istanti
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