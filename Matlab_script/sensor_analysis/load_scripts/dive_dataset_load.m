% dive_dataset_load

if exist('turtle_dive', 'var') == 0
	fprintf('load single dives values \n')
	load_dive_data
else
	if strcmp(turtle_dive.name, turtle_name)
		fprintf('single dives data already present in the workspace \n')
	else
		fprintf('single dives data referred to another turtle are already present in the workspace \n')
		fprintf('overwrite operation: start load single dives data referred to the current turtle... \n')
		load_dive_data
		fprintf('overwrite operation: completed \n')
	end
end