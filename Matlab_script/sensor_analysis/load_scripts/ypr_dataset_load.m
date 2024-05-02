% ypr_dataset_load

if exist('ypr_data_struct', 'var') == 0
	fprintf('load ypr values \n')
	load_ypr_data
else
	if strcmp(ypr_data_struct.name, turtle_name)
		fprintf('ypr data already present in the workspace \n')
	else
		fprintf('ypr data referred to another turtle are already present in the workspace \n')
		fprintf('overwrite operation: start load ypr data referred to the current turtle... \n')
		load_ypr_data
		fprintf('overwrite operation: completed \n')				
	end
end