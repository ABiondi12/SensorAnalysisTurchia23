% load_ODBA_paper_data
%
% This script load ODBA paper data allocated in a specified .mat file

if exist(turtle_DBA_name_paper) == 2
	load(turtle_DBA_name_paper);
else
	errorStruct.message = 'Data file not found.';
	errorStruct.identifier = 'MyFunction:fileNotFound';

	error(errorStruct)
end