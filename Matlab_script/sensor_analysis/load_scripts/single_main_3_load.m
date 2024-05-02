% single_main_3_load

%% check for already existent DIVE dataset

new_dive_dataset = 0;
if exist(turtle_dive_name, 'file') == 2 && exist(turtle_dive_name_din, 'file') == 2
	fprintf([turtle_dive_name,' and ', turtle_dive_name_din, ' : datasets already exist!!! \n'])
	ov_to_do = 0;
	
	yn_ans = 0;
	while yn_ans < 1 || yn_ans > 2
		fprintf([turtle_dive_name,' and ', turtle_dive_name_din, ': do you want to load and use the existing datasets? \n'])
		fprintf('1_ yes \n')
		fprintf('2_ no \n')
		yn_ans = input('');
	end
	
	if yn_ans == 1
		ov_to_do = 1;
		fprintf([turtle_dive_name,' and ', turtle_dive_name_din, ': start loading... \n'])
	elseif yn_ans == 2
		ov_to_do = 0;
		fprintf([turtle_dive_name,' and ', turtle_dive_name_din, ': load operation aborted, create a new dataset! \n'])
	end
else
	new_dive_dataset = 1;
end
