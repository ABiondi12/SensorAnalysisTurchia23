% odba_dataset_load

if exist('turtle_DBA_paper', 'var') == 0
	fprintf('load ODBA paper values \n')
	load_ODBA_paper_data
else
	if strcmp(turtle_DBA_paper.name, turtle_name)
		fprintf('ODBA paper data already present in the workspace \n')
	else
		fprintf('ODBA paper data referred to another turtle are already present in the workspace \n')
		fprintf('overwrite operation: start load ODBA paper data referred to the current turtle... \n')
		load_ODBA_paper_data
		fprintf('overwrite operation: completed \n')
	end
end