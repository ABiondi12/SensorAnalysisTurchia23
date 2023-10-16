% clear_all_variables

clear_workspace = 0;
fprintf('Do you want to clean the workspace at the beginning? \n')
fprintf('1. Yes \n')
fprintf('2. No \n')
while clear_workspace < 1 || clear_workspace > 2
	clear_workspace = input('');
end

if clear_workspace == 1
	clear
	close all
	
	step_data_def
	
end