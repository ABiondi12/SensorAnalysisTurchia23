% single_main_2_load

%% check for already existent YPR dataset
new_ypr_dataset = 0;

if exist(turtle_ypr_name, 'file') == 2
	fprintf([turtle_ypr_name,': dataset already exists!!! \n'])
	ov_to_do = 0;
	
	yn_ans = 0;
	while yn_ans < 1 || yn_ans > 2
		fprintf([turtle_ypr_name, ': do you want to load and use the existing dataset? \n'])
		fprintf('1_ yes \n')
		fprintf('2_ no \n')
		yn_ans = input('');
	end
	
	if yn_ans == 1
		ov_to_do = 1;
		fprintf([turtle_ypr_name, ': start loading... \n'])
	elseif yn_ans == 2
		ov_to_do = 0;
		fprintf([turtle_ypr_name, ': load operation aborted, create a new dataset! \n'])
	end
else
	new_ypr_dataset = 1;
end